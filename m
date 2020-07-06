Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F98C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:09:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6687720708
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="STbraNic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6687720708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsTg7-00023x-Mc
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 12:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jsTfE-0001D2-Ky; Mon, 06 Jul 2020 12:08:16 -0400
Received: from mail-vi1eur05on2128.outbound.protection.outlook.com
 ([40.107.21.128]:35552 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jsTf9-0004EX-3R; Mon, 06 Jul 2020 12:08:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxkwMJVHz6O+7N6jK4wGETDCuk3u1Fry3pK8WVnYukwwlbQWPGYzPXa0qI/FBMRzsIG6dyetzB8KKdaxxligho7VpI0u7jUXtn7nTD/NrWvrOzm12ysHPm1zcLqh3ttr3O9qEXUFIMhLJxcas8bB6IlBmwBh4ULpta8SZKdPKJyx7cgDI88Pk+JqdksaNsXU+pZcF79fQoa/xc4NcCGR0Bxd/CRMvAI24hHy/LYJZOzEtgW9oVX5/7JNlThPA1qIYDXNbfB/ZcFru2N3aITvLCQQOVxsBn8K4WINilHRjwW0OGyL+P3F9ht8WpslheejRqmOAESx+Drd0B3vAI6zaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhFEVfTtS5+rAWdYBS5Jt6RkuzCI6QLAAlh3xUbeUSU=;
 b=SeRQGho8zFCOPu9KTHKOLh0q9Tr1wiKZMbCSDQFiHvkZ3JVJxuaMguEgV6Nv9b+6If1rRe9bhmYtQjruwP6hshB3xUS5s5bpU4R9IPcFkBT+iQsFu7FLwQ7oBi71MnSIyzYVN/IJdTX8ZURDpVnHvN+WlKLgA3ajLAFdMNPhEhkJ5cNxF5Lw5dozH7n4vsU2K/jxTbDnzpnZpC03iVCyrL0yA+8GPehtze9dHQNUDs4horTF6O2nMsXfhjZfr1PVdRPyIIBm91whkHf1u/tz1l0+WYrN9Ilf5idZ4Cco+aNivBd+tBLqfe2IQ9BDk4Ta+lv5cALzWjioJvb45zvVgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhFEVfTtS5+rAWdYBS5Jt6RkuzCI6QLAAlh3xUbeUSU=;
 b=STbraNicOoT7FY797C3MQB1jg/6Bx17YDPQzd23TnDQmA9O7VUPZcHvcudwnVCyNZdaLIGpb0kOckMBbd7+Aqu6laXP1MNH5+nqb5KQ2UztSC+ufD0Y7Lg49Z3rQQCmK2MiBSk9fPvS7YqxJTSDnkiscKQggMvL/BTZrP/Cs1f4=
Authentication-Results: kaod.org; dkim=none (message not signed)
 header.d=none;kaod.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4344.eurprd08.prod.outlook.com (2603:10a6:20b:74::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Mon, 6 Jul
 2020 16:08:08 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 16:08:08 +0000
Subject: Re: [PATCH v3 27/44] qom: Use returned bool to check for failure,
 Coccinelle part
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200706080950.403087-1-armbru@redhat.com>
 <20200706080950.403087-28-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <809626f0-431e-b781-9661-10360d77f84e@virtuozzo.com>
Date: Mon, 6 Jul 2020 19:08:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200706080950.403087-28-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0013.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.12] (185.215.60.58) by
 AM0PR10CA0013.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21 via Frontend
 Transport; Mon, 6 Jul 2020 16:08:07 +0000
X-Originating-IP: [185.215.60.58]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c102fb66-11e5-453b-99be-08d821c6c5f1
X-MS-TrafficTypeDiagnostic: AM6PR08MB4344:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4344FDACB98358FA351942AFC1690@AM6PR08MB4344.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:213;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bjrW65cJHw7iqrZUdnb+AOV9QNDMsfVj4fuSMuvyzGHosN6MpTjRTC0GtDTeZSGO3Fe6QvAYO4wm11U9w3UgrD5eeNewfyJe7WoEvCdBkH4yz0QtKy+UClX0okzfoBjvrGUCtJ/igMxd9i2GUqau3z33SQNsE+lBvyl0p1PJx2cbCNOi/LTgk/xOII/yMs9qiFU2Mk6FtiaKtMS4S4Fb2AA0ZXPfq6HAfw/o9+YUO6ZJc/VyKepdJYm1UOL+0ENhZcrueNojsOaiUkguOkH6CeIsL4i07flRHAcTRRO6egwlVxcnHVFNnFFohRj4Jdn3y09Shyr24zAOYHPAxjBC03xL/t6kCWkKuhEa/SahaIKRL4KC50rUsV/nKhF7ScRm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(376002)(346002)(39840400004)(136003)(16576012)(66476007)(66556008)(66946007)(31696002)(6486002)(2616005)(478600001)(956004)(5660300002)(16526019)(186003)(4326008)(2906002)(86362001)(8676002)(26005)(31686004)(316002)(8936002)(36756003)(53546011)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: SAVn+IAFS9ctc9P+4EPWTjhyoHs0KMSCunHhopVbJI8Np8AHS+1cG4A3UgkpvHwOXzLaRge9yfRCmqKyGW4SLa8PCz2m9oA8ZFj9cxRUr7lG/Sy6J+5CbDRz54Td+nTwUOlCvc7QPfX/gkgp7GnQzFZb5a7Sby2UH04PfmJF76uq3pkLrJvmRj5G2pLFNUT07aP6Zd2Zuaz+XL7bHzpmnSuKKRxBHFW0/vVXByfFFbzzKavZpVPjZjgL+K8xACRgWnjkYvxn/gilpSsu9iaSJl0BDJgQRkLOgfqeB3cbWU0mPlIkFlwrr+0NERIUo8lZOp83Ukhi5aH9Fg754HLOl69X83Uj53GLxfFHGf1edRhjexjVgFCC2JQB3RIv50DU3a8WT84LP6DJVVJr1uBTlI3GR0RNheuQ+IXSvkZBOG967jBjW8rfuWqEwWAKtxfG7XuXZkAz2df+rCqVYf5MCpOpaTqepVzsxsNZAJZJi88=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c102fb66-11e5-453b-99be-08d821c6c5f1
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 16:08:08.2246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83w9bTVAkohc0Aj9KU7QJ+cJMBy6BnbSlkhC7pT1jk4pwghDPgnRhKvy4WriLeiaCIbOKrAud4JljdTpLtu7YD/D7YbIkLvhZrBSAu90+58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4344
Received-SPF: pass client-ip=40.107.21.128;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 12:08:09
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
 qemu-block@nongnu.org, groug@kaod.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06.07.2020 11:09, Markus Armbruster wrote:
> The previous commit enables conversion of
> 
>      foo(..., &err);
>      if (err) {
>          ...
>      }
> 
> to
> 
>      if (!foo(..., errp)) {
>          ...
>      }
> 
> for QOM functions that now return true / false on success / error.
> Coccinelle script:
> 
>      @@
>      identifier fun = {
>          object_apply_global_props, object_initialize_child_with_props,
>          object_initialize_child_with_propsv, object_property_get,
>          object_property_get_bool, object_property_parse, object_property_set,
>          object_property_set_bool, object_property_set_int,
>          object_property_set_link, object_property_set_qobject,
>          object_property_set_str, object_property_set_uint, object_set_props,
>          object_set_propv, user_creatable_add_dict,
>          user_creatable_complete, user_creatable_del
>      };
>      expression list args, args2;
>      typedef Error;
>      Error *err;
>      @@
>      -    fun(args, &err, args2);
>      -    if (err)
>      +    if (!fun(args, &err, args2))
>           {
>               ...
>           }
> 
> Fails to convert hw/arm/armsse.c, because Coccinelle gets confused by
> ARMSSE being used both as typedef and function-like macro there.
> Convert manually.
> 
> Line breaks tidied up manually.
> 
> Signed-off-by: Markus Armbruster<armbru@redhat.com>
> Reviewed-by: Eric Blake<eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

