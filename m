Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC31C10DAA
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:35:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13FC52087C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13FC52087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG0Fx-0006Yy-SO
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 09:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kG0F4-0005kC-L3; Wed, 09 Sep 2020 09:34:30 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:40521)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kG0F2-0005wn-SF; Wed, 09 Sep 2020 09:34:30 -0400
Received: from [192.168.100.1] ([82.252.148.206]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MJVU0-1jw7uB0KrY-00Jp9e; Wed, 09 Sep 2020 15:34:23 +0200
Subject: Re: [PATCH 2/2] hw/timer/hpet: Fix DPRINTF format string
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200903134506.440082-1-philmd@redhat.com>
 <20200903134506.440082-3-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <dde28c3d-d3a4-eaae-9839-a65307e4336c@vivier.eu>
Date: Wed, 9 Sep 2020 15:34:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903134506.440082-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0bdvnudVIuZgHzpA3SVgIVes0ATvCY/PolJIy4Nktp4PadoP0Ex
 KD+lYGSQB6/HLLEipBD0gHvJz7ej3855IIgTeqBtmAE5seJCXSTk8C7UNRdLYwpjElY6srk
 Fv90lSAzfjCIsvr7lvhMD01k3/6NvRydet7jhBA68SHZ2x7VW7XWlJYEqFsgzNURfTfZg5Z
 4ktdDCRKWu2Wmz5MgTPbQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zz6/YvUu01g=:lJvocgt9zAIUKvROQcntK4
 PDoRZYrTHK1Lknlu8mnAeKnmGG70b1xHprtz72QUov3xETONKwU4fnt0i9LnmO62CIDP2XJtd
 O5Aw3V9/QN9ezLS+SIr6q8K+rF/U1JrfkB5GMNUNzCn051YOerWMK5epk+SmrRubnNdPXnx+l
 3rPAJtKXdCdXDUA19Ndjh99tVr2NturdFH2ugpPVl7I7fa1i7kFeOVTUedDwUn9BKXHu95o4e
 4kbZtCC5Kqv+vgO715OvqA9hAIfPEYVj8cF1sicxhIAHeNvMzLCCBOugviWk2FDPHgdfpYjVV
 8tHfuHH6Ri4UDwDeonLVp0dPVrDeqM7wKU1JjS85ACR0PdjRHcXaUCOyPwATrSim00RyMi6Zf
 x6EmIOqB3ZA2A8oML0lcwGH5E4JiejKxq1iWaIHFTmxnyzlkIZ1GPTAhB+FZLY6POnvWC8U0L
 yZLGuDIciCGdBkG/5n2gLD0aJQRk68cMnqqyXcVgMxVpV49zEE/H0gr3XgOI7bol2Wp6JVT2l
 +lZA0aWdy7X535sbxswTvzpl8BLsmnir5tySTtuX5qkpwkwp+zgKe2ySRpUA26KbfL2Ec2NNx
 fwUz0rDMPPGq5KD2gRZXf8FSbyOtjcwatE0wgV9U0AE8nlWcgPXj4QtS/ijYI12hVXHwLCZij
 2SpNIf/6kF1YFe28O1Ww/5TiDGswxsET64Dd9jBqXWLsqACTzpW/UciVWf8f5JzzPe9Z+Sgun
 +lnGJCLj9q4UBQ1fK2efPSjAXZOZwY+J2cIO1OFxAVpSshUf+IAAsJmH6wchBorl3qUaWia58
 5Mgb+Ot6P2WZNEGMLC5ptRWkNQ0Z+rTpWvOCD1dA6tDS7U2imE3QLSj3Q1AO1gC68Kc1JgR
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 09:34:27
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.576,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 03/09/2020 à 15:45, Philippe Mathieu-Daudé a écrit :
> Fix building with HPET_DEBUG enabled:
> 
>   hw/timer/hpet.c:512:73: error: format specifies type 'unsigned int' but the argument has type 'uint64_t' (aka 'unsigned long') [-Werror,-Wformat]
>       DPRINTF("qemu: Enter hpet_ram_writel at %" PRIx64 " = %#x\n", addr, value);
>                                                             ~~~           ^~~~~
>                                                             %#lx
>   hw/timer/hpet.c:655:21: error: format specifies type 'unsigned int' but the argument has type 'uint64_t' (aka 'unsigned long') [-Werror,-Wformat]
>                       value, s->hpet_counter);
>                       ^~~~~
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> Keep trace-events conversion as ByteSizeTask.
> ---
>  hw/timer/hpet.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
> index b683f64f1d3..8115e42cff3 100644
> --- a/hw/timer/hpet.c
> +++ b/hw/timer/hpet.c
> @@ -495,7 +495,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
>      HPETState *s = opaque;
>      uint64_t old_val, new_val, val, index;
>  
> -    DPRINTF("qemu: Enter hpet_ram_writel at %" PRIx64 " = %#x\n", addr, value);
> +    DPRINTF("qemu: Enter hpet_ram_writel at 0x%" HWADDR_PRIx " = 0x%#"PRIx64"\n", addr, value);
>      index = addr;
>      old_val = hpet_ram_read(opaque, addr, 4);
>      new_val = value;
> @@ -637,7 +637,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
>              }
>              s->hpet_counter =
>                  (s->hpet_counter & 0xffffffff00000000ULL) | value;
> -            DPRINTF("qemu: HPET counter written. ctr = %#x -> %" PRIx64 "\n",
> +            DPRINTF("qemu: HPET counter written. ctr = %#" PRIx64 " -> %" PRIx64 "\n",
>                      value, s->hpet_counter);
>              break;
>          case HPET_COUNTER + 4:
> @@ -646,7 +646,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
>              }
>              s->hpet_counter =
>                  (s->hpet_counter & 0xffffffffULL) | (((uint64_t)value) << 32);
> -            DPRINTF("qemu: HPET counter + 4 written. ctr = %#x -> %" PRIx64 "\n",
> +            DPRINTF("qemu: HPET counter + 4 written. ctr = %#" PRIx64 " -> %" PRIx64 "\n",
>                      value, s->hpet_counter);
>              break;
>          default:
> 

Applied to my trivial-patches branch.

Thanks,
Laurent


