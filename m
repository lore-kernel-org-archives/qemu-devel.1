Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A06DC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 17:57:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F048121D46
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 17:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4nCYdxs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F048121D46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG4L4-0003A3-V0
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 13:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kG4KW-0002hu-52
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 13:56:24 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34905)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kG4KU-00015K-8Z
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 13:56:23 -0400
Received: by mail-wm1-x343.google.com with SMTP id y15so3292850wmi.0
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 10:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kklDda8xcwHHYE1R2nI3fwUc62PSqJ5jSx8FygF1khw=;
 b=W4nCYdxsCEacs8JOi05dqejBSivm90U/Ita/stJ0Dch20M0FDz4o+6JOvblOiSaZO1
 U/iE2cjdC46oXp0+ThLIknPu7sFBLdTwAm5i6A1uhJuiaYW+FQ4iAndzcZMisoEspDkv
 xwf+xBPP1L6NIngDaDkYo62thkJzplx9hAnBPP0iD5Pt5qQgxbqIQWBVqqEgmRidXqbR
 wIJysniaSgnwXkG5xVsQDiNVw9JAibE/GsYaH02T+TeiDiKCcn3ANamGSgkX4xubT6To
 sCI+oCrgCuntHvTDs8Y7n8LIiERNo5EdkHvUB2xxtNob7nuloEGm9La0vQVKxDnEQWQl
 Lf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kklDda8xcwHHYE1R2nI3fwUc62PSqJ5jSx8FygF1khw=;
 b=EcsCnnYaB+iJxH+maTXD5D1GBQwbxUUwyGILvPoGfSXyhqYB1iRsCbunG343ftbyNW
 0viBO5h9t1tvfpPfiDsi5L7vQdlN9MskWA7Z6co5jytz5h+KiYsOz7JPPkSSyWtqMeCA
 zfQ0D9Z2JIwCgJC8VU+kU2iSxOXw60nPjc1CI0bbkzoLduWXcqvvfRkOYWk3aNkj9lcA
 wJho0h5Q7LKMezdHldHjEbFlbkVl3Nl1LtDwvClYpG+kCXuC9XINXCw0muwDHvWmntcT
 fJ0xRxTnttJkNWkd6rS7NpuyqBFogRPvE33qpMCV0XjzruhCdRGfSBEEuiKZjpxwx4KX
 Iojw==
X-Gm-Message-State: AOAM533QAvp6xbEBYXY6Wqsx9ndLJSPEEdRuC13XnkEjHcymQLVTh24V
 59jJrloDD4unehx00Us4OA4=
X-Google-Smtp-Source: ABdhPJxgwuhewb9esxTejWhvC40uyc+pGk8uJBJCw5pHEUDRXArVDgWW2kNPw14KBg0dRfz9Hc1IUg==
X-Received: by 2002:a1c:f612:: with SMTP id w18mr4511419wmc.47.1599674180548; 
 Wed, 09 Sep 2020 10:56:20 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id z13sm5234781wro.97.2020.09.09.10.56.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2020 10:56:19 -0700 (PDT)
Subject: Re: [PULL v2 13/15] hw/rx: Add RX GDB simulator
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200622191746.18031-1-f4bug@amsat.org>
 <20200622191746.18031-2-f4bug@amsat.org>
 <CAFEAcA9SK1BmrY9_LO6ERy-e22rXOVUP1+vSmUYSTEwWywuzuA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <24fc5d34-8af3-53cb-3257-62b3b07defcb@amsat.org>
Date: Wed, 9 Sep 2020 19:56:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9SK1BmrY9_LO6ERy-e22rXOVUP1+vSmUYSTEwWywuzuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-3.576,
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
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Yoshinori,

On 9/7/20 3:13 PM, Peter Maydell wrote:
> On Mon, 22 Jun 2020 at 20:20, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> From: Yoshinori Sato <ysato@users.sourceforge.jp>
>>
>> Add the RX machine internally simulated in GDB.
> 
> Hi; Coverity points out a memory leak (CID 1432307) in this function:
> 
>> +static void rx_gdbsim_init(MachineState *machine)
>> +{
> 
>> +        if (dtb_filename) {
>> +            ram_addr_t dtb_offset;
>> +            int dtb_size;
>> +            void *dtb;
>> +
>> +            dtb = load_device_tree(dtb_filename, &dtb_size);
> 
> This allocates memory...
> 
>> +            if (dtb == NULL) {
>> +                error_report("Couldn't open dtb file %s", dtb_filename);
>> +                exit(1);
>> +            }
>> +            if (machine->kernel_cmdline &&
>> +                qemu_fdt_setprop_string(dtb, "/chosen", "bootargs",
>> +                                        machine->kernel_cmdline) < 0) {
>> +                error_report("Couldn't set /chosen/bootargs");
>> +                exit(1);
>> +            }
>> +            /* DTB is located at the end of SDRAM space. */
>> +            dtb_offset = machine->ram_size - dtb_size;
>> +            rom_add_blob_fixed("dtb", dtb, dtb_size,
>> +                               SDRAM_BASE + dtb_offset);
> 
> ...and rom_add_blob_fixed() copies that memory, it doesn't take
> ownership of it, so after we've called it we need to
>     g_free(fdt);

Can you send a patch to fix this please?

> 
>> +            /* Set dtb address to R1 */
>> +            RXCPU(first_cpu)->env.regs[1] = SDRAM_BASE + dtb_offset;
>> +        }
>> +    }
> 
> thanks
> -- PMM
> 

