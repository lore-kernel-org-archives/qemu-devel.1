Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3403FC282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 16:57:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 007042072A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 16:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mkcj1OjL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007042072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipEe1-0003P3-Uz
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 11:57:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1ipEcz-00029s-3B
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 11:56:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1ipEcy-0007IW-3u
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 11:56:17 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:42043)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ipEcx-0007Gt-Pj
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 11:56:16 -0500
Received: by mail-wr1-x432.google.com with SMTP id q6so4124473wro.9
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 08:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=cIilAHRcWbUNrv7shYYEtdfy8TJk31Q0fusbS7+lnT8=;
 b=Mkcj1OjL8vlW7hECbTuCDpuK2MbXRnNFpK4GwS5+bn/HRfywVTQQGLe524L1RICsSu
 uU2iw2a/7bzi/wj6p12SReEK1TZN1ejraHKjr/SACs5vDriVbze5ZirPBOpKqSWqePdF
 mUaYXJDq9jl+aeShOaXfBYQ6OBkqdkGffM2cDI+PkFhZe2SB9T43PlsrDfa5yc2qgfKT
 Hat5HjPRXtgpNHCtJ56/OTHV7h6t/dh/pyoxzeQ38yh+5aNcUSbcE29VnSTFEoqk/YJp
 MJAOR9w/PyyNelkNxSEYs+HgD5pMAVIO3Z/090wk52hfBbuWf4k0iB1wN+Rr6AL8MJmO
 +ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cIilAHRcWbUNrv7shYYEtdfy8TJk31Q0fusbS7+lnT8=;
 b=sJE6DHHJl0y6QDPUfLR6SV5SsqBRQ3Qs9l7MrXDWJTthTgoK2QgaAKokqqIQrBV4CX
 uTqu/ttMS2lwv+96cZ4wVgIQgnmWS85OFtI/FsdjRMdwpGLuSOKfPUo0bQdxp7r7WjL4
 4dBw8pLB9qIdrjyMjCkobN/3gHUD7Z5GMwv7SEeq0hv6kNOg1N3FGtgbDIX45RgiWPvv
 1d42Ay+AD10mKwRpJlaEkYlXwR2FoH02u70eHJxmzBqokPEoexn++kHOO1C9Y/bG8+oZ
 nFoiz/DRjvd3+WUfIG7CxqIM2jt6IaTosjv4ryZabUYwQA+4iGni7N21zV9wDBTgOD80
 oslQ==
X-Gm-Message-State: APjAAAX+RFTmZmo665q0m8Mdn/sK2sE/IIzxgkJ1OGaPv9rkSrZYG25y
 02RkHdG4lEYz/vG2LO6gBuw=
X-Google-Smtp-Source: APXvYqyhC4JcEpQQaGeGyyiPBdCLV2lK3RgP7FYx6OxWkQN/uP6GGwhp/oyLB68D5rr1aW0wb3boQQ==
X-Received: by 2002:adf:fa0b:: with SMTP id m11mr5631585wrr.98.1578502574558; 
 Wed, 08 Jan 2020 08:56:14 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id f127sm4374975wma.4.2020.01.08.08.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 08:56:13 -0800 (PST)
Date: Wed, 8 Jan 2020 16:56:12 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: How to extend QEMU's vhost-user tests after implementing
 vhost-user-blk device backend
Message-ID: <20200108165612.GB501521@stefanha-x1.localdomain>
References: <CAJAkqrXyeVn4iy7NzkR__BS9q9xT4ZWcjJszNBaSKH0U57c4hw@mail.gmail.com>
 <20191114111429.GC580024@stefanha-x1.localdomain>
 <CAJAkqrULM=wjDEVV8kZBU4u1ag4ERiKq3z5yzRus3vqwsx_a4A@mail.gmail.com>
 <20191213105810.GD1180977@stefanha-x1.localdomain>
 <CAJAkqrVzryw3L5V0=pTEv=wfO9t7423FbySzn3_bD_LpHUqqag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline
In-Reply-To: <CAJAkqrVzryw3L5V0=pTEv=wfO9t7423FbySzn3_bD_LpHUqqag@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 04, 2020 at 02:00:02PM +0800, Coiby Xu wrote:
> Thank you for the advice! I've skipped test cases regarding resizing the
> disk. The remaining tests are "indirect" and "basic". vhost-user-blk device
> has now passed the "basic" test
> (/x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/vhost-user-blk-pci/vhost-user-blk/vhost-user-blk-tests/basic)
> as virtio-blk-deivce. But it fails the "indirect" test because
> libvhost-user doesn't support VIRTIO_RING_F_INDIRECT_DESC (indirect buffer
> descriptors),  Would you suggest me to improve libvhost-user to
> support indirect buffer descriptors?

libvhost-user supports VIRTIO_RING_F_INDIRECT_DESC.

Please add VIRTIO_RING_F_INDIRECT_DESC to
contrib/libvhost-user/libvhost-user.c:vu_get_features_exec() so that all
libvhost-user applications automatically get indirect descriptor support.

Stefan

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4WCasACgkQnKSrs4Gr
c8jiAwgAxdJ/dSGgQxU0nFq5LAnpjgQC9wnqlfph2RNtox7gnYa/VwAHw+BxNSCr
dn+nCwlVw+GG62laauKnM4VPIqWkJmxzgs6sAdnsoxVZLcwrpirsLNwnFq7pAtnu
9F2LdoZ5SczScJXq+PG0N2UpN2B6duR1PJd2TX+WPeqsweFkC+yG56YDb/F0pJIc
T584MmxyN1VVrv00seolWDSrXRCExJxPufRlqZ562ggcSxqGTN9bb5mgTd2UKTiq
hL1mU9/V0B2IN/cxMbjk96+qBlyV/oYyTa9dPdmAsjC/d+VYtpUwrcwRvVKMzAis
fDEaG4ELHtem55tZA29XarsGWsrL6g==
=yRzB
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--

