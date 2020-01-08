Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C5CC33C9E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 11:47:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B6B62077B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 11:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6B62077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip9o0-0004oy-NR
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 06:47:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xiaoyao.li@intel.com>) id 1ip9nQ-0004P5-79
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:46:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xiaoyao.li@intel.com>) id 1ip9nO-00042F-9b
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:46:43 -0500
Received: from mga12.intel.com ([192.55.52.136]:22764)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <xiaoyao.li@intel.com>)
 id 1ip9nN-0003yc-Vl
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:46:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Jan 2020 03:46:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,409,1571727600"; d="scan'208";a="421422173"
Received: from lxy-dell.sh.intel.com ([10.239.159.46])
 by fmsmga005.fm.intel.com with ESMTP; 08 Jan 2020 03:46:32 -0800
Message-ID: <6729950817376aab737700b4baf0580cfd36ad59.camel@intel.com>
Subject: Re: [PATCH v2] accel/kvm: Make "kernel_irqchip" default on
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost
 <ehabkost@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Wed, 08 Jan 2020 19:38:05 +0800
In-Reply-To: <05532242-3a70-b547-3765-0ab29583c4b0@redhat.com>
References: <20191228104326.21732-1-xiaoyao.li@intel.com>
 <05532242-3a70-b547-3765-0ab29583c4b0@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-5.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.136
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
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-01-07 at 11:32 +0100, Paolo Bonzini wrote:
> On 28/12/19 11:43, Xiaoyao Li wrote:
> > Commit 11bc4a13d1f4 ("kvm: convert "-machine kernel_irqchip" to an
> > accelerator property") moves kernel_irqchip property from "-machine" to
> > "-accel kvm", but it forgets to set the default value of
> > kernel_irqchip_allowed and kernel_irqchip_split.
> > 
> > Also cleaning up the three useless members (kernel_irqchip_allowed,
> > kernel_irqchip_required, kernel_irqchip_split) in struct MachineState.
> > 
> > Fixes: 11bc4a13d1f4 ("kvm: convert "-machine kernel_irqchip" to an
> > accelerator property")
> > Reported-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > ---
> > Changes in v2:
> >   - Add Reported-by tag;
> >   - Initialize kernel_irqchip_split in init_machine();
> 
> Now that I am actually reviewing the patch on something other than a
> phone, I think this would break "-machine kernel_irqchip=split".  I'll
> test, and squash if it works, something like this:
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index afbbe0a1af..ea35433170 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -98,7 +98,7 @@ struct KVMState
>      int kvm_shadow_mem;
>      bool kernel_irqchip_allowed;
>      bool kernel_irqchip_required;
> -    bool kernel_irqchip_split;
> +    OnOffAuto kernel_irqchip_split;
>      bool sync_mmu;
>      bool manual_dirty_log_protect;
>      /* The man page (and posix) say ioctl numbers are signed int, but
> @@ -1799,7 +1799,7 @@ static void kvm_irqchip_create(KVMState *s)
>       * in-kernel irqchip for us */
>      ret = kvm_arch_irqchip_create(s);
>      if (ret == 0) {
> -        if (s->kernel_irqchip_split) {
> +        if (s->kernel_irqchip_split == ON_OFF_AUTO_ON) {
>              perror("Split IRQ chip mode not supported.");
>              exit(1);
>          } else {
> @@ -2070,7 +2070,9 @@ static int kvm_init(MachineState *ms)
>          goto err;
>      }
>  
> -    s->kernel_irqchip_split = mc->default_kernel_irqchip_split;
> +    if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
> +        s->kernel_irqchip_split = mc->default_kernel_irqchip_split ?
> ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
> +    }
>  
>      if (s->kernel_irqchip_allowed) {
>          kvm_irqchip_create(s);
> @@ -3007,17 +3009,17 @@ static void kvm_set_kernel_irqchip(Object *obj,
> Visitor *v,
>          case ON_OFF_SPLIT_ON:
>              s->kernel_irqchip_allowed = true;
>              s->kernel_irqchip_required = true;
> -            s->kernel_irqchip_split = false;
> +            s->kernel_irqchip_split = ON_OFF_AUTO_OFF;
>              break;
>          case ON_OFF_SPLIT_OFF:
>              s->kernel_irqchip_allowed = false;
>              s->kernel_irqchip_required = false;
> -            s->kernel_irqchip_split = false;
> +            s->kernel_irqchip_split = ON_OFF_AUTO_OFF;
>              break;
>          case ON_OFF_SPLIT_SPLIT:
>              s->kernel_irqchip_allowed = true;
>              s->kernel_irqchip_required = true;
> -            s->kernel_irqchip_split = true;
> +            s->kernel_irqchip_split = ON_OFF_AUTO_ON;
>              break;
>          default:
>              /* The value was checked in visit_type_OnOffSplit() above. If
> @@ -3040,7 +3042,7 @@ bool kvm_kernel_irqchip_required(void)
>  
>  bool kvm_kernel_irqchip_split(void)
>  {
> -    return kvm_state->kernel_irqchip_split;
> +    return kvm_state->kernel_irqchip_split == ON_OFF_AUTO_ON;
>  }
>  
>  static void kvm_accel_instance_init(Object *obj)
> @@ -3049,6 +3051,7 @@ static void kvm_accel_instance_init(Object *obj)
>  
>      s->kvm_shadow_mem = -1;
>      s->kernel_irqchip_allowed = true;
> +    s->kernel_irqchip_split = ON_OFF_AUTO_AUTO;
>  }
>  
>  static void kvm_accel_class_init(ObjectClass *oc, void *data)

thanks, the above patch does fix the issue that unconditionally setting
	s->kernel_irqchip_split = mc->default_kernel_irqchip_split;

in kvm_init() may change the value setting by "kernel_irqchip=split" 

> As a follow up, kernel_irqchip_allowed and kernel_irqchip_required could also
> be changed to a single OnOffAuto field, I think.

In fact, kernel_irqchip_allowed and kernel_irqchip_required don't have the issue
of kernel_irqchip_split. Anyway, making them the same style looks good.

> Paolo
> 


