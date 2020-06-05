Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C085C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 18:27:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 659A92074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 18:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyayfARc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 659A92074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhH4B-0004G3-OB
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 14:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jhH3Z-0003Aa-DH
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 14:27:05 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37248)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jhH3Y-0006lh-Pk
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 14:27:05 -0400
Received: by mail-wm1-x343.google.com with SMTP id y20so2293490wmi.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 11:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bTTh4EO+d/slPGFZnFe5fOHEsNGvl1Yatl7sm9mgRlk=;
 b=MyayfARcwnlywzdIIYYIN+m1L1/O09iZ9oG/5P3iBfnBSyl2K+cnCNYzxEUcLvl2Kl
 uPoWk3ny17IZ6Qv/OPDgVan9MDbMo9B6EqnPW44NaRprICGvv/EoJJuMREb2Xm4kFB/e
 pYCZom3/OwRwOQUrK9eDgEhoFIhhJVfLUdwSxaPu1eMsOMGZwhCWZSaFGBStR8MPUu7i
 HobnLzaLFI9JsBtYyAyKD5/TeThwfuqPVWVxFeJMWxDKqEOU3LkxSAkkRNCwRo0hyzJE
 D730mPTs5tO9js2sDtg3J3CYcI3uHwS06qFW+iBSIqAx5l1DRa+aT2bBLxftbsQpNHQw
 6LXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bTTh4EO+d/slPGFZnFe5fOHEsNGvl1Yatl7sm9mgRlk=;
 b=hsJ/jRyY8d46kHcM83F4y8odOf5aQ77ftIY6F2kYAVNqxcE61A6wi4iXLUEdLznrru
 wLSmfO/y42nKWw9ZN4i3+3GjjzkvE1odhu2zaZrKmMaBd7y67xPsZr6DI5rsLREk0KG7
 CyVnVX1uZCpvG1qy4Vm2MdmUKymvqgzLeIMf2Wd1R0geYF+akVXKhhpQcvGdkWPtdu4G
 jGek5G2XRrE68sHnGK46UlE7Ft20ujyeGCoEnEYdmN4EopvFjmhww4Amc6GuIGpWGZHi
 XUvRSs6hvqZ/7ki6b2JRMZpYJCxDjGicAvSl2qG+cpMR3snoPJwcvvkHXjqgpTPMyl4P
 fzOA==
X-Gm-Message-State: AOAM533DZf3l/Vi/0pPpfL2slh5hZ4c9Eh5diQvZJ3QbU8zH6gkCbsNq
 H5hjrEDkJAq7p1h9yHmdAPk=
X-Google-Smtp-Source: ABdhPJx+0oCChnAmo5XsZVczxokYaGrl9wSRIS2zFoxK6ytoD8zqGYnz1HPdbbAhniaUOG/GOzgtBg==
X-Received: by 2002:a1c:3dd6:: with SMTP id k205mr3896711wma.87.1591381623125; 
 Fri, 05 Jun 2020 11:27:03 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id a14sm13693265wrv.20.2020.06.05.11.27.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2020 11:27:02 -0700 (PDT)
Subject: Re: [PATCH v2] fuzz: add oss-fuzz build.sh script
To: Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov
 <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20200605175028.5626-1-alxndr@bu.edu> <m2a71hv1gf.fsf@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c2153590-e318-d232-e3fd-9a8028484762@amsat.org>
Date: Fri, 5 Jun 2020 20:27:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <m2a71hv1gf.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: bsd@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/5/20 7:58 PM, Darren Kenny wrote:
> Hi Alex,
> 
> From looking at another OSS Fuzz project recently (a coincidence) I
> wonder if we could make this script work so that it can be run outside
> of the OSS-Fuzz environment?

Yes, we want to have this feature to reproduce/debug what oss-fuzz does.

> 
> Specifically, for example, if $OUT is not set, then creating a subdir in
> the build directory, and setting it to be that.
> 
> Similarly for some other things like $LIB_FUZZING_ENGINE?
> 
> I'm just thinking that it might help someone that is not familiar with
> OSS-Fuzz to validate that the script still works without having to go
> through setting up the containers, etc that would be required to
> validate it.

Exactly.

> 
> Also, I would definitely recommend running ShellCheck against any script
> to ensure that you're catching any mistakes that can so easily be put in
> to shell scripts - speaking from experience here ;)
> 
> Thanks,
> 
> Darren.
[...]

