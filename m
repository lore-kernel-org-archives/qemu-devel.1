Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05991C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 09:16:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8989D2089E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 09:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8989D2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48116 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM7pL-0005pk-MH
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 05:16:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hM7oH-0005AL-GE
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hM7oG-0008As-JO
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:15:21 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:49441)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hM7oE-0006yX-JB; Thu, 02 May 2019 05:15:20 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1MI4gb-1ha5zK2AwJ-00FDFv; Thu, 02 May 2019 11:12:09 +0200
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
	<philmd@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20190427141459.19728-1-philmd@redhat.com>
	<20190427141459.19728-4-philmd@redhat.com>
	<bb31dd2a-8cd6-0dfe-a71f-4c47ec3d9687@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <65906ce9-944a-0845-5126-2355b1a2f150@vivier.eu>
Date: Thu, 2 May 2019 11:12:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <bb31dd2a-8cd6-0dfe-a71f-4c47ec3d9687@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/q9Tv0oureixicFJ1lTQcd4rLDvlZmO/T9rSCmAQVxUOwNHBbn8
	GcaJVq+sLynv6AneP6qKgebMB6AUcpOVMDIR7w2ae5NRfjlwz3XtkiMorrhDhLXd8N3vAHC
	t0zY0uUyPN6vG5viaU938/620Ufdh4nCnfbvMo422+ssBuu1VnP3JT6ZZbpcIL04/NFTmKE
	5NPB7RbA/M/YTikdWgxTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FLL73RMG2rE=:BBNdAeIKr6GHiMchOffGql
	4M7TESNYwCTQdRKCVlK/BvMc7jNooE2cL0PGT5IUPKOzz/kbpu+iFPaCBt54jMVVl43KbMrtx
	TUiVADpgGFZy0hv5Tp85chW5AyDDrkmZo8iildKYXsvK8E2ueZIgJDTF9kzfRgrXn+eU+f6jc
	oM/PhzJEvs/yGBzFRWUTPgRqodNaJRsO2COgEtk2accXxdK0RXlr/4CNHW9SKPwynlxEuQI03
	SA6EBCobyCDUUhi/0MqDInFD7k/zP8I+zvsYdCQSqayuRYvBsqxmrWNjEbQCNfUMLxfvUIB9Q
	QUs05oqMJZ0yMA3vwtfOCcdkETjZjYclMIxj5GvxE5NVmfOF0GWoVS3SeycSCYLaV1ZH12LMV
	kEGBJsnXG23hBBcKRavC8fWMq5X3hvxC7VNEayqLtGDmltwixiX69XnxxsiAcLI/P/nV1zFU5
	zK6nSw70kk6oN2NbwtKh6dNrIN1xesUrwBJVeoOZ72h6fGUKQ4EmenaGwVGNxpR+inGcProIz
	kr9BzaCpsW7RCaIDVmfJWOEWgiRmG8bv9ZJ/p3OKCSFOL0LZCjPDTSvYgoxHm/gy8KHFKwqjk
	oy/WMdifgyTbawra6amOpxDfhNVLtiCa8yJ5i1+Ub7mSFEtkdqKz6Ow6DdsM/f3Jy7mn5mDDP
	+zAsXq/E8zZjXU7f/LsiU3zFWpqY7psg86eXTsUDlpcHzXBTrWCef3FHQyCZl1/rJ+rP8yvSh
	P4FG4kvLUNcs2/Rhe1mlBXGL6Pb9fogB16UDlzJYHdIpSXfzAvleeHhuUdw=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH 3/3] hw/dma: Do not build
 the xlnx_dpdma device for the MicroBlaze machines
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Peter Maydell <peter.maydell@linaro.org>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502091208.YHH6bV6aOjQVTzgP89U28CviIFDB2RZRVkdE5_i40DY@z>

On 27/04/2019 16:46, Thomas Huth wrote:
> On 27/04/2019 16.14, Philippe Mathieu-Daudé wrote:
>> The xlnx_dpdma device is only used by the ZynqMP AArch64 machine
>> (not the MicroBlaze PMU). Remove it from the ZynqMP generic objects.
>> (Note, this entry was duplicated for the AArch64).
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  hw/dma/Makefile.objs | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/hw/dma/Makefile.objs b/hw/dma/Makefile.objs
>> index 79affecc390..a5b1276f52a 100644
>> --- a/hw/dma/Makefile.objs
>> +++ b/hw/dma/Makefile.objs
>> @@ -8,7 +8,6 @@ common-obj-$(CONFIG_XILINX_AXI) += xilinx_axidma.o
>>  common-obj-$(CONFIG_ZYNQ_DEVCFG) += xlnx-zynq-devcfg.o
>>  common-obj-$(CONFIG_ETRAXFS) += etraxfs_dma.o
>>  common-obj-$(CONFIG_STP2000) += sparc32_dma.o
>> -obj-$(CONFIG_XLNX_ZYNQMP) += xlnx_dpdma.o
>>  obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx_dpdma.o
>>  common-obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx-zdma.o
>>  
>>
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

