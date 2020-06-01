Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A18AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 07:30:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7491206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 07:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tzeQ0AFO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7491206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfeu9-0004pq-3p
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 03:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jfetN-00048h-7G
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 03:29:53 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:52101)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jfetM-0006Zx-Aa
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 03:29:52 -0400
Received: by mail-wm1-x32d.google.com with SMTP id u13so9714674wml.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 00:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=k60Ki+0d+huittbFp4TGfReShSbjpNeL+RQ/phNEPxg=;
 b=tzeQ0AFORE8x6nOohflCYO2dEMRHzTAWgDxiGQbHAc0q6trHkuYxCYu63YOG1z9qky
 hlTfzB9CrN5Eg0CnGvJgXJf0+znlEFlgGz6fIuqV/316mPf2fdKYQv6WDbkVpL1Sjj2E
 8OSVGRe94xJ4Mpo/oJ4ZgkJzCyCwpVh6CaOsc5Nfqfhl6lIgJSskKGzMF0OVM3INzk0h
 wxxx0PNl2iwESeTdX3SRw9z0dtPxpP32XB+IpszZzW6kTDG4bDcYATlEKZuGQxx7zRpk
 3CBDUWpLxOj74Ok4SJz7sHc3J+7NUd834PCaO9onGko4hIR2STS9hgru/1hI6lZbqyE6
 38HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=k60Ki+0d+huittbFp4TGfReShSbjpNeL+RQ/phNEPxg=;
 b=JyjnsZP8kvB199N3uL/YnEpbntlQNme+gZ4jf0qswgZQn1RRiomrkz1JvIl2HHxL3f
 9PhWwQGhmjx+SuVLaCtIWIxBhJcpbxUtW9vFBzXsO9ASMJc3dr7+ktxRPkPdMZNQkxSI
 zZhAtsFl6oEw8K577DhpNho3ckEVhxhxImxIOiTT+BP8b1InCvSOUeBntFSlCyShoU7h
 1fzJtre+d0t5gs92WYH2TLmgxLHI2f04NR0FyhkeTMYA/Pq7UEVS1xuH1/djedMWG8xN
 L+D5MLQjeIipeaG5ueXGAkWP4UCSgsitV5yNe89zXX0YQkTCBnrPl7XSykCOWZOti+Hr
 X//A==
X-Gm-Message-State: AOAM533quQKxeIermng2e26VqTkipPdwOnHOvLn5n9sxy9qpeHPlmSmA
 u9dkajM7yvI8e0M08SlZmtY=
X-Google-Smtp-Source: ABdhPJz9EU727b1Im5JoEnWMWFBKhVwjUur/oEI0hDM4GiLn9ccICnw/cOTp0IseWty0IMNDTqnHew==
X-Received: by 2002:a7b:c8d6:: with SMTP id f22mr20422297wml.188.1590996590834; 
 Mon, 01 Jun 2020 00:29:50 -0700 (PDT)
Received: from jondnuc (IGLD-84-229-154-20.inter.net.il. [84.229.154.20])
 by smtp.gmail.com with ESMTPSA id 1sm10941303wms.25.2020.06.01.00.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 00:29:50 -0700 (PDT)
Date: Mon, 1 Jun 2020 10:29:48 +0300
From: Jon Doron <arilou@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH-for-5.0] gdbstub: Use correct address space with
 Qqemu.PhyMemMode packet
Message-ID: <20200601072948.GG3071@jondnuc>
References: <20200330153016.2959-1-f4bug@amsat.org>
 <CAFEAcA8i1W7ss2hQjaFbVHXzqhV81M8U4Fkaj_Te5JK8JO8+mg@mail.gmail.com>
 <f1fd3384-8653-c2e2-7248-457ae873cc27@redhat.com>
 <CAFEAcA_BJf3k-O4j73kNaPtSHfhqmgtm9LH=nAmNj46kMjbkCA@mail.gmail.com>
 <d5ce42bc-a236-512f-dbbe-7327527419e0@amsat.org>
 <20200531164236.GF3071@jondnuc>
 <CAFEAcA95hfnjBjUT0hCxPUzBnGL9xKDkEjBqDcyVBD6spVZ_4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA95hfnjBjUT0hCxPUzBnGL9xKDkEjBqDcyVBD6spVZ_4w@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=arilou@gmail.com; helo=mail-wm1-x32d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/05/2020, Peter Maydell wrote:
>On Sun, 31 May 2020 at 17:42, Jon Doron <arilou@gmail.com> wrote:
>>
>> On 31/05/2020, Philippe Mathieu-Daudé wrote:
>> >On 3/30/20 6:41 PM, Peter Maydell wrote:
>> >> PS: do we have any documentation of this new command ?
>> >> ab4752ec8d9 has the implementation but no documentation...
>> >
>> >Jon, do you have documentation on the Qqemu.PhyMemMode packet?
>
>> Hi, there is no documentation for this mode, but in general the idea was
>> very simple.
>>
>> I want to have GDB the option to see the physical memory and examine it
>> and have this option toggled.
>>
>> This was useful to me when I was working on nested virtual machine and I
>> wanted to examine different states of the VMCS12 and EPTs.
>>
>> I used this in the following commands:
>> // Enable
>> maint packet Qqemu.PhyMemMode:1
>>
>> // Disable
>> maint packet Qqemu.PhyMemMode:0
>
>docs/system/gdb.rst would be the place to document QEMU-specific
>extensions to the gdb protocol (there's an "advanced debugging
>options" section where we document things like the single-step
>stuff you can also change via 'maint packet').
>
>thanks
>-- PMM

Thanks, I'll know for next time, when I did all that work and 
re-factored gdbstub, that doc did not exist.

Perhaps Peter can just add the documentation to this commit?

-- Jon.

