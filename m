Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD9AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 11:32:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CB9F20758
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 11:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ELg+hyuv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB9F20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbMxv-0005rD-Ez
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 07:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jbMvk-0004BJ-Dx
 for qemu-devel@nongnu.org; Wed, 20 May 2020 07:30:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42734
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jbMvj-00049Z-Az
 for qemu-devel@nongnu.org; Wed, 20 May 2020 07:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589974230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e3gr5Say9U2bhEmzKh8WaIF4xmsjG6x3YSbt/HKN7NE=;
 b=ELg+hyuv/jgs1ZKgzIhuVX48yzNYAcnNbTH2KWwU4iGJCW+vKHHM98p0a9weB+KaARWbe3
 hhta+VZFI38oKCS2vfq7fERTAGL5udI5irneRLu84yA5vjGSniu7ixnY2cF1bHBv7c3rnV
 DrYyiGouU8wwEMIDATX4gdOrBukPVxY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-WkUeD8uWM8-1YFpXn4rV3Q-1; Wed, 20 May 2020 07:30:25 -0400
X-MC-Unique: WkUeD8uWM8-1YFpXn4rV3Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E1EFEC1AE;
 Wed, 20 May 2020 11:30:23 +0000 (UTC)
Received: from gondolin (ovpn-113-5.ams2.redhat.com [10.36.113.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3502C1001920;
 Wed, 20 May 2020 11:30:15 +0000 (UTC)
Date: Wed, 20 May 2020 13:30:12 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Collin Walling <walling@linux.ibm.com>
Subject: Re: [PATCH v2 8/8] s390: guest support for diagnose 0x318
Message-ID: <20200520133012.1ad60b71.cohuck@redhat.com>
In-Reply-To: <20200515222032.18838-9-walling@linux.ibm.com>
References: <20200515222032.18838-1-walling@linux.ibm.com>
 <20200515222032.18838-9-walling@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 01:34:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: thuth@redhat.com, frankja@linux.ibm.com, mst@redhat.com, david@redhat.com,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, svens@linux.ibm.com, pbonzini@redhat.com,
 mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 May 2020 18:20:32 -0400
Collin Walling <walling@linux.ibm.com> wrote:

> DIAGNOSE 0x318 (diag 318) allows the storage of diagnostic data that
> is collected by the firmware in the case of hardware/firmware service
> events.
> 
> The instruction is invoked in the Linux kernel and is handled,
> migrated, and reset (modified clear and load normal) by QEMU.
> KVM assists with the get/set of the relevent data via IOCTLs.
> 
> This feature depends on the Extended-Length SCCB (els) feature. If
> els is not present, then a warning will be printed and the SCLP bit
> that allows the Linux kernel to execute the instruction will not be
> set.
> 
> Availability of this instruction is determined by byte 134 (aka fac134)
> bit 0 of the SCLP Read Info block. This coincidentally expands into the
> space used for CPU entries, which means VMs running with the diag 318
> capability may not be able to read information regarding all CPUs
> unless the guest kernel supports an extended-length SCCB.
> 
> This feature is not supported in protected virtualization mode.

I think it should be easy enough to wire it up for !kvm as well
(although I'm not sure how useful it would be there -- mostly for
seeing what a guest does with it, I guess.)

> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>  hw/s390x/s390-virtio-ccw.c          | 45 +++++++++++++++++++++++++++++
>  hw/s390x/sclp.c                     |  5 ++++
>  include/hw/s390x/s390-virtio-ccw.h  |  1 +
>  include/hw/s390x/sclp.h             |  3 ++
>  target/s390x/cpu.c                  | 23 +++++++++++++++
>  target/s390x/cpu.h                  |  4 +++
>  target/s390x/cpu_features.h         |  1 +
>  target/s390x/cpu_features_def.inc.h |  3 ++
>  target/s390x/cpu_models.c           |  1 +
>  target/s390x/gen-features.c         |  1 +
>  target/s390x/kvm-stub.c             | 10 +++++++
>  target/s390x/kvm.c                  | 40 +++++++++++++++++++++++++
>  target/s390x/kvm_s390x.h            |  2 ++
>  13 files changed, 139 insertions(+)
> 

(...)

> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index f2ccf0a06a..367a54c173 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -446,6 +446,29 @@ void s390_enable_css_support(S390CPU *cpu)
>          kvm_s390_enable_css_support(cpu);
>      }
>  }
> +
> +void s390_get_diag_318_info(uint64_t *info)
> +{
> +    if (kvm_enabled()) {
> +        kvm_s390_get_diag_318_info(info);
> +    }
> +}
> +
> +void s390_set_diag_318_info(uint64_t info)
> +{
> +    if (kvm_enabled()) {
> +        kvm_s390_set_diag_318_info(info);
> +    }
> +}
> +
> +bool s390_diag_318_is_allowed(void)
> +{
> +    if (kvm_enabled()) {

I would recommend not tying this explicitly to kvm -- assuming that the
feature checks should be enough.

> +        return s390_has_feat(S390_FEAT_DIAG_318) &&
> +               s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB);
> +    }
> +    return false;
> +}
>  #endif
>  
>  static gchar *s390_gdb_arch_name(CPUState *cs)

(...)

> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 380fb81822..5d7dc60c85 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -105,6 +105,7 @@
>  
>  #define DIAG_TIMEREVENT                 0x288
>  #define DIAG_IPL                        0x308
> +#define DIAG_SET_CONTROL_PROGRAM_CODES  0x318
>  #define DIAG_KVM_HYPERCALL              0x500
>  #define DIAG_KVM_BREAKPOINT             0x501
>  
> @@ -814,6 +815,28 @@ int kvm_s390_set_clock_ext(uint8_t tod_high, uint64_t tod_low)
>      return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
>  }
>  
> +int kvm_s390_get_diag_318_info(uint64_t *info)
> +{
> +    struct kvm_device_attr attr = {
> +        .group = KVM_S390_VM_MISC,
> +        .attr = KVM_S390_VM_MISC_DIAG_318,
> +        .addr = (uint64_t)info,
> +    };
> +
> +    return kvm_vm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr);
> +}
> +
> +int kvm_s390_set_diag_318_info(uint64_t info)
> +{
> +    struct kvm_device_attr attr = {
> +        .group = KVM_S390_VM_MISC,
> +        .attr = KVM_S390_VM_MISC_DIAG_318,
> +        .addr = (uint64_t)&info,
> +    };
> +
> +    return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
> +}
> +
>  /**
>   * kvm_s390_mem_op:
>   * @addr:      the logical start address in guest memory
> @@ -1601,6 +1624,14 @@ static int handle_sw_breakpoint(S390CPU *cpu, struct kvm_run *run)
>      return -ENOENT;
>  }
>  
> +static void kvm_handle_diag_318(struct kvm_run *run)
> +{
> +    uint64_t reg = (run->s390_sieic.ipa & 0x00f0) >> 4;
> +    uint64_t info = run->s.regs.gprs[reg];
> +
> +    kvm_s390_set_diag_318_info(info);

Follow the other diag handlers and rather call a common
handle_diag_318() function, which will in turn call
s390_set_diag_318_info()? While that feels like a bit of extra churn at
a glance, it allows non-kvm access to this diag more easily.

> +}
> +
>  #define DIAG_KVM_CODE_MASK 0x000000000000ffff
>  
>  static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb)
> @@ -1620,6 +1651,9 @@ static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb)
>      case DIAG_IPL:
>          kvm_handle_diag_308(cpu, run);
>          break;
> +    case DIAG_SET_CONTROL_PROGRAM_CODES:
> +        kvm_handle_diag_318(run);
> +        break;
>      case DIAG_KVM_HYPERCALL:
>          r = handle_hypercall(cpu, run);
>          break;
> @@ -2460,6 +2494,12 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
>      /* Extended-Length SCCB is handled entirely within QEMU */
>      set_bit(S390_FEAT_EXTENDED_LENGTH_SCCB, model->features);
>  
> +    /* Allow diag 0x318 iff KVM supported and not in PV mode */

"iff supported by KVM" ?

> +    if (!s390_is_pv() && kvm_vm_check_attr(kvm_state,
> +        KVM_S390_VM_MISC, KVM_S390_VM_MISC_DIAG_318)) {
> +        set_bit(S390_FEAT_DIAG_318, model->features);
> +    }
> +
>      /* strip of features that are not part of the maximum model */
>      bitmap_and(model->features, model->features, model->def->full_feat,
>                 S390_FEAT_MAX);

(...)


