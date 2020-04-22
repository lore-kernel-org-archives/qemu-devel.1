Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C2CC5518A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 08:16:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27C6D205C9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 08:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S9AjLR+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C6D205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRAYc-0008J9-9A
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 04:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49558)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRAXU-0007Ob-Gf
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 04:15:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRAXT-0001qd-Lb
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 04:15:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54808
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRAXT-0001qL-7w
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 04:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587543322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+LwLu5BQin5tmZUXwR53/MiinefBza4g0u4Mv7RPekc=;
 b=S9AjLR+tx/zzZdVpQ3y2pAdU24lzNnn4SDhmtxmCHehL0nKJ6maeeNZyGLa5bHzUTf39aW
 AKBTa1duXtzyVH8DpJISiNdbFyk2gJGEVbdM7FcLyCPOyyd5vr6mGRCQrk9QF0Nwq/ebHs
 ZRAKGEm2u69Y3SSBOTqDpCw2d64nqgs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-2wDyWd0gO_izieoHPOh3Iw-1; Wed, 22 Apr 2020 04:15:12 -0400
X-MC-Unique: 2wDyWd0gO_izieoHPOh3Iw-1
Received: by mail-wr1-f71.google.com with SMTP id j22so686082wrb.4
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 01:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+LwLu5BQin5tmZUXwR53/MiinefBza4g0u4Mv7RPekc=;
 b=MiCmGkx+oz8m/LbSfhdoAZM5z9On9lmbbzNo+GHtfxwtXWAF4Z4EXtLhtv94fpA2kh
 f48TSsiUt/yDqWooUB4w2xaNB5rG5KCm4TdP4yc5HS6jzcVdRuAHv2V5ymnmV9ak7eQB
 wIgYLWKkaUE2nmr5b6dCu3vmc9JzorNMhHTkvYBQJN5ZmpI51ovnT9PVnNfIbxPtiDBv
 ikwTpmA8cK41HVrIFjtdymxbYxkBuSj/VC+BoMmDuLkSGSaWXwiefx7Fp4ScmtqAIjjv
 LkKRpukV/E/m3pMQWJ86mFg+DTPWv58QTYebyWfADivlsBqdPKjRBN8GIjGfV28dJy30
 CsWw==
X-Gm-Message-State: AGi0PuZkgl6l7ZrW0r1ATvRR9J7EKulMRw7MZvlkrZr8KS3J+lCpMww+
 EPFdQYOEy05ReZbFEit5XGbHMGZOjbLHiNUY+5egmVovBvy+xflUdPUaLmWDkbF6C2Q3qPLsiXS
 RZsOOhoFB92GoIc0=
X-Received: by 2002:a5d:5224:: with SMTP id i4mr28291277wra.1.1587543310039;
 Wed, 22 Apr 2020 01:15:10 -0700 (PDT)
X-Google-Smtp-Source: APiQypJG2+yCSq8lRG9pgd/x0hVpvxjyJfNnTEuzna1LIOn0QWqth7zGaXeSM/7Pr7sMcuq/qbxrRQ==
X-Received: by 2002:a5d:5224:: with SMTP id i4mr28291262wra.1.1587543309817;
 Wed, 22 Apr 2020 01:15:09 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id k184sm6808336wmf.9.2020.04.22.01.15.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2020 01:15:09 -0700 (PDT)
Subject: Re: [PATCH] roms: opensbi: Upgrade from v0.6 to v0.7
To: Bin Meng <bmeng.cn@gmail.com>, Alistair Francis <alistair23@gmail.com>
References: <1587389038-1549-1-git-send-email-bmeng.cn@gmail.com>
 <CAKmqyKMzUzHC1FhV6ccjswjRvQH_h6DuUwEWjte4CAEmxPOKDg@mail.gmail.com>
 <CAEUhbmUTEVPF6f91SqrXL-_M-G_Jg2D29cBjbCs1YBGm2fk6QA@mail.gmail.com>
 <CAEUhbmWsNmTTTFz66M4sK-pEtEMOhfoYzCHYVyEF4AJ2X02twA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bd7da39b-4ece-7e72-a0a0-1d401c3b8c34@redhat.com>
Date: Wed, 22 Apr 2020 10:15:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAEUhbmWsNmTTTFz66M4sK-pEtEMOhfoYzCHYVyEF4AJ2X02twA@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:57:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/22/20 3:30 AM, Bin Meng wrote:
> Hi Alistair,
> 
> On Tue, Apr 21, 2020 at 9:34 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>>
>> Hi Alistair,
>>
>> On Tue, Apr 21, 2020 at 2:41 AM Alistair Francis <alistair23@gmail.com> wrote:
>>>
>>> On Mon, Apr 20, 2020 at 6:25 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>>>>
>>>> Upgrade OpenSBI from v0.6 to v0.7 and the pre-built bios images.
>>>>
>>>> The v0.7 release includes the following commits:
>>>>
>>>> f64f4b9 lib: Add a new platform feature to bringup secondary harts
>>>> b677a9b lib: Implement hart hotplug
>>>> 5b48240 lib: Add possible hart status values
>>>> e3f69fc lib: Implement Hart State Management (HSM) SBI extension
>>>> 6704216 lib: Check MSIP bit after returning from WFI
[...]
>>>> 6c7922e lib: Support vector extension
>>>> 615587c docs: Update README about supported SBI versions
>>>> 66d0184 lib: Allow overriding SBI implementation ID
>>>> 9f1b72c include: Bump-up version to 0.7

The git-short-log in the commit message is very appreciated, thanks.

>>>>
>>>> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>>>
>>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>>>
>>> Can you share a git branch with this patch? From memory these binary
>>> patches don't apply well from emails.

Indeed. These patches are good candidate to use the 'git-format-patch 
--no-binary' option with a link to a git repository to fetch the full 
commit:

   --no-binary
     Do not output contents of changes in binary files,
     instead display a notice that those files changed.
     Patches generated using this option cannot be applied
     properly, but they are still useful for code review.

>>
>> Sure. Please grab the bits from http://github.com/lbmeng/qemu opensbi branch.
>>
>> You can also use patchwork to help with your custodian work.
>> http://patchwork.ozlabs.org/project/qemu-devel/patch/1587389038-1549-1-git-send-email-bmeng.cn@gmail.com/
>>
>> Click on the "mbox" button to download the patch and apply it.
> 
> Will this be 5.0, or 5.1?

Unlikely 5.1, too late.

> 
> Regards,
> Bin
> 


