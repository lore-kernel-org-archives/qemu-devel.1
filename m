Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B911C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:12:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06D0E22510
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="sSfMcy8K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D0E22510
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvLfy-0004cr-8p
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 10:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jvLfE-00043K-MR; Tue, 14 Jul 2020 10:12:09 -0400
Received: from mail-eopbgr150112.outbound.protection.outlook.com
 ([40.107.15.112]:46081 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jvLfA-0005PB-TT; Tue, 14 Jul 2020 10:12:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYykAoKR5ZeGe9Z3Icy0f1/EVXHPKRWqEl0bcSWZ7J0QykKMD3geY1YH224TLQv1e221ZaGqxtiIyGFMYwSIlGLJG4F3Ilbpo83V/BDLamYinJtso4U/MJWwVvYdsLZzMSObqeAWgaoke7STO9M/KHKvWw9T5A95sXs1jAlU6n0wIvcIPFzLKEoJ3O38qxrOPpWP4JliSrXVRTUNBxjegQEiMiX6M+MsYYQ34pG+PaLILqDBCpzKvC3dm3MLdV1ttgZpnWkuzo9cAzfH6ksPBEQj7VfbNxxwBBN5lt176jXfNoocBII7RmsriBeOfbrFwrwKM+/gIy2HHqls1b+0xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCdn77TA8/LryV7TQWINYE+HFRrid6u8pwZSbnWkEOQ=;
 b=epVpYxJGBKc5dltJCNwy/S4OYMJusxHlsaWLvBDD3O1XCGgqUM1ZrSGRGaXAngbLo67NacyyqwWqOuBfDcseQmQGxrm7w5LusBv65MNcpLSLykFmRaO2j5WLYjC9PbtiYW7/+gzvIb1Gt9+lIbbTQIhwKTmUPM2Gt0W9Orx5bHurVgO6FSJTSzqoZr46Zb9pcOkDfMPg7HDRRgVrqb0GWWbT896e6PK9dVGBJmXDvIv0TJGQ6MDdlcOM/Cp9EF6yNBM6C6dMH6a9TJIeUdIeVC9yi1JsGovY4FY5v5LvKHDrk/bA0y+DNJMg7FjdbFkWqRLJ03O6dFZ+VcRY23vR9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCdn77TA8/LryV7TQWINYE+HFRrid6u8pwZSbnWkEOQ=;
 b=sSfMcy8KLLAcdSXTgcp+TFz6ApOIN5bW7APBIkK/7it8jEy6izEZF3FTuNs122B8JmaLQStRuf2UC6VINEsNf3J+f5VXOnl7SJnSTsaHjMX5oNworzR8mxK7emwJIzXUTuCrk0TPaQHxNGvzpb4AHazy56F8+q8JTFTJLz9gYt0=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3448.eurprd08.prod.outlook.com (2603:10a6:20b:50::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Tue, 14 Jul
 2020 14:12:01 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 14:12:01 +0000
Subject: Re: [PATCH v5] scripts/simplebench: compare write request performance
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1594660965-159653-1-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <55eb0343-0750-719e-11be-46a609f014a5@virtuozzo.com>
Date: Tue, 14 Jul 2020 17:11:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1594660965-159653-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0126.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::31) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.164) by
 AM0PR06CA0126.eurprd06.prod.outlook.com (2603:10a6:208:ab::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17 via Frontend Transport; Tue, 14 Jul 2020 14:11:59 +0000
X-Originating-IP: [185.215.60.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64202188-dfed-4027-48b3-08d827ffe004
X-MS-TrafficTypeDiagnostic: AM6PR08MB3448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3448D98B73A9CF7FF88D3393C1610@AM6PR08MB3448.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yPj/oSKS7pPCSprM5/tOJ4+xEgOaYwRxhrQINVKIapef/0XShyEd5+kOty3OCARwSLAcegJDXAk9ZF4xO3HpEL26b+ksPW/E4GkUm+cGGNQDu6adjxEOp479OBLB0RYAIbSTVh1Bli37j8AJNat4xiOBZ57Jznci75psNjbt9UE76mGofX42h9WbPqtJYumwNAvIXe3yQPTvtPKATJx8VoMfzgOYQ8sQux//ldhlYBB2y+Mp9+buYlfiVHl+btaaSr2P5P3SWWCULA4TBkBcYkTH6jBfNYH0BKoDjC+FfkjOakuqLzFT/p5LXS4OGSRWbKgYFk+VtTHHsGs+YIj8TUhGz/yn70huIQTyXNdwjcBJ9UDqjnfzcxy8Haeyl6+FjagVMMUaQDjAA1Weg9HOXz5GQOvr/+k6dnfLyrRYvPgZOPcGXWLuZQvejZr1xxoYUWbX3hISNytlRjqojYVoGRObbXE2XXKf6XUj5zaPbnc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39840400004)(346002)(376002)(396003)(136003)(450100002)(86362001)(66946007)(8676002)(66476007)(66556008)(4326008)(316002)(31696002)(16576012)(52116002)(26005)(16526019)(31686004)(36756003)(186003)(478600001)(8936002)(2906002)(6486002)(83380400001)(107886003)(2616005)(956004)(5660300002)(2004002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: rHe85bJix2tyI+8LtPTvWOftqHa1R8wu715UmxnOKKTMPVQ76AorLq9fjzVqfWQLEgzE/ZqlBLFY3U/F5edToKpoPXwhkXzVrc8qCAAhDlVvV3g6iIPkknkro0eTq4KDb3MSVH+HPoLSIb72J56OAPcAf+r6aSCVOAptfVyIJb9ldatAxhiKJVvmcuGrVQNFuJ4zu3VbALKnkqVjsikNmzLa7eH7H5uF+dC7woTAJt30Cc7w/0KJwZyQFqrud/62P+L9QZ3st60YmQg97+isAfYXJjvooWuc4lE4+b+a1OP5k80DnLzgjGC0bq8VmLcWdF2BtLDIyy3DZUCq36WF5CqEHAyrb/OauTDueOlKvLXdCv+03N4Mmtm/9fN7EopVmoYcMkiD8tX3ppljZMmtGz1pMAHnaT75eyO6F7om62NgPTVzMAZkjYBYtLBUWBaPI3VQra7doiVH5qcXXwm9OIxTGrejjErujHE1F7nZZoHKfJmtUpuGyPwPd+u9XgTm
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64202188-dfed-4027-48b3-08d827ffe004
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 14:12:01.1113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yE/6LBRqdmPPOsG0hgm+TY9owZlY/Qp/HwDlSmfOQVjFM4pnp9FnAosLSeRJS9GTDaqH2LOn/KERLQ0tRwvuXIcxC8HvQ3Aq4CLg7v2cLt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3448
Received-SPF: pass client-ip=40.107.15.112;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 10:12:02
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
Cc: den@openvz.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

13.07.2020 20:22, Andrey Shinkevich wrote:
> The script 'bench_write_req.py' allows comparing performances of write
> request for two qemu-img binary files.
> An example with (qemu-img binary 1) and without (qemu-img binary 2) the
> applied patch "qcow2: skip writing zero buffers to empty COW areas"
> (git commit ID: c8bb23cbdbe32f5) has the following results:
> 
> SSD:
> ----------------  -------------------  -------------------
>                    <qemu-img binary 1>  <qemu-img binary 2>
> <cluster front>   0.10 +- 0.00         8.16 +- 0.65
> <cluster middle>  0.10 +- 0.00         7.37 +- 1.10
> <cross cluster>   7.40 +- 1.08         21.97 +- 4.19
> <cluster 64K>     2.14 +- 0.94         8.48 +- 1.66
> ----------------  -------------------  -------------------
> HDD:
> ----------------  -------------------  -------------------
>                    <qemu-img binary 1>  <qemu-img binary 2>
> <cluster front>   2.30 +- 0.01         6.19 +- 0.06
> <cluster middle>  2.20 +- 0.09         6.20 +- 0.06
> <cross cluster>   8.32 +- 0.16         8.26 +- 0.14
> <cluster 64K>     8.20 +- 0.05         6.26 +- 0.10
> ----------------  -------------------  -------------------
> 
> Suggested-by: Denis V. Lunev <den@openvz.org>
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
> v5:
>    01: 'cluster_size' made variable.
>    02: <simple case> deleted as duplicated.
>    03: A case with cluster size 64K was added.
>    04: The comments amended as Vladimir suggested.
>    05: Superfluous variables removed.
>    06: 'finally' block removed from function bench_write_req()
>    07: The names of test cases changed.
>    08: The 'block_size' of <cross cluster> set to the cluster size.
> 
>   scripts/simplebench/bench_write_req.py | 170 +++++++++++++++++++++++++++++++++
>   1 file changed, 170 insertions(+)
>   create mode 100755 scripts/simplebench/bench_write_req.py
> 
> diff --git a/scripts/simplebench/bench_write_req.py b/scripts/simplebench/bench_write_req.py
> new file mode 100755
> index 0000000..7665c4b
> --- /dev/null
> +++ b/scripts/simplebench/bench_write_req.py
> @@ -0,0 +1,170 @@
> +#!/usr/bin/env python3
> +#
> +# Test to compare performance of write requests for two qemu-img binary files.
> +#
> +# The idea of the test comes from intention to check the benefit of c8bb23cbdbe
> +# "qcow2: skip writing zero buffers to empty COW areas".
> +#
> +# Copyright (c) 2020 Virtuozzo International GmbH.
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +#
> +
> +

[..]

> +    # Test-cases are "rows" in benchmark resulting table, 'id' is a caption
> +    # for the row, other fields are handled by bench_func.
> +    test_cases = [
> +        {
> +            'id': '<cluster front>',
> +            'block_size': 4096,
> +            'block_offset': 0,
> +            'cluster_size': 1048576
> +        },
> +        {
> +            'id': '<cluster middle>',
> +            'block_size': 4096,
> +            'block_offset': 524288,
> +            'cluster_size': 1048576
> +        },
> +        {
> +            'id': '<cross cluster>',
> +            'block_size': 1048576,
> +            'block_offset': 4096,
> +            'cluster_size': 1048576
> +        },
> +        {
> +            'id': '<cluster 64K>',
> +            'block_size': 4096,
> +            'block_offset': 0,
> +            'cluster_size': 65536
> +        },
> +   ]

wrong indent (s/   /    /). with it fixed:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> +
> +    # Test-envs are "columns" in benchmark resulting table, 'id is a caption
> +    # for the column, other fields are handled by bench_func.
> +    # Set the paths below to desired values
> +    test_envs = [
> +        {
> +            'id': '<qemu-img binary 1>',
> +            'qemu_img': f'{sys.argv[1]}',
> +            'image_name': f'{sys.argv[3]}'
> +        },
> +        {
> +            'id': '<qemu-img binary 2>',
> +            'qemu_img': f'{sys.argv[2]}',
> +            'image_name': f'{sys.argv[3]}'
> +        },
> +    ]
> +
> +    result = simplebench.bench(bench_func, test_envs, test_cases, count=3,
> +                               initial_run=False)
> +    print(simplebench.ascii(result))
> 


-- 
Best regards,
Vladimir

