Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28AAC4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 09:49:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A233D2072D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 09:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AyBQDZLF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A233D2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGJiA-0001UD-QF
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 05:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jGJhU-000146-9l
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 05:48:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jGJhT-0001Sz-3W
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 05:48:52 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:49257)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jGJhT-0001Si-0C
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 05:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584956930;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fQMxHatu8kGUzKGzlr6CVJQxnTVx7sMvEA2CAhngcrg=;
 b=AyBQDZLFHPqgzm26VqDh8QxZphi2jUT0abcxzI6Jbb5P0R5/QedO5l46eOSz1cAXEAYm2f
 hERodHpef91sy6V1FovLSCyiwDSIrgz6IYxvrgVmP7EjyWhVQTQJqNnaIMpZrtAztGuksA
 cURsVLy+GutvX9vvVEqo4s4VCKuGMKg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-sW2s8WnUPtiLVpB9SoiNKA-1; Mon, 23 Mar 2020 05:48:35 -0400
X-MC-Unique: sW2s8WnUPtiLVpB9SoiNKA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD0561851C3B;
 Mon, 23 Mar 2020 09:48:33 +0000 (UTC)
Received: from redhat.com (ovpn-112-208.ams2.redhat.com [10.36.112.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 87E4D5C1B2;
 Mon, 23 Mar 2020 09:48:21 +0000 (UTC)
Date: Mon, 23 Mar 2020 09:48:18 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH-for-5.0 v2 2/4] tests/test-util-sockets: Skip test on
 non-x86 Travis containers
Message-ID: <20200323094818.GA3379720@redhat.com>
References: <20200318222717.24676-1-philmd@redhat.com>
 <20200318222717.24676-3-philmd@redhat.com>
 <20200320123958.354e6cbb.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200320123958.354e6cbb.cohuck@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 20, 2020 at 12:39:58PM +0100, Cornelia Huck wrote:
> On Wed, 18 Mar 2020 23:27:15 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>=20
> > Similarly to commit 4f370b1098, test-util-sockets fails in
> > restricted non-x86 Travis containers since they apparently
> > blacklisted some required system calls there.
>=20
> Is "they" =3D=3D "Travis admins"? Can we get them to remove those calls
> from the blacklist?
>=20
> (I'm wondering why x86 allows those calls. Probably just because it has
> been around for longer.)

I believe it is due to the different build env architecture for
the non-x86 arches, which is based on a strict locked down container,
compared to x86 which IIUC was a full VM.

Blacklisting like this is a bit hacky, but a prudent fix in the short
term.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


