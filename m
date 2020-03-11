Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1870BC3F2D0
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 09:17:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBD5921655
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 09:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rPzHgvTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD5921655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBxUW-0004gr-Od
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 05:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jBxTV-00040S-5v
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 05:16:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jBxTR-0001MX-Jf
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 05:16:25 -0400
Received: from mail-am6eur05on2136.outbound.protection.outlook.com
 ([40.107.22.136]:26671 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jBxTH-0001GG-VP; Wed, 11 Mar 2020 05:16:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABfbuAP1rJ4f5hsLlU7AjuIoP1fVV7jlZXh8ChhiesWAbs+mckaLTuFUaPEyCiiGkhB1Mq2ZiL3baX55M5NKasjglSA1NosV2SXUx3PsF/EMyhvI9o+wiJjMEGe/C/kuk/RYlA3eiuBXQbwXQhIscO1aCK9ZJZMV7wrMfq9btT1vleUei1c7z+UhN+t9WwqCgi6TlM0yLTCheXPUKbCDWRdc6gQCxa71rOl2tfwVqV/DmOuK9b4Yqguh0oT8JFcv5yypL9+o1jZyUTuQF2sEPJsbuamcxN1NnD/guYfdyzUdt8RDHNYiDbExDn4Qfgby6ILN6FduoLtTisOh8Z5M6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYSbMiK2A6RvPY4MZxHxBDJwqPdh7EUrtY1bXQLxaNQ=;
 b=CbjTwfthDsLvbypqqqMIAjPZ5hyIS7sso6gBVYVMcLeNJ3xqYGvxHUHSMxCR8Y9UI6JSFAHobwOHZYfBpx676WiBHfwJ6282X9PXiCzbYBH17BLNvUX4IhVIbK1toER9v4mbeaqqsHOeHjJIfTTXGfyZJb930bEnxaSkkB8YCwjylsZlHVfS3FYDdr4FrMaW7V9DIAb8NsCRDFlWnXZ0ogyIXvuXu+WY4m6sYQUQYYYmWYDZBtglF4RpszRfpRNlQbLQ+G/KrLK1s6WNL/tLArU6mLjR0bLe+K+JNTKGH2ovelGadTM61rBmupP1t9PkU8coPckWvgwpVrgivvKJZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYSbMiK2A6RvPY4MZxHxBDJwqPdh7EUrtY1bXQLxaNQ=;
 b=rPzHgvTGV/NnRRhWqVY4t4IvgB3C4oqPSzkrvMHmX+Rqwez15WsUH01fKlaBsJRhcmpuntk77ZGh1oXagsp0ZLaQyurO+mI4STsFnSLdFjfflRqNwxHOACGIEijtoFsRI1+i5FXvIf7mzSMEdk5eIXuzbrs46Sm6kv/sNsTteBc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3704.eurprd08.prod.outlook.com (20.177.199.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Wed, 11 Mar 2020 09:16:09 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2814.007; Wed, 11 Mar 2020
 09:16:09 +0000
Subject: Re: [PATCH v8 02/10] scripts: add coccinelle script to use auto
 propagated errp
To: Markus Armbruster <armbru@redhat.com>
References: <20200306051536.27803-1-vsementsov@virtuozzo.com>
 <20200306051536.27803-3-vsementsov@virtuozzo.com>
 <87lfo997hs.fsf@dusky.pond.sub.org>
 <e5b19cf6-f206-a0ed-27cc-173c3a137ef2@virtuozzo.com>
 <87lfo8nrdo.fsf@dusky.pond.sub.org>
 <4ad4f78d-bdf2-1302-a9b4-0324119217c7@virtuozzo.com>
 <87a74ni7p7.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200311121605216
Message-ID: <e340fc44-08ac-364f-d752-7188b5e74798@virtuozzo.com>
Date: Wed, 11 Mar 2020 12:16:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <87a74ni7p7.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR05CA0140.eurprd05.prod.outlook.com
 (2603:10a6:7:28::27) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR05CA0140.eurprd05.prod.outlook.com (2603:10a6:7:28::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.15 via Frontend Transport; Wed, 11 Mar 2020 09:16:07 +0000
X-Tagtoolbar-Keys: D20200311121605216
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5eb3014-00c0-40a4-83af-08d7c59cd5bb
X-MS-TrafficTypeDiagnostic: AM6PR08MB3704:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3704BC54AB9BABAAF4634DE8C1FC0@AM6PR08MB3704.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(136003)(376002)(39850400004)(346002)(199004)(81156014)(8676002)(86362001)(7416002)(4326008)(52116002)(36756003)(6916009)(81166006)(31696002)(6486002)(186003)(5660300002)(54906003)(16526019)(30864003)(31686004)(16576012)(316002)(66556008)(2616005)(2906002)(956004)(66946007)(8936002)(66476007)(478600001)(26005)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3704;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FS+3d/Kcb9EjZe0Rr4F8/gCqPxiuiMyokYUrnzK/xsv+5RyNx1L4eTNp7+ejY5scE074zzq3xnyRvrdMZJBzHXqt4uEd0dfyhOVxkyYJoOpLd33AznWo3CTA8N1EDhCgzSXuWiAzRLR8XqHk6Z3Y9vXxWTsqgX65F1G/9oKTsSMvki0udAbjQch9cxGEpJXyeroWdeC0ZmuMCgClbeiU4QZfWFS0yzgXjRkJQ41QmRr67FRv37pxrwY7J69lvi7hz/gzuHt0m7LNbcZSND/tFeWOqjdoS5wS6Lf+OqoDRdDSM+Hy6X5ALqKFj+L+uCqWWBZhx359QyKe38t6AuT8FIsl8x3KMq2Bm1qTpFmLZ4HrZuLmjOvj5w5QZYBYZwAepAdwmc1OO/GzCwDs+HcsF83GPY1GPdigoQ1nxGDK4tbKXW+jOkGXavuZ1OHXyairPnecYnmbLKoSxPIfocEZRPLNWql+6EI8Bcjhlaa++XuNv+139fdWtn8gNqmJ+6M5m9rxbJEtrj/69aOIrl05ITgoffMqhhboLJCz+4pUejoyETTE2SYRKjbnAEUlvHHx
X-MS-Exchange-AntiSpam-MessageData: LEsDUY1Ym49R0bRC9DIW2qQrBPUX4BMW0lapzHhbA4e140nd5RRJhiEBnZmR5mIPAHM7rJz6x2TcMYiGT0RoRqbLY9Gu0Fo/x0wuoOi50zLbNvUPfipHvE5ngVSaBL5KDn7kg0UvYfLl9iFJet8JHw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5eb3014-00c0-40a4-83af-08d7c59cd5bb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 09:16:08.9849 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v1GJP85oZRkJSwTzRZ8TWO5VkGskokIs7alFNF8mhxl5Nb7+M6u2LBnXFj6Kl5GShbvYW6o4lSZQCCV9bmC7nzOlOUL6fsRSdqUQJAGNF10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3704
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.22.136
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, Paul Durrant <paul@xen.org>,
 Laszlo Ersek <lersek@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11.03.2020 12:04, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>=20
>> 10.03.2020 18:47, Markus Armbruster wrote:
>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>
>>>> 09.03.2020 12:56, Markus Armbruster wrote:
>>>>> Suggest
>>>>>
>>>>>        scripts: Coccinelle script to use auto-propagated errp
>>>>>
>>>>> or
>>>>>
>>>>>        scripts: Coccinelle script to use ERRP_AUTO_PROPAGATE()
>>>>>
>>>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>>>
>>>>>> Script adds ERRP_AUTO_PROPAGATE macro invocation where appropriate a=
nd
>>>>>> does corresponding changes in code (look for details in
>>>>>> include/qapi/error.h)
>>>>>>
>>>>>> Usage example:
>>>>>> spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>>>>>>     --macro-file scripts/cocci-macro-file.h --in-place --no-show-dif=
f \
>>>>>>     blockdev-nbd.c qemu-nbd.c {block/nbd*,nbd/*,include/block/nbd*}.=
[hc]
>>>>>
>>>>> Suggest FILES... instead of a specific set of files.
>>>>>
>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.co=
m>
>>>>>> ---
>>>>>>
>>>>>> Cc: Eric Blake <eblake@redhat.com>
>>>>>> Cc: Kevin Wolf <kwolf@redhat.com>
>>>>>> Cc: Max Reitz <mreitz@redhat.com>
>>>>>> Cc: Greg Kurz <groug@kaod.org>
>>>>>> Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>
>>>>>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>>>>>> Cc: Anthony Perard <anthony.perard@citrix.com>
>>>>>> Cc: Paul Durrant <paul@xen.org>
>>>>>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>>>>>> Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
>>>>>> Cc: Laszlo Ersek <lersek@redhat.com>
>>>>>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>>>>>> Cc: Stefan Berger <stefanb@linux.ibm.com>
>>>>>> Cc: Markus Armbruster <armbru@redhat.com>
>>>>>> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
>>>>>> Cc: qemu-block@nongnu.org
>>>>>> Cc: qemu-devel@nongnu.org
>>>>>> Cc: xen-devel@lists.xenproject.org
>>>>>>
>>>>>>     include/qapi/error.h                          |   3 +
>>>>>>     scripts/coccinelle/auto-propagated-errp.cocci | 231 ++++++++++++=
++++++
>>>>>>     2 files changed, 234 insertions(+)
>>>>>>     create mode 100644 scripts/coccinelle/auto-propagated-errp.cocci
>>>>>>
>>>>>> diff --git a/include/qapi/error.h b/include/qapi/error.h
>>>>>> index bb9bcf02fb..fbfc6f1c0b 100644
>>>>>> --- a/include/qapi/error.h
>>>>>> +++ b/include/qapi/error.h
>>>>>> @@ -211,6 +211,9 @@
>>>>>>      *         }
>>>>>>      *         ...
>>>>>>      *     }
>>>>>> + *
>>>>>> + * For mass conversion use script
>>>>>
>>>>> mass-conversion (we're not converting mass, we're converting en masse=
)
>>>>>
>>>>>> + *   scripts/coccinelle/auto-propagated-errp.cocci
>>>>>>      */
>>>>>>       #ifndef ERROR_H
>>>>>> diff --git a/scripts/coccinelle/auto-propagated-errp.cocci b/scripts=
/coccinelle/auto-propagated-errp.cocci
>>>>>> new file mode 100644
>>>>>> index 0000000000..bff274bd6d
>>>>>> --- /dev/null
>>>>>> +++ b/scripts/coccinelle/auto-propagated-errp.cocci
>>>>>
>>>>> Preface to my review of this script: may aim isn't to make it
>>>>> bullet-proof.  I want to (1) make it good enough (explained in a
>>>>> jiffie), and (2) automatically identify the spots where it still isn'=
t
>>>>> obviously safe for manual review.
>>>>>
>>>>> The latter may involve additional scripting.  That's okay.
>>>>>
>>>>> The script is good enough when the number of possibly unsafe spots is
>>>>> low enough for careful manual review.
>>>>>
>>>>> When I ask for improvements that, in your opinion, go beyond "good
>>>>> enough", please push back.  I'm sure we can work it out together.
>>>>>
>>>>>> @@ -0,0 +1,231 @@
>>>>>> +// Use ERRP_AUTO_PROPAGATE (see include/qapi/error.h)
>>>>>> +//
>>>>>> +// Copyright (c) 2020 Virtuozzo International GmbH.
>>>>>> +//
>>>>>> +// This program is free software; you can redistribute it and/or mo=
dify
>>>>>> +// it under the terms of the GNU General Public License as publishe=
d by
>>>>>> +// the Free Software Foundation; either version 2 of the License, o=
r
>>>>>> +// (at your option) any later version.
>>>>>> +//
>>>>>> +// This program is distributed in the hope that it will be useful,
>>>>>> +// but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>>>> +// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>>>> +// GNU General Public License for more details.
>>>>>> +//
>>>>>> +// You should have received a copy of the GNU General Public Licens=
e
>>>>>> +// along with this program.  If not, see <http://www.gnu.org/licens=
es/>.
>>>>>> +//
>>>>>> +// Usage example:
>>>>>> +// spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>>>>>> +//  --macro-file scripts/cocci-macro-file.h --in-place --no-show-di=
ff \
>>>>>> +//  --max-width 80 blockdev-nbd.c qemu-nbd.c \
>>>>>
>>>>> You have --max-width 80 here, but not in the commit message.  Default
>>>>> seems to be 78.  Any particular reason to change it to 80?
>>>>
>>>> Hmm. As I remember, without this parameter, reindenting doesn't work c=
orrectly.
>>>> So, I'm OK with "--max-width 78", but I doubt that it will work withou=
t a parameter.
>>>> Still, may be I'm wrong, we can check it.
>>>
>>> If you can point to an example where --max-width helps, keep it, and
>>> update the commit message to match.  Else, drop it.
>>>
>>>>>
>>>>>> +//  {block/nbd*,nbd/*,include/block/nbd*}.[hc]
>=20
> As our discussion shows, this script is somewhat hard to understand.
> That's okay, it solves a somewhat thorny problem, and I don't have
> better ideas.  But let me state the intended transformations once more,
> so I don't get lost in the details.
>=20
> Motivation:
>=20
> 1. Make error propagation less error-prone and improve stack backtraces
>=20
>     The "receive error in &local_error, propagate to @errp" pattern is
>     tedious, error-prone, and produces unhelpful stack backtraces with
>     &error_abort.
>=20
>     ERRP_AUTO_PROPAGATE() removes manual propagation.  It additionally
>     gives us the stack backtraces we want.
>=20
> 2. Improve error messages with &error_fatal
>=20
>     Passing @errp to error_append_hint(), error_prepend() or
>     error_vprepend() is useless when @errp is &error_fatal.
>=20
>     ERRP_AUTO_PROPAGATE() fixes this by delaying &error_fatal handling
>     until the automatic propagation.
>=20
> The intended transformation has three parts:
>=20
> * Replace declaration of @local_err by ERRP_AUTO_PROPAGATE() where
>    needed for 1 or 2.

actually, we just add macro invocation. local_err is removed together with
other conversions.

>=20
>    It's needed when we also drop some error propagation from the function
>    (motivation 1), or the function calls error_append_hint(),
>    error_prepend() or error_vprepend() (motivation 2).  A function could
>    do both.  I'll refer back to this below.
>=20
> * Drop error_propagate(errp, local_err)
>=20
>    Special case: error_propagate_prepend(errp, local_err, ...) becomes
>    error_prepend(errp, ...).
>=20
>    Only correct if there is no other such error_propagate() /
>    error_propagate_prepend() on any path from the here to return.
>=20
> * Replace remaining use of @local_err by *errp
>=20
>>>>>> +
>>>>>> +// Switch unusual (Error **) parameter names to errp
>>>>>
>>>>> Let's drop the parenthesis around Error **
>>>>>
>>>>>> +// (this is necessary to use ERRP_AUTO_PROPAGATE).
>>>>>
>>>>> Perhaps ERRP_AUTO_PROPAGATE() should be ERRP_AUTO_PROPAGATE(errp) to
>>>>> make the fact we're messing with @errp more obvious.  Too late; I
>>>>> shouldn't rock the boat that much now.
>>>>>
>>>>>> +//
>>>>>> +// Disable optional_qualifier to skip functions with "Error *const =
*errp"
>>>>>> +// parameter.
>>>>>> +//
>>>>>> +// Skip functions with "assert(_errp && *_errp)" statement, as they=
 have
>>>>>> +// non generic semantics and may have unusual Error ** argument nam=
e for purpose
>>>>>
>>>>> non-generic
>>>>>
>>>>> for a purpose
>>>>>
>>>>> Wrap comment lines around column 70, please.  It's easier to read.
>>>>>
>>>>> Maybe
>>>>>
>>>>>       // Skip functions with "assert(_errp && *_errp)" statement, bec=
ause that
>>>>>       // signals unusual semantics, and the parameter name may well s=
erve a
>>>>>       // purpose.
>>>>
>>>> Sounds good.
>>>>
>>>>>
>>>>>> +// (like nbd_iter_channel_error()).
>>>>>> +//
>>>>>> +// Skip util/error.c to not touch, for example, error_propagate and
>>>>>> +// error_propagate_prepend().
>>>>>
>>>>> error_propagate()
>>>>>
>>>>> I much appreciate your meticulous explanation of what you skip and wh=
y.
>>>>>
>>>>>> +@ depends on !(file in "util/error.c") disable optional_qualifier@
>>>>>> +identifier fn;
>>>>>> +identifier _errp !=3D errp;
>>>>>> +@@
>>>>>> +
>>>>>> + fn(...,
>>>>>> +-   Error **_errp
>>>>>> ++   Error **errp
>>>>>> +    ,...)
>>>>>> + {
>>>>>> +(
>>>>>> +     ... when !=3D assert(_errp && *_errp)
>>>>>> +&
>>>>>> +     <...
>>>>>> +-    _errp
>>>>>> ++    errp
>>>>>> +     ...>
>>>>>> +)
>>>>>> + }
>>>>>
>>>>> This rule is required to make the actual transformations (below) work
>>>>> even for parameters with names other than @errp.  I believe it's not
>>>>> used in this series.  In fact, I can't see a use for it in the entire
>>>>> tree right now.  Okay anyway.
>>>>>
>>>>>> +
>>>>>> +// Add invocation of ERRP_AUTO_PROPAGATE to errp-functions where ne=
cessary
>>>>>> +//
>>>>>> +// Note, that without "when any" final "..." may not want to mach s=
omething
>>>>>
>>>>> s/final "..." may not mach/the final "..." does not match/
>>>>>
>>>>>> +// matched by previous pattern, i.e. the rule will not match double
>>>>>> +// error_prepend in control flow like in vfio_set_irq_signaling().
>>>>>
>>>>> Can't say I fully understand Coccinelle there.  I figure you came to
>>>>> this knowledge the hard way.
>>>>
>>>> It's follows from smpl grammar document:
>>>>
>>>> "Implicitly, =E2=80=9C...=E2=80=9D matches the shortest path between s=
omething that matches the pattern before the dots (or the beginning of the =
function, if there is nothing before the dots) and something that matches t=
he pattern after the dots (or the end of the function, if there is nothing =
after the dots)."
>>>> ...
>>>> "_when any_ removes the aforementioned constraint that =E2=80=9C...=E2=
=80=9D matches the shortest path"
>>>
>>> Let me think that through.
>>>
>>> The pattern with the cases other than error_prepend() omitted:
>>>
>>>        fn(..., Error **errp, ...)
>>>        {
>>>       +   ERRP_AUTO_PROPAGATE();
>>>           ...  when !=3D ERRP_AUTO_PROPAGATE();
>>>           error_prepend(errp, ...);
>>>           ... when any
>>>        }
>>>
>>> Tail of vfio_set_irq_signaling():
>>>
>>>           name =3D index_to_str(vbasedev, index);
>>>           if (name) {
>>>               error_prepend(errp, "%s-%d: ", name, subindex);
>>>           } else {
>>>               error_prepend(errp, "index %d-%d: ", index, subindex);
>>>           }
>>>           error_prepend(errp,
>>>                         "Failed to %s %s eventfd signaling for interrup=
t ",
>>>                         fd < 0 ? "tear down" : "set up", action_to_str(=
action));
>>>           return ret;
>>>       }
>>>
>>> The pattern's first ... matches a "shortest" path to an error_prepend()=
,
>>> where "shortest" means "does not cross an error_prepend().  Its when
>>> clause makes us ignore functions that already use ERRP_AUTO_PROPAGATE()=
.
>>>
>>> There are two such "shortest" paths, one to the first error_prepend() i=
n
>>> vfio_set_irq_signaling(), and one to the second.  Neither path to the
>>> third one is not "shortest": they both cross one of the other two
>>> error_prepend().
>>>
>>> The pattern' s second ... matches a path from a matched error_prepend()
>>> to the end of the function.  There are two paths.  Both cross the third
>>> error_prepend().  You need "when any" to make the pattern match anyway.
>>>
>>> Alright, I think I got it.  But now I'm paranoid about ... elsewhere.
>>> For instance, here's rule1 with error_propagate_prepend() omitted:
>>>
>>>       // Match scenarios with propagation of local error to errp.
>>>       @rule1 disable optional_qualifier exists@
>>>       identifier fn, local_err;
>>>       symbol errp;
>>>       @@
>>>
>>>        fn(..., Error **errp, ...)
>>>        {
>>>            ...
>>>            Error *local_err =3D NULL;
>>>            ...
>>>            error_propagate(errp, local_err);
>>>            ...
>>>        }
>>>
>>> The second and third ... won't match anything containing
>>> error_propagate().  What if a function has multiple error_propagate() o=
n
>>> all paths?
>>
>> I thought about this, but decided that double error propagation is a str=
ange pattern, and may be better not match it...
>=20
> I'm fine with not touching "strange" patterns.  But we do at least in
> the example I gave below: we still add ERRP_AUTO_PROPAGATE().
>=20
> We either avoid that in the Coccinelle script,

I think avoiding is best thing, and it seems possible as you proposed.

> or we catch it
> afterwards.  Catching it afterwards should be feasible:
>=20
> * If we also drop some error propagation from this function: okay.
>=20
> * If this function call error_append_hint(), error_prepend() or
>    error_vprepend(): okay.
>=20
> * Else: unwanted, back out.
>=20
> Moreover, I'd like us to double-check we really don't want to touch the
> things we don't touch.  Feels feasible to me, too: after running
> Coccinelle, search for unconverted error_append_hint(), error_prepend(),
> error_vprepend(), error_propagate_prepend(), error_propagate().
>=20
>>> Like this one:
>>>
>>>       extern foo(int, Error **);
>>>       extern bar(int, Error **);
>>>
>>>       void frob(Error **errp)
>>>       {
>>>           Error *local_err =3D NULL;
>>>           int arg;
>>>
>>>           foo(arg, errp);
>>>           bar(arg, &local_err);
>>>           error_propagate(errp, local_err);
>>>           bar(arg + 1, &local_err);
>>>           error_propagate(errp, local_err);
>>>       }
>>>
>>> This is actually a variation of error.h's "Receive and accumulate
>>> multiple errors (first one wins)" code snippet.
>>
>> ah yes, we can propagate to already filled errp, which just clean local_=
err.
>>
>>>
>>> The Coccinelle script transforms it like this:
>>>
>>>        void frob(Error **errp)
>>>        {
>>>       +    ERRP_AUTO_PROPAGATE();
>>>            Error *local_err =3D NULL;
>>>            int arg;
>>>
>>> The rule that adds ERRP_AUTO_PROPAGATE() matches (it has ... when any),
>>> but rule1 does not, and we therefore don't convert any of the
>>> error_propagate().
>>>
>>> The result isn't wrong, just useless.
>>>
>>> Is this the worst case?
>>>
>>> Possible improvement to the ERRP_AUTO_PROPAGATE() rule: don't use
>>> "... when any" in the error_propagate() case, only in the other cases.
>>> Would that help?
>>
>> I think not, as it will anyway match functions with error_prepend (and a=
ny
>> number of following error_propagate calls)...
>=20
> I'm not sure I understand this sentence.
>=20
> The aim of my "possible improvement" is to avoid unwanted
> ERRP_AUTO_PROPAGATE() in the Coccinelle script.  We can instead search
> for unwanted ones after the Coccinelle run, and back them out.

You are right.

>=20
>>> I think this is the only other rule with "..." matching control flow.
>>>
>>>>>
>>>>>> +//
>>>>>> +// Note, "exists" says that we want apply rule even if it matches n=
ot on
>>>>>> +// all possible control flows (otherwise, it will not match standar=
d pattern
>>>>>> +// when error_propagate() call is in if branch).
>>>>>
>>>>> Learned something new.  Example: kvm_set_kvm_shadow_mem().
>>>>>
>>>>> Spelling it "exists disable optional_qualifier" would avoid giving
>>>>> readers the idea we're disabling "exists", but Coccinelle doesn't let
>>>>> us.  Oh well.
>>>>>
>>>>>> +@ disable optional_qualifier exists@
>>>>>> +identifier fn, local_err, errp;
>>>>>
>>>>> I believe this causes
>>>>>
>>>>>        warning: line 98: errp, previously declared as a metavariable,=
 is used as an identifier
>>>>>        warning: line 104: errp, previously declared as a metavariable=
, is used as an identifier
>>>>>        warning: line 106: errp, previously declared as a metavariable=
, is used as an identifier
>>>>>        warning: line 131: errp, previously declared as a metavariable=
, is used as an identifier
>>>>>        warning: line 192: errp, previously declared as a metavariable=
, is used as an identifier
>>>>>        warning: line 195: errp, previously declared as a metavariable=
, is used as an identifier
>>>>>        warning: line 228: errp, previously declared as a metavariable=
, is used as an identifier
>>>>>
>>>>> Making @errp symbol instead of identifier should fix this.
>>>>
>>>> Hmm, I didn't see these warnings.. But yes, it should be symbol.
>>>>
>>>>>
>>>>>> +@@
>>>>>> +
>>>>>> + fn(..., Error **errp, ...)
>>>>>> + {
>>>>>> ++   ERRP_AUTO_PROPAGATE();
>>>>>> +    ...  when !=3D ERRP_AUTO_PROPAGATE();
>>>>>> +(
>>>>>> +    error_append_hint(errp, ...);
>>>>>> +|
>>>>>> +    error_prepend(errp, ...);
>>>>>> +|
>>>>>> +    error_vprepend(errp, ...);
>>>>>> +|
>>>>>> +    Error *local_err =3D NULL;
>>>>>> +    ...
>>>>>> +(
>>>>>> +    error_propagate_prepend(errp, local_err, ...);
>>>>>> +|
>>>>>> +    error_propagate(errp, local_err);
>>>>>> +)
>>>>>> +)
>>>>>> +    ... when any
>>>>>> + }
>>>>>> +
>>>>>> +
>>>>>> +// Match scenarios with propagation of local error to errp.
>>>>>> +@rule1 disable optional_qualifier exists@
>>>>>> +identifier fn, local_err;
>>>>>> +symbol errp;
>>>>>> +@@
>>>>>> +
>>>>>> + fn(..., Error **errp, ...)
>>>>>> + {
>>>>>> +     ...
>>>>>> +     Error *local_err =3D NULL;
>>>>>> +     ...
>>>>>> +(
>>>>>> +    error_propagate_prepend(errp, local_err, ...);
>>>>>> +|
>>>>>> +    error_propagate(errp, local_err);
>>>>>> +)
>>>>>
>>>>> Indentation off by one.
>>>>>
>>>>>> +     ...
>>>>>> + }
>>>>>> +
>>>>>> +// Convert special case with goto in separate.
>>>>>
>>>>> s/in separate/separately/
>>>>>
>>>>>> +// We can probably merge this into the following hunk with help of =
( | )
>>>>>> +// operator, but it significantly reduce performance on block.c par=
sing (or it
>>>>>
>>>>> s/reduce/reduces/
>>>>>
>>>>>> +// hangs, I don't know)
>>>>>
>>>>> Sounds like you tried to merge this into the following hunk, but then
>>>>> spatch took so long on block.c that you killed it.  Correct?
>>>>
>>>> Yes.
>>>
>>> I'd say something like "I tried merging this into the following rule th=
e
>>> obvious way, but it made Coccinelle hang on block.c."
>>>
>>>>>
>>>>>> +//
>>>>>> +// Note interesting thing: if we don't do it here, and try to fixup=
 "out: }"
>>>>>> +// things later after all transformations (the rule will be the sam=
e, just
>>>>>> +// without error_propagate() call), coccinelle fails to match this =
"out: }".
>>>>>
>>>>> Weird, but not worth further investigation.
>>>>
>>>> It partially match to the idea which I saw somewhere in coccinelle doc=
umentation,
>>>> that coccinelle converts correct C code to correct C code. "out: }" is=
 an example
>>>> of incorrect, impossible code flow, and coccinelle can't work with it.=
.. But it's
>>>> just a thought.
>>>>
>>>>>
>>>>>> +@@
>>>>>> +identifier rule1.fn, rule1.local_err, out;
>>>>>> +symbol errp;
>>>>>> +@@
>>>>>> +
>>>>>> + fn(...)
>>>>>> + {
>>>>>> +     <...
>>>>>> +-    goto out;
>>>>>> ++    return;
>>>>>> +     ...>
>>>>>> +- out:
>>>>>> +-    error_propagate(errp, local_err);
>>>>>
>>>>> You neglect to match error_propagate_prepend().  Okay, because (1) th=
at
>>>>> pattern doesn't occur in the tree right now, and (2) if it gets added=
,
>>>>> gcc will complain.
>>>>
>>>> No, because it should not removed. error_propagate_prepend should be c=
onverted
>>>> to prepend, not removed. So, corresponding gotos should not be removed=
 as well.
>>>
>>> You're right.
>>>
>>>>>
>>>>>> + }
>>>>>> +
>>>>>> +// Convert most of local_err related staff.
>>>>>
>>>>> s/staff/stuff/
>>>>>
>>>>>> +//
>>>>>> +// Note, that we update everything related to matched by rule1 func=
tion name
>>>>>> +// and local_err name. We may match something not related to the pa=
ttern
>>>>>> +// matched by rule1. For example, local_err may be defined with the=
 same name
>>>>>> +// in different blocks inside one function, and in one block follow=
 the
>>>>>> +// propagation pattern and in other block doesn't. Or we may have s=
everal
>>>>>> +// functions with the same name (for different configurations).
>>>>>
>>>>> Context: rule1 matches functions that have all three of
>>>>>
>>>>> * an Error **errp parameter
>>>>>
>>>>> * an Error *local_err =3D NULL variable declaration
>>>>>
>>>>> * an error_propagate(errp, local_err) or error_propagate_prepend(errp=
,
>>>>>      local_err, ...) expression, where @errp is the parameter and
>>>>>      @local_err is the variable.
>>>>>
>>>>> If I understand you correctly, you're pointing out two potential issu=
es:
>>>>>
>>>>> 1. This rule can match functions rule1 does not match if there is
>>>>> another function with the same name that rule1 does match.
>>>>>
>>>>> 2. This rule matches in the entire function matched by rule1, even wh=
en
>>>>> parts of that function use a different @errp or @local_err.
>>>>>
>>>>> I figure these apply to all rules with identifier rule1.fn, not just
>>>>> this one.  Correct?
>>>>
>>>> Yes.
>>>
>>> Thanks!
>>>
>>>>>
>>>>> Regarding 1.  There must be a better way to chain rules together, but=
 I
>>>>> don't know it.
>>>>>    Can we make Coccinelle at least warn us when it converts
>>>>> multiple functions with the same name?  What about this:
>>>>>
>>>>>       @initialize:python@
>>>>>       @@
>>>>>       fnprev =3D {}
>>>>>
>>>>>       def pr(fn, p):
>>>>>           print("### %s:%s: %s()" % (p[0].file, p[0].line, fn))
>>>>>
>>>>>       @r@
>>>>>       identifier rule1.fn;
>>>>>       position p;
>>>>>       @@
>>>>>        fn(...)@p
>>>>>        {
>>>>>            ...
>>>>>        }
>>>>>       @script:python@
>>>>>           fn << rule1.fn;
>>>>>           p << r.p;
>>>>>       @@
>>>>>       if fn not in fnprev:
>>>>>           fnprev[fn] =3D p
>>>>>       else:
>>>>>           if fnprev[fn]:
>>>>
>>>> hmm, the condition can't be false
>>>>
>>>>>               pr(fn, fnprev[fn])
>>>>>               fnprev[fn] =3D None
>>>>>           pr(fn, p)
>>>>
>>>> and we'll miss next duplication..
>>>
>>> The idea is
>>>
>>>       first instance of fn:
>>>           fn not in fnprev
>>>           fnprev[fn] =3D position of instance
>>>           don't print
>>>       second instance:
>>>           fnprev[fn] is the position of the first instance
>>>           print first two instances
>>>       subsequent instances: fnprev[fn] is None
>>>           print this instance
>>>
>>> I might have screwed up the coding, of course :)
>>>
>>>> But I like the idea.
>>>>
>>>>>
>>>>> For each function @fn matched by rule1, fncnt[fn] is an upper limit o=
f
>>>>> the number of functions with the same name we touch.  If it's more th=
an
>>>>> one, we print.
>>>>>
>>>>> Reports about a dozen function names for the whole tree in my testing=
.
>>>>> Inspecting the changes to them manually is feasible.  None of them ar=
e
>>>>> in files touched by this series.
>>>>>
>>>>> The line printed for the first match is pretty useless for me: it poi=
nts
>>>>> to a Coccinelle temporary file *shrug*.
>>>>>
>>>>> Regarding 2.  Shadowing @errp or @local_err would be in bad taste, an=
d I
>>>>> sure hope we don't do that.  Multiple @local_err variables... hmm.
>>>>> Perhaps we could again concoct some script rules to lead us to spots =
to
>>>>> check manually.  See below for my attempt.
>>>>>
>>>>> What's the worst that could happen if we blindly converted such code?
>>>>> The answer to that question tells us how hard to work on finding and
>>>>> checking these guys.
>>>>>
>>>>>> +//
>>>>>> +// Note also that errp-cleaning functions
>>>>>> +//   error_free_errp
>>>>>> +//   error_report_errp
>>>>>> +//   error_reportf_errp
>>>>>> +//   warn_report_errp
>>>>>> +//   warn_reportf_errp
>>>>>> +// are not yet implemented. They must call corresponding Error* - f=
reeing
>>>>>> +// function and then set *errp to NULL, to avoid further propagatio=
n to
>>>>>> +// original errp (consider ERRP_AUTO_PROPAGATE in use).
>>>>>> +// For example, error_free_errp may look like this:
>>>>>> +//
>>>>>> +//    void error_free_errp(Error **errp)
>>>>>> +//    {
>>>>>> +//        error_free(*errp);
>>>>>> +//        *errp =3D NULL;
>>>>>> +//    }
>>>>>> +@ exists@
>>>>>> +identifier rule1.fn, rule1.local_err;
>>>>>> +expression list args;
>>>>>> +symbol errp;
>>>>>> +@@
>>>>>> +
>>>>>> + fn(...)
>>>>>> + {
>>>>>> +     <...
>>>>>> +(
>>>>>
>>>>> Each of the following patterns applies anywhere in the function.
>>>>>
>>>>> First pattern: delete @local_err
>>>>>
>>>>>> +-    Error *local_err =3D NULL;
>>>>>
>>>>> Common case: occurs just once, not nested.  Anything else is suspicio=
us.
>>>>>
>>>>> Both can be detected in the resulting patches with a bit of AWK
>>>>> wizardry:
>>>>>
>>>>>        $ git-diff -U0 master..review-error-v8 | awk '/^@@ / { ctx =3D=
 $5; for (i =3D 6; i <=3D NF; i++) ctx =3D ctx " " $i; if (ctx !=3D octx) {=
 octx =3D ctx; n =3D 0 } } /^- *Error *\* *[A-Za-z0-9_]+ *=3D *NULL;/ { if =
(index($0, "E") > 6) print "nested\n    " ctx; if (n) print "more than one\=
n    " ctx; n++ }'
>>>>>        nested
>>>>>            static void xen_block_drive_destroy(XenBlockDrive *drive, =
Error **errp)
>>>>>        nested
>>>>>            static void xen_block_device_destroy(XenBackendInstance *b=
ackend,
>>>>>        nested
>>>>>            static void xen_block_device_destroy(XenBackendInstance *b=
ackend,
>>>>>        more than one
>>>>>            static void xen_block_device_destroy(XenBackendInstance *b=
ackend,
>>>>>
>>>>> Oh.
>>>>>
>>>>> xen_block_drive_destroy() nests its Error *local_err in a conditional=
.
>>>>>
>>>>> xen_block_device_destroy() has multiple Error *local_err.
>>>>>
>>>>> In both cases, manual review is required to ensure the conversion is
>>>>> okay.  I believe it is.
>>>>>
>>>>> Note that the AWK script relies on diff showing the function name in =
@@
>>>>> lines, which doesn't always work due to our coding style.
>>>>>
>>>>> For the whole tree, I get some 30 spots.  Feasible.
>>>>>
>>>>>> +|
>>>>>
>>>>> Second pattern: clear @errp after freeing it
>>>>>
>>>>>> +
>>>>>> +// Convert error clearing functions
>>>>>
>>>>> Suggest: Ensure @local_err is cleared on free
>>>>>
>>>>>> +(
>>>>>> +-    error_free(local_err);
>>>>>> ++    error_free_errp(errp);
>>>>>> +|
>>>>>> +-    error_report_err(local_err);
>>>>>> ++    error_report_errp(errp);
>>>>>> +|
>>>>>> +-    error_reportf_err(local_err, args);
>>>>>> ++    error_reportf_errp(errp, args);
>>>>>> +|
>>>>>> +-    warn_report_err(local_err);
>>>>>> ++    warn_report_errp(errp);
>>>>>> +|
>>>>>> +-    warn_reportf_err(local_err, args);
>>>>>> ++    warn_reportf_errp(errp, args);
>>>>>> +)
>>>>>
>>>>> As you mention above, these guys don't exist, yet.  Builds anyway,
>>>>> because this part of the rule is not used in this patch series.  You
>>>>> don't want to omit it, because then the script becomes unsafe to use.
>>>>>
>>>>> We could also open-code:
>>>>>
>>>>>       // Convert error clearing functions
>>>>>       (
>>>>>       -    error_free(local_err);
>>>>>       +    error_free(*errp);
>>>>>       +    *errp =3D NULL;
>>>>>       |
>>>>>       ... and so forth ...
>>>>>       )
>>>>>
>>>>> Matter of taste.  Whatever is easier to explain in the comments.  Sin=
ce
>>>>> you already wrote one...
>>>>
>>>> I just feel that using helper functions is safer way..
>>>>
>>>>>
>>>>> We talked about extending this series slightly so these guys are used=
.
>>>>> I may still look into that.
>>>>>
>>>>>> +?-    local_err =3D NULL;
>>>>>> +
>>>>>
>>>>> The new helpers clear @local_err.  Assignment now redundant, delete.
>>>>> Okay.
>>>>>
>>>>>> +|
>>>>>
>>>>> Third and fourth pattern: delete error_propagate()
>>>>>
>>>>>> +-    error_propagate_prepend(errp, local_err, args);
>>>>>> ++    error_prepend(errp, args);
>>>>>> +|
>>>>>> +-    error_propagate(errp, local_err);
>>>>>> +|
>>>>>
>>>>> Fifth pattern: use @errp directly
>>>>>
>>>>>> +-    &local_err
>>>>>> ++    errp
>>>>>> +)
>>>>>> +     ...>
>>>>>> + }
>>>>>> +
>>>>>> +// Convert remaining local_err usage. It should be different kinds =
of error
>>>>>> +// checking in if operators. We can't merge this into previous hunk=
, as this
>>>>>
>>>>> In if conditionals, I suppose.  It's the case for this patch.  If I
>>>>> apply the script to the whole tree, the rule gets also applied in oth=
er
>>>>> contexts.  The sentence might mislead as much as it helps.  Keep it o=
r
>>>>> delete it?
>>>>
>>>> Maybe, just be more honest: "It should be ..., but it may be any other=
 pattern, be careful"
>>>
>>> "Need to be careful" means "needs careful manual review", which I
>>> believe is not feasible; see "Preface to my review of this script"
>>> above.
>>>
>>> But do we really need to be careful here?
>>>
>>> This rule should apply only where we added ERRP_AUTO_PROPAGATE().
>>>
>>> Except when rule chaining via function name fails us, but we plan to
>>> detect that and review manually, so let's ignore this issue here.
>>>
>>> Thanks to ERRP_AUTO_PROPAGATE(), @errp is not null.  Enabling
>>> replacement of @local_err by @errp is its whole point.
>>>
>>> What exactly do we need to be careful about?
>>
>> Hmm.. About some unpredicted patterns. OK, then "For example, different =
kinds of .."
>=20
> Something like this, perhaps?
>=20
>         // Convert remaining local_err usage, typically error checking.
>         // We can't merge this into previous hunk, as this conflicts with=
 other
>         // substitutions in it (at least with "- local_err =3D NULL").

OK

>=20
>>>>>> +// conflicts with other substitutions in it (at least with "- local=
_err =3D NULL").
>>>>>> +@@
>>>>>> +identifier rule1.fn, rule1.local_err;
>>>>>> +symbol errp;
>>>>>> +@@
>>>>>> +
>>>>>> + fn(...)
>>>>>> + {
>>>>>> +     <...
>>>>>> +-    local_err
>>>>>> ++    *errp
>>>>>> +     ...>
>>>>>> + }
>>>>>> +
>>>>>> +// Always use the same patter for checking error
>>>>>
>>>>> s/patter/pattern/
>>>>>
>>>>>> +@@
>>>>>> +identifier rule1.fn;
>>>>>> +symbol errp;
>>>>>> +@@
>>>>>> +
>>>>>> + fn(...)
>>>>>> + {
>>>>>> +     <...
>>>>>> +-    *errp !=3D NULL
>>>>>> ++    *errp
>>>>>> +     ...>
>>>>>> + }
>>>>>
>>>
>=20


--=20
Best regards,
Vladimir

