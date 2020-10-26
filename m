Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5069FC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 08:17:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A420620874
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 08:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OtYSkm77"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A420620874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWxgz-0005i3-IT
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 04:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kWxg1-0004sX-3A
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 04:16:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30867)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kWxfx-0007zz-LN
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 04:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603700179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Gj8R/Tq0+m3+CBLYJU7abG+Ea4vDV8t1S7LjzOQKs0=;
 b=OtYSkm77t9DKHpeMUrIq0Pu92cb8HvopE+6KMCWVnQMKezxgFzusXQ5dUugQVZ1QFotzfD
 +6bAWw2MShG0hmI16E9aDTyJkwysUdAsbkqoJqMIJsL7Yc0XWJpv3GiquQpoH2u/KZDRVl
 WE3wolrRbVKsWBWYxv3PVfTVaoZt2lQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-6YQhhQ6VOg6OcWnOGuDXkA-1; Mon, 26 Oct 2020 04:16:17 -0400
X-MC-Unique: 6YQhhQ6VOg6OcWnOGuDXkA-1
Received: by mail-wm1-f70.google.com with SMTP id s25so6031598wmj.7
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 01:16:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TVOmc+XXKDBxmwlmjR0RLzR/w3Op4v4mamp0TBu0JC8=;
 b=K9de85rK9KSirDmbdbnQL0L+n44FgzGYVl65NNWN3SQkwzmkkqtAg2HeiXEm6P3caU
 MYpY1qKnj/eMZiGpW36i/1SsChbRbclajHBWLCVt+cRqYmPAj7jDBKCnox5tkqtTcYVI
 wvLcqoHTZnzRfWBnMj1aaUO2O9iNs38VFRvSMSThFwcccc5Sp1DPRDuwuPzkcS1am4j3
 DelkMy1/1xTNbCNz0s2rzRyC5h64m8LX8KteuoZTw3t/SIOM2yRB0a2MYDl1mYp/u5QF
 MAbdl7B3KXIPuFQ1FnCf06YD3y3XplJROpPBjcqCXQgd5+dDDQei9NuaMWKmvl/p5ox9
 wfgQ==
X-Gm-Message-State: AOAM532HvxIKjeDD3whtXvzzdG+xui1fQFjk6UoDblQl5wxX8z9M4C/j
 vOSHFBI21eyEBjyzhi2av4hfQqDsNYQie9b9weADMXnclUG5b/Wgbphh2lnO7UlQ8RHPl8NGl3m
 9xJps3EVmCCxJHFM=
X-Received: by 2002:a1c:5585:: with SMTP id j127mr12958791wmb.90.1603700176244; 
 Mon, 26 Oct 2020 01:16:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQwWptyQJiAfemjnksVKyte0GZxuPk8aOyx0h1kbLiC092flxLnSF2EcyIKRBq9J0QFOrtMw==
X-Received: by 2002:a1c:5585:: with SMTP id j127mr12958774wmb.90.1603700176055; 
 Mon, 26 Oct 2020 01:16:16 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id c130sm27751360wma.1.2020.10.26.01.16.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 01:16:15 -0700 (PDT)
Subject: Re: [PATCH v2] tests/acceptance: Test case for detecting -object
 crashes
To: Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
References: <20201009202905.1845802-1-ehabkost@redhat.com>
 <8daa726a-a359-c533-acb0-e3294b4c8aa7@redhat.com>
 <20201012031859.GC887538@localhost.localdomain>
 <20201013174611.GA5733@habkost.net>
 <20201013180120.GB1065819@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6280d778-8fcb-346b-b41d-66282d892e42@redhat.com>
Date: Mon, 26 Oct 2020 09:16:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201013180120.GB1065819@localhost.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/20 8:01 PM, Cleber Rosa wrote:
> On Tue, Oct 13, 2020 at 01:46:11PM -0400, Eduardo Habkost wrote:
>> On Sun, Oct 11, 2020 at 11:18:59PM -0400, Cleber Rosa wrote:
>>> On Sat, Oct 10, 2020 at 09:54:16AM +0200, Philippe Mathieu-Daudé wrote:
>>>> On 10/9/20 10:29 PM, Eduardo Habkost wrote:
>>>>> Add a simple test case that will run QEMU directly (without QMP)
>>>>> just to check for crashes when using `-object`.
>>>>>
>>>>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>>>>> ---
>>>>> Changes v1 -> v2:
>>>>> * "Running command:" log message instead of "Command:" (Cleber)
>>>>> * Use universal_newlines=True instead of encoding='utf-8' (Cleber)
>>>>> * Rename devices() to get_devices() (Cleber)
>>>>> * Use @avocado.fail_on(subprocess.CalledProcessError) (Cleber)
>>>>> * Reword test_crash() docstring (Cleber)
>>>>> * Reorder imports
>>>>
>>>> Assuming:
>>>> Based-on: <20201008202713.1416823-1-ehabkost@redhat.com>
>>>>
>>>> I get:
>>>>
>>>>   (1/2) tests/acceptance/object_option.py:ObjectOption.test_help:
>>>> qemu-system-avr: No machine specified, and there is no default
>>>> Use -machine help to list supported machines
>>>> FAIL: CalledProcessError(1, ['./qemu-system-avr', '-object', 'help']) (0.19
>>>> s)
>>>>   (2/2) tests/acceptance/object_option.py:ObjectOption.test_crash:
>>>> qemu-system-avr: No machine specified, and there is no default
>>>> Use -machine help to list supported machines
>>>> FAIL: CalledProcessError(1, ['./qemu-system-avr', '-object', 'help']) (0.18
>>>> s)
>>>>
>>>
>>> Did you influence (test parameter?) the QEMU binary to be used?
>>
>> I'm assuming this was triggered by "make check-acceptance".  I
> 
> The output shows test 1/2 and 2/2, so I don't think it was triggered
> by "make check-acceptance".

I tested it in a build dir configured with:

   ../configure --target-list=avr-softmmu

I will test it again during the week.

> 
>> will change the test case to use '-machine none', which should
>> work on all architectures.
>>
> 
> +1, sounds good!
> - Cleber.
> 
>> -- 
>> Eduardo
> 


