Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA2BC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 09:00:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21B7620825
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 09:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21B7620825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9POI-0001ez-7b
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 05:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k9PNe-000133-2I; Sat, 22 Aug 2020 05:00:06 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:39621)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k9PNb-0003XK-KY; Sat, 22 Aug 2020 05:00:05 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.2])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id BA3BC59932F3;
 Sat, 22 Aug 2020 10:59:57 +0200 (CEST)
Received: from kaod.org (37.59.142.99) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 22 Aug
 2020 10:59:56 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G0039f398cef-ed1d-4c8c-9689-b06051627c32,
 3BE414691F1E901D170BBC22D222B03988F0DEFC) smtp.auth=clg@kaod.org
Subject: Re: [PATCH v6 4/8] ppc/e500: Use start-powered-off CPUState property
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>, <qemu-ppc@nongnu.org>
References: <20200819164306.625357-1-bauerman@linux.ibm.com>
 <20200819164306.625357-5-bauerman@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3dd050ad-147e-c365-883a-3384130b0d2f@kaod.org>
Date: Sat, 22 Aug 2020 10:59:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819164306.625357-5-bauerman@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.99]
X-ClientProxiedBy: DAG5EX1.mxp5.local (172.16.2.41) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: dad23c6b-c7fe-4bcf-8773-6c35175e3896
X-Ovh-Tracer-Id: 16036473850654722969
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedruddugedguddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepjeekudeuudevleegudeugeekleffveeludejteffiedvledvgfekueefudehheefnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepghhrohhugheskhgrohgurdhorhhg
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/22 04:39:23
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Greg Kurz <groug@kaod.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On 8/19/20 6:43 PM, Thiago Jung Bauermann wrote:
> Instead of setting CPUState::halted to 1 in ppce500_cpu_reset_sec(), use
> the start-powered-off property which makes cpu_common_reset() initialize it
> to 1 in common code.
> 
> Also change creation of CPU object from cpu_create() to object_new() and
> qdev_realize_and_unref() because cpu_create() realizes the CPU and it's not
> possible to set a property after the object is realized.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>


This is breaking make check : 

    tests/qtest/libqtest.c:175: kill_qemu() detected QEMU death from signal 11 (Segmentation fault) (core dumped)
    ERROR boot-serial-test - too few tests run (expected 7, got 0)
    make: *** [/home/legoater/work/qemu/qemu-powernv-5.2.git/tests/Makefile.include:650: check-qtest-ppc64] Error 1
    make: *** Waiting for unfinished jobs....
    
    
    gdb --args build/ppc64-softmmu/qemu-system-ppc64  -display none   -M ppce500
    ...
    Thread 1 "qemu-system-ppc" received signal SIGSEGV, Segmentation fault.
    0x000055555596ebf2 in ppce500_init (machine=0x5555567aa6e0)
        at /home/legoater/work/qemu/qemu-powernv-5.2.git/hw/ppc/e500.c:880
    880	        irqs[i].irq[OPENPIC_OUTPUT_INT] = input[PPCE500_INPUT_INT];
 
    
    AFAIUI, 'input is not initialized since the CPU is not yet realized.

    C.

> ---
>  hw/ppc/e500.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index ab9884e315..d7b803ef26 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -704,9 +704,6 @@ static void ppce500_cpu_reset_sec(void *opaque)
> 
>      cpu_reset(cs);
> 
> -    /* Secondary CPU starts in halted state for now. Needs to change when
> -       implementing non-kernel boot. */
> -    cs->halted = 1;
>      cs->exception_index = EXCP_HLT;
>  }
> 
> @@ -865,7 +862,7 @@ void ppce500_init(MachineState *machine)
>          CPUState *cs;
>          qemu_irq *input;
> 
> -        cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
> +        cpu = POWERPC_CPU(object_new(machine->cpu_type));
>          env = &cpu->env;
>          cs = CPU(cpu);
> 
> @@ -897,7 +894,16 @@ void ppce500_init(MachineState *machine)
>          } else {
>              /* Secondary CPUs */
>              qemu_register_reset(ppce500_cpu_reset_sec, cpu);
> +
> +            /*
> +             * Secondary CPU starts in halted state for now. Needs to change
> +             * when implementing non-kernel boot.
> +             */
> +            object_property_set_bool(OBJECT(cs), "start-powered-off", true,
> +                                     &error_fatal);
>          }
> +
> +        qdev_realize_and_unref(DEVICE(cs), NULL, &error_fatal);
>      }
> 
>      env = firstenv;
> 


