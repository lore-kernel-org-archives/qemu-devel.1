Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23824C55179
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 07:54:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44FDC20782
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 07:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rFFgUY/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44FDC20782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY2lc-00034j-5j
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 03:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kY2l3-0002fV-GK
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 03:54:05 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35545)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kY2l1-0003Db-LO
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 03:54:05 -0400
Received: by mail-wm1-x344.google.com with SMTP id h22so1521507wmb.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 00:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=NeBa8Nl+Q0TYFbMJnp5QmysdRmnFdnPqqLmrAtqaugY=;
 b=rFFgUY/Xw85nuLUJpJ5OYdw8LIDuDTWLRIdYeYZvRkMST2f2xrbH0IgjKnMgkhICVF
 K1JDrVL5LZwnkEv2/yOssR25m6xPpOGl5mhbI+2ys4l5N/1aaY5IwOl3OhJ2rMTDStBN
 5rHdI2NS4qdx1O/JxlPm+cJYyCPeB2VzX4AZONjVOcvSa1+99PXHcX3EHF35SECMXA4u
 d6V8Ql8yl95nPCaPBcScRcNmifkhrhDMDLCzYc5XIfakrNIPp0Q7WCAPtz6bGstDOayx
 cG9KG0vgIOijPt9kCwLA00uEsyn476WGvDeyaSruwEPsuQnBod/ugxI7/AR5+iWDUJeP
 QZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NeBa8Nl+Q0TYFbMJnp5QmysdRmnFdnPqqLmrAtqaugY=;
 b=ujMhViUWN5+BO5fH8rzwWvvglGVsUcxzNen+Szf+8U0CleTbGq/5nArFXQxh94yl81
 fU/Ff+fWnxJxPjtpWVADdIT2nqxmiwiV3+GOZ9kG/ltzqvlI1JfrwrGC6qvvfGFc5FYx
 HKjx8dY45gfIIp8WH+NNk15U1+zurBLQGuBbzW2yE6ijnQq97BUBylE1ml+T1VjfsR/v
 5KMpv29bFtJ41sJ14ViEDa/R6/Jlgu4iN9DlcWINfVB7phAw1KyZIcdNszmIKCcV3bjf
 wFRntnjN7g5iVQGuK6DRsILFwaoZ+rS9XJpEXPg7Qrw0ww5ezWoWnfn2Kbr6z8uunzPo
 GYrA==
X-Gm-Message-State: AOAM530bSlEj2m0eEanwt0Oi47t3/VT/mvgO88dxvhCacOyUTkt5WdC0
 BrV2meH+1sRsUquTmtM+pvU=
X-Google-Smtp-Source: ABdhPJxviNvharjO3pKEGFtCrKuxWXQCcwlecSAD5sljdwZwgKUABzY7MGQ8Vim29wwxTn0jWG3BeQ==
X-Received: by 2002:a7b:c00a:: with SMTP id c10mr2854496wmb.119.1603958041863; 
 Thu, 29 Oct 2020 00:54:01 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id 90sm3180621wrh.35.2020.10.29.00.54.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 00:54:00 -0700 (PDT)
Date: Thu, 29 Oct 2020 07:53:59 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Joelle van Dyne <j@getutm.app>
Subject: Re: [PATCH v3 7/7] block: check availablity for preadv/pwritev on mac
Message-ID: <20201029075359.GC251558@stefanha-x1.localdomain>
References: <20201028030701.14086-1-j@getutm.app>
 <20201028030701.14086-8-j@getutm.app>
 <20201028115946.GK221115@stefanha-x1.localdomain>
 <CA+E+eSAfHXsYDbn5HnpGmQrpwpkAUBrMn7w4PwLDfMPctRwdFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CblX+4bnyfN0pR09"
Content-Disposition: inline
In-Reply-To: <CA+E+eSAfHXsYDbn5HnpGmQrpwpkAUBrMn7w4PwLDfMPctRwdFw@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 28, 2020 at 06:07:16PM -0700, Joelle van Dyne wrote:
> If built with Xcode 12 without the checks, a runtime error will occur.

If that runtime error is ENOSYS then it's handled by existing code:

  if (preadv_present) {
      nbytes = handle_aiocb_rw_vector(aiocb);
      if (nbytes == aiocb->aio_nbytes ||
          (nbytes < 0 && nbytes != -ENOSYS)) {
          goto out;
      }
      preadv_present = false;
  }

Why is additional code needed for iOS?

Stefan

--CblX+4bnyfN0pR09
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+adRcACgkQnKSrs4Gr
c8gTOQgAvraqb+nOVuNfnuXWxrHKvb3h0er7m9aEYi/oVQ6zceMEcOVfxuWICEIM
0fJYWZea+RrP7ztNT5GpWL0RbArRXrmmJF3GtRRfOXSbomQ392R/C3MSj+cIelPL
dl6CysVxPzvBPqBSPIheLR5nnq9sFYAJLMiWSWD1DP3R7vUAoJ4g+utz595rpkKe
RWuWCZCA7ufxEEPYPAEP9i9rUAE7N7GTW3R/wlpsyYmlvc9qbYTPUsmhrHY63tDn
Agyuj9B+B+eg02hrHaAWtshFEHarTPxdCgtXGEces0BPbNB7KqTtXt9DlCJ+DOvS
IURIiYJypYMn3mvf8Xpto10/LH1fsw==
=vwt+
-----END PGP SIGNATURE-----

--CblX+4bnyfN0pR09--

