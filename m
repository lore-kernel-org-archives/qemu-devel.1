Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A70C10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:57:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F34AF2146E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="wNgiC2vL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34AF2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBvIf-0000ma-57
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 02:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35739)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jBvH0-0006Gd-EH
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jBvGv-0006rl-O9
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:55:22 -0400
Received: from mail-eopbgr10119.outbound.protection.outlook.com
 ([40.107.1.119]:36422 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jBvGl-00066o-Uy; Wed, 11 Mar 2020 02:55:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fY7IEnWR3ShnPzo6NwPnfKES4W5pztMR9PosKuz2FTV3PLEYdGFpqzQNS9yoPr38gx9Q4DQflvdAgIKVGzMPHlzd2dl1zFwE+vtQaGOvuPgJu8gMV8bjXNMsfHPDigpHPO/rGh7E5A3kC65cY1ClGaX73KjYVID3NQcUsfARwYDohNqYHa5IPBcgAOF9xNL95acwwDD42dMVZKfvtJgy00itBPcMugqwPoY4zIYz8ddeAIGRxDJJegd50VZuEIStnIYL1zGSI/SQef+z1hKjIXw7no8uwj9RCzxeXl6MiRC+ROEaUXywgX4zYLCc3JGxI6xpHycXLIHSW3+VBQnFGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUJ2OIQSC3lxllv/84Vkyy/FbrqyUIlySL+4THr8fbM=;
 b=eBuv7cxAVRnBovBf9ui51IdRq5XAYYrVdKo5Nj2t1m9SgScxdLerHE8H4UbKsVlKHPGX+Dpp7yOfrA4siTg+G0w7nj9DId0WlXsZ8DZ5sT0qgGu3XkuIIsFxognX85BSKYlb8PUytlup1JvmeNF5HedYF4Uw1/Hc9Q2+ZrQv07djBNyHflw+hiz2LxZKTXs48YojWvEDoSlypibasaB3J4cWX5c4rv+PV9dVwAZXzOf4lO3lQCnriJ4Pi3QcjuCVNNLtxf1lqosVKT7rYVbCR6LIvYjcQx+bzPr+CHOZq9XOvic5k77To/4L1BgK78+BGiPNE0zT22VZUTlN70Lr0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUJ2OIQSC3lxllv/84Vkyy/FbrqyUIlySL+4THr8fbM=;
 b=wNgiC2vLwW5l5ZMCtwTRL6L70McVgxDSyY1YZ1pnJCX80zuUjI4kd/8csMYJbc1TP477D/GUodWi6/MVrRCZuBsCkmqXnKVz7QiDtUQB3O7GmIraZ68j9L4IVjxVX3FmCCGhhfccvc5vARfFvZGjCu3uG3Zv/d5N4F09yXiSrzc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3032.eurprd08.prod.outlook.com (52.135.162.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Wed, 11 Mar 2020 06:55:04 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2814.007; Wed, 11 Mar 2020
 06:55:04 +0000
Subject: Re: [PATCH v8 02/10] scripts: add coccinelle script to use auto
 propagated errp
To: Markus Armbruster <armbru@redhat.com>
References: <20200306051536.27803-1-vsementsov@virtuozzo.com>
 <20200306051536.27803-3-vsementsov@virtuozzo.com>
 <87lfo997hs.fsf@dusky.pond.sub.org>
 <e5b19cf6-f206-a0ed-27cc-173c3a137ef2@virtuozzo.com>
 <87lfo8nrdo.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200311095501098
Message-ID: <4ad4f78d-bdf2-1302-a9b4-0324119217c7@virtuozzo.com>
Date: Wed, 11 Mar 2020 09:55:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <87lfo8nrdo.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0402CA0058.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::47) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0402CA0058.eurprd04.prod.outlook.com (2603:10a6:7:7c::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16 via Frontend Transport; Wed, 11 Mar 2020 06:55:03 +0000
X-Tagtoolbar-Keys: D20200311095501098
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6942693-3796-4ed9-17b6-08d7c5892096
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3032353AEC8750BAAECA4AE3C1FC0@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(39850400004)(396003)(346002)(366004)(136003)(199004)(52116002)(66476007)(5660300002)(86362001)(4326008)(66946007)(66556008)(6486002)(30864003)(36756003)(54906003)(956004)(478600001)(6916009)(16526019)(31686004)(26005)(186003)(8936002)(81156014)(8676002)(2906002)(316002)(2616005)(16576012)(31696002)(81166006)(7416002)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3032;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KrhFeva5CJDwR7CU0MoG2Z2dZ3rK6oAU4b0rb7QGLBCu6/cRZcRFOCLL8GuKyaX/R1T2qqjV6vNEZjyzlNNxmoHpyao1yxgZYtLdZrzwAFL6P30H7Ll3Eahl8Quh0WivUohQUHL9ifL89G12TxSwix+PSqyQToDbyC1xF7g+cQ6n2OODQsHkT5KdzI3tW+JVeTW+dK7iZi2eovliILlBpTTtgQUb1vqa6DwCiabtYCK91/KvGY7ZcwiZOkuyRNzm3QsLY8aV4XEpsx8dYGN3Ye9tvGPdhB2ZDbrxvMMPoXHL/663Ctb/5bYYNNyrqU+j9RZGm/680N+Jql4ZTuKxlMM8tmLoWLM3AHTogKwbT2gBTX0xVZxiH2rSePMn7v9u1c3FanKrCEsrYcnlu0mNv+YGMUzIoY/gLCgqFyxLVgEsGsZpKlOZ6lTwyYzEIYDHy3V4gqZFC3W79/82mi2EuDkGVs4Wtn2fuRWzeTiPsJaygx2iriR3bjbLtN6uWDH0u5AgJ8cx9DTaLO4idTEdBjQMPJsEOJq89mzB20i16/26G12KRf7jJQa/uRubFzx4
X-MS-Exchange-AntiSpam-MessageData: LSK22lPgHi8QsjSsk6TCcvKJXfDUh76DqQfoUQNJZG6+QsMAowEmroFKS1U9DaWT2cG5qvIM0nVFGnEgHrHx+LW20IFFfeL2Qd7L4tJNlFK1etBI2R3I9gKyBl4Ka+D7mVua6yW5SpS6oyzxl9wXDA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6942693-3796-4ed9-17b6-08d7c5892096
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 06:55:04.5822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /BygTTJpCFjrCyjoj1NBRqFrziH9tdrObGh0HbM8P9AvxueKgauie0iDRd0/jeJ+bc90558R8g4qdobk3wbRduhOlM7CzN/sInQzh6eV4J0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.119
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
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

10.03.2020 18:47, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>=20
>> 09.03.2020 12:56, Markus Armbruster wrote:
>>> Suggest
>>>
>>>       scripts: Coccinelle script to use auto-propagated errp
>>>
>>> or
>>>
>>>       scripts: Coccinelle script to use ERRP_AUTO_PROPAGATE()
>>>
>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>
>>>> Script adds ERRP_AUTO_PROPAGATE macro invocation where appropriate and
>>>> does corresponding changes in code (look for details in
>>>> include/qapi/error.h)
>>>>
>>>> Usage example:
>>>> spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>>>>    --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff \
>>>>    blockdev-nbd.c qemu-nbd.c {block/nbd*,nbd/*,include/block/nbd*}.[hc=
]
>>>
>>> Suggest FILES... instead of a specific set of files.
>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> ---
>>>>
>>>> Cc: Eric Blake <eblake@redhat.com>
>>>> Cc: Kevin Wolf <kwolf@redhat.com>
>>>> Cc: Max Reitz <mreitz@redhat.com>
>>>> Cc: Greg Kurz <groug@kaod.org>
>>>> Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>
>>>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>>>> Cc: Anthony Perard <anthony.perard@citrix.com>
>>>> Cc: Paul Durrant <paul@xen.org>
>>>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>>>> Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
>>>> Cc: Laszlo Ersek <lersek@redhat.com>
>>>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>>>> Cc: Stefan Berger <stefanb@linux.ibm.com>
>>>> Cc: Markus Armbruster <armbru@redhat.com>
>>>> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
>>>> Cc: qemu-block@nongnu.org
>>>> Cc: qemu-devel@nongnu.org
>>>> Cc: xen-devel@lists.xenproject.org
>>>>
>>>>    include/qapi/error.h                          |   3 +
>>>>    scripts/coccinelle/auto-propagated-errp.cocci | 231 +++++++++++++++=
+++
>>>>    2 files changed, 234 insertions(+)
>>>>    create mode 100644 scripts/coccinelle/auto-propagated-errp.cocci
>>>>
>>>> diff --git a/include/qapi/error.h b/include/qapi/error.h
>>>> index bb9bcf02fb..fbfc6f1c0b 100644
>>>> --- a/include/qapi/error.h
>>>> +++ b/include/qapi/error.h
>>>> @@ -211,6 +211,9 @@
>>>>     *         }
>>>>     *         ...
>>>>     *     }
>>>> + *
>>>> + * For mass conversion use script
>>>
>>> mass-conversion (we're not converting mass, we're converting en masse)
>>>
>>>> + *   scripts/coccinelle/auto-propagated-errp.cocci
>>>>     */
>>>>      #ifndef ERROR_H
>>>> diff --git a/scripts/coccinelle/auto-propagated-errp.cocci b/scripts/c=
occinelle/auto-propagated-errp.cocci
>>>> new file mode 100644
>>>> index 0000000000..bff274bd6d
>>>> --- /dev/null
>>>> +++ b/scripts/coccinelle/auto-propagated-errp.cocci
>>>
>>> Preface to my review of this script: may aim isn't to make it
>>> bullet-proof.  I want to (1) make it good enough (explained in a
>>> jiffie), and (2) automatically identify the spots where it still isn't
>>> obviously safe for manual review.
>>>
>>> The latter may involve additional scripting.  That's okay.
>>>
>>> The script is good enough when the number of possibly unsafe spots is
>>> low enough for careful manual review.
>>>
>>> When I ask for improvements that, in your opinion, go beyond "good
>>> enough", please push back.  I'm sure we can work it out together.
>>>
>>>> @@ -0,0 +1,231 @@
>>>> +// Use ERRP_AUTO_PROPAGATE (see include/qapi/error.h)
>>>> +//
>>>> +// Copyright (c) 2020 Virtuozzo International GmbH.
>>>> +//
>>>> +// This program is free software; you can redistribute it and/or modi=
fy
>>>> +// it under the terms of the GNU General Public License as published =
by
>>>> +// the Free Software Foundation; either version 2 of the License, or
>>>> +// (at your option) any later version.
>>>> +//
>>>> +// This program is distributed in the hope that it will be useful,
>>>> +// but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> +// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>> +// GNU General Public License for more details.
>>>> +//
>>>> +// You should have received a copy of the GNU General Public License
>>>> +// along with this program.  If not, see <http://www.gnu.org/licenses=
/>.
>>>> +//
>>>> +// Usage example:
>>>> +// spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>>>> +//  --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff=
 \
>>>> +//  --max-width 80 blockdev-nbd.c qemu-nbd.c \
>>>
>>> You have --max-width 80 here, but not in the commit message.  Default
>>> seems to be 78.  Any particular reason to change it to 80?
>>
>> Hmm. As I remember, without this parameter, reindenting doesn't work cor=
rectly.
>> So, I'm OK with "--max-width 78", but I doubt that it will work without =
a parameter.
>> Still, may be I'm wrong, we can check it.
>=20
> If you can point to an example where --max-width helps, keep it, and
> update the commit message to match.  Else, drop it.
>=20
>>>
>>>> +//  {block/nbd*,nbd/*,include/block/nbd*}.[hc]
>>>> +
>>>> +// Switch unusual (Error **) parameter names to errp
>>>
>>> Let's drop the parenthesis around Error **
>>>
>>>> +// (this is necessary to use ERRP_AUTO_PROPAGATE).
>>>
>>> Perhaps ERRP_AUTO_PROPAGATE() should be ERRP_AUTO_PROPAGATE(errp) to
>>> make the fact we're messing with @errp more obvious.  Too late; I
>>> shouldn't rock the boat that much now.
>>>
>>>> +//
>>>> +// Disable optional_qualifier to skip functions with "Error *const *e=
rrp"
>>>> +// parameter.
>>>> +//
>>>> +// Skip functions with "assert(_errp && *_errp)" statement, as they h=
ave
>>>> +// non generic semantics and may have unusual Error ** argument name =
for purpose
>>>
>>> non-generic
>>>
>>> for a purpose
>>>
>>> Wrap comment lines around column 70, please.  It's easier to read.
>>>
>>> Maybe
>>>
>>>      // Skip functions with "assert(_errp && *_errp)" statement, becaus=
e that
>>>      // signals unusual semantics, and the parameter name may well serv=
e a
>>>      // purpose.
>>
>> Sounds good.
>>
>>>
>>>> +// (like nbd_iter_channel_error()).
>>>> +//
>>>> +// Skip util/error.c to not touch, for example, error_propagate and
>>>> +// error_propagate_prepend().
>>>
>>> error_propagate()
>>>
>>> I much appreciate your meticulous explanation of what you skip and why.
>>>
>>>> +@ depends on !(file in "util/error.c") disable optional_qualifier@
>>>> +identifier fn;
>>>> +identifier _errp !=3D errp;
>>>> +@@
>>>> +
>>>> + fn(...,
>>>> +-   Error **_errp
>>>> ++   Error **errp
>>>> +    ,...)
>>>> + {
>>>> +(
>>>> +     ... when !=3D assert(_errp && *_errp)
>>>> +&
>>>> +     <...
>>>> +-    _errp
>>>> ++    errp
>>>> +     ...>
>>>> +)
>>>> + }
>>>
>>> This rule is required to make the actual transformations (below) work
>>> even for parameters with names other than @errp.  I believe it's not
>>> used in this series.  In fact, I can't see a use for it in the entire
>>> tree right now.  Okay anyway.
>>>
>>>> +
>>>> +// Add invocation of ERRP_AUTO_PROPAGATE to errp-functions where nece=
ssary
>>>> +//
>>>> +// Note, that without "when any" final "..." may not want to mach som=
ething
>>>
>>> s/final "..." may not mach/the final "..." does not match/
>>>
>>>> +// matched by previous pattern, i.e. the rule will not match double
>>>> +// error_prepend in control flow like in vfio_set_irq_signaling().
>>>
>>> Can't say I fully understand Coccinelle there.  I figure you came to
>>> this knowledge the hard way.
>>
>> It's follows from smpl grammar document:
>>
>> "Implicitly, =E2=80=9C...=E2=80=9D matches the shortest path between som=
ething that matches the pattern before the dots (or the beginning of the fu=
nction, if there is nothing before the dots) and something that matches the=
 pattern after the dots (or the end of the function, if there is nothing af=
ter the dots)."
>> ...
>> "_when any_ removes the aforementioned constraint that =E2=80=9C...=E2=
=80=9D matches the shortest path"
>=20
> Let me think that through.
>=20
> The pattern with the cases other than error_prepend() omitted:
>=20
>       fn(..., Error **errp, ...)
>       {
>      +   ERRP_AUTO_PROPAGATE();
>          ...  when !=3D ERRP_AUTO_PROPAGATE();
>          error_prepend(errp, ...);
>          ... when any
>       }
>=20
> Tail of vfio_set_irq_signaling():
>=20
>          name =3D index_to_str(vbasedev, index);
>          if (name) {
>              error_prepend(errp, "%s-%d: ", name, subindex);
>          } else {
>              error_prepend(errp, "index %d-%d: ", index, subindex);
>          }
>          error_prepend(errp,
>                        "Failed to %s %s eventfd signaling for interrupt "=
,
>                        fd < 0 ? "tear down" : "set up", action_to_str(act=
ion));
>          return ret;
>      }
>=20
> The pattern's first ... matches a "shortest" path to an error_prepend(),
> where "shortest" means "does not cross an error_prepend().  Its when
> clause makes us ignore functions that already use ERRP_AUTO_PROPAGATE().
>=20
> There are two such "shortest" paths, one to the first error_prepend() in
> vfio_set_irq_signaling(), and one to the second.  Neither path to the
> third one is not "shortest": they both cross one of the other two
> error_prepend().
>=20
> The pattern' s second ... matches a path from a matched error_prepend()
> to the end of the function.  There are two paths.  Both cross the third
> error_prepend().  You need "when any" to make the pattern match anyway.
>=20
> Alright, I think I got it.  But now I'm paranoid about ... elsewhere.
> For instance, here's rule1 with error_propagate_prepend() omitted:
>=20
>      // Match scenarios with propagation of local error to errp.
>      @rule1 disable optional_qualifier exists@
>      identifier fn, local_err;
>      symbol errp;
>      @@
>=20
>       fn(..., Error **errp, ...)
>       {
>           ...
>           Error *local_err =3D NULL;
>           ...
>           error_propagate(errp, local_err);
>           ...
>       }
>=20
> The second and third ... won't match anything containing
> error_propagate().  What if a function has multiple error_propagate() on
> all paths?

I thought about this, but decided that double error propagation is a strang=
e pattern, and may be better not match it...

> Like this one:
>=20
>      extern foo(int, Error **);
>      extern bar(int, Error **);
>=20
>      void frob(Error **errp)
>      {
>          Error *local_err =3D NULL;
>          int arg;
>=20
>          foo(arg, errp);
>          bar(arg, &local_err);
>          error_propagate(errp, local_err);
>          bar(arg + 1, &local_err);
>          error_propagate(errp, local_err);
>      }
>=20
> This is actually a variation of error.h's "Receive and accumulate
> multiple errors (first one wins)" code snippet.

ah yes, we can propagate to already filled errp, which just clean local_err=
.

>=20
> The Coccinelle script transforms it like this:
>=20
>       void frob(Error **errp)
>       {
>      +    ERRP_AUTO_PROPAGATE();
>           Error *local_err =3D NULL;
>           int arg;
>=20
> The rule that adds ERRP_AUTO_PROPAGATE() matches (it has ... when any),
> but rule1 does not, and we therefore don't convert any of the
> error_propagate().
>=20
> The result isn't wrong, just useless.
>=20
> Is this the worst case?
>=20
> Possible improvement to the ERRP_AUTO_PROPAGATE() rule: don't use
> "... when any" in the error_propagate() case, only in the other cases.
> Would that help?

I think not, as it will anyway match functions with error_prepend (and any
number of following error_propagate calls)...

>=20
> I think this is the only other rule with "..." matching control flow.
>=20
>>>
>>>> +//
>>>> +// Note, "exists" says that we want apply rule even if it matches not=
 on
>>>> +// all possible control flows (otherwise, it will not match standard =
pattern
>>>> +// when error_propagate() call is in if branch).
>>>
>>> Learned something new.  Example: kvm_set_kvm_shadow_mem().
>>>
>>> Spelling it "exists disable optional_qualifier" would avoid giving
>>> readers the idea we're disabling "exists", but Coccinelle doesn't let
>>> us.  Oh well.
>>>
>>>> +@ disable optional_qualifier exists@
>>>> +identifier fn, local_err, errp;
>>>
>>> I believe this causes
>>>
>>>       warning: line 98: errp, previously declared as a metavariable, is=
 used as an identifier
>>>       warning: line 104: errp, previously declared as a metavariable, i=
s used as an identifier
>>>       warning: line 106: errp, previously declared as a metavariable, i=
s used as an identifier
>>>       warning: line 131: errp, previously declared as a metavariable, i=
s used as an identifier
>>>       warning: line 192: errp, previously declared as a metavariable, i=
s used as an identifier
>>>       warning: line 195: errp, previously declared as a metavariable, i=
s used as an identifier
>>>       warning: line 228: errp, previously declared as a metavariable, i=
s used as an identifier
>>>
>>> Making @errp symbol instead of identifier should fix this.
>>
>> Hmm, I didn't see these warnings.. But yes, it should be symbol.
>>
>>>
>>>> +@@
>>>> +
>>>> + fn(..., Error **errp, ...)
>>>> + {
>>>> ++   ERRP_AUTO_PROPAGATE();
>>>> +    ...  when !=3D ERRP_AUTO_PROPAGATE();
>>>> +(
>>>> +    error_append_hint(errp, ...);
>>>> +|
>>>> +    error_prepend(errp, ...);
>>>> +|
>>>> +    error_vprepend(errp, ...);
>>>> +|
>>>> +    Error *local_err =3D NULL;
>>>> +    ...
>>>> +(
>>>> +    error_propagate_prepend(errp, local_err, ...);
>>>> +|
>>>> +    error_propagate(errp, local_err);
>>>> +)
>>>> +)
>>>> +    ... when any
>>>> + }
>>>> +
>>>> +
>>>> +// Match scenarios with propagation of local error to errp.
>>>> +@rule1 disable optional_qualifier exists@
>>>> +identifier fn, local_err;
>>>> +symbol errp;
>>>> +@@
>>>> +
>>>> + fn(..., Error **errp, ...)
>>>> + {
>>>> +     ...
>>>> +     Error *local_err =3D NULL;
>>>> +     ...
>>>> +(
>>>> +    error_propagate_prepend(errp, local_err, ...);
>>>> +|
>>>> +    error_propagate(errp, local_err);
>>>> +)
>>>
>>> Indentation off by one.
>>>
>>>> +     ...
>>>> + }
>>>> +
>>>> +// Convert special case with goto in separate.
>>>
>>> s/in separate/separately/
>>>
>>>> +// We can probably merge this into the following hunk with help of ( =
| )
>>>> +// operator, but it significantly reduce performance on block.c parsi=
ng (or it
>>>
>>> s/reduce/reduces/
>>>
>>>> +// hangs, I don't know)
>>>
>>> Sounds like you tried to merge this into the following hunk, but then
>>> spatch took so long on block.c that you killed it.  Correct?
>>
>> Yes.
>=20
> I'd say something like "I tried merging this into the following rule the
> obvious way, but it made Coccinelle hang on block.c."
>=20
>>>
>>>> +//
>>>> +// Note interesting thing: if we don't do it here, and try to fixup "=
out: }"
>>>> +// things later after all transformations (the rule will be the same,=
 just
>>>> +// without error_propagate() call), coccinelle fails to match this "o=
ut: }".
>>>
>>> Weird, but not worth further investigation.
>>
>> It partially match to the idea which I saw somewhere in coccinelle docum=
entation,
>> that coccinelle converts correct C code to correct C code. "out: }" is a=
n example
>> of incorrect, impossible code flow, and coccinelle can't work with it...=
 But it's
>> just a thought.
>>
>>>
>>>> +@@
>>>> +identifier rule1.fn, rule1.local_err, out;
>>>> +symbol errp;
>>>> +@@
>>>> +
>>>> + fn(...)
>>>> + {
>>>> +     <...
>>>> +-    goto out;
>>>> ++    return;
>>>> +     ...>
>>>> +- out:
>>>> +-    error_propagate(errp, local_err);
>>>
>>> You neglect to match error_propagate_prepend().  Okay, because (1) that
>>> pattern doesn't occur in the tree right now, and (2) if it gets added,
>>> gcc will complain.
>>
>> No, because it should not removed. error_propagate_prepend should be con=
verted
>> to prepend, not removed. So, corresponding gotos should not be removed a=
s well.
>=20
> You're right.
>=20
>>>
>>>> + }
>>>> +
>>>> +// Convert most of local_err related staff.
>>>
>>> s/staff/stuff/
>>>
>>>> +//
>>>> +// Note, that we update everything related to matched by rule1 functi=
on name
>>>> +// and local_err name. We may match something not related to the patt=
ern
>>>> +// matched by rule1. For example, local_err may be defined with the s=
ame name
>>>> +// in different blocks inside one function, and in one block follow t=
he
>>>> +// propagation pattern and in other block doesn't. Or we may have sev=
eral
>>>> +// functions with the same name (for different configurations).
>>>
>>> Context: rule1 matches functions that have all three of
>>>
>>> * an Error **errp parameter
>>>
>>> * an Error *local_err =3D NULL variable declaration
>>>
>>> * an error_propagate(errp, local_err) or error_propagate_prepend(errp,
>>>     local_err, ...) expression, where @errp is the parameter and
>>>     @local_err is the variable.
>>>
>>> If I understand you correctly, you're pointing out two potential issues=
:
>>>
>>> 1. This rule can match functions rule1 does not match if there is
>>> another function with the same name that rule1 does match.
>>>
>>> 2. This rule matches in the entire function matched by rule1, even when
>>> parts of that function use a different @errp or @local_err.
>>>
>>> I figure these apply to all rules with identifier rule1.fn, not just
>>> this one.  Correct?
>>
>> Yes.
>=20
> Thanks!
>=20
>>>
>>> Regarding 1.  There must be a better way to chain rules together, but I
>>> don't know it.
>>>   Can we make Coccinelle at least warn us when it converts
>>> multiple functions with the same name?  What about this:
>>>
>>>      @initialize:python@
>>>      @@
>>>      fnprev =3D {}
>>>
>>>      def pr(fn, p):
>>>          print("### %s:%s: %s()" % (p[0].file, p[0].line, fn))
>>>
>>>      @r@
>>>      identifier rule1.fn;
>>>      position p;
>>>      @@
>>>       fn(...)@p
>>>       {
>>>           ...
>>>       }
>>>      @script:python@
>>>          fn << rule1.fn;
>>>          p << r.p;
>>>      @@
>>>      if fn not in fnprev:
>>>          fnprev[fn] =3D p
>>>      else:
>>>          if fnprev[fn]:
>>
>> hmm, the condition can't be false
>>
>>>              pr(fn, fnprev[fn])
>>>              fnprev[fn] =3D None
>>>          pr(fn, p)
>>
>> and we'll miss next duplication..
>=20
> The idea is
>=20
>      first instance of fn:
>          fn not in fnprev
>          fnprev[fn] =3D position of instance
>          don't print
>      second instance:
>          fnprev[fn] is the position of the first instance
>          print first two instances
>      subsequent instances: fnprev[fn] is None
>          print this instance
>=20
> I might have screwed up the coding, of course :)
>=20
>> But I like the idea.
>>
>>>
>>> For each function @fn matched by rule1, fncnt[fn] is an upper limit of
>>> the number of functions with the same name we touch.  If it's more than
>>> one, we print.
>>>
>>> Reports about a dozen function names for the whole tree in my testing.
>>> Inspecting the changes to them manually is feasible.  None of them are
>>> in files touched by this series.
>>>
>>> The line printed for the first match is pretty useless for me: it point=
s
>>> to a Coccinelle temporary file *shrug*.
>>>
>>> Regarding 2.  Shadowing @errp or @local_err would be in bad taste, and =
I
>>> sure hope we don't do that.  Multiple @local_err variables... hmm.
>>> Perhaps we could again concoct some script rules to lead us to spots to
>>> check manually.  See below for my attempt.
>>>
>>> What's the worst that could happen if we blindly converted such code?
>>> The answer to that question tells us how hard to work on finding and
>>> checking these guys.
>>>
>>>> +//
>>>> +// Note also that errp-cleaning functions
>>>> +//   error_free_errp
>>>> +//   error_report_errp
>>>> +//   error_reportf_errp
>>>> +//   warn_report_errp
>>>> +//   warn_reportf_errp
>>>> +// are not yet implemented. They must call corresponding Error* - fre=
eing
>>>> +// function and then set *errp to NULL, to avoid further propagation =
to
>>>> +// original errp (consider ERRP_AUTO_PROPAGATE in use).
>>>> +// For example, error_free_errp may look like this:
>>>> +//
>>>> +//    void error_free_errp(Error **errp)
>>>> +//    {
>>>> +//        error_free(*errp);
>>>> +//        *errp =3D NULL;
>>>> +//    }
>>>> +@ exists@
>>>> +identifier rule1.fn, rule1.local_err;
>>>> +expression list args;
>>>> +symbol errp;
>>>> +@@
>>>> +
>>>> + fn(...)
>>>> + {
>>>> +     <...
>>>> +(
>>>
>>> Each of the following patterns applies anywhere in the function.
>>>
>>> First pattern: delete @local_err
>>>
>>>> +-    Error *local_err =3D NULL;
>>>
>>> Common case: occurs just once, not nested.  Anything else is suspicious=
.
>>>
>>> Both can be detected in the resulting patches with a bit of AWK
>>> wizardry:
>>>
>>>       $ git-diff -U0 master..review-error-v8 | awk '/^@@ / { ctx =3D $5=
; for (i =3D 6; i <=3D NF; i++) ctx =3D ctx " " $i; if (ctx !=3D octx) { oc=
tx =3D ctx; n =3D 0 } } /^- *Error *\* *[A-Za-z0-9_]+ *=3D *NULL;/ { if (in=
dex($0, "E") > 6) print "nested\n    " ctx; if (n) print "more than one\n  =
  " ctx; n++ }'
>>>       nested
>>>           static void xen_block_drive_destroy(XenBlockDrive *drive, Err=
or **errp)
>>>       nested
>>>           static void xen_block_device_destroy(XenBackendInstance *back=
end,
>>>       nested
>>>           static void xen_block_device_destroy(XenBackendInstance *back=
end,
>>>       more than one
>>>           static void xen_block_device_destroy(XenBackendInstance *back=
end,
>>>
>>> Oh.
>>>
>>> xen_block_drive_destroy() nests its Error *local_err in a conditional.
>>>
>>> xen_block_device_destroy() has multiple Error *local_err.
>>>
>>> In both cases, manual review is required to ensure the conversion is
>>> okay.  I believe it is.
>>>
>>> Note that the AWK script relies on diff showing the function name in @@
>>> lines, which doesn't always work due to our coding style.
>>>
>>> For the whole tree, I get some 30 spots.  Feasible.
>>>
>>>> +|
>>>
>>> Second pattern: clear @errp after freeing it
>>>
>>>> +
>>>> +// Convert error clearing functions
>>>
>>> Suggest: Ensure @local_err is cleared on free
>>>
>>>> +(
>>>> +-    error_free(local_err);
>>>> ++    error_free_errp(errp);
>>>> +|
>>>> +-    error_report_err(local_err);
>>>> ++    error_report_errp(errp);
>>>> +|
>>>> +-    error_reportf_err(local_err, args);
>>>> ++    error_reportf_errp(errp, args);
>>>> +|
>>>> +-    warn_report_err(local_err);
>>>> ++    warn_report_errp(errp);
>>>> +|
>>>> +-    warn_reportf_err(local_err, args);
>>>> ++    warn_reportf_errp(errp, args);
>>>> +)
>>>
>>> As you mention above, these guys don't exist, yet.  Builds anyway,
>>> because this part of the rule is not used in this patch series.  You
>>> don't want to omit it, because then the script becomes unsafe to use.
>>>
>>> We could also open-code:
>>>
>>>      // Convert error clearing functions
>>>      (
>>>      -    error_free(local_err);
>>>      +    error_free(*errp);
>>>      +    *errp =3D NULL;
>>>      |
>>>      ... and so forth ...
>>>      )
>>>
>>> Matter of taste.  Whatever is easier to explain in the comments.  Since
>>> you already wrote one...
>>
>> I just feel that using helper functions is safer way..
>>
>>>
>>> We talked about extending this series slightly so these guys are used.
>>> I may still look into that.
>>>
>>>> +?-    local_err =3D NULL;
>>>> +
>>>
>>> The new helpers clear @local_err.  Assignment now redundant, delete.
>>> Okay.
>>>
>>>> +|
>>>
>>> Third and fourth pattern: delete error_propagate()
>>>
>>>> +-    error_propagate_prepend(errp, local_err, args);
>>>> ++    error_prepend(errp, args);
>>>> +|
>>>> +-    error_propagate(errp, local_err);
>>>> +|
>>>
>>> Fifth pattern: use @errp directly
>>>
>>>> +-    &local_err
>>>> ++    errp
>>>> +)
>>>> +     ...>
>>>> + }
>>>> +
>>>> +// Convert remaining local_err usage. It should be different kinds of=
 error
>>>> +// checking in if operators. We can't merge this into previous hunk, =
as this
>>>
>>> In if conditionals, I suppose.  It's the case for this patch.  If I
>>> apply the script to the whole tree, the rule gets also applied in other
>>> contexts.  The sentence might mislead as much as it helps.  Keep it or
>>> delete it?
>>
>> Maybe, just be more honest: "It should be ..., but it may be any other p=
attern, be careful"
>=20
> "Need to be careful" means "needs careful manual review", which I
> believe is not feasible; see "Preface to my review of this script"
> above.
>=20
> But do we really need to be careful here?
>=20
> This rule should apply only where we added ERRP_AUTO_PROPAGATE().
>=20
> Except when rule chaining via function name fails us, but we plan to
> detect that and review manually, so let's ignore this issue here.
>=20
> Thanks to ERRP_AUTO_PROPAGATE(), @errp is not null.  Enabling
> replacement of @local_err by @errp is its whole point.
>=20
> What exactly do we need to be careful about?

Hmm.. About some unpredicted patterns. OK, then "For example, different kin=
ds of .."

>=20
>>
>>>
>>>> +// conflicts with other substitutions in it (at least with "- local_e=
rr =3D NULL").
>>>> +@@
>>>> +identifier rule1.fn, rule1.local_err;
>>>> +symbol errp;
>>>> +@@
>>>> +
>>>> + fn(...)
>>>> + {
>>>> +     <...
>>>> +-    local_err
>>>> ++    *errp
>>>> +     ...>
>>>> + }
>>>> +
>>>> +// Always use the same patter for checking error
>>>
>>> s/patter/pattern/
>>>
>>>> +@@
>>>> +identifier rule1.fn;
>>>> +symbol errp;
>>>> +@@
>>>> +
>>>> + fn(...)
>>>> + {
>>>> +     <...
>>>> +-    *errp !=3D NULL
>>>> ++    *errp
>>>> +     ...>
>>>> + }
>>>
>=20


--=20
Best regards,
Vladimir

