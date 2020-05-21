Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF68C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:36:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C8E620671
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3bp2SgF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8E620671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbmJK-0002nT-6l
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 10:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jbmIm-0002MU-Rh
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:36:04 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53848)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jbmIm-0000Rl-69
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:36:04 -0400
Received: by mail-wm1-x342.google.com with SMTP id u1so5763252wmn.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 07:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=6dr1N6au+/PSDuCwuDyv95Wk7SFoJLoX7H1tBGd290Y=;
 b=J3bp2SgFuzbqJEpHEh2SE0dRE17uU9iVKMB0uORKrE0UlQ5JDarUQiczV15qF+j/Kt
 p+JeD3B/h1yWzJPCFah2DGa0NlIuuMSMdVpeRP/yI31pGDkyZskBR2lwBMOJWHm2TH3+
 CRAJLgye3lJvgZ+7kHB0iPlKu9E+w9W6X0uHR29GkSFNr9mq1wzQsmS01OED80+e6rtW
 By+sVUsDXWBdEKPudLgDdGarKh9wsRCw5blxy6KkLPMUkwkA60Jv8pVT32+eqFUFm7Vs
 jZD1l52zcav5EUwo34mB2+lyEvU5C4thmuM2IS4VHksaEDU9mKa8iZQ5xuRbdp81Rn9f
 G2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6dr1N6au+/PSDuCwuDyv95Wk7SFoJLoX7H1tBGd290Y=;
 b=RO/DLbM8jXcjfwksKU9PxD/rY1UAXeRhoSjQ7zWEGWf8eV8tE0vOwF0z7sQT/cSja0
 PYYbHtdbhDomSw/qHW/D9uZZqiEs7NSI+Y5KR3vWGgD2JD6dkSo/GvbnmWJhiqkA8Zx1
 UI5UCbAvuVApmIPBmUBJRqSyB6Efe/WYscNe2VP3MQO82bFNsE06VmuIwR3QXSQMUyjv
 YjzzXOYpLyQWJhR0pvLKU4NliQ/WYVAnpLXdjUWpeS40p7aOACWiodj4E1CC2hgvkc3U
 9CfjWX/YdbaIvcNhY4w/MmV4CL5/Dh9SpbYlJN0DH9SZsBc676bLbTeKHovXBuHF1/WA
 SbTw==
X-Gm-Message-State: AOAM532FFAAldFtCvrYtXTGs9skQCntqnlQpJua/nLR/4TH/nXNYzim5
 0KAp4Ka6v1IqgNfTDiMs7NM=
X-Google-Smtp-Source: ABdhPJwiqUhiifBX8C3kSbH440XuQcTra2yI+A3HEFkqqzBES+E2jiKMTuhf/ZWsgF4x7h2coSXT+g==
X-Received: by 2002:a1c:bd8b:: with SMTP id n133mr2454078wmf.160.1590071762406; 
 Thu, 21 May 2020 07:36:02 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id b14sm7248640wmb.18.2020.05.21.07.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 07:36:00 -0700 (PDT)
Date: Thu, 21 May 2020 15:35:59 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH 0/3] virtio: add vhost-user-vsock device
Message-ID: <20200521143559.GL251811@stefanha-x1.localdomain>
References: <20200515152110.202917-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8SdtHY/0P4yzaavF"
Content-Disposition: inline
In-Reply-To: <20200515152110.202917-1-sgarzare@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Julio Montes <julio.montes@intel.com>,
 Sebastien Boeuf <sebastien.boeuf@intel.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--8SdtHY/0P4yzaavF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 15, 2020 at 05:21:07PM +0200, Stefano Garzarella wrote:
> This series add vhost-user-vsock base device and its PCI version
> (vhost-user-vsock-pci).
> The vhost-user-vsock device can be used to implement the virtio-vsock
> device emulation in user-space.
> An use case might be Kata, where they prefer to emulate devices
> in user-space.

Looks good.

My main concern is live migration. If it hasn't been tested, please
remove the live migration code.

Stefan

--8SdtHY/0P4yzaavF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7Gkc8ACgkQnKSrs4Gr
c8jyOQf8DqTCaRrHi6J57Oanzd1Tzsn8jik7P4hLE2i422FIe4fATGk7fGJm51IV
oJ37fNZVxt7a1cgx5wV2XtpCT3I1Ov0m7bUaJCFLUhI0NJgTzg0VE0HMkzu33tga
UcBf7Ian8eodrxjVz3wdsdGp5kwjgvLsNdEr91IsfKHCe559P9IBMV1Gml6FtGqt
GAyZrjdggO/EGPOcRnehq287DTYWRWpdbbx29XdVE+nvZQ19LC/xmsSzrCDiFoRq
NtMqG0K7TotcQzJJEv4CmpSsh6++KqE9VGpP+YtbmWFRWDiQXppnwtYkE1vpQN4E
EKC4veE3KlVJ7NMslpbXIdoPYOyxvA==
=Ipej
-----END PGP SIGNATURE-----

--8SdtHY/0P4yzaavF--

