Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819B0C433E5
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:13:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FF622065C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C9VbNTK8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF622065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0SE4-0005DT-BW
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 12:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0SDL-0004Xg-4k
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:12:27 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:45321)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0SDI-00017M-3o
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:12:26 -0400
Received: by mail-ot1-x334.google.com with SMTP id h1so15248148otq.12
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 09:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8Ql2ayafqLc1lnXHpXZ45nQ+w1BXNFoFwUvhFlDIV7Q=;
 b=C9VbNTK8uD7hi6hKlNU9cSGt/PWpvZcVhC6UHx9hUw5M2g6bTwTxFrouy0O69GyfMj
 AHf79Pj37UkTV/NgdtehYt9NBy557GOfbOuvQ/6QtBNloe1M87pq5jk9khNDTweqqiGL
 G5v8Cie4xO5LJ8y/vS76dINLwq7wXRsbjOtHiZDGYcXu0v9Bcwva3QyiXMFCQx8Xu/8F
 OdsfGmycnGEOiILoy8iTjUZukryPBSLBoJuef9IAJJbHrdBJLBBWbpGe3/BGiGGGqbDC
 uBbzZdWHxm22igmxMsP97di+JHB2/6QpXlDJElYFyKMhbF/2Sb6mRcau3BsJKuLgFTVS
 d1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8Ql2ayafqLc1lnXHpXZ45nQ+w1BXNFoFwUvhFlDIV7Q=;
 b=K6QQ+JHDVvME341ZMgg5qe5YyeNirBjxLjSagcUdT/F0uNfKCTs50b5B5KOeH/Tc/j
 7LYgA8wTRiou4xn8a3o/6wRQ6ILlQIvpaXgoQtA5BRspl3H5dg1BkoYwIAUrdcW4iiWf
 wolNsZsOX6OZ6+w1preO7zAgUtrOm6Ashr/pIKAtjU40qkO177PFCluA+P+7tkNm9VAs
 ujSI/bhlEoHm/YCboWLY9Z9HspiitsXcu/kH6/pzIos60fdS6iHpdZUinlrAcWdpiTym
 pqYysIcnOGtKXsgEcSKbkCsV0xPotVhoBtRU2caNg4cpumkJoUEZchzBxY8EQjhXxvEe
 aTTA==
X-Gm-Message-State: AOAM530PsPW2k1S99VOXFjzw1DwZdlHe3tWt3fkMcLjaGsHgmelt2l8S
 mTYfnGilEaUk6joQHlqfOhVcmsSrhv1FkKvETGGX+iTDdVM=
X-Google-Smtp-Source: ABdhPJwcuCRcETpeG9P8BFUQ8pOLaiiaq58+7qaH5fGq7OWzUj45zsK6umy7a2WH9APWUf7/2g8MWMS6zxSyHFXdCms=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr24915964ota.91.1595952742654; 
 Tue, 28 Jul 2020 09:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200727143812.1101547-1-mreitz@redhat.com>
 <CAFEAcA_8hhEUJdxGzmjVjG+CFosAtDf9GAR0D2x+-k_mU7Gfug@mail.gmail.com>
In-Reply-To: <CAFEAcA_8hhEUJdxGzmjVjG+CFosAtDf9GAR0D2x+-k_mU7Gfug@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2020 17:12:11 +0100
Message-ID: <CAFEAcA_W+G_5iSGj+rg0dx0rUod7XYmR8cxEfGcSKsccVNrtTA@mail.gmail.com>
Subject: Re: [PULL 0/3] Block patches for 5.1
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x334.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jul 2020 at 11:19, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 27 Jul 2020 at 15:38, Max Reitz <mreitz@redhat.com> wrote:
> > ----------------------------------------------------------------
> > Block patches for 5.1:
> > - Coverity fix
> > - iotests fix for rx and avr
> > - iotests fix for qcow2 -o compat=0.10
> >
>
> Applied, thanks.

This seems to have broken the "tcg disabled" build on gitlab:
https://gitlab.com/qemu-project/qemu/-/jobs/659352096


197       [1m [31mfail       [0m [10:57:48] [10:59:34]
   output mismatch (see 197.out.bad)
--- /builds/qemu-project/qemu/tests/qemu-iotests/197.out 2020-07-28
10:47:16.000000000 +0000
+++ /builds/qemu-project/qemu/build/tests/qemu-iotests/197.out.bad
2020-07-28 10:59:33.000000000 +0000
@@ -26,9 +26,9 @@

 === Partial final cluster ===

-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1024
+qemu-img: TEST_DIR/t.IMGFMT: Invalid parameter 'compat'
 read 1024/1024 bytes at offset 0
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-1 KiB (0x400) bytes     allocated at offset 0 bytes (0x0)
+4 GiB (0x100000000) bytes     allocated at offset 0 bytes (0x0)
 No errors were found on the image.
 *** done


thanks
-- PMM

