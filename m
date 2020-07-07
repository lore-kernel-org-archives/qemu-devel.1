Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE5EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 23:29:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0AA520775
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 23:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0AA520775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsx1d-0008Jz-9C
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 19:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1jsx0t-0007or-OK; Tue, 07 Jul 2020 19:28:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1330)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1jsx0r-0003Im-7p; Tue, 07 Jul 2020 19:28:35 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 067N3IhO113048; Tue, 7 Jul 2020 19:28:26 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3251musd9s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2020 19:28:26 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 067N858o128049;
 Tue, 7 Jul 2020 19:28:26 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3251musd9d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2020 19:28:25 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 067NPqDx006970;
 Tue, 7 Jul 2020 23:28:24 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma02wdc.us.ibm.com with ESMTP id 324b3jh6er-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2020 23:28:24 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 067NSNo823593432
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2020 23:28:23 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C2477805C;
 Tue,  7 Jul 2020 23:28:23 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 108C87805E;
 Tue,  7 Jul 2020 23:28:21 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.211.127.86])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Tue,  7 Jul 2020 23:28:21 +0000 (GMT)
References: <20200707204333.261506-1-bauerman@linux.ibm.com>
 <20200707214917.GX7276@habkost.net>
User-agent: mu4e 1.2.0; emacs 26.3
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH] cpu: Add starts_halted() method
In-reply-to: <20200707214917.GX7276@habkost.net>
Date: Tue, 07 Jul 2020 20:28:17 -0300
Message-ID: <87y2nu3nxq.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-07_14:2020-07-07,
 2020-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 adultscore=0 suspectscore=0 cotscore=-2147483648
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007070146
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=bauerman@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 19:28:31
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Hello Eduardo,

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Tue, Jul 07, 2020 at 05:43:33PM -0300, Thiago Jung Bauermann wrote:
>> PowerPC sPAPRs CPUs start in the halted state, but generic QEMU code
>> assumes that CPUs start in the non-halted state. spapr_reset_vcpu()
>> attempts to rectify this by setting CPUState::halted to 1. But that's too
>> late for hotplugged CPUs in a machine configured with 2 or mor threads per
>> core.
>>
>> By then, other parts of QEMU have already caused the vCPU to run in an
>> unitialized state a couple of times. For example, ppc_cpu_reset() calls
>> ppc_tlb_invalidate_all(), which ends up calling async_run_on_cpu(). This
>> kicks the new vCPU while it has CPUState::halted = 0, causing QEMU to issue
>> a KVM_RUN ioctl on the new vCPU before the guest is able to make the
>> start-cpu RTAS call to initialize its register state.
>>
>> This doesn't seem to cause visible issues for regular guests, but on a
>> secure guest running under the Ultravisor it does. The Ultravisor relies on
>> being able to snoop on the start-cpu RTAS call to map vCPUs to guests, and
>> this issue causes it to see a stray vCPU that doesn't belong to any guest.
>>
>> Fix by adding a starts_halted() method to the CPUState class, and making it
>> return 1 if the machine is an sPAPR guest.
>>
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> [...]
>> +static uint32_t ppc_cpu_starts_halted(void)
>> +{
>> +    SpaprMachineState *spapr =
>> +        (SpaprMachineState *) object_dynamic_cast(qdev_get_machine(),
>> +                                                  TYPE_SPAPR_MACHINE);
>
> Wouldn't it be simpler to just implement this as a MachineClass
> boolean field?  e.g.:
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Yes, indeed it would. Thanks for this patch. I just tested and it
also solves the problem (except for the nit mentioned below).

Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Should I submit a proper patch with these changes (with you as the
author)?

> ---
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 426ce5f625..ffadc7a17d 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -215,6 +215,7 @@ struct MachineClass {
>      bool nvdimm_supported;
>      bool numa_mem_supported;
>      bool auto_enable_numa;
> +    bool cpu_starts_halted;
>      const char *default_ram_id;
>
>      HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
> diff --git a/hw/core/cpu.c b/hw/core/cpu.c
> index 0f23409f1d..08dd504034 100644
> --- a/hw/core/cpu.c
> +++ b/hw/core/cpu.c
> @@ -252,6 +252,7 @@ static void cpu_common_reset(DeviceState *dev)
>  {
>      CPUState *cpu = CPU(dev);
>      CPUClass *cc = CPU_GET_CLASS(cpu);
> +    MachineState *machine = object_dynamic_cast(qdev_get_machine(), TYPE_MACHINE);

I had to add a (MachineState *) cast here to get the code to compile.

>
>      if (qemu_loglevel_mask(CPU_LOG_RESET)) {
>          qemu_log("CPU Reset (CPU %d)\n", cpu->cpu_index);
> @@ -259,7 +260,7 @@ static void cpu_common_reset(DeviceState *dev)
>      }
>
>      cpu->interrupt_request = 0;
> -    cpu->halted = 0;
> +    cpu->halted = machine ? MACHINE_GET_CLASS(machine)->cpu_starts_halted : 0;
>      cpu->mem_io_pc = 0;
>      cpu->icount_extra = 0;
>      atomic_set(&cpu->icount_decr_ptr->u32, 0);
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f6f034d039..d16ec33033 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4487,6 +4487,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>      mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.0");
>      mc->has_hotpluggable_cpus = true;
>      mc->nvdimm_supported = true;
> +    mc->cpu_starts_halted = true;
>      smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
>      fwc->get_dev_path = spapr_get_fw_dev_path;
>      nc->nmi_monitor_handler = spapr_nmi;
>
>> +
>> +    /*
>> +     * In sPAPR, all CPUs start halted. CPU0 is unhalted from the machine level
>> +     * reset code and the rest are explicitly started up by the guest using an
>> +     * RTAS call.
>> +     */
>> +    return spapr != NULL;
>> +}
>> +


--
Thiago Jung Bauermann
IBM Linux Technology Center

