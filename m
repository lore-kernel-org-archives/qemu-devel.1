Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F31C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:36:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E3112073E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="sSrIDHpw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E3112073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k03IO-0001a2-Kc
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 09:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k03Hk-00010j-9R; Mon, 27 Jul 2020 09:35:20 -0400
Received: from mail-am6eur05on2103.outbound.protection.outlook.com
 ([40.107.22.103]:60192 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k03Hh-00083E-JU; Mon, 27 Jul 2020 09:35:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWUS2wGYCitqktBH8VqYK8yRN2ctWMgHwSOT8kPCn9l+vwaMJxPkWbBg9uC4oBLRAk6wW1J1YehEeGzJ7SF2i3vfPtBOFz3PUKJD+CSTZMwgpauWTMXw5lozD9UqHIDoWy9rYC8fqfPlQS2exxpi1OUY0EPqw12A+mxef0bIe0/D8eLIKBhVWJAqdn00hWhFI335xfSHWyBO5ZvUw+L/RvSeKkX/sFPYJkmcU/3RDnxDCDohVcDM10BlU0DtTJnqGurBp98rMqFrhMax3QOc+JyERecAWFT0uoOYv2XUyZmkj13GMjjkSIsVD4fsqm6/5hDw7Y7lPslDTgCrncoXRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4XnNlFkYsHA1rI5yw3sKjTsoeQfi0iQc6RbJA1SnWk=;
 b=B/7LayLFrlF8tNAHnwEZfCS14b0uIjm3o3DNBHCkmYZP/vQfTvg8N9DnpjpJLF/HW0gi7b9v7bVfffG6H3B0Sd1mOBttmSya4D4HHYSDjoYSkOLuM8FbZPCWUG2vSsroPA7UmQO586YagEfnC3B++y6LJNrMhKCssHvSWqNt5kpXxglxGk63bJnah1h78Hxs6cgNhl6qXbrJdemO8Wpt0XcJqgsRSZzf+WBhuaOMmGa6pM4XgOEMnP8vPJSkXRrW+BLaBj1zmoJo4ZUTI5qV3m2LdbwC8ptlqwTFFXrmSw9QzntHe3156qpRYVsX/R1QYrNf/qPKDX5SJw1VWHWXnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4XnNlFkYsHA1rI5yw3sKjTsoeQfi0iQc6RbJA1SnWk=;
 b=sSrIDHpwNYmpdL+ngb5luj9jvsbT2hATBP47YL/UNvWQdFYjeMCx4qzXUDFoAtwOVqBs/2fBIE8eRtyt3hxtBUYnZHEOKZUogP+x+GzwK3hi8XODAU+kY49ZyBlm8k9veVNgbjUdLqrWKkxHlm/TTRBnNuWCbIIS7GYasEy7TTg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB3224.eurprd08.prod.outlook.com (2603:10a6:209:47::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Mon, 27 Jul
 2020 13:35:14 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 13:35:14 +0000
Subject: Re: [PATCH v7 43/47] iotests: Let complete_and_wait() work with commit
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-44-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <c328a8ba-8041-ebd6-3765-94be19d0c53b@virtuozzo.com>
Date: Mon, 27 Jul 2020 16:35:08 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-44-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM4P190CA0003.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::13) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.82) by
 AM4P190CA0003.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.20 via Frontend Transport; Mon, 27 Jul 2020 13:35:12 +0000
X-Originating-IP: [109.252.114.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03820410-92c2-499d-56dd-08d83231e4a6
X-MS-TrafficTypeDiagnostic: AM6PR08MB3224:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3224023B833DA01362C89875F4720@AM6PR08MB3224.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:269;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SznxtrKAaXlvuSsdNX6WabHwxavDq7SGTDDMUEXvsDuMOjFNeIMsMGj2IlD9sxOTs9SLlhbkpZyp2aGCuF40u1b0ccvokgJgee2zsmYiyKR7ScTeJ7vA5eX3OM3huHAbIBM1wTgbKLFX/Remv7AAywiQEgYTLfP/cJxG0Xz2y0ykOs6yZQM9aqX2UkaTYsjVOch24U9GzJb5XfOgchaeoTdaCIz7EWYC7zLONgn2d0dUAs/f4BKeMr7Eurjs2SLN8QObAvPPXTAP2DpVm5QxQJ4FlX8s/yuUQJTCX1Ytw6FOswHogb5agsbJswf/MGaKAc6lsuCiX3Lo0CaDJbQLMdowM7byz+r8UNLrjwENZQGhs6wLDI9+5pz/TfEGhQWU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(396003)(366004)(376002)(39840400004)(6506007)(5660300002)(66476007)(478600001)(83380400001)(54906003)(66556008)(53546011)(6512007)(66946007)(44832011)(316002)(36756003)(956004)(6666004)(26005)(52116002)(2906002)(2616005)(6486002)(186003)(16526019)(8676002)(4326008)(31686004)(8936002)(31696002)(86362001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: UePR2DtmDqF47T49bjuf3bKetFPd3gJloP6GRsfnr3Gw0mrhweCaBfbPYlryf+jlyYb2kREbnioWwVy2HUX7UC1t7H2dBzpIcAfmD9yeq3SzUbxpY2Rn6OZWU33+zL2e46RKBMJVlAeQjyvhiBdnAgPzjaq/i73ziv5qGyXztGrSdafY/VZUImsynjLbymtBR/pnYt7sfA1neN2yIPEV9the2vHAEUetsqwOxNIueYGEhxGVygR4FO/15VFi2cTlSFEZYH+pSjlCnQZuWLJae17VdK7SwGIj9kxg/q5veOJ9g2M1ZR8q/fVLJjk2vpuU5j0MdWkIYiCTbwjjlQ1HDC25BCSC+QHzOaimXFX2a/d9zjGeXuE4IfM8y9OdABxojjcOo/Yi1VGfYBxM4oVH1YG8cfy7zmvSSYr3CJBcEOFevV7hPbZdhfb39WnbxlWSQI6sgBaP4ljDxtJb6mGjGytJ5oNemRkXWLKf4nTb5+f8Y2U9DgcKrG/LgRPR3fb5
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03820410-92c2-499d-56dd-08d83231e4a6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 13:35:14.5447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EEexueqmf1iVRQxRseSH5Cvp+m61KyXJovuOTBfnGs6kORHIAzQThKcI6MZVYnEjH35Js0yk+13P5fIN/CkdmcG37JJ3QkXUPQfaNIA5D88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3224
Received-SPF: pass client-ip=40.107.22.103;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 09:35:15
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25.06.2020 18:22, Max Reitz wrote:
> complete_and_wait() and wait_ready() currently only work for mirror
> jobs.  Let them work for active commit jobs, too.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/iotests.py | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index 5ea4c4df8b..57b32d8ad3 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -932,8 +932,12 @@ class QMPTestCase(unittest.TestCase):
>   
>       def wait_ready(self, drive='drive0'):
>           """Wait until a BLOCK_JOB_READY event, and return the event."""
> -        f = {'data': {'type': 'mirror', 'device': drive}}
> -        return self.vm.event_wait(name='BLOCK_JOB_READY', match=f)
> +        return self.vm.events_wait([
> +            ('BLOCK_JOB_READY',
> +             {'data': {'type': 'mirror', 'device': drive}}),
> +            ('BLOCK_JOB_READY',
> +             {'data': {'type': 'commit', 'device': drive}})
> +        ])
>   
>       def wait_ready_and_cancel(self, drive='drive0'):
>           self.wait_ready(drive=drive)
> @@ -952,7 +956,7 @@ class QMPTestCase(unittest.TestCase):
>           self.assert_qmp(result, 'return', {})
>   
>           event = self.wait_until_completed(drive=drive, error=completion_error)
> -        self.assert_qmp(event, 'data/type', 'mirror')
> +        self.assertTrue(event['data']['type'] in ['mirror', 'commit'])
>   
>       def pause_wait(self, job_id='job0'):
>           with Timeout(3, "Timeout waiting for job to pause"):


Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>



