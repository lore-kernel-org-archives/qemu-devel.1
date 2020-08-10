Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA40C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 12:59:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28814206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 12:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=openvz.org header.i=@openvz.org header.b="n5dGB+pc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28814206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k57Og-0000qI-Ba
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 08:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1k57Nq-0000KB-6K; Mon, 10 Aug 2020 08:58:34 -0400
Received: from mail-eopbgr70122.outbound.protection.outlook.com
 ([40.107.7.122]:28135 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1k57Nm-0004vE-PS; Mon, 10 Aug 2020 08:58:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkD+bT4RsKxmMCzXAlyn5kP5Mti+ZcgO+1fvzSsthTTED9ddSd7kWetI6lefQePPDTcx3KCvRqRGrLVmLiGhKkaQ0RHt6xRBOfLGHV8RFl+vb6NG5hLwFg2dZBNa18TuyeJRBR7qY6y3iXtGw/NXqePYxkZA/k87VQ0hwXUGSL4q2SBGC5Y4v12kymgXLVTEvrPyFBF8VNbt0cO8a3WbspYnIWWQTOqbQ08ZdaptGyvL6SOvuqaU7UwG1WvPF1TM7Tf4vn1hB4TPrbmKd7QNMMDLMUs+im0UkXCycV/+N4ltPuiKiP6kWAhWdNL/H6qYUDlcJ0nHCyxz/QNyoOZqow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjMzaeIbBfvJMJDHBWr8T/2OywVOGavxXEy1bc749Bk=;
 b=F/UFYitw1ZgKnlMhkBPmQefYzoRFLqZQHAUxgyuePAXGXZ2vjvJxiYGPZn2V581jNxs/vK9g49q+w4J7FBNSYxGSRIY/569V6WNCu8Joddz7wxYaeBHe2VFHtQBnwd1XY8As+HGyJV1GcSWYQ4Z8hL4doqBea9p6KrrmMRodEMH9QpabQNiVcGEiRs2a0qCZ7Fkcck+2B5fNtZvEOg16dTdj23W62ese/WOap4kvniaAF+PEhrJWkz+yjRaBrfmWJrmah0x4n/YNY3jQ9Lvl8r20qB112zJtETYxl/4oS4d0OXryiuac/F+8bWz+89z+M+Kcn5P+6IvSXlR5qs78Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=openvz.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjMzaeIbBfvJMJDHBWr8T/2OywVOGavxXEy1bc749Bk=;
 b=n5dGB+pc6WOa35RTADPILFmEVr1AUxBvzdnleiNOKtVrVwhNUgjFAAVhKiq4mJA6pxnNXZn3kp1g/VdxwBvoJTO1/mLol0ew/7IhDgcdQQ7EolS+mowj+B9iWva+Xq0tiOtBw+RUwvJO2S1XIZr0DLH57JD9I6iAMPgxfb2w+4E=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=openvz.org;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM6PR08MB3542.eurprd08.prod.outlook.com (2603:10a6:20b:4b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Mon, 10 Aug
 2020 12:58:21 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::751c:fc78:625c:ea34]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::751c:fc78:625c:ea34%4]) with mapi id 15.20.3261.022; Mon, 10 Aug 2020
 12:58:21 +0000
Subject: Re: [PATCH for 5.2 1/1] qemu-io: add -V flag for read sub-command
To: "Richard W.M. Jones" <rjones@redhat.com>
References: <20200810123555.30481-1-den@openvz.org>
 <20200810125215.GJ3888@redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <944b93f5-ed1f-3bd0-c4ca-81bfd378467c@openvz.org>
Date: Mon, 10 Aug 2020 15:58:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200810125215.GJ3888@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0P190CA0003.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::13) To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.27] (31.148.204.195) by
 AM0P190CA0003.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.16 via Frontend Transport; Mon, 10 Aug 2020 12:58:20 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c021046-9df3-4f3e-af76-08d83d2d0f46
X-MS-TrafficTypeDiagnostic: AM6PR08MB3542:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3542878A0092D462E3A15D9DB6440@AM6PR08MB3542.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I/3leEe941I6YhMku8mXjNOdkYIRjWZJUn3KQ03NjU/3rHZUFLjvrvkq6ZesXXTFJCHnuMSDui8k0HKH8HGNs5cYNMBMVa4rDfVyRpmsgg6nMxGA1wJidFyWwSiX5PWnHcKaZ0owhmujVAwtt8a8fr1JEfcsrjOCyalw/vKNxizfhxXv+/itBuBFUrniGZLcKXkcg3MFeasG4ZmdVsSCfSMfWPpdvG8IrEg/r6AemIIDhpPB79kvUjK73pQ9jEMunPRrLuroHoBVzChzWEAIkAU0HmnxBZJp07oBVRSOlbY38TGtn89GZptWdK877u3pIjjryeXz4dt1EV7qprpZXrt6SLHXNykALrB46AzeK20kYrN2hu4f9Pgqq51dMDQZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4214.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(366004)(376002)(346002)(39840400004)(186003)(31696002)(4326008)(52116002)(31686004)(5660300002)(66946007)(66476007)(66556008)(316002)(54906003)(6486002)(83170400001)(16576012)(956004)(2616005)(6916009)(2906002)(36756003)(26005)(16526019)(53546011)(42882007)(8936002)(478600001)(8676002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: +bA+BnPdqklpCgOUNffshR53w/Z9xlVDIi+2OeJXM7CK162ecsmf2csZxEXkp5owZRJ4K46H+eemweq4CRsL5q/VbPI5hFm7BFP49IYXnFNwkJeZ0nli2Q85zL360/LBE4pu1rDGEkpAa/fv4jgB2liHJk95HyVdiFr2bCSt7hNe9qtq813qErzCeJzUk9i0roxvrOdpfvQXxb2hBZzFgq+9DVnLhn5rWndM+FpndsVk9o+2Q9GJkhRkGVKBqyIM17aapUVb+mDn+TkOF90w/NEP6vWo4vmI59uIOOjjhiYsOCrnFrun5BBWuh718WsRQXDTMY3ZSchOqSAgVeuM3L45FB0doXsc66MRMUEQ3TGNeOZM9uU43NfHYpwHzX8jQgRvU+PRExZh6czwOx+zFKgG7+uwN2HCtdlBt0Jt0STgAi6IAkbX/ll4Ymsp8Anh1W9TO0UzNJR3dQlfIPOD84IfDbcXmKs+zau099mzAUOJX3F5esN20naErWW0HffbgSD5HXPdMYl+SYaYc3Vhnd3vCpFcTpA23/o4wb2T85+6BLnk5MwmugsyTZpOhx+6qzLgZ26SMGzQ56zm1kgf6U/EFk36eKG4K3SYovvOJ6uf1XKTtfPUFYF2RrA5BNdhmJfbGrl/MWyXEWgRZB/aRw==
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c021046-9df3-4f3e-af76-08d83d2d0f46
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4214.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2020 12:58:21.4147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6cD7iBWOzIxmKUeRYmSgJ/tEr9Jd2ZXZv98Akr5OQvqI4X/wbssuk0P/P69j91uQ2vm1gkFm2h/8mD8Wq+/aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3542
Received-SPF: pass client-ip=40.107.7.122; envelope-from=den@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 08:58:26
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/10/20 3:52 PM, Richard W.M. Jones wrote:
> On Mon, Aug 10, 2020 at 03:35:55PM +0300, Denis V. Lunev wrote:
>> The problem this patch is trying to address is libguestfs behavior on the
>> appliance startup. It starts supporting to use root=UUID definition in
>> the kernel command line of its root filesystem using
>>     file --  /usr/lib64/guestfs/appliance/root
>> This works fine with RAW image, but we are using QCOW2 as a storage to
>> save a bit of file space and in this case we get
>>     QEMU QCOW Image (v3), 1610612736 bytes
>> instead of UUID of the root filesystem.
>>
>> The solution is very simple - we should dump first 256k of the image file
>> like the follows
>>     qemu-io -c "read -V 0 256k" appliance | file -
>> which will provide correct result for all possible types of the appliance
>> storage.
>>
>> Unfortunately, additional option for qemu-io is the only and the simplest
>> solution as '-v' creates very specific output, which requires to be
>> parsed. 'qemu-img dd of=/dev/stdout' does not work and the fix would be
>> much more intrusive.
> I like the idea of the flag - we could also use it in the nbdkit test
> suite.
>
> I wonder if the actual flag ('V') is a good idea because I would
> normally associate that with getting the version of a command.  But
> as these are subcommand flags, that's probably not too relevant here.
we could use '-r' aka --raw and apply it only if -v present.

I think that some opinion from Kevin or Max would be helpful
here.

Den

