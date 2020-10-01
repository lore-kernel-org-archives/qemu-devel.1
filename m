Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D46C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:59:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B008C21707
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/HEsNaB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B008C21707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2rK-0002Fi-O3
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kO2bx-0007el-6I
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:43:21 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33122)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kO2bv-0006Ec-FO
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:43:20 -0400
Received: by mail-wm1-x344.google.com with SMTP id e11so2742085wme.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 10:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DR7G6fqST4DGgaQEMsHDS7bxbufaO21QgHcV0e/spsU=;
 b=q/HEsNaBbMPCCQZ/GiNlC/vPctg6uD/580tPIPw8Kwkp6xejkeCyAgNfDwguysvdeb
 PuoIatsOmhgCR0AVKEeYbPWSPtoyGuwt4jrfoH9c1+D+7fkCz3HcWymxjMMS2Kl8gtUf
 STYJrtQz/O9PHak1cmbZVoKia6vPhC9q4kt3pqQ/M5J0suXpjMOsRxxUhN4yg1/eB7/O
 6WxABfVOcdTl+FjhaXO5mRgGkzXv+3XehbwrdLkNt2c3PX1nfVMZGke54D75zM2IvYQ5
 oK21QaLbCbkRBE4RJaoz4Jtc7g5aqmyF120pyMBOFxNIwpId24SMS+rMRCiC2k3vhLEt
 tW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DR7G6fqST4DGgaQEMsHDS7bxbufaO21QgHcV0e/spsU=;
 b=BuoEv02kW9DCaJ3yFe8EGLI6jIzuFAG7qma9bNOkR4gN2R3ruEsIX9euVwheTz8FjM
 jZjTC4RT/P3rivdw9ywZ+iOhrahHuKJBnJpsyUs/fI2FWWLcMbkd9TFNOgrb+fKSwx04
 WsgBM/yISWWzCrCVC99S6g+oQZEsWKo9Rdlab+DMND5mPBinU/fOanPkh1RFYJZUwyjv
 rLH0gFXRqZFXT3liWcj7jHKomSiyOxOilAbL5D5kvPhjN9c8JyIP/rj3oBYpG8lFtsNp
 5ZERTXh7sUbhIr0Z/+QZ2dGAuPsWwiwsRyMh9+Z7VMz9XCAJClAZvs/uzH9PIpOsQTyX
 Z9pg==
X-Gm-Message-State: AOAM532iru+M7zQIKWI66uLbUNRvJgWcoM/IDWFTljnfgLRi3t2Idvy6
 aD3iKnBx46kDCj1sjCaqcQ4=
X-Google-Smtp-Source: ABdhPJyDFPi44TTSBA9HnvV6gCiPpL5kGylcu2JhqQtGBfO+PRvI0TxLnp9eesTELKKb/cCPodwVGw==
X-Received: by 2002:a7b:cc84:: with SMTP id p4mr1200931wma.58.1601574198131;
 Thu, 01 Oct 2020 10:43:18 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id s12sm894108wmd.20.2020.10.01.10.43.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 10:43:17 -0700 (PDT)
Subject: Re: [PULL v2 13/15] hw/rx: Add RX GDB simulator
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200622191746.18031-1-f4bug@amsat.org>
 <20200622191746.18031-2-f4bug@amsat.org>
 <CAFEAcA9SK1BmrY9_LO6ERy-e22rXOVUP1+vSmUYSTEwWywuzuA@mail.gmail.com>
 <24fc5d34-8af3-53cb-3257-62b3b07defcb@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7bcad3ac-b2a1-7bab-cc33-668518b7cf75@amsat.org>
Date: Thu, 1 Oct 2020 19:43:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <24fc5d34-8af3-53cb-3257-62b3b07defcb@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.26,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/9/20 7:56 PM, Philippe Mathieu-Daudé wrote:
> Hi Yoshinori,
> 
> On 9/7/20 3:13 PM, Peter Maydell wrote:
>> On Mon, 22 Jun 2020 at 20:20, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>
>>> From: Yoshinori Sato <ysato@users.sourceforge.jp>
>>>
>>> Add the RX machine internally simulated in GDB.
>>
>> Hi; Coverity points out a memory leak (CID 1432307) in this function:
>>
>>> +static void rx_gdbsim_init(MachineState *machine)
>>> +{
>>
>>> +        if (dtb_filename) {
>>> +            ram_addr_t dtb_offset;
>>> +            int dtb_size;
>>> +            void *dtb;
>>> +
>>> +            dtb = load_device_tree(dtb_filename, &dtb_size);
>>
>> This allocates memory...
>>
>>> +            if (dtb == NULL) {
>>> +                error_report("Couldn't open dtb file %s", dtb_filename);
>>> +                exit(1);
>>> +            }
>>> +            if (machine->kernel_cmdline &&
>>> +                qemu_fdt_setprop_string(dtb, "/chosen", "bootargs",
>>> +                                        machine->kernel_cmdline) < 0) {
>>> +                error_report("Couldn't set /chosen/bootargs");
>>> +                exit(1);
>>> +            }
>>> +            /* DTB is located at the end of SDRAM space. */
>>> +            dtb_offset = machine->ram_size - dtb_size;
>>> +            rom_add_blob_fixed("dtb", dtb, dtb_size,
>>> +                               SDRAM_BASE + dtb_offset);
>>
>> ...and rom_add_blob_fixed() copies that memory, it doesn't take
>> ownership of it, so after we've called it we need to
>>     g_free(fdt);
> 
> Can you send a patch to fix this please?

ping?

> 
>>
>>> +            /* Set dtb address to R1 */
>>> +            RXCPU(first_cpu)->env.regs[1] = SDRAM_BASE + dtb_offset;
>>> +        }
>>> +    }
>>
>> thanks
>> -- PMM
>>
> 


