Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97046C433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:44:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 657E5221E8
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NOXQcaUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 657E5221E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrNrd-0007Sd-NM
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 11:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrNqV-0006uV-Gf; Fri, 03 Jul 2020 11:43:23 -0400
Received: from mail-eopbgr60139.outbound.protection.outlook.com
 ([40.107.6.139]:41378 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrNqS-0002Rs-BE; Fri, 03 Jul 2020 11:43:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqrdDfwLFbAxUtSgG49SRN9Qyz5ocGD8gswk+O1C/ipVHylv/JyR0w6U6L1d3KwuJ/sAbM/DmP9U0/JwmUzNC4DWD7BQ8sQM6y4sl+rs0+FEhrF1Zn5MwwEsIXyXqs4FS3RavBbvz6IO20h4UI3ldfGLXwGS1T0qyXBuqpwmelRudUQwhaxgfbzLzSy1LyUVx6q4ZanMctBukiuNojRqN83ywkjNNaRg78WcwM415UBXut5ck2qfJG2xyIFvk/CuLh9pIsAUPewHrMdkYXVD9LLoY2tzLGnwdfgdCY+stuxfauVXfrOIz4ZRdS8bXHAm0hP9m7wxoYue8MZRUTjvjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+5lVKlTTvaLxyr7ucJcN58DOYS7YePDt8eNz9eZeJg=;
 b=Q/PdCu5sqH59GNq9QFlFPnjMO3z/bm/nqEOuTQToLhUL6YGcg+7hMAT7yuWGCsMJiWfl/IZr4TrpCsqd/fNA90R1JGAursGOeRpF7JRO/9wABqJTLzK4Sr5RjJGxi0+m5ylM1Ga91xYimzwX5NARDY+kMWjkU40SCAXmx8kJH60J5TnCjLoVXJXUY7UFooymfK5+lPKBfsloo+gcnKwBMnlbNdpYkTbUIrcrNIZUrYUOXnwfliksaL3i3sr09mY7rmXt4e69yLxJpuO3DknZDvrF4ndp4DHumz1PKMAv/b5T0q0FqTOneTbqmadkT7dENSPy0niJPW9QQ05L8L9yyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+5lVKlTTvaLxyr7ucJcN58DOYS7YePDt8eNz9eZeJg=;
 b=NOXQcaUDDKSC+771i4hk4qKdwevDuwv2b3uWyi+/1agxy7srIuEDytKFK0xl5YrnZRxTTkP+z2HWdQ+ggb1idtTEIZL3uNuIx36z/ubGDe3SkTHDLXOEAuaLqrwoqCUALWeEWKmXO7Nzzy8593i3OJi+qa289x57NtFJ77Nyd+s=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5253.eurprd08.prod.outlook.com (2603:10a6:20b:ec::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Fri, 3 Jul
 2020 15:43:16 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.028; Fri, 3 Jul 2020
 15:43:16 +0000
Subject: Re: [PATCH v2 23/44] qom: Crash more nicely on
 object_property_get_link() failure
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200702155000.3455325-1-armbru@redhat.com>
 <20200702155000.3455325-24-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <4b6973a2-ef5d-b422-b7bb-39fd62453c0c@virtuozzo.com>
Date: Fri, 3 Jul 2020 18:43:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200702155000.3455325-24-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0032.eurprd03.prod.outlook.com
 (2603:10a6:208:14::45) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.15) by
 AM0PR03CA0032.eurprd03.prod.outlook.com (2603:10a6:208:14::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.20 via Frontend Transport; Fri, 3 Jul 2020 15:43:15 +0000
X-Originating-IP: [185.215.60.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6573879-f8e9-461f-bcff-08d81f67cd77
X-MS-TrafficTypeDiagnostic: AM6PR08MB5253:
X-Microsoft-Antispam-PRVS: <AM6PR08MB525338E9BF8AC618B40EC1A1C16A0@AM6PR08MB5253.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tGB3RTIVQVOhtd2Eanzb+l/iKOOhTfgjrfbmUaHaJfspQAvZVkx4G2AUBYENEQ8DbcS3F+Qim7Gmhv9M5NECWzegb8TI7/1HYXn2dZe5Tgj5AjotfW25q/y5VZimp3aKlcYRRI77ySMJd+r8kx/bkwizXVUU83IJEUi5F8+O+yRt/iBFela3O9GgWzuu4y6YGKsIE/TmtHerXlChAdSPPwRffw0Yl29xWzbc9Nb3ciRZC664VYasSzsp6ma0pM7uMUe/gUmPwUkcGEB2UBJE+5+C+dHEApDZFaUMroubEsI2VdkcMtMW5UQ2OLgcJRAUOvB0tSlcXE3BDzJFv/KVcgSxFBMcv+LUJgFxEg4eIrlqG8CIr+PvvLmehlYxXZEp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(396003)(376002)(346002)(366004)(136003)(31696002)(956004)(2616005)(86362001)(8676002)(186003)(2906002)(66556008)(316002)(66476007)(8936002)(16526019)(478600001)(5660300002)(66946007)(4326008)(16576012)(52116002)(26005)(31686004)(6486002)(83380400001)(36756003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 9IkwikhxTnxEztw1TrVlsmCPqepgQjL1OVVIj55xZXMWZcMS08FftL4RYp0LdpiiEXJnpWVhYPLTAzntbn7SZpM8Ml27WuFlCSwJyD1M4hgz/5VU8Uon4Zkop1VDNxmMlmvTWQK9MHA+UZmOuPFz2D9cCw2ig0gzo1pq2L4ERAaVdtIFbuEKc9xH/JjQy+pfwY5TZucu4iu2Vmt30/1UrvwNaWunB8kTvC3/SHrZZgQDKtATC7adzGHScsOa5QhfZi6ihkxE7KyOKJWygXzRPrMvMlC9HOynuRfq5V4Baj9IYkiHLAtJdBtOid4mLxvmbvI9xX6u0UdKCg1GzOdBVZnkfna1VNrq8PVC122UDZLpOnIZCpTHP2nPnapDYr7Xs+QyFDWhMc0lU+/C4wa2F4K1XJ8Z2sinDuGymaGb2aTHPUHKTUpSERUp4V2bWyHAvAvQ78wwXqs4AsybxWNHFdbz4Dt6xmrTXdKNAKhFRII=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6573879-f8e9-461f-bcff-08d81f67cd77
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 15:43:16.3956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tH9bnqdY9wIaS9fdVswhqRgkavLLf3RfbNhlbay+hvlxtR4z4KIHFNANwWxLCvIICQSE25+Gq8fdSON82Wxy+cikmfvU471vCiKv2njvH1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5253
Received-SPF: pass client-ip=40.107.6.139;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 11:43:17
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

02.07.2020 18:49, Markus Armbruster wrote:
> Pass &error_abort instead of NULL where the returned value is
> dereferenced or asserted to be non-null.  Drop a now redundant
> assertion.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/core/platform-bus.c     | 6 +++---
>   hw/ppc/spapr_drc.c         | 3 ++-
>   hw/ppc/spapr_hcall.c       | 3 ++-
>   hw/ppc/spapr_pci_nvlink2.c | 3 ++-
>   ui/vnc.c                   | 2 +-
>   5 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
> index d494e5cec1..5037ca265e 100644
> --- a/hw/core/platform-bus.c
> +++ b/hw/core/platform-bus.c
> @@ -22,6 +22,7 @@
>   #include "qemu/osdep.h"
>   #include "hw/platform-bus.h"
>   #include "hw/qdev-properties.h"
> +#include "qapi/error.h"
>   #include "qemu/error-report.h"
>   #include "qemu/module.h"
>   
> @@ -63,9 +64,8 @@ hwaddr platform_bus_get_mmio_addr(PlatformBusDevice *pbus, SysBusDevice *sbdev,
>           return -1;
>       }
>   
> -    parent_mr = object_property_get_link(OBJECT(sbdev_mr), "container", NULL);
> -
> -    assert(parent_mr);
> +    parent_mr = object_property_get_link(OBJECT(sbdev_mr), "container",
> +                                         &error_abort);
>       if (parent_mr != pbus_mr_obj) {
>           /* MMIO region is not mapped on platform bus */
>           return -1;
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index d10193f39e..1f18b79348 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -870,7 +870,8 @@ int spapr_dt_drc(void *fdt, int offset, Object *owner, uint32_t drc_type_mask)
>               continue;
>           }
>   
> -        obj = object_property_get_link(root_container, prop->name, NULL);
> +        obj = object_property_get_link(root_container, prop->name,
> +                                       &error_abort);
>           drc = SPAPR_DR_CONNECTOR(obj);
>           drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
>   
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 0f54988f2e..c1d01228c6 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1655,7 +1655,8 @@ static void spapr_handle_transient_dev_before_cas(SpaprMachineState *spapr)
>               continue;
>           }
>           drc = SPAPR_DR_CONNECTOR(object_property_get_link(drc_container,
> -                                                          prop->name, NULL));
> +                                                          prop->name,
> +                                                          &error_abort));
>   
>           if (spapr_drc_transient(drc)) {
>               spapr_drc_reset(drc);
> diff --git a/hw/ppc/spapr_pci_nvlink2.c b/hw/ppc/spapr_pci_nvlink2.c
> index 8332d5694e..dd8cd6db96 100644
> --- a/hw/ppc/spapr_pci_nvlink2.c
> +++ b/hw/ppc/spapr_pci_nvlink2.c
> @@ -358,7 +358,8 @@ void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbState *sphb, void *fdt)
>       for (i = 0; i < sphb->nvgpus->num; ++i) {
>           SpaprPhbPciNvGpuSlot *nvslot = &sphb->nvgpus->slots[i];
>           Object *nv_mrobj = object_property_get_link(OBJECT(nvslot->gpdev),
> -                                                    "nvlink2-mr[0]", NULL);
> +                                                    "nvlink2-mr[0]",
> +                                                    &error_abort);
>           uint32_t associativity[] = {
>               cpu_to_be32(0x4),
>               SPAPR_GPU_NUMA_ID,

the following
uint64_t size = object_property_get_uint(nv_mrobj, "size", NULL);

is a good candidate for error_abort as well.

with it or not:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> diff --git a/ui/vnc.c b/ui/vnc.c
> index 527ad25124..f006aa1afd 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -568,7 +568,7 @@ VncInfo2List *qmp_query_vnc_servers(Error **errp)
>                          &info->vencrypt, &info->has_vencrypt);
>           if (vd->dcl.con) {
>               dev = DEVICE(object_property_get_link(OBJECT(vd->dcl.con),
> -                                                  "device", NULL));
> +                                                  "device", &error_abort));
>               info->has_display = true;
>               info->display = g_strdup(dev->id);
>           }
> 


-- 
Best regards,
Vladimir

