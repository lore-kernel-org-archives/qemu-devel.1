Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BC3C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 18:53:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A065320758
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 18:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fPN3xdtq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A065320758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOQBK-0000SP-MF
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 14:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kOQAE-0007zj-N4
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 14:52:18 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:45340)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kOQAC-0003Uk-RP
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 14:52:18 -0400
Received: by mail-ej1-x644.google.com with SMTP id i26so3308394ejb.12
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 11:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JRtRV5DwhN4sZj6i+KCROddwh5d67mIFZSGuJ8DZL00=;
 b=fPN3xdtqUhdAMQMjwkKV5hOvMH+0aLWzTj+UnCX/ASO3WRHpN7CX8g4t2XcahQ/0aJ
 In+rcGbPuqj24pUiq0QIiN0C1yfRAxEnbe69vdT8NUzUOUV1R6Rm510Qawm2T+b4Uzv+
 p2KtX/OZgkySN61gnS46BoGfEt42R1k3jm8FCMf/zHYccAmx9Es5xOh7rtAe6ZSqkk6O
 FBpTR8+fgy03wiiQiN/mmRQPS3g5T0VvMHS+zSzn/0GVXCAZNDFfDoiGXgEtW5ugQa0x
 emBTzkMHAVj/cPx/AQptfeeT2Y3zgXmBaAKGJPg25vFQqHh9fHT5W5H7/NhDK56aMpbb
 GDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JRtRV5DwhN4sZj6i+KCROddwh5d67mIFZSGuJ8DZL00=;
 b=iKYmR8Qdl8L9cl0MDcLSieaZwCox7AjDyWOR0kCjASdxIR1yqM7RTg8TYHAFNcXsc8
 wgolMj+NOk7U21yF6HzUATHb4d7E9NUCOEbcEiimhRni6pDTa3Ct4AjucmGF+Cn/veo8
 Uth3KLwgaCIE/YRMirN3gmukme7iVj/fBbqB/fzowXmQpn5+uUIsfrtZqI9OHFjSZI1+
 Z39rbdSQE37yW1GN80B6CdLv1Q2DqaOIiZn3j6b6WdiBWgJH0UBif6PdLElKAURGG6Lb
 UL0bDXThbm2cxcflX91IpbzVUgWts4DBf9RywwsdG4uiyII4mQIXI3bYkY7YkEKehyBT
 2EsQ==
X-Gm-Message-State: AOAM533NhnhOZISnSHt9824TMs/vmD2Z60pYUNG3Fo10AFssKWIJy7WN
 5D7PO+DnJcdhksV8oGF02H/UjTIYJNYnBhwx8U0ykA==
X-Google-Smtp-Source: ABdhPJyMYv1RS4UWJ573HCcO8HP6uHbG7nxTNRuSZumqC+c5t2mw9sN5O4gbKLr7Z1adDW12WYtUIr8DSrPGBzzku64=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr3581616ejk.407.1601664734933; 
 Fri, 02 Oct 2020 11:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200930195850.278104-1-pbonzini@redhat.com>
 <a0b8e23a-cccb-3c5d-dbf7-f489c0d95f93@redhat.com>
 <5c9a0783-f7ea-7872-f5f4-44ba9e65a1b2@redhat.com>
 <20201002182457.GE7303@habkost.net>
 <2be76d12-695b-363f-c74b-f1b461aec3df@redhat.com>
In-Reply-To: <2be76d12-695b-363f-c74b-f1b461aec3df@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Oct 2020 19:52:04 +0100
Message-ID: <CAFEAcA_o8DbfBEOfR1VrFg-2AXOT2Ts3sj6KXrf4iL2BFMjMCQ@mail.gmail.com>
Subject: Re: [PULL v8 00/86] Misc QEMU patches for 2020-09-24
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URI_DOTEDU=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2 Oct 2020 at 19:45, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 02/10/20 20:24, Eduardo Habkost wrote:
> > We already have Sphinx 3.x hacks inside our fork of kernel-doc,
> > see commit 152d1967f650 ("kernel-doc: Use c:struct for Sphinx 3.0
> > and later").
> >
> > If we want to keep deviating from upstream kernel-doc, the
> > following patch seems to work.  Do we want to?

> I can try sending these to upstream Linux, too.

I did mention the c:struct change we're carrying to Jon Corbet
when I sent him the missing-close-paren fix to kernel-doc
earlier this year:
http://lkml.iu.edu/hypermail/linux/kernel/2004.1/08760.html
I think it probably mostly needs somebody to try these changes
in the context of producing the kernel docs and see if they
are sufficient to fix kernel doc production too...

thanks
-- PMM

