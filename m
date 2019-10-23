Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8125CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 14:52:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51A0A2086D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 14:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o3BtT8f8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A0A2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNHzg-00008T-17
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 10:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNHxA-0007Qw-O2
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:49:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNHx8-00021w-KB
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:49:36 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:39001)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNHx5-000212-GU
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:49:32 -0400
Received: by mail-qt1-x844.google.com with SMTP id t8so15131839qtc.6
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 07:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1vUml2yPaZYwill4zJoPkUXYGGGkcBcMmR85Vn9D5DU=;
 b=o3BtT8f84rveB49Y9EN1ZNQnHnst6kdVDEDk8hFc94avzAvrmi3FNmneknvcTXX2NB
 GCdcjWwnPZgjG1GVNas9aiztpB3I88qcBjgOBSVpJAbxp9FSPehXrkxEcKHfp24jX8UG
 kRSmzBAG4OnHy5vW03NvvKXc2iX//gyo9/ZtpTJjMBZ124aaBt2gVRxLyuiATUYsr9Qz
 vyCq0fF4s96Yx08wrby9xkbyeV4aIA/eYhhDYkCvUj2Llnl2RmtPXdqGruNnsA9ITW2t
 OZpuNuP7mh3DYCLUhz4RHegGqogU6eaXoZXfUfTu349hkq3E6gDovIXvcucCP9We8ULc
 0vsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1vUml2yPaZYwill4zJoPkUXYGGGkcBcMmR85Vn9D5DU=;
 b=ldFzmpaa/5nsc2Zhd4amF442/qRJiUns1f/CZohX4aZOzyTH1ta4VI9r5MRKV7QXji
 /Ezn2TmovoqG9asuMxdxmJhvdu2kH76xYQQMpY8dWw0sv7i2sUPV91ZHp3D8j0lHzWsJ
 NUrFWlR23deadNjcK3gAYSGShLDwi29nNooImMTQ1idie8nv+zV10EissViCiOrtTRIl
 wGDwvQi5qA3y6E0nt+QYxGVjM0lBjRvadiu4/8bR5twml1yBp+S7ATknaNma5ELpCIRr
 2Z0B/lGQoinhv6EC3dcPZdF84aLxU0btgSFTEhKFu92O4rUs6Key+bPfO+wzIMWk5cXO
 +A/g==
X-Gm-Message-State: APjAAAWEFKpWQp6tjSR0aRvacKr1r38J724Zh20cNG0cRcXMwx67ps5C
 d7lgZ8LqUbF6hc2X7JjnQuK/Ow==
X-Google-Smtp-Source: APXvYqwBoxpfdc2uKmWtwubsHwoglT8dLEQpqe2m3K/XmG0So2kppnUT0h7ecwtNbf7OI50dyv6o+Q==
X-Received: by 2002:ac8:1207:: with SMTP id x7mr9572821qti.255.1571842168131; 
 Wed, 23 Oct 2019 07:49:28 -0700 (PDT)
Received: from [172.20.87.163] (rrcs-172-254-253-50.nyc.biz.rr.com.
 [172.254.253.50])
 by smtp.gmail.com with ESMTPSA id h129sm3781267qke.49.2019.10.23.07.49.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 23 Oct 2019 07:49:26 -0700 (PDT)
Subject: Re: [PATCH v8 00/22] target/arm: Reduce overhead of
 cpu_get_tb_cpu_state
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191018174431.1784-1-richard.henderson@linaro.org>
 <CAFEAcA-MyKoA63UF6DYQ6J-dKihYn9iyG09eFCgWT8j4OqsQnw@mail.gmail.com>
 <CAFEAcA-Xj-6CdVzgfcVONipApD5b5PZ84nPnvbbOQjQkqQLnqA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <6e06dede-2470-92e1-eba9-40646ed56af0@linaro.org>
Date: Wed, 23 Oct 2019 10:49:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-Xj-6CdVzgfcVONipApD5b5PZ84nPnvbbOQjQkqQLnqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/22/19 11:38 AM, Peter Maydell wrote:
> Turns out this asserts in qemu-armeb :-(
> 
> /home/petmay01/linaro/qemu-for-merges/build/all-linux-static/armeb-linux-user/qemu-armeb
> -L ./gnemul/qemu-armeb armeb/ls -l dummyfile
> qemu-armeb: /home/petmay01/linaro/qemu-for-merges/target/arm/helper.c:11267:
> cpu_get_tb_cpu_state: Assertion `flags ==
> rebuild_hflags_internal(env)' failed.
> qemu: uncaught target signal 11 (Segmentation fault) - core dumped
> Segmentation fault (core dumped)
> 
> Dropping this series again for the moment.

Argh!  I had forgotten that we have no testing of armeb in check-tcg.

Yes, I see now that we need a recompute in linux-user/{aarch64,arm}/cpu_loop.c
specific to TARGET_WORDS_BIGENDIAN.


r~

