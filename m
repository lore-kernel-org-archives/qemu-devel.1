Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	YOU_INHERIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600FAC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 07:18:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0968E20663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 07:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cHr/eMv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0968E20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDk1I-0006BS-QG
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 03:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jDjvp-00057T-Fd
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 03:13:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jDjvi-0007fi-QW
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 03:13:01 -0400
Received: from mail-am6eur05on2096.outbound.protection.outlook.com
 ([40.107.22.96]:31264 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jDjvV-0004bo-RA; Mon, 16 Mar 2020 03:12:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GebB/0I+lBj3yeVxh+ApizH5/DMr3wsnHxYxyoob5/Rj6kmrK5C11rXPYVvvza7pWI3ERc7hi0eDM7wx8Ah69MzoV7pE6km25j6oEMTkeNUJsxGycWkzrBzsDbseEPaUw4qZvpSu0B+m4K5+mWXkfekl/cPCIZ0JoaXzMj+5EeUkNipduL4txkhX+h7BWQulyhBoiIY4B0rEofla44raaFxil/r8+1fZWYHzu9SB4IPmWaUTBQljdJw0FdI6I6snn47QjosE1C4mzdPAgbHkbKYWGxnAk8BO2JKP0QBstw0I6ixtSsWAWU/fbYqayusZhuOj4EpvPjxDfV5N2/o4DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vu9nYE4abfphjVrX8tLLZNJf8qk15QPLbNm3uGX4eFk=;
 b=UqbfKk425jI4rQqmCgsFHWU13cXcRDaNYNYx+W1jK5CxYmPJeOLKTIt7OvtldsO29lvys0ioVIip5myubZqiJ1o7SrfTVgz36QBbmyz4aj6dxMlOFa9e5UFZrfWLTO8i3mHNEcpjKfT/Lg2X7RnDMSl789wXKoWnd4xa1EuoGkAcK1nLQsSZtEtCuJuEQzy87SFwOFD2UpdVskcJ835txrxhc23oUOFHiynfqJ5Mq120JWQ32qxMx7P4dl62/IDgFYyY6U1umYCh1GCduIFj50YOuhkQeYlrIxQwVO48tOP3P9ywyTgXhUEfcIgMQqnbf2/TGNxlYu4vJPDUpOzZ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vu9nYE4abfphjVrX8tLLZNJf8qk15QPLbNm3uGX4eFk=;
 b=cHr/eMv4KURwggp3o/PKrZXmcufHuDQoNi8mlkU+s5ZzeA5lvpa6ZtchWoseA4CCKwZXMXr/TjnI90e67x3TaJXgVgv3+geJZ1WoGQ+9VXuQKkw4PE75VqRG1W2INND8qMkt8nV8qZN/cGusZisTfp2haEwlgJCmTazJRmKtoJE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com (10.175.35.136) by
 HE1PR0802MB2410.eurprd08.prod.outlook.com (10.175.33.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13; Mon, 16 Mar 2020 07:12:36 +0000
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f]) by HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f%12]) with mapi id 15.20.2814.021; Mon, 16 Mar
 2020 07:12:36 +0000
Subject: Re: [PATCH v9 02/10] scripts: Coccinelle script to use
 ERRP_AUTO_PROPAGATE()
To: Markus Armbruster <armbru@redhat.com>
References: <20200312085936.9552-1-vsementsov@virtuozzo.com>
 <20200312085936.9552-3-vsementsov@virtuozzo.com>
 <874kuto7hq.fsf@dusky.pond.sub.org>
 <4a70c6ee-10a2-fdc3-f8df-88c05340398b@virtuozzo.com>
 <875zf8gt2m.fsf@dusky.pond.sub.org>
 <7c6f9a91-76cf-242d-8166-0693ec14b24d@virtuozzo.com>
 <87blozex9v.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f9c8de73-38d8-a14c-632a-8e57d18e00c8@virtuozzo.com>
Date: Mon, 16 Mar 2020 10:12:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <87blozex9v.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0902CA0011.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::21) To HE1PR0802MB2507.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.126] (185.215.60.205) by
 HE1PR0902CA0011.eurprd09.prod.outlook.com (2603:10a6:3:e5::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.18 via Frontend Transport; Mon, 16 Mar 2020 07:12:32 +0000
X-Originating-IP: [185.215.60.205]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 243608fc-34c1-4abd-d3f3-08d7c979672a
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2410:
X-Microsoft-Antispam-PRVS: <HE1PR0802MB2410CCC868D18BA7509B3180C1F90@HE1PR0802MB2410.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(136003)(39840400004)(366004)(396003)(346002)(199004)(316002)(66574012)(30864003)(52116002)(4326008)(53546011)(478600001)(7416002)(8936002)(31686004)(6666004)(5660300002)(66556008)(66476007)(66946007)(36756003)(86362001)(2616005)(956004)(16526019)(81156014)(81166006)(8676002)(31696002)(26005)(186003)(2906002)(6916009)(54906003)(6486002)(16576012)(2004002)(579004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:HE1PR0802MB2410;
 H:HE1PR0802MB2507.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UEJpxfhjAZaGc5gwKNQYL5GxcR24Asu/DyyfcSwrm7MZMlXsI0q8gg73skRQcmAlbHwz7ucejE/stbt9etrf0e4xVxrvZdnc4RzH0jhqB9fV7pq/4AFTGQxXYEbOm+w1FH1OlYBZvrPQx/0IYukma7IfzlDFP8TZ1GPhOjF9EX7YFSLIixgjGnqrW6Ht1S6pQtEBRWfJ+FWjaLErGFfn71K4cDYiYaqpOMqcIkGCWi7NUeYSJeZFwq4Ljd/1qAvhrbGtEbudD4lEU8BVqELjnLaQHBuopKjogWX2ISjD+/Ra2UzmodJ2vSyzeG9jyohd/dTg2PxtowLxgq+DZ1MXLvPG+rowgY5/uTaEy7m+KzhAoD9nwzoetBQD9fsynMnT74sFgAoAT+2D7UpWbAGURl/+ugtlAcJbn1+xYd9YiQfr7xszwrc/ct0tSt7P+IOc/HjorsPBbV4QzKeR7TLUvlSMu95XYeY31RTMya+hKs/ucPMZUT9xmGX9QrIU1PE//6f/wdoBbl81W8dJ+hwzL3/1t3ERDzit+gJ5uoFuOlvHk1mgSHhGIX1wgb9/TJtf
X-MS-Exchange-AntiSpam-MessageData: vI6zXZtyahAKomIS1NbYqrPZjiTwLpobomDeb/eD1hUXyCP8FVSt9lw7DGzUta35K/129LcHpkWvlFse/5YsxYLH4UrrT8dPq6pEKgQejMJCNofzI0qajaflak8S9Kn0X5R9lNR68H+SNpzHYN8t4w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 243608fc-34c1-4abd-d3f3-08d7c979672a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 07:12:36.4336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DqAu+BM0xeDWr6uKgWENyqfrHMo2k7zvCoWHXcMitPHrReNSRYhXHajgdmW5N1Iha3sSjaY4j3hMo8rRg+fqigRWfE+W5rTWRx/xEZDyPC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2410
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.22.96
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



On 14.03.2020 00:54, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>=20
>> 13.03.2020 18:42, Markus Armbruster wrote:
>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>
>>>> 12.03.2020 19:36, Markus Armbruster wrote:
>>>>> I may have a second look tomorrow with fresher eyes, but let's get th=
is
>>>>> out now as is.
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
>>>>>>     --max-width 80 FILES...
>>>>>>
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
>>>>>> Cc: qemu-devel@nongnu.org
>>>>>> Cc: qemu-block@nongnu.org
>>>>>> Cc: xen-devel@lists.xenproject.org
>>>>>>
>>>>>>     scripts/coccinelle/auto-propagated-errp.cocci | 327 ++++++++++++=
++++++
>>>>>>     include/qapi/error.h                          |   3 +
>>>>>>     MAINTAINERS                                   |   1 +
>>>>>>     3 files changed, 331 insertions(+)
>>>>>>     create mode 100644 scripts/coccinelle/auto-propagated-errp.cocci
>>>>>>
>>>>>> diff --git a/scripts/coccinelle/auto-propagated-errp.cocci b/scripts=
/coccinelle/auto-propagated-errp.cocci
>>>>>> new file mode 100644
>>>>>> index 0000000000..7dac2dcfa4
>>>>>> --- /dev/null
>>>>>> +++ b/scripts/coccinelle/auto-propagated-errp.cocci
>>>>>> @@ -0,0 +1,327 @@
>>>>>> +// Use ERRP_AUTO_PROPAGATE (see include/qapi/error.h)
>>>>>> +//
>>>>>> +// Copyright (c) 2020 Virtuozzo International GmbH.
>>>>>> +//
>>>>>> +// This program is free software; you can redistribute it and/or
>>>>>> +// modify it under the terms of the GNU General Public License as
>>>>>> +// published by the Free Software Foundation; either version 2 of t=
he
>>>>>> +// License, or (at your option) any later version.
>>>>>> +//
>>>>>> +// This program is distributed in the hope that it will be useful,
>>>>>> +// but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>>>> +// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>>>> +// GNU General Public License for more details.
>>>>>> +//
>>>>>> +// You should have received a copy of the GNU General Public Licens=
e
>>>>>> +// along with this program.  If not, see
>>>>>> +// <http://www.gnu.org/licenses/>.
>>>>>> +//
>>>>>> +// Usage example:
>>>>>> +// spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>>>>>> +//  --macro-file scripts/cocci-macro-file.h --in-place \
>>>>>> +//  --no-show-diff --max-width 80 FILES...
>>>>>> +//
>>>>>> +// Note: --max-width 80 is needed because coccinelle default is les=
s
>>>>>> +// than 80, and without this parameter coccinelle may reindent some
>>>>>> +// lines which fit into 80 characters but not to coccinelle default=
,
>>>>>> +// which in turn produces extra patch hunks for no reason.
>>>>>
>>>>> This is about unwanted reformatting of parameter lists due to the ___
>>>>> chaining hack.  --max-width 80 makes that less likely, but not
>>>>> impossible.
>>>>>
>>>>> We can search for unwanted reformatting of parameter lists.  I think
>>>>> grepping diffs for '^\+.*Error \*\*' should do the trick.  For the wh=
ole
>>>>> tree, I get one false positive (not a parameter list), and one hit:
>>>>>
>>>>>        @@ -388,8 +388,10 @@ static void object_post_init_with_type(O
>>>>>             }
>>>>>         }
>>>>>
>>>>>        -void object_apply_global_props(Object *obj, const GPtrArray *=
props, Error **errp)
>>>>>        +void object_apply_global_props(Object *obj, const GPtrArray *=
props,
>>>>>        +                               Error **errp)
>>>>>         {
>>>>>        +    ERRP_AUTO_PROPAGATE();
>>>>>             int i;
>>>>>
>>>>>             if (!props) {
>>>>>
>>>>> Reformatting, but not unwanted.
>>>>
>>>> Yes, I saw it. This line is 81 character length, so it's OK to fix it =
in one hunk with
>>>> ERRP_AUTO_PROPAGATE addition even for non-automatic patch.
>>>
>>> Agree.
>>>
>>>>>
>>>>> The --max-width 80 hack is good enough for me.
>>>>>
>>>>> It does result in slightly long transformed lines, e.g. this one in
>>>>> replication.c:
>>>>>
>>>>>        @@ -113,7 +113,7 @@ static int replication_open(BlockDriverS
>>>>>                 s->mode =3D REPLICATION_MODE_PRIMARY;
>>>>>                 top_id =3D qemu_opt_get(opts, REPLICATION_TOP_ID);
>>>>>                 if (top_id) {
>>>>>        -            error_setg(&local_err, "The primary side does not=
 support option top-id");
>>>>>        +            error_setg(errp, "The primary side does not suppo=
rt option top-id");
>>>>>                     goto fail;
>>>>>                 }
>>>>>             } else if (!strcmp(mode, "secondary")) {
>>>>>
>>>>> v8 did break this line (that's how I found it).  However, v9 still
>>>>> shortens the line, just not below the target.  All your + lines look
>>>>> quite unlikely to lengthen lines.  Let's not worry about this.
>>>>>
>>>>>> +// Switch unusual Error ** parameter names to errp
>>>>>> +// (this is necessary to use ERRP_AUTO_PROPAGATE).
>>>>>> +//
>>>>>> +// Disable optional_qualifier to skip functions with
>>>>>> +// "Error *const *errp" parameter.
>>>>>> +//
>>>>>> +// Skip functions with "assert(_errp && *_errp)" statement, because
>>>>>> +// that signals unusual semantics, and the parameter name may well
>>>>>> +// serve a purpose. (like nbd_iter_channel_error()).
>>>>>> +//
>>>>>> +// Skip util/error.c to not touch, for example, error_propagate() a=
nd
>>>>>> +// error_propagate_prepend().
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
>>>>>> +
>>>>>> +// Add invocation of ERRP_AUTO_PROPAGATE to errp-functions where
>>>>>> +// necessary
>>>>>> +//
>>>>>> +// Note, that without "when any" the final "..." does not mach
>>>>>> +// something matched by previous pattern, i.e. the rule will not ma=
tch
>>>>>> +// double error_prepend in control flow like in
>>>>>> +// vfio_set_irq_signaling().
>>>>>> +//
>>>>>> +// Note, "exists" says that we want apply rule even if it matches n=
ot
>>>>>> +// on all possible control flows (otherwise, it will not match
>>>>>> +// standard pattern when error_propagate() call is in if branch).
>>>>>> +@ disable optional_qualifier exists@
>>>>>> +identifier fn, local_err;
>>>>>> +symbol errp;
>>>>>> +@@
>>>>>> +
>>>>>> + fn(..., Error **errp, ...)
>>>>>> + {
>>>>>> ++   ERRP_AUTO_PROPAGATE();
>>>>>> +    ...  when !=3D ERRP_AUTO_PROPAGATE();
>>>>>> +(
>>>>>> +(
>>>>>> +    error_append_hint(errp, ...);
>>>>>> +|
>>>>>> +    error_prepend(errp, ...);
>>>>>> +|
>>>>>> +    error_vprepend(errp, ...);
>>>>>> +)
>>>>>> +    ... when any
>>>>>> +|
>>>>>> +    Error *local_err =3D NULL;
>>>>>> +    ...
>>>>>> +(
>>>>>> +    error_propagate_prepend(errp, local_err, ...);
>>>>>> +|
>>>>>> +    error_propagate(errp, local_err);
>>>>>> +)
>>>>>> +    ...
>>>>>> +)
>>>>>> + }
>>>>>> +
>>>>>> +
>>>>>> +// Match functions with propagation of local error to errp.
>>>>>> +// We want to refer these functions in several following rules, but=
 I
>>>>>> +// don't know a proper way to inherit a function, not just its name
>>>>>> +// (to not match another functions with same name in following rule=
s).
>>>>>> +// Not-proper way is as follows: rename errp parameter in functions
>>>>>> +// header and match it in following rules. Rename it back after all
>>>>>> +// transformations.
>>>>>> +//
>>>>>> +// The simplest case of propagation scheme is single definition of
>>>>>> +// local_err with at most one error_propagate_prepend or
>>>>>> +// error_propagate on each control-flow. Still, we want to match mo=
re
>>>>>> +// complex schemes too. We'll warn them with help of further rules.
>>>>>
>>>>> I think what we actually want is to examine instances of this pattern=
 to
>>>>> figure out whether and how we want to transform them.  Perhaps:
>>>>>
>>>>>        // The common case is a single definition of local_err with at=
 most one
>>>>>        // error_propagate_prepend() or error_propagate() on each cont=
rol-flow
>>>>>        // path. Instances of this case we convert with this script. F=
unctions
>>>>
>>>> For me, sounds a bit like "other things we don't convert".
>>>> Actually we convert other things too.
>>>
>>> What other patterns of error propagation do we convert?
>>
>> Something like in xen_block_device_destroy, why not? Otherwise, it's bet=
ter to avoid
>> matching things like xen_block_device_destroy, not just warn them.
>> But I'd prefer to proceed now as is to fit into 5.0.. Too much time alre=
ady
>> spent on this. So, I'm OK with your wording too.
>=20
> Let's scratch "Instances of this case we convert with this script."

OK

>=20
>>>>>        // with multiple definitions or propagates we want to examine
>>>>>        // manually. Later rules emit warnings to guide us to them.
>>>>>
>>>>>> +@rule1 disable optional_qualifier exists@
>>>>>> +identifier fn, local_err;
>>>>>> +symbol errp;
>>>>>> +@@
>>>>>> +
>>>>>> + fn(..., Error **
>>>>>> +-    errp
>>>>>> ++    ____
>>>>>> +    , ...)
>>>>>> + {
>>>>>> +     ...
>>>>>> +     Error *local_err =3D NULL;
>>>>>> +     ...
>>>>>> +(
>>>>>> +     error_propagate_prepend(errp, local_err, ...);
>>>>>> +|
>>>>>> +     error_propagate(errp, local_err);
>>>>>> +)
>>>>>> +     ...
>>>>>> + }
>>>>>> +
>>>>>> +
>>>>>> +// Warn several Error * definitions.
>>>>>> +@check1 disable optional_qualifier exists@
>>>>>> +identifier fn =3D rule1.fn, local_err, local_err2;
>>>>>
>>>>> Elsewhere, you use just rule.fn instead of fn =3D rule1.fn.  Any
>>>>> particular reason for the difference?
>>>>
>>>> I didn't find other way to ref check1.fn in next python rule. It just =
don't
>>>> work if I write here just rule1.fn.
>>>>
>>>>>
>>>>> With the ___ chaining hack, I doubt we still need "=3D rule1.fn" or
>>>>> "rule1.fn".  If I replace "fn =3D rule1.fn" and "rule.fn" by just "fn=
"
>>>>> everywhere, then apply the script to the complete tree, I get the sam=
e
>>>>> result.
>>>>
>>>> I think, it's more efficient to reuse names from previous rules. I thi=
nk it should
>>>> work faster (more information, less extra matching).
>>>
>>> Nope.  With my hacked up script (patch appended) Coccinelle is actually
>>> *faster* for the .[ch] touched by this series: with your unmodified
>>> script, it takes a bit over 12s on my box, with mine around 7s.  Output
>>> is identical.
>>>
>>> Never guess performance, always measure it :)
>>
>> Hmm, whole tree results would be better proof
>>
>>>
>>> Two notes on my script:
>>>
>>> * Unlike yours, it recognizes double-propagation in my test case.
>>>     Discussed below.
>>>
>>> * Its "several definitions of" warning includes positions.  That turned
>>>     out to be useless, but I've been too lazy to take that out again.
>>>
>>>>>
>>>>>> +@@
>>>>>> +
>>>>>> + fn(..., Error ** ____, ...)
>>>>>> + {
>>>>>> +     ...
>>>>>> +     Error *local_err =3D NULL;
>>>>>> +     ... when any
>>>>>> +     Error *local_err2 =3D NULL;
>>>>>> +     ... when any
>>>>>> + }
>=20
> This flags functions that have more than one declaration along any
> control flow path.  It doesn't flag this one:
>=20
>      void gnat(bool b, Error **errp)
>      {
>          if (b) {
>              Error *local_err =3D NULL;
>              foo(arg, &local_err);
>              error_propagate(errp, local_err);
>          } else {
>              Error *local_err =3D NULL;
>              bar(arg, &local_err);
>              error_propagate(errp, local_err);
>          }
>      }
>=20
> The Coccinelle script does the right thing for this one regardless.
>=20
> I'd prefer to have such functions flagged, too.  But spending time on
> convincing Coccinelle to do it for me is not worthwhile; I can simply
> search the diff produced by Coccinelle for deletions of declarations
> that are not indented exactly four spaces.
>=20
> But if we keep this rule, we should adjust its comment
>=20
>      // Warn several Error * definitions.
>=20
> because it sure suggests it also catches functions like the one I gave
> above.

Hmm, yes.. We can write "Warn several Error * definitions in _one_=20
control flow (it's not so trivial to match _any_ case with several=20
definitions with coccinelle)" or something like this.

>=20
>>>>>> +
>>>>>> +@ script:python @
>>>>>> +fn << check1.fn;
>>>>>> +@@
>>>>>> +
>>>>>> +print('Warning: function {} has several definitions of '
>>>>>> +      'Error * local variable'.format(fn))
>>>>>> +
>>>>>> +// Warn several propagations in control flow.
>>>>>> +@check2 disable optional_qualifier exists@
>>>>>> +identifier fn =3D rule1.fn;
>>>>>> +symbol errp;
>>>>>> +position p1, p2;
>>>>>> +@@
>>>>>> +
>>>>>> + fn(..., Error ** ____, ...)
>>>>>> + {
>>>>>> +     ...
>>>>>> +(
>>>>>> +     error_propagate_prepend(errp, ...);@p1
>>>>>> +|
>>>>>> +     error_propagate(errp, ...);@p1
>>>>>> +)
>>>>>> +     ...
>>>>>> +(
>>>>>> +     error_propagate_prepend(errp, ...);@p2
>>>>>> +|
>>>>>> +     error_propagate(errp, ...);@p2
>>>>>> +)
>>>>>> +     ... when any
>>>>>> + }
>>>>>> +
>>>>>
>>>>> Hmm, we don't catch the example I used in review of v8:
>>>>>
>>>>>        extern foo(int, Error **);
>>>>>        extern bar(int, Error **);
>>>>>
>>>>>        void frob(Error **errp)
>>>>>        {
>>>>>            Error *local_err =3D NULL;
>>>>>            int arg;
>>>>>
>>>>>            foo(arg, errp);
>>>>>            bar(arg, &local_err);
>>>>>            error_propagate(errp, local_err);
>>>>>            bar(arg + 1, &local_err);
>>>>>            error_propagate(errp, local_err);
>>>>>        }
>>>>>
>>>>> I believe this is because rule1 does not match here.
>>>>
>>>> Yes, rule1 wants at least one code flow with non-doubled propagation.
>>>>
>>>>>
>>>>> If I change the rule as follows, it catches the example:
>>>>>
>>>>>        @@ -157,24 +157,23 @@ print('Warning: function {} has several =
definitions of '
>>>>>
>>>>>         // Warn several propagations in control flow.
>>>>>         @check2 disable optional_qualifier exists@
>>>>>        -identifier fn =3D rule1.fn;
>>>>>        -symbol errp;
>>>>>        +identifier fn, _errp;
>>>>>         position p1, p2;
>>>>>         @@
>>>>>
>>>>>        - fn(..., Error ** ____, ...)
>>>>>        + fn(..., Error **_errp, ...)
>>>>>          {
>>>>>              ...
>>>>>         (
>>>>>        -     error_propagate_prepend(errp, ...);@p1
>>>>>        +     error_propagate_prepend(_errp, ...);@p1
>>>>>         |
>>>>>        -     error_propagate(errp, ...);@p1
>>>>>        +     error_propagate(_errp, ...);@p1
>>>>>         )
>>>>>              ...
>>>>>         (
>>>>>        -     error_propagate_prepend(errp, ...);@p2
>>>>>        +     error_propagate_prepend(_errp, ...);@p2
>>>>>         |
>>>>>        -     error_propagate(errp, ...);@p2
>>>>>        +     error_propagate(_errp, ...);@p2
>>>>>         )
>>>>>              ... when any
>>>>>          }
>>>>>
>>>>> To my mild surprise, it still doesn't find anything in our tree.
>>>>>
>>>>> Should we decouple the previous rule from rule1, too?  I tested the
>>>>> following on the whole tree:
>>>>
>>>> I don't think so. Why to check what we are not going to convert? If we=
 want
>>>> to check side things, it's better to do it in other coccinelle script.=
.
>>>
>>> Misunderstanding?  The rules are still chained together via the ___
>>> hack, just not via function name, because that's unreliable and
>>> redundant.
>>
>> Strange.. Then, how can it match something not matched by rule1?
>=20
> I think I got confused when I wrote the "Misunderstanding?" paragraph.
>=20
> Let me try again.
>=20
> First rule check2.
>=20
> The common case is a at most one propagation to @errp along any control
> flow path.  We trust your Coccinelle script to convert that alright.
>=20
> Any other propagation to @errp I want to review.  Whether the script
> attempts a conversion or not is unimportant, as long as it points me to
> the function to review.
>=20
> Rule rule1 matches functions that propagate to @errp once along at least
> one control flow path.
>=20
> Unchained from rule rule1, rule check2 flags any function that
> propagates to @errp multiple times along any control flow path.
>=20
> Chained to rule1, it flags only functions that also have a path with
> single propagation.
>=20
> In other words, the unchained rule flags *all* multi-propagations to
> @errp, while the chained rule flags only the ones the script attempts to
> convert.  The former is much more useful to me.
>=20
> Now rule check1.  It flags functions with multiple declarations along
> any control flow path.  Again, chaining it to rule1 restricts it to the
> functions we attempt to convert.  Makes it less useful to me.  However,
> because my desire to review multiple declarations in function we don't
> attempt to convert is lower than my desire to review multiple
> propagations to @errp in such functions, chaining check1 is tolerable
> for me.  But why chain check1 if we don't chain check2?
>=20

OK, let's unchain them.

>>
>>>
>>>>>
>>>>>        @@ -136,10 +136,10 @@ symbol errp;
>>>>>
>>>>>         // Warn several Error * definitions.
>>>>>         @check1 disable optional_qualifier exists@
>>>>>        -identifier fn =3D rule1.fn, local_err, local_err2;
>>>>>        +identifier fn, _errp, local_err, local_err2;
>>>>>         @@
>>>>>
>>>>>        - fn(..., Error ** ____, ...)
>>>>>        + fn(..., Error **_errp, ...)
>>>>>          {
>>>>>              ...
>>>>>              Error *local_err =3D NULL;
>>>>>
>>>>> Warnings remain unchanged.
>>>>>
>>>>>> +@ script:python @
>>>>>> +fn << check2.fn;
>>>>>> +p1 << check2.p1;
>>>>>> +p2 << check2.p2;
>>>>>> +@@
>>>>>> +
>>>>>> +print('Warning: function {} propagates to errp several times in '
>>>>>> +      'one control flow: at {}:{} and then at {}:{}'.format(
>>>>>> +          fn, p1[0].file, p1[0].line, p2[0].file, p2[0].line))
>>>>>> +
>>>>>> +// Convert special case with goto separately.
>>>>>> +// I tried merging this into the following rule the obvious way, bu=
t
>>>>>> +// it made Coccinelle hang on block.c
>>>>>> +//
>>>>>> +// Note interesting thing: if we don't do it here, and try to fixup
>>>>>> +// "out: }" things later after all transformations (the rule will b=
e
>>>>>> +// the same, just without error_propagate() call), coccinelle fails=
 to
>>>>>> +// match this "out: }".
>>>>>> +@ disable optional_qualifier@
>>>>>> +identifier rule1.fn, rule1.local_err, out;
>>>>>
>>>>> As explained above, I doubt the need for rule1.fn.  We do need
>>>>> rule1.local_err to avoid unwanted transformations.  More of the same
>>>>> below.
>>>>
>>>> Logically, I want to inherit from rule1. So why not to stress it by in=
heriting
>>>> fn variable? It's just a correct thing to do.
>>>> And I hope it helps coccinelle to work more efficiently.
>>>>
>>>>>
>>>>>> +symbol errp;
>>>>>> +@@
>>>>>> +
>>>>>> + fn(..., Error ** ____, ...)
>>>>>> + {
>>>>>> +     <...
>>>>>> +-    goto out;
>>>>>> ++    return;
>>>>>> +     ...>
>>>>>> +- out:
>>>>>> +-    error_propagate(errp, local_err);
>>>>>> + }
>>>>>> +
>>>>>> +// Convert most of local_err related stuff.
>>>>>> +//
>>>>>> +// Note, that we update everything related to matched by rule1
>>>>>> +// function name and local_err name. We may match something not
>>>>>> +// related to the pattern matched by rule1. For example, local_err =
may
>>>>>> +// be defined with the same name in different blocks inside one
>>>>>> +// function, and in one block follow the propagation pattern and in
>>>>>> +// other block doesn't. Or we may have several functions with the s=
ame
>>>>>> +// name (for different configurations).
>>>>>> +//
>>>>>> +// Note also that errp-cleaning functions
>>>>>> +//   error_free_errp
>>>>>> +//   error_report_errp
>>>>>> +//   error_reportf_errp
>>>>>> +//   warn_report_errp
>>>>>> +//   warn_reportf_errp
>>>>>> +// are not yet implemented. They must call corresponding Error* -
>>>>>> +// freeing function and then set *errp to NULL, to avoid further
>>>>>> +// propagation to original errp (consider ERRP_AUTO_PROPAGATE in us=
e).
>>>>>> +// For example, error_free_errp may look like this:
>>>>>> +//
>>>>>> +//    void error_free_errp(Error **errp)
>>>>>> +//    {
>>>>>> +//        error_free(*errp);
>>>>>> +//        *errp =3D NULL;
>>>>>> +//    }
>>>>>> +@ disable optional_qualifier exists@
>>>>>> +identifier rule1.fn, rule1.local_err;
>>>>>> +expression list args;
>>>>>> +symbol errp;
>>>>>> +@@
>>>>>> +
>>>>>> + fn(..., Error ** ____, ...)
>>>>>> + {
>>>>>> +     <...
>>>>>> +(
>>>>>> +-    Error *local_err =3D NULL;
>>>>>> +|
>>>>>> +
>>>>>> +// Convert error clearing functions
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
>>>>>> +?-    local_err =3D NULL;
>>>>>> +
>>>>>> +|
>>>>>> +-    error_propagate_prepend(errp, local_err, args);
>>>>>> ++    error_prepend(errp, args);
>>>>>> +|
>>>>>> +-    error_propagate(errp, local_err);
>>>>>> +|
>>>>>> +-    &local_err
>>>>>> ++    errp
>>>>>> +)
>>>>>> +     ...>
>>>>>> + }
>>>>>> +
>>>>>> +// Convert remaining local_err usage. For example, different kinds =
of
>>>>>> +// error checking in if conditionals. We can't merge this into
>>>>>> +// previous hunk, as this conflicts with other substitutions in it =
(at
>>>>>> +// least with "- local_err =3D NULL").
>>>>>> +@ disable optional_qualifier@
>>>>>> +identifier rule1.fn, rule1.local_err;
>>>>>> +symbol errp;
>>>>>> +@@
>>>>>> +
>>>>>> + fn(..., Error ** ____, ...)
>>>>>> + {
>>>>>> +     <...
>>>>>> +-    local_err
>>>>>> ++    *errp
>>>>>> +     ...>
>>>>>> + }
>>>>>> +
>>>>>> +// Always use the same pattern for checking error
>>>>>> +@ disable optional_qualifier@
>>>>>> +identifier rule1.fn;
>>>>>> +symbol errp;
>>>>>> +@@
>>>>>> +
>>>>>> + fn(..., Error ** ____, ...)
>>>>>> + {
>>>>>> +     <...
>>>>>> +-    *errp !=3D NULL
>>>>>> ++    *errp
>>>>>> +     ...>
>>>>>> + }
>>>>>> +
>>>>>> +// Revert temporary ___ identifier.
>>>>>> +@ disable optional_qualifier@
>>>>>> +identifier rule1.fn;
>>>>>> +@@
>>>>>> +
>>>>>> + fn(..., Error **
>>>>>> +-   ____
>>>>>> ++   errp
>>>>>> +    , ...)
>>>>>> + {
>>>>>> +     ...
>>>>>> + }
>>>>>> diff --git a/include/qapi/error.h b/include/qapi/error.h
>>>>>> index 30140d9bfe..56c133520d 100644
>>>>>> --- a/include/qapi/error.h
>>>>>> +++ b/include/qapi/error.h
>>>>>> @@ -214,6 +214,9 @@
>>>>>>      *         }
>>>>>>      *         ...
>>>>>>      *     }
>>>>>> + *
>>>>>> + * For mass-conversion use script
>>>>>> + *   scripts/coccinelle/auto-propagated-errp.cocci
>>>>>>      */
>>>>>>       #ifndef ERROR_H
>>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>>> index 857f969aa1..047f1b9714 100644
>>>>>> --- a/MAINTAINERS
>>>>>> +++ b/MAINTAINERS
>>>>>> @@ -1998,6 +1998,7 @@ F: include/qemu/error-report.h
>>>>>>     F: qapi/error.json
>>>>>>     F: util/error.c
>>>>>>     F: util/qemu-error.c
>>>>>> +F: scripts/coccinelle/*err*.cocci
>>>>>>       GDB stub
>>>>>>     M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>>>
>>>
>>>
>>>   From 42a08c529024337d1b859839c9ce7f797f784555 Mon Sep 17 00:00:00 200=
1
>>> From: Markus Armbruster <armbru@redhat.com>
>>> Date: Fri, 13 Mar 2020 14:27:57 +0100
>>> Subject: [PATCH] fixup! scripts: Coccinelle script to use
>>>    ERRP_AUTO_PROPAGATE()
>>>
>>> ---
>>>    scripts/coccinelle/auto-propagated-errp.cocci | 37 ++++++++++-------=
--
>>>    1 file changed, 20 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/scripts/coccinelle/auto-propagated-errp.cocci b/scripts/co=
ccinelle/auto-propagated-errp.cocci
>>> index 7dac2dcfa4..43b0b0e63b 100644
>>> --- a/scripts/coccinelle/auto-propagated-errp.cocci
>>> +++ b/scripts/coccinelle/auto-propagated-errp.cocci
>>> @@ -136,45 +136,48 @@ symbol errp;
>>>      // Warn several Error * definitions.
>>>    @check1 disable optional_qualifier exists@
>>> -identifier fn =3D rule1.fn, local_err, local_err2;
>>> +identifier fn, _errp, local_err, local_err2;
>>> +position p1, p2;
>>
>>
>> Hmm, seems like I forget to define ____ as symbol in my patch
>=20
> Coccinelle defaults to symbol.

But for errp we saw warnings simetimes.

>=20
>>>    @@
>>>    - fn(..., Error ** ____, ...)
>>> + fn(..., Error **_errp, ...)
>>
>> Ahmm.. it will break compilation?
>>
>> Or, how will it work when _errp defined as meta variable is only in "+..=
." line? Should it be symbol instead, or just not defined?
>=20
> Misunderstanding?  It's a diff between your .cocci and mine.=20

Oops, yes, sorry. Patches to coccinelle scripts are tricky thing.

> My version
> is
>=20
>      // Warn several Error * definitions.
>      @check1 disable optional_qualifier exists@
>      identifier fn, _errp, local_err, local_err2;
>      position p1, p2;
>      @@
>=20
>       fn(..., Error **_errp, ...)
>       {
>           ...
>           Error *local_err =3D NULL;@p1
>           ... when any
>           Error *local_err2 =3D NULL;@p2
>           ... when any
>       }
>=20
>      @ script:python @
>      fn << check1.fn;
>      p1 << check1.p1;
>      p2 << check1.p2;
>      @@
>=20
>>>     {
>>>         ...
>>> -     Error *local_err =3D NULL;
>>> +     Error *local_err =3D NULL;@p1
>>
>> Why to do -/+ here? Nothing changed..
>>
>>>         ... when any
>>> -     Error *local_err2 =3D NULL;
>>> +     Error *local_err2 =3D NULL;@p2
>>>         ... when any
>>>     }
>>>      @ script:python @
>>>    fn << check1.fn;
>>> +p1 << check1.p1;
>>> +p2 << check1.p2;
>>>    @@
>>>      print('Warning: function {} has several definitions of '
>>> -      'Error * local variable'.format(fn))
>>> +      'Error * local variable: at {}:{} and then at {}:{}'.format(
>>> +          fn, p1[0].file, p1[0].line, p2[0].file, p2[0].line))
>>>      // Warn several propagations in control flow.
>>>    @check2 disable optional_qualifier exists@
>>> -identifier fn =3D rule1.fn;
>>> -symbol errp;
>>> +identifier fn, _errp;
>>>    position p1, p2;
>>>    @@
>>>    - fn(..., Error ** ____, ...)
>>> + fn(..., Error **_errp, ...)
>>>     {
>>>         ...
>>>    (
>>> -     error_propagate_prepend(errp, ...);@p1
>>> +     error_propagate_prepend(_errp, ...);@p1
>>>    |
>>> -     error_propagate(errp, ...);@p1
>>> +     error_propagate(_errp, ...);@p1
>>>    )
>>>         ...
>>>    (
>>> -     error_propagate_prepend(errp, ...);@p2
>>> +     error_propagate_prepend(_errp, ...);@p2
>>>    |
>>> -     error_propagate(errp, ...);@p2
>>> +     error_propagate(_errp, ...);@p2
>>>    )
>>
>> You change some occurrences of errp to _errp, but not all. It breaks com=
pilation.
>>
>>>         ... when any
>>>     }
>>> @@ -198,7 +201,7 @@ print('Warning: function {} propagates to errp seve=
ral times in '
>>>    // the same, just without error_propagate() call), coccinelle fails =
to
>>>    // match this "out: }".
>>>    @ disable optional_qualifier@
>>> -identifier rule1.fn, rule1.local_err, out;
>>> +identifier fn, rule1.local_err, out;
>>
>> Hmm. If it improves performance it is strange.. But I can live with this=
 change.
>>
>>>    symbol errp;
>>>    @@
>>>    @@ -239,7 +242,7 @@ symbol errp;
>>>    //        *errp =3D NULL;
>>>    //    }
>>>    @ disable optional_qualifier exists@
>>> -identifier rule1.fn, rule1.local_err;
>>> +identifier fn, rule1.local_err;
>>>    expression list args;
>>>    symbol errp;
>>>    @@
>>> @@ -287,7 +290,7 @@ symbol errp;
>>>    // previous hunk, as this conflicts with other substitutions in it (=
at
>>>    // least with "- local_err =3D NULL").
>>>    @ disable optional_qualifier@
>>> -identifier rule1.fn, rule1.local_err;
>>> +identifier fn, rule1.local_err;
>>>    symbol errp;
>>>    @@
>>>    @@ -301,7 +304,7 @@ symbol errp;
>>>      // Always use the same pattern for checking error
>>>    @ disable optional_qualifier@
>>> -identifier rule1.fn;
>>> +identifier fn;
>>>    symbol errp;
>>>    @@
>>>    @@ -315,7 +318,7 @@ symbol errp;
>>>      // Revert temporary ___ identifier.
>>>    @ disable optional_qualifier@
>>> -identifier rule1.fn;
>>> +identifier fn;
>>>    @@
>>>       fn(..., Error **
>>>
>=20
> I append my hacked up version of auto-propagated-errp.cocci.  It
> produces the same patch as yours for the complete tree.
>=20
>=20
>=20
> // Use ERRP_AUTO_PROPAGATE (see include/qapi/error.h)
> //
> // Copyright (c) 2020 Virtuozzo International GmbH.
> //
> // This program is free software; you can redistribute it and/or
> // modify it under the terms of the GNU General Public License as
> // published by the Free Software Foundation; either version 2 of the
> // License, or (at your option) any later version.
> //
> // This program is distributed in the hope that it will be useful,
> // but WITHOUT ANY WARRANTY; without even the implied warranty of
> // MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> // GNU General Public License for more details.
> //
> // You should have received a copy of the GNU General Public License
> // along with this program.  If not, see
> // <http://www.gnu.org/licenses/>.
> //
> // Usage example:
> // spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
> //  --macro-file scripts/cocci-macro-file.h --in-place \
> //  --no-show-diff --max-width 80 FILES...
> //
> // Note: --max-width 80 is needed because coccinelle default is less
> // than 80, and without this parameter coccinelle may reindent some
> // lines which fit into 80 characters but not to coccinelle default,
> // which in turn produces extra patch hunks for no reason.
>=20
> // Switch unusual Error ** parameter names to errp
> // (this is necessary to use ERRP_AUTO_PROPAGATE).
> //
> // Disable optional_qualifier to skip functions with
> // "Error *const *errp" parameter.
> //
> // Skip functions with "assert(_errp && *_errp)" statement, because
> // that signals unusual semantics, and the parameter name may well
> // serve a purpose. (like nbd_iter_channel_error()).
> //
> // Skip util/error.c to not touch, for example, error_propagate() and
> // error_propagate_prepend().
> @ depends on !(file in "util/error.c") disable optional_qualifier@
> identifier fn;
> identifier _errp !=3D errp;
> @@
>=20
>   fn(...,
> -   Error **_errp
> +   Error **errp
>      ,...)
>   {
> (
>       ... when !=3D assert(_errp && *_errp)
> &
>       <...
> -    _errp
> +    errp
>       ...>
> )
>   }
>=20
> // Add invocation of ERRP_AUTO_PROPAGATE to errp-functions where
> // necessary
> //
> // Note, that without "when any" the final "..." does not mach
> // something matched by previous pattern, i.e. the rule will not match
> // double error_prepend in control flow like in
> // vfio_set_irq_signaling().
> //
> // Note, "exists" says that we want apply rule even if it matches not
> // on all possible control flows (otherwise, it will not match
> // standard pattern when error_propagate() call is in if branch).
> @ disable optional_qualifier exists@
> identifier fn, local_err;
> symbol errp;
> @@
>=20
>   fn(..., Error **errp, ...)
>   {
> +   ERRP_AUTO_PROPAGATE();
>      ...  when !=3D ERRP_AUTO_PROPAGATE();
> (
> (
>      error_append_hint(errp, ...);
> |
>      error_prepend(errp, ...);
> |
>      error_vprepend(errp, ...);
> )
>      ... when any
> |
>      Error *local_err =3D NULL;
>      ...
> (
>      error_propagate_prepend(errp, local_err, ...);
> |
>      error_propagate(errp, local_err);
> )
>      ...
> )
>   }
>=20
>=20
> // Match functions with propagation of local error to errp.
> // We want to refer these functions in several following rules, but I
> // don't know a proper way to inherit a function, not just its name
> // (to not match another functions with same name in following rules).
> // Not-proper way is as follows: rename errp parameter in functions
> // header and match it in following rules. Rename it back after all
> // transformations.
> //
> // The simplest case of propagation scheme is single definition of
> // local_err with at most one error_propagate_prepend or
> // error_propagate on each control-flow. Still, we want to match more
> // complex schemes too. We'll warn them with help of further rules.
> @rule1 disable optional_qualifier exists@
> identifier fn, local_err;
> symbol errp;
> @@
>=20
>   fn(..., Error **
> -    errp
> +    ____
>      , ...)
>   {
>       ...
>       Error *local_err =3D NULL;
>       ...
> (
>       error_propagate_prepend(errp, local_err, ...);
> |
>       error_propagate(errp, local_err);
> )
>       ...
>   }
>=20
>=20
> // Warn several Error * definitions.
> @check1 disable optional_qualifier exists@
> identifier fn, _errp, local_err, local_err2;
> position p1, p2;
> @@
>=20
>   fn(..., Error **_errp, ...)
>   {
>       ...
>       Error *local_err =3D NULL;@p1
>       ... when any
>       Error *local_err2 =3D NULL;@p2
>       ... when any
>   }
>=20
> @ script:python @
> fn << check1.fn;
> p1 << check1.p1;
> p2 << check1.p2;
> @@
>=20
> print('Warning: function {} has several definitions of '
>        'Error * local variable: at {}:{} and then at {}:{}'.format(
>            fn, p1[0].file, p1[0].line, p2[0].file, p2[0].line))
>=20
> // Warn several propagations in control flow.
> @check2 disable optional_qualifier exists@
> identifier fn, _errp;
> position p1, p2;
> @@
>=20
>   fn(..., Error **_errp, ...)
>   {
>       ...
> (
>       error_propagate_prepend(_errp, ...);@p1
> |
>       error_propagate(_errp, ...);@p1
> )
>       ...
> (
>       error_propagate_prepend(_errp, ...);@p2
> |
>       error_propagate(_errp, ...);@p2
> )
>       ... when any
>   }
>=20
> @ script:python @
> fn << check2.fn;
> p1 << check2.p1;
> p2 << check2.p2;
> @@
>=20
> print('Warning: function {} propagates to errp several times in '
>        'one control flow: at {}:{} and then at {}:{}'.format(
>            fn, p1[0].file, p1[0].line, p2[0].file, p2[0].line))
>=20
> // Convert special case with goto separately.
> // I tried merging this into the following rule the obvious way, but
> // it made Coccinelle hang on block.c
> //
> // Note interesting thing: if we don't do it here, and try to fixup
> // "out: }" things later after all transformations (the rule will be
> // the same, just without error_propagate() call), coccinelle fails to
> // match this "out: }".
> @ disable optional_qualifier@
> identifier fn, rule1.local_err, out;
> symbol errp;
> @@
>=20
>   fn(..., Error ** ____, ...)
>   {
>       <...
> -    goto out;
> +    return;
>       ...>
> - out:
> -    error_propagate(errp, local_err);
>   }
>=20
> // Convert most of local_err related stuff.
> //
> // Note, that we update everything related to matched by rule1
> // function name and local_err name. We may match something not
> // related to the pattern matched by rule1. For example, local_err may
> // be defined with the same name in different blocks inside one
> // function, and in one block follow the propagation pattern and in
> // other block doesn't. Or we may have several functions with the same
> // name (for different configurations).
> //
> // Note also that errp-cleaning functions
> //   error_free_errp
> //   error_report_errp
> //   error_reportf_errp
> //   warn_report_errp
> //   warn_reportf_errp
> // are not yet implemented. They must call corresponding Error* -
> // freeing function and then set *errp to NULL, to avoid further
> // propagation to original errp (consider ERRP_AUTO_PROPAGATE in use).
> // For example, error_free_errp may look like this:
> //
> //    void error_free_errp(Error **errp)
> //    {
> //        error_free(*errp);
> //        *errp =3D NULL;
> //    }
> @ disable optional_qualifier exists@
> identifier fn, rule1.local_err;
> expression list args;
> symbol errp;
> @@
>=20
>   fn(..., Error ** ____, ...)
>   {
>       <...
> (
> -    Error *local_err =3D NULL;
> |
>=20
> // Convert error clearing functions
> (
> -    error_free(local_err);
> +    error_free_errp(errp);
> |
> -    error_report_err(local_err);
> +    error_report_errp(errp);
> |
> -    error_reportf_err(local_err, args);
> +    error_reportf_errp(errp, args);
> |
> -    warn_report_err(local_err);
> +    warn_report_errp(errp);
> |
> -    warn_reportf_err(local_err, args);// Use ERRP_AUTO_PROPAGATE (see in=
clude/qapi/error.h)
//
// Copyright (c) 2020 Virtuozzo International GmbH.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License as
// published by the Free Software Foundation; either version 2 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see
// <http://www.gnu.org/licenses/>.
//
// Usage example:
// spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
//  --macro-file scripts/cocci-macro-file.h --in-place \
//  --no-show-diff --max-width 80 FILES...
//
// Note: --max-width 80 is needed because coccinelle default is less
// than 80, and without this parameter coccinelle may reindent some
// lines which fit into 80 characters but not to coccinelle default,
// which in turn produces extra patch hunks for no reason.

// Switch unusual Error ** parameter names to errp
// (this is necessary to use ERRP_AUTO_PROPAGATE).
//
// Disable optional_qualifier to skip functions with
// "Error *const *errp" parameter.
//
// Skip functions with "assert(_errp && *_errp)" statement, because
// that signals unusual semantics, and the parameter name may well
// serve a purpose. (like nbd_iter_channel_error()).
//
// Skip util/error.c to not touch, for example, error_propagate() and
// error_propagate_prepend().
@ depends on !(file in "util/error.c") disable optional_qualifier@
identifier fn;
identifier _errp !=3D errp;
@@

  fn(...,
-   Error **_errp
+   Error **errp
     ,...)
  {
(
      ... when !=3D assert(_errp && *_errp)
&
      <...
-    _errp
+    errp
      ...>
)
  }

// Add invocation of ERRP_AUTO_PROPAGATE to errp-functions where
// necessary
//
// Note, that without "when any" the final "..." does not mach
// something matched by previous pattern, i.e. the rule will not match
// double error_prepend in control flow like in
// vfio_set_irq_signaling().
//
// Note, "exists" says that we want apply rule even if it matches not
// on all possible control flows (otherwise, it will not match
// standard pattern when error_propagate() call is in if branch).
@ disable optional_qualifier exists@
identifier fn, local_err;
symbol errp;
@@

  fn(..., Error **errp, ...)
  {
+   ERRP_AUTO_PROPAGATE();
     ...  when !=3D ERRP_AUTO_PROPAGATE();
(
(
     error_append_hint(errp, ...);
|
     error_prepend(errp, ...);
|
     error_vprepend(errp, ...);
)
     ... when any
|
     Error *local_err =3D NULL;
     ...
(
     error_propagate_prepend(errp, local_err, ...);
|
     error_propagate(errp, local_err);
)
     ...
)
  }


// Match functions with propagation of local error to errp.
// We want to refer these functions in several following rules, but I
// don't know a proper way to inherit a function, not just its name
// (to not match another functions with same name in following rules).
// Not-proper way is as follows: rename errp parameter in functions
// header and match it in following rules. Rename it back after all
// transformations.
//
// The simplest case of propagation scheme is single definition of
// local_err with at most one error_propagate_prepend or
// error_propagate on each control-flow. Still, we want to match more
// complex schemes too. We'll warn them with help of further rules.
@rule1 disable optional_qualifier exists@
identifier fn, local_err;
symbol errp;
@@

  fn(..., Error **
-    errp
+    ____
     , ...)
  {
      ...
      Error *local_err =3D NULL;
      ...
(
      error_propagate_prepend(errp, local_err, ...);
|
      error_propagate(errp, local_err);
)
      ...
  }


// Warn several Error * definitions.
@check1 disable optional_qualifier exists@
identifier fn, _errp, local_err, local_err2;
position p1, p2;
@@

  fn(..., Error **_errp, ...)
  {
      ...
      Error *local_err =3D NULL;@p1
      ... when any
      Error *local_err2 =3D NULL;@p2
      ... when any
  }

@ script:python @
fn << check1.fn;
p1 << check1.p1;
p2 << check1.p2;
@@

print('Warning: function {} has several definitions of '
       'Error * local variable: at {}:{} and then at {}:{}'.format(
           fn, p1[0].file, p1[0].line, p2[0].file, p2[0].line))

// Warn several propagations in control flow.
@check2 disable optional_qualifier exists@
identifier fn, _errp;
position p1, p2;
@@

  fn(..., Error **_errp, ...)
  {
      ...
(
      error_propagate_prepend(_errp, ...);@p1
|
      error_propagate(_errp, ...);@p1
)
      ...
(
      error_propagate_prepend(_errp, ...);@p2
|
      error_propagate(_errp, ...);@p2
)
      ... when any
  }

@ script:python @
fn << check2.fn;
p1 << check2.p1;
p2 << check2.p2;
@@

print('Warning: function {} propagates to errp several times in '
       'one control flow: at {}:{} and then at {}:{}'.format(
           fn, p1[0].file, p1[0].line, p2[0].file, p2[0].line))

// Convert special case with goto separately.
// I tried merging this into the following rule the obvious way, but
// it made Coccinelle hang on block.c
//
// Note interesting thing: if we don't do it here, and try to fixup
// "out: }" things later after all transformations (the rule will be
// the same, just without error_propagate() call), coccinelle fails to
// match this "out: }".
@ disable optional_qualifier@
identifier fn, rule1.local_err, out;
symbol errp;
@@

  fn(..., Error ** ____, ...)
  {
      <...
-    goto out;
+    return;
      ...>
- out:
-    error_propagate(errp, local_err);
  }

// Convert most of local_err related stuff.
//
// Note, that we update everything related to matched by rule1
// function name and local_err name. We may match something not
// related to the pattern matched by rule1. For example, local_err may
// be defined with the same name in different blocks inside one
// function, and in one block follow the propagation pattern and in
// other block doesn't. Or we may have several functions with the same
// name (for different configurations).
//
// Note also that errp-cleaning functions
//   error_free_errp
//   error_report_errp
//   error_reportf_errp
//   warn_report_errp
//   warn_reportf_errp
// are not yet implemented. They must call corresponding Error* -
// freeing function and then set *errp to NULL, to avoid further
// propagation to original errp (consider ERRP_AUTO_PROPAGATE in use).
// For example, error_free_errp may look like this:
//
//    void error_free_errp(Error **errp)
//    {
//        error_free(*errp);
//        *errp =3D NULL;
//    }
@ disable optional_qualifier exists@
identifier fn, rule1.local_err;
expression list args;
symbol errp;
@@

  fn(..., Error ** ____, ...)
  {
      <...
(
-    Error *local_err =3D NULL;
|

// Convert error clearing functions
(
-    error_free(local_err);
+    error_free_errp(errp);
|
-    error_report_err(local_err);
+    error_report_errp(errp);
|
-    error_reportf_err(local_err, args);
+    error_reportf_errp(errp, args);
|
-    warn_report_err(local_err);
+    warn_report_errp(errp);
|
-    warn_reportf_err(local_err, args);
+    warn_reportf_errp(errp, args);
)
?-    local_err =3D NULL;

|
-    error_propagate_prepend(errp, local_err, args);
+    error_prepend(errp, args);
|
-    error_propagate(errp, local_err);
|
-    &local_err
+    errp
)
      ...>
  }

// Convert remaining local_err usage. For example, different kinds of
// error checking in if conditionals. We can't merge this into
// previous hunk, as this conflicts with other substitutions in it (at
// least with "- local_err =3D NULL").
@ disable optional_qualifier@
identifier fn, rule1.local_err;
symbol errp;
@@

  fn(..., Error ** ____, ...)
  {
      <...
-    local_err
+    *errp
      ...>
  }

// Always use the same pattern for checking error
@ disable optional_qualifier@
identifier fn;
symbol errp;
@@

  fn(..., Error ** ____, ...)
  {
      <...
-    *errp !=3D NULL
+    *errp
      ...>
  }

// Revert temporary ___ identifier.
@ disable optional_qualifier@
identifier fn;
@@

  fn(..., Error **
-   ____
+   errp
     , ...)
  {
      ...
  }

> +    warn_reportf_errp(errp, args);
> )
> ?-    local_err =3D NULL;
>=20
> |
> -    error_propagate_prepend(errp, local_err, args);
> +    error_prepend(errp, args);
> |
> -    error_propagate(errp, local_err);
> |
> -    &local_err
> +    errp
> )
>       ...>
>   }
>=20
> // Convert remaining local_err usage. For example, different kinds of
> // error checking in if conditionals. We can't merge this into
> // previous hunk, as this conflicts with other substitutions in it (at
> // least with "- local_err =3D NULL").
> @ disable optional_qualifier@
> identifier fn, rule1.local_err;
> symbol errp;
> @@
>=20
>   fn(..., Error ** ____, ...)
>   {
>       <...
> -    local_err
> +    *errp
>       ...>
>   }
>=20
> // Always use the same pattern for checking error
> @ disable optional_qualifier@
> identifier fn;
> symbol errp;
> @@
>=20
>   fn(..., Error ** ____, ...)
>   {
>       <...
> -    *errp !=3D NULL
> +    *errp
>       ...>
>   }
>=20
> // Revert temporary ___ identifier.
> @ disable optional_qualifier@
> identifier fn;
> @@
>=20
>   fn(..., Error **
> -   ____
> +   errp
>      , ...)
>   {
>       ...
>   }
>=20

OK, I almost OK with it, the only thing I doubt a bit is the following:

We want to keep rule1.local_err inheritance to keep connection with
local_err definition.

Interesting, when we have both rule1.fn and rule1.local_err inherited,
do we inherit them in separate (i.e. all possible combinations of fn
and local_err symbols from rule1) or do we inherit a pair, i.e. only
fn/local_err pairs, found by rule1? If the latter is correct, that
with your script we loss this pair inheritance, and go to all possible
combinations of fn and local_err from rule1, possibly adding some wrong
conversion (OK, you've checked that no such cases in current code tree).

So, dropping inheritance in check-rules makes sence, as it may match=20
(and warn) more interesting cases.

But for other rules, I'd prefere to be safer, and explictly inherit all
actually inherited identifiers.. Still, I feel, we'll never be=20
absolutely safe with coccinelle :)

--
Best regrads,
Vladimir

