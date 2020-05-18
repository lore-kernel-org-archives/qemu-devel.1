Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEB6C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 10:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FE3120657
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 10:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE3120657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jad1Q-0008Db-TN
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 06:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jad0D-0007DU-Ny
 for qemu-devel@nongnu.org; Mon, 18 May 2020 06:28:12 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:40608)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jad09-0001nh-M9
 for qemu-devel@nongnu.org; Mon, 18 May 2020 06:28:08 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id EB49274633E;
 Mon, 18 May 2020 12:27:58 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D077D74633D; Mon, 18 May 2020 12:27:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CEE8C746333;
 Mon, 18 May 2020 12:27:58 +0200 (CEST)
Date: Mon, 18 May 2020 12:27:58 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 13/24] ppc4xx: Drop redundant device realization
In-Reply-To: <20200518050408.4579-14-armbru@redhat.com>
Message-ID: <alpine.BSF.2.22.395.2005181226160.5961@zero.eik.bme.hu>
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-14-armbru@redhat.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 May 2020, Markus Armbruster wrote:
> object_property_set_bool(OBJECT(dev), true, "realized", ...) right
> after qdev_init_nofail(dev) does nothing, because qdev_init_nofail()
> already realizes.  Drop.
>
> Cc: BALATON Zoltan <balaton@eik.bme.hu>

Shouldn't this Cc line come after the --- so it's not included in the 
final commit? Thanks.

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
> hw/ppc/ppc440_uc.c | 2 --
> 1 file changed, 2 deletions(-)
>
> diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
> index b30e093cbb..dc318c7aa7 100644
> --- a/hw/ppc/ppc440_uc.c
> +++ b/hw/ppc/ppc440_uc.c
> @@ -1370,12 +1370,10 @@ void ppc460ex_pcie_init(CPUPPCState *env)
>     dev = qdev_create(NULL, TYPE_PPC460EX_PCIE_HOST);
>     qdev_prop_set_int32(dev, "dcrn-base", DCRN_PCIE0_BASE);
>     qdev_init_nofail(dev);
> -    object_property_set_bool(OBJECT(dev), true, "realized", NULL);
>     ppc460ex_pcie_register_dcrs(PPC460EX_PCIE_HOST(dev), env);
>
>     dev = qdev_create(NULL, TYPE_PPC460EX_PCIE_HOST);
>     qdev_prop_set_int32(dev, "dcrn-base", DCRN_PCIE1_BASE);
>     qdev_init_nofail(dev);
> -    object_property_set_bool(OBJECT(dev), true, "realized", NULL);
>     ppc460ex_pcie_register_dcrs(PPC460EX_PCIE_HOST(dev), env);
> }
>

