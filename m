Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38A7C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 16:33:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72F2521527
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 16:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=openvz.org header.i=@openvz.org header.b="LSuh5DaC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F2521527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmJxA-0007Vm-K3
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 12:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jmJrt-0007nI-4Z; Fri, 19 Jun 2020 12:27:53 -0400
Received: from mail-eopbgr80114.outbound.protection.outlook.com
 ([40.107.8.114]:15598 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jmJrp-0005Rz-Pm; Fri, 19 Jun 2020 12:27:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nn+ykg7FNtOPAA2JnlQyjj/8ZuyKIIFjc2OCzKLobMdraX5Wfage0/4+97Y+xI6t57ICIFrWkZ9hWeR3UfhpMqS36VTkSZOJNgncwRri4LIsB4d98t0RyheYMg6zYhcsoKeIchPrxt7k760A14iKHXz4HXP+B7wdGVgcOn1PGUq6gnp7clDQM2fv+cjTJ0ICSr7ZQHasTMkPtABkno90syySnfP7Z4S5jdos7/FxN24Z18Ov3OJmCkKC1cXY9CQDlyaNh859DQ2sK/e5qMn9oK/TwdE63iYdb1G2C6w1hM9tgwpvZQInm0oisf1D4agOAZzap6PXP3e4++A5t03zGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpaatHNzOGr0U3ZctEYPACOGgN8rZpFIcH3ALF8A7fE=;
 b=ffSi6ZX5FegQXZlVCY/afCoYPZ+I0UC1/CzS/5byq8RgeOT3ykWXTKjYOtpqZWTR2jm7ImVsyIcHa2VvD+os2Q1fbSs+E7YxFbK7MceiPvOuZdwsfIo7FTjiGMlq/Pk9Cus2/orI7ApZotWN1tvJsyWMzqWItQt9DVwUCg/ucQ7J1Y8tlAdh6g5I7YmTeCA8uXgCUXkijYDZViZTCVFG9U8E9jSHmmj5JT7G4zw+CyD6isg5ClAjIXgBPcWJAou14fUNAVesNpvYyTt8LECh3UetLcy2QYFMGhZHDmcGQnUXAwjlSwYvp5evcASw6D8dSZ3tAc2Up4H/DY6cLo2kEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=openvz.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpaatHNzOGr0U3ZctEYPACOGgN8rZpFIcH3ALF8A7fE=;
 b=LSuh5DaC9jmM7IkzQHAbkT2N78qRbmRPtu4yqYyJQWLes/BvyKDlIrSV71aORoqo4svo6A6nRtzcy1wv5unUZIjUEeHtnIyANWhb6f/LAktcTCI+jUvKloduF4WnS8YhtC239IsOSsD/ISf9K5hqv3wTmMt0KtC5KMjtpQZYMoU=
Authentication-Results: euphon.net; dkim=none (message not signed)
 header.d=none;euphon.net; dmarc=none action=none header.from=openvz.org;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM6PR08MB3397.eurprd08.prod.outlook.com (2603:10a6:20b:43::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19; Fri, 19 Jun
 2020 16:27:45 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8%4]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 16:27:45 +0000
Subject: Re: [PATCH 0/2] block: propagate discard alignment from format
 drivers to the guest
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20200611171608.22052-1-den@openvz.org>
 <20200619162004.GA9925@habkost.net>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <50129897-3687-e96f-03f6-4f121be76988@openvz.org>
Date: Fri, 19 Jun 2020 19:27:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200619162004.GA9925@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR02CA0086.eurprd02.prod.outlook.com
 (2603:10a6:7:29::15) To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.27] (31.148.204.195) by
 HE1PR02CA0086.eurprd02.prod.outlook.com (2603:10a6:7:29::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 16:27:44 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdffdf94-94cc-4dd1-a406-08d8146db286
X-MS-TrafficTypeDiagnostic: AM6PR08MB3397:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3397130B4EE50CEE3F943970B6980@AM6PR08MB3397.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0M6xLG/pR0/EFqFwkE/sgi1uiPrb4hiAG01pY4641SrnpQ833VWyo1vIgqEHZdA3r0EYLnOotRXOL0SY9jfj1qfhZRiFIEIW7UO+Qnsyu6SDJ5znqQ7r4v2/BuPPdVDIy8DcuJene9KgwasiRBmaYOpK3utUCiE6zUPE6eV3gD6YEj0JHVqkUuK2xViz3aQLoU2DraYFVkHAFn278Sjj90DEDJ7QE6I+F7+TGuni6wemS2hK9/kF7UWUjwcnzXH4UqwIc3ku3bmzUIC3ztRKZH/zzjMTbT3u8e0dCWyQX9SOBgTerUoOSJeaWCY617o7bqfpZbrVWljVAhZGDG8P0jGqHvuhlk03DGbvBPmNZw2SEPpczLczXhpXWTP5DZfI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4214.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(136003)(346002)(39840400004)(396003)(5660300002)(956004)(2616005)(16526019)(316002)(83170400001)(31686004)(6916009)(52116002)(53546011)(54906003)(186003)(16576012)(26005)(478600001)(31696002)(66946007)(66476007)(66556008)(2906002)(8936002)(36756003)(8676002)(83380400001)(4326008)(42882007)(6486002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: YS73hzw6JfKgGwCZe2nu2LxeVvMYgaMl47l28AgAmaThI8Mr+fYB4l8fb86l/2OObMJ/htLHyL6oJSa1vH3rOCXDz0RJWIPmn9YPoFYNynXFqJ+/F62ZvGiDTfQaAmN5YEVfFDC9YjMBTARyJn6Kv1pWpo1aiXtoFkstefZ5gq1srD+wVcM7CGpdEpczq6IwXJiR/fN3NPLkrAutWgaAVQQ8yG9dfyLyruKdj50Izamn4uwMvDDvpssXWAY0c5mB+kkW8q9YeIE4FFZX7+fctVRUddb5J65MsYLMsCrKIYGjxORCs0k31Ck8gbZBUwMb60oroXnHTa+sCcUcYq4h0g8KU75wN/B4hvUdobQVWbi7H0absIQEY1EN/Do9yz8VsV7rHpngtyVV5kFFMWwHXRK6sacEP6W3qUr/tHLt6PL4uxOKA/oSMw0IXMIGHJqBO9M4wy+hrdboUNCoE1j3DtIDIbq+c2k65dhy9YRGUgvTI8I4XN8hOmrXNItXLBQD
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: fdffdf94-94cc-4dd1-a406-08d8146db286
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 16:27:45.4063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FkZOTTFnYztjcrY76KU9djkGCYVkNSDkjtVXNkAQfu9W/kmSGxEscAOSlTSu37GXcT/QHHQP0JeKuIJ4keLm6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3397
Received-SPF: pass client-ip=40.107.8.114; envelope-from=den@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 12:27:46
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
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/19/20 7:20 PM, Eduardo Habkost wrote:
> On Thu, Jun 11, 2020 at 08:16:06PM +0300, Denis V. Lunev wrote:
>> Nowaday SCSI drivers in guests are able to align UNMAP requests before
>> sending to the device. Right now QEMU provides an ability to set
>> this via "discard_granularity" property of the block device which could
>> be used by management layer.
>>
>> Though, in particular, from the point of QEMU, there is
>> pdiscard_granularity on the format driver level, f.e. on QCOW2 or iSCSI.
>> It would be beneficial to pass this value as a default for this
>> property.
> I assume the value is visible to the guest.  What is supposed to
> happen if live migrating and the block backend is a different one
> on the destination?
>
> Also, don't we have mechanisms to change the block backend change
> at run time?  What should happen in that case?
First of all, I think that this should be very rare case.
Though nothing bad is expected. The quest will see
old value, i.e. one negotiated at guest startup.

Let us assume that block backend has been changed
and discard alignment is
- less than set. In this case the guest will continue to
  send larger than possible requests, i.e. some blocks
  will not be discarded as it could happen. This will
  happen until the guest restarts and see smaller
  alignment. First re-trim will discard all non-discarded
  so far blocks
- greater than set. The code will work like now, i.e.
  some extra requests will be sent.

Den

