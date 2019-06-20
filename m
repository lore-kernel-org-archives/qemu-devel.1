Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806BDC43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 12:39:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 186E72082C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 12:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 186E72082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47352 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdwLL-00064i-5a
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 08:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33287)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hdw2v-000194-NG
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 08:20:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hdvq6-0003ab-CU
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 08:08:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40782)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1hdvoI-0002Nz-6r; Thu, 20 Jun 2019 08:04:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 600E6307D871;
 Thu, 20 Jun 2019 12:04:46 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 140AD19807;
 Thu, 20 Jun 2019 12:04:13 +0000 (UTC)
Date: Thu, 20 Jun 2019 14:04:09 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Dongjiu Geng <gengdongjiu@huawei.com>
Message-ID: <20190620140409.3c713760@redhat.com>
In-Reply-To: <1557832703-42620-2-git-send-email-gengdongjiu@huawei.com>
References: <1557832703-42620-1-git-send-email-gengdongjiu@huawei.com>
 <1557832703-42620-2-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 20 Jun 2019 12:04:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v17 01/10] hw/arm/virt: Add RAS platform
 version for migration
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, kvm@vger.kernel.org,
 mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
 linuxarm@huawei.com, shannon.zhaosl@gmail.com, zhengxiang9@huawei.com,
 qemu-arm@nongnu.org, james.morse@arm.com, xuwei5@huawei.com,
 jonathan.cameron@huawei.com, pbonzini@redhat.com, lersek@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 May 2019 04:18:14 -0700
Dongjiu Geng <gengdongjiu@huawei.com> wrote:

> Support this feature since version 4.1, disable it by
> default in the old version.
> 
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> ---
>  hw/arm/virt.c         | 6 ++++++
>  include/hw/arm/virt.h | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 5331ab7..7bdd41b 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2043,8 +2043,14 @@ DEFINE_VIRT_MACHINE_AS_LATEST(4, 1)
>  
>  static void virt_machine_4_0_options(MachineClass *mc)
>  {
> +    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
> +
>      virt_machine_4_1_options(mc);
>      compat_props_add(mc->compat_props, hw_compat_4_0, hw_compat_4_0_len);
> +    /* Disable memory recovery feature for 4.0 as RAS support was
> +     * introduced with 4.1.
> +     */
> +    vmc->no_ras = true;

So it would mean that the feature is enabled unconditionally for
new machine types and consumes resources whether user needs it or not.

In light of the race for leaner QEMU and faster startup times,
it might be better to make RAS optional and make user explicitly
enable it using a machine option.


>  }
>  DEFINE_VIRT_MACHINE(4, 0)
>  
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 4240709..7f1a033 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -104,6 +104,7 @@ typedef struct {
>      bool disallow_affinity_adjustment;
>      bool no_its;
>      bool no_pmu;
> +    bool no_ras;
>      bool claim_edge_triggered_timers;
>      bool smbios_old_sys_ver;
>      bool no_highmem_ecam;


