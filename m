Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D980AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 11:35:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9930F20759
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 11:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJ92HP1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9930F20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqEY0-0000Ok-Th
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 07:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqEXM-0008OS-Jb
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 07:34:52 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:39128)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqEXK-00031q-Nk
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 07:34:52 -0400
Received: by mail-ej1-x644.google.com with SMTP id w6so20174965ejq.6
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 04:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JUrnK9o60wyHkWjD2KQ+VcdKf+nmHOumpN3FKBEanRI=;
 b=FJ92HP1I0jNqNXXFiPS5z5NdiuXt7BryYjWVtDqICsk/UNkc4wL3J0+uOfkDb3ui0A
 2IuBgLk8HlBncrK055sRaMPbTaPUwHgkzrWMzyKwUWwleaXyQzl9n6yAiMXx3A37f1A/
 sFkMTKv3aqWZfT9eed5ZUb8Ikmu7I3D5dYvlQtRdmNPDdiyTc8bOyzZbTUiUTFRbpOMP
 wkCWMiOZKVfAYjUO7nTxX4lryjIMtZA6NaTg7OU72eROLSB/d1rQaOUyTxyqEyPQNAmH
 Zy4QkZ9gil8DuTUay40X9GBsg5NKOvW3Xq+Ax7H/Lafgwc3EYckKdFP+4rxRZqdjsrN8
 Tt5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JUrnK9o60wyHkWjD2KQ+VcdKf+nmHOumpN3FKBEanRI=;
 b=H+RbvBdh1YWnsd2AlO5wT12nKy7GVh7zKGoxXakIKX/KjI///Fe3VWJNP0teVHrMkZ
 ST/22dXvbSJ7atHUnymxpcoq69ChKqUz3OAiCvCwhz/fhhZ3ESGvo4KZNX2hCK60Bv2P
 fsH6fXQINVAyDsYO/ZcZb/jBANqQSDJ1RZKozsfsC3mNfsRKWRYM6rXzx/Yc2LOY3c6p
 q9fUd2sG1663A2bcMUrzx3SU9bkYj0ZMDB3YLlR0obPcgJg9FUAXdYziFQKpUXYsuoCN
 K8MpS1dz2VTVhKCGWgZLVwkG2RxNUZjGicyze0eMTL/dLztOlyhKMSTX+2AgnFkv1FgT
 vKRA==
X-Gm-Message-State: AOAM532ynL6RUXe8YEhNq7LhN4fXGGUWYqq1PdZz33OchyEfYyMGksd2
 fno2y4eMvPlnNaBNCZVrdkQ=
X-Google-Smtp-Source: ABdhPJwGsBIaq5d36NRueTvasxIRzI9mV7LlbCYli5f4Bsc6c7fPVMJD4QmAoA0+eyu9mSArHzDDHw==
X-Received: by 2002:a17:906:ca0e:: with SMTP id
 jt14mr17444595ejb.325.1593516889196; 
 Tue, 30 Jun 2020 04:34:49 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id e16sm1793328ejt.14.2020.06.30.04.34.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 04:34:48 -0700 (PDT)
Subject: Re: [PATCH 0/7] hw/mips/malta: Rework to allow more than 2GB of RAM
 on 64-bit
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <20200630081322.19146-1-f4bug@amsat.org>
 <CAHiYmc6coeBBOvCAs+=Ccw2aXfw0m3gTdSM1Pc8AQvJ4QNBhow@mail.gmail.com>
 <da6c2f55-b8b7-3492-37b3-d24a25106d72@amsat.org>
 <CAAdtpL7MObRjk77ZFsNF4Xoghdj33mwufZ9s3L8fAC3XxkJCqA@mail.gmail.com>
 <CAHiYmc59Ahpii2dvhVD8EPK4qzc8y2RNTwTbp4L1d2Mjun+Phg@mail.gmail.com>
 <3b75d15d-9195-bcd5-87aa-e243547552e5@amsat.org>
 <CAHiYmc4NOrG-ETX_rLGGR=Cac_Q_hNfjAsS3mF6PpAFFjLDHGw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2514e774-ade4-cd91-8d45-e4402c36c27f@amsat.org>
Date: Tue, 30 Jun 2020 13:34:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHiYmc4NOrG-ETX_rLGGR=Cac_Q_hNfjAsS3mF6PpAFFjLDHGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yunqiang Su <ysu@wavecomp.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/30/20 1:17 PM, Aleksandar Markovic wrote:
> уторак, 30. јун 2020., Philippe Mathieu-Daudé <f4bug@amsat.org
> <mailto:f4bug@amsat.org>> је написао/ла:
> 
>     On 6/30/20 1:01 PM, Aleksandar Markovic wrote:
>     >
>     >
>     > уторак, 30. јун 2020., Philippe Mathieu-Daudé <f4bug@amsat.org
>     <mailto:f4bug@amsat.org>
>     > <mailto:f4bug@amsat.org <mailto:f4bug@amsat.org>>> је написао/ла:
>     >
>     >     On Tue, Jun 30, 2020 at 12:52 PM Philippe Mathieu-Daudé
>     >     <f4bug@amsat.org <mailto:f4bug@amsat.org>
>     <mailto:f4bug@amsat.org <mailto:f4bug@amsat.org>>> wrote:
>     >     >
>     >     > On 6/30/20 12:48 PM, Aleksandar Markovic wrote:
>     >     > >
>     >     > >
>     >     > > уторак, 30. јун 2020., Philippe Mathieu-Daudé
>     <f4bug@amsat.org <mailto:f4bug@amsat.org>
>     >     <mailto:f4bug@amsat.org <mailto:f4bug@amsat.org>>
>     >     > > <mailto:f4bug@amsat.org <mailto:f4bug@amsat.org>
>     <mailto:f4bug@amsat.org <mailto:f4bug@amsat.org>>>> је написао/ла:
>     >     > >
>     >     > >     Hi,
>     >     > >
>     >     > >     Following Jiaxun Yang's patch and discussion:
>     >     > >     https://patchwork.kernel.org/patch/11416915/
>     <https://patchwork.kernel.org/patch/11416915/>
>     >     <https://patchwork.kernel.org/patch/11416915/
>     <https://patchwork.kernel.org/patch/11416915/>>
>     >     > >     <https://patchwork.kernel.org/patch/11416915/
>     <https://patchwork.kernel.org/patch/11416915/>
>     >     <https://patchwork.kernel.org/patch/11416915/
>     <https://patchwork.kernel.org/patch/11416915/>>>
>     >     > >
>     >     > >     - Rename the current machine as 'malta-virt' (keeping
>     >     'malta' aliased)
>     >     > >       Suggestions for better names are welcome, maybe
>     >     'malta-unreal' or
>     >     > >       'malta-unleashed' instead?
>     >     > >     - Add 'malta-phys' which respects hardware
>     restrictions (on
>     >     RAM so far)
>     >     > >     - Unleash 'malta-virt' to allow more than 2GB on 64-bit
>     >     > >
>     >     > >     Philippe Mathieu-Daudé (7):
>     >     > >       hw/mips/malta: Trivial code movement
>     >     > >       hw/mips/malta: Register the machine as a TypeInfo
>     >     > >       hw/mips/malta: Rename 'malta' machine as 'malta-virt'
>     >     > >       hw/mips/malta: Introduce MaltaMachineClass::max_ramsize
>     >     > >       hw/mips/malta: Introduce the 'malta-phys' machine
>     >     > >       hw/mips/malta: Verify malta-phys machine uses
>     correct DIMM
>     >     sizes
>     >     > >       hw/mips/malta: Allow more than 2GB on 64-bit malta-virt
>     >     > >
>     >     > >      hw/mips/malta.c | 121
>     >     +++++++++++++++++++++++++++++++++++++++---------
>     >     > >      1 file changed, 99 insertions(+), 22 deletions(-)
>     >     > >
>     >     > >     --
>     >     > >
>     >     > >
>     >     > >
>     >     > > Thank you, Philippe, for providing this series.
>     >     > >
>     >     > > However, in previous discussion on the patch you mention
>     above, I
>     >     > > already expressed serious reservations on the approach
>     taken in that
>     >     > > patch. These reservations stay today too.
>     >     > >
>     >     > > There is nothing qualitatively different between the original
>     >     patch and
>     >     > > this series. Naming and related stuff are just cosmetic
>     issues.
>     >     >
>     >     > OK, what about considering all patches except the last one?
>     >     > So we can run firmware on a real Malta board, not the QEMU
>     >     > imaginary one (in the discussion you said QEMU should respect
>     >     > real hardware, which I agree).
>     >     >
>     >     > >
>     >     > > The good thing about this series is that one can apply it
>     >     dowstream, if
>     >     > > one finds it useful. However, it is not suitable for
>     upstreaming
>     >
>     >     IOW, what is missing to have this series (except the last patch)
>     >     accepted upstream?
>     >
>     >
>     > It is not what is missing, but was already is in the series that makes
>     > it not suitable for upstreaming. The very concept of the series is
>     > problematic.
> 
>     What is the series is not suitable for upstream? Can you point to
>     patch and code please? How would you conceptually resolve the
>     problem?
> 
> 
> The answer is already in the original thread on the original patch.
> 
> The problem is artificialy imposed:
> 
> One needs a feature not present in the physical system. The solution is
> not in creating "virtual" upgrade - this violates the basic foundation
> if QEMU.
> 
> If the feature is missing, the optimal solution would be emulating the
> physical solution that has that feature.
> 
> In some rare cases (that should be avoided as mush as possible), and for
> really good reasons, we can create an emulation of some imagined
> hardware that was never designed let alone built - there are a couple of
> examples in other targets.
> 
> But extending the emulation of existing physical system with
> non-existing features is not acceptable.
> 
> Hopefuly everything is clear now to you. :)

I guess I understand a bit. I was confused by your use of "upstream".
It seems you use it the wrong way, so for you "upstream" is what the
MIPS enterprise world wants/needs, while "downstream" is what the
open-source community wants/needs.

If MIPS enterprise doesn't want a Malta machine model with 3GB of RAM,
they can disable it in their downstream.
If it helps the upstream community, the model is wrong anyway by using
2GB. It would be disastrous for all user to restrict the malta machine
to 1GB upstream.

> 
> Regards,
> Aleksandar
> 
>  
> 
>     >
>     > Regards,
>     > Aleksandar
>     >
>     >
>     >
>     >
>     >
>     >  
>     >
>     >     > >
>     >     > > Regards,
>     >     > > Aleksandar
>     >     > >
>     >     > >
>     >     > >
>     >     > >     2.21.3
>     >     > >
>     >
> 

