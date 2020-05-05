Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB64FC47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:37:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92609206A4
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f17EbuiS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92609206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVuwo-0001NU-NX
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 06:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVuw3-0000gn-SL; Tue, 05 May 2020 06:36:23 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40795)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVuw2-0000mQ-QJ; Tue, 05 May 2020 06:36:23 -0400
Received: by mail-wr1-x441.google.com with SMTP id e16so2115374wra.7;
 Tue, 05 May 2020 03:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sklmjy3eA+wxj59B/HeXK/747r+mSrWS964aHUgV2lo=;
 b=f17EbuiSkA+BazVWyFvtm53SDrQe2ieCrzLCjMj+oSl78CnMmkIM8ZJh9HxAlinj4q
 pKdnyiK4uAEO9OsONCkfbz5SiHviufO42U0b79KbQx+fwQgHvwxBnD8idQc/pycC9EwY
 dBPewcB9OiUTU+A/kvqTn7mQPATfi7Rk9VO/VXcQa7zkpiQYI7jJ+lM9vx6C/J1+FY5W
 61/DXaqvPIq/q+lJ5FIkvEqAI+EuYwcAHN3pg58QmQgnO9NMeeUgRqP1x0p4wilxOKD5
 wUHOSoGluXYemeJ56Cw5elEwAw039VGvf3Z5Azd9WXYEIGvljSwYSYZOGV23RmAA3Hmt
 sLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sklmjy3eA+wxj59B/HeXK/747r+mSrWS964aHUgV2lo=;
 b=ff8q/eOPTPneLgq9ENBMhoRqUFpJq1cRsWyTyGebxedNAz/ehJ15oRWb+xMHavSVod
 ePXMK18/7XNfsfdc/JrVjErj/UZRNMcGfkgvToKuijqDxrdS5aI3TpjuvtlzmMyJjqxg
 HEw+C3JNgNwbJGOKGT6IBYGmK0ELC0xZ+DN2fRadUG8uPI+rhm6rrCm7/DzwTss1KozH
 6nkI6VN6ryuoNlM+AmHRz5H6MxaqBujCARnmKgGvNJK2HURDhNsq/Ub/1CxImUWId1I3
 cCtOzLYzyN8DjOXtuk4hWYZl0le7dy3gSGcRGgR8PKnem+lly4CzufT1fMvfMzHb+4Pa
 ZXQQ==
X-Gm-Message-State: AGi0PuYrbkIa7BKfEFQ53h3dhr8+OLHd8cCz+rsHwjQyLLH55CV1c7tG
 wokmvf4bAGBkcuEqPrOcrzA=
X-Google-Smtp-Source: APiQypL8WdQMX19fALBss6Xbp/NGFu5wzc47ZYNIdhMmdQe9Kkw0DmNqWgvwcluTcT1sqjr64GCJ7w==
X-Received: by 2002:adf:82c1:: with SMTP id 59mr2809240wrc.377.1588674980969; 
 Tue, 05 May 2020 03:36:20 -0700 (PDT)
Received: from [192.168.1.38] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id p7sm2630504wrf.31.2020.05.05.03.36.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2020 03:36:20 -0700 (PDT)
Subject: Re: [PATCH V2] tests/Makefile: Fix description of "make check"
To: Huacai Chen <zltjiangshi@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>,
 Markus Armbruster <armbru@redhat.com>
References: <1588674291-6486-1-git-send-email-chenhc@lemote.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6c0fbc8f-e838-16e8-083c-6390c4fd2938@amsat.org>
Date: Tue, 5 May 2020 12:36:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1588674291-6486-1-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: qemu-trivial@nongnu.org, Huacai Chen <chenhuacai@gmail.com>,
 qemu-devel@nongnu.org, Huacai Chen <chenhc@lemote.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/5/20 12:24 PM, Huacai Chen wrote:
> The description of "make check" is out-of-date, so fix it by adding
> block and softfloat.
> 
> Reviewed-by: Claudio Fontana <cfontana@suse.de>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>   tests/Makefile.include | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 03a74b6..5d32239 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -4,7 +4,7 @@
>   check-help:
>   	@echo "Regression testing targets:"
>   	@echo
> -	@echo " $(MAKE) check                Run unit, qapi-schema, qtest and decodetree"
> +	@echo " $(MAKE) check                Run block, qapi-schema, unit, softfloat, qtest and decodetree tests"
>   	@echo
>   	@echo " $(MAKE) check-qtest-TARGET   Run qtest tests for given target"
>   	@echo " $(MAKE) check-qtest          Run qtest tests"
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

