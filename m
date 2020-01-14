Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92963C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 18:00:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66D5524656
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 18:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fnDofzQm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D5524656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irQUQ-0001oT-GM
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 13:00:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1irQTX-0001IY-GB
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 12:59:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1irQTU-0004qC-RH
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 12:59:34 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31746
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1irQTU-0004p7-Nj
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 12:59:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579024772;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xIzipvWTiZQtAqlHTgmnnJqAn40QZeZxkEn/xqp8DL4=;
 b=fnDofzQmUF8T8yrY2T8CqjzGINV/584HIBLRnI1Xf3GOnt1gwrdU97sZBaOC5LSsZnuM5N
 XMtB9++11mYtxnjG48oDOemwWIcTSPyUFfnOvFZ9Sk+TugYE7W8A/fhjPPtuethXS1CWND
 M/J9Une+sxZx9nJLOltLumN6z4blcrg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378--v2f0XeuNFi5JOSG5hs-RA-1; Tue, 14 Jan 2020 12:59:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABE9EDBCC;
 Tue, 14 Jan 2020 17:59:27 +0000 (UTC)
Received: from redhat.com (ovpn-112-42.ams2.redhat.com [10.36.112.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D12FD60C81;
 Tue, 14 Jan 2020 17:59:10 +0000 (UTC)
Date: Tue, 14 Jan 2020 17:59:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: Priority of -accel
Message-ID: <20200114175906.GS4071034@redhat.com>
References: <20200106130951.29873-1-philmd@redhat.com>
 <c493e693-13a7-7dc4-eb2d-5dbc7b3053f1@redhat.com>
 <12334054-4ae7-e580-9727-2d322bfa2bda@redhat.com>
 <1A5859EA-4403-4921-B527-DFD07C59C702@redhat.com>
 <360fa010-ba80-b02b-3a35-19c2b48a462d@redhat.com>
 <87d0bnwct1.fsf@dusky.pond.sub.org>
 <ff78d961-9432-c84d-4bba-6df14b1a5a79@redhat.com>
 <597F9FF3-382F-4580-85F9-7C755E1B7CCE@redhat.com>
MIME-Version: 1.0
In-Reply-To: <597F9FF3-382F-4580-85F9-7C755E1B7CCE@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: -v2f0XeuNFi5JOSG5hs-RA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 14, 2020 at 06:49:45PM +0100, Christophe de Dinechin wrote:
>=20
>=20
> > On 13 Jan 2020, at 17:25, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >=20
> > On 13/01/20 17:17, Markus Armbruster wrote:
> >> Perfect opportunity to change the default to something more useful.
> >=20
> > I am not sure acutally if it's that more useful, now that we have
> > sanctioned qemu-kvm as the fast alternative.
>=20
> OK, half a joke, but we should have tested on =E2=80=9Cq=E2=80=9D at the =
beginning
> rather than =E2=80=9C-kvm=E2=80=9D at the end ;-)
>=20
> emu being the slow one ;-)

IIRC, Debian had (still has ?) it called /usr/bin/kvm

The qemu-kvm naming came from RHEL / Fedora land originally,
when the project was literally forked as a "qemu-kvm" git repo.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


