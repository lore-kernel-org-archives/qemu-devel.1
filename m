Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D04C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 14:14:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FF67247E2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 14:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF67247E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSL3z-00062O-8k
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 10:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kSL2l-00051A-Lq
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 10:12:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:57166)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kSL2j-0007C9-KZ
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 10:12:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id E2BA7ABCC;
 Tue, 13 Oct 2020 14:12:43 +0000 (UTC)
Subject: Re: [PATCH v2 3/3] accel: Add xen CpusAccel using dummy-cpus
To: Jason Andryuk <jandryuk@gmail.com>, qemu-devel@nongnu.org
References: <20201013140511.5681-1-jandryuk@gmail.com>
 <20201013140511.5681-4-jandryuk@gmail.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <803af254-a005-1a50-ddad-7116ef261a8a@suse.de>
Date: Tue, 13 Oct 2020 16:12:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201013140511.5681-4-jandryuk@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 01:21:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Anthony Perard <anthony.perard@citrix.com>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/20 4:05 PM, Jason Andryuk wrote:
> Xen was broken by commit 1583a3898853 ("cpus: extract out qtest-specific
> code to accel/qtest").  Xen relied on qemu_init_vcpu() calling
> qemu_dummy_start_vcpu() in the default case, but that was replaced by
> g_assert_not_reached().
> 
> Add a minimal "CpusAccel" for Xen using the dummy-cpus implementation
> used by qtest.
> 
> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
> ---
>  accel/meson.build   | 1 +
>  accel/xen/xen-all.c | 8 ++++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/accel/meson.build b/accel/meson.build
> index 9a417396bd..b26cca227a 100644
> --- a/accel/meson.build
> +++ b/accel/meson.build
> @@ -12,3 +12,4 @@ dummy_ss.add(files(
>  ))
>  
>  specific_ss.add_all(when: ['CONFIG_SOFTMMU', 'CONFIG_POSIX'], if_true: dummy_ss)
> +specific_ss.add_all(when: ['CONFIG_XEN'], if_true: dummy_ss)
> diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
> index 60b971d0a8..878a4089d9 100644
> --- a/accel/xen/xen-all.c
> +++ b/accel/xen/xen-all.c
> @@ -16,6 +16,7 @@
>  #include "hw/xen/xen_pt.h"
>  #include "chardev/char.h"
>  #include "sysemu/accel.h"
> +#include "sysemu/cpus.h"
>  #include "sysemu/xen.h"
>  #include "sysemu/runstate.h"
>  #include "migration/misc.h"
> @@ -153,6 +154,10 @@ static void xen_setup_post(MachineState *ms, AccelState *accel)
>      }
>  }
>  
> +const CpusAccel xen_cpus = {
> +    .create_vcpu_thread = dummy_start_vcpu_thread,
> +};
> +
>  static int xen_init(MachineState *ms)
>  {
>      MachineClass *mc = MACHINE_GET_CLASS(ms);
> @@ -180,6 +185,9 @@ static int xen_init(MachineState *ms)
>       * opt out of system RAM being allocated by generic code
>       */
>      mc->default_ram_id = NULL;
> +
> +    cpus_register_accel(&xen_cpus);
> +
>      return 0;
>  }
>  
> 
Reviewed-by: Claudio Fontana <cfontana@suse.de>

