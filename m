Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FFEC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:25:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 282D52082F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 282D52082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Ojq-0002HA-RY
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 07:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1i0Of0-0004Lz-5k
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:20:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1i0OeQ-000622-C1
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:19:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34800)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1i0OeQ-00061e-6N
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:19:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2745E30A5686;
 Wed, 21 Aug 2019 11:19:37 +0000 (UTC)
Received: from localhost (ovpn-116-73.gru2.redhat.com [10.97.116.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F396197E9;
 Wed, 21 Aug 2019 11:19:36 +0000 (UTC)
Date: Wed, 21 Aug 2019 08:19:34 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: "owen.si@ucloud.cn" <owen.si@ucloud.cn>
Message-ID: <20190821111934.GO3908@habkost.net>
References: <20190819100924.14968-1-owen.si@ucloud.cn>
 <20190820212306.GM3908@habkost.net>
 <2019082111044638341815@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2019082111044638341815@ucloud.cn>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Wed, 21 Aug 2019 11:19:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] Revert "i386: correct cpu_x86_cpuid(0xd)"
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 21, 2019 at 11:04:46AM +0800, owen.si@ucloud.cn wrote:
> Thanks for you reply, we have some hosts running with legacy kernel, difficult to upgrade, and i want to run the latest qemu.
> Does QEMU support running with legacy kernel(kvm) in design?

For KVM, QEMU requires Linux 4.5 or newer.  See "System
requirements" / "KVM kernel module" section on qemu-doc.  We also
aim to support the latest version of Linux distributions with
long term support (e.g. RHEL, Debian, Ubuntu LTS, SLES).

Do you have more details on the kernel you are using?  Is it
built and distributed by a third party?


> 
> 
> 
> owen.si@ucloud.cn
>  
> From: Eduardo Habkost
> Date: 2019-08-21 05:23
> To: Bingsong Si
> CC: qemu-devel
> Subject: Re: [Qemu-devel] [PATCH] Revert "i386: correct cpu_x86_cpuid(0xd)"
> On Mon, Aug 19, 2019 at 06:09:24PM +0800, Bingsong Si wrote:
> > This reverts commit de2e68c902f7b6e438b0fa3cfedd74a06a20704f.
> > 
> > Initial value of env->xcr0 == 0, then CPUID(EAX=0xd,ECX=0).EBX == 0, after kvm
> > upstream commit 412a3c41, It is ok.
> > On host before commit 412a3c41, some legacy guest, i.e. CentOS 6, get
> > xstate_size == 0, will crash the guest.
> > 
> > Signed-off-by: Bingsong Si <owen.si@ucloud.cn>
>  
> cpu_x86_cpuid() is also used by TCG, and needs to return the
> correct data depending on xcr0.  If you want to work around a KVM
> bug by ignoring xcr0, it needs to be conditional on
> kvm_enabled().
>  
> But even if we you make this conditional on kvm_enabled(), I
> don't understand why QEMU would need a workaround for a KVM bug
> that was fixed more than 4 years ago.
>  
> > ---
> >  target/i386/cpu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index ff65e11008..69562e21ed 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -4416,7 +4416,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >              *ecx = xsave_area_size(x86_cpu_xsave_components(cpu));
> >              *eax = env->features[FEAT_XSAVE_COMP_LO];
> >              *edx = env->features[FEAT_XSAVE_COMP_HI];
> > -            *ebx = xsave_area_size(env->xcr0);
> > +            *ebx = *ecx;
> >          } else if (count == 1) {
> >              *eax = env->features[FEAT_XSAVE];
> >          } else if (count < ARRAY_SIZE(x86_ext_save_areas)) {
> > -- 
> > 2.22.0
> > 
> > 
>  
> -- 
> Eduardo

-- 
Eduardo

