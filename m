Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C04C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:09:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD7B7207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PkaUVeRs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7B7207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iomjn-0003xy-PA
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 06:09:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iolkI-0005cf-Tq
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:05:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iolkH-0003dQ-FJ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:05:54 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40505
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iolkH-0003dC-B2
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:05:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578391552;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=csSjxJAcVDYv6IToAX9oHQf06tSljbIHMNDOTYaaw0k=;
 b=PkaUVeRsbyUY2wvJgonp3b0EASt7HrY9KVN6jMFNNp6OM8jMBLPt52N9Kh7FoCs3NsWRUj
 zl4mpG8ap4o1SuVFe1gf+LP7qFPlI2UADQl25vsgMVIKUrF9BGMCjGrG59uZwI+i7sSyUJ
 4hUakKm6hd5FhhN5hdIQsFrtzxsEoE8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-0rR38oZhNzmnApzrDOnTog-1; Tue, 07 Jan 2020 05:05:51 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6167180746B
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 10:05:50 +0000 (UTC)
Received: from redhat.com (ovpn-112-61.ams2.redhat.com [10.36.112.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A71A1036D1B;
 Tue,  7 Jan 2020 10:05:46 +0000 (UTC)
Date: Tue, 7 Jan 2020 10:05:43 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 056/104] virtiofsd: add security guide document
Message-ID: <20200107100543.GC3368802@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-57-dgilbert@redhat.com>
 <20200106150351.GT2930416@redhat.com>
 <20200106175355.GL2798@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200106175355.GL2798@work-vm>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 0rR38oZhNzmnApzrDOnTog-1
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 06, 2020 at 05:53:55PM +0000, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
> > On Thu, Dec 12, 2019 at 04:38:16PM +0000, Dr. David Alan Gilbert (git) =
wrote:
> > > From: Stefan Hajnoczi <stefanha@redhat.com>
> > >=20
> > > Many people want to know: what's up with virtiofsd and security?  Thi=
s
> > > document provides the answers!
> > >=20
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > >  tools/virtiofsd/security.rst | 118 +++++++++++++++++++++++++++++++++=
++
> >=20
> > Do we need to link this into the rest of QEMU's docs in some
> > index page ?
>=20
> I wonder how;  there's a autogenerated thing in
>   docs/index.rst
>=20
> that includes some of the docs directories subdirectories/index
> Does that mean we should have this in docs/tools/virtiofsd/security.rst
> and a docs/tools/index  and a docs/tools/virtiofsd/index  ?

I was wondering if this fits into any of the current three sections
"devel" or "interop" or "specs", but it doesn't feel quite right in
any of them to me. So having a new docs/tools subtree looks like an
ok idea in absence of better suggestions.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


