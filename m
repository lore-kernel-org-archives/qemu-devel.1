Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDC7C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:47:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9CB320897
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZOnYpi3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9CB320897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbmU2-0001To-TX
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 10:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jbmS4-0006Zr-Dx; Thu, 21 May 2020 10:45:40 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39147)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jbmS3-00022q-Jg; Thu, 21 May 2020 10:45:40 -0400
Received: by mail-wm1-x342.google.com with SMTP id w64so6601621wmg.4;
 Thu, 21 May 2020 07:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=uJ41ibNFVTnLpK8AfYMjQwjlteNDLIHKeqZW8vLnGHA=;
 b=JZOnYpi3lN99EzjrrGQIZ7RqpdhSaO5iDc+udsIFSUqVBWIVrZs5yPZQqdXV6CP/V5
 eaLBnb2uj/dUX1/0csgnet0XDpvMy4ZDtUeG2SA9rcjI0IMWAhPWq/dYuUPxOZ+nCZkk
 WOOmKcc0J9q3m7flrxUuKsOhq1T7qCZIw5ocgZgBGD228JxZq5E3M9ITyHklttkNoEGV
 8u1JkaFlkE+gO8Vn8kkWLW26LjtPFAYhHMudVe3Z4Zho/aez7NHKD90bBLXm/EIaMygO
 pKTrFGOp0oUv6sSHy96j+EchYxNNtxuOjrXC+HtT6GMpop7upGzlXNDuz6UfwVhcWp9a
 U4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uJ41ibNFVTnLpK8AfYMjQwjlteNDLIHKeqZW8vLnGHA=;
 b=X0x7qW+Y6M2WN/CkCm3QuBfweFoEgFkML2oLOLz14ifLi7CqSE/KgLD7ufDnLxhEtL
 3XR1fIAO/qVv2FnCrKoZyuoClsiHZdxP4BTDHJVKvfkzeEFlQEBMEsT4EN9ywLM+RfwQ
 hUc+baZKah+MQOnpxTQhoN4c5nKoq1CddzFv1hGdRE16Uo5G4+oZXNFoaFxMJSW+E+A0
 4WiogMrwU9zTMMg3D6xeErB/VA+OBkSgy2k7yIwqgAA0b/Sc+BmnaE2h90t1z9yeBQX4
 67Pk0CO9NLLsS7xXnSqmYTyUMyJc3HGJ8pny0eU6S3UDH912xfc5+WO6R4jorXBB5N29
 Xa1g==
X-Gm-Message-State: AOAM5339xIpwP/ZsqqCMmXfCOABmqULZ9EvXDipiaXG/3CPkDmbmYqUU
 s3ZCG1jEnoZuDuUBW+3JGpg=
X-Google-Smtp-Source: ABdhPJzGZ1tWvyzMgbJaT8Lo/HwH1YK1wimN0bZiGN6mHTXaX205wuz6s525M6Y8PXAXv5yG1vf30A==
X-Received: by 2002:a7b:c7d5:: with SMTP id z21mr8750095wmk.112.1590072336662; 
 Thu, 21 May 2020 07:45:36 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id y207sm7443355wmd.7.2020.05.21.07.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 07:45:35 -0700 (PDT)
Date: Thu, 21 May 2020 15:45:34 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] io_uring: use io_uring_cq_ready() to check for ready cqes
Message-ID: <20200521144534.GN251811@stefanha-x1.localdomain>
References: <20200519134942.118178-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jdM5ZcN/ZcXXVwZs"
Content-Disposition: inline
In-Reply-To: <20200519134942.118178-1-sgarzare@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--jdM5ZcN/ZcXXVwZs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2020 at 03:49:42PM +0200, Stefano Garzarella wrote:
> In qemu_luring_poll_cb() we are not using the cqe peeked from the
> CQ ring. We are using io_uring_peek_cqe() only to see if there
> are cqes ready, so we can replace it with io_uring_cq_ready().
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  block/io_uring.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

io_uring_cq_ready() was added in liburing 0.2 and is already used by
fdmon-io_uring.c. It's safe to use here.

I wanted to mention this in case anyone is concerned about dependencies.
liburing is a fast-moving target and everyone should be on liburing 0.5+.

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--jdM5ZcN/ZcXXVwZs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7GlA4ACgkQnKSrs4Gr
c8gI/AgAuzYVtjOW+rrvmiYYvCOYwPKtMEDeKXZDxQbFgp1QStgYXbgtoqjsSqp1
4aFEXqJJxIRFQDhC7W5+tFmpMz/mrZ3b4tM8il5vAovW2fyfsGtEss+btDjDRQz2
Posa+GCvANupzuxvPOMnEfePRce1ZIAwUJZQ3rOX3d6KY1EucD6CXJFEX2YpDN0P
b1SbCQt34NUfRraKLGfkX7ymt1ss74KU3u8NYYpHD3MGpkflnQmVK4O7lAHd4nsz
ozKWPVKqK8K6l/SzMVfyniI0xO6ULQTxe6IuL7g0rmRbdseIsD+ZiMrQWcJ0M8Ta
wAsD/f5hCulD/dQ1P5/120KuWWzdnQ==
=PIpG
-----END PGP SIGNATURE-----

--jdM5ZcN/ZcXXVwZs--

