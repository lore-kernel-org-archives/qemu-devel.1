Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEBDC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:00:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA00020657
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtuVLq9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA00020657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvh1A-0002Fj-2d
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 09:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvh0G-0001SN-Ru
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 08:59:16 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:41587)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvh0F-0002KG-Gq
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 08:59:16 -0400
Received: by mail-wr1-x436.google.com with SMTP id z15so2563948wrl.8
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 05:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gXNZetBqYaNt6360jVSUjUE/5Cw+9pzm29r+5cK1vXc=;
 b=QtuVLq9doqSwwIIZR/x14kvCQ1EVoBr4bUFO+sMIo4SZqRynJ1iJb3sqjTAhAcdSiD
 LXb6tBnSIL2xpi0veXb3EOu8ZNGsB0qoX3HwV07Of8NvMWBJdjMs07/8MrJm244TYDQ9
 Us99zKlaL3IxPjQ5tcsZCQjcjmFtn1q1u37y1Gxt7XZqDpv8UnKS2fsJVYZwTzb1Pewt
 Xg/ZeAwHTDLn3pknrAXDAxIadCBChgouzefkNmWDeeeDRzFgVjE9bsWbskWptJ7Z/3YP
 H3xl0uv2qDD/byAB7YPACNDoBawFaym/q7TCsPVrmlsflcaUGZkrpE0yxG5KPobD4qhK
 7h2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gXNZetBqYaNt6360jVSUjUE/5Cw+9pzm29r+5cK1vXc=;
 b=HPStG2Hah7xdC+sLFntAfu5UrpWoBURG7QIVPjP55jpn1SG62S8mAeoXpNSG5+RZ+T
 IMHIz9sHZ7SBgvMNo91fnbuOE1w/jCP/TILUpXNdJvw/Pn/csoENbMDyhtVPQYGZcwKl
 Ch+vtRQkjfpO/2xPGUU181DusC++L+zIDm1g6haQvocqDa+JFk2rJrLluqqD7OprgENw
 +NXK+71SY5aZ+2sPiKO7htQeGHVWZeKIRmaNc2hbm7O30x2VeCuEwOaOlBlqrywonX4e
 HoUvjv9Rg0ugmHQ96NWvQ6vKYiYQHI7JZmht8NCwLqzb2bTTsPXMsAi77Yd8B8DL6Xtv
 6cmA==
X-Gm-Message-State: AOAM531NWvkZ6DEHAbTIWYrMwqjrGknyECjpMy5McPtPqXRWIly+d2vU
 2DTNhNYhpwAdwK0grVU3Z3LiAb+ht+o=
X-Google-Smtp-Source: ABdhPJzUJFBjqiri2GK0VcT1ugThNp/sWyqf2ehH2SbCR/tOBh1Gges5w4l8iU5QJftAFjXFibOUyA==
X-Received: by 2002:a5d:5151:: with SMTP id u17mr11489541wrt.154.1594817953764; 
 Wed, 15 Jul 2020 05:59:13 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id p17sm3124346wma.47.2020.07.15.05.59.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2020 05:59:13 -0700 (PDT)
Subject: Re: [PULL v2 0/8] final misc fixes for 5.1-rc0
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org
References: <20200715105542.14428-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <625ac860-b1b9-f204-1737-b9deaeb47e94@amsat.org>
Date: Wed, 15 Jul 2020 14:59:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200715105542.14428-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 7/15/20 12:55 PM, Alex Bennée wrote:
> Dropped configure patch

Ah, after looking at v1 I was going to suggest there is
probably a dependency issue with the configure patch, we
let old objects in the directory, make doesn't source .d
and doesn't rebuilt them.

