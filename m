Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C173C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 18:15:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DE2E20715
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 18:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QxvMTgBT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE2E20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jakIE-0003su-Hd
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 14:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jakHC-0002wi-ON; Mon, 18 May 2020 14:14:10 -0400
Received: from mail-am6eur05on2120.outbound.protection.outlook.com
 ([40.107.22.120]:8358 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jakHA-00063X-CU; Mon, 18 May 2020 14:14:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0sooKji3VSk4prQiuu3pmWTyPfnX7fQv2cYjcPp7CHWu/TsRAJAU8nvCqwsrMEsKCv+BfoWYzduznM5xnDv0HpmO82nFxPqyftiU4P8B3NIxmGgWjC+aPaqvQ/ezbNfmLq3JlSQtYSv6zjde8N2A5CuU95Aez1nXftaPjJvnPgDQyJbOq608xPUdiDhzScKea/Aiitx8iCwQGJLZbVo38iP53ehNUPa7JBLsqj4X9hfvB/X4i3esSB5S3drdP48xk3HZfq5ng3E2/mtviXe28uUJ1ldlIciKgVR5F35rXDMb/XkUgdz/jAy2G+PJDX5ZOe/5xxxDfB3NDsD0q1koQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJMAWBeUUDWajDIQORgYH5C0xZ4YAT8OLcJ1qa9V5KM=;
 b=iiNFv3HzLr7ZjK1WwFd0Sojsi/gf6tOpPqw21RUId/HrjTpBs0Hz6RIVy0Z2fYIni8AmC+q51WmtOSv7+KsR7CLcRQ3okg9Js8RnhqyGSEX2tlzpgTOjCvbvOsUEXCPwqazYm7kLDHyq+pIEf6jL/oMG3f3eCbHZhv8luUZB/kxPkH489j9vY7Mk7TSf6SRRbQkD4d/uOBb88gDVW2svkqRPzKCqFvG5dPTiIyhLkKAMhV7Q7C/xWiKRUIkxAWiYxEZWLcQJaWyS3v2nTFrooRjTV+M3KveX7QXSfJDeuPZ51zJu1ZBtfyWmkvPA/vVv6eUeFnQTWJaNpE4fHBrQcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJMAWBeUUDWajDIQORgYH5C0xZ4YAT8OLcJ1qa9V5KM=;
 b=QxvMTgBT9LxhQaOwhGprYujFj0s6JVaNyTh6T6GEPlyUb5qvxDPHS4OPAqmvWdNyiVOYVzHYQoNIMBPDYvMpIJm+dZ9zPHDCzRb1SgY+TdkKSCgrhK9MHRNn3/h9VmiTuJqmr3COIC+WwjbpL6dEQQQ4g8p0BYlK2R17gYa1WCI=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5430.eurprd08.prod.outlook.com (10.141.172.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.27; Mon, 18 May 2020 18:14:05 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.034; Mon, 18 May 2020
 18:14:05 +0000
Subject: Re: [PATCH RFC 01/32] python/qemu: create qemu.lib module
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200514055403.18902-1-jsnow@redhat.com>
 <20200514055403.18902-2-jsnow@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b4618eb0-5303-40ab-b5e2-5a08d5738a81@virtuozzo.com>
Date: Mon, 18 May 2020 21:14:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200514055403.18902-2-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR05CA0147.eurprd05.prod.outlook.com
 (2603:10a6:207:3::25) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.187) by
 AM3PR05CA0147.eurprd05.prod.outlook.com (2603:10a6:207:3::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.25 via Frontend Transport; Mon, 18 May 2020 18:14:04 +0000
X-Originating-IP: [185.215.60.187]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 709a2c0e-7f52-4351-50ee-08d7fb573fed
X-MS-TrafficTypeDiagnostic: AM7PR08MB5430:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5430323BC650CBB67AD7680EC1B80@AM7PR08MB5430.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 04073E895A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gwge5wrWRxl/wbCgdjE0umcAr3I5hWZD6jNOZQT+zBYksHzST+vlIFb2B8oRbhbMCtMQZdJKp9LdOGQnPKUGfmOcRJdiMRjn5fo5gQ90wdKuVzwEBBM4xseQVTsW6b8pbrzczWi0fOBv+7pKHek2tg5VgRXV/4qcPWtn7di0qYZBCWUSurY5gJiDNtbZGSlsBtRYS36Iv+kkreBCZ3lTNh3BTHk6TVWT4xlBZ8CYGinq2olXdKqnycjvBC9eAGiiiMlHWc+jb87jqJsDh+JBlNV5G1pH/R3AR40y7X8PM+ue4vtO2dOiH935i5BultXvqe/Pyshzd1gAVsCeUmMafMp4rIgGJlnDosPH/Vd4eqppE8DXTDhLyb6OjXPRkVPImU942iaFV9ssNAk5SMNzJqjMg/RWSrjWLAwbC3H1To8G95og8JTwwOrSWOtulrPZkIiLs+Q/bLHWLXIP/9s1LHs4qPuuiI6BvMaCmUVwb5myb3b4yzcTso1LtAslCNY+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39840400004)(66556008)(5660300002)(2616005)(956004)(66946007)(8936002)(316002)(31696002)(6486002)(36756003)(7416002)(66476007)(54906003)(478600001)(16576012)(86362001)(4326008)(26005)(186003)(52116002)(4744005)(31686004)(16526019)(8676002)(2906002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: /9HRT5793j5abM7UkMxKPetbxbF9rpgwu1N4mZb6144xn98bqJIf0y7ynSxid3SRiMyqeSJMwkxpj/brFRHNt87nKFyCRtlUNpXOSLpwWPGQ83rAM2FKNHn7GgiDigPnx2s3/hrC6RH6Hru267lQogS82CbUb6tcHcTROA5AN81GxGUZanI9YzKEnoz4nyDLp6ACIxBZpISOp2cMPJZtW4Bl2i+AJK/wpS73tdbXeN9CO9kaahVKdt4tW3L0lIpOTwgc8p+mfPLVBnapM+4Znzg/jI1+1cjriCooKUut26us+sONz692sM05t/HLPw/LrrTrXUHevVBYc4JBTTKyCUIrO9BFFcIyBoMP6wdUcjnp3WRW79E7s83JB6kveyhXT6JKBwrVMjlXyFwmgFgElhhMdUOkGIFymgKwMRBx+vyRL89JP3ihC2jtqspGmCjnAaDHW7caHJQ0wQOLbKo2l53a/bfw+TaZSOcZJN+voJShcD7h8C2/HI2+bNFpBfCQ
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 709a2c0e-7f52-4351-50ee-08d7fb573fed
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2020 18:14:05.0404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gHlc67ezolXMgtNFn1OWsMd7WB91SWDmljJregeR9mZGnG2f6Ct5epgJbRy7Kq1+JUPgndi2Sct9uFw+6gqF4mPs+JNUjz1MNmTe7+Yh96U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5430
Received-SPF: pass client-ip=40.107.22.120;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 14:14:05
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

14.05.2020 08:53, John Snow wrote:
> move python/qemu/*.py to python/qemu/lib/*.py.
> 
> To create a namespace package, the 'qemu' directory itself shouldn't
> have module files in it. Thus, these files will go under a 'lib' package
> directory instead.

Hmm..

On the first glance, it looks better to have

   from qemu import QEMUMachine

than
  
   from qemu.lib import QEMUMachine

why do we need this extra ".lib" part?

Is it needed only for internal use?

Assume we have installed qemu package. Can we write

   from qemu import QEMUMachine

? Or we still need qemu.lib ?

I don't remember any python package, which made me to write "import from package_name.lib ..."


-- 
Best regards,
Vladimir

