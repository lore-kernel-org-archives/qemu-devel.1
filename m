Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD4BC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 08:06:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 277E82225F
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 08:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWNH3kTJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277E82225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVs67-0008Ke-30
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 04:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVs51-0007FL-7d; Fri, 23 Oct 2020 04:05:44 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55251)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVs4z-0006FY-GQ; Fri, 23 Oct 2020 04:05:42 -0400
Received: by mail-wm1-x344.google.com with SMTP id c77so493032wmd.4;
 Fri, 23 Oct 2020 01:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=j+ATAd7gU5GbpSmqvJXEpsQoFScY0uEPaIDF5We6j3c=;
 b=CWNH3kTJKCADomA6FsrKd7KqTYnNYwGtvolrZCQ6z4fE9kUFFxwd6+onkQfqr3eqK7
 MvkeZr29GjRG5Ff6WtSxqTctLBcqVElA/otTeua4UqWtYm3dT66vwAFMXISfsDQwg992
 oLo/wlscSe6+sOg4yKyzmLIhFJpwpF3/hSSXt1bnT4PnTdXBNXYhZ1Su1fiZnPLR2mJ2
 WJ7cOIwV+4xbiXA9hm3ons7UbVlkqUb9pBL8oBGKwf/96VYMK7ujn1ev3dPIhSQ0w5//
 5XasfAYY0JgWdXQ0tZw5DQ0yOrw6GbOOHLdf8RGRRb6dP2C5FaQKOk62T0WyGEVWxFXN
 SWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=j+ATAd7gU5GbpSmqvJXEpsQoFScY0uEPaIDF5We6j3c=;
 b=lhwCjzFP/QIDBv6kd04zThEoB4m/ZuF67H3AjO2pLZLzrkQ1fA9KbO4ltIs4ft7sU9
 6J5q1a0fwpgRRljINlPmdqi7l2yZQHBTYeJAlDMwiLxTvHCY2SWSHaF6IoeK8omzDEwJ
 g4LE3H1zM3iym8GOp23AbpPDG7AaX7F74NmjO3OsiiPUtsDFNrZWVLz3MyWvqxeWwNJ7
 AOCK/6ydTHWFRzWfuyW87+1lQ1o2LuT5qpLFR8e/G2WJH6fZLH9MncQrwmwodzTt4AJA
 vwLfQ+d0MKSYYOZSS0OvK5u1eT+tkEvJ5Tt4KK/qQso2Bub6VGe2e6MZnJ/F48pmoJLA
 YJ9A==
X-Gm-Message-State: AOAM5314xMcpMADqfPhdlNlQybJCT0cFsOGok9uBvvt5wGfa919eNYLq
 O0Egk2JqxmDMXZpMNJbF/tI0YAG7FKg=
X-Google-Smtp-Source: ABdhPJxMnYZeelh1Z7XhchAD0sxMCr/GqnD2OYcXYb1as4EB/699VrNdWOQozqfF9cOdQhivvXNqXw==
X-Received: by 2002:a1c:7d54:: with SMTP id y81mr973505wmc.114.1603440336171; 
 Fri, 23 Oct 2020 01:05:36 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id p67sm1695211wmp.11.2020.10.23.01.05.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2020 01:05:35 -0700 (PDT)
Subject: Re: [PATCH 1/4] tests/acceptance/ppc_prep_40p: Fix the URL to the
 NetBSD-4.0 archive
To: Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20201023073351.251332-1-thuth@redhat.com>
 <20201023073351.251332-2-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <26969abd-f4fa-3793-c3e6-f615d669f7ce@amsat.org>
Date: Fri, 23 Oct 2020 10:05:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201023073351.251332-2-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.107,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-ppc@nongnu.org,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/20 9:33 AM, Thomas Huth wrote:
> The current URL on cdn.netbsd.org is failing - using archive.netbsd.org
> instead seems to be fine.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/acceptance/ppc_prep_40p.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_prep_40p.py
> index 1515561249..e82755c9cf 100644
> --- a/tests/acceptance/ppc_prep_40p.py
> +++ b/tests/acceptance/ppc_prep_40p.py
> @@ -35,7 +35,7 @@ class IbmPrep40pMachine(Test):
>                       '7020-40p/P12H0456.IMG')
>           bios_hash = '1775face4e6dc27f3a6ed955ef6eb331bf817f03'
>           bios_path = self.fetch_asset(bios_url, asset_hash=bios_hash)
> -        drive_url = ('https://cdn.netbsd.org/pub/NetBSD/NetBSD-archive/'
> +        drive_url = ('https://archive.netbsd.org/pub/NetBSD-archive/'
>                        'NetBSD-4.0/prep/installation/floppy/generic_com0.fs')
>           drive_hash = 'dbcfc09912e71bd5f0d82c7c1ee43082fb596ceb'
>           drive_path = self.fetch_asset(drive_url, asset_hash=drive_hash)
> 

Thanks!

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


