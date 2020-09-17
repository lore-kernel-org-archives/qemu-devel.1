Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EDCC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 19:23:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A77FC20672
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 19:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YIKVaEbW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A77FC20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIzUl-0003Ez-EH
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 15:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kIzTl-0002IC-If; Thu, 17 Sep 2020 15:22:01 -0400
Received: from mail-eopbgr70108.outbound.protection.outlook.com
 ([40.107.7.108]:47614 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kIzTi-0001PL-9V; Thu, 17 Sep 2020 15:22:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Py6JIS7hICYdNt4Nr+8dbP8r0AYpredmRd1pxZ92f5rDDmM+3N5Vvy0bTxQ59vpdLZ1LWmjk7rMsrwM7xPORiZY66K+GDfk6yKvYaquiNEpuLgUnJ0lAUifHVR598o5dNsuGLuFCEf/Zx0m2zvU55Ne6XLx+nwCtCqDOfEWOwo4M4NF3wO0EFO3etT2/IOwmW6J9jYuaKuUGdp7A857HK6XZ17ITwmKnuwriGTKZifDuarr+oPuso1/Dey4GWfMblAu12nQ0E2KhJj4k8RcUavB0jgSz0b08Z2b2b/KQ0S01f9svEbMQbHCV0f8cEuRzpwqnZduZRVXw6KBt4wJqkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2vJR2O/9joM0UOlI4TDBzryHO1fcx39LkaNEf2o88s=;
 b=hhE53NvMuTWs+/rvqh7Df9D3VgBtanS0MAxwTNAHV3C0ZC+M83IZ/e1PYcQY/Kee2XiJr/PGjsjUq8rsNiXw6Yt+A/nRN7xNLm/N6ei+pAUo3tY9X6EIV8EIqS0iJHDNga+L/nUTO8A+oigCVsUyQ5CDMfrSgafL9UkunAsMWgUVRMZBthkdYPi6fMJbsqyy5ByAavBiZ7LfT9AhG69XkcqYoE0hddQ0V3ZzWAWSm2Nl1aAv1C6pfnh9JpmaFNTjM+PbLBmYvGkcQpAZcbMT9sr6zrrWHNDCZFOK9qm3+ieqdyAcJN//20uOnF6UGPEfT/zJdG2HYLwbEQmxijoiQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2vJR2O/9joM0UOlI4TDBzryHO1fcx39LkaNEf2o88s=;
 b=YIKVaEbWiyhPT9VoHtYVcr/E5EBbSd2PBsbQ10Ua6WZEqsxeH7ECQNHrOmi4W/wD0W+xvljNqMW3sNmXPbznh70YcCPhYkGEOoS/jP5h1j7cBDFF1M7RqZlYtidNtkpjEi74BK8Bz1/F599MwdW4TN4Gvv48ZCGpd1R6Xcfb7r4=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5493.eurprd08.prod.outlook.com (2603:10a6:20b:102::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Thu, 17 Sep
 2020 19:21:53 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 19:21:53 +0000
Subject: Re: [PATCH 02/14] block: use return status of bdrv_append()
To: Greg Kurz <groug@kaod.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 berto@igalia.com, eblake@redhat.com, jsnow@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, pavel.dovgaluk@ispras.ru, ari@tuxera.com,
 mreitz@redhat.com, kwolf@redhat.com
References: <20200909185930.26524-1-vsementsov@virtuozzo.com>
 <20200909185930.26524-3-vsementsov@virtuozzo.com>
 <20200910181056.039cd173@bahia.lan>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ad1da02c-e5e2-7e09-ee23-d93a7d0a0a64@virtuozzo.com>
Date: Thu, 17 Sep 2020 22:21:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <20200910181056.039cd173@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR04CA0133.eurprd04.prod.outlook.com (2603:10a6:207::17)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.75) by
 AM3PR04CA0133.eurprd04.prod.outlook.com (2603:10a6:207::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14 via Frontend Transport; Thu, 17 Sep 2020 19:21:52 +0000
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30cb6a58-1e70-421d-92c3-08d85b3eef13
X-MS-TrafficTypeDiagnostic: AM7PR08MB5493:
X-Microsoft-Antispam-PRVS: <AM7PR08MB549313A1F95EEDE106EF7B4CC13E0@AM7PR08MB5493.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nll8oXiVT4gepGLPL4LNobOVRle2Wesr/B7f7XWKQ+wc8zTmv6orcKEN+bf/g9jgWOnTbhajkaEMnKlPHs3sD5Ca2e2NG6P1EB3hNR+4kuQpA69r0gOAlF2XZrjnSn6MLog7xZRYuP+Wou4y+vtBLn79IWWA09+du4705V42FseLpWnloHZjEdgCsfMbaNalj0TC188tp2s4+pI2+t4kXDcQPkmjS3kwggZZHEWweldvu2EnCZQs4SOhL6CDzQjF3ZA8zXOySOd0C9pIcjksremqNfJyvdOuEFjqBAxXxmd6cVgj3swPwgwWkRtEuFLRNGHuMcDpd3X0IbDFzedVL0qC0nPL9MjyYO1Vfdwt1NgwJeujRgnPgO0sFEChdaK7qCdWBrQkkwA2iS0mj3Y58X5UaErqbE0GG2z3hTfrv19ItI/ZpYhb7Q0bNPhs2j6k
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(396003)(376002)(366004)(346002)(136003)(5660300002)(83380400001)(31686004)(16526019)(8676002)(478600001)(2616005)(86362001)(31696002)(8936002)(956004)(16576012)(2906002)(4326008)(66556008)(52116002)(7416002)(6486002)(26005)(316002)(186003)(6916009)(66476007)(66946007)(36756003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: bU1RnM7TYtAo3gIHl699+i8JOaeO1DEVNajGBQymx1+VUFVlCBSaOlG+oZx0TOx6EGWP/RTSFVZl3uWGY4xX+PrnP0Ypaj0flKbtX8myM+9DcAnz6bFN0AGLfmvkcI7v778YGRbmlKhwc1jzzd1njZBG0Z7VMNwXQJO7LUqNW/erSY6hS77HSvxF3Ua5ARVT0fIt4z+emWoidjJeA5pONYZqux61FQHTgPRmKcoQ+yERW3fZAb9Z3XpUrwHKUvVkpaJ4sR26QJTaBx847YOwIUP9Sas2qJra7R1Sgg42qteh4bX5lhuTDS3AryqLpepZ3Nd8RxyzeC26iOlevx1JXvsPK7rtkmn7uwLulojhDXvLBeZN12OmSO5qIaGVw8C4bYkRKMOuvfg1lvRSXEy3TRHreSAUaBCsVwK8a4PwJzeLbzRhaSOC1egvW914FUgxoKOgYh7FLla+9xf4hVrimZn8/B4ZUcbf1dLjEHLehO1HTVwmviDi1/U2Qh29dkqtWX+U2m9ZN1yilvi0xQKsV3Ma6f5y0A+HckYIif/XeopvEn3kvHpe+lort9PX+bYiK1X4vQljhRPUS9iWLuYJO3KTDJh4OKk8tu2K5xnLxKyn4rtLtIUavnKaTMzduLdeBuw+i/hTXVIuOnjF03GhvQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30cb6a58-1e70-421d-92c3-08d85b3eef13
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 19:21:53.0968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wpHgQwA5qLUF3LRt+Sa8rldigyuuxOaHp2uhuGlPTutgCVc9dXF5zuWIYasgkKF1MDsemaQbiNludzyqioerkh1KRQc5CcFIhXFWr+aEDuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5493
Received-SPF: pass client-ip=40.107.7.108;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 15:21:55
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

10.09.2020 19:10, Greg Kurz wrote:
> On Wed,  9 Sep 2020 21:59:18 +0300
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
> 
>> Now bdrv_append returns status and we can drop all the local_err things
>> around it.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
> 
> Reviewed-by: Greg Kurz <groug@kaod.org>
> 
> Just one suggestion for a follow-up below...
> 
>>   block.c                     |  5 +----
>>   block/backup-top.c          | 20 ++++++++------------

[..]

>> @@ -253,7 +253,6 @@ void commit_start(const char *job_id, BlockDriverState *bs,
>>       CommitBlockJob *s;
>>       BlockDriverState *iter;
>>       BlockDriverState *commit_top_bs = NULL;
>> -    Error *local_err = NULL;
>>       int ret;
>>   
> 
> ... this is unrelated but while reviewing I've noticed that the ret
> variable isn't really needed.
> 

Looking at this now, I'm not quite agreed. I think that avoiding multi-line if conditions is a good reason for additional variables, like this ret. A kind of taste of course, so if you want you may post a patch, but I don't want do it :)

-- 
Best regards,
Vladimir

