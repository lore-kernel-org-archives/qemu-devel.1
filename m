Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C739C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 10:53:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4472220828
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 10:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4472220828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2vZd-0008Sy-E7
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 06:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gengdongjiu@huawei.com>) id 1i2vY1-0007rj-1R
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 06:51:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gengdongjiu@huawei.com>) id 1i2vXy-00066N-Tz
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 06:51:28 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44906 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gengdongjiu@huawei.com>)
 id 1i2vXw-0005V3-Kt; Wed, 28 Aug 2019 06:51:24 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id DA7BB340A07922D05D6B;
 Wed, 28 Aug 2019 18:51:14 +0800 (CST)
Received: from [127.0.0.1] (10.142.68.147) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Wed, 28 Aug 2019
 18:51:09 +0800
To: Peter Maydell <peter.maydell@linaro.org>
References: <1566898915-3129-1-git-send-email-gengdongjiu@huawei.com>
 <CAFEAcA-QunKkEW1BUXrEZVt+QP_Wc=dd0JJpnE+ypkPrca9TXw@mail.gmail.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <d42acb0d-5acf-f289-a55f-6257d1231fdf@huawei.com>
Date: Wed, 28 Aug 2019 18:50:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-QunKkEW1BUXrEZVt+QP_Wc=dd0JJpnE+ypkPrca9TXw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
X-Originating-IP: [10.142.68.147]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.32
Subject: Re: [Qemu-devel] [PATCH] hw/arm/boot: Load the Non Linux initrd to
 the memory
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/8/27 17:47, Peter Maydell wrote:
> On Tue, 27 Aug 2019 at 10:42, Dongjiu Geng <gengdongjiu@huawei.com> wro=
te:
>>
>> Except support linux operation system, qemu also supports other
>> operation system which is non linux, such as microkernel system.
>>
>> But now Qemu only load linux initrd, so change it to load both
>> linux and Non-linux initrd Image.
>=20
> We currently support two methods of booting:
>  (1) using the boot protocol defined by the Linux kernel
>      (which includes how to find the DTB, initrd, what the
>      secondary CPUs do, and so on)
>  (2) you're a 'bare-metal' image, in which case you get
>      complete control of all the CPUs at once in the same
>      way the hardware does. Raw hardware doesn't provide
>      initrd files, and nor does QEMU.
>=20
> This patch seems to be trying to introduce a third hybrid
> thing. Is there a specification for whatever this boot
> protocol is? How many guest OSes use it? Are they common?
>=20
> If you want an initrd, you can always wrap your guest OS in
> a shim which complies with the Linux kernel boot protocol.
> I think that would be a better approach than this patch.

OK=EF=BC=8C thanks for the suggestion, I will use your suggested method.

>=20
> thanks
> -- PMM
> .
>=20


