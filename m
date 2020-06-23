Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819D0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 13:08:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 422AC20716
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 13:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzo5vSCp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422AC20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnien-0005Sq-Eu
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 09:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jnidN-0003tU-9i
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 09:06:41 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33662)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jnidK-0004iX-AY
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 09:06:40 -0400
Received: by mail-wr1-x442.google.com with SMTP id l11so20470183wru.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 06:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=dI8g9qS+jVB/4vLvhLgoILnPimY59KA7HsrlVbhps5I=;
 b=qzo5vSCpeQPeE/wDGfdxnn7UJRke3SR9I8+SdwcqkOPx2zDJ6p+0u+OH+inMYcME+H
 BPAYbB2dUUdSDHTzJWBUEALFgAeROjj7NO4ggOYeg69JlIAJErLVtIVewuGGZKevyvXC
 sPx0y3BmFPVqQU+p0c3cCp6mJqo+k5Ncs3mep+oUruWGRTv6G5s5BFX7UA4QDlQgMFkc
 WhOJsYwVHSuWbYsWcBk/IE6b0xJvwd5qaw5TKjIwhv0q7u9/ZgKS17xF82rZCmvnzsmu
 OWciBVZb0FdxZcWzxwTPhIihKUVnJh72dIo03YFaJTbC4/5wvxkP8ElcyzPL13HKX/fs
 zKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dI8g9qS+jVB/4vLvhLgoILnPimY59KA7HsrlVbhps5I=;
 b=jrha30a77L9Cq0Uw4plSjGZfP+1bdh1fsIxLTsthDdxwWZGZP+7XJIFcYUJ8j1TS6l
 3iihPVWU9qHPfgqqeOskaLMNYJbL92YderMV5IWLISUpJ4HsEfiizSTAF6qNj+DZRtxa
 yyJ+ZeiwZUu4S+NSL2JXYovBrB66Zy00SxowLRVVNsXclIZIXCrUOOL1BLppqDYcaIPX
 12lzO3xGnH+7b1kNMuu9Ypm9Wv9nBUCw2XDVJhmmA+KwkyipkeLrgzV0zCwVrryQmba5
 124IZ8gHgtFnu6BUSP3n8Q2vdEpJy4GzJPz4YXeTbh6gWEpjVUYMYHUiEm8XXPbXuRHe
 nrxA==
X-Gm-Message-State: AOAM532RsMCm3k9DEMi4Y+wOzjp8vPEklZ7SsCj8dUcJyhuqarryG/5w
 95a6bA08DXInwlm0h2Zhcog=
X-Google-Smtp-Source: ABdhPJwPioECzTzwflUGa9+5RjMyfJwgM4LGUgfxfTO7RlOvWsMKkEPQu6bRq/eFYUu7VmNd8seR4g==
X-Received: by 2002:adf:c44d:: with SMTP id a13mr3757269wrg.205.1592917596266; 
 Tue, 23 Jun 2020 06:06:36 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id 11sm3817236wmg.41.2020.06.23.06.06.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 06:06:35 -0700 (PDT)
Date: Tue, 23 Jun 2020 14:06:34 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: tugouxp <13824125580@163.com>
Subject: Re: what is the difference to transfer elf execute file or binary
 file on "-kernel" paramter?
Message-ID: <20200623130634.GJ36568@stefanha-x1.localdomain>
References: <79c48cfb.8c13.1729eae4849.Coremail.13824125580@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Ublo+h3cBgJ33ahC"
Content-Disposition: inline
In-Reply-To: <79c48cfb.8c13.1729eae4849.Coremail.13824125580@163.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Ublo+h3cBgJ33ahC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 10, 2020 at 10:42:01PM +0800, tugouxp wrote:
> what is the difference to transfer elf execute file or binary file on "-kernel" paramter? is it the same and all be reconganized rightly for qemu?

The -kernel option supports several file formats depending on the
machine being emulated. Linux kernel images (bzImage) and multiboot are
probably the most common.

If you post your QEMU command-line and the file format of the kernel
you'd like to load then I or someone else on the mailing list can check
whether it's supported.

Stefan

--Ublo+h3cBgJ33ahC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7x/lkACgkQnKSrs4Gr
c8h7Iwf/YEDDusD74TZ4xjQsAW1noSdTkg4vKRfyCcIt1+pOI5pgwFeWGvFjnfSq
1nbMC2xaJXviA5bye47d+c0MQ5eZBPXDRK29p8iNPD6Lyjqzs2iVKVsZW7RWf41d
oMdE0ROE1pesnEHI7YRn/1NJGUPj1VTK/kVjGCKkJpAwj+C+5DFivhpzWdOD8Ny1
R4wXEAIuOUI2nZ5focXK6SI0VGBlcrYjM3VsQiIsEEU8vrdKtLXkFdKOzi8qEjNQ
HiKsy6NucYsVnTkniNL21ZLlJucY4OHmP3sDPLrCzj0GQR7/XCBJsh5mHsYRu+/z
p4R74RuP9UH12afDNODj1qCLlmiL4g==
=AbAr
-----END PGP SIGNATURE-----

--Ublo+h3cBgJ33ahC--

