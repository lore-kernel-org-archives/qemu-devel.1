Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E686BC32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 15:54:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B163E215EA
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 15:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k79NEgN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B163E215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iExzx-0006xh-92
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 11:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35767)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iExqP-0000Fb-Vd
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 11:44:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iExqM-0004Vk-0H
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 11:44:13 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40655)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iExqK-0004Un-7H
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 11:44:09 -0400
Received: by mail-wm1-x344.google.com with SMTP id b24so13268661wmj.5
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 08:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:openpgp:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ol8PZ29Q1f+tqHa7aQPexU0fyFN438PTp9U0ZAG82gs=;
 b=k79NEgN4JT7x8al56BI2S5AcI6Yg88eMN+Tvv7cBktXm8kOFAdRSM4dIBO1XLi8urA
 91J+afcPRV8Se5SOl+7QDH4+dEjYlUO6P0c1IHTEsmJsDVJv4WiqzFbuQpFSM+vRIgFp
 vNzyrcLw+y8qUtbHkixfZijY3JWrtt7l4yuQqmawBom414eTpUDARstso9tfHtJuSIqA
 mQ4GE8uvBN7abcUylWCnzNFgwiksGYaS/Ck+go//0P/clgGbZHBmmoN/K/16EIfiO8VQ
 hf4MOMZe6+2X01tbymR0qGzwbw5SRXa4TBNl5didvsLpj3xBBWcMcNVW03wXIHSMlO8A
 aduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ol8PZ29Q1f+tqHa7aQPexU0fyFN438PTp9U0ZAG82gs=;
 b=UmLVktl4o4b2yFT/Qi9WqfVwVomPLxpsoDCibtsiY7aRRPvDH4rIFTp+IH2GJq8b1Y
 5Coy8EPCK0RtxYDvZkctpJETvUQ51UsepF7x0ejrE3YAmdlvfh5Hgt+wPMJMEpnPWB+b
 YVgQMkMEjQLwgAqIONTgMVPXR+q5ssG3xuxmGLU9wS94UZSyWhWZ8Qs0c0YSWjuLDCnT
 dJqcmCC0nQN/DQ/PqoX5j5DZaAkBkAq5yCyWSMvo/5QM6E496D792xL3Jp0t/NWiTp16
 RQB3/J8lRR21msM05hX4mAV3+VbgQuLN7pLGGQy1gbNGwosP1NIaqdqIN9km1lkQPGmK
 Wt4A==
X-Gm-Message-State: APjAAAXaAYKc560iWpj4JN5d6VSvXN1N5qgG0viKXR4TJhWjmhGglrlD
 d93+eHKSs/D1fa0dSyMVLz0=
X-Google-Smtp-Source: APXvYqymWn+HfW9GA2Vb3z3t1kE4m697hxHuVsjiICoOjPts2Pu8FXNEOphsfFleM3MlbovoZcyzVg==
X-Received: by 2002:a7b:cb0e:: with SMTP id u14mr19461447wmj.115.1569858246677; 
 Mon, 30 Sep 2019 08:44:06 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id t4sm13378424wrm.13.2019.09.30.08.44.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Sep 2019 08:44:05 -0700 (PDT)
Subject: Re: [PATCH v7 0/9] linux-user: strace improvements
To: qemu-devel@nongnu.org
References: <20190915213924.22223-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Openpgp: url=http://pgp.mit.edu/pks/lookup?op=get&search=0xE3E32C2CDEADC0DE
Message-ID: <872209d1-e47c-7385-5581-79c9e243803b@amsat.org>
Date: Mon, 30 Sep 2019 17:44:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190915213924.22223-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/15/19 11:39 PM, Philippe Mathieu-Daudé wrote:
> Hi Laurent,
> 
> Few patches I'v been writting while trying to figure out this issue:
> http://lists.nongnu.org/archive/html/qemu-arm/2018-01/msg00514.html
> 
> As usual with linux-user files, this series will trigger some checkpatch
> benign warnings.
> 
> Regards,
> 
> Phil.
> 
> Since v6:
> - Use ABI types in sockaddr
> 
> Since v5:
> - dropped 'Verify recvfrom(addr)' since failing LTP testsuite (see [1])
> - also define print_sockfd() for bind() (patches #6 and #7)
> 
> Since v4:
> - rebased on master (no change)
> 
> Since v3:
> - addressed Laurent comments
> - added print_sockfd()
> - removed the print_sockaddr_ptr() patch, also the two
>   getsockname()/recvfrom() patches for after 3.0.
> 
> Since v2:
> - display invalid pointer in print_timeval() and print_timezone()
> - do not display gettimeofday() arguments
> 
> Since v1:
> - addressed Laurent comments
> - added 'last' argument to print_sockaddr()
> - reordered series, so patches already correct can get applied directly
> - dropped "linux-user/syscall: simplify recvfrom()" for now
> 
> v1: http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg05855.html
> v2: http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg08216.html
> v3: http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg00411.html
> v5: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02067.html
> v6: https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg01346.html
> [1] https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02807.html

Ping?

