Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B015BC4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 17:44:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C4A020836
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 17:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fb/uhFBb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4A020836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUDEv-0003iW-KE
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 13:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32816)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jUDDQ-0002o0-AV
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 13:43:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jUDDO-0001Jb-Ea
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 13:43:15 -0400
Received: from mail-eopbgr00101.outbound.protection.outlook.com
 ([40.107.0.101]:5377 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jUDDN-0001JP-JW; Thu, 30 Apr 2020 13:43:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCylT2iTzkp60iQjKgXPZ7ZLGWWV7pvu64OLPdm7Qq5oTdeQIYrEbBzBKFuDj61OHsJhJ6Hm1hkLG6q/F93IOexSH72DnMmWnebwGsZTLuxm/knGH9lWaqhpOtgS4Esa3P1Dzp5sfp8B8zU1geZKUw80KziYe9RTaaZSOeTPyiujB5ah+CGEB+GietEE5XItE04w7Fq66Tdoms4A5gGhgTBzaDqP9lKEHw+vaGjbnlZ+Kn7wonaCdjPjIbNWW52Nou5tV5nQNeS5qdm56L7OBlAQy5fE0MXexaMwoLUxoggVgCMna4CaMzArrJJTdz+KaA3MnEq3KNmTH9sNz4w3Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5Hb3WTP8J5v447dY1H+u+CPFTK833D1TZ4MJbxpUvk=;
 b=muCdkgBQZPx7bUHXPVZdsRkd+LbJHQIKuUIIgbTFYh/zJorytCTaaMW+IUp4TW8VwUfrvV2p9Zd3dPMamiqW/1zR7B+vpeolobPUcJdw2XDrR+U4FfKq19UcIrRycIUcukQ2hpZ5xlWhbP61gBRNg+sPic8t6AeXhF8aVW3KCt1UkXhsfrb2fb2nBOdX44RZm8EjKl7tpp/4XkzGLlUV1n+sbI6d49fKDeoWfDA5VOA3KenxCm6XuvPWihmFdQp1OIzT2gefQa3GZ7J+nN8DfdJFZHKzMuTNBA+PdxhpveAn97iOORCrxQzjxPeTt1Wx+canzsi0HnKgcurYzJVrNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5Hb3WTP8J5v447dY1H+u+CPFTK833D1TZ4MJbxpUvk=;
 b=fb/uhFBbW8r911EQUdFfcdHmGQ/bpP37cDgmX4KS+at3uH0Ei5jYMN2kVqKErYlCNELb3IW78XCZSNp4TxUlUxR5sJ4CQ8lNWe8X16WJ+AR5pWwilVUAt5DEAJor9fmItpf9qkQcyXLnhOSx+aIEEU9DvNzJZJyCPQURAJkY8Fc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5493.eurprd08.prod.outlook.com (2603:10a6:20b:102::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 17:43:10 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 17:43:10 +0000
Subject: Re: [PATCH v2 1/4] iotests/283: Use consistent size for source and
 target
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200430142755.315494-1-kwolf@redhat.com>
 <20200430142755.315494-2-kwolf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200430204308953
Message-ID: <d77f5e36-5567-f638-9ce9-348432d8ce67@virtuozzo.com>
Date: Thu, 30 Apr 2020 20:43:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200430142755.315494-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0045.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::25) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.138) by
 AM0PR10CA0045.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Thu, 30 Apr 2020 17:43:09 +0000
X-Tagtoolbar-Keys: D20200430204308953
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a85513d-a4f8-44a7-b34c-08d7ed2df30d
X-MS-TrafficTypeDiagnostic: AM7PR08MB5493:
X-Microsoft-Antispam-PRVS: <AM7PR08MB54934D70E9B842485A0C4895C1AA0@AM7PR08MB5493.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CjBgWB6NuSaLti6Hml+/Ktt/ubQFhrixRs1KSiBpsHNsfVhofhu4XOG24cavHqKCLWQ+nlVBJ7NxFQmNi75GTUJOnaa1OUb0/L6xl8nezSRrsMt2KPw4Ela56sX0OO/7t4ypqCyXO2ruYTI+lhp24whFBzvIbDQ+O367Bs5rcbSgQRQ6M1Ny/8UsG8Q+B4wei2+O/yS4IBcE15xWt7Ov2if3tyDHrIzNs4olFfmewKXE92muxywgwrhmucle8dsTuomKYVNKuHTWE+L5ScZvGjsIqEal0VST/5tG82dK/mYorpIuO1ax3d4HV2+tNq5oZuBXRb/mCSXyJO3AR/5vKh8/2MOWkZk6tUI5mme3HxU05emwbPxqLNAvop61ClMdGpa2H319SpgJztUl+/1Ma7sDyMrNZqvAnrhMXA/xKnunil3Qls/elXdTAon661PV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(376002)(366004)(396003)(39850400004)(316002)(16576012)(8936002)(26005)(8676002)(31686004)(478600001)(36756003)(186003)(66946007)(66556008)(31696002)(2906002)(16526019)(66476007)(86362001)(52116002)(4744005)(5660300002)(6486002)(4326008)(956004)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 0nhhTvwYpDSKsTByeFxqLw/eTQbFgdNzzZdi56AGKpSnEePCp0Tfj1Ibo3GhJ++c2dXqHT1XyegQz/8ZDFjgtMWopd1vTbFNH4ajtOSL7WO09YjcXlW4lX+3drMosZO6EczScXx9JD2VZi4bGYsoc+vs9Yr0eBSgoXtTvs/8aLoSBouBivylaBaTCMn0L82CkeK5f1SEDYQII1cpE8tPyaUhyUSM+snpH3Nt2cL46oJAkDpOYhTANB6+MVou6TnaohPSsqTxEPePP9Csy0igeCSFOVCIGGjK8Rq1RhkA/WUl64d/PkH3fXWsr9xS3dUPMO3WWPGVE3kPu4BUIqV0CwhVa7bhd30s4e3nnSqchqh7zcYtcanSJ5UEIASLu2/TCTDhweSuvDwpHcumd04+IvVVkM+fEOX1Ly2JUmdBS6Xba/TEOlipIKAt5z08CWGuAyub3a2/Ao/otzsfqPKoxYpNIIzavkVpkwf7d7l/0+Cw2VwTrXi5EuoAIQSeSG5vzLMi7PZtPuJQFfw949Blj3LitFMGY59BDVosy84zu5ehOMcZ3ZrATx/jMlR9kpmptB9uB94l+borj7yeE9EiJ9eCo2Rq81S2ccb0UgncahOcKM1GLYqb+t5pFWPnHzBKfVTSdKC/7MHdoCaKhwnXYfhc7N10bHhEjZp5A0oangmWkEWNqF8KxhMRnY2I/4660543hFX85rKeJQztfOM6lBIKceZQU/1Pz+s6vCrxg3u7qeyAbTLokdX+bW6tLsaJruOWQQDjUXvAT9TBetcIHrnKpdJeG0y80Bj9mhtqeH8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a85513d-a4f8-44a7-b34c-08d7ed2df30d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 17:43:10.4282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fBrrTRzFqJVO0FFrf8K6L/q74T/z4p8yc0xIAVmnwEpLMNKWUvsx5B3lWm+QzcfgEBSKTUc+bJPgrh7uw/bFjZHEGkbQtPPD/o5y6LwOLNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5493
Received-SPF: pass client-ip=40.107.0.101;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 13:43:11
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.0.101
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

30.04.2020 17:27, Kevin Wolf wrote:
> The test case forgot to specify the null-co size for the target node.
> When adding a check to backup that both sizes match, this would fail
> because of the size mismatch and not the behaviour that the test really
> wanted to test.
> 
> Fixes: a541fcc27c98b96da187c7d4573f3270f3ddd283
> Signed-off-by: Kevin Wolf<kwolf@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

