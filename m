Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DABC10F14
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 15:52:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7364B20693
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 15:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbEWcKZf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7364B20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39029 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEyTO-0004gK-KZ
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 11:52:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hEyIn-0003ou-Kc
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:41:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hEyIm-0003MI-HJ
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:41:17 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hEyIm-0003M4-8f; Fri, 12 Apr 2019 11:41:16 -0400
Received: by mail-wr1-x441.google.com with SMTP id k17so7872285wrx.10;
	Fri, 12 Apr 2019 08:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=Xl4hP0iyH6w/MGh0/Ar8italcnchSSvgPrZKCRA9YmM=;
	b=ZbEWcKZfFzXgE7y0a5ZxX/AhsLqa1mwqExqmi+pIogcmw0MFMBaInSWJyL15H9E+DY
	tLwiOIzBOzB/HRxyUs76xKVDmHIZwBlG8fRWQ2ogP4ojoSIUyjWiC6p38R/h8MqDaf9Z
	WzmvIgc9qmTrfStM1jhFyFH4V0ndIOw5vj1x4ntwPo9hBQrNvB8Zhgi+B9ydroNAtlxQ
	6cuQqcXQH891BFwuNiOE6xiKINssErlgiuivel5I0kMfTwatSVpQySw9jxGaMewhkNoQ
	4A6voIa8bV0Wy3dTLF6UqGYiNLgIWaISRFcIfgM7T/2C2acTrhz9z+CcA/vlzmNumX8V
	pxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=Xl4hP0iyH6w/MGh0/Ar8italcnchSSvgPrZKCRA9YmM=;
	b=QmqU29CTa+3f/r+fPSaGEgcLvLTb2gPiQPWQizZ/As7RQ5SBGE/D+ybFhVJR/EcRkB
	onjkGElGrFMthnU197TYAAAwGwkci5SThOG1nH6EoiAkPLLquU+dr41sLpBw4BMZ2SQL
	3rBB1mIUN/J7oQUiUJ+I1FT5ib8SnaVHQGocRV2mJYU8NSbDuyv67q8krhu1gZ9/0x4L
	ApHslaqv81eZPhjIyE78vFU2ZkYDoVump/FUp09ctw9gO35VVV2XEiQGV+RMiZcX2RqV
	18xogpIq3ceKopm0mdNj+5RqJm2uVX/uvzqZSt5esjwkhSqX6cWZy+DC/xlhK/ORmI64
	O4AQ==
X-Gm-Message-State: APjAAAXn3/jWhAta9lSoJT3n7op0zo1G4UG4mPFrlFt0DAvAoWw3avWw
	O98CvONn3vkr2OawC1PIVyGz0SiRvXtWaHNfSWG8HyLU
X-Google-Smtp-Source: APXvYqxQVO4tfJ4v2fguNB/uSVpdZ+KcxXU4TGadj8ySwzscNj6pbCx+/xwXH5yjrHRFIi6u51KyF5O7EfntXUpZic8=
X-Received: by 2002:adf:cc85:: with SMTP id p5mr33199289wrj.101.1555083674889; 
	Fri, 12 Apr 2019 08:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190412153647.19027-1-marcandre.lureau@redhat.com>
In-Reply-To: <20190412153647.19027-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 12 Apr 2019 17:41:03 +0200
Message-ID:
 <CAJ+F1CKDLkpWAA4W1auMdvQ1Pm0FdRT+UvTCfyn0VoRKk+W6Jg@mail.gmail.com>
To: QEMU <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v5 00/13] vhost-user for input & GPU
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	"open list:sPAPR pseries" <qemu-ppc@nongnu.org>,
	Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412154103.adZ-eHU3ccrMJ7lKjxptNQh-0ZK0tpRRbtbsY51ghEk@z>

Hi

On Fri, Apr 12, 2019 at 5:38 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi,
>
> vhost-user allows to drive a virtio device in a seperate
> process. After vhost-user-net, we have seen
> vhost-user-{scsi,blk,crypto} added more recently.
>
> This series, initially proposed ~3 years ago, time flies
> (https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg01905.html)
> contributes with vhost-user-input and vhost-user-gpu.
>
> You may start a vhost-user-gpu with virgl rendering in a separate
> process like this:
>
> $ ./vhost-user-gpu --virgl -s vgpu.sock &
> $ qemu...
>   -chardev socket,id=3Dchr,path=3Dvgpu.sock
>   -device vhost-user-vga,chardev=3Dchr
>
> v5:
>  - remove user-creatable version of vhost-user-backend
>  - remove optinal management of sub-process in vhost-user-backend
>  - removed daemonize/pid code
>  - drop introduction of new input & gpu messages for PCI config space
>    handling, instead use VHOST_USER_PROTOCOL_F_CONFIG
>  - plain mem & udmabuf fallback for 2d rendering
>  - rebased, kconfig-ify, rst-ify
>
> Gerd Hoffmann (1):
>   curses: fix wchar_t printf warning
>
> Greg Kurz (1):
>   spapr_pci: Fix broken naming of PCI bus
>
> Marc-Andr=C3=A9 Lureau (10):
>   Add vhost-user-backend
>   Add vhost-user-input-pci
>   libvhost-user: add PROTOCOL_F_CONFIG if {set,get}_config
>   contrib: add vhost-user-input
>   vhost-user: add vhost_user_gpu_set_socket()
>   virtio: add virtio-gpu bswap helpers header
>   contrib: add vhost-user-gpu
>   virtio-gpu: split virtio-gpu, introduce virtio-gpu-base
>   virtio-gpu: split virtio-gpu-pci & virtio-vga
>   hw/display: add vhost-user-vga & gpu-pci
>
> Peter Maydell (1):
>   Update version for v4.0.0-rc3 release
>

oops, some bonus patches :) my bad, please ignore



--=20
Marc-Andr=C3=A9 Lureau

