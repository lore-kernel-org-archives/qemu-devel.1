Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A072C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 01:46:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB7A520833
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 01:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7A520833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45858 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDJMz-00032z-4Q
	for qemu-devel@archiver.kernel.org; Sun, 07 Apr 2019 21:46:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guoheyi@huawei.com>) id 1hDJM9-0002ib-LA
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 21:45:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guoheyi@huawei.com>) id 1hDJM8-0005aJ-GB
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 21:45:53 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59174 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <guoheyi@huawei.com>)
	id 1hDJM5-0005VI-NU; Sun, 07 Apr 2019 21:45:50 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id EB38DE45BE85DA402998;
	Mon,  8 Apr 2019 09:45:43 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.55) by DGGEMS409-HUB.china.huawei.com
	(10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Mon, 8 Apr 2019
	09:45:33 +0800
To: Peter Maydell <peter.maydell@linaro.org>
References: <1554624893-8363-1-git-send-email-guoheyi@huawei.com>
	<CAFEAcA-N=y3k41oexvYaQ+tKj1d2tCZh8MhPvdq8Uz7dh-eWWA@mail.gmail.com>
From: Heyi Guo <guoheyi@huawei.com>
Message-ID: <cb3534ef-2bd0-0518-c6ca-01c1f6511199@huawei.com>
Date: Mon, 8 Apr 2019 09:45:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
	Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-N=y3k41oexvYaQ+tKj1d2tCZh8MhPvdq8Uz7dh-eWWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.55]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.32
Subject: Re: [Qemu-devel] [RFC] arm/virt: add one more uart for UEFI runtime
 debug
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: wanghaibin.wang@huawei.com, qemu-arm <qemu-arm@nongnu.org>,
	Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408014532.pYo0pCEQvZT7ocx6rUBPZWZWBnnM-qE3oOpJD-qZx3c@z>



On 2019/4/7 21:16, Peter Maydell wrote:
> On Sun, 7 Apr 2019 at 09:19, Heyi Guo <guoheyi@huawei.com> wrote:
>> This patch is based on the discussion in TianoCore edk2-devel mailing
>> list:
>> https://lists.01.org/pipermail/edk2-devel/2019-March/037986.html
>>
>> The conclusion is that we need an individual UART for UEFI runtime
>> services to print debug message at runtime, to avoid conflicting with
>> the system UART. We cannot use the secure UART either, for we may both
>> have Trusted Firmware and UEFI runtime services running on the VM, and
>> it is not easy to keep synchronization between the two components.
> I don't think it makes much sense to keep adding UARTs for every
> bit of the system software stack. We don't have an infinite
> supply of UARTs on real hardware either -- how is this handled
> there ?
As you were in the edk2 mail thread, I supposed you also agreed to add one more UART. What did you mean by "I do still have a todo list item to add a 2nd UART"? How shall we do that?

On our real hardware platforms, we don't have a separate serial port for UEFI runtime services; that's the reason for why I had wanted to have an adaptable approach for platform without one more serial port...

>
> Also adding new UARTs to this board is awkward because of
> the weird choices various bits of software have made in
> reading the dtb and picking a UART if there's more than one
> listed.
>
>> @@ -713,13 +715,23 @@ static void create_uart(const VirtMachineState *vms, qemu_irq *pic, int uart,
>>       if (uart == VIRT_UART) {
>>           qemu_fdt_setprop_string(vms->fdt, "/chosen", "stdout-path", nodename);
>>       } else {
>> +        const char *status_string;
>> +
>> +        if (uart == VIRT_SECURE_UART) {
>> +            status_string = "secure-status";
>> +        } else {
>> +            status_string = "uefi-status";
> Where does this status string come from? The "secure-status" one
> is documented in the device tree spec and has a well defined
> meaning.
Sorry this came from my imagination, so I sent it as a "RFC" :)

Thanks,
Heyi

>
> thanks
> -- PMM
>
> .
>



