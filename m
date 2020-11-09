Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B412C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 12:18:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F40C20789
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 12:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ISAuht70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F40C20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc67e-0001PS-Vq
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 07:18:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kc66C-0000jJ-Gs; Mon, 09 Nov 2020 07:16:41 -0500
Received: from mail-db8eur05on2107.outbound.protection.outlook.com
 ([40.107.20.107]:30368 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kc669-0005R2-4c; Mon, 09 Nov 2020 07:16:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQWuc0GPZzpgExXBLE2f+BezJsrOjRrv44sxhZwkmZdg8XC+PY9fG4RRsxE9lW89KMyYU/pc501ZK8J8qhkfDMLFR4oGU1HEdMtAuJIqUGX1TQiG2PB21ip/OKEqwlSwtJWX01wfL/4vNsefXrasFpr/vQ9V1L3bb7IUHZ+cmrlwKps75mcxb5P0F855ywzioXnpO2G+uiJaJ+ThJatAjfGmKpk1FWz6rB3nOQHstS7g6kzKzyPJ2/h0oV9BBheNyXEizUn72Vp5KJuELxQzBRgQVsCAeBDQdXu3mynTy/yV2pescIRuvmQEhk0wJK3hqlos3ngbVp0aNxnBIbnGuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0ifNNq/AxnSz9lSEhto87sUiyAEJvMH6Yvy8LFaX3U=;
 b=OEH4xmhVNb/c/FfJVL1t4+WH2jYUljd60ZS6uvxzp/wdD5RtPnc8SUs693uRKgt0CLg/am4kK+Us6ELDu8P5xEa1kVaZiKH3Q6pAyirSoI2jhq73PxhcqKGFmNSBVO8MHrQudS+ZLVDL37ioaw/2vS+U9x3rn3dx52xiSU2Ci+xVThsAkrhSW6loHEf5MxZJpJWAjiyvZVHnx4H14s6JwKAz+8QXBbSGpnFY35SjK3McCI5ZH54g0pivNxjqVhfnbkjG+ZG5gOzzrNZxcRTl+SRIFAtiejGhOxtEPgjvxOKsVp2Mx38b5zo9Au/yMzHnLndgGvQkSXaR5Ns0L1O+wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0ifNNq/AxnSz9lSEhto87sUiyAEJvMH6Yvy8LFaX3U=;
 b=ISAuht70a/K5atb76epYAFm1oYOvoaf7adLhCGaNRAP1uYRoKAA870gvDPnZTgNkTQO44Y1vkc/vps9scZuoM4/w0xnxO+oayhALtmkeQEZILJ7OXU5hhy9lKFnSicyf9gL7cKmCbcLaIroiu4Hx2TEV3StCM0l66p467b2FgWM=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB2036.eurprd08.prod.outlook.com (2603:10a6:203:42::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Mon, 9 Nov
 2020 12:16:34 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.032; Mon, 9 Nov 2020
 12:16:34 +0000
Subject: Re: [PATCH v2 13/20] iotests: 129: prepare for backup over block-copy
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, wencongyang2@huawei.com,
 xiechanglong.d@gmail.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, den@openvz.org
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
 <20200601181118.579-14-vsementsov@virtuozzo.com>
 <0293433f-7b37-f7bb-c4dc-3d64b2dbbc68@redhat.com>
 <95c4411f-9b88-2fbb-1e36-2fda369e51a8@virtuozzo.com>
 <bc4a3074-cda2-fad9-1bce-71aa3ce2f837@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a62c4eb8-8a08-11b4-f09b-dedd0ee99da0@virtuozzo.com>
Date: Mon, 9 Nov 2020 15:16:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <bc4a3074-cda2-fad9-1bce-71aa3ce2f837@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.215.60.85]
X-ClientProxiedBy: AM0PR08CA0018.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::31) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.85) by
 AM0PR08CA0018.eurprd08.prod.outlook.com (2603:10a6:208:d2::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 12:16:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60c9a5bc-bc7c-4c61-5edf-08d884a94ca5
X-MS-TrafficTypeDiagnostic: AM5PR0801MB2036:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB20363F68EA4BC44D59BF5E4DC1EA0@AM5PR0801MB2036.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CAgkArkQw8jAkQgY+dCVLQl0rjbWSegno631vLYfhGvwFW8qh42T+E/KUlrGxC8mSDW1ddo3XAR2moziu+Zk+XuT5Sue9nVCPCdbZq8heBwutKGYgLYPe7dOVfF3gJeK0uxnhHw+B2k2nKsCHwuojGj7/f2fbkXL9UcLfar71uTbNZadl2smkWiFFqBNcaezLqP1Cbj6uj6y73QQPvI4sTcEVMxncVnM75ivR2bsptOxNN+vQwZojnB4JsCFvJUdgi0rmvS1Z+N/mW0aK7tF9HJWSDc4BNN0d/HeGWnIAWHfub6+95Pida1VG0NQZeSAzGDU5+xQ/sgULVWT4o8O3cPA60giZ0USregoQUcBcu/vnMriZlVa3lUgii5sbMwGbFf4H6tYj3PQi7wuwO+62+N78gqENOoizkcMALGp0+8TKBOBzq9eL0jvLa2mNgubiS3euHCvu9POgM8aIVwIkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39840400004)(396003)(376002)(346002)(136003)(966005)(5660300002)(53546011)(66556008)(66476007)(83380400001)(4326008)(66946007)(8936002)(52116002)(186003)(478600001)(16526019)(26005)(8676002)(36756003)(86362001)(31686004)(956004)(6486002)(16576012)(107886003)(316002)(31696002)(2906002)(2616005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: cJ1YrUU3/kVWgOulvSEdVLxaurBmhVj9PVJ+6iUmlHxGaTAMbvioUkFi89u4+2ef8zQCSJM2SbUxYuwYDGcBa7A1yH9VG7jO8VvXcvTqPHRdOwJphrx4UPAfc0tRJfrhgYbtm5nTTF5p89xgoFh0HrVWvvmw3+69dhyCT05FJaV6UPUTCViUgDjnLLJY4KSDf5qpTiTRm1n33f+A0U7w5yQdsiBJZqjSnP/evwPQ1Ht3LeIwtvzsC4MBZK5f8AhWk6ngYavAJSanaJTgIfmDxGy1UY9E3h1ablr1c76Z657YYW+8mkvsDX5ESBQmzo0DV2DVL81Z7lioDrnjtl5GzbiFD2U/HgGN+u6a6LU8RbxTYcwonsoPXUlZHeH0WXlRunAtj+l2dGhkc7JQ4lWJiLBGfQCtbx2NIdbYGM/pKk1Rup7b5V43Wo7k+GNveff8TKDWjZ7Bn4d9Dv3AeNvrofukpO9cmzjvTDSkXOqe3ITEpV1NJWgIzu8z607vuYC9rSndE8Kjvb+bwRweTnRMEAvRKqyiP+Zh+1MlgdEigx8bdiO0FMNWTXssbaEI2Y1eC/riweXuANYsFeUgJ12j0ETPXLTC9vNaEudGd3JShM6ywqKSMSQOcjUociWR+VYc+pmWJmQ/0MjlJ/4NsS0UyA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c9a5bc-bc7c-4c61-5edf-08d884a94ca5
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 12:16:34.4684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ek/uq6i/pIYwdbVTtkiSxEY/AVNEfJfkc7cIeLuYxXopmi8yYt3o262dNtjKhkg/OPMxc/zlKfdtEpkkZyNFGGgdc68sTrlxmIm1dP2tR/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB2036
Received-SPF: pass client-ip=40.107.20.107;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 07:16:35
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

04.11.2020 20:30, Max Reitz wrote:
> On 22.10.20 23:10, Vladimir Sementsov-Ogievskiy wrote:
>> 23.07.2020 11:03, Max Reitz wrote:
>>> On 01.06.20 20:11, Vladimir Sementsov-Ogievskiy wrote:
>>>> After introducing parallel async copy requests instead of plain
>>>> cluster-by-cluster copying loop, backup job may finish earlier than
>>>> final assertion in do_test_stop. Let's require slow backup explicitly
>>>> by specifying speed parameter.
>>>
>>> Isn’t the problem really that block_set_io_throttle does absolutely
>>> nothing?  (Which is a long-standing problem with 129.  I personally just
>>> never run it, honestly.)
>>
>> Hmm.. is it better to drop test_drive_backup() from here ?
> 
> I think the best would be to revisit this:
> 
> https://lists.nongnu.org/archive/html/qemu-block/2019-06/msg00499.html
> 
> Max
> 

I've checked, no, that doesn't help. I suppose that throttling has same defect as
original block-job speed: it calculates throttling after request, and if we issue
simultaneously many requests they all will be handled (and after it we'll have long
throttling pause). New solution for backup in these series works better with parallel
requests (see patch [PATCH v2 07/20] block/block-copy: add ratelimit to block-copy).

So, I'd keep this patch for now.

-- 
Best regards,
Vladimir

