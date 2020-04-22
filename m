Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A47C5518A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 10:06:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 582B020575
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 10:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJsj4zfw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582B020575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRCHS-0007ej-Hk
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 06:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRCFe-0005Rw-DU
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 06:05:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRCFZ-0007u1-G7
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 06:05:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49443
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRCFZ-0007n1-2G
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 06:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587549899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9EcqVeYqvigPiSD6IPipYSy7lwBCN6HkO6NYflX4Yfw=;
 b=SJsj4zfwXJDsVQOgrVaR478QBJPM6SAOvYYiE40H2I42EdR7y4rWBMeeVbXhfrluBTsPZc
 NdhWuK0sk+/3ScwpifHBU4Zy81FsECyHTPciQL3YQ6gqTNmKWK/t3E4HOa4rHsCaWMhDVX
 Jt9yWrnmZbN3pG0nAInZXCY8d4Nli8g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-SuNDiRb2MreMArY9fX0tKQ-1; Wed, 22 Apr 2020 06:04:51 -0400
X-MC-Unique: SuNDiRb2MreMArY9fX0tKQ-1
Received: by mail-wr1-f71.google.com with SMTP id o12so796873wra.14
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 03:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V9rIBjaXCVFb+27MgqipRdDkydXyWxQTqrdeF3j3K7Q=;
 b=h+NvNrV7KS9QhDTqf/qThzCyVqO7X6h0gwVTy8iLJehwP3QIGRz+qVb7uDOGkzOhpV
 GjQ79rexLbfdedwbPKwJHHS9mpywOlgec1UqWKmkU4rX64NjE6bndJPbfAmZTZC9bOGY
 MJD7s5ZulO0gk/09w3a1A5mrNNM0XweUS7VqaKekrKaEEfrhq5Ta1Oxe+T/ZgJmzWytc
 CmdVWDDCS71zIWFZAFrBjcSVV1t6qFU+zaFTXIXlyZLoGD5R1z3dorysL1PR2keV4eHj
 JmNuD2noRhroptFsezt5zJI4Suw1bUe4Ef0WxwF2z3qgTOnW5GkmxZHNKu8O112f+Sv5
 7esA==
X-Gm-Message-State: AGi0PuZDyzILdhw6O+gfhXeF8C54YVNKAO1HFEwKUahNbtt+dfxysKtf
 WS9WwhFEfeGLN5ipksN0OPKUF0SLBvDQQnEJr50uaUXqjjXhAQWm8uQASX5dsq/IGs00Nbz8F5u
 xmmChL6wj/UMm0K0=
X-Received: by 2002:a5d:4ccb:: with SMTP id c11mr16266462wrt.122.1587549889935; 
 Wed, 22 Apr 2020 03:04:49 -0700 (PDT)
X-Google-Smtp-Source: APiQypJi1/Ccx2CyW2jaEpUD/YDxYboR6/Ttj/sE06nbKuydu66J+exL8QRn6ZXkPtrJKKB7n6VejA==
X-Received: by 2002:a5d:4ccb:: with SMTP id c11mr16266445wrt.122.1587549889695; 
 Wed, 22 Apr 2020 03:04:49 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id h16sm8364071wrw.36.2020.04.22.03.04.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2020 03:04:49 -0700 (PDT)
Subject: Re: [PATCH] roms: opensbi: Upgrade from v0.6 to v0.7
To: Bin Meng <bmeng.cn@gmail.com>, Anup Patel <anup.patel@wdc.com>
References: <1587389038-1549-1-git-send-email-bmeng.cn@gmail.com>
 <CAKmqyKMzUzHC1FhV6ccjswjRvQH_h6DuUwEWjte4CAEmxPOKDg@mail.gmail.com>
 <CAEUhbmUTEVPF6f91SqrXL-_M-G_Jg2D29cBjbCs1YBGm2fk6QA@mail.gmail.com>
 <CAEUhbmWsNmTTTFz66M4sK-pEtEMOhfoYzCHYVyEF4AJ2X02twA@mail.gmail.com>
 <bd7da39b-4ece-7e72-a0a0-1d401c3b8c34@redhat.com>
 <CAEUhbmWCNGTn34wGSUvbwAbuY15VeDPPnFF2em4=XKEH5kReKw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f70626ab-3527-475e-de97-b399cc1d378c@redhat.com>
Date: Wed, 22 Apr 2020 12:04:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAEUhbmWCNGTn34wGSUvbwAbuY15VeDPPnFF2em4=XKEH5kReKw@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
 Alistair Francis <Alistair.Francis@wdc.com>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/22/20 11:50 AM, Bin Meng wrote:
> On Wed, Apr 22, 2020 at 4:15 PM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
>>
>> On 4/22/20 3:30 AM, Bin Meng wrote:
>>> Hi Alistair,
>>>
>>> On Tue, Apr 21, 2020 at 9:34 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>>>>
>>>> Hi Alistair,
>>>>
>>>> On Tue, Apr 21, 2020 at 2:41 AM Alistair Francis <alistair23@gmail.com=
> wrote:
>>>>>
>>>>> On Mon, Apr 20, 2020 at 6:25 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>>>>>>
>>>>>> Upgrade OpenSBI from v0.6 to v0.7 and the pre-built bios images.
>>>>>>
>>>>>> The v0.7 release includes the following commits:
>>>>>>
>>>>>> f64f4b9 lib: Add a new platform feature to bringup secondary harts
>>>>>> b677a9b lib: Implement hart hotplug
>>>>>> 5b48240 lib: Add possible hart status values
>>>>>> e3f69fc lib: Implement Hart State Management (HSM) SBI extension
>>>>>> 6704216 lib: Check MSIP bit after returning from WFI
>> [...]
>>>>>> 6c7922e lib: Support vector extension
>>>>>> 615587c docs: Update README about supported SBI versions
>>>>>> 66d0184 lib: Allow overriding SBI implementation ID
>>>>>> 9f1b72c include: Bump-up version to 0.7
>>
>> The git-short-log in the commit message is very appreciated, thanks.
>>
>>>>>>
>>>>>> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>>>>>
>>>>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>>>>>
>>>>> Can you share a git branch with this patch? From memory these binary
>>>>> patches don't apply well from emails.
>>
>> Indeed. These patches are good candidate to use the 'git-format-patch
>> --no-binary' option with a link to a git repository to fetch the full
>> commit:
>>
>=20
> Some other project mailing lists do not prevent binary patch mails. If
> this is QEMU convention, I suggest we document this in
> https://wiki.qemu.org/Contribute/SubmitAPatch.

This is not a convention, but a personal suggestion. QEMU mailing list=20
don't have this limitation AFAIK. However some MTA do weird things when=20
relaying encoded binaries, and the result is patch are simply not=20
applicable.
Also such large (broken) mails are a pain when your mailbox has quota.

I added this entry:
https://wiki.qemu.org/Contribute/SubmitAPatch#Avoid_posting_large_binary_bl=
ob

>=20
>>     --no-binary
>>       Do not output contents of changes in binary files,
>>       instead display a notice that those files changed.
>>       Patches generated using this option cannot be applied
>>       properly, but they are still useful for code review.
>>
>>>>
>>>> Sure. Please grab the bits from http://github.com/lbmeng/qemu opensbi =
branch.
>>>>
>>>> You can also use patchwork to help with your custodian work.
>>>> http://patchwork.ozlabs.org/project/qemu-devel/patch/1587389038-1549-1=
-git-send-email-bmeng.cn@gmail.com/
>>>>
>>>> Click on the "mbox" button to download the patch and apply it.
>>>
>>> Will this be 5.0, or 5.1?
>>
>> Unlikely 5.1, too late.
>=20
> I am fine. Just wanted to know the strategy of which QEMU release to
> ship which OpenSBI release. +Anup in case he has some comments.

Well I'm not taking any decision here, I'm simply sharing the impression=20
I have after reading the thread between Palmer and Peter:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg697142.html
You can still ask Alistair to insist to Peter, but you'd need a strong=20
reason :)

>=20
> Regards,
> Bin
>=20


