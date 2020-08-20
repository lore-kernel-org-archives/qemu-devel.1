Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90BEC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 13:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75A46206DA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 13:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Jk2xVX76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75A46206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8l0F-00078c-Pu
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 09:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8kzH-0006MV-5L; Thu, 20 Aug 2020 09:52:15 -0400
Received: from mail-db8eur05on2132.outbound.protection.outlook.com
 ([40.107.20.132]:30689 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8kzC-0004l6-Pz; Thu, 20 Aug 2020 09:52:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/PHaei+wn1mGrnegzbEwiki/0lP3SLqEL/hsAnD+2Y71AqUh8a+b4w2dg4GHIROO/5U9z6duHmRVnwuRpQbci44OghwnzRDfSJnhKo/P4QylXyCPRaemL2vqyLLyW5CsHUmMpf61Xn41+iG1IM7nZjrVsaaOm7y13i5BRYpxXWM6KmLKUxxe5Sy+lK93eVN7L39vX9PoAZ1/TdjDJlno4MKg7xnlr1OJaSvnPnmgHne98bGAvesrcVtYYic4uTF5oEnVwyywdKSWiU9+EySmOh8g1LINq8L4VNVL4XrtJWRrMl4rEDcM26NZbskAjXhyxQ1OLP13FCGMY/Pi2ECJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lt1CkQPA+1XJI73XFtx1oEt61bhL6M0x5+QeP2+0mek=;
 b=WJ6xFFfL+LIUIhy4xChdqOk2AN0By2OFdtqKkn1xSye5TdfgsUFDRvf56zQEKj3BMtHnSl2+jB9RfOyBg3I9jij0bLON9lsfkZERCOoZpCjFlH0B66CqxDq9KVuIShM0BVoFlBC6ywIsUbLtVf8O+1AZYXQHgv9N8vizHNEGx6yH79OkWLGHPw2xD8RteWg+CyCiZGkaMSOeVXvu8Vrf1DnBqYoIzFi8Fytcl+MkJkLMXrrkAQsQevyhg1J9OPwwzoCzQwGVK/4b75e488PgkMljRHQTgxFZX2tqJwa1ITvDauVu4X/1hYxLTqBiN8JvgyXY+21sFZCYMxakOnDwNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lt1CkQPA+1XJI73XFtx1oEt61bhL6M0x5+QeP2+0mek=;
 b=Jk2xVX76sy0QKV8RIxfT4xwq4OE5owcJTLPJ70CYBAx05CGTHuohvl03pbKaeqV+O0spWeU1ToNJlx+mAdE86Qja1ZVbue5PHef2dpBjLuQKslEnE3XqNciM+3P64v335WsiD47Wx8OteS72byXglYYmzT1rZRAzOa8cel/6KqQ=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3158.eurprd08.prod.outlook.com (2603:10a6:209:44::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Thu, 20 Aug
 2020 13:52:07 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Thu, 20 Aug 2020
 13:52:07 +0000
Subject: Re: [PATCH v4 4/4] iotests: Test node/bitmap aliases during migration
To: Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org
References: <20200818133240.195840-1-mreitz@redhat.com>
 <20200818133240.195840-5-mreitz@redhat.com>
 <fe00acc5-a06f-5e65-63f6-5f0ed7ec3019@redhat.com>
 <28314d9e-714a-2acd-5bd0-cf61f9ca41b2@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a07eed84-8c00-03d9-39cd-f78fe9cbf17f@virtuozzo.com>
Date: Thu, 20 Aug 2020 16:52:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <28314d9e-714a-2acd-5bd0-cf61f9ca41b2@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0004.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 AM0PR10CA0004.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Thu, 20 Aug 2020 13:52:06 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2f3c74e-9782-4a8b-cdee-08d845103a14
X-MS-TrafficTypeDiagnostic: AM6PR08MB3158:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3158A2846C1C52F4A0FF574EC15A0@AM6PR08MB3158.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:374;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N+YFPUBekaahVqtV5z2uGy8eZVAavWLqtrFBju0yDv8hobO9CvMxiFfVChoiEa+G4a2zLeI54G3HLr7P56nj/ftAtceMrlkyKQUCQ7s+zStBd858S30Kvn2pUrYSHkbRivhexosX3yeIK+zvJE1tPyomxKCmeSftlhH6+pyCTf+DUkijMtSiazYhm47KpGW52QCKeN2D53OzyTR9538Jh4LLaZdpJ64qt8rI8HIIv8Hqu6yvlLOiXYlpic7lg3KNZ2W98t6vfA58Z5j/XnWQkOFTPyY85Np+Vu2rzKHKHWDFU1+7ZtsK+u8RiX7zX9VKOaSJMf/tmddx0gv6LMvUNnw9tuYwGIfTkAUzQXOzHht3lDhUiU/CG0UEmwpO2zCG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39840400004)(376002)(366004)(396003)(26005)(86362001)(16526019)(36756003)(2906002)(53546011)(8936002)(956004)(478600001)(316002)(52116002)(186003)(4326008)(31686004)(31696002)(54906003)(66946007)(2616005)(16576012)(6486002)(66556008)(5660300002)(8676002)(83380400001)(110136005)(66476007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: k7QIbIHzWRrV5qA7/wXfe2zNdbGjdaKyOxDc7mgXBxeYFBppI190DyK+tWyV9P0FQi07IfvzSQH5DK99hK+qVccIJctEdkOAhRwpA5zOh8b0DSamncxQoPJ/0y0ok0WL6QR/fqDNqgp7j7WIOqMSjtm6p6rsduJMeCHh7GHQ0D1qQMSrA/Zrhv6sxI4ythXsXaghCDkK7etgU8I0bxCx66mIij4UBHFH8uIcCe0zsoS0oifiamBublnXO1QHz2RUa8oFHtgOt+PNBwzVlmbl4T6ZgaNVpRL832gmp2yqdZRvMP9A+tvECsHiV7xDXd9BJkQz/uCrX7AqqgyXAFvJVd6fJIdbxz2sVZ1oOb+ez4njcnUdiMqLeLPLwmk9xnDZddFUkBOeCQw61ETQKZMvnzjOB4QkaP+QkOqdO6ChgkOBq2Ql4wPgJdHkGhRzcRM0UzWiVXpboCXgNy9BW/dikXOdLSAy9naW41uEFMxIIgK0/DhOLpCVYnupusFtMSc1eV8zlWLdimTt1zYH/ZXFJg4cIzOEfyb3T8OTfSpKtCa3mbH/I0d8lCCSC5ry2gt5nrytE5PRU5c0UNNYmT8VtVI8F1Bd/Qlg8uiej4PZuzjY2L29FI+WeVREjxTbJAoKiY3/MWHIiiUNddr2fsGndA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f3c74e-9782-4a8b-cdee-08d845103a14
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 13:52:07.0106 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+u/fiA3KBCRaq+J/EbZPnGUzeYZlYcPZB/vYmQH8bNTHVau7bQA7DYnS874lFDhm1Ejx6DHQOalqFDb9Z199Jg9t5Wib6Gh3Adj+A8kJcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3158
Received-SPF: pass client-ip=40.107.20.132;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 09:52:08
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.08.2020 16:17, Max Reitz wrote:
> On 20.08.20 03:58, Eric Blake wrote:
>> On 8/18/20 8:32 AM, Max Reitz wrote:
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>>    tests/qemu-iotests/300     | 595 +++++++++++++++++++++++++++++++++++++
>>>    tests/qemu-iotests/300.out |   5 +
>>
>> Rather sparse output (I hate debugging those sorts of outputs when the
>> test is failing).
> 
> Hm.  I don’t know, the stack trace usually gives a good idea and
> ./check -d gives QMP context.
> 
> The advantage of a sparse output is that we don’t need to adjust the
> reference output every time some optional field is added somewhere.
> 
>>>    tests/qemu-iotests/group   |   1 +
>>>    3 files changed, 601 insertions(+)
>>>    create mode 100755 tests/qemu-iotests/300
>>>    create mode 100644 tests/qemu-iotests/300.out
>>>
>>
>>> +        # Dirty some random megabytes
>>> +        for _ in range(9):
>>> +            mb_ofs = random.randrange(1024)
>>> +            self.vm_a.hmp_qemu_io(self.src_node_name, f'write
>>> {mb_ofs}M 1M')
>>
>> It turns out that the discard operation likewise dirties the bitmap, but
>> slightly faster (see edb90bbd).  We could optimize it on top, but I'm
>> not going to require a micro-optimizing to get it in.  The test takes
>> about 12 seconds to run for me, but you didn't mark it as such in
>> 'group', so that's good; but it turns up a problem:
>>
>> 300      fail       [20:55:54] [20:56:06]                    output
>> mismatch (see 300.out.bad)
>> --- /home/eblake/qemu-tmp2/tests/qemu-iotests/300.out    2020-08-19
>> 20:53:11.087791988 -0500
>> +++ /home/eblake/qemu-tmp2/tests/qemu-iotests/300.out.bad    2020-08-19
>> 20:56:06.092428756 -0500
>> @@ -1,5 +1,41 @@
>> -.....................................
>> +WARNING:qemu.machine:qemu received signal 11; command:
>> "/home/eblake/qemu-tmp2/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64
>> -display none -vga none -chardev
>> socket,id=mon,path=/tmp/tmp.qT831UThme/qemu-b-798452-monitor.sock -mon
>> chardev=mon,mode=control -qtest
>> unix:path=/tmp/tmp.qT831UThme/qemu-b-798452-qtest.sock -accel qtest
>> -nodefaults -display none -accel qtest -blockdev
>> node-name=node0,driver=null-co -incoming unix:/tmp/tmp.qT831UThme/mig_sock"
>> +.............FE.......................
>> +======================================================================
>> +ERROR: test_migratee_bitmap_is_not_mapped_on_dst
>> (__main__.TestBlockBitmapMappingErrors)
>> +----------------------------------------------------------------------
>> +Traceback (most recent call last):
>> +  File
>> "/home/eblake/qemu-tmp2/tests/qemu-iotests/../../python/qemu/machine.py", line
>> 435, in _do_shutdown
>> +    self._soft_shutdown(timeout, has_quit)
>> +  File
>> "/home/eblake/qemu-tmp2/tests/qemu-iotests/../../python/qemu/machine.py", line
>> 415, in _soft_shutdown
>> +    self._qmp.cmd('quit')
>> +  File
>> "/home/eblake/qemu-tmp2/tests/qemu-iotests/../../python/qemu/qmp.py",
>> line 266, in cmd
>> +    return self.cmd_obj(qmp_cmd)
>> +  File
>> "/home/eblake/qemu-tmp2/tests/qemu-iotests/../../python/qemu/qmp.py",
>> line 246, in cmd_obj
>> +    self.__sock.sendall(json.dumps(qmp_cmd).encode('utf-8'))
>> +BrokenPipeError: [Errno 32] Broken pipe
>> +
>> +The above exception was the direct cause of the following exception:
>> +
>> +Traceback (most recent call last):
>> +  File "300", line 76, in tearDown
>> +    self.vm_b.shutdown()
>> +  File
>> "/home/eblake/qemu-tmp2/tests/qemu-iotests/../../python/qemu/machine.py", line
>> 465, in shutdown
>> +    self._do_shutdown(timeout, has_quit)
>> +  File
>> "/home/eblake/qemu-tmp2/tests/qemu-iotests/../../python/qemu/machine.py", line
>> 438, in _do_shutdown
>> +    raise AbnormalShutdown("Could not perform graceful shutdown") \
>> +qemu.machine.AbnormalShutdown: Could not perform graceful shutdown
>> +
>> +======================================================================
>> +FAIL: test_migratee_bitmap_is_not_mapped_on_dst
>> (__main__.TestBlockBitmapMappingErrors)
>> +----------------------------------------------------------------------
>> +Traceback (most recent call last):
>> +  File "300", line 384, in test_migratee_bitmap_is_not_mapped_on_dst
>> +    self.migrate(False)
>> +  File "300", line 99, in migrate
>> +    self.assertEqual(self.vm_a.wait_migration('postmigrate'),
>> +AssertionError: False != True
>> +
>>   ----------------------------------------------------------------------
>>   Ran 37 tests
>>
>> -OK
>> +FAILED (failures=1, errors=1)
>>
>> I'm not sure why I'm seeing that, but it looks like you've got a bad
>> deref somewhere in the alias code.
> 
> Ah, crap.
> 
> This should fix it:
> 
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index 89cb16b12c..d407dfefea 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -1091,7 +1091,9 @@ static int dirty_bitmap_load_header(QEMUFile *f,
> DBMLoadState *s,
>               } else {
>                   bitmap_name = s->bitmap_alias;
>               }
> +        }
> 
> +        if (!s->cancelled) {
>               g_strlcpy(s->bitmap_name, bitmap_name, sizeof(s->bitmap_name));
>               s->bitmap = bdrv_find_dirty_bitmap(s->bs, s->bitmap_name);
> 
> 

That's correct thing to do

> I had this originally, and then I decided to drop that hunk just before
> sending v4 because I couldn’t see the point.  But we need it, because if
> the bitmap alias is unknown, the migration is cancelled, so we need to
> re-check s->cancalled after the alias lookup block.
> 
> Would you be OK with squashing that into patch 1?
> 

Ok for me.

-- 
Best regards,
Vladimir

