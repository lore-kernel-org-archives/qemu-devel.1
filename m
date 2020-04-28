Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32C1C83002
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 02:47:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6134206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 02:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6134206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTGHl-0006nQ-Ip
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 22:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <colin.xu@intel.com>) id 1jTGGf-0005U7-0B
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 22:46:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <colin.xu@intel.com>) id 1jTGGP-0002IT-RS
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 22:46:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:21503)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <colin.xu@intel.com>)
 id 1jTGGP-0002Hg-8g
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 22:46:25 -0400
IronPort-SDR: XhlPvrIvRY92sPf+r6bTL0GmnphWjA76qn52VdMM1dwBbeaWutZTAJFQy/5ULU64dOV7l83XtF
 PtX6wdgsVE2g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2020 19:46:23 -0700
IronPort-SDR: e7T7q1v8d+eHTi4Bb6tqtepkhtkEcEglY8yULtCYAElahztBorP2FVmi/FPIY45qT7UwV3nrHB
 1hdmzzMZ1FZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,326,1583222400"; d="scan'208";a="260947081"
Received: from unknown (HELO coxu-arch-shz) ([10.239.160.120])
 by orsmga006.jf.intel.com with ESMTP; 27 Apr 2020 19:46:21 -0700
Date: Tue, 28 Apr 2020 10:46:20 +0800 (CST)
From: Colin Xu <colin.xu@intel.com>
X-X-Sender: coxu_arch@coxu-arch-shz
To: Colin Xu <colin.xu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] hax: Add hax max vcpu IOCTL and support 64 vcpu
In-Reply-To: <alpine.LNX.2.22.419.2004201131460.21524@coxu-arch-shz>
Message-ID: <alpine.LNX.2.22.419.2004281045410.5289@coxu-arch-shz>
References: <20200410045751.3448-1-bowen.wang@intel.com>
 <alpine.LNX.2.22.419.2004201131460.21524@coxu-arch-shz>
User-Agent: Alpine 2.22 (LNX 419 2020-04-12)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=134.134.136.100; envelope-from=colin.xu@intel.com;
 helo=mga07.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 22:45:07
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 134.134.136.100
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
Cc: WangBowen <bowen.wang@intel.com>, qemu-devel@nongnu.org,
 wenchao.wang@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paolo,

Would you also help queue this one for PULL?

--
Best Regards,
Colin Xu

On Mon, 20 Apr 2020, Colin Xu wrote:

> Looks good to me.
>
> Reviewed-by: Colin Xu <colin.xu@intel.com>
>
> --
> Best Regards,
> Colin Xu
>
> On Fri, 10 Apr 2020, WangBowen wrote:
>
>> This commit tried to obtain max vcpu of haxm driver by calling
>> HAX_IOCTL_CAP_MAX_VCPU before creating the vm so that if using hax as
>> the accelerator and the smp value is larger than the haxm driver
>> supported max value, the program will terminate. Previously, it will
>> create vm and vcpu one by one until haxm reports error. Also, the
>> maximum vcpu value in qemu for haxm is updated from 0x10 to 0x40 in
>> hax-i386.h.
>> 
>> This patch resolves the issue by calling hax device ioctl
>> HAX_IOCTL_CAP_MAX_VCPU in hax_init and store the min(haxm max, qemu max)
>> in hax_state structure. The value will be compared with smp value in
>> vm_create. (ioctl naming credit to KVM)
>> 
>> This commit results in if ioctl doesn't exist or occur error, it will
>> continue running but output warning, if smp value is larger than the
>> min(hax max,qemu max), it will terminate and output error message.
>> 
>> Signed-off-by: WangBowen <bowen.wang@intel.com>
>> ---
>> target/i386/hax-all.c     |  7 +++++--
>> target/i386/hax-i386.h    |  4 +++-
>> target/i386/hax-posix.c   | 29 +++++++++++++++++++++++++++++
>> target/i386/hax-posix.h   |  1 +
>> target/i386/hax-windows.c | 32 ++++++++++++++++++++++++++++++++
>> target/i386/hax-windows.h |  2 ++
>> 6 files changed, 72 insertions(+), 3 deletions(-)
>> 
>> diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
>> index a22adec5da..eadfa7c881 100644
>> --- a/target/i386/hax-all.c
>> +++ b/target/i386/hax-all.c
>> @@ -259,8 +259,9 @@ struct hax_vm *hax_vm_create(struct hax_state *hax, int 
>> max_cpus)
>>         goto error;
>>     }
>> 
>> -    if (max_cpus > HAX_MAX_VCPU) {
>> -        fprintf(stderr, "Maximum VCPU number QEMU supported is %d\n", 
>> HAX_MAX_VCPU);
>> +    if (max_cpus > hax->hax_max_vcpu) {
>> +        fprintf(stderr, "Maximum VCPU number QEMU and HAXM driver 
>> supported is %d\n",
>> +                hax->hax_max_vcpu);
>>         goto error;
>>     }
>> 
>> @@ -332,6 +333,8 @@ static int hax_init(ram_addr_t ram_size, int max_cpus)
>>         goto error;
>>     }
>> 
>> +    hax->hax_max_vcpu = hax_max_vcpus_support(hax);
>> +
>>     if (!hax_version_support(hax)) {
>>         ret = -EINVAL;
>>         goto error;
>> diff --git a/target/i386/hax-i386.h b/target/i386/hax-i386.h
>> index 7d988f81da..1ffa8df63a 100644
>> --- a/target/i386/hax-i386.h
>> +++ b/target/i386/hax-i386.h
>> @@ -38,9 +38,10 @@ struct hax_state {
>>     struct hax_vm *vm;
>>     uint64_t mem_quota;
>>     bool supports_64bit_ramblock;
>> +    int hax_max_vcpu;
>> };
>> 
>> -#define HAX_MAX_VCPU 0x10
>> +#define HAX_MAX_VCPU 0x40
>> #define MAX_VM_ID 0x40
>> #define MAX_VCPU_ID 0x40
>> 
>> @@ -74,6 +75,7 @@ int hax_notify_qemu_version(hax_fd vm_fd, struct 
>> hax_qemu_version *qversion);
>> int hax_set_ram(uint64_t start_pa, uint32_t size, uint64_t host_va, int 
>> flags);
>> 
>> /* Common host function */
>> +int hax_max_vcpus_support(struct hax_state *hax);
>> int hax_host_create_vm(struct hax_state *hax, int *vm_id);
>> hax_fd hax_host_open_vm(struct hax_state *hax, int vm_id);
>> int hax_host_create_vcpu(hax_fd vm_fd, int vcpuid);
>> diff --git a/target/i386/hax-posix.c b/target/i386/hax-posix.c
>> index a5426a6dac..a4f9dce55e 100644
>> --- a/target/i386/hax-posix.c
>> +++ b/target/i386/hax-posix.c
>> @@ -163,6 +163,35 @@ int hax_host_create_vm(struct hax_state *hax, int 
>> *vmid)
>>     return ret;
>> }
>> 
>> +int hax_max_vcpus_support(struct hax_state *hax)
>> +{
>> +    int ret;
>> +    int vcpu_num = 0;
>> +
>> +    if (hax_invalid_fd(hax->fd)) {
>> +        return vcpu_num;
>> +    }
>> +
>> +    ret = ioctl(hax->fd, HAX_IOCTL_CAP_MAX_VCPU, &vcpu_num);
>> +
>> +    if (ret == 0 && vcpu_num > 0) {
>> +        if (vcpu_num != HAX_MAX_VCPU) {
>> +            fprintf(stderr, "Warning: HAXM driver and QEMU are 
>> inconsistent"
>> +                    " in max vcpu number, HAXM driver: %d, QEMU: %d,"
>> +                    " refers to the smaller one.\n", vcpu_num, 
>> HAX_MAX_VCPU);
>> +            if (vcpu_num > HAX_MAX_VCPU) {
>> +                vcpu_num = HAX_MAX_VCPU;
>> +            }
>> +        }
>> +    } else {
>> +        vcpu_num = HAX_MAX_VCPU;
>> +        fprintf(stderr, "Warning: HAXM driver doesn't support 
>> HAX_IOCTL_CAP_MAX_VCPU,"
>> +                " will refer to max value defined in QEMU\n");
>> +    }
>> +
>> +    return vcpu_num;
>> +}
>> +
>> hax_fd hax_host_open_vm(struct hax_state *hax, int vm_id)
>> {
>>     hax_fd fd;
>> diff --git a/target/i386/hax-posix.h b/target/i386/hax-posix.h
>> index fb7c64426d..42e58f6fa5 100644
>> --- a/target/i386/hax-posix.h
>> +++ b/target/i386/hax-posix.h
>> @@ -38,6 +38,7 @@ static inline void hax_close_fd(hax_fd fd)
>> #define HAX_IOCTL_CREATE_VM _IOWR(0, 0x21, uint32_t)
>> #define HAX_IOCTL_DESTROY_VM _IOW(0, 0x22, uint32_t)
>> #define HAX_IOCTL_CAPABILITY _IOR(0, 0x23, struct hax_capabilityinfo)
>> +#define HAX_IOCTL_CAP_MAX_VCPU _IOR(0, 0x25, uint32_t)
>> 
>> #define HAX_VM_IOCTL_VCPU_CREATE _IOWR(0, 0x80, uint32_t)
>> #define HAX_VM_IOCTL_ALLOC_RAM _IOWR(0, 0x81, struct hax_alloc_ram_info)
>> diff --git a/target/i386/hax-windows.c b/target/i386/hax-windows.c
>> index 5729ad9b48..c7816e1950 100644
>> --- a/target/i386/hax-windows.c
>> +++ b/target/i386/hax-windows.c
>> @@ -249,6 +249,38 @@ int hax_host_create_vm(struct hax_state *hax, int 
>> *vmid)
>>     return 0;
>> }
>> 
>> +int hax_max_vcpus_support(struct hax_state *hax)
>> +{
>> +    int ret;
>> +    int vcpu_num = 0;
>> +    DWORD dSize = 0;
>> +
>> +    if (hax_invalid_fd(hax->fd)) {
>> +        return vcpu_num;
>> +    }
>> +
>> +    ret = DeviceIoControl(hax->fd,
>> +                          HAX_IOCTL_CAP_MAX_VCPU,
>> +                          NULL, 0, &vcpu_num, sizeof(vcpu_num), &dSize,
>> +                          (LPOVERLAPPED) NULL);
>> +    if (ret && vcpu_num > 0) {
>> +        if (vcpu_num != HAX_MAX_VCPU) {
>> +            fprintf(stderr, "Warning: HAXM driver and QEMU are 
>> inconsistent"
>> +                    " in max vcpu number, HAXM driver: %d, QEMU: %d,"
>> +                    " refers to the smaller one.\n", vcpu_num, 
>> HAX_MAX_VCPU);
>> +            if (vcpu_num > HAX_MAX_VCPU) {
>> +                vcpu_num = HAX_MAX_VCPU;
>> +            }
>> +        }
>> +    } else {
>> +        vcpu_num = HAX_MAX_VCPU;
>> +        fprintf(stderr, "Warning: HAXM driver doesn't support 
>> HAX_IOCTL_CAP_MAX_VCPU,"
>> +                " will refer to max value defined in QEMU\n");
>> +    }
>> +
>> +    return vcpu_num;
>> +}
>> +
>> hax_fd hax_host_open_vm(struct hax_state *hax, int vm_id)
>> {
>>     char *vm_name = NULL;
>> diff --git a/target/i386/hax-windows.h b/target/i386/hax-windows.h
>> index 12cbd813dc..c4fa88a2fa 100644
>> --- a/target/i386/hax-windows.h
>> +++ b/target/i386/hax-windows.h
>> @@ -48,6 +48,8 @@ static inline int hax_invalid_fd(hax_fd fd)
>>                                          METHOD_BUFFERED, FILE_ANY_ACCESS)
>> #define HAX_IOCTL_CAPABILITY    CTL_CODE(HAX_DEVICE_TYPE, 0x910, \
>>                                          METHOD_BUFFERED, FILE_ANY_ACCESS)
>> +#define HAX_IOCTL_CAP_MAX_VCPU  CTL_CODE(HAX_DEVICE_TYPE, 0x917, \
>> +                                         METHOD_BUFFERED, FILE_ANY_ACCESS)
>> 
>> #define HAX_VM_IOCTL_VCPU_CREATE   CTL_CODE(HAX_DEVICE_TYPE, 0x902, \
>>                                             METHOD_BUFFERED, 
>> FILE_ANY_ACCESS)
>> -- 
>> 2.24.1
>> 
>> 
>

