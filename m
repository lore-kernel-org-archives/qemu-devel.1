Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366ECC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 08:50:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC00C2088E
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 08:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iljc1xHz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC00C2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeEFS-0002lz-3P
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 04:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jeEDZ-0001QG-Uq
 for qemu-devel@nongnu.org; Thu, 28 May 2020 04:48:49 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51441)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jeEDY-0001mK-V9
 for qemu-devel@nongnu.org; Thu, 28 May 2020 04:48:49 -0400
Received: by mail-wm1-x343.google.com with SMTP id u13so2284760wml.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 01:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=xL7qK8ZWbzy4gxK/GIFYPzu7RMggLz9h6RNZ0CrW790=;
 b=iljc1xHzcQLyi1uWBs1zHxjLgEYHLFyxYYlAGxYLqontJnLm0198VJvZ4EQYiBD38u
 6HiA6KCPqIPfs3TgU72YpNwtLfH7x9anzMLuBZckj/9ZXSQvH41bup8qksudTYOsS4JQ
 8hoHsZ55EDTOjWHAZSs7JLZ/b520Ifr4OCrR03ZWVLaCIwj7Jc97MhJwugAunJgtgmXM
 PGWcYlZXxCtAIRH89iiLOTN3ts/Lgm5YBIYzJAb01IfuE/xd7WUIogdpx9X5GwnLZPiY
 Mg/+f/ctlemaUVMf3GBwSMaD+W7pxbNMRtk73o+YMc/VV+JFb/lbblnofoTIVwe7aqRW
 DAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=xL7qK8ZWbzy4gxK/GIFYPzu7RMggLz9h6RNZ0CrW790=;
 b=VDg0Pi81WCK1XscOikB+/9uQS746IipW9lrPqkzd0ToMEtQDKF9tIpOxh/Zl2be53l
 ZMpy01WDjZSJRxSYGXuPcdTci5KGYHQgS7xMwvA5iRpK5ydNpBJtm6WYBeKqjHqy7ojN
 Hu5tihtTRvc4g8/Tye45WKiFUnnj0ITj3qy+aBpj3r02bz9enAfVODuiKHbRkLZRrtwt
 49HM3ejQiV9MnKynJB4BVVNYUnB/pIvZZeO4Vcsi5Q9sm1aKc4bbg6j80+yAer/l0PJy
 Y2jAhk3NZ0/kShLnafooieOhsjFAvoS8soMI7GImkhuBAAcWeBxHWQKUaBjlB0dzlkzv
 +aFQ==
X-Gm-Message-State: AOAM533AnHy/lmwuTCQ9S4eNvK5roQPKFnMKgcQW+Bbwro3uZJotii8q
 XaCIGqPdFyyn6LxYWP2UY7XScZdE8Sw=
X-Google-Smtp-Source: ABdhPJxhFGCEHVKkTrwOXXeOlh/0Wjgpi5MZMZkiOmwXJZ3frGtTPlOillzpmtewycsKcHGeEVeeVw==
X-Received: by 2002:a7b:cc06:: with SMTP id f6mr2289132wmh.119.1590655727052; 
 Thu, 28 May 2020 01:48:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n9sm5427367wmj.5.2020.05.28.01.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 01:48:45 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0158F1FF7E;
 Thu, 28 May 2020 09:48:44 +0100 (BST)
References: <CADAnahmxeveTRvoN9TN3qgi+_gy5PpSCULy+Cp3Rzj0gaE-p7A@mail.gmail.com>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Chris Hoy <hoychris01@gmail.com>
Subject: Re: Fully operable build post
In-reply-to: <CADAnahmxeveTRvoN9TN3qgi+_gy5PpSCULy+Cp3Rzj0gaE-p7A@mail.gmail.com>
Date: Thu, 28 May 2020 09:48:44 +0100
Message-ID: <87mu5s4f83.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Chris Hoy <hoychris01@gmail.com> writes:

> Hello all,
>
> I am proud to see that I have my barebones implementation of qemu finally
> working. After starting earlier this year, I have slowly made progress to
> fully integrate my kernel hardware into a gpu-passthrough vm. I went
> through many settings and templates from various sources and finally have
> something that works for me for a start and would be really interested in
> lining out my experiences. It is my observation that the documentation may
> be a bit unevenly distributed on the official page as far as templates go
> and so if I could help I would like to send my template through the
> official forum. Any help or advice with this would be greatly
> appreciated.

We have a top level page on contribution here:

  https://www.qemu.org/contribute/

specifically the page:

  https://wiki.qemu.org/Contribute/SubmitAPatch

goes into some detail on how to prepare, format and submit your patches.
Specifically it has notes on basing on master, breaking up a long series
for easy review and how to submit to the mailing list using git
send-email.

If there is something you don't understand in those pages or something
that could be made clearer then please ask for clarification here or on
the IRC channel.

>
> Best Regards


--=20
Alex Benn=C3=A9e

