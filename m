Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2BCC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 18:57:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 888DD20768
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 18:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xP/q58UY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888DD20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkuIm-0003Gt-Nb
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 14:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkuI1-0002jb-90
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 14:57:01 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43236)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkuHy-000828-Ee
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 14:57:01 -0400
Received: by mail-oi1-x244.google.com with SMTP id j189so16831876oih.10
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 11:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YmH3hG6EhBsqqMd07CDLXlRsVvhPUNVt2A0ZzdgHAJc=;
 b=xP/q58UYbKL4/L+gCAQeH92j7Fjd2Z8c+sVT1Bmd5w9uMlaxC8CNsbqgrkLIIF2DA4
 fyPvKccena1j4PHpkTld9ELWWHaWvOuX8s3wYAGe9OfTo9QU9J4MMWkuOq4KsiAd461X
 VzcNcnLkns+5cmeGnLf3wwHJPS7DmT70PfLzGtFEGjwfx4C3bHPbVfipFLIHU2uI9xwE
 vEEb13R8Acv9mhW+ehC39DeJffjI2TGrXCWhIsfDbmLEaxdXJnltph+SCFjAkVEk4XQr
 XYWXMyyJ9FpdEzr4SPTum/MA6Jk9uZyBSJJqCWSnsLI5yBQ6g7LrQK4RsPogu7z/GplQ
 f4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YmH3hG6EhBsqqMd07CDLXlRsVvhPUNVt2A0ZzdgHAJc=;
 b=TpvTE7EZVS6ZI43XhnUsC6vjsxFj7WputriXWqzrVxr818YuPsvaMJcw95Coehzpdi
 Me15YjfH8P7pZsXxJ8H5Sxak5FBIYmywMT3lqFsxV8Vx/R1irBzDJVvgTlRq6h5tLeDE
 oL8Hf8aoKKJAiQJwYwkh21Y6v1y56uPPmDoO05wGdNc27qIrYuGlGx6YxRF+Dzp0il6j
 JoRqJvJBZ0MBJkoLrg7WYc1NmL60Hcvgp0KOLCcoL/WczjpAlXGBmp2J4nufeDSKE+EP
 Y/0A92X8kIIMoB+TvVteDBo8dt5PKW77byu5VgsP0fnTqJWGLp7qIctYO2Cj8copxhO1
 tJzg==
X-Gm-Message-State: AOAM532Aiua6PC15Weesj7aAuoFp9U5rnYdZ2ruZuUSFO7r+NQZItEma
 8JypJt7KbHcFjJ2Oy/JRAlENTDxK9JAH2srHiV2ZJg==
X-Google-Smtp-Source: ABdhPJxDgpB7+j8lGobSHHjCxnLlnPu80vI3Q4VugAVJDY9ap06eXyTvSwMVd1NAeUjsKxsBNcgkWJqu7cXvFuxNzRw=
X-Received: by 2002:aca:568c:: with SMTP id k134mr619824oib.48.1592247417050; 
 Mon, 15 Jun 2020 11:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <1591663670-47712-1-git-send-email-wang.yi59@zte.com.cn>
 <94e456a8-0b4f-e1fd-7baa-8f81f36c6872@redhat.com>
 <31290c21-01bb-e191-a166-1595f4fc8549@redhat.com>
 <CAFEAcA-D440Z4-cPdmpMXJcfkxjrHTOvwO2PG5BhyXMzRCQN+w@mail.gmail.com>
 <eb11ce18-f1db-1d60-6b8e-3b0ba6ce6993@redhat.com>
In-Reply-To: <eb11ce18-f1db-1d60-6b8e-3b0ba6ce6993@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jun 2020 19:56:45 +0100
Message-ID: <CAFEAcA_kfs-Par3fA0x3=m+X5ZXNCfj6TrLZFPWUxgrcTODS3g@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Install qemu-[qmp/ga]-ref.* into the directory
 "interop"
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Yi Wang <wang.yi59@zte.com.cn>, wang.liang82@zte.com.cn,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, xue.zhihong@zte.com.cn,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Liao Pingfang <liao.pingfang@zte.com.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 15 Jun 2020 at 18:00, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 15/06/20 18:32, Peter Maydell wrote:
> >> Queued, thanks.
> > I guess this works, but it's kind of odd because it's installing
> > a non-Sphinx document into the Sphinx manual directory.
> >
> > I'm hoping we'll be able to land the conversion of the qapigen
> > stuff to rst this cycle, which will make this change moot;
> > so I suppose it's the most expedient fix for the moment.
>
> I can keep the patch in the queue and not submit it unless really necessary.

Probably better to apply it; the conversion patchset is pretty
big and is going to need at least one more round of review.
And this fix won't be a big deal to fix up the conflict for.

thanks
-- PMM

