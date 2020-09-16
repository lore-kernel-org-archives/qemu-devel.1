Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B008C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:17:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37ACD2076C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:17:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37ACD2076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kITYj-0002Dh-9V
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 05:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kITXU-0001Yb-Pt; Wed, 16 Sep 2020 05:15:44 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:57243)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kITXS-0003ub-68; Wed, 16 Sep 2020 05:15:44 -0400
Received: from [192.168.100.1] ([82.252.129.222]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N4R0a-1kSkJZ33va-011OJ2; Wed, 16 Sep 2020 11:15:31 +0200
Subject: Re: [PATCH 0/2] hw/timer/hpet: Fix compiler errors with -DHPET_DEBUG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Dov Murik <dovmurik@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20200909083650.46771-1-dovmurik@linux.vnet.ibm.com>
 <8d9ae068-77cc-6152-7b90-a51bf70648a0@redhat.com>
 <4918b958-dbd4-bd18-bb75-da7386124886@linux.vnet.ibm.com>
 <f246ada9-bf7d-2c94-e24e-e28bf3d2efc2@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f866b06f-b499-a940-2f60-520eb75f0a3e@vivier.eu>
Date: Wed, 16 Sep 2020 11:15:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <f246ada9-bf7d-2c94-e24e-e28bf3d2efc2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LqhXqvuUu1stUfqsIkDhnd6J3Nw5qjCK/v3+F6/jWCB65lS0f5h
 rvgU+AtTczUqgyOgPuJ4Nh82unrhHfmNRjquw0eAdRkSMKiO0raRHjYbiyqTihfRnL3yNeU
 FK/mTznEt8hYslYRMaUVV9CN4LriQN2y4za5Xa7oaUtRGV/BwoT72pJGMkCeyDAZHYCfBSe
 NBeSYbQYBZPAkmvaPoJbA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O+UKZ3fl2tk=:F2AntRaaJBpV4itj4La3B9
 NyXJ519w9Ol6XUWwT1BSaFhhbM82UugiOB6szd723PkstxiL/O4cNSfpH5nrqwM2m4eFP7IkE
 qbiJcXy+3u61/zlCYmzcl8pzuVNH5PrsDgFMBCOtVzQqopNo/WY/wFio5l/fELBw87NE2kV7/
 gBzW7FsFdHnuYZhycScSXeWAmmNzIRi6EvDCiyUmq4FjEH5ukMmGU9//YUOuzbl8otJi+9o7i
 TK8pQ0ZZzxE0JZ1Yy7sVq7H6Mmc/qrorn+6Iu5PoeJ0rYhetoC38qQCJvuPn1za6X5FRKpdvD
 vh1fakwMRrbuVe7WlprlruYDJDp8H3kFkMrTYkPdF03L3xj9Zi4VXpoPBeHZ59ShdDyMcU7Hy
 X0LJu55ULBAwYHSF5TmYWZjUbirMTWZh3fZMprLZesAo0aG42XG71nT3Ez1SzYCPF0oDM0hZE
 XQgFRj87dl8p+93xhM84FRoJ8wNt9Nd5hggzvPudpsSC+sh9FhiYkVIkM3Zfp/R/qLdpxUHaR
 cA8Lq4fbcBbQRdUhUGiPkuTTssOHzn1nNraCPaDMVMzvGbqjvbfgfiR4Rr5dWJwLoEufBq8iR
 7HkqM3+nMT0IzLZ74r7EAjKESDnK3Bx5FQvgHVyAGYU2WPxuFo4ZX0Jsf3Q0smT6D/rQ/oFKy
 B9QqQKbqTRE/jMtsVsDZIfXTfeN35oAvK8CIhQ1KQo/qd0m0Gis8+SSwsE30/O5vrDx1wGK/1
 Y0K8Hq0k9Sn/vDiudUQPRuh72fgMkemqiYoPVZsMwVt1SxCxOZp9ASNvueiUeHc2zytJ+Emy3
 HbL8GHR5SVMrwimJkyBMvwk+kQD8VAEfn6jtenwJD5dGMNk71tx/kpe60OIkE/hRlVqdvA5
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 04:53:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 13/09/2020 à 13:42, Philippe Mathieu-Daudé a écrit :
> Cc'ing qemu-trivial@
> 
> On 9/10/20 2:53 PM, Dov Murik wrote:
>> On 09/09/2020 20:24, Philippe Mathieu-Daudé wrote:
>>> On 9/9/20 10:36 AM, Dov Murik wrote:
>>>> Fix several compiler errors when compiling withe -DHPET_DEBUG.
>>>>
>>>> Steps to reproduce the issue:
>>>>
>>>>      mkdir build
>>>>      cd build
>>>>      ../configure --target-list=x86_64-softmmu
>>>> --extra-cflags=-DHPET_DEBUG
>>>>      make
>>>>
>>>> Dov Murik (2):
>>>>    hw/timer/hpet: Remove unused functions hpet_ram_readb, hpet_ram_readw
>>>>    hw/timer/hpet: Fix debug format strings
>>>>
>>>>   hw/timer/hpet.c | 27 +++++++--------------------
>>>>   1 file changed, 7 insertions(+), 20 deletions(-)
>>>>
>>>
>>> I sent almost the same patches last week :)
>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg736836.html
>>
>> Oops, missed that. You're right.
>>
>>> You seem to fix a 4th format, can you rebase on top? (As these
>>> patches have already been queued).
>>
>> Actually there's a small issue in one of your suggested fixes: you added
>> "0x" but kept the "%#".  I think it should be without the "#" (also
>> according to the coding style document).
>>
>> I suggest you fix this small issue, and also add any changes you wish
>> from this patchset; then we can throw my patchset to the bin.
> 
> Let's use your patchset instead.
> 
> Series:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 

Series applied to my trivial-patches branch.

Thanks,
Laurent




