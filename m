Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F95C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:27:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FF1C207ED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ie8GbWc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF1C207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiYfb-0001gE-QQ
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 03:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jiYei-0000YP-Az; Tue, 09 Jun 2020 03:26:44 -0400
Received: from mail-eopbgr80090.outbound.protection.outlook.com
 ([40.107.8.90]:44099 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jiYeg-0006Yt-3n; Tue, 09 Jun 2020 03:26:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kj1PRLqz2UoZPsSIM3jOZAZh6l0WGE7i8qxJXbRev9FqTOPWMp67gTAJ29VsO0KZCmZt3UDlCVgjeF68L63wjBsWoct3hplI8phTI50GkVYUdDAYG00oTyh10cUE6gQzOadNU3/T8hXyBEtetzYLYJgLFaHt6M605dUVL570cC/jnn4kmf7UHHkgyulXG+uDqWWu949dOhHUvv+edFLql23WguehpO1KaC8l4hfnd3VrjJdI9ePvaon+5wUpYVPEK/VvGyGtE/r2gNgjrPI7vZQ/l22LxiXusbe5Hj7dqn40lagV5V+WuAIWoxCsVlftXiwaJnmnkpPNQlNDZpECJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6Nw6zUarHvHx/WX6pDEicADEBVhL6mNma3CLcRFAhk=;
 b=kUMhhwH13kC8lsjzP5aQc+JSpNuQcD5Xzf3DtQs1UaxphZ73ohr0bUBAiTBuCUgpWLzu33G1T7sVENW1KJ97mtA5s04AaF83HjxojY9ijE3KuzPFk8dETAXeY5J2f61enBKceazk+SaOVJcfuH/t9iL2HLFzsWyH/7w6wCy+uCF4XtSSYlFW1nt9vNNjBDnqIYS68yKzIdVb17naDPH8Gpb/JYLi/Nd84sm5UiyRYjY76VNXcC31o9E8BlCwMn+PxuRC+LI/Szww750ppR0TQVl/WDfSnTWPNkKLQZleU/x9fvXQVxZoy7P/a7yrus+Qj2YzOiv0VNakYMruojmLZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6Nw6zUarHvHx/WX6pDEicADEBVhL6mNma3CLcRFAhk=;
 b=ie8GbWc+GXr0vVQJ9wMuxkPWYZArdsGODbfcuHX1dDxv4TySA8KnpxxEHjwhY2ClDUi6zN8hpz7rosvbfRcnnKqmvBuqH7LJhZog6Ovm3mZpWZChEQq5YEYomdIxgpCX9o0GOK57oklaxpQldGRVhrUNP6PmsXCTU8w3LXPaL0k=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5447.eurprd08.prod.outlook.com (2603:10a6:20b:10b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Tue, 9 Jun
 2020 07:11:37 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 07:11:37 +0000
Subject: Re: [PATCH v5 13/13] qcow2_format.py: dump bitmaps header extension
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200606081806.23897-1-vsementsov@virtuozzo.com>
 <20200606081806.23897-14-vsementsov@virtuozzo.com>
 <f14ae085-6328-a96f-f9ab-fa35a0537a3b@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <8fd46a36-6c81-fe09-0680-db1e3b1f33ff@virtuozzo.com>
Date: Tue, 9 Jun 2020 10:11:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <f14ae085-6328-a96f-f9ab-fa35a0537a3b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR06CA0136.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::41) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.180) by
 AM0PR06CA0136.eurprd06.prod.outlook.com (2603:10a6:208:ab::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Tue, 9 Jun 2020 07:11:37 +0000
X-Originating-IP: [185.215.60.180]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86de45a2-490e-438d-0c85-08d80c4459b6
X-MS-TrafficTypeDiagnostic: AM7PR08MB5447:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5447633301C353865C8A375BC1820@AM7PR08MB5447.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 042957ACD7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uMbkuTW3mjuuiZ3XIiZ5spR56gRrR6zFjS/ITHqNJ0Caxn88JkT9TZKFCfyc5xMMLND48dEftXHu74iWfs6Bs/6SaBEcxo7aA3NEi7CbrA6M7mj/GR+iEWWmu05A80lGCfXyh3Z1IWPT2uAkiySzNa1m3ZNkdbVatiOuikkmJNDdi4PAFkYxZQViFqGxOZlwUP775QZDry15HvblT3a/nh9X0jnctEECDTo6nQTrWKvzZrwe037Kqy6FeialA7Zg4BLs2xlJdIXI+lQjb5J7zcA2DK3Nr4X4rca9yc016OvXYcQihrMwcsSnfEYHpOZpeNKWATIEWL0naBxTK2CZ/4Dmxdvzv7xtsNW7vLyaopS1bXWbEDyAHi8vw2suUZBjgZDc1QI462Cd7jlRDjAKKEMo6MaNeaYIDAJqeBDuSuFP6F097U/p54ybqt3HuJmWz61xPYmDph+BQ1zJI5L/FQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39840400004)(396003)(376002)(366004)(136003)(16576012)(186003)(16526019)(4326008)(8676002)(8936002)(107886003)(83380400001)(31686004)(478600001)(86362001)(5660300002)(31696002)(66946007)(26005)(316002)(36756003)(966005)(6486002)(66476007)(53546011)(2906002)(956004)(2616005)(66556008)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Hq947+CMTEdnYPXmDKf3Jb09jiUfJI+Wcpf7S6isFcqDbt5QHMCO+kZ7UF6XagG589cEZfRuJZxBsi8KMAob4WUL3vab2SaRctd8+27KIS4C5yyBrGkcx9FQGBF6MZhrP5tVicyYXNJ87w3zqQtXslcBB6Vqi2L1URP7YQioMFtZS8JCng2A4L6NnXkMsKfv3qMFqSy75/Lk9J3WgrbUzHboWwx6RpXFkX7XzqN22T1GIgA98MaENtT1f4S/xCJ8hwEphAN6zNe8vrZYOWywS+ppzA6IaUNVnn9qYd9Zf78veONuWYDycWdLWjTMUkG/8kgPOovymz7qDocQGgyB2uGyLs89J24j7x9mjMIwSu/5pOlL0UykHHnwkH9ureRa4Qpj5Ir205zdhiEo6NzImYR8eCwO4mErVQcamETvTabJnydOJAVgXbtwYo/V7D1RurXGauf6kgVClOsQsgKLURcsQz8qNiVlopUvRLEbvRT3jX0e7mUp91wpjDcQEfbH
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86de45a2-490e-438d-0c85-08d80c4459b6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2020 07:11:37.6940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PdwFTHa3YXfuA4dSVjWKNCgUAoIO2shoerioOU8R1aHh4Eh+MtL0pwPMoTBc1Qx/sqNGp6+XuY4qohGMSMs/PbREKqbKkoD4GL6+YUSvIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5447
Received-SPF: pass client-ip=40.107.8.90;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 03:26:40
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
Cc: kwolf@redhat.com, den@openvz.org, andrey.shinkevich@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

09.06.2020 01:00, Eric Blake wrote:
> On 6/6/20 3:18 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Add class for bitmap extension and dump its fields. Further work is to
>> dump bitmap directory.
>>
>> Test new functionality inside 291 iotest.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
> 
>> @@ -88,6 +90,8 @@ $QEMU_IMG bitmap --merge tmp -f $IMGFMT "$TEST_IMG" b0
>>   $QEMU_IMG bitmap --remove --image-opts \
>>       driver=$IMGFMT,file.driver=file,file.filename="$TEST_IMG" tmp
>>   $QEMU_IMG info "$TEST_IMG" | _filter_img_info --format-specific
>> +echo "Check resulting qcow2 header extensions:"
>> +$PYTHON qcow2.py "$TEST_IMG" dump-header-exts
> 
> Context conflict with my pending patch to resolve an issue reported by Kevin:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg02057.html
> 
> but that is easy enough to resolve.
> 
> I'll be queuing this series through my bitmaps tree, hopefully with a pull request on Tuesday.
> 

Great! Thanks!

-- 
Best regards,
Vladimir

