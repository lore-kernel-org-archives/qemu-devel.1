Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535DDC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:38:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2524721D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u7ak+r4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2524721D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuiJS-000291-9f
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 14:38:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50892)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1iuhSB-0008AT-9X
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 13:43:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1iuhS9-0008MY-ER
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 13:43:42 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:40072)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1iuhS7-0008LO-KM
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 13:43:39 -0500
Received: by mail-pg1-x543.google.com with SMTP id k25so1803021pgt.7
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 10:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:subject:cc:from:to:in-reply-to:references:message-id
 :mime-version:content-transfer-encoding;
 bh=GP/r9PIlSLqYQhKV2QQNMvljVe8xKLDedn52KnK8YEc=;
 b=u7ak+r4HNGSYzN10dl2xekH55MhnLCc8D0BDny6v+p+7ty6IqpkPDBs2Bz1lLqsLVD
 0VPIArxeBGBEBi3xwCU4KdQ6yQHvavdsm3aH4cmDuvcc049LTROtvBnGDOM6P953XBcD
 6FObmd69Vl+r0nldTIMco7AELRP9xEsJpatw3I1IbIKPEMGApcdwBMjtdwvvL1dmJTnS
 4QzaC9OEM2KyY7KuX9pWUcHuIYt9PD/EshBtNNpSwXFHwHJwLa4syEXUyZB7NaC8K5Pt
 D4avERIouW9fvrimoS9WCLJwookIMGZNOJaMvEU7RbQpasAMSpB+Yk5zCL0CZSEVA0vZ
 310w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:cc:from:to:in-reply-to:references
 :message-id:mime-version:content-transfer-encoding;
 bh=GP/r9PIlSLqYQhKV2QQNMvljVe8xKLDedn52KnK8YEc=;
 b=iS+cmRf8B4emLmaNuQXW5KfuPXNyEWzSod5EBSuzoaQSOrsT+rUqQiJMScP4PLXGZM
 wUXkHYd3tRxGE3ZcXWIPFsB7RW9fvKkAIXOAspQHGA5/xw2EfoF/217RX+8CVVE1gITJ
 CTMZ80ruAY6AOKy9zGzZnT6m8J6J/FrDe0t7loHG7JDzKiD2emVSI9b3CrAUoQ5BWTRs
 MOThKhJ8F+CLg6bGlfGiRkQNke3p4zGh1j8VsKyS1YywTwcmGY7/mrPWW2PJ76ojFoEq
 wujbUt0PKXE/6ho7jDSX/OOehAXgU0OE6HgkjjUgyUYsQd2IGQQy3m/42oCV5VaBt3H/
 DmXA==
X-Gm-Message-State: APjAAAV4RPw/05rSaE4CHHMk6z4fCGZYNHuCFPPllC2wuMj9D2vm1BDR
 VRO+lXkH+W4jTqLyR8NHAKwR2g==
X-Google-Smtp-Source: APXvYqw8LKSOPhzj3wIR6MKwNKQ4u3nx3Bh0YeQptuOkDEI+tl1AjDXSb+kVGM5R4uC9JO+kGtX9mA==
X-Received: by 2002:a63:66c6:: with SMTP id a189mr115356pgc.401.1579805017815; 
 Thu, 23 Jan 2020 10:43:37 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:bf69:4011:cfff:c9e3])
 by smtp.gmail.com with ESMTPSA id d27sm3491014pgm.53.2020.01.23.10.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 10:43:37 -0800 (PST)
Date: Thu, 23 Jan 2020 10:43:37 -0800 (PST)
X-Google-Original-Date: Thu, 23 Jan 2020 10:43:35 PST (-0800)
Subject: Re: [PULL] RISC-V Patches for the 5.0 Soft Freeze, Part 1
CC: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
In-Reply-To: <CAFEAcA9YoAjASu4F1hZRjbq5S+h8GtBUVb9dgecMdaWb9YENEw@mail.gmail.com>
References: <CAFEAcA9YoAjASu4F1hZRjbq5S+h8GtBUVb9dgecMdaWb9YENEw@mail.gmail.com>
 <20200121225703.148465-1-palmerdabbelt@google.com>
Message-ID: <mhng-ea4d4047-6dfa-4be0-8ce7-424b1d17560a@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Jan 2020 06:38:07 PST (-0800), Peter Maydell wrote:
> On Tue, 21 Jan 2020 at 23:41, Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>>
>> The following changes since commit 28b58f19d269633b3d14b6aebf1e92b3cd3ab56e:
>>
>>   ui/gtk: Get display refresh rate with GDK version 3.22 or later (2020-01-16 14:03:45 +0000)
>>
>> are available in the Git repository at:
>>
>>   git@github.com:palmer-dabbelt/qemu.git tags/riscv-for-master-5.0-sf1
>>
>> for you to fetch changes up to 82f014671cf057de51c4a577c9e2ad637dcec6f9:
>>
>>   target/riscv: update mstatus.SD when FS is set dirty (2020-01-16 10:03:15 -0800)
>>
>> ----------------------------------------------------------------
>> RISC-V Patches for the 5.0 Soft Freeze, Part 1
>>
>> This patch set contains a handful of collected fixes that I'd like to target
>> for the 5.0 soft freeze (I know that's a long way away, I just don't know what
>> else to call these):
>>
>> * A fix for a memory leak initializing the sifive_u board.
>> * Fixes to privilege mode emulation related to interrupts and fstatus.
>>
>> Notably absent is the H extension implementation.  That's pretty much reviewed,
>> but not quite ready to go yet and I didn't want to hold back these important
>> fixes.  This boots 32-bit and 64-bit Linux (buildroot this time, just for fun)
>> and passes "make check".
>
> Hi. This pull request doesn't seem to be signed with the GPG
> key that I have on record for you...

When I moved to Google I got a Yubikey and made new subkeys for it.  If I
understand correctly the new subkeys should be signed by my main key, but maybe
that didn't make it to your keyring?  I see

    $ gpg --list-keys palmer@dabbelt.com
    pub   rsa4096 2017-06-06 [SC] [expires: 2027-11-13]
          00CE76D1834960DFCE886DF8EF4CA1502CCBAB41
    uid           [ultimate] Palmer Dabbelt <palmer@dabbelt.com>
    uid           [ultimate] Palmer Dabbelt <palmerdabbelt@google.com>
    sub   rsa4096 2017-06-06 [E]
    sub   rsa4096 2019-11-26 [S] [expires: 2024-11-24]
    sub   rsa4096 2019-11-26 [A] [expires: 2024-11-24]
    sub   rsa4096 2019-11-26 [E] [expires: 2024-11-24]

I have the master key at home, so if I didn't do this right I can re-spin
things tonight.

>
> thanks
> -- PMM

