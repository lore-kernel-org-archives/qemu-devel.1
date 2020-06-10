Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9FEC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 18:15:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A1E2206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 18:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AYb2rcN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A1E2206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj5Fy-0007H5-9Z
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 14:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jj5F7-0006jQ-7Z; Wed, 10 Jun 2020 14:14:29 -0400
Received: from mail-vi1eur05on2125.outbound.protection.outlook.com
 ([40.107.21.125]:61408 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jj5F4-0004Lk-RS; Wed, 10 Jun 2020 14:14:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLdNTpQtPvQmcyeIiuu9QlI68d4H8lmSApJ0KWCkBI9rEAB4ja64ZvZyVoRcDU4G/daw+j/ooBO+ro0HjOrP8qWmGfo+JS53QW+CMM0Txr1/SVbe65T/4j1Br8u97y6KBWgvc8mv2UQKvJc2YH99o7RYvyegiPj+JFxsh2F9l0KA7EkLfias9xCpemxI5qaOZSVE1kYCXlYoCtnAf7pXlhGobKZ1zwbkiMRJM1QGljbndPBswPErla3rioYK68bjww1I8T1PZ8IxARsBT8EFqVeCu91mq2oyGOGVXzUoXS8oYUx/BMGsLcrS8Bq0URHKFqpcqQ57K7ZEdogFU1nSWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VK3KG4eHyKAkm1vlIOGKOlykUVYfqaDH3uwz0msRo3I=;
 b=XJfpsPsDF8e3HSwPSxo4d5g1dNzy9S+jt4BEoQS9j3othI8ofq3iUCCGgZdt+BQyAv8FEmmVTT+AkiNUGqHuY62CasoucjECvb0YPakQOWta46lbPCbuvpl3vtU3yEAkZA293kDCjxJLNXyCwv4ftV+l2D3zsCfTDoA+srr6Tb70r2D3d2ecRtNSqAMV7BvG1qOzB/9DwlkIC+cXkh7vUIqKiv0LEjWaRT7/str8reJFBFW8vSWDR5GKU0az81DA0LZXdCylJK0XfaNqqNCF6RNOZWt750jrHJuDmRHC2NErEry/vI/MCUnLpk3AKOWeQQUyAm9SmbEZ+DbR1t92dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VK3KG4eHyKAkm1vlIOGKOlykUVYfqaDH3uwz0msRo3I=;
 b=AYb2rcN3jtbJW0tFBH8igdfLsCkBY3jk3ifkfz/SNJft8/6ngfCqs7DAFxGraq3eGpKMom07Jvzw5W+4+QEvODQcM3gId1m1vf/NcWo33z64ur4Fege1oAbINmx2bu85W1888hE8spcbWZTT58TafJO9cmabdlblekpiKvlTjio=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5445.eurprd08.prod.outlook.com (2603:10a6:20b:10d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Wed, 10 Jun
 2020 18:14:23 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 18:14:23 +0000
Subject: Re: [PATCH 3/3] spapr: Forbid nested KVM-HV in pre-power9 compat mode
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <159180935807.29090.16079635439548762534.stgit@bahia.lan>
 <159180946200.29090.1530776456251159527.stgit@bahia.lan>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c2e56898-9bd1-921f-9a35-dc5cbd73ba63@virtuozzo.com>
Date: Wed, 10 Jun 2020 21:14:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <159180946200.29090.1530776456251159527.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.166) by
 FR2P281CA0026.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Wed, 10 Jun 2020 18:14:22 +0000
X-Originating-IP: [185.215.60.166]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b7120bb-c82b-4858-742e-08d80d6a1a40
X-MS-TrafficTypeDiagnostic: AM7PR08MB5445:
X-Microsoft-Antispam-PRVS: <AM7PR08MB544508172082963FF6657552C1830@AM7PR08MB5445.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: egZqvRuyw8k45M3qe5LRdRTXyhgp0YMi17ciT88MHMETAjdVLEBXvxA4mMzdJOkxPoPhJU4MojBgnysCYa4zhwgn2GaxSU+1P0dKB6YVfNlTCgDJlyXzuFLq6xVOIuLNJTXdmlS1zRE+8+nnqMXkCm01cOcQPoTeR+sUxMx4Ji/k/eY0WFGaI8FgIpbkZXqGT7fXYsjMHkFHiMlZMHN050Nv9MDQFR+1Cb9IDwHK5UceydI0Wdwe8F11iDMxKCK3pwysLB2pbcDN/2cHNJY1f0fSEeK1GjHbWNrSQjDX3CIndxczqqBC2nkOqPG1WY3wo8JGHqcx6tnsp1npKD+E7rXqlOuvNdUziqb4hau2u2pmIidNoQc1WaX/dZS0zA59
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(39850400004)(136003)(396003)(366004)(66946007)(26005)(16526019)(5660300002)(31686004)(4326008)(6486002)(8676002)(8936002)(2906002)(66556008)(478600001)(2616005)(66476007)(16576012)(186003)(54906003)(83380400001)(86362001)(956004)(36756003)(316002)(52116002)(31696002)(110136005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: HCSxy54yX7H96sykigdpD+6NlNuisHqWkI2PE7WI+5O2KmIc4ND+w+yquix10fxDg9n+ihx/PE8ehTaLoxiv21ss6LFYewl0jFBpeIZQpBL34JUFZZkNER+45e+3JoFCMRYfOfbu5gLCQh8V/+rSBn5LQwPbumlkl6BNl/TaRP3aNke2KLgZDv6t+aYBO6kdTAnLa/tv63370f8ordfolwu009erX/X8Vki5TzkzoEhGQe3mCnkQWhFB5g3cpq+Qnrjg8ttP5K4+b2scpXseDI5NRpcsuOKdu/1KNxSRmDEE9JorKoPursSqiHS2HwQ4e66f7l6865hBBeDsp3zWDjIVRQJQKvpmk5EB9epmw1PtSEKkyaW8SkJ++fhuHcQslSHId8y7fl4wI3wQJr7GfgSsIpCTsD8dSylyNNxrt8pmId8+34CzSV68QX2Yb3tu5tybK05I1eGzXEblMBawGAbBsuqbhl5n/TZrV6isb/sY9XH0EeCK7ruPP05fysix
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7120bb-c82b-4858-742e-08d80d6a1a40
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 18:14:23.1977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tI6/E3xShy2FcVwjjzLsWG4QXSkA1QRC/0Ik/dkTDwhucLB6wqDlfz3yyIBkLZxIoUPz8biyjz+3B4OsgAhNJS+fJDiY5XN0UGtw85ftoVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5445
Received-SPF: pass client-ip=40.107.21.125;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 14:14:24
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
> Nested KVM-HV only works on POWER9.

Worth mention that existing usage of error_append_hint in the function is fixed too by this patch?

> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   hw/ppc/spapr_caps.c |   11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 0c3d3b64a508..05c8f70506ad 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -408,6 +408,9 @@ static void cap_hpt_maxpagesize_cpu_apply(SpaprMachineState *spapr,
>   static void cap_nested_kvm_hv_apply(SpaprMachineState *spapr,
>                                       uint8_t val, Error **errp)
>   {
> +    ERRP_AUTO_PROPAGATE();
> +    PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
> +
>       if (!val) {
>           /* capability disabled by default */
>           return;
> @@ -417,6 +420,14 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState *spapr,
>           error_setg(errp, "No Nested KVM-HV support in TCG");
>           error_append_hint(errp, "Try appending -machine cap-nested-hv=off");
>       } else if (kvm_enabled()) {
> +        if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00, 0,
> +                              spapr->max_compat_pvr)) {
> +            error_setg(errp, "Nested KVM-HV only supported on POWER9");
> +            error_append_hint(errp,
> +                              "Try appending -machine max-cpu-compat=power9\n");

I think you should either add \n to all other hint in this function or drop this \n.

> +            return;
> +        }
> +
>           if (!kvmppc_has_cap_nested_kvm_hv()) {
>               error_setg(errp,
>   "KVM implementation does not support Nested KVM-HV");
> 
> 


-- 
Best regards,
Vladimir

