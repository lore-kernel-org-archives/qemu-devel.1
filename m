Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126BDC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 09:12:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 038C6206DA
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 09:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+CdC3D3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 038C6206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2szM-0007Ol-4K
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 05:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k2syf-0006wp-SW
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 05:11:21 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:46787)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k2sye-0006K4-59
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 05:11:21 -0400
Received: by mail-ed1-x541.google.com with SMTP id q4so26068957edv.13
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 02:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=612tIrQzCRmfmbmm1I797E4BNBBpTE41xugv5OMRluI=;
 b=r+CdC3D3B+o7DwERpgczyqroqsxrVDo0oTGvYhZiJw9k0t1epqMaSVz4nohwSwFF+7
 PjZCTJCyYdxjsd2L/7+qBLlyjlrNfGmWm93TtzxweA8eIExI0IjmvHF/NlsJwzrjD1ZI
 T/F9nsRrLaCGKu4J9+d2U1FzCuMNHVeq+1jwmNJoPbsJPQIR6HT1YLXzc7RLoaEFsChP
 0QLTmuKrhWvLdpNAg9lWpLIfY9SJPkprAqXjljpi6mco4J9cVxgEA8ysIZZUS2/oP2Un
 VNwIKyspk3oTo8/gI63Nmy+6NXbNQ76eH3Wq26YwZJ+R+F2I4lUJQTW/sRyALnmSosfj
 ++AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=612tIrQzCRmfmbmm1I797E4BNBBpTE41xugv5OMRluI=;
 b=dd/gnJVWQJ5y9C//c10FqnSkRdh51kef9WEx316m6MbX0UVBACGfryqrBHB8hGUkFr
 aTHcLBbltHo6Ufas7KvAET1AeuUq4ySKzb8mfB6sHLAIznKR0x68LIGa6BYHPkaBsM+g
 YMqDu9gLVi7M69kGgUZ1A137Do388Ed/KL0Q2kqBZhUAtC4KTP0e/UpUWrJAb751ABkP
 ZHETvnSdX/bAJo7JIrOmQGGU/jWgTL9RzIG11S37rduFvCHpGTH1mjewSI5Mlm20CRnf
 EogTvW7eJK6Rh0o5oL32Z8umw9cn/hssQVjjL8ME/D50x8+zDVskEFfGgxUGnn0AaHKs
 PcBA==
X-Gm-Message-State: AOAM5336eS73U8L+YhcfYocS5SCQZFNylRnlwK55+e/uMKJ3fJuEhec8
 5wWYVA6ltyCYhKH4is97HuQ=
X-Google-Smtp-Source: ABdhPJwTmyAMXgFLd6kLo95IEgjxJv36L3pIk4GAC+JvfNeieFWBy6NaWBT/HS47J0zVKX6pYplRMw==
X-Received: by 2002:aa7:d809:: with SMTP id v9mr19601336edq.94.1596532278202; 
 Tue, 04 Aug 2020 02:11:18 -0700 (PDT)
Received: from [192.168.1.43] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id v2sm18644037edb.95.2020.08.04.02.11.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2020 02:11:17 -0700 (PDT)
Subject: Re: [RFC PATCH 3/3] .github/workflows: Use matrix strategy to
 parallelize builds
To: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org
References: <20200804084843.31075-1-f4bug@amsat.org>
 <20200804084843.31075-4-f4bug@amsat.org>
 <3c915f8a-bedc-2a53-6e1e-0c713dcda659@weilnetz.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3017d953-9871-137c-b18a-5b3acd238b13@amsat.org>
Date: Tue, 4 Aug 2020 11:11:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <3c915f8a-bedc-2a53-6e1e-0c713dcda659@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/4/20 11:04 AM, Stefan Weil wrote:
> Hi Philippe,
> 
> just a side note: GitHub action runs parallel jobs by default. I use two
> jobs (32 and 64 bit builds), so both are built at the same time, see
> https://github.com/stweil/qemu/actions.

Indeed... Not sure why my tests ran serialized, maybe I had too many
jobs scheduled.

> 
> Regards,
> 
> Stefan
> 
> Am 04.08.20 um 10:48 schrieb Philippe Mathieu-Daudé:
>> Using sequencial builds, both jobs take almost 2h to build.
>> By using the matrix strategy we can build the jobs in parallel,
>> reducing the total build time to 1h12m (as of v5.1.0-rc2).
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  .github/workflows/build.sh |  8 ++++----
>>  .github/workflows/win.yml  | 23 +++++++----------------
>>  2 files changed, 11 insertions(+), 20 deletions(-)
>>
>> diff --git a/.github/workflows/build.sh b/.github/workflows/build.sh
>> index c430a367be..4f2c6b56f3 100755
>> --- a/.github/workflows/build.sh
>> +++ b/.github/workflows/build.sh
>> @@ -7,10 +7,10 @@
>>  #~ set -e
>>  set -x
>>  
>> -ARCH=$1
>> -DLLS="libgcc_s_sjlj-1.dll libgomp-1.dll libstdc++-6.dll"
>> -
>> -if test "$ARCH" != "i686"; then
>> +if test "$1" == "32"; then
>> +  ARCH=i686
>> +  DLLS="libgcc_s_sjlj-1.dll libgomp-1.dll libstdc++-6.dll"
>> +else
>>    ARCH=x86_64
>>    DLLS="libgcc_s_seh-1.dll libgomp-1.dll libstdc++-6.dll"
>>  fi
>> diff --git a/.github/workflows/win.yml b/.github/workflows/win.yml
>> index 81cf48530f..afd827db8e 100644
>> --- a/.github/workflows/win.yml
>> +++ b/.github/workflows/win.yml
>> @@ -9,26 +9,17 @@ name: Cross build for Windows
>>  on: [push]
>>  
>>  jobs:
>> -  build32:
>> +  build:
>> +    strategy:
>> +      matrix:
>> +        arch: [32, 64]
>>      if: github.repository == 'qemu/qemu'
>>      runs-on: [ubuntu-20.04]
>>      steps:
>>      - uses: actions/checkout@v2
>> -    - name: Build QEMU installer (32 bit)
>> -      run: .github/workflows/build.sh i686
>> +    - name: Build QEMU installer (${{ matrix.arch }} bit)
>> +      run: .github/workflows/build.sh ${{ matrix.arch }}
>>      - uses: actions/upload-artifact@v1
>>        with:
>> -        name: QEMU Installer Windows 32 bit
>> -        path: dist
>> -
>> -  build64:
>> -    if: github.repository == 'qemu/qemu'
>> -    runs-on: [ubuntu-20.04]
>> -    steps:
>> -    - uses: actions/checkout@v2
>> -    - name: Build QEMU installer (64 bit)
>> -      run: .github/workflows/build.sh x86_64
>> -    - uses: actions/upload-artifact@v1
>> -      with:
>> -        name: QEMU Installer Windows 64 bit
>> +        name: QEMU Installer Windows ${{ matrix.arch }} bit
>>          path: dist
> 
> 

