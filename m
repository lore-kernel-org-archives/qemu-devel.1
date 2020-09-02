Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C236FC433E6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:23:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84E9020709
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="AvBKt6eR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E9020709
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDO3H-0007op-MN
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 04:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kDNxA-00038w-1c
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:17:12 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:51459)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kDNx5-00035m-GZ
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=bso7npxdX15y7YPc/x6rLS+gQrlnup3YO7hgNSCTW90=; b=AvBKt6eRlFkDmzCR6FjowWgto8
 y6qFti27vSVQOc5V2iaKZZeKNAE2fB3mYBq3MryfV5y8A/WcrHyvf1cPRRxkgwJKQA3xeUvIIEjGS
 H286f47Uc53ujFTswnAJ06OXhN7/fIBhDn1watOWVjJ9XgEsRxl+L0U3EVkhGaN6WqDLHnu/bDRUg
 +HTixv8UPwMwxfn/L5jdAN1gbuWwznouSax57LKUP8n8JKjrOMdheZJ/b6E5BOGjM74NX3HZDOLkN
 fPKmdvKF53WrnHcITPcSJPATl2RIAfkBOdlslK3ZmuUmOlFnFplPgEQlV+s6yqpbSSYnFZJomUX3s
 UgCsuRsw==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: David Cohen <dacohen@zohomail.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>
Subject: Re: qemu panic on OSX 10.15.6
Date: Wed, 02 Sep 2020 10:17:01 +0200
Message-ID: <1645171.kiFi0bBsqf@silver>
In-Reply-To: <a1f5ea65-073c-6130-1151-722d66d1564e@zohomail.com>
References: <a1f5ea65-073c-6130-1151-722d66d1564e@zohomail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 04:17:03
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Dienstag, 1. September 2020 14:45:55 CEST David Cohen wrote:
> Hi,
> 
> I'm trying to use qemu on OSX Catalina using HVF hypervisor, but it's
> currently panic'ing upon booting Linux guest.
> 
> These are the args I'm using:
> build % ./qemu-system-x86_64 -cdrom
> ~/Downloads/archlinux-2020.08.01-x86_64.iso -smp 4 -m 4G -vga virtio
> -accel hvf -cpu host
> 
> I could trace the failure to test_pt_entry(), in this exact position:
> 
> build % git diff
> diff --git a/target/i386/hvf/x86_mmu.c b/target/i386/hvf/x86_mmu.c
> index 65d4603dbf..8f04a94cc6 100644
> --- a/target/i386/hvf/x86_mmu.c
> +++ b/target/i386/hvf/x86_mmu.c
> @@ -113,6 +113,7 @@ static bool test_pt_entry(struct CPUState *cpu,
> struct gpt_translation *pt,
>       }
> 
>       if (!pte_present(pte)) {
> +        printf("Code is failing here");
>           return false;
>       }
> 
> 
> Is anyone aware of this issue?
> 
> Br, David Cohen

CCing Cameron and Roman, just in case.

Best regards,
Christian Schoenebeck



