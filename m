Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A83C3524D
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:36:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB5FD20730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5FD20730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyyNi-0006ut-4D
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 08:36:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iyyMl-0005wk-0C
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:35:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iyyMj-0004hQ-0d
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:35:46 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:45487)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iyyMf-0004V7-IS
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:35:43 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N6svJ-1jblye33bL-018J9S; Tue, 04 Feb 2020 14:35:07 +0100
Subject: Re: [PATCH 2/4] linux-user: cleanup signal.c
To: Taylor Simpson <tsimpson@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20200201122746.1478003-1-laurent@vivier.eu>
 <20200201122746.1478003-3-laurent@vivier.eu>
 <BYAPR02MB48863971CD9E073FB98B130CDE000@BYAPR02MB4886.namprd02.prod.outlook.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <74a54fdb-6d2c-6912-55fa-b925e4c614d2@vivier.eu>
Date: Tue, 4 Feb 2020 14:35:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB48863971CD9E073FB98B130CDE000@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:opqm33O9Yexu7oP+3FHQfvUpd52I3b8a6lNt067Gk4M4e6xsAZn
 H49WClBgterNWaPnUOZshqnb5bGe9bpUW/lRTM85YvTU3M8ELpg/3DaCLPVzTZUX2bApXfJ
 AjmlG/t1BiyVvRXVS68A3gMZWvbROU17s6kPhGCQHvxYll0iBrmtc/Er8FPhhx42qtHhVql
 ZIgxZNFDr2IwAQK4GEO5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hYU1iT9XJGI=:jX6c87E3Lhl5+nVTwWBcrQ
 ZTgEu1aomiM7KGOvKKVSAl1mqZqV9icp+nQCaRf5A5NKhbmLgdtTFYJcR1W3R0ulVkP8dGW0g
 hUrKGcERiTUHhJ6gvumgpotTvMnQlwnHkZg8vToDCJM3xb8LEgNyNsBO4Q8GhLCao09F3+c0v
 H0FnffFcnxyVsfKVpJgOzpkKA08eCCfcEd6hecMXFEDzUp9DlUXtKQFrpuTHLrAzsYqnAIhKc
 //m2/0oynjb7VzURis2AL30oWBWCTvFcSzCS8Cg4AOl/BRDwe8dy3tRY5Xx/x24wQzDfJAuxe
 Tt9InWfF47rYmTR/3U+HB3itWuGwcJ3FixsJ6jEc/eRJvne6wSvT157UEClZabh/BKg44fr/J
 yzG/S3l9vAbwcl0AwGgi9sc1UGGlPNcWxX09VIqyZLEy8JDUZ+nkMwcTetzvL5ezQ2PaZtnGM
 lbMtX35xlnlIj66qEARaBvbMsyDz8JSy2hj2pvw53PGfevLXl6QDuc5XLybxsE1z3FIjQYLRy
 Esa9wfQpmY9CxSfcAWBERAZBS31nPItLwMIZQUEyyvEPpvSffvpzEGpoPliJYC3P9PfHZUDNi
 PwZORCXBaDN4Dpft7SrHPmaCk3nTFJMYTSK6lntm4ZJQ4/kuO5LOqOK2y7WHGP1i27i1xiest
 1Rw6uXkgtkd4QWEBnNglBxg5xHJMVOULWIdRaZpUIBKnnn1td+6S+7iyFajCZ0GbgCegMtNPS
 Rg5cjOJH8pfKdkfnrYn2T2LVTncyAGt78+ZKWy/5rguxY0NEv+NkIY1uHoXMTUEr9gWqcQUAE
 PXNOjQVaiZVms4LyiSEbUky1n+JLlXTgxHsaF79CMKvubZuHhEIPBUB8e4l5mKXXDXtOHU03R
 q/MlV/5kS+mCsgaTL6AqufZ4JEQvorOVpaQS2iZfWV6aXeIwVhp4gpGfpMiXVE
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marlies Ruck <marlies.ruck@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Josh Kunz <jkz@google.com>, Matus Kysel <mkysel@tachyum.com>,
 "milos.stojanovic@rt-rk.com" <milos.stojanovic@rt-rk.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 03/02/2020 à 23:58, Taylor Simpson a écrit :
> 
> 
>> -----Original Message-----
>> From: Laurent Vivier <laurent@vivier.eu>
>> Sent: Saturday, February 1, 2020 6:28 AM
>> To: qemu-devel@nongnu.org
>> Cc: Josh Kunz <jkz@google.com>; milos.stojanovic@rt-rk.com; Matus Kysel
>> <mkysel@tachyum.com>; Aleksandar Markovic <aleksandar.markovic@rt-
>> rk.com>; Marlies Ruck <marlies.ruck@gmail.com>; Laurent Vivier
>> <laurent@vivier.eu>; Peter Maydell <peter.maydell@linaro.org>; Taylor
>> Simpson <tsimpson@quicinc.com>; Riku Voipio <riku.voipio@iki.fi>
>> Subject: [PATCH 2/4] linux-user: cleanup signal.c
>>
>> -------------------------------------------------------------------------
>> CAUTION: This email originated from outside of the organization.
>> -------------------------------------------------------------------------
>>
>> No functionnal changes. Prepare the field for future fixes.
> 
> 
> Spelling error

Sorry, french word. Will be changed by "functional"

> 
>>
>> Remove memset(.., 0, ...) that is useless on a static array
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>  linux-user/signal.c | 37 ++++++++++++++++++++++---------------
>>  1 file changed, 22 insertions(+), 15 deletions(-)
>>
>> diff --git a/linux-user/signal.c b/linux-user/signal.c index
>> 5ca6d62b15d3..f42a2e1a82a5 100644
>> --- a/linux-user/signal.c
>> +++ b/linux-user/signal.c
>> @@ -66,12 +66,6 @@ static uint8_t host_to_target_signal_table[_NSIG] = {
>>      [SIGPWR] = TARGET_SIGPWR,
>>      [SIGSYS] = TARGET_SIGSYS,
>>      /* next signals stay the same */
>> -    /* Nasty hack: Reverse SIGRTMIN and SIGRTMAX to avoid overlap with
>> -       host libpthread signals.  This assumes no one actually uses SIGRTMAX :-/
>> -       To fix this properly we need to do manual signal delivery multiplexed
>> -       over a single host signal.  */
>> -    [__SIGRTMIN] = __SIGRTMAX,
>> -    [__SIGRTMAX] = __SIGRTMIN,
>>  };
>>  static uint8_t target_to_host_signal_table[_NSIG];
>>
>> @@ -480,13 +474,18 @@ static int core_dump_signal(int sig)
>>      }
>>  }
>>
>> -void signal_init(void)
>> +static void signal_table_init(void)
>>  {
>> -    TaskState *ts = (TaskState *)thread_cpu->opaque;
>> -    struct sigaction act;
>> -    struct sigaction oact;
>>      int i, j;
>> -    int host_sig;
>> +
>> +    /*
>> +     * Nasty hack: Reverse SIGRTMIN and SIGRTMAX to avoid overlap with
>> +     * host libpthread signals.  This assumes no one actually uses SIGRTMAX :-
>> /
>> +     * To fix this properly we need to do manual signal delivery multiplexed
>> +     * over a single host signal.
>> +     */
>> +    host_to_target_signal_table[__SIGRTMIN] = __SIGRTMAX;
>> +    host_to_target_signal_table[__SIGRTMAX] = __SIGRTMIN;
>>
>>      /* generate signal conversion tables */
>>      for(i = 1; i < _NSIG; i++) {
>> @@ -497,14 +496,22 @@ void signal_init(void)
>>          j = host_to_target_signal_table[i];
> 
> Since you are cleaning up this code, let's give this a more descriptive name - target_sig would be consistent with host_sig used elsewhere.

I agree.

Thanks,
Laurent

