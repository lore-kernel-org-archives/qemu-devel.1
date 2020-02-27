Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADE4C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:26:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2558D24691
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cO0oVbDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2558D24691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7HJ9-0003FU-Cr
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 06:26:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7HIC-0002Xl-8c
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:25:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7HIA-0005ea-Sf
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:25:24 -0500
Received: from mail-eopbgr80109.outbound.protection.outlook.com
 ([40.107.8.109]:17941 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j7HI6-0005LR-Eo; Thu, 27 Feb 2020 06:25:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oO9Yxb49AJXZAT89GCHdljsHED0z74oFWj9M/Cl9HYKC6OoyPYm5H+u8ToeeOn8x5XlKtll6cWoRkueE5Iz5bVzk1Hvd60bzGJIvVo8Br8JICEMV+FTea+BUtZOCHfq6TJPSHFxOVTaDPQTrosImlJpPsyDlWIYY+yiCYacpLN1zM/j+Djk9R9CaWa6prOOFgWbtXwr3O2cgx7KAtpIJNghDJ6G3DGRqW0PSKz1/1HsGt2A+gGer/Dl4c/oC0RjN46gFsLu/3K5bBXI9d6tAR9Pw/aMYD5bFFgAts6Hvd7A63LSEW8j8PtgoUI6ftO01HFLkdXlhzcvGRBxzhV9Vbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlnqqNQp81WZWd94g9pkufYVFkJnWb6ydoeI4v6vACM=;
 b=QLWHox8fefs8i50GxZ9c35GXN5rE0M9KuAxCfpoa60fh06f8KCgwlmwtB2Z8o7d5Np3QFNA8TNN2hAo3YOK3mm77tobUra21jV/ODabNQe5Z7vaiczZbSHWcwVtpGNrtCtXmYSQHWbMk5lK8Aw22LMs2x7Bx4A5yIjiRjObZhsZ6IrJLH3ylgylHvihY4j27s+u4xpb1uwPz1HMY67cLOo7MxMg5wk5XJx1IbYNeIlh8GplU9Pn11bxFmxJvFbcgNWOJ99ZRTaJCiiy29UJQKmpdCWq1GdJbcWpygY5ghy+KmQHN6wOFMNExDmEneaZSA6JHRjEuPlScpIM+Mhl8kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlnqqNQp81WZWd94g9pkufYVFkJnWb6ydoeI4v6vACM=;
 b=cO0oVbDq94WN7zyKgYcHb63mZnk68MgU/G+Q3tFr4MPjdivWW9kfKJhfE6wlrLUqH7CkAGqtc/UMf0ZZVmEbAd9ROoFFLaKnga1pP8+5dD1QSaZHpnQ9AWrouriU0KNrvXc4i9WY/RIZ69z/MO9BOzbcqzPlcP3BGqR/uwj2sc4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com (20.179.28.138) by
 VI1PR08MB3357.eurprd08.prod.outlook.com (52.133.14.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Thu, 27 Feb 2020 11:25:16 +0000
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::91aa:2540:62c:aeda]) by VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::91aa:2540:62c:aeda%5]) with mapi id 15.20.2750.024; Thu, 27 Feb 2020
 11:25:16 +0000
Subject: Re: [PATCH 5/6] qmp.py: change event_wait to use a dict
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200225005641.5478-1-jsnow@redhat.com>
 <20200225005641.5478-6-jsnow@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200227142513481
Message-ID: <b9cf1087-a616-0345-0f81-d6d8247039e5@virtuozzo.com>
Date: Thu, 27 Feb 2020 14:25:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200225005641.5478-6-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0401CA0076.eurprd04.prod.outlook.com
 (2603:10a6:3:19::44) To VI1PR08MB4432.eurprd08.prod.outlook.com
 (2603:10a6:803:102::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0401CA0076.eurprd04.prod.outlook.com (2603:10a6:3:19::44) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Thu, 27 Feb 2020 11:25:15 +0000
X-Tagtoolbar-Keys: D20200227142513481
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75e34bee-4991-4b39-c104-08d7bb77b80d
X-MS-TrafficTypeDiagnostic: VI1PR08MB3357:
X-Microsoft-Antispam-PRVS: <VI1PR08MB3357A0F61B649C455C6E50A2C1EB0@VI1PR08MB3357.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(39840400004)(376002)(346002)(366004)(396003)(189003)(199004)(8676002)(81156014)(5660300002)(81166006)(4326008)(31686004)(8936002)(2906002)(31696002)(86362001)(7416002)(6486002)(956004)(2616005)(478600001)(16576012)(316002)(54906003)(16526019)(52116002)(36756003)(186003)(26005)(66556008)(66946007)(66476007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3357;
 H:VI1PR08MB4432.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FavDddyNtODgif6ydfMAwiImB4AsIonAD6SFDGKJSD53M/hR9JO6KIzlNFbH0OVp0nXHxZJNk5ECD6fvgA3zHS6yryxT/e/UhdkK1JoU9qYGyxpT+l1YjIsAfyzuOLLVT43f3LRstejHT3qLbSPCahxo4vQTeimO/ePd+d+86IZhZLKnrtFLxv+8hlWtOev70SYFWo4AMZJqvRbLqoqqcW4EsEs0zdh4b7sRdKfPQfcbsSbOtBExnSt1jqEGRvuX2BqK31/1gocL36TP4MIkKwCf+jMkAY9Uv2IA6HIdeSedgfmnIZinPIt22WLV63ZY+VQxCcLWKX5UFeiHFv4rtNHdE2FCJY0Yu1CDQkTgHAC8yJI67pU+VJij0cFGqVmjs59TCHtJZmdr5h2tfW6lZeIWUr62ptsEcR49u52xkyVxjpfyUYQQVM68n4Who/w4
X-MS-Exchange-AntiSpam-MessageData: QNmLxugLmmJtak0NmHSUhkWR6uGxc4pHe4YnCavI2ASPmksou0opu/KV1NTWADUjAeB/46pyAQA5y8GVdO5wRJxC/TclXuPmRL2XHBMDwdF5C5IMHsAVLpJpfXfOwYIJOIiVITKMd/s/7EUF5VPVKA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e34bee-4991-4b39-c104-08d7bb77b80d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 11:25:16.0715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1jPE7yc1mWbvift8zbzF4y39/nZQu8l+kiBfOfzrLZK9Bhso7utdNhymkL3xiLoKM6ip94+WiC/kdKGBHSfitaVbwnsopxw3c2VWuVNtOTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3357
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.109
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
Cc: Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

25.02.2020 3:56, John Snow wrote:
> It's easier to work with than a list of tuples, because we can check the
> keys for membership.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   python/qemu/machine.py        | 10 +++++-----
>   tests/qemu-iotests/040        | 12 ++++++------
>   tests/qemu-iotests/260        |  5 +++--
>   tests/qemu-iotests/iotests.py | 16 ++++++++--------
>   4 files changed, 22 insertions(+), 21 deletions(-)
> 
> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> index 183d8f3d38..748de5f322 100644
> --- a/python/qemu/machine.py
> +++ b/python/qemu/machine.py
> @@ -476,21 +476,21 @@ def event_wait(self, name, timeout=60.0, match=None):
>           timeout: QEMUMonitorProtocol.pull_event timeout parameter.
>           match: Optional match criteria. See event_match for details.
>           """
> -        return self.events_wait([(name, match)], timeout)
> +        return self.events_wait({name: match}, timeout)
>   
>       def events_wait(self, events, timeout=60.0):
>           """
>           events_wait waits for and returns a named event from QMP with a timeout.
>   
> -        events: a sequence of (name, match_criteria) tuples.
> +        events: a mapping containing {name: match_criteria}.
>                   The match criteria are optional and may be None.
>                   See event_match for details.
>           timeout: QEMUMonitorProtocol.pull_event timeout parameter.
>           """
>           def _match(event):
> -            for name, match in events:
> -                if event['event'] == name and self.event_match(event, match):
> -                    return True
> +            name = event['event']
> +            if name in events:
> +                return self.event_match(event, events[name])
>               return False
>   
>           # Search cached events
> diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
> index 32c82b4ec6..90b59081ff 100755
> --- a/tests/qemu-iotests/040
> +++ b/tests/qemu-iotests/040
> @@ -485,12 +485,12 @@ class TestErrorHandling(iotests.QMPTestCase):
>   
>       def run_job(self, expected_events, error_pauses_job=False):
>           match_device = {'data': {'device': 'job0'}}
> -        events = [
> -            ('BLOCK_JOB_COMPLETED', match_device),
> -            ('BLOCK_JOB_CANCELLED', match_device),
> -            ('BLOCK_JOB_ERROR', match_device),
> -            ('BLOCK_JOB_READY', match_device),
> -        ]
> +        events = {
> +            'BLOCK_JOB_COMPLETED': match_device,
> +            'BLOCK_JOB_CANCELLED': match_device,
> +            'BLOCK_JOB_ERROR': match_device,
> +            'BLOCK_JOB_READY': match_device,
> +        }
>   
>           completed = False
>           log = []
> diff --git a/tests/qemu-iotests/260 b/tests/qemu-iotests/260
> index 30c0de380d..b2fb045ddd 100755
> --- a/tests/qemu-iotests/260
> +++ b/tests/qemu-iotests/260
> @@ -65,8 +65,9 @@ def test(persistent, restart):
>   
>       vm.qmp_log('block-commit', device='drive0', top=top,
>                  filters=[iotests.filter_qmp_testfiles])
> -    ev = vm.events_wait((('BLOCK_JOB_READY', None),
> -                         ('BLOCK_JOB_COMPLETED', None)))
> +    ev = vm.events_wait({
> +        'BLOCK_JOB_READY': None,
> +        'BLOCK_JOB_COMPLETED': None })

may be better to keep it 2-lines. Or, otherwise, put closing "})" on a separate line too.

>       log(filter_qmp_event(ev))
>       if (ev['event'] == 'BLOCK_JOB_COMPLETED'):
>           vm.shutdown()
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index 5d2990a0e4..3390fab021 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -604,14 +604,14 @@ def run_job(self, job, auto_finalize=True, auto_dismiss=False,
>           """
>           match_device = {'data': {'device': job}}
>           match_id = {'data': {'id': job}}
> -        events = [
> -            ('BLOCK_JOB_COMPLETED', match_device),
> -            ('BLOCK_JOB_CANCELLED', match_device),
> -            ('BLOCK_JOB_ERROR', match_device),
> -            ('BLOCK_JOB_READY', match_device),
> -            ('BLOCK_JOB_PENDING', match_id),
> -            ('JOB_STATUS_CHANGE', match_id)
> -        ]
> +        events = {
> +            'BLOCK_JOB_COMPLETED': match_device,
> +            'BLOCK_JOB_CANCELLED': match_device,
> +            'BLOCK_JOB_ERROR': match_device,
> +            'BLOCK_JOB_READY': match_device,
> +            'BLOCK_JOB_PENDING': match_id,
> +            'JOB_STATUS_CHANGE': match_id,
> +        }
>           error = None
>           while True:
>               ev = filter_qmp_event(self.events_wait(events, timeout=wait))
> 


Not sure that I like new interface more (neither that it is faster), but it works too:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

