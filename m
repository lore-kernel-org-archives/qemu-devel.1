Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FBDC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:05:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40EE4206F8
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40EE4206F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKHKk-0001Dr-7Z
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 04:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jKHJU-0000NM-Ae
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:04:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jKHJT-0006OV-4Q
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:04:28 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:49817)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jKHJS-0006JC-Rs; Fri, 03 Apr 2020 04:04:27 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MAgMY-1jVEat1ZAu-00B2GM; Fri, 03 Apr 2020 10:04:07 +0200
Subject: Re: [PATCH v5 0/3] redundant code: Fix warnings reported by Clang
 static code analyzer
To: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
References: <20200325025919.21316-1-kuhn.chenqun@huawei.com>
 <7412CDE03601674DA8197E2EBD8937E83B6D495C@dggemm511-mbx.china.huawei.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b273c5c9-18cc-691f-bd1f-df056f448ade@vivier.eu>
Date: Fri, 3 Apr 2020 10:04:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <7412CDE03601674DA8197E2EBD8937E83B6D495C@dggemm511-mbx.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zxMt04446m7SMh2YF/LundvabHBI6Cu4OK4NY5WgqYlaEE2mNoc
 39qteOD0ceZE6E1VqkIgs0o/ea/Pslp7nERJzQhMhNQ/3E9VSDNQ8v+N/xXh5E1XaWOJeuC
 ARGs29pB2TYrkPLCs4vhNQqN0RCdq9YZXwIGXFHZW472i8k62CfcqJI6f1USBXfe1bxsBGz
 aFhiaMri/JyiWBopseA1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uD5z4TbX1Kw=:07Fn/mBSelKBWYaGXuIgKM
 9zo6uF0ktqWOuVbUHKzchmOpWHUZXozO7iqrhtuICvbUHUFqNEAD3AZr6Q1ZTDZL7rMm0Ppzj
 oQRiWF5zVkTAb0VtyuV53Yr5Y2yHafyPZJF72RIkyBqgBGTtZrvpiMTUW8SJv8PM3MwCcob5m
 E2JY9x2UumhYuhkNRkSoAQygx51MXk09yAFge9jd/wIf3iULNWMy4uOlkUiYLWxcIHPoXbWrh
 6gujNcTYbGgopm7YkHysR8t+Z9JLXB5tgJ6hSnYhEgvMq0Avt33NIg1vCiIyMpMjk099+1mG+
 gT42yNBhLMttZ2N14yeCt9Fip/qgFixBZbPVEcYwaDw8V6xkzPAmGQhgortBoKO0CYyICPip3
 kkhbDD9+VHYTB30HGXoxsgAE1pdb9EzJCKgH4VR/UcRP3mhqYadM4YDsPiyGWTWEpGuXwSVfh
 S71LGmO0IjCycS45jYzUpIdTnL/SY5QU68uRyuF1sHc1Zk3X3LbwnbY5pcOUUF+wapxDAA4bt
 /QsA9J4G67OjVK9vMrjE3bkqWxZKNLuRoLEoy6n+H9OzHUOdSTi19UIkWFmukbNGRna9YnZtP
 N9VBEK4llJ9vMiznmeHnD8wJJhomuCumeq6usYrXqG5BI4jjxOtoHPAprdTBBlP659ZZCy/+C
 Tn4SVTNBv3Cy8WLUsYG/hIXZFSUy+HbxDgNglmJr3bqdvbx83KGGAi0PwyDtCCOIuDwAsoLHy
 E2jxLiC81irowbFSRul9zZ64TEUWO8AurEhZFCNM7UYD3+LETfh00jY1vK5UjZ/IOAywVFLxM
 GdTUyyjP+r9WuB9uC4imOJKcyvjCtaMyyCz3AVx/UsHVmHevdLlFFK3VWDoPbyWwySflNNN
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
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
Cc: "philmd@redhat.com" <philmd@redhat.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 03/04/2020 à 09:51, Chenqun (kuhn) a écrit :
> Ping!
> 
> This series has been reviewed.  Could someone please pick this up (e.g. qemu-trivial?)?

As we are in hard feature freeze now and this is not critical bug fixes
I'm going to queue them for 5.1 except if you have good arguments to
have them in 5.0.

Thanks,
Laurent

>> -----Original Message-----
>> From: Chenqun (kuhn)
>> Sent: Wednesday, March 25, 2020 10:59 AM
>> To: qemu-devel@nongnu.org; qemu-trivial@nongnu.org
>> Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>; laurent@vivier.eu;
>> philmd@redhat.com; Chenqun (kuhn) <kuhn.chenqun@huawei.com>
>> Subject: [PATCH v5 0/3] redundant code: Fix warnings reported by Clang static
>> code analyzer
>>
>> v1->v2:
>> - Patch1: Add John Snow review comment.
>> - Patch9: Move the 'dst_type' declaration to while() statement.
>> - Patch12: Add Philippe Mathieu-Daud茅 review comment.
>> - Patch13: Move the 'set' declaration to the for() statement.
>>
>> v2->v3:
>> - Patch1: Add Kevin Wolf review comment.
>> - Patch2: Keep the 'flags' then use it(Base on Kevin's comments).
>> - Patch3: Add Kevin Wolf review comment.
>> - Patch9: Add Francisco Iglesias and Alistair Francis review comment.
>> - Patch10: Juan Quintela has added it to the queue and delete it.
>> - Patch12->Patch11: Add Philippe Mathieu-Daud茅 review comment.
>> - Patch13->Patch12: Add Philippe Mathieu-Daud茅 review comment.
>>
>> v3->v4:
>> - Deleted the patches that have been merged in the v3.
>> - Modify "scsi/esp-pci" Patch, use g_assert with variable size.
>>
>> v4->v5:
>> - Patch1: Add Laurent Vivier review comment and change the subject.
>> - Patch2: Use extract16() instead of delete bit operation statement.
>> - Patch3: Add Laurent Vivier review comment.
>>
>> Chen Qun (3):
>>  scsi/esp-pci: add g_assert() for fix clang analyzer warning in
>>    esp_pci_io_write()
>>  display/blizzard: use extract16() for fix clang analyzer warning in
>>    blizzard_draw_line16_32()
>>  timer/exynos4210_mct: Remove redundant statement in
>>    exynos4210_mct_write()
>>
>> hw/display/blizzard.c     | 10 ++++------
>> hw/scsi/esp-pci.c         |  1 +
>> hw/timer/exynos4210_mct.c |  4 ----
>> 3 files changed, 5 insertions(+), 10 deletions(-)
>>
>> --
>> 2.23.0
>>
> 


