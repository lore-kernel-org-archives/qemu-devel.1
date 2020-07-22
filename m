Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66813C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 15:48:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30DAE2065F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 15:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JmM0z+iW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30DAE2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyGzE-0004Cy-ER
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 11:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jyGyJ-0003L1-4j
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 11:47:56 -0400
Received: from mail-eopbgr130123.outbound.protection.outlook.com
 ([40.107.13.123]:24452 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jyGyF-0007Li-EQ
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 11:47:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzTtUTJO/CtS+jtu6s+Ja3uoVntDdNXJMMDxJSmIej31INGABTevfQn+7I8A/Vcozg3C0M/wkYwYB47HRVpqOvmDXNV8XG3FNEzTT1FL8YLYD5Em94e+aqWFOEYNKrsSCTd6lmMnlfaEnKfryE9V3+J1lksUG7ZpniGGw/dThtCavvAj3VMBHwl6gRl54pd1to63MGWDEnUZtfw1C0zKrYBWaTZAb46KyWeRFG5ZbXDvjOSy+gU9YZKqxshE68rgfJbn9g94zWfvzyrCulZUvU90sFs8TvTYcWSK0sLcTwVkeQUOdhFKneSTymdr0rWP1o8qOLX4X9w4pH4akXUk6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGQaLVm/wwfsv7kZeznK1E/Fz0QLgFgbUHGKbcOWmJc=;
 b=TJKirXuaeTWEk7EyPrx8hiNHdT0lqtJv9onv6NZ50Gk7w0iUZ7odmnyTF0rb3r7XzCWoTIbaYMBO+RCGQ0lqI96KApa7yqyXRgHxTGD2rmV44sFwR9hhuy3WuMcUF8y1l476pZ02Fd46PBHedCCLixEK2PZIBsMygLxe8Q+v6g/OKiyuD5IRJXtQKnrPkpUcTuD0WdNJC6hr2q/tkGFuuCn9t3WOgr6lgfnLvi1LXEcu7mq3aiMngQd0VFwKRX5+pzDTFw9sef2E6F1dYD6fPBGdXT4ctBW8RtDi5/0F1vwXO/z+TGkc+/ZeoR08SLyi6pHArNRcUwysh2lfhjGKNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGQaLVm/wwfsv7kZeznK1E/Fz0QLgFgbUHGKbcOWmJc=;
 b=JmM0z+iWnF/ZqbsdPDRswDnNw+srTpBIaPmeBJARBR2uRxECqc7G/MN/NdamUCPp2ky5NfNga7kjEOqJRMo9nsaCByztKc331FsQB9HBFaUrQzfJQt4Iy/zVvy3bRrQFc0fSATUESMW7TI7/jM10ofz4wU9JTZSie/w/wf6su1Y=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (2603:10a6:208:ff::27)
 by AM0PR08MB4321.eurprd08.prod.outlook.com (2603:10a6:208:137::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Wed, 22 Jul
 2020 15:47:47 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5d21:ce58:6f11:b5dd]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5d21:ce58:6f11:b5dd%7]) with mapi id 15.20.3195.025; Wed, 22 Jul 2020
 15:47:47 +0000
Subject: Re: [PATCH v0 0/4] background snapshot
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Peter Xu <peterx@redhat.com>
References: <20200722081133.29926-1-dplotnikov@virtuozzo.com>
 <20200722145034.GZ535743@xz-x1>
 <8146768f-7804-e239-41a0-3f7997f6b75d@virtuozzo.com>
Message-ID: <bf3fd4f4-31a1-9d13-94b0-e3b026edb6b1@virtuozzo.com>
Date: Wed, 22 Jul 2020 18:47:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <8146768f-7804-e239-41a0-3f7997f6b75d@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::24) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.102] (5.138.110.191) by
 FR2P281CA0014.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.17 via Frontend Transport; Wed, 22 Jul 2020 15:47:46 +0000
X-Originating-IP: [5.138.110.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f95b60f7-0ce1-4b78-38d6-08d82e569488
X-MS-TrafficTypeDiagnostic: AM0PR08MB4321:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB432150BA1ECA0BE37766D6B6CF790@AM0PR08MB4321.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CUsLUpP/CycjwTW2MvMmJgAsI0ibCPCPJK5mxsCTrwSOx7YdN0xp4ddfMK+GVlmeegmz88cR5z5eGBiKu0fPuwvfXdwdU2r4eRB72A/UTRJpGtWoYgv0fXvUFiCpfc4t73dwtR6+gD0wf38Rj90e+cRPIA7GBSspslNNiCIf8Xb0W5kGPdGg62ukD+IRQVPvPXeLQWZtdGlayPWFxrwXg9gny3npnYXyVMVJvPy91Xec5jF3DGX7lKgbgTN3FGKNu2cY71N9DriX3bxRXBE9Z4qQCwEAA3LywhN1Rpc3QB/8aqJOP+1judx8kEQpa8oBhICIXiRgoukESh7acr/Ig27GKzfNhtHlk0OMTQRiQ1zrzhRh+amJXPDEpc5r9k8V
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB3745.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(346002)(376002)(136003)(396003)(366004)(956004)(8936002)(4326008)(186003)(2616005)(16526019)(26005)(53546011)(31696002)(36756003)(8676002)(478600001)(6486002)(86362001)(5660300002)(83380400001)(31686004)(16576012)(66946007)(66556008)(66476007)(52116002)(316002)(6916009)(2906002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: xNZQ1DgxZFLZmUcW5K1D2f5cq0c639OY3nroIE8IYpSSzEj5mqZaHN/lRp0x2Y78df2mBjhe0/x+C8iEoK8slihQJQ8FfeVkeACEgUrk6aU7b+3WRZL/A9c/ZY5IrDu0R8bU/53NRadTdpGpj5S+EzXLNIyrUwmh6Jv7pgpUo3cRIZoAz/OWJDDl6+gxD1TxX1WFIWBDBKCXmKRx5BQI+cqZcxPkTenGm21ur6W8aGnL/Amy8jQbih8WYHxKNE4AnpQsCVMLlhBP+vS6Qfic6kEO9yDcHwNAgri1SX7tprs2iSaX8FmoeNfRMHsQbKgl/yBs+MeSUICxHNt1heaK0WUhIco9pVzqxUp7dE6ulV3z5nK3t+DFc4Cway2a7V9f/N7LtAk/CsTQO72B6IfOEX2nF/xVzdbxMvgU0w7N2qD7SS4qsNRYy2pld0Jt3j5wNdOX3xtD09v1m+nlP5ybxggGqRkL/qOcXBz1qNO5Pt4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f95b60f7-0ce1-4b78-38d6-08d82e569488
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB3745.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 15:47:46.9424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2JYnmoJ84a732Q5WHBEs97QQDz9bUwZi1+0g7L6jg04n6w9gmip6/qi7Tt0J9aeQm9X/5JVstFoykT4anLFjdIEdz1F0DMrF05um5rmG/rs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4321
Received-SPF: pass client-ip=40.107.13.123;
 envelope-from=dplotnikov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 11:47:48
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
Cc: quintela@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, den@openvz.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 22.07.2020 18:42, Denis Plotnikov wrote:
>
>
> On 22.07.2020 17:50, Peter Xu wrote:
>> Hi, Denis,
> Hi, Peter
>> ...
>>> How to use:
>>> 1. enable background snapshot capability
>>>     virsh qemu-monitor-command vm --hmp migrate_set_capability 
>>> background-snapshot on
>>>
>>> 2. stop the vm
>>>     virsh qemu-monitor-command vm --hmp stop
>>>
>>> 3. Start the external migration to a file
>>>     virsh qemu-monitor-command cent78-bs --hmp migrate exec:'cat > 
>>> ./vm_state'
>>>
>>> 4. Wait for the migration finish and check that the migration has 
>>> completed state.
>> Thanks for continued working on this project! I have two high level 
>> questions
>> before dig into the patches.
>>
>> Firstly, is step 2 required?  Can we use a single QMP command to take 
>> snapshots
>> (which can still be a "migrate" command)?
>
> With this series it is required, but steps 2 and 3 should be merged 
> into a single one.
>>
>> Meanwhile, we might also want to check around the type of backend 
>> RAM.  E.g.,
>> shmem and hugetlbfs are still not supported for uffd-wp (which I'm still
>> working on).  I didn't check explicitly whether we'll simply fail the 
>> migration
>> for those cases since the uffd ioctls will fail for those kinds of 
>> RAM.  It
>> would be okay if we handle all the ioctl failures gracefully,
>
> The ioctl's result is processed but the patch has a flaw - it ignores 
> the result of ioctl check. Need to fix it.

It happens here:

+int ram_write_tracking_start(void)
+{
+    if (page_fault_thread_start()) {
+        return -1;
+    }
+
+    ram_block_list_create();
+    ram_block_list_set_readonly(); << this returns -1 in case of failure but I just ignore it here
+
+    return 0;
+}

>> or it would be
>> even better if we directly fail when we want to enable live snapshot 
>> capability
>> for a guest who contains other types of ram besides private anonymous 
>> memories.
>
> I agree, but to know whether shmem or hugetlbfs are supported by the 
> current kernel we should
> execute the ioctl for all memory regions on the capability enabling.
>
> Thanks,
> Denis


