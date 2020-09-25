Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEA7C4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:51:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2062820936
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="A9XY+qSI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2062820936
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLjRV-0007z8-45
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 04:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLjQ7-0006Ir-Aw; Fri, 25 Sep 2020 04:49:35 -0400
Received: from mail-eopbgr20121.outbound.protection.outlook.com
 ([40.107.2.121]:43758 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLjQ4-00055u-Mo; Fri, 25 Sep 2020 04:49:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0CfUHt6BKSPZCgqE+uTwxG9sZEPIzDN9UO+jlV5fqe4PHVsJ9ZFOTljRROQVV9Hac6l7vxYF50CzsFffumBPtktRixKnwIbpYuk1tY8BW+Y+e6P1lMqLKTJUp7ph1uCYXmFr9o7WI/O0Fa/9aWfQX9eKdy2Hibg3NvMSHz6f39cfartOrhWJoqHqjcD/9vD+23fL0tcjMa8ZXD+F7WS4Hj8+2c/N6PjCxAh2J24ClwKfbkScfch94tFAmfx2uz6GbT5dddgmpeS55/SPwKdwmTDZfiJ0FrjiawemM5n4wPgGceo+2d3wKTEnbnGje/g7rt3lC4ZVosllPc00Ln41w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8MV5R3Vsy+iqNN2DNi3hJN2WJrvV697vAunxjs1P8s=;
 b=atXFbpbxJhQr+1cxJASvv7JpvfYrhFWwCx+E/Xsq0seVsGmLPn6Bi8S1EC+kb4WKUMz/mkOt8LQwRxse9Vu4l9cRpwRXRl3HcYAgw4YSB0oqwnK8cEct1wIYRuqcY6sXsTu7rcpGvQwH9rNxQ6+fQzjna3N3O5j7Mepuc34rZQDwvdEZtyIGjJZpecT5/7ADBm1Qg1/JY+KQzKofnJ6eG+TQquQHYVwEbDuCp0coU/pFliPPTp6EAjTe7SplsA9wDM5nbS0yEBOxdU98+00T+FWGvfu6fzehtTZPwonNEBODbyHmMmSmZ2E5rB00KhXLiFse9zEBEBkFfdmjtE9eCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8MV5R3Vsy+iqNN2DNi3hJN2WJrvV697vAunxjs1P8s=;
 b=A9XY+qSIU3H3STZGMzV7vCFp4mIuHSXUr03QZAATa7BZtnZxvZH39+XsaD1I2OemtlwqaTRgztn0E+NC2W8fC1/QtiOwtl9LR8abVgH/0UxAB6nPnQRZTK4PaeRxX0Assz64nm8XQMAGrluq5gZiJFSuz/Up2190CSDCk2qd1W8=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2418.eurprd08.prod.outlook.com (2603:10a6:203:9f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Fri, 25 Sep
 2020 08:49:29 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Fri, 25 Sep 2020
 08:49:29 +0000
Subject: Re: [PATCH v6 11/15] iotests: add 298 to test new preallocate filter
 driver
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 fam@euphon.net, stefanha@redhat.com, kwolf@redhat.com, den@openvz.org
References: <20200918181951.21752-1-vsementsov@virtuozzo.com>
 <20200918181951.21752-12-vsementsov@virtuozzo.com>
 <1d202398-7a0e-9e72-6f9d-c04b7f887a0a@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <33d1a996-f212-eac7-ab78-659a4025c069@virtuozzo.com>
Date: Fri, 25 Sep 2020 11:49:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <1d202398-7a0e-9e72-6f9d-c04b7f887a0a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0008.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::18)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.94) by
 FRYP281CA0008.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.14 via Frontend Transport; Fri, 25 Sep 2020 08:49:28 +0000
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45984944-89c9-4d64-1bd0-08d8612fea2d
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2418:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB241899856091A3A38AF8F43CC1360@AM5PR0802MB2418.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WdvUtxv9ZYN0AFmxZ7+ZBfX7llm6LUaYSjQzwkQCYFnkT5kFLg0SV5keEExN/xHoQ7W0Hq97ZI6Tx8xVmnPCi2oOnujEunsqTRftXAzSEzxXJnMzGU1TfJ0b5NGjLDNqCl5Bn/OGPg3iliBnGZehV2+WX6SdrqVXH4+ZtSEO7NEw6aJksLUL9IlTXKXLjESKB4VXVkYgv1j1yHqOXO9kfD0m5+Ao/OCd9OQkH913S3fx5Ws4Cbk34NiRWYIrsaL1ozxW8DVp1N/Wd8RqpI/GtYHZmy0XPzW7fTmfS8ORdPM3LcmsiCLmVaeWTJDd9FQk0JPidhtEPDB+LBPMu5wW3qhQ+HtUSlUnkEQPr8npyn1B8znaTba8t6FNWfTZQCIYa4bKI5HL9uLRdv+/oGr0uRfuZ4Ai46sPqIb90OhTfiOZMjMjapiPOoggrMv8tlPl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(396003)(376002)(346002)(136003)(366004)(66946007)(66556008)(478600001)(8936002)(4326008)(2616005)(956004)(8676002)(66476007)(107886003)(36756003)(6486002)(86362001)(16576012)(316002)(2906002)(5660300002)(83380400001)(31696002)(31686004)(186003)(16526019)(26005)(53546011)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: kZgi9IUwM96+36houIM0aYd12PlkIq576vzauhzTnSUT6ulBF3m/CouaBUOk+im6mNiE31W1361gkrUUJfrmoF+DrTqVwOaLse4dQmv73oPcluWuLwxLLPcObHYu4VL38t0N8BrYTmwwoZZhApLyVpLmj3X9YpZyVN+cIo5DjyxuakvQH6FV09235/pL0ZrtyYr+sgjPeOQpi5+rmh4uEykx92h+pdBph37/Lw6LVQ5eA1LnTuRKPfHSQhWEXFTbPv1k1M1FtLaqAjhgKB2Ka0itVBJYr/e/JJD885Gg/hJ04LLca2nd1YTwS2ZxOkDu4Ti6xl8r+CoK21dhYOWaL57Kj1upoWMLK+et8FBwFBFiPm1Uj9jxQ6L0hG2DWLab6/+Aw6VQxHT48RND+cSsF3fFksQ4JJX+qHj6iSyN1CH5MKIRVyBkZJOqQuUamhuCf3Ah056GT1djcLVAgR5TK94q4FC88KXxJ3pOZnk4JcI4WDNCIVTG4l2yhF97Mx6oZ3KKmz7p0H2RhzVgmjTMmQ4iB5qaQD+e//sH5BLyqmUpkI/bZWggXsYZ6G9OUiE2od/wFuZ7rFRtDNH8lTQlml2yYjMhMOucAkUaN4T1JrHv7+S1ABPTJVCFGkH7wPbQWCgPUvziCdrx8SSS+t1ccA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45984944-89c9-4d64-1bd0-08d8612fea2d
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 08:49:29.4670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z8EfpGJDRI2KVYZkg2RK0NvlpW0h58kBDXZlHx8mabNkItKQoy25KhAQIGWp5/vYPUhkfdUi/Rciko6NkGLmNc0oPH2bv8ScBoK/dT2xZXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2418
Received-SPF: pass client-ip=40.107.2.121;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 04:49:30
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001,
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

25.09.2020 11:26, Max Reitz wrote:
> On 18.09.20 20:19, Vladimir Sementsov-Ogievskiy wrote:
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   tests/qemu-iotests/298     | 186 +++++++++++++++++++++++++++++++++++++
>>   tests/qemu-iotests/298.out |   5 +
>>   tests/qemu-iotests/group   |   1 +
>>   3 files changed, 192 insertions(+)
>>   create mode 100644 tests/qemu-iotests/298
>>   create mode 100644 tests/qemu-iotests/298.out
>>
>> diff --git a/tests/qemu-iotests/298 b/tests/qemu-iotests/298
>> new file mode 100644
>> index 0000000000..fef10f6a7a
>> --- /dev/null
>> +++ b/tests/qemu-iotests/298
> 
> [...]
> 
>> +class TestPreallocateBase(iotests.QMPTestCase):
> 
> Perhaps a
> 
> @iotests.skip_if_unsupported(['preallocate'])
> 
> here?
> 
>> +    def setUp(self):
>> +        iotests.qemu_img_create('-f', iotests.imgfmt, disk, str(10 * MiB))
> 
> [...]
> 
>> +class TestTruncate(iotests.QMPTestCase):
> 
> The same decorator could be placed here, although this class doesn’t
> start a VM, and so is unaffected by the allowlist.  Still may be
> relevant in case of block modules, I don’t know.

Or just global test skip at file top

> 
>> +    def setUp(self):
>> +        iotests.qemu_img_create('-f', iotests.imgfmt, disk, str(10 * MiB))
>> +        iotests.qemu_img_create('-f', iotests.imgfmt, refdisk, str(10 * MiB))
>> +
>> +    def tearDown(self):
>> +        os.remove(disk)
>> +        os.remove(refdisk)
>> +
>> +    def do_test(self, prealloc_mode, new_size):
>> +        ret = iotests.qemu_io_silent('--image-opts', '-c', 'write 0 10M', '-c',
>> +                                     f'truncate -m {prealloc_mode} {new_size}',
>> +                                     drive_opts)
>> +        self.assertEqual(ret, 0)
>> +
>> +        ret = iotests.qemu_io_silent('-f', iotests.imgfmt, '-c', 'write 0 10M',
>> +                                     '-c',
>> +                                     f'truncate -m {prealloc_mode} {new_size}',
>> +                                     refdisk)
>> +        self.assertEqual(ret, 0)
>> +
>> +        stat = os.stat(disk)
>> +        refstat = os.stat(refdisk)
>> +
>> +        # Probably we'll want preallocate filter to keep align to cluster when
>> +        # shrink preallocation, so, ignore small differece
>> +        self.assertLess(abs(stat.st_size - refstat.st_size), 64 * 1024)
>> +
>> +        # Preallocate filter may leak some internal clusters (for example, if
>> +        # guest write far over EOF, skipping some clusters - they will remain
>> +        # fallocated, preallocate filter don't care about such leaks, it drops
>> +        # only trailing preallocation.
> 
> True, but that isn’t what’s happening here.  (We only write 10M at 0, so
> there are no gaps.)  Why do we need this 1M margin?

We write 10M, but qcow2 also writes metadata as it wants

> 
>> +        self.assertLess(abs(stat.st_blocks - refstat.st_blocks) * 512,
>> +                        1024 * 1024)
> 
> [...]
> 
>> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
>> index ff59cfd2d4..15d5f9619b 100644
>> --- a/tests/qemu-iotests/group
>> +++ b/tests/qemu-iotests/group
>> @@ -307,6 +307,7 @@
>>   295 rw
>>   296 rw
>>   297 meta
>> +298 auto quick
> 
> I wouldn’t mark it as quick, there is at least one preallocate=full of
> 140M, and one of 40M, plus multiple 10M data writes and falloc
> preallocations.
> 
> Also, since you mark it as “auto”, have you run this test on all
> CI-relevant hosts?  (Among other things I can’t predict) I wonder how
> preallocation behaves on macOS.  Just because that one was always a bit
> weird about not-really-data areas.
> 

Ofcourse, I didn't run on all hosts. I'm a bit out of sync about this.. If I don't put new test in "auto", is there any chance that test would be automatically run somewhere?


-- 
Best regards,
Vladimir

