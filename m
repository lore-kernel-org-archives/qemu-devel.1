Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D1AC55181
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 08:14:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7304B2073A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 08:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PpbXre1q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7304B2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQo3F-0007ki-Ju
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 04:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jQo2J-0006mg-Sy
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:13:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jQo2H-0002DP-61
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:13:43 -0400
Received: from mail-am6eur05on2107.outbound.protection.outlook.com
 ([40.107.22.107]:45505 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jQo2G-0002C4-GD
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:13:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ej7lYiRpL9KBIrV2mZMFqnb6d7ejmB/++Gb0OsuJBQXKJVQ9k42tgtnC4VAFY+7YOnrGaxtatiUvGKWfU4IRnNQ5MdVm11JUywIBznrq99zImvKgpwFDpeDDoQj3ZlZKzmlZ9LrSBYSjGXk1BUVTelGOQ5yjDwRgEN2iJDbxWnPNZvPY9aUMOYIIdBu37LziR7Q8PaDwQP4upDQvkYZI5s5O5SoDqrSTt+FB2V4BbdNbMbJ4qygw36xSHsA6qgkhJbfuu91VdNU4ExDI8F/txl4pbf8I5iODK1vO5jK+bp8Px6ooziu2XRE+U76wXv4FgKGeiKoFrJ+Wc1AilMepAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ux2vIxe/kBgySMVV6+/5DIUB2xYOhm+plNrSuHWssng=;
 b=Xnh2iumMQzM141yjv1kPx8ZkKqDR6xy/axcOXTeuveJ3dDch2c/dx+tLfjEyXU+GVBMMDjPgznqMhuDOLLnPer5GxskUPKcrv/s4e7TE+xm4yj63UIcBV0uQON6fO0LE6CMHu6hFLS7YVFYv/cEOAxVpOD/lD8JMiGFz7Xk9tAhpPlAPsgZvueCqtvnEHpWOZ9e/iGFaT3efUP4KGmrYZqkKDrafSVVVTT/jNv90GXA00FXKnumEcAk+G/h3yl339uZ+radfLKJe4l7AnDnLx1s+iZBYlJOVEiOIvoopmH5HSIGXXIrBnoGOaPCsESVioQSzKcN3wuK/4VXmmB9OTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ux2vIxe/kBgySMVV6+/5DIUB2xYOhm+plNrSuHWssng=;
 b=PpbXre1qa6TrutJmUo0bu6iITK36jaPPUvUpg5QRco17v+oILiwljHIkKgkXm9ivwRPAcbnfjTwbO9CBeHI3q2QmJPXe3jZO2jcEYYQJM2cauu1dhP2R0dOiWkeAgcjsE9xTc9dRGlOwjamJmZU0/oPsJ2hrVZ5SGT0EZmCO1KU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (2603:10a6:208:ff::27)
 by AM0PR08MB3588.eurprd08.prod.outlook.com (2603:10a6:208:d5::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Tue, 21 Apr
 2020 08:13:37 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f%4]) with mapi id 15.20.2921.030; Tue, 21 Apr 2020
 08:13:37 +0000
Subject: Re: [RFC patch v1 0/3] qemu-file writing performance improving
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: qemu-devel@nongnu.org
References: <1586776334-641239-1-git-send-email-dplotnikov@virtuozzo.com>
Message-ID: <54194c98-5692-c0d6-e3d0-c3049ab524b9@virtuozzo.com>
Date: Tue, 21 Apr 2020 11:13:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <1586776334-641239-1-git-send-email-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR0101CA0083.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::51) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (5.138.121.5) by
 AM4PR0101CA0083.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::51) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Tue, 21 Apr 2020 08:13:36 +0000
X-Originating-IP: [5.138.121.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6d887ef-c2df-4659-a391-08d7e5cbe4a4
X-MS-TrafficTypeDiagnostic: AM0PR08MB3588:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB358813BD7C2E14B8022F4EF4CFD50@AM0PR08MB3588.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB3745.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(376002)(39840400004)(366004)(396003)(346002)(136003)(6916009)(86362001)(81156014)(2616005)(4326008)(6486002)(16526019)(5660300002)(31696002)(66556008)(66476007)(186003)(66946007)(956004)(26005)(478600001)(53546011)(8676002)(52116002)(2906002)(31686004)(8936002)(36756003)(316002)(16576012);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WBpR2bsHjoeXMy9Fhm0JS4pxod+DeKzsW+YxbWckmhs3PoonU59UdKRHq7ONN043U+M3q+zbSuGpK18+/M99pLibofXKUcBmbeCzKccHJLmUkG8BXROeWGpHPZViv5j+myexbYDK9yD3NX2aiYKDLgaCF9BeASfuOOn8Tf8o+bw6+C9W0UeNAmfyNxBgsecwsTAPf8j6JQU8DzOadFcu6IhhW2D+WUjUzf05a2iBaH5oJNsQF+4mWrJs74wZrS8WeixsyK2yvNzO8bh2JxkuKlpcu0Gi56K3WAqf7COl0BsMDUTyEedE9iQ8rMOy1JcLMejCGOtqeS48sup+x3LLG5XY2KxB+VKdsojel/VvGv0fkZyurSEvHgraIanwtQ/cexzH2//l5Pxnj5J+kRMjwYB7zo6lfZzvN4iZTnNjzcnIKJzAO367p+oHSufSe0hP
X-MS-Exchange-AntiSpam-MessageData: i1hja8W9m8MCe8A5tmTTb9DsLVfKsXidCRZHyv0AOu9qmqy3bcg2QZ6bsKH/2UCOkd6NbZSWtf8we3+5YXk1gZD4Tgym633/p1ZY0545mbZDUswmNn+Yxq6lfSwuEqULOH9EWj9nIuh25dIlOQe1Gw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d887ef-c2df-4659-a391-08d7e5cbe4a4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 08:13:37.7628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nmaVWu9YM0/4y9Gl/2J1vFgP2AGIj2uKUE31ICDtU8j5UweIHNmnneJCJxK03UaQnykbMOZ2A0xt0UG9wdvE0J59YEMvsCNsJcALl+qiWBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3588
Received-SPF: pass client-ip=40.107.22.107;
 envelope-from=dplotnikov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 04:13:38
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.22.107
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
Cc: den@openvz.org, dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping!

On 13.04.2020 14:12, Denis Plotnikov wrote:
> Problem description: qcow2 internal snapshot saving time is too big on HDD ~ 25 sec
>
> When a qcow2 image is placed on a regular HDD and the image is openned with
> O_DIRECT the snapshot saving time is around 26 sec.
> The snapshot saving time can be 4 times sorter.
> The patch series propose the way to achive that.
>
> Why is the saving time = ~25 sec?
>
> There are three things:
> 1. qemu-file iov limit (currently 64)
> 2. direct qemu_fflush calls, inducing disk writings
> 3. ram data copying and synchronous disk wrtings
>
> When 1, 2 are quite clear, the 3rd needs some explaination:
>
> Internal snapshot uses qemu-file as an interface to store the data with
> stream semantics.
> qemu-file avoids data coping when possible (mostly for ram data)
> and use iovectors to propagate the data to an undelying block driver state.
> In the case when qcow2 openned with O_DIRECT it is suboptimal.
>
> This is what happens: on writing, when the iovectors query goes from qemu-file
> to bdrv (here and further by brdv I mean qcow2 with posix O_DIRECT openned backend),
> the brdv checks all iovectors to be base and size aligned, if it's not the case,
> the data copied to an internal buffer and synchronous pwrite is called.
> If the iovectors are aligned, io_submit is called.
>
> In our case, snapshot almost always induces pwrite, since we never have all
> the iovectors aligned in the query, because of frequent adding a short iovector:
> 8 byte ram-page delimiters, after adding each ram page iovector.
>
> So the qemu-file code in this case:
> 1. doesn't aviod ram copying
> 2. works fully synchronously
>
> How to improve the snapshot time:
>
> 1. easy way: to increase iov limit to IOV_MAX (1024).
> This will reduce synchronous writing frequency.
> My test revealed that with iov limit = IOV_MAX the snapshot time *~12 sec*.
>
> 2. complex way: do writings asynchronously.
> Introduce both base- and size-aligned buffer, write the data only when
> the buffer is full, write the buffer asynchronously, meanwhile filling another
> buffer with snapshot data.
> My test revealed that this complex way provides the snapshot time *~6 sec*,
> 2 times better than just iov limit increasing.
>
> The patch proposes how to improve the snapshot performance in the complex way,
> allowing to use the asyncronous writings when needed.
>
> This is an RFC series, as I didn't confident that I fully understand all
> qemu-file use cases. I tried to make the series in a safe way to not break
> anything related to qemu-file using in other places, like migration.
>
> All comments are *VERY* appriciated!
>
> Thanks,
> Denis
>
> Denis Plotnikov (3):
>    qemu-file: introduce current buffer
>    qemu-file: add buffered mode
>    migration/savevm: use qemu-file buffered mode for non-cached bdrv
>
>   include/qemu/typedefs.h |   2 +
>   migration/qemu-file.c   | 479 +++++++++++++++++++++++++++++++++++++++++-------
>   migration/qemu-file.h   |   9 +
>   migration/savevm.c      |  38 +++-
>   4 files changed, 456 insertions(+), 72 deletions(-)
>


