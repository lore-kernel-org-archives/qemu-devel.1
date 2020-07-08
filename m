Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1662DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:27:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D109F206E9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="t0xLLzIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D109F206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtDqY-0000eL-63
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 13:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtDpX-0008FE-Bs; Wed, 08 Jul 2020 13:25:59 -0400
Received: from mail-db8eur05on2126.outbound.protection.outlook.com
 ([40.107.20.126]:50561 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtDpV-0005Bk-3Z; Wed, 08 Jul 2020 13:25:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNjFE5CdFC5zs5Q1Lt1jdNV/U0Btj23bR/xa0oQ9R1sx/MkGfS/AfkwG47SRoTTAJ14CWtWlSuWpi7sx80HuMv5nAz9rLvlQugz2CmZ4y5Rgjpbi+ji5VMoke2pImBLxOOgvyDiA/PQAfZoETyYuCSFMI/dCOnMOhpVgUdwxvqU6fMUbb/Po2m+n1D8/YqwVAZ+7aXMn5FPwvfmmVQ2zeWXRpL039yEHJVhSu9IQhB9I+aCVMyRRiQYyVd43u/aJvpRN8+JR63j8bBpap7Y0DnC7cLFF16/Bj4F0AnZM3tJpix+UXOuDkL2VZVHQOXhejWpHA5klUx34PwHAoetl3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VpEEF5BLkXtb9jPaE+yIynA2NhB7xMoAGRebSGGRGg=;
 b=ULQRCUHl4KrkBdWdLLMwoP/sTtDcXzdTj6lrwfM89f07VOaDqJQoaxfrkdHH5xlUVr7esg3IpUTAndltlYkIiLwG26IEsUs1vEwQAUmdzVw5uV6UMc99rV8syS6ELPg6EY07wHcUsXW0sZFWmoFRuWbysEf7N0dSO6UQl1XKpn7h4jtZHGuSJYOC8n2B75F5xSS9cuBRKNKkhLXmZFhoMPqb8uJU3pgm6LcydAxFIzDVbhaHAcWZpdsksgaWDhT/CSMe/WhxCoGzCuKckBN4QcAptr1A5SOOE2l6eMEdHqfUiBnVUr7sgFVSdNYstPJdldQXsz9oTlfiGRCRl8fDKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VpEEF5BLkXtb9jPaE+yIynA2NhB7xMoAGRebSGGRGg=;
 b=t0xLLzIkrQ8TKe5lZi5Fz2Q5z8HaBEBcjVsQnr8AeDNKT9bc1WXpRpVRDScdULgbLYDFJrG8egwNVa9EFNZm+N2f+PIwTfgehEESngM4DaGxrJQTSDh4K5lhraTEe4LxbbLgAIJXI2FtEBq56Fa1W98hqE1B7XPbvNHKkXhRB/Y=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB2984.eurprd08.prod.outlook.com (2603:10a6:209:4e::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Wed, 8 Jul
 2020 17:25:54 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 17:25:54 +0000
Subject: Re: [PATCH v7 05/47] block: Include filters when freezing backing
 chain
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-6-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <cd351d8b-02d4-5513-6411-ead518f27400@virtuozzo.com>
Date: Wed, 8 Jul 2020 20:25:52 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-6-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM4PR05CA0020.eurprd05.prod.outlook.com (2603:10a6:205::33)
 To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM4PR05CA0020.eurprd05.prod.outlook.com (2603:10a6:205::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Wed, 8 Jul 2020 17:25:53 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ad89777-f160-4721-9a3b-08d82363f82c
X-MS-TrafficTypeDiagnostic: AM6PR08MB2984:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB2984D061144607F39C43E8A1F4670@AM6PR08MB2984.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: csyilU3Pq3rnOPJb8P0Den/eZwM0LJ/2ibCJEPaKo7V2ZDjaid8nM7fQcj1MxipPz1GS7V+55O122iDfJm2IfosCsudN4Gmik+Vnc5YIfDDCKOIqRkT6obX2CVwIyA2VSoYCyNIXadwHI5R/1TflUYr4buRkbLczj9TDfGMg/ipCcqH0WRzg40uGTq2tDz//VwSfebV8L5LHA9DCY3mLb5OCcAyzvB8YeNf+iTHMsFup19esjjt7h1qNJ+GWIK8urfy2io8yGikq1yTGGPChRiRZM76Hs81ZEAH/Hn4UrSPuAllkCC7/O8mUcDpGzoRohr47xxYDIZbWleTffW2xHPrnJICIVHDmtT/5Qm5h3yAfNs1PnFFicas2I5wWSjBQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(366004)(376002)(136003)(39840400004)(8676002)(16526019)(956004)(316002)(6512007)(2616005)(8936002)(54906003)(26005)(186003)(44832011)(31686004)(2906002)(53546011)(478600001)(4326008)(5660300002)(66556008)(52116002)(6486002)(83380400001)(86362001)(66476007)(66946007)(6506007)(4744005)(31696002)(36756003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 2Qc4wnGJVcqke8qEOxkBRsMI+OHQMEOdMF5VxKGOpF1bo7aoY88COXyLDSIKXHA+/xXuHXwlkbGBQ90pnm+tHf0hDN66xB0+DQmfR/0UbZGxEnS5vzgHfGawUIVl3Ll4tbSik/wTM48o2JA3kwGQM43ODjjvdtM7PHi/BLCmwVHwXBPgpKhfHZm2J8T7arUioJw9igCSQgX9S08cOyb3cdRJ5TaGmwYhou/GQDkgEuW/u+e6cRUDSCO/hUiBS/QbLhglXfALY/Y89KHmQ/lYi5HS58taFlgw4cGAMrpXEFpXtf04DDRO8T7hRafnw/QcuriVeRq0/Hgsr8VCtMm4XP1zEhmdJafok/umLX7/qQhK0ulNWrB4JtsvSv1Jo4pIsbFJqc/c+tr3aWSmUWvYWjNaOUFr627qD8/Tych8WfUlXYArpP+EF9pH18qZWvd8Xhclr67U48db6hCgwkTnOKdAq0w//t6g59cP8Gxyr6E=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad89777-f160-4721-9a3b-08d82363f82c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 17:25:54.6641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHb24YrOzPIkZiC6ohJ5wP5Gm9FYvdxRSOStAoJRGmUp6zDi+eKfXkpjofFf9TlyYixdfGdCgc07PMfYQd2GFS9wseIyctT1s1sSbw+zJaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2984
Received-SPF: pass client-ip=40.107.20.126;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 13:25:55
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25.06.2020 18:21, Max Reitz wrote:
> In order to make filters work in backing chains, the associated
> functions must be able to deal with them and freeze both COW and filter
> child links.
>
> While at it, add some comments that note which functions require their
> caller to ensure that a given child link is not frozen, and how the
> callers do so.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block.c | 60 +++++++++++++++++++++++++++++++++++++--------------------
>   1 file changed, 39 insertions(+), 21 deletions(-)
>
> diff --git a/block.c b/block.c
> index d139ffb57d..b59bd776cd 100644
> --- a/block.c
> +++ b/block.c


Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>


