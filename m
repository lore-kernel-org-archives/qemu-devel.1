Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A566FC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:39:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BBA22084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BBA22084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyyQR-0008Ko-Mw
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 08:39:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iyyPp-0007os-Bi
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:38:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iyyPo-0000w8-0f
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:38:57 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:38027)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iyyPn-0000tJ-Nq
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:38:55 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MvJjz-1jpYtc39e5-00rEtL; Tue, 04 Feb 2020 14:38:33 +0100
Subject: Re: [PATCH 4/4] linux-user: fix use of SIGRTMIN
To: Taylor Simpson <tsimpson@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20200201122746.1478003-1-laurent@vivier.eu>
 <20200201122746.1478003-5-laurent@vivier.eu>
 <BYAPR02MB4886C76B91E2A07B47F819A9DE000@BYAPR02MB4886.namprd02.prod.outlook.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <cc98bc69-5330-3708-901e-a4434013e59f@vivier.eu>
Date: Tue, 4 Feb 2020 14:38:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB4886C76B91E2A07B47F819A9DE000@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:F5WQV7iEK/lmSCVvabcXuOloPrKt9WYdv7OTTEzf5ZTcD58wYea
 1p2NuWZzbqtQw3nxcKEzK9qjud0kuXC71p5FU7jaTQBEnmjXUB8HZcEBsDyaijDhrRX3Lw0
 WKJnNcrGhHUTwFfwX9igOc26Qq67YLECXIw1Tm7PTCB40GaCxNO4dl4Sd9modMoa4HbPdh7
 eV3O1aQeF3hLM96ni7lnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:14spSIulMiU=:wN1YdMQRIkL8O/6ZCz3WFc
 4gkLOefQCQcTbkt05600uhXLWIbkagXqE0DEHkaRjRlUvJGqd5RZoXtg7lnBeb2j4OjgBDalx
 7V+WgfU4qjCb3fjvgzs8rr80eP3YUv3U1Uw1oJIxNH++cBImt1f8o0VVdFzDOJg0Pvs18yCc6
 iNk5YHsta5LomzztM0hPn7TyfTUMB/grxfWmoB23aTRjG8okB31HjFb11iERLng4uxhH9Cvcs
 OoxmUBWasx/+4cBAJ+H3ASMSidJsvpiDY9DoHl5vFBiGuI44w5qBpaQnW5gwi1QO3iNH/SS7F
 UkaxuqRNsdOni3D6EiZ3PXMShB6ftIWSoB4yxNbYXTvwSAe68t+y8+ocqgzn8aiI24jkdEwTI
 ZIN9jilekdiFpazHfHESns2p3CJ0mjxOxWKk7cNn8YebkBnWPNnNsVvdmP4Nfy6mja6C9yCBZ
 sPdXkzLegEMQM7YsXUUYF2ZM2UYLoRuI7fi4TWO8lVna3buWvxKZw9rF5cqYdl8f5W2D4mwVD
 p2CZ4WQ6B0VrW1amXlr3w6QNnuGbQ8PMCox7pYj/DW2SE9LrRUul37+Os/9/YAe2MAMaz89JN
 AvJiaJWHPNo676WCGRfsHfAtiKpmd5mIEQvf50VuZJHXrQZtNN48F2FwodsdCHnQlVoTyPlbI
 f6CZXXWLdlv8fU1s66cSt/mHZWxJ25Qc43Ha/GAOhlkc5mkmKQJNCYOie4PhR8wDP/HjLMSv1
 XDTYSMqjggn4hA09Sc0j4WF8PqxKi1UG2SB2xzacnYhVeFwG6mP+51vP2qJNNxbBJsCGI74eR
 DTKR4ogYtBW0m4Vjb0LxNSDszokhitCaRaftfvIs0CSKfnuCotCt9u/+JEtqvd6lGdQRXt4ix
 O1EZ8KgU098lMrd+g1DIFJZHqQuQ63vkEZXjrVGe3A1sBRaRXfybkvBY7G+ODA
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

Le 04/02/2020 à 00:15, Taylor Simpson a écrit :
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
>> Subject: [PATCH 4/4] linux-user: fix use of SIGRTMIN
>>
>> Some RT signals can be in use by glibc,
>> it's why SIGRTMIN (34) is generally greater than __SIGRTMIN (32).
>>
>> So SIGRTMIN cannot be mapped to TARGET_SIGRTMIN.
>>
>> Instead of swapping only SIGRTMIN and SIGRTMAX, map all the range
>> [TARGET_SIGRTMIN ... TARGET_SIGRTMAX - X] to
>>       [__SIGRTMIN + X ... SIGRTMAX ]
>> (SIGRTMIN is __SIGRTMIN + X).
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>  linux-user/signal.c     | 34 ++++++++++++++++++++++++++++------
>>  linux-user/trace-events |  3 +++
>>  2 files changed, 31 insertions(+), 6 deletions(-)
>>
>> diff --git a/linux-user/signal.c b/linux-user/signal.c index
>> 3491f0a7ecb1..c4abacde49a0 100644
>> --- a/linux-user/signal.c
>> +++ b/linux-user/signal.c
>> @@ -501,15 +501,20 @@ static void signal_table_init(void)
>>      int i, j;
>>
>>      /*
>> -     * Nasty hack: Reverse SIGRTMIN and SIGRTMAX to avoid overlap with
>> -     * host libpthread signals.  This assumes no one actually uses SIGRTMAX :-/
>> -     * To fix this properly we need to do manual signal delivery multiplexed
>> -     * over a single host signal.
>> +     * some RT signals can be in use by glibc,
>> +     * it's why SIGRTMIN (34) is generally greater than __SIGRTMIN (32)
>>       */
>> -    host_to_target_signal_table[__SIGRTMIN] = __SIGRTMAX;
>> -    host_to_target_signal_table[__SIGRTMAX] = __SIGRTMIN;
>> +    for (i = SIGRTMIN; i <= SIGRTMAX; i++) {
>> +        j = i - SIGRTMIN + TARGET_SIGRTMIN;
>> +        if (j <= TARGET_NSIG) {
>> +            host_to_target_signal_table[i] = j;
>> +        }
>> +    }
>>
>>      /* generate signal conversion tables */
>> +    for (i = 1; i <= TARGET_NSIG; i++) {
>> +        target_to_host_signal_table[i] = _NSIG; /* poison */
>> +    }
>>      for (i = 1; i < _NSIG; i++) {
>>          if (host_to_target_signal_table[i] == 0) {
>>              host_to_target_signal_table[i] = i; @@ -519,6 +524,15 @@ static void
>> signal_table_init(void)
>>              target_to_host_signal_table[j] = i;
>>          }
>>      }
>> +
>> +    if (TRACE_SIGNAL_TABLE_INIT_BACKEND_DSTATE()) {
>> +        for (i = 1, j = 0; i <= TARGET_NSIG; i++) {
>> +            if (target_to_host_signal_table[i] == _NSIG) {
>> +                j++;
>> +            }
>> +        }
>> +        trace_signal_table_init(j);
> 
> It looks like j will have a count of the number of poison entries, but the message in trace_signal_table_init is "missing signal number".  Is that what you intend?

Yes, poison entries are the entries that cannot be used for the guest.
Perhaps it would be more correct as "Number of missing signals:"?

> 
>> +    }
>>  }
>>
>>  void signal_init(void)
>> @@ -817,6 +831,8 @@ int do_sigaction(int sig, const struct target_sigaction
>> *act,
>>      int host_sig;
>>      int ret = 0;
>>
>> +    trace_signal_do_sigaction_guest(sig, TARGET_NSIG);
> 
> Shouldn't this be _NSIG, not TARGET_NSIG?

No: do_sigaction() takes a number from the guest, so "sig" is a target
signal number, and this trace displays also the maximum value for the
target.

Thanks,
Laurent

