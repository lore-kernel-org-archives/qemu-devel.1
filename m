Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D207C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 07:23:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C98D205CB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 07:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IcHEq/uD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C98D205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbJ4v-0002D3-Id
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 03:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jbJ4L-0001hc-U8; Wed, 20 May 2020 03:23:13 -0400
Received: from mail-eopbgr60137.outbound.protection.outlook.com
 ([40.107.6.137]:13006 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jbJ4J-0007eI-82; Wed, 20 May 2020 03:23:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUYdYkLa3TsDxFKaO718xB3MD3ZN4YXmq/RGwbLWj/Tkp8JEkZ4/k+EjaG9FKx6og14BzuAhDyStntB6KW8k8bdZwHiDtRcr4drZ1PuUaouvVVjbBvWxG1UVl8q3B4QUWAatDRgK0LsACrlC+2io+RTzrgL4Rgg7QFqOtkuVdrQjp3p16cPV4/rheW4E9Y3BtuPCDE2Lp0x1d+skRIdvUZcVj73w4M3eiez6ka27YZY9rsP5rxH3BElpLsh2s3UQMExe3zh70YIxZsO7mj5Odne2vWMH8TyEQ/XXLM1q2yzAKTLevKYT420Q2SjtWRItcRkR/CagKlN05kNqOoJreQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFFALVEIPAJVzq5LPJkPeB6ebHW15J7WyZtaTmsDLIY=;
 b=B3P/MRuKmORcVxsc5+WV2xSIg8XURKTZuk5Ha4YjupedcHsculJw/qb37+/PEqbcLvgFywD5knhiE1Ngpq0CEBHjvDFzrlhKhEDmm6n+4Fw/mfSoI+SfW49QI5k4JIInq/RDoOKJAwqsPqjl7K7KZjdtb1PtzcuKLu8vynqbZEiIn7Zw7MSFWA6MsTHywFxICPZQ1U8f6EKihhcv/bdeLcjSnK/wRhhJyvKGO9lveF0Cn3o65rp/iVK2qu1/TGaNehia+udFW8xdrvBBmHKw7d5jhDB+kWrs+aACxKjP76IR+hWp7jDXEMMwi9VP6/KxkHgQOpHAVGfEcYq/qb3qrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFFALVEIPAJVzq5LPJkPeB6ebHW15J7WyZtaTmsDLIY=;
 b=IcHEq/uDZRzHkzPfdNpw/RCd1tQLpByYDd56xUfx241/HKQaJAitY43Rn47Ggfq1iUXpxm78spDV6fQO8uHno19c2fJXeSe6q27vgVEmvnLU8l/zjKrTckQ3rTyOSq9BfTSsHdundui322UaFj1UPR3dr2/62yXsbIvvXxh6FWc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (2603:10a6:208:ff::27)
 by AM0PR08MB3796.eurprd08.prod.outlook.com (2603:10a6:208:100::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 20 May
 2020 07:23:07 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f%4]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 07:23:07 +0000
Subject: Re: [RFC PATCH 0/3] block: Synchronous bdrv_*() from coroutine in
 different AioContext
To: Kevin Wolf <kwolf@redhat.com>
References: <20200512144318.181049-1-kwolf@redhat.com>
 <6d78bc78-0c44-d703-6f9f-e048ea34fdd9@proxmox.com>
 <20200514142606.GH5518@linux.fritz.box>
 <285ba39f-9ee6-e089-13f7-a98ea0a84866@virtuozzo.com>
 <548700ea-78db-fabc-d1eb-6d89af39ece3@virtuozzo.com>
 <20200519141858.GN7652@linux.fritz.box>
 <dfed81f7-9806-9aaf-459f-13f786b67e0a@virtuozzo.com>
 <20200519152959.GP7652@linux.fritz.box>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <ea9f2813-9b39-88d2-faaf-748b6c8a4a83@virtuozzo.com>
Date: Wed, 20 May 2020 10:23:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200519152959.GP7652@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0P190CA0007.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::17) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (178.34.161.50) by
 AM0P190CA0007.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23 via Frontend Transport; Wed, 20 May 2020 07:23:06 +0000
X-Originating-IP: [178.34.161.50]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7151deb5-52ca-4f8a-c70e-08d7fc8ea485
X-MS-TrafficTypeDiagnostic: AM0PR08MB3796:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB3796C8DC3DB0C6A8A6327029CFB60@AM0PR08MB3796.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mrTpVcy4o2yRqj2Lfga/sLv24URnyOImvKeKW0d6eaK6NEByfbQGRQH6omUX9KLbL++4gjm8LcjhsflW5qXYQMm+T79crEGKrrjpyRwc6b7xDT5Za0qVj9czVvOQzO5BuIEt3HnNreRuba9KbS3xLY7iaU4kbZGULpZjOQgfLciIuXmEVoMN++LafZH/foP+bBvaBr3zymh17khA7hoznXGyeUCMqrq6bLTx9Dpj8ALN9WowwOeWSBsV5D63RkjKQLtWJWklR7yLmbl3ffVc4gsFRM4PFhL9QDkcB4SJso6j/qjNWTwpaL/kidE8T1S9k2yoylkssliIynJrZuuzMz7Zi25v+FMXM+dLcm7cGiTsKDtQ9v8Lhz0Rz/u6k4wZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB3745.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(396003)(366004)(39840400004)(376002)(956004)(31696002)(5660300002)(6916009)(86362001)(52116002)(26005)(16526019)(2616005)(478600001)(4326008)(186003)(316002)(16576012)(6486002)(54906003)(8936002)(36756003)(31686004)(66556008)(66946007)(66476007)(2906002)(8676002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: hnOPP86FyN4aLqO5SHN65L5E1AJ+x0Zd2+irGRN6KW1kg/Y045Eg/FBYteNIX0OutRgt12nJvf5WM1GyanVEbJN+P07qf/GGVyDbOVgFR1p8AIRSZDGxDCF+rTgUDyiXsmnw3fROOPH7rvPSLniVebUqIVKVgTDc5BNkl1ygAPvtftxvTeGa27W9srfA4EtVlF68KYae+33KxnxopN994cgWCf4gZDUQQgiZ1eWtTk6jScvJcikQj1cbPWDTXdl/Qf8SAuYzElw5O1WK6p2DqgvgJt9OHQ90LPmJCmOO1LNzdraoIGUO8t/xrew8ssWUILJ32MN3gF5lzZld7akoOfrHN0/WYQfoAbASVc0jUicmvcXaq6uIjylksHREHYEipKbMfAcQNqgGn0T2dR/RoIyV3hju4/T4K5fnDFuzySqVdFblUD524o35HD7tcsAlyJJv9DywTRWw76ZFJ55PjlFXWE3fWYPm97J/kkE1i6k=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7151deb5-52ca-4f8a-c70e-08d7fc8ea485
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 07:23:07.3919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zs6S/kYwwjXM6pEiTgP34NpngQ0dtR+yGBYwtZAIxhDY5GCVC5Tx1yzPStA3rElwAToiJ95/lFVd4CrLJKMCWILT/Mks9dmSoyyB4brpZ0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3796
Received-SPF: pass client-ip=40.107.6.137;
 envelope-from=dplotnikov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 03:23:08
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, s.reiter@proxmox.com,
 armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com,
 Thomas Lamprecht <t.lamprecht@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


>> I'm not quite sure I understand the point.
>> Let's see all the picture of async snapshot: our goal is to minimize a VM
>> downtime during the snapshot.
>> When we do async snapshot we save vmstate except RAM when a VM is stopped
>> using the current L1 table (further initial L1 table). Then, we want the VM
>> start running
>> and write RAM content. At this time all RAM is write-protected.
>> We unprotect each RAM page once it has been written.
> Oh, I see, you're basically doing something like postcopy migration. I
> was assuming it was more like regular live migration, except that you
> would overwrite updated RAM blocks instead of appending them.
>
> I can see your requirement then.
>
>> All those RAM pages should go to the snapshot using the initial L1 table.
>> Since the VM is running, it may want to write new disk blocks,
>> so we need to use a NEW L1 table to provide this ability. (Am I correct so
>> far?)
>> Thus, if I understand correctly, we need to use two L1 tables: the initial
>> one to store RAM pages
>> to the vmstate and the new one to allow disk writings.
>>
>> May be I can't see a better way to achieve that. Please, correct me if I'm
>> wrong.
> I guess I could imagine a different, though probably not better way: We
> could internally have a separate low-level operation that moves the VM
> state from the active layer to an already existing disk snapshot. Then
> you would snapshot the disk and start writing the VM to the active
> layer, and when the VM state write has completed you move it into the
> snapshot.
>
> The other options is doing what you suggested. There is nothing in the
> qcow2 on-disk format that would prevent this, but we would have to
> extend the qcow2 driver to allow I/O to inactive L1 tables. This sounds
> like a non-trivial amount of code changes, though it would potentially
> enable more use cases we never implemented ((read-only) access to
> internal snapshots as block nodes, so you could e.g. use block jobs to
> export a snapshot).
>
> Kevin

Ok, thanks for validating the possibilities and more ideas of 
implementation.
I think I should start from trying to post my background snapshot 
version storing the vmstate to an external file
because write-protected-userfaultfd is now available on linux.
And If it's accepted I'll try to come up with an internal version for 
qcow2 (It seems this is the only format supporting this).

Denis

