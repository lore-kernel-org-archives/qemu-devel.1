Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A15BC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 16:34:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E1BB20652
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 16:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E1BB20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55600 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMEfi-00035l-EA
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 12:34:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMEen-0002bY-An
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:34:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMEem-0008H3-9P
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:34:01 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:41323)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hMEel-0008GL-59
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:34:00 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1M9nAB-1hRRii1sHd-005qTj; Thu, 02 May 2019 18:33:49 +0200
To: Laurent Desnogues <laurent.desnogues@gmail.com>
References: <877eb86hcf.fsf@zen.linaroharston>
	<20190502145846.26226-1-alex.bennee@linaro.org>
	<765fa2ab-2803-1945-61ea-2e80b2da6072@vivier.eu>
	<CABoDooM+DtCbTTsoYdvAJOOKuybgKUAR1yYmckM1b=dGA10=NA@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <280c5642-725a-ba94-076b-f0bb3b778dec@vivier.eu>
Date: Thu, 2 May 2019 18:33:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CABoDooM+DtCbTTsoYdvAJOOKuybgKUAR1yYmckM1b=dGA10=NA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ofTDa6wLO3mos0MqueTSxBhdE6pLJIfPi4hdJUrzqzcjxtJCq0C
	ZrihmXie8KOkD6LMdu/tIiAWjhixRR71XbbDvLEZzouuCGwXJAkb9t4ouX2DRf3O1/dPpZY
	0u7bcEfyGLRSyz/Yji2gtJLGSnNvSyeNDJqJk33Hi3918FLedHM83y5EYH6jHY9fWGRAYTV
	HW6/YxZfbrRp1dT1b4L4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jM6fah8D9b4=:SE7Wvzcedu//0mIOC/78Yq
	f4aTY3x9t6sWIG1/5qyv7h08sZLhavg0SHyi1qjfPmtiTwkDInSRhvZ4wtychoZ2drhMIl2DT
	FM5yy9Q5dFpg+ekprHcnIClYGwL3gZlE8LQ6rQfUrTrqM8CR6QxlZPEJa31xverk2DuCHzgXR
	+0rlzWm/hPXAkhd/rrdGgg7T7cNlU7PCMZKF5oarUklZWqgNUlAohHJDbHxUbi5idoiboNXvH
	KPru1S0y6Aq+rvTuohwADX5B+b1NYn0HRogbeVfrvcxS1RXZyLyuVh/EbyfNfg06Ce/Ot2kIC
	ri7dEN0AseigHyyxvIwu+ssYXP6hON46YlfVzy3bo/oKj4hl073MUeM/VofrOfauePzQNyIHD
	gIDuq6pzYKNV+SlBsL71r9xAToPkD4+Dhq4ojzvc0sEZFfN8YjbODBiE3CzZDNCTkhF47NIRS
	8FH5kIjzsOlBef5SCX/+U64q/u5RNBJWnwtcj2SoaZ47zaIazu7OyAVsrjx7L8GFz1W2JUtzD
	2kbJjvuyzOK8pDP0CVR2wFch4JkDp+ZcMwMhAywEHgvuC3DLdfKirHHOjVqxMpPAro8vF3zUD
	xTSqvaXvdhJo2vrdyk0NoqzsfmXvn9QcXhnOcyMjOH/DCN+LVMmY9EcGz+82yyZaEQWd8/McY
	70kln66BPkAOgBbscoTdnDzZlRwRPzHBUzB/YD19yaAszc2U2sUj8SYEG/Toi1z3jUAKTsAcQ
	hFPZhb5uiI9nFnJxPAbQOH2gcoEIkKoFwcyJiB5UjqSCKvA/VH0tUPLkuSk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Subject: Re: [Qemu-devel] [PATCH] linux-user: avoid treading on gprof's
 SIGPROF signals
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Riku Voipio <riku.voipio@iki.fi>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502163348.-iBnVmlvzG56-zmskeVRl3OLPtEXNdxDzMtYeQ-b1u0@z>

On 02/05/2019 18:27, Laurent Desnogues wrote:
> On Thu, May 2, 2019 at 6:17 PM Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> On 02/05/2019 16:58, Alex Bennée wrote:
>>> The guest tends to get confused when it receives signals it doesn't
>>> know about. Given the gprof magic has also set up it's own handler we
>>> would do well to avoid stomping on it as well.
>>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
>>>  linux-user/signal.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/linux-user/signal.c b/linux-user/signal.c
>>> index e2c0b37173..44b2d3b35a 100644
>>> --- a/linux-user/signal.c
>>> +++ b/linux-user/signal.c
>>> @@ -508,6 +508,11 @@ void signal_init(void)
>>>      act.sa_flags = SA_SIGINFO;
>>>      act.sa_sigaction = host_signal_handler;
>>>      for(i = 1; i <= TARGET_NSIG; i++) {
>>> +#ifdef TARGET_GPROF
>>> +        if (i == SIGPROF) {
>>> +            continue;
>>> +        }
>>> +#endif
>>>          host_sig = target_to_host_signal(i);
>>>          sigaction(host_sig, NULL, &oact);
>>>          if (oact.sa_sigaction == (void *)SIG_IGN) {
>>>
>>
>> Perhaps merge this with the previous one and send a v2: it will ease
>> bisecting.
> 
> I agree it would be better, though it should be noted that the signal
> issue has existed for at least 8 years (that's when I had to add a
> specific patch in my private repository).

I can also apply the second first, and the first then...

Thanks,
Laurent


