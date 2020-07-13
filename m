Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE7FC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 13:36:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39C2E20738
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 13:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VVH/+5RB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C2E20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juydE-000493-I1
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 09:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juycZ-0003JU-D5
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 09:35:51 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33]:33911)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juycX-0001a8-Pw
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 09:35:51 -0400
Received: by mail-oo1-xc33.google.com with SMTP id v26so765994ood.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 06:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AGztGEip1tOFPKWmEmPPPYSUMznt0VE3Z2/4fTyA09I=;
 b=VVH/+5RBbNOKKXNHNOqB5PJW+eMXfIQRMbVA0w36Mru19e0ZKSf4CJQEf5gm5DpsN7
 Qfn1EN6hKI+e7as1nARjh1rvU7BAiysbK74s4qCQYK0uiRWsctCnRoTtLqAMtFf7a5U5
 dPH67qoV8cq/5AqjzEH6E7hXoyqDA9dk0Lmg9ngnHZXDXuvSuNbWQG9fWcnJ6LeKcA5u
 oi+zC4H9+CeRLY+pL9+dE8cBUiEy+R908vik4bxt9S7lJfbrE3JvFVTZonTBZ+tVdf1w
 PgnLzLnVB8IgrxxTV3j9nfAoFW9Lx9n8IF6qgBkYahKg7yyNnE82RGQyl1E0IuKA31cc
 GOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AGztGEip1tOFPKWmEmPPPYSUMznt0VE3Z2/4fTyA09I=;
 b=eoyhNHG7ms7jfOEbkfL5UmNBt/YWghYhO+MSFERLfBbZ2ezd2UWXFO6AMCjX08Izy+
 2HhdgueFTzof7G/qA2GQVn5BEDCTTPmIZ9EID34M3LoZ7NsNGkN8Jgv3M5wG8Gbq08Yh
 O5EEEWtGKwI/Lfi/3Maon5f42fgQKuiYbSM98TovwhKgbjxSB3dvmpEyKVzeQJsGn5WB
 /o+UMUz/ZvL0tVXYATzOymnA3GODwuXy2WzUm9blI1HcZFTKgIKGzp0+Sj0DzcsDtWlb
 Toa9+V6j1WlHI0a5gKGimdclUViDk5C1utPHTOCpDBLla/UE7KZjjGA3GVU0L17lV+QD
 oO1g==
X-Gm-Message-State: AOAM533ogoHcUofMTXcJKje8qoqKgN+oJnvWgFOCxtbuazJei+5eAfEx
 JiVjpGZY0CFSSV1jVw7DlNrapU/aCwBPYzlmDCdQCBeZ
X-Google-Smtp-Source: ABdhPJyLoLLawqjXpL3VvPZvdkT+HpQCHA7f5s8Tlovy0GZxFSmYLEL66QkzlZU2pUZyFi3nBuuvkks1hT8o4/B7m0o=
X-Received: by 2002:a05:6820:172:: with SMTP id
 k18mr63146522ood.69.1594647348370; 
 Mon, 13 Jul 2020 06:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200713105534.10872-1-thuth@redhat.com>
In-Reply-To: <20200713105534.10872-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jul 2020 14:35:37 +0100
Message-ID: <CAFEAcA-oxi9R7JYBBVf-ZLANzkD0W_rf43a3d5jPsy-jrkm=Tw@mail.gmail.com>
Subject: Re: [PULL 0/9] Fuzzer, configure, gitlab and misc patches
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc33.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 Jul 2020 at 11:55, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter,
>
> the following changes since commit 9f526fce49c6ac48114ed04914b5a76e4db75785:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-and-misc-110720-2' into staging (2020-07-12 15:32:05 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2020-07-13
>
> for you to fetch changes up to 2a84f48c2b387877422ee85f6425d2c1b25bace0:
>
>   docs/system/s390x: Improve the 3270 documentation (2020-07-13 11:40:52 +0200)
>
> ----------------------------------------------------------------
> * Some fuzzer related fixes
> * Fixes / improvements for the "configure" script
> * Doc updates
> * Gitlab pipeline-status script
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

