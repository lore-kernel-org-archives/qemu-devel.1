Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D29C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:30:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F179921019
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F179921019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58536 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOmsO-0007wa-8Q
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 13:30:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hOmX1-0006tr-PN
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:08:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hOmX0-0001sF-Vl
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:08:31 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:44373)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hOmX0-0001rk-N3
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:08:30 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
	1N2E9e-1giWRw1wP0-013gs9; Thu, 09 May 2019 19:08:26 +0200
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <877eb86hcf.fsf@zen.linaroharston>
	<20190502145846.26226-1-alex.bennee@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <652f7793-8c6c-7fce-c099-41c2d00b1346@vivier.eu>
Date: Thu, 9 May 2019 19:08:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190502145846.26226-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dAHPKQnUAS8DCrWo3JohYnNEUo/t6iMtsmV+czWCaP0tQZ/nHhV
	tl5wpQLiULQTzkn44Pt+LqVJ1qqiqKijWsqLY7EknytmotVKOHuZsqkMPHfW/QIrEEweS03
	GZ+cRBYmDOZQ6S3FuGkuKicdTbUFZW+VMRvtLzR4bFZEl9HNOq32YeKkWhX/QCBI7dflZFv
	y5m5UAKJpHDCirKklfv1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ps7U2n6CXoI=:7kQBfd33xHBZ9oWY+uXl7k
	0ucBqD5ujkWYdbLZjOeHyTbo8tdsb/DD9Dxn6UHZRbedEesGXkADZJSpywv5idxTW+804tfbN
	yzbWNGvWHYHUgwa00Gzz1jBpC6jzDTpeLewzgn8Exc+cXal5PDdEtdZVH6rFP3cN/eMiiYXv0
	1GRyTWNDugyrRMC4B+xJBLRdF5qNr2kla11J8P7wWA4XrZA26ULSkZTI47FNSmnpcyw4i5LMY
	VpmNfR9GRiFptFRE/fg2Oe2T+rkb+vS8eeyTf3e4ZejjnBwb70Sxcpbkb9t170kWA5eifE0ky
	HWwTr+jhyyYJa8m2CdWgrgDXlHdSzJvNeTA1yD4SJqQLTpJl2/GHhhTftQHLbSQSKKmtUac36
	iUiyGVEHgPPVeujQTmqj9DFsSqJoy49THoXqbm1jymTgMLLZAhTpGrUNeELPIKf7vUH4I/iuO
	3EAn7V7F0gFNQaqVRDJYwJy2W40/1O4ngQLKi0phYhXwhjvt5oi5RaUzkWHbbesN1c8cGOoJg
	4xDPmI3Id3yRl1ZJQvGDAi3w3tHQ+dgQl6TQ9Vj+eYJAvgbAhmoGmdh4PVXetQfNFCsWqBXwj
	Gxcl2vi26izj69zJRtUou5Q1wo2q9hKVSLKG37ZT74D+cSepv/0gcIsTWuh1hcpyEgchAw5QW
	57bu+g/Pm4GkEf1oosBrhtJTxO1ixD702kUS6gnc0hkfEY7YjnqH4HCU4PDT3t1hNk+xu43X1
	Sa4t1I2OhEE6XzBSjmZHx8OTNlV5lCRNsXlF1tyJXzkVPFoH9QV9vdbD79Q=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
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
Cc: Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/05/2019 16:58, Alex Bennée wrote:
> The guest tends to get confused when it receives signals it doesn't
> know about. Given the gprof magic has also set up it's own handler we
> would do well to avoid stomping on it as well.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   linux-user/signal.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index e2c0b37173..44b2d3b35a 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -508,6 +508,11 @@ void signal_init(void)
>       act.sa_flags = SA_SIGINFO;
>       act.sa_sigaction = host_signal_handler;
>       for(i = 1; i <= TARGET_NSIG; i++) {
> +#ifdef TARGET_GPROF
> +        if (i == SIGPROF) {
> +            continue;
> +        }
> +#endif
>           host_sig = target_to_host_signal(i);
>           sigaction(host_sig, NULL, &oact);
>           if (oact.sa_sigaction == (void *)SIG_IGN) {
> 

Applied to my linux-user branch.

Thanks,
Laurent

