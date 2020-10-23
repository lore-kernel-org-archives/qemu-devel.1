Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBECC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 11:53:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F30F20857
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 11:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QLFULd8U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F30F20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVvdd-00049X-Fv
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 07:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVvcO-0002Sr-GM
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 07:52:24 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:40329)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVvcL-0005FV-P9
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 07:52:24 -0400
Received: by mail-wr1-x431.google.com with SMTP id h5so1472299wrv.7
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 04:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Yl5icqtET+OiBcIfafAo7TWMRE6keOrILdb3EyR0vK0=;
 b=QLFULd8UuWEQMjSJgV5crNyjPI3RTKzdxzARQuFnv36T3ujoyu9xsq2n14hMzA+46n
 Y9BvurmbmbKyQubYajSVzQpjoNEXPwk/uDuUMj/0dfb72KYDYn58QKWY+eZCRcx/tTt/
 eAnhy4h+N0bLWVWvyC3pBEe+gX7rrXOAijYsyzcsXY5UM4ieP3AfzHIhINGzdpxVr7Aq
 9Qr+MzYv84Dj1P9idveuFKIGa9Va0f2OjtkZnD2xEh1Cjzm+7kKILAKS1lbaoZ9c/32R
 CmvvgikOtZGjUpMmzuKKMS4AHSb1sUHPVFHqBulanCHPj7YFEvszzidQh8bo+hp1zuvy
 ESeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Yl5icqtET+OiBcIfafAo7TWMRE6keOrILdb3EyR0vK0=;
 b=nHuHJWIcFp5a/kr04u3DfS6Q2BavCitAmulLpcQKYsPqQ7MZNaoq5xA1dKUnJ2llXI
 hGXfG6s7TQa3JVg1VSWhG1bXvMLaLsKqPca7EzGFK5CFkIVm3+u2oNPDkNYmls+MWw6J
 2j9VJ6giE1UUy4gfh8FiLzOvH2wv+jw2hYJBUUytK4rRbKXBuxIvNP06HCTLC8uNEHQa
 TQEh2j5xLr4lzwrj80adNkRMizfJ1leccLsAq0WIDtSfYh9Pzcz7w2hqbifw62d4beB3
 /MKWf3qBZoLwJajbXTSs3cKNPWzzkkRedUqmRfN44lY3CL+xbGWdhLusdz8lnFQTVa7b
 aoag==
X-Gm-Message-State: AOAM530pCRPa0emgDD/6hnO5MPrKOEQ2hGj/l8B34P6kCi09SnWUzwoW
 y//JQjsdjGLwQ2oCj56cFdImvw==
X-Google-Smtp-Source: ABdhPJzSinLY3f/jThMkx9dNCRo6zK92/zlaR3+eZ/XWD1TYgA3iAE66G2c9iOCpTTP4PhCyWvuC6Q==
X-Received: by 2002:a5d:6110:: with SMTP id v16mr2408428wrt.219.1603453939458; 
 Fri, 23 Oct 2020 04:52:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y2sm3118472wrh.0.2020.10.23.04.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 04:52:18 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 89D5F1FF7E;
 Fri, 23 Oct 2020 12:52:17 +0100 (BST)
References: <87o8kttj2e.fsf@linaro.org>
 <20201023105120.sqharyxujgh7nppk@sirius.home.kraxel.org>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: Tips for debugging GPU acceleration.
In-reply-to: <20201023105120.sqharyxujgh7nppk@sirius.home.kraxel.org>
Date: Fri, 23 Oct 2020 12:52:17 +0100
Message-ID: <87d019tb0u.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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
Cc: qemu-devel@nongnu.org, agl-dev-community@lists.automotivelinux.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Gerd Hoffmann <kraxel@redhat.com> writes:

>   Hi,
>
>>   [    2.930300] [drm] virgl 3d acceleration not supported by host
>
> Nope, not active.
>
>>     -display gtk,show-cursor=3Don \
>
> Needs -display gtk,gl=3Don for opengl support.

Awesome - even on TCG the display is now nice and snappy.

For bonus points:

The AGL panel display is rotated 90 degrees which is putting a bit of a
crink in my neck. Is their anyway to rotate the view port. I tried
inverting xres and yres but that didn't do anything.

>>     -device virtio-gpu-pci,virgl=3Dtrue
>
> virgl is silently turned off in case opengl support is not available.
> Ideally virgl should be OnOffAuto not bool, but I fear changing that
> now (and start throwing errors on virgl=3Don if opengl is not available)
> will break stuff ...

At least a warn_report maybe?

>
> take care,
>   Gerd


--=20
Alex Benn=C3=A9e

