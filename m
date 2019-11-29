Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D36C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:47:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51C0F215F1
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fuKph44C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C0F215F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iacrw-0001Hi-EB
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 04:47:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55199)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iacfS-000147-9A
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:34:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iacfN-0006h2-Jo
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:34:22 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20117
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iacfN-0006Ma-68
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:34:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575020056;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RrFcwju3Yymoi3vvIyukp363JjxfJ8/8a4R1dkta3jc=;
 b=fuKph44C5Dip1ESxckB5sNAHtzFq8fqTAfUdXEapsh1G1BhTWyV7/N129vs6LyWNFg3qoc
 SXivIWjYf0DrpPky++67QUppmtS1t0tqU6fW7XVqvTin9HMJMKgv7XRY4LfQb2dooLpdOl
 a/tgMFA1a7Qv9/ZvI3UupIdJYIsZLcM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-KRFQxWLENYq7dcXlcdh4uw-1; Fri, 29 Nov 2019 04:34:14 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8CED100E368
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 09:34:13 +0000 (UTC)
Received: from redhat.com (ovpn-112-31.ams2.redhat.com [10.36.112.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 27AE55C545;
 Fri, 29 Nov 2019 09:34:11 +0000 (UTC)
Date: Fri, 29 Nov 2019 09:34:09 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: libcap vs libcap-ng mess
Message-ID: <20191129093409.GB2260471@redhat.com>
References: <20191128190408.GC3294@work-vm>
MIME-Version: 1.0
In-Reply-To: <20191128190408.GC3294@work-vm>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: KRFQxWLENYq7dcXlcdh4uw-1
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
Cc: pbonzini@redhat.com, thuth@redhat.com, qemu-devel@nongnu.org,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 28, 2019 at 07:04:08PM +0000, Dr. David Alan Gilbert wrote:
> Hi,
>   We seem to have a bit of a mess with libcap and libcap-ng; and I'm not
> sure if we should try and untangle it.
>=20
> a) Our configure script has tests for both libcap and libcap-ng
>   for libcap it says $cap, for libcap-ng it says $cap_ng (ok)
>   If $cap is set - nothing happens?
>   If $cap_ng is set - we define CONFIG_LIBCAP  (!)

Wow, confusing to the max.

> b) We use both
>   1) pr-helper and bridge-helper use CONFIG_LIBCAP and use cap-ng
>   2) 9p's virtfs-proxy-helper uses libcap - it's got a check in
>      configure to make sure you have libcap if you've asked for 9p
>=20
> c) Our gitlab-ci.yml installs libcap-dev to get the 9p stuff tested
>   but never installes libcap-ng-dev

Opps.

>=20
> I hit this because we're using libcap in virtiofsd at the moment.
>=20
> So hmm how to fix?
> I'm tempted to:
>   x) Replace CONFIG_LIBCAP by CONFIG_LIBCAPNG to make it clear

Definitely

>   y) Should we flip over to only using one or the other - what
>      are the advantages?

In libvirt we use libcap-ng. We picked this originally as its API
design allows you do write simpler code than libcap in some cases
You can see some docs & examples here:

  https://people.redhat.com/sgrubb/libcap-ng/

So I vote for changing the 9p code to use libcap-ng.

>   z) We should probably add the other one to the ci.

Yep.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


