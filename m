Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5396C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:27:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1411221D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WyZGlYJM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1411221D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI8B9-00070P-4B
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 06:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kI8AE-0006Qv-I2; Tue, 15 Sep 2020 06:26:18 -0400
Received: from mail-eopbgr20139.outbound.protection.outlook.com
 ([40.107.2.139]:51681 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kI8AB-00025B-OF; Tue, 15 Sep 2020 06:26:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AteU/i4FfNENGQepgyJ8KKNg6VB5bZX5bLqnFivmktsnXiO7KTDswC6Z1lxwRzSG+55PIQOx9ke+ryp/8AL8PPH1bA0qSYamIxlXmHNJFwXIXT2vOqxdKHTzfw8DW7jOPO2U4ADku3UYeUfszHow3vdg5Vk9x8YwX+YZAdPqGwjKJfwETGuJyOYlNBOkU01rH3G4e85zWEWbMQXd9m/eb/Wkt21tpAxuNgTHKTGV4ryjyqn1sLeOvKtqJxabExw3/Dmn4Q3ftDIatrh41iehXGv2J1yDk2BZvGc1PZy3Vks1tX8yrZu//V06vW/PARcke7lvdfNxah6v98TRaz/Qyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbnxnY8hueYzzCl9jYXZlj1yxW8ilfp5G9EaxyJOALE=;
 b=kCBW1slbhA4T2HdNwU7GT7fl0ZF5ITRJusr5ymCwCsgkw0ev3O7H/cXBuR6hh2onb4cobUhmcL38ZLfp7chfkmO7VGFe68KdJypeNOz7aYUMNZUbXlnrd1xzh4hk4gakfbQHagNNWzzi9idpPlGTAEMKpZgsYSxMCsIeBruPWhYMgC89KGsx+QlT6fYaH9hksxaexUVsqtcEjjhi3htgHGRFKnLkpbUaFlvKzM9ugrXpLuzgb6kZMWrH2jGARRZ3u689KjiuUbwOXbCUZG21bT+poIDXJur1KGek2J9tEcV9cpxiDMyou3MFrbTJMK1vYTI5mb0JZ9PdZpydlNMz/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbnxnY8hueYzzCl9jYXZlj1yxW8ilfp5G9EaxyJOALE=;
 b=WyZGlYJMVZvTH3k3UwGt5FTo+eeF2W497oFa5VmNb7WRA7HI/SI4/Qf3gTlhRqCXA2hHm+zTLO3IpyK5mrmnkfv3JByvYy/tI5AKjfebJlgnM8UKm4lrzLU6dN6tGwRLsNCxOaq+KyT5v2Foa07cJMBZGFuYNky5TKXa4VHjWeg=
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2450.eurprd08.prod.outlook.com (2603:10a6:203:a0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Tue, 15 Sep
 2020 10:26:07 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 10:26:07 +0000
Subject: Re: [PATCH 09/15] spapr: Simplify error handling in prop_get_fdt()
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200914123505.612812-1-groug@kaod.org>
 <20200914123505.612812-10-groug@kaod.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <5d7d8cb0-4b91-f929-63eb-90684bc08481@virtuozzo.com>
Date: Tue, 15 Sep 2020 13:26:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200914123505.612812-10-groug@kaod.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR05CA0034.eurprd05.prod.outlook.com (2603:10a6:205::47)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.75) by
 AM4PR05CA0034.eurprd05.prod.outlook.com (2603:10a6:205::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Tue, 15 Sep 2020 10:26:07 +0000
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b651a1f2-205b-4a74-4c4d-08d85961c1f2
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2450:
X-Microsoft-Antispam-PRVS: <AM5PR0802MB245014D4DED5EA7B5C9518DBC1200@AM5PR0802MB2450.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5fbWYIzEkBYnIYR2/kAJdhhOAmLgpvt880PikAsVJcmzQ8/x9u2TRJXQDH+sM5gHl1c5ADeUcroKSptM9FFEkmUddCOhbN45x6hY+A8Bbwu5QQJ8bgJF8YV5koZ2p6rL81BheiwaYHqIQ/h9a10Pw+IPFTLWrvgQ2skgRD0uP3CtEdfxNoV23sa8jpdF20Xt6U0E3HLRa9sjPn0j1hgWyOx3P4tMmbqKKiQAUWfvdE3dDwkMVkYcNdfsfDWMvJl+P71v7Ra4NUmK/72ihVBKRu2CnpmPcMyFhKqlw4MwXEdwCHVvUsWM+3bxctqXPqG/Blp0NFOmd64faBaTi7pP6EJ3j4TGdg8r80g00yCpO1oRv+pQyDZ+R25yeXorKN8O
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39840400004)(396003)(346002)(366004)(66946007)(66476007)(66556008)(52116002)(86362001)(31696002)(36756003)(5660300002)(4744005)(2906002)(8676002)(26005)(2616005)(956004)(186003)(16526019)(478600001)(6486002)(16576012)(316002)(54906003)(8936002)(31686004)(4326008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: H4euEdXgp/oP6dfmLlONMKvZ7nfFEthXJHQa3RuaDoGdMxTxBTtTd/KHL/zvZgGtHpAQ+J3X7qCawldQSzAIa57/5m9Hed/Tn9FaeTwRbDMG06FmReUDVIZ/dTid5bQ53taIBIYLxVRZdjbokSAG8fx3JgHYmYyOAtwTyxAwmVBrsf9FH1UvelabKqmCvOT+Dbc3aoGvqOIRIguuTmzaqOaYuw1PN5zGxgXCjQWk+g8VlZP0xtnfogRSpObFCAyyOiPAUNi6o6BAF1by0oO4JzJ905pz3jz3RnUMzVhpTbbcj7Bl0qN4MT6kim6xCPHjRbzqTuNr67uqL0jhqAD2qS6xGIbooQmDusmcWIWaJvdpWmRMC+bbwHnO6rOO7JoWqqTd6ewOfmEW10gfvNdgIV9PYjF0ENCVX5N+VwgbMU97GiqC8uHU7SMsulsZFl7UZy6N4ovBPAGvg1MIylzv2A0v1vb642RdR2CAECNjnZ6Vae0gFE/kbkQyHJrcVr9UmZ7S+m6CrSflo+l4JPB0pB1DarxKrQpgDk++DKySCkxeXhauhRuEPdHJhL4S8E3bh0NzBaMTR8YfQQ2PqW9qGDX2SiYhb4lFwSCfhLRa4wQ4UPvh9Gv8OurIxOlZ0jvfcf7eXLmQ9rSO2jmN6++ssg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b651a1f2-205b-4a74-4c4d-08d85961c1f2
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 10:26:07.4602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f43JOZ0kRUZULWymDhfvnIf6aaA2U4IJ8xmzcywB2khnwtTxl1vr8bYXTpRFU+SjH9U/PUdNaq3qCOfrHfqdYH/PoqHdYIlu7w7W3Siv4S0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2450
Received-SPF: pass client-ip=40.107.2.139;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 06:26:07
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

14.09.2020 15:34, Greg Kurz wrote:
> Use the return value of visit_check_struct() and visit_check_list()
> for error checking instead of local_err. This allows to get rid of
> the error propagation overhead.
> 
> Signed-off-by: Greg Kurz<groug@kaod.org>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

