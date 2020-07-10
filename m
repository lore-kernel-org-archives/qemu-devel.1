Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B4AC433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 12:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3253A20772
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 12:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xjdCdqSj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3253A20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtsZz-0000m3-Cu
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 08:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtsYn-0008PX-U2
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 08:55:25 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:37950)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtsYm-0007rs-3e
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 08:55:25 -0400
Received: by mail-oi1-x22d.google.com with SMTP id r8so4693018oij.5
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 05:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kvJyznxC6mSq10YerkGA0VU25/yk8WpIbpFZEdgLZCw=;
 b=xjdCdqSjmkJjw+o7wifVD1RoMZmwIPNJkQC+ZbZPayOlAL0FqX2Neml08EDbTdOFjv
 utqrs1knpOhTQiKhKTEcRIfMjQDtTHFJxYamod0GGkjjU9BlD4W2UZfOYXieuB+0k6th
 lH1A/VxsiFAgHPutA2ijN7lntENHpvLuzHlev+LGx6vSL21FBRdMlJM+a48H48+a6Jdr
 SA6w2icQMAzpjY0azrqPIZNfhxYhuhnkfWzRMRT0ZHJF7RupSdfPEDNbLWtWqDgfFnWc
 7Xv1LwifXqZFucLqNxEByCf8n4lGS6fdCtXTder3HCHz+tyTH6A6udx5OdomGVfQ3ZTd
 s8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kvJyznxC6mSq10YerkGA0VU25/yk8WpIbpFZEdgLZCw=;
 b=kAQm9UVC/opjbxwTDSvYxazkWJTxZdrNYvwqkl+kxvOmx0AgEXRTpTGXiekKokNx66
 HkRFNxQnHBHe0GydBznqr9/0et/aTB2rGIufUw0LoMH+oB6Jh67w0qiGg1gNZ5Gcteuh
 42vSAwt/YB2yPi8sAOIUY3Pf13Ar2M28SQxE0aJgZWebP7gBJ41159d2oKULnXcb8MlV
 IeYrc6PDzpZD3SqfZpiBXFSdYo0OYvHGvWc+t03Hf0vqkN6H1WDg+KMnctYBFU9RCQ7S
 VkSCnhX5elKA5WQH0QXoCXMYGmONLV7I3uzara02+TOFid9eBSDKrQNyb8atXAfW0X2i
 JLWA==
X-Gm-Message-State: AOAM5323pRGhRxlv7In3Ha5ch4oTtJNmKS5+6O0aRaS+f/TQ2gwBc4iZ
 a+hhP/1F+TyHc7Zc40BlSpG8Fj4hW2kdv0CLfqtW8A==
X-Google-Smtp-Source: ABdhPJyliAs2DhHLHL4EYeZtI0IHh2KFNioMEzE67u79ATkbZuw3BQ+97gjL+9V5sQRzvmTURx0NekE2y+JMiVx4pEk=
X-Received: by 2002:aca:1706:: with SMTP id j6mr3893084oii.146.1594385723006; 
 Fri, 10 Jul 2020 05:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200708172542.25012-1-pbonzini@redhat.com>
 <CAFEAcA8b6sn8fXOKwqOF6MvsKT5oKqS+4jjYDPAPvnXmVimLiQ@mail.gmail.com>
 <9631042d-00e4-2a2e-292b-66ca1b590120@suse.de>
 <CAFEAcA-UbHpj_xSbqjTsaURt8yPZjuYOmd3pe97vg_G7--17Cw@mail.gmail.com>
 <e78820bb-af5f-c2a0-7727-1a0caedfa584@suse.de>
In-Reply-To: <e78820bb-af5f-c2a0-7727-1a0caedfa584@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2020 13:55:12 +0100
Message-ID: <CAFEAcA-raDJ2pSUG-OYHcJi_LnQwxMHvcyjsD7+=WxGYcrSz3w@mail.gmail.com>
Subject: Re: [PULL v2 00/52] Misc patches for QEMU 5.1 soft freeze
To: Claudio Fontana <cfontana@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Jul 2020 at 13:52, Claudio Fontana <cfontana@suse.de> wrote:
> If you can access it,
>
> https://cirrus-ci.com/task/5537514263937024?command=main#L2039
>
> the thing is treated here as a warning, which is in the middle of a large amount of other warnings.
>
> private/var/folders/3y/l0z1x3693dl_8n0qybp4dqwh0000gn/T/cirrus-ci-build/ui/vnc-auth-sasl.c:648:29: warning: 'sasl_errdetail' is deprecated: first deprecated in macOS 10.11 [-Wdeprecated-declarations]
>                             sasl_errdetail(vs->sasl.conn));
>
> /* ... lots of similar warnings */
>
> private/var/folders/3y/l0z1x3693dl_8n0qybp4dqwh0000gn/T/cirrus-ci-build/ui/cocoa.m:1478:9: warning: implicit declaration of function 'cpu_throttle_set' is invalid in C99 [-Wimplicit-function-declaration]
>         cpu_throttle_set(throttle_pct);
>         ^
>
>
> Apparently the cirrus-ci I am using is not treating this as an error, while what you are using is..

Ah, I see. Yeah, configure by default doesn't enable -Werror for OSX.
My build tree has
 '--extra-cflags=-fdiagnostics-color=never -Werror
-Wno-error=deprecated-declarations'

(of which the last two are relevant here). We should probably
make configure use -Werror on OSX now with the same logic as Linux,
I've been using it that way for ages without issues.

thanks
-- PMM

