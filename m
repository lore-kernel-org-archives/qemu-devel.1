Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AB0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 09:43:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55AF721548
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 09:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bE0fVWAw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55AF721548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlr4V-0004E2-Ki
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 05:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jlr33-0002Oo-5K; Thu, 18 Jun 2020 05:41:29 -0400
Received: from mail-eopbgr20133.outbound.protection.outlook.com
 ([40.107.2.133]:17985 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jlr2w-0005Hn-Ta; Thu, 18 Jun 2020 05:41:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xhvc7KJfu6wi0IfUTmpU+BcDE1YsX5KYcih8gscmqE/ui2Ef8JeZ6POxYUGZZlkR7Vi8n/AFOZhZuxAViyadvGJTIpsOrQXqk/V96QrUqtFV0wv4CADgxCl6UpE89OoKm4TICB7of2xLcSMVndDOqaq5XShUXI3PB1KXNRl54D/pCzvfPUvOMhhXb1kzDkzM26/Zy347+mogLVHO0oEejQnRjsAF2UU8NalrI7hh0qizOlIiJ4qFino4zjzRiuD0obGaCKSiAXxHWhFsWTMpjTcADCU/gEDlruNgtWL3tPaNWxMMTMgoC04CFu83/0zULNaIp9OM43ETiHkOPrdAAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTFIux/eaZq7GACua3rDC39MARMlhN9bSpF4gSxRsgU=;
 b=Jbs43MVyheH+C5ms9s/2OPfQYvzaw3NbkeuX7BpD/2ZXFeQFr0t8uf8Zyrk5C4GWlKeP569Fp4j07df2T1uGYvhYC6WCjdoK0QyAmr0KoMbchOfKdCK84Z1rETvQSzSTwO70uF7sKNUrsxCuxOJ9M7s//c6QNulg3cAuxWk+U7K77+G/AVT2r/tXkFjufaDKeQ5zgn5OuPyZ6tQX3/nXZThSsMhTBuQSzcmGZ/VySBpYq6FwM2iXGbbX7LVYOi2Lrt9yUcd4J8nxNZzQouqXwmjIoH6gTX8a2ieQqOcT7yxzg0EOyekB1QpjDwzuQeFwjU+NWx+4ASFuhFHPWKMM1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTFIux/eaZq7GACua3rDC39MARMlhN9bSpF4gSxRsgU=;
 b=bE0fVWAwIdvnEOmHtYLjMcmdKqiYSw0b7IFo6FsByEcV8uNMmlOZHGXVYNfQczzIjbfbfMoM9VMEo1ItQ0BR2i1cLfK8Gd9X39jw2y5PAqehBfRsQBldpE8VmG1N2tl5GSUIMjfGn2xqS5gIpnt+2c5/We2J9OVFgog6cMwxy8g=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5302.eurprd08.prod.outlook.com (2603:10a6:20b:103::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 09:41:20 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 09:41:20 +0000
Subject: Re: [PATCH 3/5] block/aio_task: drop aio_task_pool_wait_one() helper
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20200616162035.29857-1-den@openvz.org>
 <20200616162035.29857-4-den@openvz.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b392a50a-c106-ff48-68ac-adb9369ea95b@virtuozzo.com>
Date: Thu, 18 Jun 2020 12:41:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200616162035.29857-4-den@openvz.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::11) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.145) by
 FR2P281CA0024.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.21 via Frontend Transport; Thu, 18 Jun 2020 09:41:20 +0000
X-Originating-IP: [185.215.60.145]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cb8d7e3-3f2d-43f4-b211-08d8136bc1c2
X-MS-TrafficTypeDiagnostic: AM7PR08MB5302:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB530234E7A6FB6646A12F4260C19B0@AM7PR08MB5302.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xuPD8nA5sVU/p6i8wewzId/OeyZurNv8y8vq1famku+LgJgd6sH8ZP8YgKUhvHFQS1Gtk7FFYH5z0gZIZXbVn3kgJGnD3SSIEq6Q3w97MPBE5CFzrDjFwRg4k7W4LewZ2mBPJ50vVbdO6RFPfeVG5S5B9FHhgo9vvHQ0moo16rk2GFxBaq+c4WfJhJb1EKua1XR6Y3y8S+zcL1k3CduJRvPBI0iKe3I4j5i4rr+iYm4gfny1rY9Ftvwo3HnnT22uDbregCpvdHVCXtbJavvoIDpqOh40ECH4H3IRXrUutC/gSxEZm/ZBta8jv7EXYPLryVKSMU7beQ497+Pk2uFV9PQtIVXaYHJOmMnVLD9GRTI0Yy3X+mUDhGiMuRgow8cu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(136003)(366004)(376002)(39840400004)(316002)(16576012)(5660300002)(26005)(83380400001)(8936002)(2906002)(86362001)(478600001)(31696002)(2616005)(6486002)(36756003)(107886003)(8676002)(4744005)(66946007)(52116002)(186003)(31686004)(16526019)(54906003)(66476007)(956004)(66556008)(4326008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: TSi16mJri828tSLO6VLvRO07z9idqHHEu6itQrMkWeZkuVnCDaj7MxYC/5zle9RFnjAV5iVlDLxPL6EU8X3D3hIegQqZIOEhBxs2WP4R2M0M/dVUZoc624UO/jTg1CuPcGZkHDKqNXSSj4HgzegqPTonAmlKjLjM5ZM79uB0VLwzWct2aTHwkZCJ+2GSj3B70z6Vfo2FvRuWOxGsvly8DBbyECkrXUL6zzD+mZ2FtXs0oUdU9FOlp9fMRMdleBfFM5KG+MErDasHacSUEZpRKyCUsUPqFx8XxEdSnOsWv3gd0aFvnOD6IBYtOB0Z4pwsDZMl2hqOLs51wBLh4+48Pwc1eaOK04eto+RN4dGF/OpjoPmhAFtKjLL6D8zWauaXiTaetrgdISC7eerVuLJHVEwLOetLwCVxnWrfP2z/f5G2uHiy1hEUsq11DvCvW38EIDhP6nMhrb9nBZl2K0X+GIhvRxtXpgmxWIVq7Xdz8Qm8J+B9YFYOiz+/m/LFHEpH
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb8d7e3-3f2d-43f4-b211-08d8136bc1c2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 09:41:20.6892 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ArKgpT3DBdA66tGo8ta3ttwsopmskVC+oC8ZUcH3NC1uh63xG4yq3r+gv4zmBx3t3L7JDyN7oL9l2f+C7ofZJVVmYqhRuiCDvVf+ubAtNtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5302
Received-SPF: pass client-ip=40.107.2.133;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 05:41:21
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

16.06.2020 19:20, Denis V. Lunev wrote:
> It is not used outside the module.
> 
> Actually there are 2 kind of waiters:
> - for a slot and
> - for all tasks to finish
> This patch limits external API to listed types.
> 
> Signed-off-by: Denis V. Lunev<den@openvz.org>
> Suggested-by: Vladimir Sementsov-Ogievskiy<vsementsov@virtuozzo.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

