Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7324C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 18:05:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77B73206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 18:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="jbigCrP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B73206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj56A-0001Sc-Km
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 14:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jj54N-0000C7-RI; Wed, 10 Jun 2020 14:03:27 -0400
Received: from mail-eopbgr20123.outbound.protection.outlook.com
 ([40.107.2.123]:53910 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jj54L-0002QD-5d; Wed, 10 Jun 2020 14:03:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLrw0Dz3koiTqepWibUjAslYCjZhxTX5czWLXV4GaPCBPlx2/5iWUfcyEfzA7DFApGuNliw+hUE7duB+FqtJ0CSFu5rk/DVDQYa7QSM6oS6tJeosSdk9AQpY6FvF4a5fbs/6JSfkNzNr4QEzUv1b5YV2jVRMOET4zsodo/Y4DrQSgWsUfy4KpddlzRI0u26mR/fP/KVI/qe4oK2uVB9b4QJpnbYVyYJ60jb0JnJEVvTH9fiqsAC1hWEx1LdA1augeDRDMsig0rJeYW3HvXxLF1KfS610Ks6IgbNkguVimbIYrJL16raKL5L2RhUvNcUvlhIjgQLJyhTa9sOEXxi0EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtQ9BzwfRaMhtQK4ki/MVMYKm49u74D6uRXE718SqDM=;
 b=HA0GTZ1w56xGwRjKX767liwtZjypJl37Q5qM01Qc6S5sITo8ZCZHGjhnchBC2lu31JdcWT/lPfs3rfLrO1tVECc42zZAHGhlBIF+pzNw+JnsMCEsBC7V7eY2RpbAy8M2VOeaVe+4bnrs9r2oWhzspM4a5Odo6G1MOz5Kgd3JIqvs+2kikcIC07FlRGkHWj5DC3XF1kOL065Cu2SQH0vfHteOMEjqb9eV0lCGRc9gOiXtuwX56Zie3shGDNpeqMoE40dXiUmJ/ZhwMuF2Nn0Sm/TD+qwfpI5jvs1ZTou1T21dsNjVKtaH3G3HYa8FtrK1+x7E2CQsMO51IaREPKW5Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtQ9BzwfRaMhtQK4ki/MVMYKm49u74D6uRXE718SqDM=;
 b=jbigCrP92TkX0XM86Hc88HuI8Qdc9chunH5MNHy4NcECvbw3G2uNFhHvSZb53rnbuLBbi96RKIP/lH3cQRUKnYKApGk8ujrHfadD2efYQ+iCWd9DSoThSsMI0aeapVzSWjf245xOz02jTlSx21oYgsnvcDM6vBoW7X2m8z2OLJM=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5493.eurprd08.prod.outlook.com (2603:10a6:20b:102::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 10 Jun
 2020 18:03:17 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 18:03:17 +0000
Subject: Re: [PATCH 2/3] spapr: Use error_append_hint() in spapr_caps.c
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <159180935807.29090.16079635439548762534.stgit@bahia.lan>
 <159180945454.29090.15222636045973363294.stgit@bahia.lan>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <3bbcf90e-13c3-1c45-b100-69e0e5bcb0ef@virtuozzo.com>
Date: Wed, 10 Jun 2020 21:03:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <159180945454.29090.15222636045973363294.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR05CA0079.eurprd05.prod.outlook.com
 (2603:10a6:208:136::19) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.166) by
 AM0PR05CA0079.eurprd05.prod.outlook.com (2603:10a6:208:136::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18 via Frontend
 Transport; Wed, 10 Jun 2020 18:03:16 +0000
X-Originating-IP: [185.215.60.166]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7bb86ac-2dae-4596-d801-08d80d688d3c
X-MS-TrafficTypeDiagnostic: AM7PR08MB5493:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5493F9778A59C38A2C100E65C1830@AM7PR08MB5493.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Px3DsTY2p+jrB27HT13xwKovJoz5xPE+qERR+bo0lWb3nUTT7bRupSloJLHZSzN9Ahr4LSaRs7DbyBvNmxhU/GINhE7lrlbZNMr1skF1zy9hPUqcHMZu2Pae3UCFBBGUvoE9+qJSLogfsRxuzXhg/crRozvAvd2IqLnlH2VAjZZKgGEgA9kCOw1FaOPFGbJw0m5XqT1kF/GOG5lCUdOP0IKNadGcLurSvGZAx2/49kNAwvQ4voRAR2m/wQdSw5LGRNWoqT6GZ2OpwfIP0/okRVzOuiMZUsK6E5YhW3vnarFWJvKojqUEacXrV47rUkkIX8Vt6bTUhB8CHTQmOKEpjb718d8iq4WloQB9iAspTcGk+2Sp656qb0JNOvLAq84
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(39850400004)(366004)(376002)(136003)(86362001)(2616005)(26005)(478600001)(6486002)(956004)(31696002)(8936002)(8676002)(316002)(66946007)(110136005)(5660300002)(66476007)(31686004)(2906002)(16576012)(4326008)(16526019)(66556008)(52116002)(83380400001)(36756003)(54906003)(186003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: iN5idNrtqH699xK8hF2ySgyyw+62mVMdKyo0YjvjYz3XfnIErF6msNLe+DhQSrVfP7dP0B7KxI86AMRF7XIQXB0wNLZ1YSjptgRt9rG29N6PTXXVY5tHYfn495XhLXrOFC9UPH+1Z+w2P6VpIrDhk1Yn3BliPEd+XD4dYg59ErJhXqNroUiKNcQb03f2d0LDqHntfCFD/1/UJfPKFHMriWPUNHdsdF6XOk6nq5wAQcsqTT9qvqjuycndjpljtIzgU0dwY/z19lBnecgnyZNaweAhxcNWD4VjjzSAnwDy5FFLTS0OgN+huGeROdA1o1a3rrqDZbIORMPWOnjaH6a2Ae4ZXcqTCt37iL7/WUjd7GjYpziMpghZNWa/XcRCpJSS1KfCaXwOyzfa/qFRGLC5Cejx2EPdZqtonTjhf3NW/+bAcV+Nr/BJoumbUJbem32FoPnOfdb54+7OJa5COF0kDPyZ2N8yHsjsBvY4n6Lpnwo8NhLR+FJdogCUOdQU2gQS
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7bb86ac-2dae-4596-d801-08d80d688d3c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 18:03:17.1564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PrLlyCPqKVOIQMFSPdELbzeJELWNe6JvenfaY3OZnnouAsqP8ql6VIGqWB3ddKBkOCCteHNKeT3Zs/Q2Ag2IxEE1bYgcs3Vs7CCo8zL0nvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5493
Received-SPF: pass client-ip=40.107.2.123;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 14:03:18
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

10.06.2020 20:17, Greg Kurz wrote:
> We have a dedicated error API for hints. Use it instead of embedding
> the hint in the error message, as recommanded in the "qapi/error.h"
> header file.
> 
> Since spapr_caps_apply() passes &error_fatal, all functions must
> also call the ERRP_AUTO_PROPAGATE() macro for error_append_hint()
> to be functional.
> 
> While here, add some missing braces around one line statements that
> are part of the patch context. Also have cap_fwnmi_apply(), which
> already uses error_append_hint() to call ERRP_AUTO_PROPAGATE() as
> well.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   hw/ppc/spapr_caps.c |   93 +++++++++++++++++++++++++++++----------------------
>   1 file changed, 52 insertions(+), 41 deletions(-)
> 
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index efdc0dbbcfc0..0c3d3b64a508 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -189,24 +189,24 @@ static void spapr_cap_set_pagesize(Object *obj, Visitor *v, const char *name,
>   
>   static void cap_htm_apply(SpaprMachineState *spapr, uint8_t val, Error **errp)
>   {
> +    ERRP_AUTO_PROPAGATE();
>       if (!val) {
>           /* TODO: We don't support disabling htm yet */
>           return;
>       }
>       if (tcg_enabled()) {
> -        error_setg(errp,
> -                   "No Transactional Memory support in TCG,"
> -                   " try appending -machine cap-htm=off");
> +        error_setg(errp, "No Transactional Memory support in TCG");
> +        error_append_hint(errp, "Try appending -machine cap-htm=off\n");
>       } else if (kvm_enabled() && !kvmppc_has_cap_htm()) {
>           error_setg(errp,
> -"KVM implementation does not support Transactional Memory,"
> -                   " try appending -machine cap-htm=off"
> -            );
> +"KVM implementation does not support Transactional Memory");

Should be indented after opening '('

> +        error_append_hint(errp, "Try appending -machine cap-htm=off\n");
>       }
>   }
>   
>   static void cap_vsx_apply(SpaprMachineState *spapr, uint8_t val, Error **errp)
>   {
> +    ERRP_AUTO_PROPAGATE();
>       PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
>       CPUPPCState *env = &cpu->env;
>   
> @@ -218,13 +218,14 @@ static void cap_vsx_apply(SpaprMachineState *spapr, uint8_t val, Error **errp)
>        * rid of anything that doesn't do VMX */
>       g_assert(env->insns_flags & PPC_ALTIVEC);
>       if (!(env->insns_flags2 & PPC2_VSX)) {
> -        error_setg(errp, "VSX support not available,"
> -                   " try appending -machine cap-vsx=off");
> +        error_setg(errp, "VSX support not available");
> +        error_append_hint(errp, "Try appending -machine cap-vsx=off\n");
>       }
>   }
>   
>   static void cap_dfp_apply(SpaprMachineState *spapr, uint8_t val, Error **errp)
>   {
> +    ERRP_AUTO_PROPAGATE();
>       PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
>       CPUPPCState *env = &cpu->env;
>   
> @@ -233,8 +234,8 @@ static void cap_dfp_apply(SpaprMachineState *spapr, uint8_t val, Error **errp)
>           return;
>       }
>       if (!(env->insns_flags2 & PPC2_DFP)) {
> -        error_setg(errp, "DFP support not available,"
> -                   " try appending -machine cap-dfp=off");
> +        error_setg(errp, "DFP support not available");
> +        error_append_hint(errp, "Try appending -machine cap-dfp=off\n");
>       }
>   }
>   
> @@ -248,6 +249,7 @@ SpaprCapPossible cap_cfpc_possible = {
>   static void cap_safe_cache_apply(SpaprMachineState *spapr, uint8_t val,
>                                    Error **errp)
>   {
> +    ERRP_AUTO_PROPAGATE();
>       Error *local_err = NULL;
>       uint8_t kvm_val =  kvmppc_get_cap_safe_cache();
>   
> @@ -258,13 +260,14 @@ static void cap_safe_cache_apply(SpaprMachineState *spapr, uint8_t val,
>                      cap_cfpc_possible.vals[val]);
>       } else if (kvm_enabled() && (val > kvm_val)) {
>           error_setg(errp,
> -                   "Requested safe cache capability level not supported by kvm,"
> -                   " try appending -machine cap-cfpc=%s",
> -                   cap_cfpc_possible.vals[kvm_val]);
> +"Requested safe cache capability level not supported by KVM");

Hmm you do this intentionally.. OK, than, it's a kind of taste.

> +        error_append_hint(errp, "Try appending -machine cap-cfpc=%s\n",
> +                          cap_cfpc_possible.vals[kvm_val]);
>       }
>   
> -    if (local_err != NULL)
> +    if (local_err != NULL) {
>           warn_report_err(local_err);
> +    }
>   }
>   
>   SpaprCapPossible cap_sbbc_possible = {
> @@ -277,6 +280,7 @@ SpaprCapPossible cap_sbbc_possible = {
>   static void cap_safe_bounds_check_apply(SpaprMachineState *spapr, uint8_t val,
>                                           Error **errp)
>   {
> +    ERRP_AUTO_PROPAGATE();
>       Error *local_err = NULL;
>       uint8_t kvm_val =  kvmppc_get_cap_safe_bounds_check();
>   
> @@ -287,13 +291,14 @@ static void cap_safe_bounds_check_apply(SpaprMachineState *spapr, uint8_t val,
>                      cap_sbbc_possible.vals[val]);
>       } else if (kvm_enabled() && (val > kvm_val)) {
>           error_setg(errp,
> -"Requested safe bounds check capability level not supported by kvm,"
> -                   " try appending -machine cap-sbbc=%s",
> -                   cap_sbbc_possible.vals[kvm_val]);
> +"Requested safe bounds check capability level not supported by KVM");
> +        error_append_hint(errp, "Try appending -machine cap-sbbc=%s\n",
> +                          cap_sbbc_possible.vals[kvm_val]);
>       }
>   
> -    if (local_err != NULL)
> +    if (local_err != NULL) {
>           warn_report_err(local_err);
> +    }
>   }
>   
>   SpaprCapPossible cap_ibs_possible = {
> @@ -309,6 +314,7 @@ SpaprCapPossible cap_ibs_possible = {
>   static void cap_safe_indirect_branch_apply(SpaprMachineState *spapr,
>                                              uint8_t val, Error **errp)
>   {
> +    ERRP_AUTO_PROPAGATE();
>       Error *local_err = NULL;
>       uint8_t kvm_val = kvmppc_get_cap_safe_indirect_branch();
>   
> @@ -319,9 +325,9 @@ static void cap_safe_indirect_branch_apply(SpaprMachineState *spapr,
>                      cap_ibs_possible.vals[val]);
>       } else if (kvm_enabled() && (val > kvm_val)) {
>           error_setg(errp,
> -"Requested safe indirect branch capability level not supported by kvm,"
> -                   " try appending -machine cap-ibs=%s",
> -                   cap_ibs_possible.vals[kvm_val]);
> +"Requested safe indirect branch capability level not supported by KVM");
> +        error_append_hint(errp, "Try appending -machine cap-ibs=%s\n",
> +                          cap_ibs_possible.vals[kvm_val]);
>       }
>   
>       if (local_err != NULL) {
> @@ -408,17 +414,17 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState *spapr,

You forget to add ERRP_AUTO_PROPAGATE

>       }
>   
>       if (tcg_enabled()) {
> -        error_setg(errp,
> -                   "No Nested KVM-HV support in tcg,"
> -                   " try appending -machine cap-nested-hv=off");
> +        error_setg(errp, "No Nested KVM-HV support in TCG");
> +        error_append_hint(errp, "Try appending -machine cap-nested-hv=off");

Hmm, didn't you forget '\n' ? You consistantly add it in previous hints. (I do think that it's strange that we should add it by hand, but it seems a common thing to add it)

>       } else if (kvm_enabled()) {
>           if (!kvmppc_has_cap_nested_kvm_hv()) {
>               error_setg(errp,
> -"KVM implementation does not support Nested KVM-HV,"
> -                       " try appending -machine cap-nested-hv=off");
> +"KVM implementation does not support Nested KVM-HV");
> +            error_append_hint(errp, "Try appending -machine cap-nested-hv=off");

and here

>           } else if (kvmppc_set_cap_nested_kvm_hv(val) < 0) {
> -                error_setg(errp,
> -"Error enabling cap-nested-hv with KVM, try cap-nested-hv=off");
> +                error_setg(errp, "Error enabling cap-nested-hv with KVM");
> +                error_append_hint(errp,
> +                                  "Try appending -machine cap-nested-hv=off");

and here

>           }
>       }
>   }
> @@ -426,6 +432,7 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState *spapr,
>   static void cap_large_decr_apply(SpaprMachineState *spapr,
>                                    uint8_t val, Error **errp)
>   {
> +    ERRP_AUTO_PROPAGATE();
>       PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
>       PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
>   
> @@ -436,22 +443,23 @@ static void cap_large_decr_apply(SpaprMachineState *spapr,
>       if (tcg_enabled()) {
>           if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00, 0,
>                                 spapr->max_compat_pvr)) {
> -            error_setg(errp,
> -                "Large decrementer only supported on POWER9, try -cpu POWER9");
> +            error_setg(errp, "Large decrementer only supported on POWER9");
> +            error_append_hint(errp, "Try -cpu POWER9\n");
>               return;
>           }
>       } else if (kvm_enabled()) {
>           int kvm_nr_bits = kvmppc_get_cap_large_decr();
>   
>           if (!kvm_nr_bits) {
> -            error_setg(errp,
> -                       "No large decrementer support,"
> -                        " try appending -machine cap-large-decr=off");
> +            error_setg(errp, "No large decrementer support");
> +            error_append_hint(errp,
> +                              "Try appending -machine cap-large-decr=off\n");
>           } else if (pcc->lrg_decr_bits != kvm_nr_bits) {
>               error_setg(errp,
> -"KVM large decrementer size (%d) differs to model (%d),"
> -                " try appending -machine cap-large-decr=off",
> -                kvm_nr_bits, pcc->lrg_decr_bits);
> +                       "KVM large decrementer size (%d) differs to model (%d)",
> +                       kvm_nr_bits, pcc->lrg_decr_bits);
> +            error_append_hint(errp,
> +                              "Try appending -machine cap-large-decr=off\n");
>           }
>       }
>   }
> @@ -460,14 +468,15 @@ static void cap_large_decr_cpu_apply(SpaprMachineState *spapr,
>                                        PowerPCCPU *cpu,
>                                        uint8_t val, Error **errp)
>   {
> +    ERRP_AUTO_PROPAGATE();
>       CPUPPCState *env = &cpu->env;
>       target_ulong lpcr = env->spr[SPR_LPCR];
>   
>       if (kvm_enabled()) {
>           if (kvmppc_enable_cap_large_decr(cpu, val)) {
> -            error_setg(errp,
> -                       "No large decrementer support,"
> -                       " try appending -machine cap-large-decr=off");
> +            error_setg(errp, "No large decrementer support");
> +            error_append_hint(errp,
> +                              "Try appending -machine cap-large-decr=off\n");
>           }
>       }
>   
> @@ -482,6 +491,7 @@ static void cap_large_decr_cpu_apply(SpaprMachineState *spapr,
>   static void cap_ccf_assist_apply(SpaprMachineState *spapr, uint8_t val,
>                                    Error **errp)
>   {
> +    ERRP_AUTO_PROPAGATE();
>       uint8_t kvm_val = kvmppc_get_cap_count_cache_flush_assist();
>   
>       if (tcg_enabled() && val) {
> @@ -504,14 +514,15 @@ static void cap_ccf_assist_apply(SpaprMachineState *spapr, uint8_t val,
>               return;
>           }
>           error_setg(errp,
> -"Requested count cache flush assist capability level not supported by kvm,"
> -                   " try appending -machine cap-ccf-assist=off");
> +"Requested count cache flush assist capability level not supported by KVM");
> +        error_append_hint(errp, "Try appending -machine cap-ccf-assist=off\n");
>       }
>   }
>   
>   static void cap_fwnmi_apply(SpaprMachineState *spapr, uint8_t val,
>                                   Error **errp)
>   {
> +    ERRP_AUTO_PROPAGATE();
>       if (!val) {
>           return; /* Disabled by default */
>       }
> 
> 


-- 
Best regards,
Vladimir

