Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC25C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 06:25:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE51D206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 06:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ep0SReSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE51D206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeByt-0007jG-VI
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 02:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeBxz-0007AJ-MA; Thu, 28 May 2020 02:24:35 -0400
Received: from mail-eopbgr80117.outbound.protection.outlook.com
 ([40.107.8.117]:53634 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeBxw-00024H-1a; Thu, 28 May 2020 02:24:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItBjp88GK3qtsHcfv1+WWWck19drfI+lcAtEkfMu2SKxl6R+jzv0s/nNRUgFrZvpHzaO81v+WG807k9YZIqyfBKskUF4apdlrwKhdIYJbFzqRppkKY6AHWuxBLZcIruH4wDuMgnsdCxuHeiEAdWluiml4DsvULzVV7AHTm63I8qsjkA5kfVqcclD41VRtrc0++uO4g8KMXJTaBLmK9Ny9qd9gQYylgIz+V1K55iOUNC31uA6fPJl5H5kj/ZTh1ITnH7B6FxSyP1AnlIDGUl6QcfRTjHFrXf5U96EB0plm/OyXIQMB6NRl5g9vaeSDMqsvE2TGkbzRp6+kxAPwaZWaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLUCRp1YhCYPAGcZXcGDl1Q80R1M7xMEzATyiUGuPW8=;
 b=fHCs8pu7e9hYuBXHjPorFv34vooHzoH+zqlJXqBE5vsMmMnn5dWiWkguwFCQYdf+scE5iJetoKvAfIOwC4bHMQwq9a5OPPItcC4Rvy9uX9Cy/nZVCqrwBdzHSeusv0FxVrCj8fx5geSanlc/ZRkZ5DDZ48mFjUYpOZnT1xob3ejA7gLxNZvRAOseAI+jLtNdm81I88DxO7MuyBIo4t5Nx8mV77J3bqBbd3C9nQW0berGfneN9KK6XcRyvxGKDESdypG3sXTjWlSsWlMMk8OGEVmyYw5+2tuCKGEgaev5pPYoeelruyyc/IaVGmyKFlvTTIBtdY+jnkowHjDy7ejgiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLUCRp1YhCYPAGcZXcGDl1Q80R1M7xMEzATyiUGuPW8=;
 b=ep0SReSm+pGPXb+nVkmEBteroObWEnjN7XWcCcOR15AAIYh3oY9eEZp4kuc6Yb2JM7nMJFCwcymk/QCKJR4pALX+6iyjhbZnLTbtl1Uf+v0MYmksE40k7JVayZzJY5mE5lWLbnOCv66csL6iTM9/ICEzrnFSLtcsDQA3AmnRrWU=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5463.eurprd08.prod.outlook.com (2603:10a6:20b:106::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Thu, 28 May
 2020 06:24:28 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 06:24:28 +0000
Subject: Re: [PATCH v5 0/7] coroutines: generate wrapper code
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <159061599705.16318.11961887809600256765@45ef0f9c86ae>
 <4a4d5dc4-4cab-ad59-a4d3-6f84de1aa1e3@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <dca82885-3a38-3c32-7915-0291c4642888@virtuozzo.com>
Date: Thu, 28 May 2020 09:24:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <4a4d5dc4-4cab-ad59-a4d3-6f84de1aa1e3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR05CA0007.eurprd05.prod.outlook.com (2603:10a6:205::20)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.178) by
 AM4PR05CA0007.eurprd05.prod.outlook.com (2603:10a6:205::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.17 via Frontend Transport; Thu, 28 May 2020 06:24:27 +0000
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b193b0b-557a-4e96-2e17-08d802cfc611
X-MS-TrafficTypeDiagnostic: AM7PR08MB5463:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5463B715759233C29D89191BC18E0@AM7PR08MB5463.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E3jnsCInJBqS4IObMcopllJkMBNIVQz3z3vuPSmn7Kuo4uaEIxBM/aYpxw/1Zhx5Co5+Zvsk+rwIIBM1wb13oGdS6gSkOIxrMxAK/h6vZvzgo2uGLUcgmL0pcQ3MNs8sy07u5/j7bCHLU9gWmtpTHrHaC1svWvEyfPxsXCgssWyKbF1kvPK3UzK9rx3bq9x/C4Hst0QlorTYp+OgaG61TJcbD+ubP1LVuajXT9vHDFld7ExDUi+7PahTYreOk1j79ps+tNkkkoKQ5x0NSYGJrLSFZBu0Arwn8KrVcUWq7WpfYEeOxhGpbp0PQ3JNvUl3lODzyIE23+zgSNblMuHfoNwctY512ftBSY8NCKuj6W6Ta2vGPHxYvR/RPW71xDKbO3fJLoXCQIC8nvoiyfNCoNDDebarRXvw073dyjarp38LAUb1CLtQKzjp9rSxI51jn/qhV9veH0J0q5UaXu4nwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(396003)(39850400004)(346002)(366004)(6486002)(8936002)(31686004)(4326008)(186003)(956004)(16526019)(107886003)(316002)(66946007)(66476007)(66556008)(2616005)(16576012)(26005)(5660300002)(83380400001)(53546011)(31696002)(2906002)(966005)(52116002)(86362001)(36756003)(8676002)(478600001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: x6DKu7IHzfC2Cgq0GC+W1X+/woZJbAY4qDXTHndHjHHWIpaBddyUw/dYAPXFQYInttks04ggoNFFZ+oGC9l5pgtc9kzLVfeNu3DY2dHLPgqXy9p8ayxi5jXb22DVJm2Q3hasHqxU0WBHMFjkjti5UUpOSJ2EuEZfXZI2ib/2SK8Mo18dCJaH1RkLEsh40CnHuBW5OJwcmTJ86hN03XIAclLUoblw8hDN8Xi07HfrN7ABvsBtgZkm1ju++VOALJN9EeSaqViavaQFF76FQBSDcyjDxvirm38VkCLdIFQr/QTETKgP+e52+uYlLxNFLYg9Tlg8HCuydr8rmrr89f/uRPL7gybVpOoYCDND1JWK9yi2KE04poUekm+cIu4RAEcnJIeXmU71zsKL43cbq+RxnklTXzhi5Y3GMRbTyUZMozLm2pxWBvkoEUvHp/JUlX7OW5/IJi2YUbwyw5tHX7m1gbt43yKybmkGPu2szwRZUn758zxZ2fGqRjSCLJ0Ya65q
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b193b0b-557a-4e96-2e17-08d802cfc611
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 06:24:27.9436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aCEZOVx1kGXsABWabOdDFa4i4CRbECgAHsvgTnj92QXG0lw1zN6Nvuz/5f7VJ2in6aMkrr2eeiIcCx/16000l0bfvQn7TMNERdEFp9skB/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5463
Received-SPF: pass client-ip=40.107.8.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 02:24:28
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
Cc: kwolf@redhat.com, fam@euphon.net, ehabkost@redhat.com,
 qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

28.05.2020 00:57, Eric Blake wrote:
> On 5/27/20 4:46 PM, no-reply@patchew.org wrote:
>> Patchew URL: https://patchew.org/QEMU/20200527203733.16129-1-vsementsov@virtuozzo.com/
>>
>>
>>
>> Hi,
>>
>> This series failed the docker-quick@centos7 build test. Please find the testing commands and
>> their output below. If you have Docker installed, you can probably reproduce it
>> locally.
>>
>> === TEST SCRIPT BEGIN ===
>> #!/bin/bash
>> make docker-image-centos7 V=1 NETWORK=1
>> time make docker-test-quick@centos7 SHOW_ENV=1 J=14 NETWORK=1
>> === TEST SCRIPT END ===
>>
>> TypeError: __init__() got an unexpected keyword argument 'capture_output'
>>    CC      /tmp/qemu-test/build/slirp/src/bootp.o
>>    GEN     ui/input-keymap-usb-to-qcode.c
>> make: *** [block/block-gen.c] Error 1
>> make: *** Deleting file `block/block-gen.c'
>> make: *** Waiting for unfinished jobs....
>>    GEN     ui/input-keymap-win32-to-qcode.c
> 
> The more interesting part of the failure:
> 
>    File "/tmp/qemu-test/src/scripts/coroutine-wrapper.py", line 173, in <module>
>      print(gen_wrappers_file(sys.stdin.read()))
>    File "/tmp/qemu-test/src/scripts/coroutine-wrapper.py", line 169, in gen_wrappers_file
>      return prettify(res)  # prettify to wrap long lines
>    File "/tmp/qemu-test/src/scripts/coroutine-wrapper.py", line 40, in prettify
>      encoding='utf-8', input=code, capture_output=True)
>    File "/usr/lib64/python3.6/subprocess.py", line 423, in run
>      with Popen(*popenargs, **kwargs) as process:
> TypeError: __init__() got an unexpected keyword argument 'capture_output'
> 
> which indeed looks like a bug in the patch.
> 

Ah, yes, capture_output is since python 3.7.

So, s/capture_output=True/stdout=subprocess.PIPE/ .

-- 
Best regards,
Vladimir

