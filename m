Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B615DC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:28:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ABB120C56
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ABB120C56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD3Wq-0008Lp-JH
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 06:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kD3W4-0007Tz-3n; Tue, 01 Sep 2020 06:27:52 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:52359)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kD3W1-00008O-RC; Tue, 01 Sep 2020 06:27:51 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.4.108])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id D250B5CB8213;
 Tue,  1 Sep 2020 12:27:38 +0200 (CEST)
Received: from kaod.org (37.59.142.97) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Tue, 1 Sep 2020
 12:27:37 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G0025ab2b1c4-e3ec-43a6-a465-234858c1f105,
 DF2AD85881EC9B15757C33AEE529973A5D0472CE) smtp.auth=groug@kaod.org
Date: Tue, 1 Sep 2020 12:27:36 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2 3/3] spapr: Remove unnecessary DRC type-checker macros
Message-ID: <20200901122736.6740a243@bahia.lan>
In-Reply-To: <20200831235146.36045-4-david@gibson.dropbear.id.au>
References: <20200831235146.36045-1-david@gibson.dropbear.id.au>
 <20200831235146.36045-4-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG4EX1.mxp5.local (172.16.2.31) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: e0f7cbe5-6bd6-437e-9b6c-9b96d62e53e4
X-Ovh-Tracer-Id: 2457276547992689059
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudefjedgvdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefuddtieejjeevheekieeltefgleetkeetheettdeifeffvefhffelffdtfeeljeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopegtlhhgsehkrghougdrohhrgh
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 06:27:39
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org,
 ehabkost@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue,  1 Sep 2020 09:51:46 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> spapr_drc.h includes typechecker macro boilerplate for the many different
> DRC subclasses.  However, most of these types don't actually have different
> data in their class and/or instance, making these unneeded, unused, and in
> fact a bad idea.  Remove them.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>


>  include/hw/ppc/spapr_drc.h | 43 +-------------------------------------
>  1 file changed, 1 insertion(+), 42 deletions(-)
> 
> diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> index 21af8deac1..f270860769 100644
> --- a/include/hw/ppc/spapr_drc.h
> +++ b/include/hw/ppc/spapr_drc.h
> @@ -29,62 +29,21 @@
>                                               TYPE_SPAPR_DR_CONNECTOR)
>  
>  #define TYPE_SPAPR_DRC_PHYSICAL "spapr-drc-physical"
> -#define SPAPR_DRC_PHYSICAL_GET_CLASS(obj) \
> -        OBJECT_GET_CLASS(SpaprDrcClass, obj, TYPE_SPAPR_DRC_PHYSICAL)
> -#define SPAPR_DRC_PHYSICAL_CLASS(klass) \
> -        OBJECT_CLASS_CHECK(SpaprDrcClass, klass, \
> -                           TYPE_SPAPR_DRC_PHYSICAL)
>  #define SPAPR_DRC_PHYSICAL(obj) OBJECT_CHECK(SpaprDrcPhysical, (obj), \
>                                               TYPE_SPAPR_DRC_PHYSICAL)
>  
>  #define TYPE_SPAPR_DRC_LOGICAL "spapr-drc-logical"
> -#define SPAPR_DRC_LOGICAL_GET_CLASS(obj) \
> -        OBJECT_GET_CLASS(SpaprDrcClass, obj, TYPE_SPAPR_DRC_LOGICAL)
> -#define SPAPR_DRC_LOGICAL_CLASS(klass) \
> -        OBJECT_CLASS_CHECK(SpaprDrcClass, klass, \
> -                           TYPE_SPAPR_DRC_LOGICAL)
> -#define SPAPR_DRC_LOGICAL(obj) OBJECT_CHECK(SpaprDrc, (obj), \
> -                                             TYPE_SPAPR_DRC_LOGICAL)
>  
>  #define TYPE_SPAPR_DRC_CPU "spapr-drc-cpu"
> -#define SPAPR_DRC_CPU_GET_CLASS(obj) \
> -        OBJECT_GET_CLASS(SpaprDrcClass, obj, TYPE_SPAPR_DRC_CPU)
> -#define SPAPR_DRC_CPU_CLASS(klass) \
> -        OBJECT_CLASS_CHECK(SpaprDrcClass, klass, TYPE_SPAPR_DRC_CPU)
> -#define SPAPR_DRC_CPU(obj) OBJECT_CHECK(SpaprDrc, (obj), \
> -                                        TYPE_SPAPR_DRC_CPU)
>  
>  #define TYPE_SPAPR_DRC_PCI "spapr-drc-pci"
> -#define SPAPR_DRC_PCI_GET_CLASS(obj) \
> -        OBJECT_GET_CLASS(SpaprDrcClass, obj, TYPE_SPAPR_DRC_PCI)
> -#define SPAPR_DRC_PCI_CLASS(klass) \
> -        OBJECT_CLASS_CHECK(SpaprDrcClass, klass, TYPE_SPAPR_DRC_PCI)
> -#define SPAPR_DRC_PCI(obj) OBJECT_CHECK(SpaprDrc, (obj), \
> -                                        TYPE_SPAPR_DRC_PCI)
>  
>  #define TYPE_SPAPR_DRC_LMB "spapr-drc-lmb"
> -#define SPAPR_DRC_LMB_GET_CLASS(obj) \
> -        OBJECT_GET_CLASS(SpaprDrcClass, obj, TYPE_SPAPR_DRC_LMB)
> -#define SPAPR_DRC_LMB_CLASS(klass) \
> -        OBJECT_CLASS_CHECK(SpaprDrcClass, klass, TYPE_SPAPR_DRC_LMB)
> -#define SPAPR_DRC_LMB(obj) OBJECT_CHECK(SpaprDrc, (obj), \
> -                                        TYPE_SPAPR_DRC_LMB)
>  
>  #define TYPE_SPAPR_DRC_PHB "spapr-drc-phb"
> -#define SPAPR_DRC_PHB_GET_CLASS(obj) \
> -        OBJECT_GET_CLASS(SpaprDrcClass, obj, TYPE_SPAPR_DRC_PHB)
> -#define SPAPR_DRC_PHB_CLASS(klass) \
> -        OBJECT_CLASS_CHECK(SpaprDrcClass, klass, TYPE_SPAPR_DRC_PHB)
> -#define SPAPR_DRC_PHB(obj) OBJECT_CHECK(SpaprDrc, (obj), \
> -                                        TYPE_SPAPR_DRC_PHB)
>  
>  #define TYPE_SPAPR_DRC_PMEM "spapr-drc-pmem"
> -#define SPAPR_DRC_PMEM_GET_CLASS(obj) \
> -        OBJECT_GET_CLASS(SpaprDrcClass, obj, TYPE_SPAPR_DRC_PMEM)
> -#define SPAPR_DRC_PMEM_CLASS(klass) \
> -        OBJECT_CLASS_CHECK(SpaprDrcClass, klass, TYPE_SPAPR_DRC_PMEM)
> -#define SPAPR_DRC_PMEM(obj) OBJECT_CHECK(SpaprDrc, (obj), \
> -                                         TYPE_SPAPR_DRC_PMEM)
> +
>  /*
>   * Various hotplug types managed by SpaprDrc
>   *


