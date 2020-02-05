Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D00C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 16:36:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6247720702
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 16:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVjj2fmG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6247720702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izNfX-0004vf-IG
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 11:36:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1izNeB-0003cC-Fr
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 11:35:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1izNeA-00013H-Gc
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 11:35:27 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:46908)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1izNe7-0000cz-Pc; Wed, 05 Feb 2020 11:35:23 -0500
Received: by mail-pl1-x641.google.com with SMTP id y8so1075684pll.13;
 Wed, 05 Feb 2020 08:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=jRh4q/Ba/QCpeEew0nFMRFuVZIQDzbCuo4yMPgsxAs8=;
 b=BVjj2fmG9K7mqNhdRARDagKjmwv0HxecaX1LU34Q/haT+XFckst2IsxyxhzEZ9XqQF
 gltlDQJODgho2hCbv0rtkEmYrWVXK2KRAW5Rei6kadiwFQT5FtjPAf1tJHrGpnBGCYv3
 YZRLyFcvHqM7ov1pddcbf42j7MCP/Gx5D7d515GtRVv55R8DpxSW4ah9dbonpyMeDT06
 Do0tBaGa1E41mbyQUrHhEgZEI3r0/YVGBAZZrKSTOYxefotbudWrE1o0o6I712ZNlKRn
 ElnYTiy59wCRXVBBG2BsdLAZJMvogEqVioWup8NLv+mA0+axmlI9FFJjHIHb2+v9jF44
 biSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=jRh4q/Ba/QCpeEew0nFMRFuVZIQDzbCuo4yMPgsxAs8=;
 b=nfz3MV76pkPoqype5YmLz79xqYOXA5bCidZExd4VPqLKafHFUMVmCh73BEx8nW6rpq
 kZulhgC7D2edOWAkaD5ICgV7EzkNhg9pMHD/yzEztg+88HqDh9cJ9tgnTORX61E/0Zik
 8FmwqKbFIyv+B6VzLaeheA492vfw47jr3ta3w6Y2zEAYmbN4VQUmcm+5fSU+Fl0llnwN
 +MwV6/dc4DAudSU/BHMW3HWHTxIhWT5ji/M3+BisDvxBI47zVb1UIn0tIrGdYP2pkGAb
 JcQ9ArsBAUIZ9Ewca72RPnZ9EmaS3+qt5Y5zJloHbxREg53lKjr+t3D1NVJGV8ZhgmdU
 U5sQ==
X-Gm-Message-State: APjAAAVQDOi2NI/ixP7Xj9pZb4wOQpwjJCaf8g1BYVeFratt17kkWv1D
 qlxRRRjuHxty8y7Zn0GJGRQ=
X-Google-Smtp-Source: APXvYqwZkAfh0Wx6tS554LxMvEvz1GdJTay6ABW18vlOk2c1/6fwGc2zbhSJHWuqDqxhNboILsUKKQ==
X-Received: by 2002:a17:902:6bc3:: with SMTP id
 m3mr18082067plt.27.1580920522546; 
 Wed, 05 Feb 2020 08:35:22 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id 28sm306578pgl.42.2020.02.05.08.35.21
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Feb 2020 08:35:21 -0800 (PST)
Date: Wed, 5 Feb 2020 08:35:20 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 1/3] m25p80: Convert to support tracing
Message-ID: <20200205163520.GE25403@roeck-us.net>
References: <20200203180904.2727-1-linux@roeck-us.net>
 <615518c7-f4c8-7c08-9096-bcf5f583eeb1@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <615518c7-f4c8-7c08-9096-bcf5f583eeb1@kaod.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 05, 2020 at 11:05:04AM +0100, Cédric Le Goater wrote:
> On 2/3/20 7:09 PM, Guenter Roeck wrote:
> > While at it, add some trace messages to help debug problems
> > seen when running the latest Linux kernel.
> 
> In case you resend, It would be nice to printout a flash id in the tracing
> else I have a patch for it on top of yours. It helped me track a squashfs
> corruption on the Aspeed witherspoon-bmc machine which we were after since
> 2017 or so. It seems to be a kernel bug.
> 

I'll send a new version to split patch 2. Not sure I understand what you mean
with the above. If you send me your patch I'll be happy to merge it into mine,
otherwise we can just keep it as follow-ip patch.

Thanks,
Guenter

