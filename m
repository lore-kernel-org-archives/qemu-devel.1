Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E3EC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:36:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74F392074B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F392074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiiAJ-0001UO-ON
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 13:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jihh6-0008B1-8Q; Tue, 09 Jun 2020 13:05:48 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:39139)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jihh5-00081y-2n; Tue, 09 Jun 2020 13:05:47 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1N4z2a-1izRI02cgm-010txN; Tue, 09 Jun 2020 19:05:40 +0200
Subject: Re: [PATCH] hw/isa/apm: Convert debug printf()s to trace events
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200524164806.12658-1-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e0882e71-cc55-83be-930c-91cb384f0b73@vivier.eu>
Date: Tue, 9 Jun 2020 19:05:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200524164806.12658-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LDQFKOAakAeOFdWIfS1aIDzXHiSh/ib1cqIABlblitv1bgUxkwq
 mkZstG5WYs1MC7TcpYhd86O9D6P48OoNmcbqaJX0LRcynmu+3TT4T6zhni4LEJufjmhs73+
 ja0Wr4oTV84e98XOB0lhBhrT5doRhOJ9cnIP3EoAkgC7hXbYWKDqAuoppOjGh3HvaB63FKY
 Io9tnHbmXW69usuB31LUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t4pmpHB1TXI=:FVJcwqBs678SPy5ixKg2rp
 iak1l3UnISpGvT/ocdh/c1+Ag8au/ucsDXfL95bBLw6LXcFxWA8knQDbBBLUgWTjeWFjwTOAe
 jlWGk5P7KkKeT1SneQ9Hlnpsk5vi9Hecr3CnRSppHMJe6ajYWxLj3gc3M0+H+l/jZyVugU270
 xljVccifRvXTs54uCUGdUh3sjqYoDxqu6Q5b5UgQgnykh7dmoZUs9ad9hLhBe/nyJ0rIJ0cxY
 qJRrApUXb6IoCLgaVgnb2YmNRIW9GG98+ta/dEnn6y+f9pS6Z5tUXyKd5voXE9F50EJ/10qLZ
 CJeofYF66q6RFhBBAp8oYwVC1NgmKebgACTPXOlXnC96wlDHz2pZwFGjCgYR8baAVTzVQXAmK
 E6GE66orDJ/zIV9EH6Yfh5RRwxNeEUUqtJlTaMZwTsi8gw0CLBJ7BmSOwRqbQSpmCcT3y+ChY
 nJe0b4g4zpuvqEJwBO05aU9SL5eZk5MzI8m3sR6LbhAI2F9j5apljkapF0ZvsNnu/aBzBfQPp
 h14/Zll4uiB6LQ4agex85qiQLKssm7DzH32DOs2B+Pu5JwBuJBssBJdkb/GoW5JKbODBG56lZ
 UcZkY5RUbLRKqeitqY73SsPMZ8ezqDwp7+pgxL4QY0/xX3J5/IYF4nhEPjoG2JwhGU18g6bOw
 WHG3tGb0pbW19CghRlP+9iio084jaztwXAqFv3F/Hh1Fzt9/EqsPEV8kWdlpHgDmgTGAed9iW
 YNdx/cPHy4NJtLvorMP8delMpQw6wuIt2kSfwuHUGldRo9Y8PV9bFkT2T2QWCrn9e9/rF2IpB
 Nwszxj94pFUavs/C2tPkz++zgVSknN1AZ3vaWTrebA9DnYydiiMzb2FWdU38ZNcCHAe5FzM
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 12:55:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 24/05/2020 à 18:48, Philippe Mathieu-Daudé a écrit :
> Convert APM_DPRINTF() to trace events and remove ifdef'ry.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/isa/apm.c        | 15 +++++----------
>  hw/isa/trace-events |  4 ++++
>  2 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/isa/apm.c b/hw/isa/apm.c
> index 6300b1ba7a..bce266b957 100644
> --- a/hw/isa/apm.c
> +++ b/hw/isa/apm.c
> @@ -24,14 +24,8 @@
>  #include "hw/isa/apm.h"
>  #include "hw/pci/pci.h"
>  #include "migration/vmstate.h"
> +#include "trace.h"
>  
> -//#define DEBUG
> -
> -#ifdef DEBUG
> -# define APM_DPRINTF(format, ...)       printf(format, ## __VA_ARGS__)
> -#else
> -# define APM_DPRINTF(format, ...)       do { } while (0)
> -#endif
>  
>  /* fixed I/O location */
>  #define APM_STS_IOPORT  0xb3
> @@ -41,8 +35,8 @@ static void apm_ioport_writeb(void *opaque, hwaddr addr, uint64_t val,
>  {
>      APMState *apm = opaque;
>      addr &= 1;
> -    APM_DPRINTF("apm_ioport_writeb addr=0x%" HWADDR_PRIx
> -                " val=0x%02" PRIx64 "\n", addr, val);
> +
> +    trace_apm_io_write(addr, val);
>      if (addr == 0) {
>          apm->apmc = val;
>  
> @@ -65,7 +59,8 @@ static uint64_t apm_ioport_readb(void *opaque, hwaddr addr, unsigned size)
>      } else {
>          val = apm->apms;
>      }
> -    APM_DPRINTF("apm_ioport_readb addr=0x%" HWADDR_PRIx " val=0x%02x\n", addr, val);
> +    trace_apm_io_read(addr, val);
> +
>      return val;
>  }
>  
> diff --git a/hw/isa/trace-events b/hw/isa/trace-events
> index 202f8938e7..3544c6213c 100644
> --- a/hw/isa/trace-events
> +++ b/hw/isa/trace-events
> @@ -9,3 +9,7 @@ superio_create_ide(int id, uint16_t base, unsigned int irq) "id=%d, base 0x%03x,
>  # pc87312.c
>  pc87312_io_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
>  pc87312_io_write(uint32_t addr, uint32_t val) "write addr=0x%x val=0x%x"
> +
> +# apm.c
> +apm_io_read(uint8_t addr, uint8_t val) "read addr=0x%x val=0x%02x"
> +apm_io_write(uint8_t addr, uint8_t val) "write addr=0x%x val=0x%02x"
> 

Applied to my trivial-patches branch.

Thanks,
Laurent


