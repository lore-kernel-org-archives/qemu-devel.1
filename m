Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BA4C11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 15:29:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 715C920714
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 15:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AdSU4ssL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715C920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6FfS-0006Lv-KC
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 10:29:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j6Fen-0005si-PU
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 10:28:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j6Fem-0001ip-Df
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 10:28:29 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47593
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j6Fem-0001iJ-9l
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 10:28:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582558107;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=APoaJ7j1BYzsCA3ibKp+8/nkAt0JXWAIBRYbG5lFGeY=;
 b=AdSU4ssLiRq5Jv0cosNjN2riU6bKFPDJOXzWu2gGpJ5lzAA6INhBaO6pQot+FBWXTqnTWw
 0v/8Jmku2o3o/JtkwnKWJtEAAJuaHfSseA6wmq0Ary2RRpg41zMP3pt6l4G5xnKk3wjbLs
 vxpi2/Hecw2Km3Cf4QKTNJbRkk+fm/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-_Y0wPHMpPm2blQCQyCjNwA-1; Mon, 24 Feb 2020 10:28:15 -0500
X-MC-Unique: _Y0wPHMpPm2blQCQyCjNwA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 691621005510;
 Mon, 24 Feb 2020 15:28:14 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C19C19C7F;
 Mon, 24 Feb 2020 15:28:13 +0000 (UTC)
Date: Mon, 24 Feb 2020 15:28:10 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: A problem with live migration of UEFI virtual machines
Message-ID: <20200224152810.GX635661@redhat.com>
References: <tencent_BC7FD00363690990994E90F8@qq.com>
 <87sgjhxbtc.fsf@zen.linaroharston>
MIME-Version: 1.0
In-Reply-To: <87sgjhxbtc.fsf@zen.linaroharston>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: discuss <discuss@edk2.groups.io>,
 "devel@edk2.groups.io" <devel@edk2.groups.io>, qemu-devel@nongnu.org,
 zhoujianjay <zhoujianjay@gmail.com>, wuchenye1995 <wuchenye1995@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 11, 2020 at 05:39:59PM +0000, Alex Benn=C3=A9e wrote:
>=20
> wuchenye1995 <wuchenye1995@gmail.com> writes:
>=20
> > Hi all,
> >    We found a problem with live migration of UEFI virtual machines due =
to size of OVMF.fd changes.
> >    Specifically, the size of OVMF.fd in edk with low version such as ed=
k-2.0-25 is 2MB while the size of it in higher version such as edk-2.0-30 i=
s 4MB.
> >    When we migrate a UEFI virtual machine from the host with low versio=
n of edk2 to the host with higher one, qemu component will report an error =
in function qemu_ram_resize while
> > checking size of ovmf_pcbios: Length mismatch: pc.bios: 0x200000 in !=
=3D 0x400000: Invalid argument.
> >    We want to know how to solve this problem after updating the
> >    version of edk2.
>=20
> You can only migrate a machine that is identical - so instantiating a
> empty machine with a different EDK image is bound to cause a problem
> because the machines don't match.

I don't believe we are that strict for firmware in general. The firmware
is loaded when QEMU starts, but that only matters for the original
source host QEMU. During migration, the memory content of the original
firmware will be copied during live migration, overwriting whatever the
target QEMU loaded off disk. This works....provided the memory region
is the same size on source & target host, which is where the problem
arises in this case.

If there's a risk that newer firmware will be larger than old firmware
there's only really two options:

  - Keep all firmware images forever, each with a unique versioned
    filename. This ensures target QEMU will always load the original
    smaller firmware

  - Add padding to the firmware images. IOW, if the firmware is 2 MB,
    add zero-padding to the end of the image to round it upto 4 MB
    (whatever you anticipate the largest size wil be in future).

Distros have often taken the latter approach for QEMU firmware in the
past. The main issue is that you have to plan ahead of time and get
this padding right from the very start. You can't add the padding after
the fact on an existing VM.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


