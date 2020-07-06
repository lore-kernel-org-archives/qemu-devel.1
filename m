Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E6FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 11:24:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FA232074F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 11:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iC7Ut1CE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FA232074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsPEX-0006pb-8t
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 07:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jsPDY-0005w8-Pj; Mon, 06 Jul 2020 07:23:25 -0400
Received: from mail-eopbgr30125.outbound.protection.outlook.com
 ([40.107.3.125]:38725 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jsPDV-00088M-Dh; Mon, 06 Jul 2020 07:23:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rhrg/Aa4IgyBl2mBTDU0kYwqtznE3FlZzUAHM5y9AzXjSXm/O2X4LsPwVqBmnxY3Va5PpnLB6WqbEt7Y4GR33w8GqNgOmNn2oYpWPWwPUDsRKPkITQaRIgWxzzjAsha+LK3UwHaV/g6Cgs2PYJpmrmjNFhajsJKDvfeGfiCuGuGe9Gi1xa9IKHNO+7GkfTpKdeR2quo/VRUcvOKW/cKPhZFlFgNu40LqnYiLHNZ9s1ON9aFmZ5kkZchIAyrEMdYX5t3vYRE6ob3pMNgsQ06w9BAukwZbW3PJhM032A+gNFnkvVdBLuYexy8rJbfr3qdMEUsXQlR1GdSMIAvzo68c9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8/EJgVLlm0LykqOhRRHa/ifoIbCkMRaBBygqGdlHpg=;
 b=GygdRX1vDSr1S8ivTCUTdYQwWwgViY16TSVO3zLT5GFkux07A34nDs+p/cdQ8/EH58NyEdgAXOPx3FAP4aGm2Exiu6CpVNd7gUYMW6MGsX3YsrGJJxvBJIdTT8/xqrYMSDFN+q2jiyWh2i9qj0czPtWy86az9vIX0duRwaUfY+D1rcfwmVa3+ExiPcjhGghZB4KCn3xnpjiFM640LHLBlJ9YNOyK+/tSM4Yq0Lz3pfEMPOHgp4lLK1Ix/VJjtA6BWmHL9J/u/zfGWdv54tGZylyDfKX8SBoQWRhjvCPDGn3VDB7lkmp/sPrvMxQ2cTEplwrTigEnvUFxmPewmxN1nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8/EJgVLlm0LykqOhRRHa/ifoIbCkMRaBBygqGdlHpg=;
 b=iC7Ut1CEQpwdg7nhR3ml4WhjPrxW2f48xjdXF+uAFIMrC8ha4imk7/YgLgDg750dshLkH4GBNSdPAADWM2VxVqvmfBRncKnOG1kU8/vllyQJCn5wzS+EKx/3TgpACTs7HwZc1sObdFs6L1spVX24pdFzhKFaoie9b7jODxcWsf8=
Authentication-Results: kaod.org; dkim=none (message not signed)
 header.d=none;kaod.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1907.eurprd08.prod.outlook.com (2603:10a6:203:4a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Mon, 6 Jul
 2020 11:23:18 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 11:23:18 +0000
Subject: Re: [PATCH v3 24/44] qom: Use return values to check for error where
 that's simpler
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200706080950.403087-1-armbru@redhat.com>
 <20200706080950.403087-25-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2f366245-8995-6446-898c-ced84d04b5b7@virtuozzo.com>
Date: Mon, 6 Jul 2020 14:23:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200706080950.403087-25-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0004.eurprd04.prod.outlook.com
 (2603:10a6:208:122::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.58) by
 AM0PR04CA0004.eurprd04.prod.outlook.com (2603:10a6:208:122::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend
 Transport; Mon, 6 Jul 2020 11:23:17 +0000
X-Originating-IP: [185.215.60.58]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b880912a-f825-48c4-1f08-08d8219efb4e
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1907:
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1907EB826BA65FD46C73F001C1690@AM5PR0801MB1907.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TpZXFtHMFiVy36nA/KMRMtG96SsYDY6kHG458ZnVaW/2uk5DNSq6i9Rpuow4g7EwbA1Cge/2S/lUcpsQOfWjxaRHHfBfq8ySaSytFSEkZnmVIitthSIsSdAYUGfX+ZM9DHqh9cn6cwefBhUZi/F4KjJTtbjadQJa+eyxVvpDwYxMo159+pvbN/Pey4VJYZOnxWZ4Qr3NDyIBZ1aljjY7xJ5DT/w29TiFnSW1c4TW5SjB3FPWfU8KpRnN+DleJ9qzWuZwFHauHak9BhJscs1NbqYsreTtCwKll8sdlnRoClQcPXnnzbs3OHpwN743vhvK+B2Goe5LViU9lXiJu9E6ZYvcnQkRMntTyDwea2xS1QX9MpkSeM8JMvXV9Z4aG2OW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(346002)(39840400004)(366004)(136003)(5660300002)(186003)(4744005)(2906002)(16526019)(316002)(16576012)(66946007)(31696002)(31686004)(86362001)(66556008)(66476007)(956004)(2616005)(6486002)(8936002)(4326008)(52116002)(8676002)(36756003)(478600001)(26005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 1pSapvEhUiFc/N8qUVOCNDETKf5Kvcwvfpzs6Qfhc8yaXj/N04iBF7FiGdtdxiTIaliR4t/58m3MxXcHvIqJrnnYp8WOsBkE2vQxeSG8DsWa5HC7+y5RRRkhAZHE3bxj2xPVxJFMj8lhj5DM8u6GKodlgpqV8Gs/OjWXSA469kyHdxrpxTVjlr5KqieUIMTp2i9E4rzPPKfwmvVpuRqAJlvBKbwfYUqi71DmxWZqo/WEsydzzaaI6VRwi/mqtzrzUsIWwc1DdKMYYMUvQOMK2ng3mmV1d60vhUIUTY+HYVe3WntIBG20y5o1TqtOl97EGBtRv0HHLDOW/HN19D2/eeXOuvt8Uq/ZvygdXG0JdPav9pKIbsOdJvQ4tvRaqirvBxQpsDoJaRFckOpfd8OX/q4yaB9pp1ox0LSlOgTjuxunHJXfN+79lXrYUu+xxQ5utUdslM+2jucBFTDYDjsYweAlGFshJqS1owZFCBk6Atk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b880912a-f825-48c4-1f08-08d8219efb4e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 11:23:17.9159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iiYtFweetPixXwFUAmaisv3I+rjQfsYQMRafTdxmwVP36fSGPOc82p8Ahx9IwGSG8c4b190xWBWtxf6ZmJvBKnBac1WjCFXQiccIxJWj8E8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1907
Received-SPF: pass client-ip=40.107.3.125;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 07:23:19
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

06.07.2020 11:09, Markus Armbruster wrote:
> When using the Error object to check for error, we need to receive it
> into a local variable, then propagate() it to @errp.
> 
> Using the return value permits allows receiving it straight to @errp.
> 
> Signed-off-by: Markus Armbruster<armbru@redhat.com>
> Reviewed-by: Eric Blake<eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

