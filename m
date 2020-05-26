Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B51C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:11:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDAEC206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaBTxbiY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDAEC206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdcBE-0000MF-1p
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 12:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jdc8D-0004kk-Lr
 for qemu-devel@nongnu.org; Tue, 26 May 2020 12:08:45 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:42416)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jdc8C-0005wF-LP
 for qemu-devel@nongnu.org; Tue, 26 May 2020 12:08:45 -0400
Received: by mail-lj1-x242.google.com with SMTP id l15so24856169lje.9
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 09:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nBhNl+8065aRYnzq4Yta9UDhZD/XioKAkbYiTHNkizs=;
 b=LaBTxbiYVRoJaGKf4HBjaK/FPuTiu1QB8PVEZSjdyVxDlfUBZLdlLmgkVKjNUxoOF2
 AlqAkJGDMl2+UhrNdcrymoSWeMxfWJtHHqAdGMVzsrdcCvaO7pZPeQKLK9FBjh922sCr
 vbcWty7ssu9vRwvb02nbQKOod32oY29ueovceJA0T6yyVPbJWgdumPDt/QwYqDaEYo8O
 nNF2eknCgeQWAUV7tbr8RhK5QQSiZnUiNuSHI0TjQVu2QwC+0M728YHXXz1V9dIRI3pl
 Kqmmkre/FRPiexIAldyVq7EjXbG8UzO/2ge6PMi20HFJ0vYCKMmdnR1QMh51yW2syD+g
 61gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nBhNl+8065aRYnzq4Yta9UDhZD/XioKAkbYiTHNkizs=;
 b=pP5Eosri9EH5qLvgBmGyBy+jNNYHZdfA2OWD+lHiqfEGU6C2HZDmRPIghc7jxt2cTk
 wAiOLtoW3YLRpIPXvNnjz02SxvCy+w7HpjULEfF4GshMmlY4xQMJaNfx4IZ18XZkZzEA
 AMpVGuW68CfqWCKs6K7uPgPXv5b1nfG82D4pFwlvvc8DaM9Sm/ESJc+gFzIKJrDYLJCi
 5ugW+U8J7SRU9s/BYjd7rlnsPJNJe1hbcnW6qLbhVjvnWdjtnMoQUdXUicWYkvnj2EjJ
 tWjhKJca4zMFDYK9iO75bK6pU5nYFcr7FwsxWGfjB+L6PS/2MpYgBCZknLeeF832xvfE
 pP2Q==
X-Gm-Message-State: AOAM530eCgOxZ91cnhf6FjXZhOO9ufB9yn7F57RPv7xLQpRBFku3O/2r
 A3DdVXL2BnSzlBJSUfpNPyglm60zJjXOmeA4CpE=
X-Google-Smtp-Source: ABdhPJyEylgiNaDriA1TPFq1h3ONjgOrKK3OBlEjuAHuhM0r28w1DGX6ZmQJy++TGyavRFfgVQGvPSfu7GPVsXYIBaA=
X-Received: by 2002:a2e:901a:: with SMTP id h26mr1032374ljg.80.1590509322108; 
 Tue, 26 May 2020 09:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200519162144.10831-1-ahmedkhaledkaraman@gmail.com>
 <a0f3967f-e125-d888-bc6d-44414edbfd5b@linaro.org>
 <CALTWKrVGqVb1mjsaoxYm4Y1iQoXYwz7ToC7T6r2EDPp-_LO=LQ@mail.gmail.com>
 <4e78400c-42be-08c6-492d-dc5596551efd@linaro.org>
 <CAHiYmc6zKmxgyKHzT4gazvJvPsX3SQYLjSXwK50_2eURkR3_NA@mail.gmail.com>
 <CAHiYmc7z+OfvE7nN1j14n2O8seVtqem_hsBwq=WyFgeo=WfybA@mail.gmail.com>
In-Reply-To: <CAHiYmc7z+OfvE7nN1j14n2O8seVtqem_hsBwq=WyFgeo=WfybA@mail.gmail.com>
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Tue, 26 May 2020 18:08:05 +0200
Message-ID: <CALTWKrXv6NQUEzKFvPN4TmDGCKxY-Zaa+Dt-z0+sTgndco+EMA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Update use_goto_tb() in hppa and rx targets
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lj1-x242.google.com
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 26, 2020 at 4:14 PM Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
> Ahmed, please follow the instructions on this page: How to report a QEMU bug and file the bug related to the discussion, to the best of your abilities, if possible, today.

Please find the link to the bug below:
https://bugs.launchpad.net/qemu/+bug/1880722

