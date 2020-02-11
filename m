Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A839C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:03:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E55BE20656
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E55BE20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1YwE-0005ML-0Q
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 12:03:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41950)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j1YtG-0002mD-B7
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:00:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j1YtF-0005aC-34
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:00:02 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:33799)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j1YtE-0005Xn-PF
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:00:01 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M27Bp-1j41ij2YR7-002UAH; Tue, 11 Feb 2020 17:59:12 +0100
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200204171053.1718013-1-laurent@vivier.eu>
 <20200204171053.1718013-4-laurent@vivier.eu>
 <CAFEAcA_BVPRXkhVoq7=r6QsQ+upkg1YbiXEHmoR9R824QcjZ0Q@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v2 3/4] linux-user: fix TARGET_NSIG and _NSIG uses
Message-ID: <8cbf7281-d613-d7fe-9651-20408d54caa9@vivier.eu>
Date: Tue, 11 Feb 2020 17:59:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_BVPRXkhVoq7=r6QsQ+upkg1YbiXEHmoR9R824QcjZ0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sqkptUNmfjslL82mq+EeIWFU16yQ1H6lqEMT0Npyw6WrrauXoTq
 mVEfPIwDZ7WN8qaTtTp+pCSvL7bZUIBsExcnJ2PlTpoh6XSyxAS75hDvLmtc+puAthDmK9Y
 3sWwHDPWibQ7isQw7OvKdfmcj9/EOcoQxAZlaUQXRZwejPdSldBIlzK0+LxL7olfmA6YHI0
 8J+n11u3Tc4bZFXtHsodw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ppn9qBtJUDE=:Z6DlZkXnA2GJJQgKbF++Jc
 EL06gpVlN+kL9c7QHRp5OnzUquNuMhj8Nvz5dlricHQmKcy3BkqHWYHmxEMpwH7TjxVc6WRJW
 wmiLVGRmK32T1EJEZEl7fMxaZOJyEwf4xXE0Y0SAs9eitbLxVW8jbaPwNl7oV0AuxwA/zi76o
 L9t5PcFcVgrOz1dhRBkmcpiCK5OgUMW8BZasLY4sOYCR/SIm4XzsmjiGXFngTVPHgRXO2ZeYk
 b+gvSwtwCAKo8YnmTb9S1FpIk4bVEVsPL8Lco0/gZ7/ZGgvWcruHJmtlhobZ5T/cRLwaIWhRL
 xc9Aeeb/VD6Wmt8EYHTeLVYeh7gFMOppkUxJV+RydmFM+DURJ9TTVOoMlMmFExmp09go/mJq+
 EmuW2K7uLotofm4nYnSkk9URw+ePlHDoJtGD2hPSCEuFyI9Vy5JK5dLKio+odzWmCgxx43Mnb
 8mQCnfsKmDUKsmDJrPtX6xXndQSMRKLjB6bF0fJD6KDDrGJAXvSp+iOb846ue8Px1T9k0Sp6A
 GfJhfG5I1F5AkMJHO3oioLouh9vh2wbZNI8X1WqLu+2O29J22io2x0IeWcCW83b996qDqpWC9
 g99HjqJS2KezaHOQexknotTxGPSJxBjQHOx9CEBG4bw+hRy7BxAi52r9RZs2GTn/oszRUBZPR
 7xUCPDsl92IXw0Flpp6SZ4fIbD41CwLe06pXbDyHiO6w9Rv1XtCjUdByp4wdfYErVm7hlLuGf
 /QHqiUwoTMiRwYwQXWuJdXFVwu8Hf/45xS6L3heqyN+gTHFIyhDKmpsJ3Jnlc/uZ/8/+vP2df
 84KpA4I9ZworFTwIl64/DOSoXUssd7J28/U4JBINcg9cx/OBNqrkO+9oUX/fddAUfgtDFrI
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
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
Cc: Marlies Ruck <marlies.ruck@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Josh Kunz <jkz@google.com>, Taylor Simpson <tsimpson@quicinc.com>,
 Matus Kysel <mkysel@tachyum.com>,
 =?UTF-8?B?TWlsb8WhIFN0b2phbm92acSH?= <milos.stojanovic@rt-rk.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 11/02/2020 à 17:47, Peter Maydell a écrit :
> On Tue, 4 Feb 2020 at 17:11, Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> Valid signal numbers are between 1 (SIGHUP) and SIGRTMAX.
>>
>> System includes define _NSIG to SIGRTMAX + 1, but
>> QEMU (like kernel) defines TARGET_NSIG to TARGET_SIGRTMAX.
>>
>> Fix all the checks involving the signal range.
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>
>> Notes:
>>     v2: replace i, j by target_sig, host_sig
>>
>>  linux-user/signal.c | 52 ++++++++++++++++++++++++++++++++-------------
>>  1 file changed, 37 insertions(+), 15 deletions(-)
>>
>> diff --git a/linux-user/signal.c b/linux-user/signal.c
>> index 246315571c09..c1e664f97a7c 100644
>> --- a/linux-user/signal.c
>> +++ b/linux-user/signal.c
>> @@ -30,6 +30,15 @@ static struct target_sigaction sigact_table[TARGET_NSIG];
> 
> Optional follow-on patch: make sigact_table[] also size
> TARGET_NSIG + 1, for consistency with target_to_host_signal_table[],
> and remove all the "- 1"s when we index into it.
> 

OK,

>> @@ -492,10 +514,10 @@ static void signal_table_init(void)
>>          if (host_to_target_signal_table[host_sig] == 0) {
>>              host_to_target_signal_table[host_sig] = host_sig;
>>          }
>> -    }
>> -    for (host_sig = 1; host_sig < _NSIG; host_sig++) {
>>          target_sig = host_to_target_signal_table[host_sig];
>> -        target_to_host_signal_table[target_sig] = host_sig;
>> +        if (target_sig <= TARGET_NSIG) {
>> +            target_to_host_signal_table[target_sig] = host_sig;
>> +        }
> 
> Why does this hunk apparently delete the for() line ?

It effectively deletes the for() line because I merge the two "for
(host_sig = 1; host_sig < _NSIG; host_sig++)" loops into one.

> Why do we need the if() -- surely there should never be any
> entries in host_to_target_signal_table[] that aren't
> valid target signal numbers ?
> 

we have above the "host_to_target_signal_table[host_sig] = host_sig;"
and host_sig can be greater than TARGET_NSIG.

Setting like this allows to ignore them later in the target as we can
compare them to TARGET_NSIG. This mapping 1:1 in the default case is the
original behaviour.

Thanks,
Laurent

