Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA51DC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 08:12:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0128219FA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 08:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0128219FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXL5m-0008DT-SF
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 03:12:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47057)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iXL4C-0007dm-36
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 03:10:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iXL4A-0001OI-TY
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 03:10:23 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:54997)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iXL4A-0001L6-Ij
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 03:10:22 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N0WPK-1haoWK18BI-00wTZd; Wed, 20 Nov 2019 09:10:00 +0100
To: Peter Maydell <peter.maydell@linaro.org>,
 Taylor Simpson <tsimpson@quicinc.com>
References: <1574190388-12605-1-git-send-email-tsimpson@quicinc.com>
 <CAFEAcA8AeTgY+3GaN9ZUi-5XtX5jxhqpdOhr3ixYwouWhQOQ5g@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH] Hexagon: Swap SIGRGMAX-1 and SIGRTMIN+1
Message-ID: <e4a52719-fc16-f94a-fb8d-1a4d9e683ce0@vivier.eu>
Date: Wed, 20 Nov 2019 09:09:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8AeTgY+3GaN9ZUi-5XtX5jxhqpdOhr3ixYwouWhQOQ5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RjJezbB6E/PHE9byobqyxXcOtCWFDdKyB9noQLrefNoei25K0u4
 17ajt6RL1wuEdi3x5Idp64fy8lb5+4WjPZqKJgD8gthIOdIcJAP/bf4hrE6rDYfUP9g0gZE
 lpsl3MEszJ8Ss8a3XFRjVWPJERrsmtHHrupNaWuXjtKHGjJMw8ozpc+3HfmQkNIHBgHmfJk
 PusatN1E3iQGDcajJhK/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:a8ejNFrn9+U=:kLlMKbaZ6yjlrPmgAe5P1R
 DXZ0Icrkw17IoaY9EtUCy4EyNYImy40s+XfNJVbwq1WymRNR7MZa6cshNQEUDBNo70TbuG/zs
 4eA8J/e3pcCEeD5zJasOJjuAFW+mlrMLgQeFQZVMqyUIpbnnLKCNd1EGttnHHrmYINHPll6w2
 N7mWJFAPsIB2nigBY6VPLcWjWXp7AkDHTTpL7wGA24stnTytge0djj3GI3O/j+De0RYGjXZbb
 nqgpqAETx0dPqg2wYdFdXnkti6csYPPcMyyHfKkKqX+mVO9RpX10thPUmBChf/Vji1dKoShpc
 Odh6uIiq25bXkBHSBmPbhVNir5HH/LqMPEWaJ5m+yetZDIBdta9N2h4K/JrwPH/dVfuT/h20C
 nDB6JA3/NQOGqMSNodTLPCgzT52GIJMqkw5yTgZyon9SeswRgM1OVjZucr18Qsi8mYqGcpa8c
 BzjPXdvCiqto1FpnIQ2Mz68IxfteCrT9z2VCnVBA2LEq1rb3QEgyn3cFhC6EqvizQAYxPP++j
 MB2Y8ibui5RqLznJj6S3+W3pMihn7YeCHe7Z+8Frt5FuKxa133gaTiVjZ86v/BCLI6kKV5oCg
 5x5+9Ua3FAyZuIIhloeVr9lLFY98/L0+SHYKEjMUxDS7IMJdEiD0iOs4iXoMj1vz7o0y2F4p3
 N+xZq4o/tTBvd8oNf21lzYTTGK3GKhU/2lDCWaEzL3G2ftWLTGXQc3txkOSCe9iI0E9Uobo6W
 8OI6KZg5znVwNFT3DmItAbyx22Y4Hm2uvvcBFgDw1Zqbpow5tN/fqP4Zraty9p2iD38ugg5vi
 MZzTSSRhua/qfyVay2trtURx5S2cLuy40mnvxXOVZT8INOKcbCujWA0Skxk3zU6H9wYH7T4IX
 Oor0tvfr4Bz6RbA3ZZpcgMfOuJlWRnTAdt6OgoBNo=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.73
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 19/11/2019 à 20:31, Peter Maydell a écrit :
> On Tue, 19 Nov 2019 at 19:07, Taylor Simpson <tsimpson@quicinc.com> wrote:
>>
>> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
>> ---
>>  linux-user/signal.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/linux-user/signal.c b/linux-user/signal.c
>> index 5ca6d62..ce3d27f 100644
>> --- a/linux-user/signal.c
>> +++ b/linux-user/signal.c
>> @@ -72,6 +72,14 @@ static uint8_t host_to_target_signal_table[_NSIG] = {
>>         over a single host signal.  */
>>      [__SIGRTMIN] = __SIGRTMAX,
>>      [__SIGRTMAX] = __SIGRTMIN,
>> +#ifdef TARGET_HEXAGON
>> +    /*
>> +     * Hexagon uses the same signal for pthread cancel as the host pthreads,
>> +     * so cannot be overridden.
>> +     * Therefore, we map Hexagon signal to a different host signal.
>> +     */
>> +    [__SIGRTMAX - 1] = __SIGRTMIN + 1,
>> +#endif
>>  };
> 
> This breaks other stuff, unfortunately, like Go binaries.
> (Also, you now have two host signals mapped to the same
> target signal; notice that the existing RTMAX/RTMIN
> is a swap of the two slots.)
> 
> We need a generic solution for this, Hexagon is not the
> only one with the problem. There's a patchset on list
> from ages back that had a suggested approach, but
> it needed review and work.

For the moment we don't have a better solution, Josh Kunz tried to
rework [1] patches from Miloš Stojanović [2] but it doesn't seem to be
an easy task.

So I agree we need a generic solution to fix this problem, but in the
meantime I told to Taylor if he doesn't care about Go on hexagon he can
do this change specifically to his target (perhaps we can have cleaner
approach by containing this change into linux-user/hexagon). And what I
understand is hexagon libc (musl) doesn't work without this.

Thanks,
Laurent

[1] https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg00738.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg05259.html

