Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9ADC3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 07:44:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7920B215A4
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 07:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hdHC9V6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7920B215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j92EH-0004LX-Ks
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 02:44:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j92DX-0003pe-Vx
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 02:43:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j92DW-0002Id-IH
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 02:43:51 -0500
Received: from mail-eopbgr40114.outbound.protection.outlook.com
 ([40.107.4.114]:53219 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j92DW-0002H5-04; Tue, 03 Mar 2020 02:43:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTPkqTnvf5tT9d0CIFjXpTf886f+3H1k1l94D+zThG6UBgWEae3AQoB48v68f4J0HbAe08vZzObs5uK/0+X8pq/nfq9q7x/iTqxd3VRUnCR/4QUMVqpvP7d0g1v5VAorcwvy5qau1xNGNyfhaGSlUM0mwaa5oOoRAbWKqpCm3+JteQcdJmZRStCHWk8fspxsQTZcexDFzDtYtg8URNvWrwyPDPMabCuiEFOZLSkz+S6X6IqZclte+xtIDr1za/SsMzT0aE9CdbCVNUucrjuhq1iuTUrsEFhEEIDfblf5h0jUf4BUaJQlMqxXGEekONy+4rDpdZ/Ya1/fnv2gTiAaLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdQnVECcXJZBXLRiy2mlFIhJyCOYMGqjhVOcf28ymn0=;
 b=Mg3tx9v5XRzM2309I801DLWBqnOCZ361p983Pkuv9G/hmnefcNkW7bQxhiRAUACf1LTuNoF9hkYhz5yIYRQFmWiDSuvzH5fJ0lHCVwiJiapp2PaApQxou0q1ev3o182IjyyCMXeBmQqUM2OY6HBDoYI95Z/QXlNkDOBgPZ0qV24RXQNlGTgOvjYpMJUd6KS2mpYmcMMMis9mPBIQLAzhfspKEqBvB4rvVtikdyYyoSBfbVB7OYqO0IQrye442vV23oCI9QHKvsI3ulvGC8nl0UZ9Cfs2zAGYvGx6X7bO3FhysdE4X2vXzKpIJMOzfsfM+ko0b1nHBBZIDk7o1FXQUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdQnVECcXJZBXLRiy2mlFIhJyCOYMGqjhVOcf28ymn0=;
 b=hdHC9V6bztWaQt4hgVdWpgldjpcB2REyldAXIgRKnlh9QL4hGrdFistsm/ke2baZqLRj0Ge37u+HBjiY8rM2V3vIZj+3g3eCc5S488nWgr/b0sHw3zo9i9WaBFZ9hkVcBHkzOrBEDVRUjdtussqGU3nvgl5xzvaqAPd9aRvbAas=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3752.eurprd08.prod.outlook.com (20.177.199.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18; Tue, 3 Mar 2020 07:43:43 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 07:43:43 +0000
Subject: Re: [PATCH v0 0/2] allow to set 'drive' property on a realized block
 device
To: Kevin Wolf <kwolf@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>
References: <20191110190310.19799-1-dplotnikov@virtuozzo.com>
 <20200302133837.GC4965@linux.fritz.box>
 <20b9cc1f-8fbe-99fc-bbdb-5605b1c186a9@virtuozzo.com>
 <20200302153939.GE4965@linux.fritz.box>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200303104341195
Message-ID: <f785fbae-c120-c3bc-eafc-e6a62dd89d99@virtuozzo.com>
Date: Tue, 3 Mar 2020 10:43:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200302153939.GE4965@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR09CA0059.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::27) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR09CA0059.eurprd09.prod.outlook.com (2603:10a6:7:3c::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Tue, 3 Mar 2020 07:43:42 +0000
X-Tagtoolbar-Keys: D20200303104341195
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f96cd387-02c3-4577-5363-08d7bf469933
X-MS-TrafficTypeDiagnostic: AM6PR08MB3752:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB375268F82E5DD81F02C14832C1E40@AM6PR08MB3752.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(376002)(39850400004)(346002)(396003)(189003)(199004)(66946007)(107886003)(8676002)(6636002)(956004)(8936002)(2906002)(53546011)(5660300002)(2616005)(81156014)(81166006)(52116002)(36756003)(31696002)(16526019)(66476007)(186003)(66556008)(316002)(966005)(6486002)(110136005)(4326008)(86362001)(478600001)(26005)(16576012)(31686004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3752;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: teQPDaHh4xEQcmIXAA3FRLt9nGKglDQpb7gNh32WpKOd8VQdGvzP5lBC1QyzqeGXhwv56xNrIp57x/nX8x/GqF0gCTziCi15RKz8Ga/B33VO3L0cr2kb87ImTNwfpU8zHjsPVQV2FB9hmp0bigoo3Lz8Zyjcm1FILlaWQQ85karatm5YailpwebgAv+iBs1BMYJ9N4Yift3pt8HpeF2yCaMcK4TjD+Qt+H4P4yZNQTUtBfrBAF4PlYliQ7Tq9JoGXDkVMpcNuzzN8IzcT6RNPtOfP9Sje+pC6AheGkxKmswqEnKRqr3k6eKbDMzri1cwsKSgwg6L/wQmMiLfQrEwaiP7QWBcZIolt2+eBPu7ON9R1AIXE/RwVXIMdakJsRoG4bS7IgP3G8BGJrl76WVzhUuBvyfoDjTwVjmJPNuwb5/F3aHnJhGDi9Q9ATDznwj/djdmJnztbU7+kiBFovIGgtAI/xme2BJuFImDi3EkOnjvO14khoZJS6EmWgnMhGDhNnNsTtznQLlV5H1TeikLUA==
X-MS-Exchange-AntiSpam-MessageData: Itod0rfJppADKqP48sNKN9hlzPoIMfsGcG/yd0lxTN75rOdn5xxUR3DQhQZBYVlQ8PjtkSuDH8si1CWkQhDFoPjOwvdP5N2iNe3G5mg43liBH4NkFlNh2PrGv3DjWuoL6EXhhoBjDlslkHuE3YYvcQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f96cd387-02c3-4577-5363-08d7bf469933
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 07:43:43.6647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +xB18fubkwiiE08Cf5jpoC6S0dlsP6p1XBYVQ01FcSDR65iOzm2S16wBBr8GsqaLgL5/fh9aFZOA8ivCb/0oZyiT9FIKl1Ixkl3vH+lBujg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3752
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.114
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
Cc: berrange@redhat.com, ehabkost@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com,
 den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

02.03.2020 18:39, Kevin Wolf wrote:
> Am 02.03.2020 um 14:55 hat Denis Plotnikov geschrieben:
>>
>>
>> On 02.03.2020 16:38, Kevin Wolf wrote:
>>> Am 10.11.2019 um 20:03 hat Denis Plotnikov geschrieben:
>>>> This allows to replace the file on a block device and is useful
>>>> to workaround the cases (migration) when the VM image is placed on
>>>> some shared storage with exclusive file opening model but the image
>>>> should be open form more than one app.
>>>>
>>>> The previous version of approaching the workaround was based on the
>>>> "blockdev-change-medium" command modification but had some flaws:
>>>>     * semantics: blockdev-change-medium is aimed to be used with removable devices
>>>>       only
>>>>     * interface: it can't accept all possible combination of parameters for
>>>>       the "drive" replacement (creation).
>>>>
>>>> More details here: http://patchwork.ozlabs.org/patch/1179329/
>>>>
>>>> The current series suggests another approach:
>>>> 1. blockdev-add
>>>> 2. qom-set disk.drive = the blockdev added (this is what the series adds)
>>> Are you still planning to send another version?
>>>
>>> Kevin
>> Not in the near future :) There is an unresolved problem with
>> bitmap-migration is case of block dev replacement.
>> Still don't know how to do it in the proper way.
> 
> I seem to remember that in some discussion a while ago we came to the
> conclusion that we need a way for the managemnt tool to provide a
> mapping from source node-names to destination node-names.

Yes, it's planned solution for bitmaps migration, but it doesn't help here.

> 
> Or is the problem you mean unrelated to identifying the node to which a
> bitmap should belong?
> 

The problem here is following:

We need to workaround migration on shared fs, which doesn't
allow to open file on node A if it is opened RW on node B
(and visa-versa).

So, we tried to start target with null-co stub instead of shared
qcow2 and than switch to correct file at some moment. The
problem with bitmaps migration is that we migrate bitmaps to
null-co and than they are lost... So we need to implement some
moving bitmaps from null-co to qcow2 node, keeping in mind that
they are in progress of migration. We didn't try to implement such
moving, it seemed too tricky.

I also had an idea of a flag for file-posix to close fd on inactivation..
But then we need to not open it when openining in inactive mode, and this
needs support in qcow2, which doesn't seem better than null-co stub.

So, I see two ways of solving this:

1. Use null-co stub and deal with moving bitmaps during postcopy
2. Move to UNOPENED mode for bdrv, which is similar to INACTIVE,
but doesn't allow to open any files on fs. We'll have to provide size
as an option anyway.. Sounds bad.

Could you give an advice?


-- 
Best regards,
Vladimir

