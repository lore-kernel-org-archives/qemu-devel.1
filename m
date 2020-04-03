Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B200C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:23:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3371C20721
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3371C20721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKHbi-0001XV-DH
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 04:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jKHb0-00010U-61
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:22:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jKHaz-0005nr-5N
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:22:34 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:43403)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jKHaw-0005lp-RR; Fri, 03 Apr 2020 04:22:31 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M72wT-1jPVBK1Ryp-008dVf; Fri, 03 Apr 2020 10:22:21 +0200
Subject: Re: [PATCH v5 0/3] redundant code: Fix warnings reported by Clang
 static code analyzer
To: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
References: <20200325025919.21316-1-kuhn.chenqun@huawei.com>
 <7412CDE03601674DA8197E2EBD8937E83B6D495C@dggemm511-mbx.china.huawei.com>
 <b273c5c9-18cc-691f-bd1f-df056f448ade@vivier.eu>
 <7412CDE03601674DA8197E2EBD8937E83B6D4A27@dggemm511-mbx.china.huawei.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f2601173-f46d-ac93-c012-f715a52400ba@vivier.eu>
Date: Fri, 3 Apr 2020 10:22:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <7412CDE03601674DA8197E2EBD8937E83B6D4A27@dggemm511-mbx.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:q6Pb9/31V0V+KqGh/sSA+Ej/Ru3Qpfx7/pIA5KDPxAvsvWKMsNL
 eEqo3eMkAGVfJLY5LGnYQFbd179a2LHXbOSs6X3OA3AU48kzniaWncGQiIx5sM+YVf+M4Gh
 maKRTnZKBB6fEbbpOAHOV+05frgKnJyz1uyN8wt8qsrW3UCIkz2bovrFkkIyEpEDJEF3I3o
 kZTmnLdQ4rLcY12odktRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1QkKLD1D1Eg=:Pe9R+3zrfNiKCn2EbVJHe3
 Uy+ZDA9AJGcOHcdaLxeyjVrtKu9BkMdfxt/O5D8xYmkThbwf6I4Rv5XhgRlc90TswfVaFH+5r
 XQWbLuN1ijn/EB5dkvx+Gafcd8YegyaCpnWsaD0H6wfoFf7mw+BloT2S9ugzxeY/XgcwPHfeY
 z8R52fZuk3HN4+WJo78b+Vm8YH+X4cVpeLCRsGkXbKOFl3y/EqnwBpDTuCTS4MTnC7yXxOSwO
 KATm19T8ug9PJaTdwvdmeALsrErn70V+em2ChDteHXXkAvb6mIMqi573Pea/xmETulFr2tDFq
 RrtbfmRNPHIE4Ybw0OkQ5Bil7FSyhGMnFfv3ssZiriWs8b9vzWYzVlPmNNSUtN1ZG1Cg0npA5
 lMH2ftFGCC/73J4i+2RqIWWigRY+aX+M2ZOt69pAtPXyAVeXvLnYpYrhWcJur8sGyJYFeHqRA
 9EFquYq9CHMDcNgNY6BUjB0I2Cm3K1yFnlW6M9S5GY3XjAfQmUD3kTDC7phv8amnZ44dUzblc
 T9NDSTv3hSvZXOTDiOfCFMt79RBbzclRA64XtdHouuVe7DmKX2S4P8jg+wm+updFcmXahpn6f
 XE2cVOiHA8dKpxUkTnmsoFD5zhOB5iud0vBErsm2GmamC2L77CHAkJt9/iyCxO7F/Wxo13d1o
 IRB1gz9c9mKpSp0QMMSm+kMDTYCvWOwXShvRtHfHuomC5HkE84Lk9+pWUCBmHBBhwPd2AM+mN
 Ruj8VVkBUcT4IJMbNAtjCXbdM0xtsKWpD5zodwOp1qM3TwFjqibm5ICEClnbzarQRC+wHOju3
 qKt6MOBZRRzVL12eYuxAi8vBbVzP2hW/LkYGNkB5NsY+CUPT5ddrUOo5eIKGwK4ljXXEU5S
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
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

Le 03/04/2020 à 10:10, Chenqun (kuhn) a écrit :
>> -----Original Message-----
>> From: Laurent Vivier [mailto:laurent@vivier.eu]
>> Sent: Friday, April 3, 2020 4:04 PM
>> To: Chenqun (kuhn) <kuhn.chenqun@huawei.com>; qemu-devel@nongnu.org;
>> qemu-trivial@nongnu.org
>> Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>; philmd@redhat.com
>> Subject: Re: [PATCH v5 0/3] redundant code: Fix warnings reported by Clang
>> static code analyzer
>>
>> Le 03/04/2020 à 09:51, Chenqun (kuhn) a écrit :
>>> Ping!
>>>
>>> This series has been reviewed.  Could someone please pick this up (e.g. qemu-
>> trivial?)?
>>
>> As we are in hard feature freeze now and this is not critical bug fixes I'm going
>> to queue them for 5.1 except if you have good arguments to have them in 5.0.
>>
> OK,  I get it. 
> It is important to ensure a stable version!

Queued to my linux-user-for-5.1 queue.

Thanks,
Laurent

