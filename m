Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A20C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 10:37:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7B522074D
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 10:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAT7Ld/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7B522074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9nN2-0001Uh-4K
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 06:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <carenas@gmail.com>) id 1k9nMJ-0000yh-9E
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 06:36:19 -0400
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44]:41969)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <carenas@gmail.com>) id 1k9nMH-0005je-IL
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 06:36:18 -0400
Received: by mail-vs1-xe44.google.com with SMTP id y8so2983645vsq.8
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2020 03:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pU9GIaq7GHO69TOfdU9X/uXq1B3cBxmBCQTCf68yYkg=;
 b=fAT7Ld/6pCkhiA41dFN+qemewqUTscRhGLJBJNeAY4kLJkzmrslWe6FuGs56wqZI8G
 Y1od9ODAwY1k/xXZXytKVg5Zfm7LhvaJy6/peDKQrjbTY8WQ7dYcx31DaASr6kuvv3oA
 rxiPPTogMfKfMSzVbd/P+lwyl8sOfLqAdEzM0nb1JPvvGvl0VXs/w/F9N3mihI4puffS
 frQcKFX8ehpcMVbs45zZ3tWFVMpEVk8ZWL0Z3oqleVYfSKfefMwFf8R81TdK00eZdydD
 FTSzIOVN/TipIGZtDndmR5XuTt4eD8X8GzV6npToy7PMzX5DfXVwsKUidutotgvBT/Xp
 WnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pU9GIaq7GHO69TOfdU9X/uXq1B3cBxmBCQTCf68yYkg=;
 b=cpgKNHQP4k32d571U/z/Sy3zBQ9tvddMaJ7qhu/5tU6ye0u0m1C+ves89g1eyTPOnR
 0j7UU0Qaw/ZyWYa2Qg/9gE4DxrV1FNxx2dSuEj1IdVSfsFVXk5HakfFhLU7hxqui03dG
 hpJrJO1Ap5//ugmlJAVgHeqYR/p9vPzaRBg/S2HLWxixVb73CIggnFvNZMh0TkUJLjtM
 SrsGkxdtxdu8qQJtEjuEcCyorixBaWHq/+Jr+/zK6nuVuuy2iHNkUiRHLOMm+pu5Fws/
 lk5WV51v9SJ23HsysvcF784JQZyae+HXa9wMN6KjfHqD8O1ko2PZmLFctgpbmutgEpWE
 1emA==
X-Gm-Message-State: AOAM531LpmDRfF+WJfq7dJPUVzVq2KPpiBXACviFSHhnhjElMf/tp1Lz
 ye+8a7Uf7io+ud0xDO+b3irQ1Jp210AE1ZszPx8=
X-Google-Smtp-Source: ABdhPJx5fNZL+xtraZupkFQALAuc4UgAJg54aMpQZTgqyLUOjkAwARbfv9h5HxBLWt7U1LLFSkYuugrnv9QwS9bivtE=
X-Received: by 2002:a67:6996:: with SMTP id e144mr223530vsc.16.1598178976510; 
 Sun, 23 Aug 2020 03:36:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200821222830.91463-1-carenas@gmail.com>
 <9cd49239-a7db-c229-8cf4-fd6ac8faaaa4@vivier.eu>
 <CAHiYmc6=1vh5jrxuq+HuzJdFFygrwSpF=WF1+U92Sd3zsKExZg@mail.gmail.com>
In-Reply-To: <CAHiYmc6=1vh5jrxuq+HuzJdFFygrwSpF=WF1+U92Sd3zsKExZg@mail.gmail.com>
From: Carlo Arenas <carenas@gmail.com>
Date: Sun, 23 Aug 2020 03:36:04 -0700
Message-ID: <CAPUEspj_YiuYr5ZE_pzzgWRGfktLCwE-SZbt3TJwJtBLnSEUsg@mail.gmail.com>
Subject: Re: [PATCH] linux-user: warn if trying to use qemu-mipsn32[el] with
 non n32 ELF
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e44;
 envelope-from=carenas@gmail.com; helo=mail-vs1-xe44.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Laurent Vivier <laurent@vivier.eu>, "Maciej W. Rozycki" <macro@linux-mips.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The differences of bit width and endianness are already being taken
care of by the current code.

The differences in ABI for ILP32 are the only ones missing and so the
new version[1] (sorry, not a series since it makes sense as a single
change anyway) should be enough to fix any inconsistencies.

With this change, all linux-user versions will show the same
consistent error when asked to load an incorrect (wrong architecture,
endianness or bit width) binary

Carlo

[1] https://patchwork.ozlabs.org/project/qemu-devel/patch/20200823101703.18451-1-carenas@gmail.com/

