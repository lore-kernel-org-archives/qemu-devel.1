Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983D8C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 08:18:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6126F207E8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 08:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=openvz.org header.i=@openvz.org header.b="aOZDJgpf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6126F207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jojZK-00042d-II
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 04:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jojYW-0003JX-S3; Fri, 26 Jun 2020 04:17:53 -0400
Received: from mail-db8eur05on2106.outbound.protection.outlook.com
 ([40.107.20.106]:58130 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jojYU-00027s-55; Fri, 26 Jun 2020 04:17:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5AFsDW7oip+3ob0IIYIcoAcRlTfyhjAgr1zo7l+NrU7MNA3eazZnJ5EgiOjKh2NE9xNJ6GMtGeL/4bKrb7WYKZoEg4XiVbCkwHvdprepNQRMXkGbZMfVi48NPAomQC+q0gmX2RvMFSzVnbR53CzyEK6bsC2/haZbpwx8+aQFbHk3YnwQ0LYUnKZakOokb9JM0FRlqihTJshnzsWGQiEi0E4Mx/vEVBJSULf0/VKHAoHUg5DoeLV0WZqHtfR9qdvOP2WlvM/f1f/jPMqe/BQzaMRSBHR1hco8xe042GG5+xxJ+MvlWK35VGEILk1FqoBKyo+yDA1XSVNBdJQLTz1Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQF+16TON87gJybpaVJCPhFeBDgBRW4BUVHbIdlRwLM=;
 b=DkdH5bJvc3M07+Bx4WooVUFrt6fvUfhQIJvcF78+9U81j52koPa7b0nDh1nD3clFGqEphqLrngThQpQJWfIEPpAuZUeqw2riNW8ORjFbMmXYXb5cdmgjlj1E8aMLrqxFinWR72rOPKuwiLMnW+Z+4lt9XSedPQZu9h0queiTr8/x5eI7bs3lqrV3SiHGjJjxamjyi+oqzei5gWZr4T9Mao5wwx75ED/LC6M2Wvoo1JHH511Qi/6wO5kBS5u2kG1YNdRgSelJBxQ9zm2bmZ2DUK1lmmE/X0RCBGZ9FYu3e1CUi+RR1Yv2pHiz81noFF2vlGmDTHCEwN9zk/DvMLRKbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=openvz.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQF+16TON87gJybpaVJCPhFeBDgBRW4BUVHbIdlRwLM=;
 b=aOZDJgpfsFwSjumC8zTg8QL8d1zES0gpxueu8vO/jIhRbjExC+VAh23lP/BnmSddyeTHmSE7lUghSMODEhxpBaDffzuHWjx6tr7pNEb+rkL25o2DoG6BPBqMgvlDLIK4xsJh/zP1RwEwCU7rL52wSbXVie7ivdVo23svkLbfTxw=
Authentication-Results: euphon.net; dkim=none (message not signed)
 header.d=none;euphon.net; dmarc=none action=none header.from=openvz.org;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM6PR08MB5077.eurprd08.prod.outlook.com (2603:10a6:20b:e6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Fri, 26 Jun
 2020 08:17:45 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8%4]) with mapi id 15.20.3131.023; Fri, 26 Jun 2020
 08:17:45 +0000
Subject: Re: [PATCH 0/2] block: propagate discard alignment from format
 drivers to the guest
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20200611171608.22052-1-den@openvz.org>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <d6579ec6-fb1e-aad1-d0b3-e3a949ccd27d@openvz.org>
Date: Fri, 26 Jun 2020 11:17:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200611171608.22052-1-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR0202CA0001.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::11) To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.27] (31.148.204.195) by
 HE1PR0202CA0001.eurprd02.prod.outlook.com (2603:10a6:3:8c::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20 via Frontend Transport; Fri, 26 Jun 2020 08:17:44 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37878961-2903-4bcf-a23e-08d819a9676d
X-MS-TrafficTypeDiagnostic: AM6PR08MB5077:
X-Microsoft-Antispam-PRVS: <AM6PR08MB5077C215E48BA648B8E7ABA5B6930@AM6PR08MB5077.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WfzSXz8np31a+BlchmzGBvkGCCXiQ0hY/GVquj3WLHzgyGwvcCP1FeDMMHr3/Ejv3DrZHd4FnxrU0hZij34Cb9ulFasKdfIYXAleH+jWKHhCwMYakTmJWGK+udo8c04acj/ErNGvplGCsAl1U8wg9TyQ7ZY8kn8ChEjJKdVByKEYZ8sXWCkdVDyTAT453UnuPsdQSNgtvDA952w9JbHsGcemkPTQKk3BWc67oo6l4E2uSHmDpHG9krIqyfKdRVdjM0wK9Dne0CGFd16qjDNWF1H+mMJHtzkEiFyFudfNlfx8+fk8Zn70FKHTL7ejTI1lFI+CvYUYp3HoZUzxcGcqQUTXqM3Co9hsdwmkWBMrMj8XEvAOjaYpvIgh0E/6zrFU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4214.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39840400004)(366004)(136003)(346002)(376002)(31696002)(42882007)(52116002)(16576012)(83170400001)(316002)(8676002)(31686004)(4326008)(54906003)(8936002)(36756003)(5660300002)(2616005)(2906002)(956004)(6486002)(66946007)(186003)(66556008)(83380400001)(66476007)(26005)(478600001)(16526019)(53546011)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: I+2dCYw+Krz9/I0+SFTAYUmfng4s7IAGCjKTCMVlE5xAMSYX1VIKsWZ+NDM09qbpXdODCHz0IhOAA1uQeOCH7SgTBBoLw9USsJO0VQRLXmdpZrovknL4p416vS7DnqYFIYmEx9KXgBP62/QDNgwpWxCtdVf9NV7Gmc9Tj+UlkjhWcvZqvfyMx5m31mEWaPNhindT4Bk4SIhbiANAXYI21h4gGK4vku+kPo8GcIJGS7hfDxru/hU8pJFIFqm+oRQyR2zXY/YbWfcHHh/AA/q/IGLgWG+HJFLe/pIaEvtplZwux5BhTW3LstjnPf1hEw2uK/bUx1OQ/HXSD976dpZdrP68ODbWGXJztX+LAaaJmKlRr4nEgfDXyMUOYjgvV0dcpJxckoECboo+HKM6X17B6HmW6yOYy9a7tpfqRlspy46PIFb642v50vScT/e/PDScQefDlQqgg4Vjfaf44RSz7c5i3fbqX6JmFhy8iuDzhvI=
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 37878961-2903-4bcf-a23e-08d819a9676d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4214.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 08:17:44.9909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTlC3T/98ZCqeQKOZz2xJijLDATsIpklHCMR9Y4PDU/MeDnGj7xVv7xWy9hJ9i33zL/Kw/w9IlDKC+//KK3bVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5077
Received-SPF: pass client-ip=40.107.20.106; envelope-from=den@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 04:17:46
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
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
 Eduardo Habkost <ehabkost@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/11/20 8:16 PM, Denis V. Lunev wrote:
> Nowaday SCSI drivers in guests are able to align UNMAP requests before
> sending to the device. Right now QEMU provides an ability to set
> this via "discard_granularity" property of the block device which could
> be used by management layer.
>
> Though, in particular, from the point of QEMU, there is
> pdiscard_granularity on the format driver level, f.e. on QCOW2 or iSCSI.
> It would be beneficial to pass this value as a default for this
> property.
>
> Technically this should reduce the amount of use less UNMAP requests
> from the guest to the host. Basic test confirms this. Fedora 31 guest
> during 'fstrim /' on 32 Gb disk has issued 401/415 requests with/without
> proper alignment to QEMU.
>
> Changes from v2:
> - 172 iotest fixed
>
> Changes from v1:
> - fixed typos in description
> - added machine type compatibility layer as suggested by Kevin
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Eduardo Habkost <ehabkost@redhat.com>
> CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> CC: John Snow <jsnow@redhat.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Fam Zheng <fam@euphon.net>
>
>
ping v2

