Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA3BC433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 17:09:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB75422D2C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 17:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="aBUGH2Pe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB75422D2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Mud-00017A-7l
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 13:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k3Mu0-0000cj-Se; Wed, 05 Aug 2020 13:08:32 -0400
Received: from mail-vi1eur05on2133.outbound.protection.outlook.com
 ([40.107.21.133]:48704 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k3Mty-0006f8-M3; Wed, 05 Aug 2020 13:08:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1dxvE7lEG6wfCD3D/9iTwa0XRhaA/TZc/VBgCt4Lj4cOrnTe6HVkyqfQMCGVqEFuIjBjqZKuYGDldrBmbJgZFx0+VDmdxCU+42hkXXyYKEY9flOzauh6FZi1ycuvrUAMaUXdcXWfDZx6SVz5x+8U+NNIcOvne5Ny4Tgzf0gAXmz3Tm/qA5V1RCsLt+4uIP+mxLhYFNujD/L+55cUHYHHbopU5B+67w5+U5mvt3JmZTv22RYnFGEUDJOqSL/rk3dG86OFUxdYN4nMDUo4kHNMgTWBXNUVOE6bhfUUqlNSb/3S94t1Ye7pEPNH7MVu8aGN6RQ+jUIHEspEAO53eRLpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lF/8ZTVdIPmeXgnXEQQ5q3aM17u6bFeI1Pi/d1x6src=;
 b=URuzXX+6F+HXJRAq6YjIV5pA7xwFZQhkZdv1dLbFIeNHCV8BDRnN5yrqAtBh7S9yZjZNS27m3StJKr3xHgcLQQ9b2rN7w8YCiqnOLu9mphR9DL7judjLONHNhi2TKrwhqYaPPXvwF60B5MM/N2RabGRl53XPNpXSM9OoVA347m5gveIpczWlF+khzHvL/KYr8jH/1AeVi12AN3fpmwKXOq7Ck8fCiT+mpycsF9kM81Ves/W5aeByski614hQKVkoz5vKqkO2CJ/bocL4/7vqqoZT6QzOYDL2PAlX8qphDk6mpyurpgtsf1x/bEV19lgihe1V1RcxF35iGjSJSNhs1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lF/8ZTVdIPmeXgnXEQQ5q3aM17u6bFeI1Pi/d1x6src=;
 b=aBUGH2Pef/xE9ZltzNS7+0b6dKkxzEYXx0w0cJYbsZQQLlwycCvI+0I+C6+V8ue7kONas1kGXWj8GQOEbi8gPI7fIkUjovP21yNEAoLSs23/3fJw4VLxOLT8gdEeFedkgNYRUuvxb5a9vHAe8bFn/EbUUD+XYYfKaVDBigS9RBc=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5448.eurprd08.prod.outlook.com (2603:10a6:20b:106::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Wed, 5 Aug
 2020 17:08:26 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3261.016; Wed, 5 Aug 2020
 17:08:26 +0000
Subject: Re: [PATCH v12 11/11] iotests: dump QCOW2 header in JSON in #303
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1596118512-424960-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1596118512-424960-12-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <0d95c831-afe0-f121-9036-03fe8905bbf7@virtuozzo.com>
Date: Wed, 5 Aug 2020 20:08:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1596118512-424960-12-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR04CA0141.eurprd04.prod.outlook.com (2603:10a6:207::25)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.157) by
 AM3PR04CA0141.eurprd04.prod.outlook.com (2603:10a6:207::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.15 via Frontend Transport; Wed, 5 Aug 2020 17:08:25 +0000
X-Originating-IP: [185.215.60.157]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83a3f57d-25f1-4379-d935-08d839622aca
X-MS-TrafficTypeDiagnostic: AM7PR08MB5448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5448EAD901A17AB9F62BC7BFC14B0@AM7PR08MB5448.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OE4SM2vpY2Ww0QA+VWrNKVrkfciSPgu6ZU8TsX+wQsTxfJgYhOdNQo7apWd/iiqCjRq+8e52FjwpbSVm81LJuxzWohhut0jl/S0NYeBDetvXG3jvxOmhFXtESiOQON8gI7XWkKPyvTxlGVZUg/fKlAo8APlV2lsE0wKYh0+sBVwbDTN/uivOyDEBwLAvYA9lUcq74DAsQ4tO8GvygVX3jPdUiwk1p6KmVAklyzYGKlvfuvIZkVFKBEVlEjPk74+OlybJBrZhF/WdCD1FhDIJM8m0UkxojLfvkmLHWwV6/qwn1ZRpmOD47+vLUlPqJ+x8CcdW8aTTel1wEgL9f/L0xOV518U9C1bzlGAz8nkUw09WTGIOJ1w0VreZtvOsGvCb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(396003)(366004)(136003)(39840400004)(478600001)(52116002)(66946007)(31686004)(4326008)(5660300002)(6486002)(8936002)(36756003)(66476007)(66556008)(8676002)(16526019)(31696002)(26005)(2906002)(956004)(2616005)(186003)(86362001)(107886003)(16576012)(316002)(558084003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: QjrrUf6eFO9eSrhIDR+GXmlFs5fgVRc/S5RdteJMoW8nMJqUroX4L998v5hfmzMxR/5IjRn3AWG4edqK85aVAHemSJDFD62kBjqzgt3dGaD2Ke0tBssPrmqA+3d+yqXm3lSPNgroF3zfP9YnIcBEbRvcGAXhR0pG2Nz5ZyPOcZBC+8ja8Q0BDAIYXoAmlBQPZWljbk/JrZsrDR/WOAZv7mJzvTaUbNau+le2vvUlyd3l16yKDCSvrR6izwKVR7p0R9cGksE5Vq2SsBGgSaHxiGPG73UyoNoRUSfp2xOrgiNqqIYvqSOt7MZB9+m5UOWo1aXfXYUw0NF2tYy3KFbxnOMZoZ6zagWmNSpy+C2pUzEmJqYfJPgulXpyKs/u2gb7HoN9qU5FDj0SIBTcpiGNyirR+P+9CrJ3+JpcTVZ9FWtbwhOQu0VhYtA4YNn4iOpVIT84Oi0pS6QjzwVeVXnkRDdSLagUZrFyxLU9w53qVGd/cHe4fEuVsaIOMz9WwSdeXJDmFxvyV5uCti18GnhlPNOhIr4j3sd9mrZ1JyrKhz7uWlvmf0fffDT1ocuP7WUQDWjEudzqemEi0XWnuksiH6eovYkueT4/ZMCDHChQPMbl56NBGFrgmquochmqfz7LZf5qv/7mdWNkJ7g4MXRXqw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a3f57d-25f1-4379-d935-08d839622aca
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 17:08:26.1137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FlKefTQPRPjXYhFTFw+sYBuMZI6JEOWLMlS22/oZ7FX1VEVaza61y6J+ra+3QZi9KH6K6e/1hDcbQIBsyhGwEGrFdWpwdtqDJCt5yn1yxgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5448
Received-SPF: pass client-ip=40.107.21.133;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 13:08:27
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

30.07.2020 17:15, Andrey Shinkevich wrote:
> Extend the test case #303 by dumping QCOW2 image metadata in JSON
> format.
> 
> Signed-off-by: Andrey Shinkevich<andrey.shinkevich@virtuozzo.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

