Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E342C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 17:22:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39D4D206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 17:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Y6C9eztp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D4D206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjQuf-0001L1-Ha
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 13:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jjQto-0000mV-8x; Thu, 11 Jun 2020 13:21:56 -0400
Received: from mail-eopbgr80128.outbound.protection.outlook.com
 ([40.107.8.128]:57732 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jjQtk-0002dg-I5; Thu, 11 Jun 2020 13:21:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsls1zvLD1OFOpjW9JIxX7iH0DCPskCQvthsiPEa0kUIs9g9iW4WNBJx1D3GFohxP890JWoMnB4IRKNCtHT7cICysDHNt148Bin5LnfKaEZn8xITyKSsvPtywQYX6mNmIAHoQHUo8XRV1NNPWBqd/pM55rwPA2axFzPzXizLei8vsGI81x27N/aiknaLx5qZLyY6MXfHjTWH39In4WgqC9jKr/yzsXTIyYCzi+NYfuk9prn38K1RHiXd6f9L4578SW1lBTQpqnnny6fE6BM/rjwGMITUcId3lALlXx2sSwyWqL3SoN6oyCNY9o9jbISE/pZsLK4O8jJ7qCGQZr0vHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2sNaSruMm1GsA0rYbwDAVKl2p2+MGXj2IBUW3zftHg=;
 b=Q7JLexuRpPNegFbM7maOCWYcihYJFemrU5RDRIIcI0/zMzSuqymFjeGKObEhtRYzXbGcr0Sxdoo7Gv5YVJQk+INiJBlIhozYkGiuX5siaFWVeCORi2K6gXNVZ+lijkUJhIRZEem20sPxxb/k/dD0+hRrcV4RacYodrNLiaLuQ1E5qvnplLZHqPkZTmv9eHwEvAhk1Eluj7QJzEZiazDUiLhPkCHTGVRvS8DErO/mKpeAEOX/5JZ2oqjWOUp50sv7vsRrrOyeCRCIWAYySaDhP4ZPDdu7P2Eh6KXFT9v350hXqZUd8XPudV7sIjguevN7s6AbAMW9R8dAp/wrgZM2Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2sNaSruMm1GsA0rYbwDAVKl2p2+MGXj2IBUW3zftHg=;
 b=Y6C9eztpGJhhpftQzqZSvsmxKMbAP1TKqz03lka+5rcONYekLs9JxfEZncHVyKiEIHobmQeSxtx+P+CpDZOafWNJc4mZLL3dOhX8Byyy6IAOsvfcvLQ0LtKXVAWPBcsV7ZraFiJ1O7hQoWOXTXw6RB9uxDw3hbbN3/W1Z5ur5K0=
Authentication-Results: euphon.net; dkim=none (message not signed)
 header.d=none;euphon.net; dmarc=none action=none header.from=openvz.org;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM6PR08MB3173.eurprd08.prod.outlook.com (2603:10a6:209:4c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Thu, 11 Jun
 2020 17:21:48 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8%4]) with mapi id 15.20.3088.018; Thu, 11 Jun 2020
 17:21:48 +0000
Subject: pls consider this is [v3] Re: [PATCH 0/2] block: propagate discard
 alignment from format drivers to the guest
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20200611171608.22052-1-den@openvz.org>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <2b9a0ce7-c06b-4b12-2e20-81fd187adadd@openvz.org>
Date: Thu, 11 Jun 2020 20:21:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200611171608.22052-1-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HE1P191CA0001.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::11)
 To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.27] (31.148.204.195) by
 HE1P191CA0001.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.19 via Frontend Transport; Thu, 11 Jun 2020 17:21:47 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33a5e2e9-c1b5-41fc-b1b4-08d80e2bec16
X-MS-TrafficTypeDiagnostic: AM6PR08MB3173:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3173824A2BBCB9DD610C828DB6800@AM6PR08MB3173.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H2pgSAwQiU9GzFEVmQ37r3tRchTkSpgpG8PS3mdVp2YvquHaEUE03WWF6GqN7r7ds864FrsPkDxJQsjWXp9WYaCFqwB7e9kL1NrTWVgwxjwnqKew6HeibGjWmGp/igBPk+jjlKVXILfkgfbvaAJuULyYLPH0wbq/QujNXegiQ44TGW/RjViHyZLj4j8obrSoQWrvgiJLOv/mFCy7pQgf3Rw6QvGSRWl5wdeszJvACfnO6yHCBML5oZGQatEbYvgWoqB96lbHLamX9OQ/c0gXqQzovc041tcW0fY0BsVtGvz7pbYM46OErmNIph7zxpDK6pSQ3RVjrhtYDQBWgu5gMs1uFweiNjMniY7zlOIO5G6jFCuGhHOyPMIAxLpZQRze
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4214.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(366004)(376002)(136003)(396003)(346002)(2616005)(6486002)(66476007)(26005)(186003)(16576012)(16526019)(66946007)(83170400001)(478600001)(316002)(66556008)(83380400001)(53546011)(8936002)(956004)(54906003)(31686004)(8676002)(31696002)(5660300002)(4326008)(36756003)(42882007)(2906002)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: nSznlwgo9vKEb48insgAaWdusJd6gzpq5IaI//lHy0Z1xnC4WD8R/u4uA8oB/TRAgcBlsIH1qQ7+Z446tSx8Ximio9BidlLE7FzYSEl/0ZxPgalDWWsopYi4PqSnzvELowdXYQSxSFvOftrDVzKHxQKprkAU938mC35EwlGlprSP3LzGkzKF2jqon5/chD6NjZ1B/95OK3RsB07HV4ZZ8o2sKUrajJssvqE67hvlvGzueD7G1ZkjvoRD3yU6vr7L6yGoUsmzScguAMMAqwPiCdfQc+CKpdc31zHJpmxclkxYn//OLm8dcRbrZ5KJzMFLIQGYVE0Y7ZcqS1ZccoI/GqaM/W66ABZ8XkXb0KCRIXGpy+6FaCXaZSgUl/ZOHU1KhLJvuD2FLGdI2KwNUU98a3j3/5hWYkQggSrSFI0Q5ug0gcYZk5aO7ldMF/hDFSYq+AN8LRg8ii8GLCzz8+cVDEgro5NnpmTGErJsdyE62y5h6cBRxIyDzF3w+uBwvhpq
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a5e2e9-c1b5-41fc-b1b4-08d80e2bec16
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 17:21:48.1157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6oeOmw2buWrZBJLikpP0IrzzdZAe78hmEtVUK0NZuqYZzRM/fMFLe9970BZ3ptNdfGzixl9mJFFv+j9GZEm6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3173
Received-SPF: pass client-ip=40.107.8.128; envelope-from=den@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 13:21:49
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
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
Sorry for missed v3 tag in the subject :(

