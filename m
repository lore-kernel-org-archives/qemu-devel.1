Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C488CC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:21:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F27720578
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F27720578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1ZDy-0005bU-OS
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 12:21:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j1ZD9-00057b-TL
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:20:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j1ZD7-00080G-8g
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:20:34 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:52113)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j1ZD6-0007yT-Iy
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:20:33 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MLRgp-1ijci30e2d-00IRWG; Tue, 11 Feb 2020 18:19:52 +0100
Subject: Re: [PATCH v2 4/4] linux-user: fix use of SIGRTMIN
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200204171053.1718013-1-laurent@vivier.eu>
 <20200204171053.1718013-5-laurent@vivier.eu>
 <CAFEAcA_9BGGr7uCqjT7R2jKSWXd6dZkxhtFvgEe4pGOXVbpW_Q@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <bd17f315-19b0-ab7a-7625-185e8de1b90c@vivier.eu>
Date: Tue, 11 Feb 2020 18:19:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_9BGGr7uCqjT7R2jKSWXd6dZkxhtFvgEe4pGOXVbpW_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:5TbFwKwpNNKw5gfKBk2W9nG44I0FBn1m1r3qyBlzdoggON01eWc
 Mbpf50faHqXzqARYaRBww7Z3gJxQApuDstQb5bCscL3D89/iFV8SJjFVXhbx5Fsp7+OUhu+
 D8f5rL/V+IsvOalyub3m6+cb8xaHpZSYm9AmVs80jndnn+wOfaFUaqimWxpq2s4DD/aJcIP
 8xKg2dGsmDIifVuaAJUyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kEJ14NwTp40=:Imv+z0XcP5u7qboZRgwicC
 Pld0CQjxVg8qtaM0x2Q9J5+iKz3vC1xKNJcR83vUjPTH+SiB0mJ5icfn4EBcxcWQluB9zRo3m
 KgSU9JbLpsjXorIboOQiCuZf2c4sRlYMjpV4symLVxXU1dWrgzHagUwLe4t5EN+YstVY+g7HV
 Uj5J1XNWNNs8B9eyBTw1N2/y+6hvK+B7ftQQB/Jmxeu4TICja/Z9MFqFyUCcExphJjYaFbIpD
 EE0QmCGHAAsyVi2PMiBBuyInfgwifLsle9cj+Yf1AuIvkMPJmQEngNxt3B0I0yGFDzwI5R5gJ
 h1oMZKjDOAlYeAWvlfujETlUqXkKiF+2SrwaBiP3x/0nj1QG0skOl3fRbux1ys4WCNnxgxifT
 2FCCs0PSNYMfzyad7H6DOi+76owbdY/OEWhMGELA313SfyzfYo6bVm0hLB8VJc+R3MoG2Xrqj
 02dLGkrISXITOju/b3LtO+uTAVx4UyZPF5wZLDrc9LEXas2tHsXgklPNNk+UjRf71ir390jIA
 Q8JeJ37rIeByKWB27AFqgZ8/mnT3PaRqNmSLAckEF9cY2SVEdricuj/xInQ4icBoKwiryLF8t
 QBGZRyshFsw4snGzNfqlFVG5W+QmkQoRwRcDwES//sqsJ9myrM6y4FkzSCdslhMXVN8Ouipoe
 1jGCl+jUZmnTqrpo2DrSY6NVgSOeAS09RNCCh8pln64hix09r6RkKABgVVO0ep9JzGeHgaXc3
 dEiW3RV5aP/6kRhhctq3w4BcTthQUpOCNVSasuijs8nlMbKuMsmwO8EItHskvNiof1upYbSYj
 HFOJF4dv/ASB51FqiddUNm2w8PW+HxnB0hU3VTvPkfoURscEr9Z1P8P2EI2SYbwLmtm9/YX
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
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

Thank you Peter,

I will address you comments and send a new version of the series.

Laurent

Le 11/02/2020 à 18:05, Peter Maydell a écrit :
> On Tue, 4 Feb 2020 at 17:11, Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> Some RT signals can be in use by glibc,
>> it's why SIGRTMIN (34) is generally greater than __SIGRTMIN (32).
>>
>> So SIGRTMIN cannot be mapped to TARGET_SIGRTMIN.
>>
>> Instead of swapping only SIGRTMIN and SIGRTMAX, map all the
>> range [TARGET_SIGRTMIN ... TARGET_SIGRTMAX - X] to
>>       [__SIGRTMIN + X ... SIGRTMAX ]
>> (SIGRTMIN is __SIGRTMIN + X).
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
> 
> In general I think this is a good approach to trying to deal
> with this long-standing issue in a pragmatic and not too
> complicated way, so thanks for writing this patchset. I have
> some fairly minor comments on the code below.
> 
>>
>> Notes:
>>     v2: ignore error when target sig <= TARGET_NSIG but host sig > SIGRTMAX
>>         replace i, j by target_sig, host_sig
>>         update signal_table_init() trace message
>>
>>  linux-user/signal.c     | 37 ++++++++++++++++++++++++++++++-------
>>  linux-user/trace-events |  3 +++
>>  2 files changed, 33 insertions(+), 7 deletions(-)
>>
>> diff --git a/linux-user/signal.c b/linux-user/signal.c
>> index c1e664f97a7c..e7e5581a016f 100644
>> --- a/linux-user/signal.c
>> +++ b/linux-user/signal.c
>> @@ -498,18 +498,23 @@ static int core_dump_signal(int sig)
>>
>>  static void signal_table_init(void)
>>  {
>> -    int host_sig, target_sig;
>> +    int host_sig, target_sig, count;
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
>> +    for (host_sig = SIGRTMIN; host_sig <= SIGRTMAX; host_sig++) {
>> +        target_sig = host_sig - SIGRTMIN + TARGET_SIGRTMIN;
>> +        if (target_sig <= TARGET_NSIG) {
>> +            host_to_target_signal_table[host_sig] = target_sig;
>> +        }
>> +    }
> 
> So the effect of this is that we now support target signals
> starting from TARGET_SIGRTMIN and going up until we run out
> of host realtime signals that the host libc hasn't reserved ?
> That seems reasonable, since glibc at least uses only the
> lower 2 rt signals and probably nobody's using the upper ones.
> But this would be a good place to have a comment explaining
> the limitation (and that if it needed to be fixed we'd have
> to multiplex guest signals onto a single host signal). You
> could also mention that attempts to configure the "missing"
> signals via sigaction will be silently ignored.
> 
>>      /* generate signal conversion tables */
>> +    for (target_sig = 1; target_sig <= TARGET_NSIG; target_sig++) {
>> +        target_to_host_signal_table[target_sig] = _NSIG; /* poison */
>> +    }
>>      for (host_sig = 1; host_sig < _NSIG; host_sig++) {
>>          if (host_to_target_signal_table[host_sig] == 0) {
>>              host_to_target_signal_table[host_sig] = host_sig;
>> @@ -519,6 +524,15 @@ static void signal_table_init(void)
>>              target_to_host_signal_table[target_sig] = host_sig;
>>          }
>>      }
>> +
>> +    if (TRACE_SIGNAL_TABLE_INIT_BACKEND_DSTATE()) {
> 
> This isn't the right way to conditionalize expensive stuff
> that's only used in trace events. You want to use
> trace_event_get_state_backends() (see docs/devel/tracing.txt
> for details).
> 
>> +        for (target_sig = 1, count = 0; target_sig <= TARGET_NSIG; target_sig++) {
>> +            if (target_to_host_signal_table[target_sig] == _NSIG) {
>> +                count++;
>> +            }
>> +        }
>> +        trace_signal_table_init(count);
>> +    }
>>  }
>>
>>  void signal_init(void)
>> @@ -817,6 +831,8 @@ int do_sigaction(int sig, const struct target_sigaction *act,
>>      int host_sig;
>>      int ret = 0;
>>
>> +    trace_signal_do_sigaction_guest(sig, TARGET_NSIG);
>> +
>>      if (sig < 1 || sig > TARGET_NSIG || sig == TARGET_SIGKILL || sig == TARGET_SIGSTOP) {
>>          return -TARGET_EINVAL;
>>      }
>> @@ -847,6 +863,13 @@ int do_sigaction(int sig, const struct target_sigaction *act,
>>
>>          /* we update the host linux signal state */
>>          host_sig = target_to_host_signal(sig);
>> +        trace_signal_do_sigaction_host(host_sig, TARGET_NSIG);
>> +        if (host_sig > SIGRTMAX) {
>> +            /* we don't have enough host signals to map all target signals */
>> +            qemu_log_mask(LOG_UNIMP, "Unsupported target signal #%d, ignored\n",
>> +                          sig);
>> +            return 0;
> 
> We should have a comment here mentioning why we don't return
> an error code here (and explicitly noting that the Go runtime
> is the major one which we don't want to upset).
> 
>> +        }
>>          if (host_sig != SIGSEGV && host_sig != SIGBUS) {
>>              sigfillset(&act1.sa_mask);
>>              act1.sa_flags = SA_SIGINFO;
>> diff --git a/linux-user/trace-events b/linux-user/trace-events
>> index f6de1b8befc0..0296133daeb6 100644
>> --- a/linux-user/trace-events
>> +++ b/linux-user/trace-events
>> @@ -1,6 +1,9 @@
>>  # See docs/devel/tracing.txt for syntax documentation.
>>
>>  # signal.c
>> +signal_table_init(int i) "number of unavailable signals: %d"
>> +signal_do_sigaction_guest(int sig, int max) "target signal %d (MAX %d)"
>> +signal_do_sigaction_host(int sig, int max) "host signal %d (MAX %d)"
>>  # */signal.c
>>  user_setup_frame(void *env, uint64_t frame_addr) "env=%p frame_addr=0x%"PRIx64
>>  user_setup_rt_frame(void *env, uint64_t frame_addr) "env=%p frame_addr=0x%"PRIx64
> 
> thanks
> -- PMM
> 


