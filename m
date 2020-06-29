Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC88CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:47:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 753D423437
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LttO4JUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 753D423437
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpqNg-00028F-Op
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 05:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jpqMi-0001d6-3O; Mon, 29 Jun 2020 05:46:16 -0400
Received: from mail-am6eur05on2118.outbound.protection.outlook.com
 ([40.107.22.118]:41569 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jpqMf-00025o-P8; Mon, 29 Jun 2020 05:46:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INUKDedztBhLinEJJeGYHZ7dhCK+yM52DjbHTo3uC8GgTRDJn95wzQGFR3ZQ5zBQxsdHLw1GuPcQdT3Pr0xHTgFib/gU6WdgJSPgyluA58wGEy2hQQtKxpciTOPxO1FwaqACqw6SD0vq70fpb/eYwGLOu31x//jWfb9JxRRjbJHJYRx2pAb6bTVbLlb8IdFoG/5Lu2Z6Z5cV/GFeLmI2aWUHaHOvGzVs6dj+/uYHAB71pEJ8+0Ip7xrav91X41cV9BYYvkq4A7R12c0uVpkrBPv4hBNqexAoGJj0kf8HFgA1LKWf8G+9sdnbojT6xwocFeXqUR78EiX25ovL0mT/nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUzvYAJqaahz1AExeyLBWF0DQC+cO2uQdbVyM0tlsMs=;
 b=ldlvTEoGgUytlwZWi6NJsc0kKWIsHtJtGmlAsgD/VKikztOAyiluanSALs7R4Ngs5L2DDZmvJlCEbosqHhYM4BaEYOoR3yHjuF7LAMhpEeJaslprCGW5Uu9XCnbPsQ3rl9aEp1hZQEiS0tzGpXS8FU1lYvJI8a3kR25EywiETAfMuHdrGlCNZgH+GHP61kuXt/THbfiYHbMRdPOmWkkVKTX1qNFsdkuYpunp+fUH6XNcdOUzkZ4NAMc78Y4eCzFMKKwcE3Ag0bi8CNlnFQnAzYkh1Etd8orAULLzyJNUx9ydu4CQG7wrYBSdpRYN0KzXbnIneOGSdjmyJAvbEqUw7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUzvYAJqaahz1AExeyLBWF0DQC+cO2uQdbVyM0tlsMs=;
 b=LttO4JUU/ajfb6qiZ+URVnvPk5OoXwcGXet5//HtGywwKJw5mFxnoJO+X1NDw6J573YI49HiYuybSyUmYMj/WwhrwEB0SUFSplTYUzstHUBh52cQCM+DDjJ5pnRmhCBeYLRM01+E2FQDpWUX2XmRWLIiWZCbyyW9Gs/aGmt7Ofs=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1905.eurprd08.prod.outlook.com (2603:10a6:203:43::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Mon, 29 Jun
 2020 09:46:09 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 09:46:09 +0000
Subject: Re: [PATCH 12/46] qemu-option: Factor out helper
 find_default_by_name()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-13-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <4a2ea025-aa77-0ad7-440f-9a500fd1178a@virtuozzo.com>
Date: Mon, 29 Jun 2020 12:46:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200624164344.3778251-13-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::27) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.28) by
 FR2P281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20 via Frontend Transport; Mon, 29 Jun 2020 09:46:08 +0000
X-Originating-IP: [185.215.60.28]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f658e797-5e64-4562-e8b4-08d81c114017
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1905:
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1905B356C4A6C8C9C862FB6DC16E0@AM5PR0801MB1905.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:400;
X-Forefront-PRVS: 044968D9E1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FksXfXmm6Ac9Ex1djzh3blQtV/YtRkB8YOba2fmJnfFMwzKEhuLZBbzes1K8+NJI5CMqTA0sZ/sX2FQR0SrruFUNOSvGN/4h7RPxpcq4CGbBxmGQXIIlzjK4FX/jE+QX6iA6Z2udL+n1LClZGxYDFdoz8hk65MS2d8+VA1Z8rMDxzDeHgWgby27gToBYymvoN7YtQni9OtG1ywc+h/A2ARUe95vv75I2kisbQ3RwPJ8NFfzW7hYNtPAJLzew1/GNwLJ7fi1AZWC+LN0lzAgnyprHjClPHOQHfVuvRtYJ+o/eO8jfbiY6PX7NIVhJMUmZ8miXQ13i2fw1u5Kz4ADiDjYBduYIGKTr9dRJjAZNzugtvvKgUMVA7hmbT+HK3lr3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(366004)(346002)(39840400004)(136003)(6486002)(558084003)(478600001)(2616005)(36756003)(956004)(4326008)(26005)(8936002)(2906002)(186003)(16526019)(5660300002)(8676002)(16576012)(31696002)(316002)(86362001)(66946007)(66556008)(66476007)(52116002)(31686004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: AEF5Y8vpM89Xzt9hu0sPKMtC+u5qw94aF9Rm+XH9gCReia0QbrENnS8BLJTO2JqDoQoMAn4nHFMdlUDicQMkLvpov/2zP2y30d8MhgKFLhEqMVhh4zN7FFuwT/d3KaTZdLnY9eEaXOFfYMBpcAVVbakCwGIHPfqavwYXR/idTNQUHSK6hqKWkTYyzUcEZGh5mulsZcWu1agm9fHfSZke2WismroO8lsweoMEXJLBXZ+KyNRnP4Wgfic7U0LmtI1pQA9yvGaiQkj09LFBq/iZLNbFUHjjMIsi34beEqIEXH2m5r6XR5ivSG2NIqMu+8n4RQHpOGPCusXPCtmuTqMlOuU5m86zL3RyLMcASBCatwK8G6dkFXFJA51/5EHlD3uJxC44hHP3hkPKXJJTglvVj9fKhRlLpbicxYO55eJtgywarD5+wXSfzty86XZPa/yuxZ3A3pd1htRMg7JxFMR/KFJORTXmAgONUVfbkfX/6+4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f658e797-5e64-4562-e8b4-08d81c114017
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2020 09:46:08.9171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQKG7BSL/0y1hOxXwWuvzvjDHpuUOEDwPOt1ol+8CsZzb/TUZepGKrYayb6jiFaaCT/89BM04xKB6R7oMQRPK/70XeAM1WjUe05oYfhWs1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1905
Received-SPF: pass client-ip=40.107.22.118;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 05:46:10
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24.06.2020 19:43, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster<armbru@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

