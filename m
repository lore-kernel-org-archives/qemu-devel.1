Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099C7C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:33:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C938F205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="E8IWabR6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C938F205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzWY-0000t1-29
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1juzUu-0007SQ-LH; Mon, 13 Jul 2020 10:32:00 -0400
Received: from mail-eopbgr20100.outbound.protection.outlook.com
 ([40.107.2.100]:41278 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1juzUr-00012p-Dn; Mon, 13 Jul 2020 10:31:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlnTHu9RKErbVxNKMkxTAjP1kx57iEksQqPWkTA9Qwls17sfcE4QUOUWZiyOsaYDayui2oTc/Zz2cEJVf0YPI2D7rAcOEbuor+efTajtshQVbd8M6QOJ+5xeIWUecP5JXoSKfa8OeiMjhj5EJAPxEwebSssIBmD5xHEn3Xri+A7LqCEkGGJR6ziE8MSJewuQTNGtPEBzyM/+WHi/Ln9nT/m89C+kuj8TP5i+rPDGv8AalriSh/gVKBwg0OLlZn7vBmg4NPnyyyrPGAW97O9YdrmHsPXaYrKHTWrfEVsXJjJEqPCeUqAUmvb0+3kHrQrOVVHKquzWzYb4MOF5Tg6Qag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3/C2m/mtt9etnd0D3EP3GkDALANgDSFp8240M50q9I=;
 b=DE+6rhl/sm52cf/DQ9ANRDA85eVY2NRFcdIwfV3DKP1qmWmHhhpjZXRGuk7Q+lZe3MBdOZyYv854SqgmlkOA3N5gMLQ7+sUr+iA5QazhKIPqKXwlaJYd+lwsm37ShdyEJMoD8UPqQVMtIQ8dUmlUZj3G15XEDmQ+hqpp+/AAdFFolURtugfoOCL5gPGNiW/c6EgYNNJLVO4bfwoNBhOHDIUmGyqJjckeG5cHwesARlp4bikV2JcawSTCVF9uiVyRz1No7nJrrhz9TUKatdlkL2vKk7Xj7AhYuJQXXRdrANb3UHo0RB4UqBjVL9nubog9z3ifS9O2V/8UtK5Ekluumg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3/C2m/mtt9etnd0D3EP3GkDALANgDSFp8240M50q9I=;
 b=E8IWabR6VZ94eROIGSzokLwgXQurBs6ayGvwimRHBk22W84vi0S1QLNrkembTuBM3yH9AmdnLFWDfBg0DDop/qxeX7+4n3e95qjDdMgcR4lXnModpuWhpQv82e7jGbdzWgNP0F1f+EqNZxmc1ASl5yU2Rvzz/fhGXq7WpwS7Fxc=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5127.eurprd08.prod.outlook.com (2603:10a6:20b:e1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Mon, 13 Jul
 2020 14:31:54 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 14:31:54 +0000
Subject: Re: [PATCH v2 4/5] iotests.py: filter_testfiles(): filter SOCK_DIR too
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200701105331.121670-1-vsementsov@virtuozzo.com>
 <20200701105331.121670-5-vsementsov@virtuozzo.com>
 <63b3acac-9501-d80b-79e1-97115cbad32b@redhat.com>
 <7b661aa0-d6b6-f69a-7dd0-73efedb7514e@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2660f6de-4e7f-7d39-51a4-f2502e110edc@virtuozzo.com>
Date: Mon, 13 Jul 2020 17:31:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <7b661aa0-d6b6-f69a-7dd0-73efedb7514e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR04CA0143.eurprd04.prod.outlook.com (2603:10a6:207::27)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.167) by
 AM3PR04CA0143.eurprd04.prod.outlook.com (2603:10a6:207::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.20 via Frontend Transport; Mon, 13 Jul 2020 14:31:53 +0000
X-Originating-IP: [185.215.60.167]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83394a01-9076-4752-0a52-08d827397d41
X-MS-TrafficTypeDiagnostic: AM6PR08MB5127:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB512734F63034578094D9DFCDC1600@AM6PR08MB5127.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:65;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IlkH1HV2PeQaE+2HmHajYSfbQ/MIHB9IsrA939FhztJgTodLAE4aPn9fUDwL0VU7+nw5hFw2hspsnGxBUx0ZbhKK9rlOUQ7+yQbjXyCk83Ny1WCrhKKpavmD4ZUIPOgPAy/omc3mIMZUQN3Qc9CmP17+wdP6M7B0yl9oe+NExHnZSoE+XFZioRC+WlRiOBJkB/fQamqpqMu7cFhyNCSdvl0ziZUbZbjltAp9KtEJh9/eYcK/MyjXxuE0kjGDsCT7fFt6h/+nx10IICgzzqN2Gtg06F4W6ik5bLcw+4Mj4fkf5V93xb46KR0IP3uKoqNU95Taie61o/OOrPDYdyZabYuV7uk4X8V79OJlEJ1ibBIklXDX+8bGFaFvKZVCE+CO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(396003)(376002)(39840400004)(366004)(31686004)(4326008)(6486002)(2906002)(66556008)(66476007)(53546011)(66946007)(16526019)(186003)(26005)(478600001)(83380400001)(5660300002)(86362001)(8936002)(36756003)(956004)(8676002)(16576012)(316002)(2616005)(31696002)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ZcrIVEh3OxVbzYQUHDOs8Tev8gR9SaolkCbLDcJfJPvVDsrgoMiEstduKAhXiUelM5VosNUG0j6y5HOIEoh0zxDnXc252IUYZU99AcW3Bgb/hnGPAEmx2pf40sKnHjhGD7eHJwoCbeFrlaCKB+aXG2YuaipMgfnlEsSNvBN14f2wLazqMGadxd9LoKZy8COrC0ALt2Qq+oPbGWKCChY3cmYAHwHgiLgazoDi5L2pwihMdAWjNH/4kgoyN8KUqK0jFGnhcqgFLU2kkLXdJQZt9qhvGT5fyt45Lqf//QmaHg+sS59mrSnBe3AAEJovG984bdW357i+3c2M4dLu1nK/LQsbFWzy1tVSmYX0trzb5wlyR4QYgkGpl9C7IGz2/COuwDeA1HJeT6p/2+G/6Ep0OS0hoPK2BqfLxHIvcS8qvT3w7yCe3clznwhGyrSyfyEuWUEQTzGzQhhzs/c4sWGwyL+jQtdUIq1NQg7IDJchN+5At90vV/mcYtNz161Vfgko
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83394a01-9076-4752-0a52-08d827397d41
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 14:31:54.2243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/WYu1iWdzJpa5nK2YiKiqU/nKmxVi5xuzMmPk7YEs4EYjN2E3ORpboUFEe+FEi6l4H34uGqDFSJZ/cHtJ6sXHHlVor9QgUrRwdDRcFGFw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5127
Received-SPF: pass client-ip=40.107.2.100;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 10:31:54
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org,
 stefanha@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

13.07.2020 17:00, Eric Blake wrote:
> On 7/13/20 8:07 AM, Eric Blake wrote:
>> On 7/1/20 5:53 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>>   tests/qemu-iotests/iotests.py | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> Queuing 1, 2, and 4 through my NBD tree as trivial iotest improvements, while we await better review on 3.

we aio_wait :)

Thanks!

> 
>>
>>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
>>> index ac9d199a1e..31d4b105ca 100644
>>> --- a/tests/qemu-iotests/iotests.py
>>> +++ b/tests/qemu-iotests/iotests.py
>>> @@ -345,8 +345,9 @@ def filter_qmp(qmsg, filter_fn):
>>>       return qmsg
>>>   def filter_testfiles(msg):
>>> -    prefix = os.path.join(test_dir, "%s-" % (os.getpid()))
>>> -    return msg.replace(prefix, 'TEST_DIR/PID-')
>>> +    pref1 = os.path.join(test_dir, "%s-" % (os.getpid()))
>>> +    pref2 = os.path.join(sock_dir, "%s-" % (os.getpid()))
>>> +    return msg.replace(pref1, 'TEST_DIR/PID-').replace(pref2, 'SOCK_DIR/PID-')
>>>   def filter_qmp_testfiles(qmsg):
>>>       def _filter(_key, value):
>>>
>>
> 


-- 
Best regards,
Vladimir

