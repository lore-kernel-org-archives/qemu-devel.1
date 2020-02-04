Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AEEC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:53:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D8CD2082E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uh61r0ev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D8CD2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyyds-0005cs-B3
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 08:53:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1iyydH-0004yd-5e
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:52:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1iyydG-00043o-34
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:52:51 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54129)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1iyydF-0003pl-Rr
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:52:50 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200204135246euoutp0271568f22ca7013bd6f3308205b9ec08b~wN2LV2xA62970929709euoutp02D
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 13:52:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200204135246euoutp0271568f22ca7013bd6f3308205b9ec08b~wN2LV2xA62970929709euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580824366;
 bh=xjlXSJKRhLmXo312u29NGHLXgTrGAKzhiX3732kJ8aM=;
 h=To:Subject:Cc:From:Date:References:From;
 b=uh61r0evS6o96Vg2UniN0yHH82u+rOM/qKIOfbbq4eB+bnz39WuWjLCOjhjKM+QnE
 /00TNHy/UVUNNpRrWGr9HIZwVkwlmWJytwvTqa3TICbdV57SWhZGhMbCZXZNkq4AFd
 txs/lVUssujoOkLw2vwNA9hC9uE+RnsWC1I2hhlA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200204135246eucas1p2882ea79765740fdc9133a60f1f74eba9~wN2LKcyDB0100401004eucas1p2W;
 Tue,  4 Feb 2020 13:52:46 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 81.55.61286.E27793E5; Tue,  4
 Feb 2020 13:52:46 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200204135246eucas1p1a61f44fc7b057dd242d0d98d5b3e2414~wN2K4T84Q0242502425eucas1p1w;
 Tue,  4 Feb 2020 13:52:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200204135246eusmtrp16f29b065c8508b453e8a8f9ade26a270~wN2K3w_4J0571105711eusmtrp15;
 Tue,  4 Feb 2020 13:52:46 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-26-5e39772e52c4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 2F.F0.08375.E27793E5; Tue,  4
 Feb 2020 13:52:46 +0000 (GMT)
Received: from [106.120.51.21] (unknown [106.120.51.21]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200204135246eusmtip2d01200730ed987fcef59eec02f6ae2ef~wN2KpzYcX2867328673eusmtip29;
 Tue,  4 Feb 2020 13:52:46 +0000 (GMT)
To: david@redhat.com
Subject: Re: [PATCH v1 06/13] util/mmap-alloc: Factor out reserving of a
 memory region to mmap_reserve()
From: =?UTF-8?Q?Igor_Kotrasi=c5=84ski?= <i.kotrasinsk@partner.samsung.com>
Message-ID: <f7a85b6b-71a9-4952-a406-a7be4edc2356@partner.samsung.com>
Date: Tue, 4 Feb 2020 14:52:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsWy7djPc7p65ZZxBu+/KVh8Xf+L2eJ47w4W
 ByaPJ9c2M3m833eVLYApissmJTUnsyy1SN8ugStj284VbAX7mSv+fXZuYPzB1MXIySEhYCLR
 9eksWxcjF4eQwApGiaZbh1ggnC+MEu87X0E5nxklfs14wwzT8vT5dhYQW0hgOaPE7u2MEPZb
 RokDU81BbBEBEYkfD1+CxYUFsiQ+HvzPDmIzC0hKLL56kRXEZhPwkrg/cSVYDa+Am8StZceB
 4hwcLAIqEv+bxEFMUYEIidNfEyEqBCVOznzCAjFFXmL72znMELa4xK0n85lAzpQQeM4m8fB4
 B9RnLhKPm1eyQdjCEq+Ob2GHsGUkTk/uYYGw6yVa7uyAau5glOhbOR2qwVriy4alLCBHMAto
 SqzfpQ9iSgg4SlzarQ1h8knceCsIcQKfxKRt05khwrwSHW1CEDP0JLqf3GSCWbqs8RHUUg+J
 XZuusk5gVJyF5LFZSB6bheSxWQgnLGBkWcUonlpanJueWmyYl1quV5yYW1yal66XnJ+7iRGY
 Kk7/O/5pB+PXS0mHGAU4GJV4eC/YWcQJsSaWFVfmHmKU4GBWEuE9r28ZJ8SbklhZlVqUH19U
 mpNafIhRmoNFSZzXeNHLWCGB9MSS1OzU1ILUIpgsEwenVAOjRdBGw+lBrfcKq3rCbQ5Fei+5
 PP3Wl37T8v8LfNb2OSz94FxZ0dX0O690gtLmi6/Wt+l1yQk+OZMSr3ptkew5P0OLglm9XxfG
 7M88GbfD4Zzimr9TK5hd+P4s8Vt9T2DLmsUGe2NyzxiUh2Uu3FCT8q3j5J6V0oeFs+ufzH9n
 MOGbwj3BHSsNlFiKMxINtZiLihMB7sz3ohEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42I5/e/4PV29css4g+UPBCy+rv/FbHG8dweL
 A5PHk2ubmTze77vKFsAUpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eT
 kpqTWZZapG+XoJexbecKtoL9zBX/Pjs3MP5g6mLk5JAQMJF4+nw7SxcjF4eQwFJGiYbpE9gh
 EjISP06vYYOwhSX+XOtigyh6zSixdOUJsCIRARGJHw9fMnYxcgAluCVWNweBhIUFsiQ+HvwP
 VsIsICmx+OpFVhCbTcBL4v7ElYwgNq+Am8StZcdZQVpZBFQk/jeJg4RFBSIknm+/AVUiKHFy
 5hMWiDFmEvM2P2SGsOUltr+dA2WLS9x6Mp9pAqPgLCQts5C0zELSMgtJywJGllWMIqmlxbnp
 ucWGesWJucWleel6yfm5mxiBkbDt2M/NOxgvbQw+xCjAwajEw3vBziJOiDWxrLgy9xCjBAez
 kgjveX3LOCHelMTKqtSi/Pii0pzU4kOMpkD/TGSWEk3OB0ZpXkm8oamhuYWlobmxubGZhZI4
 b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGxpkmER2V9/80Pk8xWyT7Or2oNt3Q+1fQshj7HWIJ
 PCk9PMm/zDd/6t0sKs8j9zjwf1n8GYmGz9zr8+seritfUfjHKpJzivzbmJCC6RrWBxLZxVfW
 FYtzduo7blJivHT//aE5eT4ejc6/j5Wxrz7xqW5SyZb0FfHnDqoUyGzKWrbL4uvq1AOblViK
 MxINtZiLihMBd1rSJpoCAAA=
X-CMS-MailID: 20200204135246eucas1p1a61f44fc7b057dd242d0d98d5b3e2414
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204135246eucas1p1a61f44fc7b057dd242d0d98d5b3e2414
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204135246eucas1p1a61f44fc7b057dd242d0d98d5b3e2414
References: <CGME20200204135246eucas1p1a61f44fc7b057dd242d0d98d5b3e2414@eucas1p1.samsung.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 210.118.77.12
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> We want to reserve a memory region without actually populating memory.
> Let's factor that out.
>
> Cc: "Michael S. Tsirkin" <address@hidden>
> Cc: Greg Kurz <address@hidden>
> Cc: Murilo Opsfelder Araujo <address@hidden>
> Cc: Eduardo Habkost <address@hidden>
> Cc: "Dr. David Alan Gilbert" <address@hidden>
> Signed-off-by: David Hildenbrand <address@hidden>
> ---
Reviewed-by: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>


