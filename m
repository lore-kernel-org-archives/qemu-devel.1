Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCA6C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 09:19:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF72120873
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 09:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF72120873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48146 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM7sW-0007vY-2z
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 05:19:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hM7r9-0007Kq-US
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:18:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hM7qz-0001Yh-AX
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:18:12 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:48243)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hM7qi-0001Kn-5f; Thu, 02 May 2019 05:17:54 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1MC3H1-1hU4Jt3IjN-00CVDX; Thu, 02 May 2019 11:17:32 +0200
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
	qemu-trivial@nongnu.org, qemu-devel@nongnu.org
References: <20190427162922.4207-1-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <fc2aab1e-b709-2f1b-f357-3a027e499309@vivier.eu>
Date: Thu, 2 May 2019 11:17:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190427162922.4207-1-f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mb4Qb7CWye0F/VsRPXLZ9OCeVa2RQQnuOF7OfA5sV8WP9TN18gC
	cfhDYekC8foQHsZrJhBP7xX4Mtpt93EpuXcTkUmqnV8w5pBNbUUG6LFf4KKz4bs+qxjajA9
	xKNKKIT6DIl7gFd9uy4MJ9tgv1KMPFqnD6SOkHJ+VGrZ0Z5M1ADpeXegaSrXCv/S3KQhm2U
	QI2jowsm9seA6Qze+Mz4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hUdJfFwA2To=:Orcgg9Bd5nezXsHp4CqVcl
	tdU4sFRby5FrX5VFRa9WAU3nFKtiTZZMj/Il5Vkws6xlQWj7XlD2HwtDFWD2xXZAW25+S8rMa
	QCtyjk7QPoqt2nnodLIaIgPLWKTWupJP7MCY0PJk+MUNoE7iIilatMKXY1/GjFu0+iRc3JaR2
	quD+jQ0tn42zfUtOFAFrKHYUAejECMvC9W1UH6UWyguAt0aq3uKJvrxklJW1UwaEa1apPvnnj
	T36vsBa9s/PhT+AHBdTVtC1JznNOAMGe8PgZZEMYOH8hwihaL4tD/eue9Onu2PH9unJumM8Rn
	V5qc1jz0z2Tpqm5WdZ+u8s73FivhYbWCPFBNOa5x8se8qXFdoOOnTJlx797Num24QobkiPeum
	k9xINTXVq55egAvVrmLaYJF3+sM8DELnKdluDsxKkSX80xuKFUSTMl8U7BgIHNMjm1djGC439
	faDZzdArrTStuccfBgtZYGrjfXQSgICDoAUxcNyYNxgdQHZ+lW950drB0XioqsqcohuyPFFHF
	frcpELWOcxcVrPez+29MW4+YXMLe56HiGEYwvvybmwubmwnE9nBRYf+gXI+whVIBVgAZSQPC6
	jDSj3bYnSStHqRvU+UeulerqU63rz4c48GK00NsdsBSOcGJmPFmrQ7NPxH1n6yguV6KKdkRA4
	57OouM4Szs2WImGl2tGrxAIud0cxV9V1hJzOvIOVgN5lPYM6AiHu9ZIV7qlWc3IfPmp9KGOjS
	Q8ZEKHoAUA9mUsT43KzIk9cMqgqhz7ZBd4PHGuMus/bTEJKICtgb4LEyPtk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v2] hw/sparc/leon3: Allow
 load of uImage firmwares
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
Cc: KONRAD Frederic <frederic.konrad@adacore.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502091730.SazQdhEID2uFowb_3_WAMWB-kWjhAnBjlhHvm89-oy0@z>

On 27/04/2019 18:29, Philippe Mathieu-Daudé wrote:
> Currently the Leon3 machine doesn't allow to load legacy u-boot images:
> 
>   $ qemu-system-sparc -M leon3_generic -d in_asm \
>       -kernel HelenOS-0.6.0-sparc32-leon3.bin
>   qemu-system-sparc: could not load kernel 'HelenOS-0.6.0-sparc32-leon3.bin'
> 
>   $ file HelenOS-0.6.0-sparc32-leon3.bin
>   HelenOS-0.6.0-sparc32-leon3.bin: u-boot legacy uImage, HelenOS-0.6.0,\
>     Linux/ARM, OS Kernel Image (Not compressed), 2424229 bytes,\
>     Sun Dec 21 19:18:09 2014,\
>     Load Address: 0x40000000, Entry Point: 0x40000000,\
>     Header CRC: 0x8BCFA236, Data CRC: 0x37AD87DF
> 
> Since QEMU can load uImages, add the necessary code,
> so the Leon3 machine can load these images:
> 
>   $ qemu-system-sparc -M leon3_generic -d in_asm \
>       -kernel HelenOS-0.6.0-sparc32-leon3.bin
>   ----------------
>   IN:
>   0x40000000:  b  0x400007a8
>   0x40000004:  nop
>   ----------------
>   IN:
>   0x400007a8:  save  %sp, -136, %sp
>   0x400007ac:  call  0x40000020
>   0x400007b0:  sethi  %hi(0x4000b800), %i1
>   ...
> 
> Tested with the following firmware:
> http://www.helenos.org/releases/HelenOS-0.6.0-sparc32-leon3.bin
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> v2: Fixed GIT_AUTHOR_EMAIL
> ---
>  hw/sparc/leon3.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index 774639af33..0383b17c29 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -193,6 +193,10 @@ static void leon3_generic_hw_init(MachineState *machine)
>          kernel_size = load_elf(kernel_filename, NULL, NULL, NULL,
>                                 &entry, NULL, NULL,
>                                 1 /* big endian */, EM_SPARC, 0, 0);
> +        if (kernel_size < 0) {
> +            kernel_size = load_uimage(kernel_filename, NULL, &entry,
> +                                      NULL, NULL, NULL);
> +        }
>          if (kernel_size < 0) {
>              error_report("could not load kernel '%s'", kernel_filename);
>              exit(1);
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

