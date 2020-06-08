Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FBDC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 15:51:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E17D6206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 15:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WFojn92Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E17D6206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiK3t-0001L4-6r
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 11:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiK30-0000oV-6o
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 11:50:50 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:44754)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiK2y-0005tw-7f
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 11:50:49 -0400
Received: by mail-wr1-x433.google.com with SMTP id y17so17932778wrn.11
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 08:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=rpIxwQkCidHxn4hW3mOrkYqeO7ot24jezHwK2nQUd5w=;
 b=WFojn92Q2qpYqIwzJ3ybwi37yQpj2ed2qAf73uCvsrHSZ9MGNK2sZA/ltsljYVl3W4
 5YpiT4axmbHfbbkaQosON9EyErf4kfl4PI2zXzZJjGJOgwExC8RI9X8UK6GmViJFpGz1
 iCS4gEhjHCVO70mWXRytLbXAwAB8ELRXHfUmKfyJ25gVKIxdvR19Tg/+1fM/LjLyHTLo
 ZengoSB5I3KCzGQ+Jql2ZwS5TJ6Lp0QuR27zxFMfmBAzezpSzNLdEAZxgzeRrH95b502
 hSci6dpkcZrEDcZyrnuXYV07MdDy3kxn8XfzOtXKQRcQTe6PGsaTx53ikrPSDRydzk/V
 ZDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=rpIxwQkCidHxn4hW3mOrkYqeO7ot24jezHwK2nQUd5w=;
 b=gDTKh0snePJSWt3ceA0G4begIKDgrXrUOnwiWzaDaaFyR2PX6DDfTpeAZWBGuxneoV
 ckuFvzXAf7QrC0bVknqiIhiqiZNW4n/F4JXk/GFE+xBSUmTEO3gkwNDiTXGh8m0aFrEF
 8KkX65MFdp2+ADz9qctOVQ+ruRp/AQlq0PGQNTIaG9AFnIlaDtxhdGVfDgLCk9w1Tfwo
 YdDKxi8DfXN6v9Nw+Dw3pyBOSaZaWUd/d+i/ouB7BKbSkZJGF0sH/lICg25C0zM7qjEg
 7c+nqYs3TMomg/WAHCKMb1N2g32Qpqfy5KzVLD1Je3h3JB/qsSHpuVK3hVSCmj0cCvFz
 idgQ==
X-Gm-Message-State: AOAM533WP0VrYOkHh8uI4c9aYDduDeV65hfQsdNQ6xfhaFvNIsYgP8vJ
 e6vCMPWoZ/st8FcwisJVd5HEXw==
X-Google-Smtp-Source: ABdhPJwZEPNt0GgS0FE3kLwHCBuGXWgBnke+ammSrPLaMCoeTtZJYTu1fHBIUyi+nOBsEauwneMkUw==
X-Received: by 2002:a5d:628c:: with SMTP id k12mr24052499wru.211.1591631446665; 
 Mon, 08 Jun 2020 08:50:46 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g19sm2337355wmh.29.2020.06.08.08.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 08:50:45 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 447E11FF7E;
 Mon,  8 Jun 2020 16:50:44 +0100 (BST)
References: <ea06c0c3-465e-34a5-5427-41ae6bf583dc@c-sky.com>
User-agent: mu4e 1.5.2; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Subject: Re: fpu/softfloat: a question on BFloat 16 support on QEMU
In-reply-to: <ea06c0c3-465e-34a5-5427-41ae6bf583dc@c-sky.com>
Date: Mon, 08 Jun 2020 16:50:44 +0100
Message-ID: <87img15zfv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


LIU Zhiwei <zhiwei_liu@c-sky.com> writes:

> Hi Richard,
>
> I am doing bfloat16 support on QEMU.
>
> Once I tried to reuse float32 interface, but I couldn't properly process=
=20
> rounding in some insns like fadd.

What do you mean by re-use the float32 interface? Isn't bfloat16 going
to be pretty much the same as float16 but with some slightly different
float parameters for the different encoding?

Like the float16 code it won't have to deal with any of the hardfloat
wrappers so it should look pretty similar.

>
> What's your opinion about it? Should I expand the fpu/softfloat?

bfloat16 is certainly going to become more common that we should have
common softfloat code to handle it. It would be nice is TestFloat could
exercise it as well.

>
> Best Regards,
> Zhiwei


--=20
Alex Benn=C3=A9e

