Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FF1C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:21:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39FBC20720
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s5w7unti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39FBC20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY4d5-0005ly-Cz
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 05:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jY4cT-0005L9-TS
 for qemu-devel@nongnu.org; Mon, 11 May 2020 05:21:05 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:32996)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jY4cS-0003aD-UE
 for qemu-devel@nongnu.org; Mon, 11 May 2020 05:21:05 -0400
Received: by mail-wr1-x443.google.com with SMTP id l11so4065369wru.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 02:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=MMHIDaNWeDbMzD6GPl1wvAv3WPo63uQop0Ll6FSwFzo=;
 b=s5w7unti7F9izz4V7zMGbIjVAmwMIqUXNsBgCXPBrbMMd+fderzkdH33ojj3yMKNeG
 5UDT5FdMxhdrJGpph5w9hWz0rLK8AM6rDs9Mn0SAgpdEWeiLLONzIFdj8ITtglY7xcfF
 sTw4thFKeMnKn5USpmYkaZmk0dX2uBplvrNjnOYAqyOoGKBQleMaXMfUzrxGTcqsdb6h
 JO6ccXqKB71BBI2+O+5RDX1++xK5exf/6PEN9GWG59WUve2dHRHW6qnjoiwU8PzAXDt+
 ktlCxa9fXFj1elWZrxfc7T7sgTcHZrYbqcBy6wZPFP6f+k4V76R7y0HRP3wu+4bWrJTv
 zs5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=MMHIDaNWeDbMzD6GPl1wvAv3WPo63uQop0Ll6FSwFzo=;
 b=fcBo+mJHruN7/y+/EurgsMzi20tMqCH4pE794tU5/zG3Tcq1swJ6sdZElgz8p7UV0w
 wfLUt0L2B9cF41w0VJiZ7ZQHlhdxP/0d4Ta7vgP9lXJFydGK/gGgRoN6yYzerD4bzQha
 g0PqdXI5KlgFDuKADStBOG5MPY5KMO84BL7PNQbOAnf2AvvI8k6SK5DMZ/8+ui/Vs8gk
 XoEw7fy6oZKRuaIJWE8ZAqgjSuw4MNWc1+WvyxP75P2JvXgoNQ5GTHgH/hHwGsUhn7cu
 MpW5ijMH7/o75wYuku3R5yccvHt5MGYDKd0CAZK7oVFeilF9eYWdH1uxOo7PVvs6KroX
 Okfw==
X-Gm-Message-State: AGi0PubzRlJCxLwys5L+v8FhWr2/Lu3SisJIB/k6/GhObPtEgP8jlxDp
 JXzIE9Th5/6ve5tN2iyNsAIthQ==
X-Google-Smtp-Source: APiQypJOLh5AKMnyzPV6Ls1ZtmJh/eGxO7W/5/xRGGW3qAoB6MY1J0VHJq/4q+ZUbywA9DPedYOa6w==
X-Received: by 2002:a05:6000:1241:: with SMTP id
 j1mr17691727wrx.42.1589188863261; 
 Mon, 11 May 2020 02:21:03 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l16sm15940991wrp.91.2020.05.11.02.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 02:21:02 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 23B2C1FF7E;
 Mon, 11 May 2020 10:21:01 +0100 (BST)
References: <20200312142728.12285-1-robert.foley@linaro.org>
User-agent: mu4e 1.4.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v4 00/10] tests/vm: Add support for aarch64 VMs
In-reply-to: <20200312142728.12285-1-robert.foley@linaro.org>
Date: Mon, 11 May 2020 10:21:01 +0100
Message-ID: <87h7wmrfnm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: peter.puhov@linaro.org, philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> This is version 4 of the patch series to=20
> add support for aarch64 VMs in the vm-build infrastructure.
>  - Ubuntu 18.04 aarch64 VM
>  - CentOS 8 aarch64 VM
>
> V3: https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg02805.html=20
>
> Changes in V4.
> - Removed the target validation we had put into Makefile.include.
> - Corrected a dependency on a later patch in gen_cloud_init_iso().
> - Changed the consume console patch to make draining the console to a=20
>   buffer optional.  This fixes the acceptance test issue.

Hi Robert,

Sorry I didn't get to this in the run up to 4.0. I've tried applying the
series to the current master but I ran into conflicts pretty early on. I
think the first patch conflicts with f01454ad17 because I had already
cherry picked some of the cleanups to gen_cloud_init_iso and then had to
fix it up. Skipping it caused the next patch to fail to apply so I
decided to back away from misapplying the series.

Would you be able to re-spin on current master please?

--=20
Alex Benn=C3=A9e

