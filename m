Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829ECC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:30:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CC1C2072C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BYY26M0G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC1C2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb9oe-0004VC-BC
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 17:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jb9kL-0007kU-08; Tue, 19 May 2020 17:25:57 -0400
Received: from mail-vi1eur05on2138.outbound.protection.outlook.com
 ([40.107.21.138]:4552 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jb9kH-0006EB-Nl; Tue, 19 May 2020 17:25:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gklW617YPaMCeokoxzrM80AE5J6yDOfciXQg0o/hEQ4WHpMmACBp9oZ3NvsxYh6kJMVJPGJUqrGJCbLYNkeY1/n+N/i0MjoG8hOP+l8U7gWLGOZrOpxqjql2EgrZaC4Fjja5dJl7/NkgPzEmttv/64C6NLPz8BQbdcrDdmbYTG6WsmdN7YrO0zSVsdnF/fWL5+EZE0bdcN9E8FIZ17crb33Jq40SLc2NNktbYL7EGIld0c0+UdEAioEHd+rRTX+Er8+V8YNvZQtJ0fwLLpTR12pVGafJysYoX47AjppgIw+jmDPji1dv/93vlj6n67McRqN36wvLp7gRfcts79hsZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rIl7Oia0Ayo/hUn3kCY9Uamd4tQ2/9ti3fwG8CCqdg=;
 b=VK1IG7i6EOwV2qnHrdUnT4GJ8gic5IR9gxba7qKRUNBhuJZizVF7/mbHDN/lwU8uh5aCGi7bXtSXdF3CCIE81UaHX/6a/n0gNJtY4U2xC1VxIYh5nvkcPbjNTR6xTZDCf+AwNajWMbGOGMnfxsFuGi9SHD98sg369+i5LmqBYvnjMIcTDxsfLIP77TDyhOx/0e36NFklhM3UAJOi++TUEC9yq4OHF3Ry2yx+SGMJSwFXf1MXnM2Zdr+S74osaQXLotsMMmAxiaDhPM8jTbs+vhzknU8JoLEf5pQ21M2BbfZKdXbPNEFK/PoE38om+m1a3WULoLylk+PNDIHpFv4rew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rIl7Oia0Ayo/hUn3kCY9Uamd4tQ2/9ti3fwG8CCqdg=;
 b=BYY26M0GSKDJsQFloCqEIiKkep5mzrM0ox7//k+IfjsS/XCt5XLU5NojGLLorOkayQuokbZHG2FD/fdf51//X/7T5ohNEm9Hn0m8OKc9QcXKhMK5fTDepxxT37qpnRDpJaoir615vYcKwHri6mQje3Y0Nbvt7YoZVazEiCIE+VU=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR08MB4221.eurprd08.prod.outlook.com (2603:10a6:803:b8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Tue, 19 May
 2020 21:25:48 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac%7]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 21:25:48 +0000
Subject: Re: [PATCH v2 5/5] iotests: add commit top->base cases to 274
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200519195501.29071-1-vsementsov@virtuozzo.com>
 <20200519195501.29071-6-vsementsov@virtuozzo.com>
 <b8b80d2b-492b-4121-a6eb-8a26aa0c70d4@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <506b90f3-2d40-168f-14f9-f5ab30c80535@virtuozzo.com>
Date: Wed, 20 May 2020 00:25:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <b8b80d2b-492b-4121-a6eb-8a26aa0c70d4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR05CA0117.eurprd05.prod.outlook.com
 (2603:10a6:207:2::19) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.178) by
 AM3PR05CA0117.eurprd05.prod.outlook.com (2603:10a6:207:2::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.25 via Frontend Transport; Tue, 19 May 2020 21:25:47 +0000
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e8e7bf0-1c10-452e-a83e-08d7fc3b32c2
X-MS-TrafficTypeDiagnostic: VI1PR08MB4221:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB4221F062D736AA3269DE9C49C1B90@VI1PR08MB4221.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UpA324AbyNNmZU7Cci9fME6f23YNTIGOdbgftuaNBaqCHnQQxSmNS5xdr07SHYeW7/fCGVLcVLVV0m2fudFkhiW/h4hOZwFjm3/Gi4/AKb4GiwSCjhfjvLTLGxbBSZRvnwbwilX8skxMlApwDVuvP6N8sRUxrksvKwnEWhbF2bM1f1UP08/575NbtqOL+CPOa2M7zvfK8e3HOgY8KyMyrtPXay4XOe1qpQf0IuDY+onLwLwv1EnvRM6WPc+ss1V6A17GYB4es75QwUf9Kb6OcFuLdWGAD0Qbqxx0aWoKTpQ3Ms6DgQCNd7AuNLPhXVmMksXHl/8VyFXAKMNQ4XlhNHEThCpuzQp1BulrJj7f+DyRZN726ax3vGzN1geXJ+5a3ZZQK43QI8ci3w5SRqb+nSqug4K8ruBKUVR8XGa8qX1uS3e3KSyuQsHIDeuH/H/O0CB81Dy8zWbDYSzY2D3BXEZXCjxyVWQv15aUet3ajpURVEja3LhkcQKt56aRw2Gh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(396003)(39840400004)(376002)(366004)(8676002)(31686004)(53546011)(2906002)(6486002)(2616005)(16526019)(956004)(66556008)(66476007)(66946007)(36756003)(4326008)(107886003)(316002)(478600001)(26005)(86362001)(5660300002)(8936002)(16576012)(31696002)(186003)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: c6XWjDZ+S/2D6C3+Ub2k5vJEaPho8AKOfPcUdAlo7Kr6zReN1K0Ec0osiwgY3zGIr6i9VQq6rqspUMIm6IAo9EWvHk8I2npNMwP5Qh+5e66Sj0EfwDZNkE+vmc7F+saAOAnSlpBr75na6n53q30ZCk15yiSplzISguDPULAoqur6Y4WzJN/RdiHgFSyWLXscYtZWOA1+YNV5+slwv55CmPPUn7EEPXxipdD3SHr6I8MQ7CHwidIHdNTEryWxv8XU5uE3ksy+IcaY8rsVdeQECqIqs3K7BZLzoed/bKBEDk5JTNBF8c45bGruyasoISLiREjlg1qOUzRpoL73O0SHgGH8OpUxS8XpAIv27bvHvrD5T7qOTlWDmHGLNSpPPZ/BsJlX41iOIuIdgNJhWolzBV1ocAakXT/KDrWpw/EjvXBkmLzxPocHwXKpZL3y53ABlZiBJEgATH+6sSj8H5Osir0lEIe1Bc4FAHHcAmG0DGDWtK6J7zmx+DL1ro1+Z5TP
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8e7bf0-1c10-452e-a83e-08d7fc3b32c2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 21:25:48.2730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G1WFJ4HkCUWjMm7tF1n/cw/FBj8tT+wTQThx5GaOQKvuDvT1ey6ZUMyqYBC0EjISOCr+1OxBWBMP4pM9frBFZV0ihYVMGIwk+d7CZFocel0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4221
Received-SPF: pass client-ip=40.107.21.138;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 17:25:51
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.05.2020 00:13, Eric Blake wrote:
> On 5/19/20 2:55 PM, Vladimir Sementsov-Ogievskiy wrote:
>> These cases are fixed by previous patches around block_status and
>> is_allocated.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   tests/qemu-iotests/274     | 20 ++++++++++++
>>   tests/qemu-iotests/274.out | 65 ++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 85 insertions(+)
> 
> Okay, so this test fails when applied in isolation without the rest of your series.
> 
>>
>> diff --git a/tests/qemu-iotests/274 b/tests/qemu-iotests/274
>> index 5d1bf34dff..e910455f13 100755
>> --- a/tests/qemu-iotests/274
>> +++ b/tests/qemu-iotests/274
>> @@ -115,6 +115,26 @@ with iotests.FilePath('base') as base, \
>>       iotests.qemu_io_log('-c', 'read -P 1 0 %d' % size_short, mid)
>>       iotests.qemu_io_log('-c', 'read -P 0 %d %d' % (size_short, size_diff), mid)
>> +    iotests.log('=== Testing qemu-img commit (top -> base) ===')
>> +
>> +    create_chain()
>> +    iotests.qemu_img_log('commit', '-b', base, top)
>> +    iotests.img_info_log(base)
>> +    iotests.qemu_io_log('-c', 'read -P 1 0 %d' % size_short, base)
>> +    iotests.qemu_io_log('-c', 'read -P 0 %d %d' % (size_short, size_diff), base)
> 
> So if I understand it, we are going from:
> 
> base    11111111
> mid     ----
> top     --------
> guest   11110000
> 
> and we want to go to:
> 
> base    11110000
> 
> except that we are not properly writing the zeroes into base, because we grabbed the wrong status, ending up with:
> 
> base    11111111
> 
> The status of top from 1M onwards is unallocated, and if we were to commit to just mid, Kevin's truncate fixes solve that (we now zero out the tail of mid as part of resizing it to be large enough).  But you are instead skipping mid, and committing all the way to base.  So we need _something_ that can tell qemu-img commit that even though the region 1m-2m is unallocated in top, we must behave as though the status of mid reports it as allocated (because when reading beyond EOF in mid, we DO read zero).  Since the data is allocated not in top, but acts as though it was allocated in mid, which is above base, then the commit operation has to do something to preserve that allocation.
> 
> Okay, you've convinced me we have a bug. > However, I'm still not sold that patches 1 and 4 are quite the right fix.  Going back to the original setup, unpatched qemu.git head reports:
> 
> $ ./qemu-img map --output=json top.qcow2
> [{ "start": 0, "length": 1048576, "depth": 2, "zero": false, "data": true, "offset": 327680},
> { "start": 1048576, "length": 1048576, "depth": 0, "zero": true, "data": false}]
> 
> I think what we really want is:
> 
> [{ "start": 0, "length": 1048576, "depth": 2, "zero": false, "data": true, "offset": 327680},
> { "start": 1048576, "length": 1048576, "depth": 1, "zero": true, "data": false}]
> 
> because then we would be _accurately_ reporting that the zeroes that we read from 1m-2m come _because_ we read from mid (beyond EOF), which is different from our current answer that the zeroes come from top (they don't, because top deferred to mid). 

Right. This is exactly the logic which I bring to block_status_above and is_allocated_above by this series

If we fix up qemu-img map output to correctly report zeroes beyond EOF from the correct layer, will that also fix up the bug we are seeing in qemu-img commit?
> 

No it will not fix it, because img_map has own implementation of block_status_above - get_block_status function in qemu-img.c, which goes through backing chain by itself, and is used only in img_map (not in img_convert). But you are right that it should be fixed too.

-- 
Best regards,
Vladimir

