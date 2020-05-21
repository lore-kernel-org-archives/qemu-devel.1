Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409F3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 13:45:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 103802072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 13:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsV+W3XO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 103802072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jblVz-0007Uy-3x
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 09:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jblV9-0006aF-Np
 for qemu-devel@nongnu.org; Thu, 21 May 2020 09:44:47 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33669)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jblV6-0007rg-O8
 for qemu-devel@nongnu.org; Thu, 21 May 2020 09:44:47 -0400
Received: by mail-wr1-x444.google.com with SMTP id l11so6756390wru.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 06:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=lTq7Rittvs5CSJ9BqKsSP/J4mW8dKIerh6Dp/vdtZbM=;
 b=VsV+W3XO2FXDuCp21QY3m6pCmP1OmY/soWo5L3TiqfQ+mLPyFJ8OM2EeDRBsC/145y
 ZfSjN7lJcjdpucqjStVDYzOUoSr4xlzdO3L6Js943x+3OGfJ5O42ESu9A7/BTxxCeWqX
 i4O/I2aq2bEoevjgipbZgW24wRpnzbJxlR17IdudqQUsVCPYFbLANih6JPBAyJ39YiuC
 rYCfhiva2nc+MKigEweP4IZ5X28oBArSDuZ2cwj0N7nXqxNvqXJ36fEbLRBrBo1hVwOL
 DvY/kbzfRHfZKmwiYLuMf67zl9mU14AwaR/V3yZo2sUxEF16W6wzGUfIblC6dlZcRLvX
 kq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lTq7Rittvs5CSJ9BqKsSP/J4mW8dKIerh6Dp/vdtZbM=;
 b=OibEYO6knur4QTwHi6eb1LUa7pFoicf3QMIBME+TGZLaULwGY8aVwKt395MF3HeJHs
 H/LQ4TgIG0i+SdJWcIwHiy4gBn0gMAoiTV2DeIZVuLW1dfh3ZEUDwgkTyahPok0HOr7u
 ZG05jyAqtnDcT7kJ8/citkDoVgg8SEWuZ7giSQBecXfG2jd+o/M5AoNhRbBchLkIoUiY
 D+We5Q7a0gQmkFpGhnko9GgRuRkxIxJy6Dnf/7voL7bePhH9LmzBi+AoFauFBXHXhNtj
 PwKeZt/9W5jbStTsD1fibiNGVRkvTf8e0eJLKLQECnN7CMvJF4+En4X7aWyhdl3fmT2S
 +qRw==
X-Gm-Message-State: AOAM531KWCNRG1M6Au8Ka1fzyKDI7KJ56fXvaAGuheGAZ2tVupAtZqnN
 FJVuRlxjariiFxmZYw6YaNs=
X-Google-Smtp-Source: ABdhPJwuueqRf1I/8NRzHlwUJ0YY2XkPVYe2vbBtu0RxcvTOpQ1RrHtbSua1I5NRTb6sraLq49+Cvg==
X-Received: by 2002:a5d:684a:: with SMTP id o10mr8302745wrw.311.1590068683253; 
 Thu, 21 May 2020 06:44:43 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id p7sm6452232wmc.24.2020.05.21.06.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 06:44:42 -0700 (PDT)
Date: Thu, 21 May 2020 14:44:40 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Alexander Bulekov <alxndr@bu.edu>
Subject: Re: Assertion failure through virtio_blk_req_complete
Message-ID: <20200521134440.GJ251811@stefanha-x1.localdomain>
References: <20200511040622.xus3eqvsxbjkfum2@mozz.bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AXxEqdD4tcVTjWte"
Content-Disposition: inline
In-Reply-To: <20200511040622.xus3eqvsxbjkfum2@mozz.bu.edu>
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: kwolf@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--AXxEqdD4tcVTjWte
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2020 at 12:06:22AM -0400, Alexander Bulekov wrote:
> Hello,
> While fuzzing, I found an input that triggers an assertion through
> virtio-blk.c:
>=20
> void address_space_unmap(AddressSpace *, void *, hwaddr, int, hwaddr): As=
sertion `mr !=3D NULL' failed
>=20
> #8 0x7fa947707091 in __assert_fail /build/glibc-GwnBeO/glibc-2.30/assert/=
assert.c:101:3
> #9 0x55ec68a73a97 in address_space_unmap exec.c:3619:9
> #10 0x55ec6943ffab in dma_memory_unmap include/sysemu/dma.h:145:5
> #11 0x55ec693e2df6 in virtqueue_unmap_sg hw/virtio/virtio.c:640:9
> #12 0x55ec693e435b in virtqueue_fill hw/virtio/virtio.c:789:5
> #13 0x55ec693e8cf0 in virtqueue_push hw/virtio/virtio.c:863:5
> #14 0x55ec68ff73ce in virtio_blk_req_complete hw/block/virtio-blk.c:83:5
> #15 0x55ec68ff037e in virtio_blk_handle_request hw/block/virtio-blk.c:671=
:13
> #16 0x55ec68fec4c0 in virtio_blk_handle_vq hw/block/virtio-blk.c:780:17
> #17 0x55ec6901ae79 in virtio_blk_handle_output_do hw/block/virtio-blk.c:8=
03:5
> #18 0x55ec6901a336 in virtio_blk_handle_output hw/block/virtio-blk.c:819:5
> #19 0x55ec694168f0 in virtio_queue_notify hw/virtio/virtio.c:2284:9
> #20 0x55ec6b55abc5 in virtio_mmio_write hw/virtio/virtio-mmio.c:369:13
> #21 0x55ec68d9e17b in memory_region_write_accessor memory.c:496:5
>=20
> I can reproduce it in a qemu 5.0 build using:
> cat << EOF | qemu-system-i386 -M pc-q35-5.0 -M microvm,x-option-roms=3Dof=
f,pit=3Doff,pic=3Doff,isa-serial=3Doff,rtc=3Doff -nographic -device virtio-=
blk-device,drive=3Dmydrive,scsi=3Dtrue -drive file=3Dnull-co://,id=3Dmydriv=
e,if=3Dnone,format=3Draw -nographic -monitor none -display none -serial non=
e -qtest stdio
> write 0x1ba000b 0x12 0x01820040bf07f0ffffffffffff3328000101
> write 0x1ba1003 0x2 0x0101
> write 0xc0000e28 0x2c 0x000046dd000000000049dd00000000004cdd00000000004fd=
d000000000052dd000000000055dd0000000000
> EOF
>=20
> I also uploaded the above trace, in case the formatting is broken:
>=20
> curl https://paste.debian.net/plain/1146092 | qemu-system-i386 -M pc-q35-=
5.0 -M microvm,x-option-roms=3Doff,pit=3Doff,pic=3Doff,isa-serial=3Doff,rtc=
=3Doff -nographic -device virtio-blk-device,drive=3Dmydrive,scsi=3Dtrue -dr=
ive file=3Dnull-co://,id=3Dmydrive,if=3Dnone,format=3Draw -nographic -monit=
or none -display none -serial none -qtest stdio

Thanks! I've found the root cause for this. Will send a patch.

Stefan

--AXxEqdD4tcVTjWte
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7GhcgACgkQnKSrs4Gr
c8gu1QgAif264/a972XHpIJu6OD5dOvTHsVQhI+anyYOSkTp1oZ3MtkGdi62A90Q
rtuFUYV3/7yt0/K0uhjBw3C87WK/oyK8Ne1eOlZ4xQuvfXgIxXg9f0dPFwQiBKfj
qs8gg75+EU6msxyshBZMOpp876s3T7y/kOgcPdXh96jQOGGijpxbIGuW2JSehIWD
cMZGPS8qWmjc442/Hqgqt7J0dXXm51hHhGFbv7ri2SDhm4jujDdPvrCNA813iphY
AaS2yD3JbmKnJ9fTC7Hy2RxLona1hvXvD0f7lOG8l0Qvmm5NadeVhQSSNZiZHN87
JyPElZMoffcFw4XNYrDQtzdHOPp6cw==
=lGfP
-----END PGP SIGNATURE-----

--AXxEqdD4tcVTjWte--

