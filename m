Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABA9C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 14:34:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF4A20651
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 14:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF4A20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzikI-000645-NW
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 10:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1hzijW-0005dq-9a
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:34:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hzijU-0003wD-JI
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:34:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46952)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hzijU-0003vP-Dv
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:34:04 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C0D28106E96C;
 Mon, 19 Aug 2019 14:34:03 +0000 (UTC)
Received: from work-vm (ovpn-116-163.ams2.redhat.com [10.36.116.163])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E3EA21001925;
 Mon, 19 Aug 2019 14:34:02 +0000 (UTC)
Date: Mon, 19 Aug 2019 15:34:00 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Bingsong Si <owen.si@ucloud.cn>, ehabkost@redhat.com
Message-ID: <20190819143400.GB2807@work-vm>
References: <20190819100924.14968-1-owen.si@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819100924.14968-1-owen.si@ucloud.cn>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Mon, 19 Aug 2019 14:34:03 +0000 (UTC)
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Copying in Eduardo.

* Bingsong Si (owen.si@ucloud.cn) wrote:
> This reverts commit de2e68c902f7b6e438b0fa3cfedd74a06a20704f.
> 
> Initial value of env->xcr0 == 0, then CPUID(EAX=0xd,ECX=0).EBX == 0, after kvm
> upstream commit 412a3c41, It is ok.
> On host before commit 412a3c41, some legacy guest, i.e. CentOS 6, get
> xstate_size == 0, will crash the guest.
> 
> Signed-off-by: Bingsong Si <owen.si@ucloud.cn>
> ---
>  target/i386/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index ff65e11008..69562e21ed 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -4416,7 +4416,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>              *ecx = xsave_area_size(x86_cpu_xsave_components(cpu));
>              *eax = env->features[FEAT_XSAVE_COMP_LO];
>              *edx = env->features[FEAT_XSAVE_COMP_HI];
> -            *ebx = xsave_area_size(env->xcr0);
> +            *ebx = *ecx;
>          } else if (count == 1) {
>              *eax = env->features[FEAT_XSAVE];
>          } else if (count < ARRAY_SIZE(x86_ext_save_areas)) {
> -- 
> 2.22.0
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

