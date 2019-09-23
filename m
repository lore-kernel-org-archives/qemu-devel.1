Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696EAC4CECF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 18:53:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B0D420820
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 18:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B0D420820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCTT9-0005X9-Jl
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 14:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54279)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iCTRT-0004EI-3D
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 14:52:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iCTRS-0004SY-2K
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 14:52:10 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:55229)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iCTRR-0004J6-OU
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 14:52:09 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MHG0U-1iPgrc2Cw4-00DJep; Mon, 23 Sep 2019 20:51:56 +0200
Subject: Re: [Qemu-devel] [PATCH v3] ui: add an embedded Barrier client
To: Anthony PERARD <anthony.perard@citrix.com>
References: <20190906083812.29487-1-laurent@vivier.eu>
 <20190923160751.GA212017@perard.uk.xensource.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <fd32b25d-e66d-6789-79ec-c26b9cd43645@vivier.eu>
Date: Mon, 23 Sep 2019 20:51:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190923160751.GA212017@perard.uk.xensource.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tk8cB0zOCFvTDv+YjSsQet5pfgUMRApPczXpOaf3crwZsRHPLp9
 rV1RI1kNZIYcpuL8f2gSRrX9fGA8cgzoKE+4pEfjrjN99eEMkiU2lmL0njbXheSI07O1710
 5sC814y28bd516XCJHCeZ0k7Ee5d4I1dwn0vIKV8xXxtDC2Yuqn+L+Yu8miiHSFSm6zItKS
 dh/2UVYVeDwNgF2Ckp5mg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5g1vZhm+nfE=:dzlIo1XHuKJ9dQyfk5EXk1
 XgXhft5Z4cBG32wadjClWUUg+upcp09All0LB1Sh1cLSvZcnejBO8C+1hv64tHpTVw3R6h9n9
 yzF2mcKNF5COJGUtRZO/N2AENhXyh8bo+lq19pyA71DzOnqhgitbhyFxINdiuMhsapfignR8B
 Y5i8h0ULzbn0qPkntfUZr75piCFprFsLy5s6ZPcvbtvTB7eOpJCIq8rX8QsCLR38cGkKykcPS
 /KS6ZNV6/Won7dRwjI38xSft6vDvWQRVm6pCUxXkSNragP2rzhJmzdZS9SuTrn7Gw94G5K1u4
 If3EJDsSo0gOEyFbkLst0e/IaNcjG869eUWIb/0LIga1F+Pr2jDpFjBVZk6XUf2hqK/tVsDAr
 vXfCgRU2vmtac7PalLchdfjxPwlULHGieDUk9JClbsN9SyHSN9hzOAe3Ckvhn0yDLBInr4/Dx
 hbwL8pO9/E7lqq6qv1nNIkSluSDXTrMdXkbKGGONmKmpSbwGsiGD8qjnOu1Vy7qZAo8nsjvFG
 OolcjMRHLsQYUHRig/7rGqsHCUUsjhhVupFEgN1Qln2QBZ9S/TzDtLyM/ik1UfELRxCBEEM72
 bE2hqjZz7aWHtfu7u/EO69Frs2NwinaRqi6l8exb4ll94FTg747r3/lJ398p4bJqbwipfVSEq
 BAud+dKj0iyUg0l/jt5RFlT2szJTxE0KOFvhwn6ZW36ShS2jwr6KWA9C6Dz22DvMMAopvQ5jW
 T4aUmFtIklpHYmzwB70B7dU89nWMHjvCnu81bRr+HQ/11uqaXHtoQBX+rLx/i36hr1uvf3if0
 bWxYo7jYr5cQ7LYyPx8VnxCvSjjPn9ouYBW2V736C9ImjHQksoUkRpfiaSZaVUlfCz1DbS6QY
 sS1cSZETksYWCBfavQa0zMq7EFNN+urauZUTYdlsE=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 23/09/2019 à 18:07, Anthony PERARD a écrit :
> Hi,
> 
> Once this patch is applied, if we try to start QEMU with "-k en-us",
> qemu print a message and exit:
>     qemu-system-i386: could not read keymap file: 'en-us'
> 
> See below,
> 
> On Fri, Sep 06, 2019 at 10:38:12AM +0200, Laurent Vivier wrote:
>> diff --git a/ui/input-barrier.c b/ui/input-barrier.c
>> new file mode 100644
>> index 000000000000..a2c961f285a4
>> --- /dev/null
>> +++ b/ui/input-barrier.c
>> +static void input_barrier_class_init(ObjectClass *oc, void *data)
>> +{
>> +    UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
>> +
>> +    ucc->complete = input_barrier_complete;
>> +
>> +    /* always use generic keymaps */
>> +    if (keyboard_layout) {
>> +        /* We use X11 key id, so use VNC name2keysym */
>> +        kbd_layout = init_keyboard_layout(name2keysym, keyboard_layout,
>> +                                          &error_fatal);
> 
> I think it's because this function is called way to early, before
> qemu_add_data_dir() is called, and so qemu_find_file() fails.
> 
> Can you fix it?

I'm going to have a look.

Thanks,
Laurent

