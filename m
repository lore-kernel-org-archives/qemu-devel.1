Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0506FC33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 20:20:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4591206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 20:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4591206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isBcY-0004mb-Ug
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 15:20:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mjrosato@linux.ibm.com>) id 1isBbu-0004KN-Jt
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 15:19:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mjrosato@linux.ibm.com>) id 1isBbs-00027j-MW
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 15:19:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61680)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mjrosato@linux.ibm.com>)
 id 1isBbs-000275-Dk; Thu, 16 Jan 2020 15:19:20 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00GKDFAV133762; Thu, 16 Jan 2020 15:19:19 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xhm363spr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jan 2020 15:19:18 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 00GKDIIb134053;
 Thu, 16 Jan 2020 15:19:18 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xhm363spb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jan 2020 15:19:18 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00GKGxP5009572;
 Thu, 16 Jan 2020 20:19:17 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma03wdc.us.ibm.com with ESMTP id 2xhmfa2dtf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jan 2020 20:19:17 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 00GKJGr563046122
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jan 2020 20:19:16 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F06FF7805E;
 Thu, 16 Jan 2020 20:19:15 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 057837805F;
 Thu, 16 Jan 2020 20:19:14 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.80.227.51])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jan 2020 20:19:13 +0000 (GMT)
Subject: Re: [PATCH] target/s390x/kvm: Enable adapter interruption suppression
 again
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org
References: <20200116122026.5804-1-thuth@redhat.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <ad421fc1-8241-3c73-e597-aebb3fc8a309@linux.ibm.com>
Date: Thu, 16 Jan 2020 15:19:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200116122026.5804-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-16_05:2020-01-16,
 2020-01-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001160163
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/16/20 7:20 AM, Thomas Huth wrote:
> The AIS feature has been disabled late in the v2.10 development
> cycle since there were some issues with migration (see commit
> 3f2d07b3b01ea61126b - "s390x/ais: for 2.10 stable: disable ais
> facility"). We originally wanted to enable it again for newer
> machine types, but apparently we forgot to do this so far. Let's
> do it for the new s390-ccw-virtio-5.0 machine now.
> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1756946
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/s390x/s390-virtio-ccw.c         |  4 ++++
>   include/hw/s390x/s390-virtio-ccw.h |  4 ++++
>   target/s390x/kvm.c                 | 11 ++++++++---
>   3 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index e7eadd14e8..6f43136396 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -456,6 +456,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
>       s390mc->cpu_model_allowed = true;
>       s390mc->css_migration_enabled = true;
>       s390mc->hpage_1m_allowed = true;
> +    s390mc->kvm_ais_allowed = true;
>       mc->init = ccw_init;
>       mc->reset = s390_machine_reset;
>       mc->hot_add_cpu = s390_hot_add_cpu;
> @@ -662,6 +663,9 @@ static void ccw_machine_4_2_instance_options(MachineState *machine)
>   
>   static void ccw_machine_4_2_class_options(MachineClass *mc)
>   {
> +    S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
> +
> +    s390mc->kvm_ais_allowed = false;
>       ccw_machine_5_0_class_options(mc);
>       compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
>   }
> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
> index 8aa27199c9..f142d379c6 100644
> --- a/include/hw/s390x/s390-virtio-ccw.h
> +++ b/include/hw/s390x/s390-virtio-ccw.h
> @@ -21,6 +21,9 @@
>   #define S390_MACHINE_CLASS(klass) \
>       OBJECT_CLASS_CHECK(S390CcwMachineClass, (klass), TYPE_S390_CCW_MACHINE)
>   
> +#define S390_CCW_MACHINE_OBJ_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(S390CcwMachineClass, obj, TYPE_S390_CCW_MACHINE)
> +
>   typedef struct S390CcwMachineState {
>       /*< private >*/
>       MachineState parent_obj;
> @@ -40,6 +43,7 @@ typedef struct S390CcwMachineClass {
>       bool cpu_model_allowed;
>       bool css_migration_enabled;
>       bool hpage_1m_allowed;
> +    bool kvm_ais_allowed;
>   } S390CcwMachineClass;
>   
>   /* runtime-instrumentation allowed by the machine */
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 15260aeb9a..4c1c8c0208 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -329,6 +329,8 @@ static void ccw_machine_class_foreach(ObjectClass *oc, void *opaque)
>   
>   int kvm_arch_init(MachineState *ms, KVMState *s)
>   {
> +    S390CcwMachineClass *smc = S390_CCW_MACHINE_OBJ_GET_CLASS(ms);
> +

I still can't run a proper test due to unavailable hw but in the 
meantime I tried to virsh define a libvirt guest pointed at qemu (master 
+ this patch).  Regardless of machine type (s390-ccw-virtio-5.0 or 
s390-ccw-virtio-4.2) I get:

virsh define guest.xml
error: Failed to define domain from /path/to/guest.xml
error: invalid argument: could not find capabilities for arch=s390x 
domaintype=kvm

Similarly:

virsh domcapabilities
error: failed to get emulator capabilities
error: invalid argument: unable to find any emulator to serve 's390x' 
architecture

Rolling back to qemu master, the define and domcapabilities work (with 
no ais of course).

So: there is some incompatibility between the way libvirt invokes qemu 
to detect capabilities and this code.  The above line seems to be the 
root problem - if I take your patch and remove 'smc' then libvirt works 
as expected and I can see ais in the domcapabilities.

Looking at those wrappers David mentioned...  I suspect you need this 
for the 'none' machine case.  I tried a quick hack with the following:

bool ais_allowed(void)
{
     /* for "none" machine this results in true */
     return get_machine_class()->kvm_ais_allowed;
}

and

if (ais_allowed() &&
     kvm_check_extension(s, KVM_CAP_S390_AIS_MIGRATION)) {
     kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
}

This works and doesn't break libvirt compatibility detection.



>       object_class_foreach(ccw_machine_class_foreach, TYPE_S390_CCW_MACHINE,
>                            false, NULL);
>   
> @@ -365,10 +367,13 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>       /*
>        * The migration interface for ais was introduced with kernel 4.13
>        * but the capability itself had been active since 4.12. As migration
> -     * support is considered necessary let's disable ais in the 2.10
> -     * machine.
> +     * support is considered necessary we only enable this for newer
> +     * machine types and if KVM_CAP_S390_AIS_MIGRATION is available.
>        */
> -    /* kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0); */
> +    if (smc->kvm_ais_allowed &&
> +        kvm_check_extension(s, KVM_CAP_S390_AIS_MIGRATION)) {
> +        kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
> +    }
>   
>       kvm_set_max_memslot_size(KVM_SLOT_MAX_BYTES);
>       return 0;
> 


