Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BB2C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 07:45:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7370224677
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 07:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="eWZ2LNk/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7370224677
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBZZt-0000QY-GI
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 03:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jBZZA-0008L4-8m
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 03:44:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jBZZ7-000786-IV
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 03:44:40 -0400
Received: from mail-db8eur05on2118.outbound.protection.outlook.com
 ([40.107.20.118]:23329 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jBZYy-0006sH-RG; Tue, 10 Mar 2020 03:44:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqAxZTvasyOnFZ1VNP/qmTYzwQoXEkwr/R6Y8AU1/nEdGup6IZqMDv6WvT+GM2b5r+4XHB97aNvxjCdMHHiAYSi9dfnKk5iYhHsFN+lG2jBi7BgGRuJfYsuCX77zBMQdnbVibku9tbeQZK3hiwC325PK6eIniE5iCAFGwwmD82vtPkdtL2gejDNidLRkRsDHdAShrnlWle7wVvBoQ7lcrgwedbU2CVCmhDZbnp7JGRFGBM6fG9CPI4xg0sG9yArSbVHduKAloi+VO7c5w0yNLMvhV3SJ9piVDMbvJo2l1KUjgIuYh7vTowJt3pX1Afm8sYGPs7pH9rN2YVhEGoOybA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1DArs3hULPds8mFTUJzEMnW6wW5lnk6t0D8MYKCJYI=;
 b=kUWfvSh+INsJcBCgdVu5WdTtkAKjq4lhDk4VeJ/o2WMhOkmBSpslFoHD89IQ9xnBOy0yW0JuXKLC1nav7MbYMubb37wMiX1TOfMVagJDEk3affEZMGV5WBp+1eT88inPdaWV9aSmRJVtd/KX0lD62mbrqvVuYv2XMFWb+NnCapL9XCyfFkol8mIMms4VMEaGWxOoj1fJOlAShswRoQIEaMMiFiLtj3DHWjWtVckQPKQxkR192EhUZKGwhCBJyRdeMeNy5+hRmvrOHisrfmXFJPFjhd9gV7Sl1m0t4/LZrGnZj0mjyr48BUq0lRiVifMNFaPC9HAPIbXlcimrXNeRQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1DArs3hULPds8mFTUJzEMnW6wW5lnk6t0D8MYKCJYI=;
 b=eWZ2LNk/xCnm7AV5rFQ/RK4+MiVb05eOdvf7ZlE63xyQfwCA3++9KjApUKGjJYTzB9HYJW2+ZskyHeM13HU7QsKHNn8Ajo6IxayYBwRCEyS9fEstPcr1WcGZijLaogsUgzeqcnPnGhZQ4B+h/opljBe/sNqzbhMIv6tLfoIbJFw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB5206.eurprd08.prod.outlook.com (10.255.122.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16; Tue, 10 Mar 2020 07:44:25 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2793.018; Tue, 10 Mar 2020
 07:44:25 +0000
Subject: Re: [PATCH v8 02/10] scripts: add coccinelle script to use auto
 propagated errp
To: Markus Armbruster <armbru@redhat.com>
References: <20200306051536.27803-1-vsementsov@virtuozzo.com>
 <20200306051536.27803-3-vsementsov@virtuozzo.com>
 <87lfo997hs.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200310104422742
Message-ID: <e5b19cf6-f206-a0ed-27cc-173c3a137ef2@virtuozzo.com>
Date: Tue, 10 Mar 2020 10:44:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <87lfo997hs.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR07CA0040.eurprd07.prod.outlook.com
 (2603:10a6:7:66::26) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR07CA0040.eurprd07.prod.outlook.com (2603:10a6:7:66::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.6 via Frontend Transport; Tue, 10 Mar 2020 07:44:24 +0000
X-Tagtoolbar-Keys: D20200310104422742
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b33c834-7f2e-4142-ccde-08d7c4c6db17
X-MS-TrafficTypeDiagnostic: AM6PR08MB5206:
X-Microsoft-Antispam-PRVS: <AM6PR08MB5206903766967A9714B7A033C1FF0@AM6PR08MB5206.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(346002)(39850400004)(366004)(376002)(396003)(136003)(189003)(199004)(52116002)(6916009)(86362001)(26005)(8936002)(8676002)(4326008)(81156014)(81166006)(478600001)(5660300002)(54906003)(316002)(2906002)(16576012)(31686004)(7416002)(36756003)(6486002)(66946007)(186003)(16526019)(30864003)(2616005)(956004)(66476007)(66556008)(31696002)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5206;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hi6F09e1JOZFVYHcC8mG119n3W4JxX0oq68k+hNnx//zsgjWwv4vofmXkI4Gz7FrtfCB2z19lfUPc4Csurnln5+pVQVF0qoGhoi4S7F45HUs2H/OaboOn/x4EUyvIWZ4CJCVmYDxbh8oKbaykJyuSNGQLTHNQZq5iPW0AT8QZbhrSXecRK1ZaQ9J1ZnDwR/UHTBfJg+O3XbbItUTExajtcFhTxum0pJKtFS2cbds/6qrU4ErpJxhIC5cp9OpMDACgvsPcZzeZ+Q1ecbiEULcmI60kZXBfiDvBaDi6rgL0l0XT1sGP6YwOh1HXK8D3LzZnqrrEK0fIND16MbvjGHr6GtwtmsNmW4/2cHllgu43gxwhfKiUq1DhRAZdkYT3CWLBYOR/nMJhk03LIn4f3NNLWSkmpF98tUUH+s1RC48v+mDdgZ+1EfZHBY7HicD1B1p9b0kQS7TwoVfxQ/WVTKwE4pO9bGp9oYQL6YnNKQBBp0bQ2ilOTUuk9S2Z89S2Wgr2WdSI8xTEqD9xGaivR8EUS3AIh0gEmIg7I2AwfKeADmowFutcyfpwx1CaBlHlXNA
X-MS-Exchange-AntiSpam-MessageData: u6zlm/Dh/r8/wGQ9j2v0gox0p4FaGgYL1Vz+cTRZjGES3hTQpxa1f42ucVcc0A28vclLi2QodJPWPIH3foWGbQWtPgBp2qJkRIPvGIvy7oTnQFuaK6f0XzmywkoIoIQOV9sAC6prxRQCenm15f0Izw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b33c834-7f2e-4142-ccde-08d7c4c6db17
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 07:44:25.7581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+7KkSU5SH9zuw0C05mAoLt9Gn0xWv1qfEWJRRp/WbsXRjGVR4GuBlXtZQIouNB1hGrbEzBFXFx2OOuqgrCh8AWAeLc/Y6tjVliocxQLZuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5206
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.20.118
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
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Laszlo Ersek <lersek@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

09.03.2020 12:56, Markus Armbruster wrote:
> Suggest
>=20
>      scripts: Coccinelle script to use auto-propagated errp
>=20
> or
>=20
>      scripts: Coccinelle script to use ERRP_AUTO_PROPAGATE()
>=20
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>=20
>> Script adds ERRP_AUTO_PROPAGATE macro invocation where appropriate and
>> does corresponding changes in code (look for details in
>> include/qapi/error.h)
>>
>> Usage example:
>> spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>>   --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff \
>>   blockdev-nbd.c qemu-nbd.c {block/nbd*,nbd/*,include/block/nbd*}.[hc]
>=20
> Suggest FILES... instead of a specific set of files.
>=20
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>
>> Cc: Eric Blake <eblake@redhat.com>
>> Cc: Kevin Wolf <kwolf@redhat.com>
>> Cc: Max Reitz <mreitz@redhat.com>
>> Cc: Greg Kurz <groug@kaod.org>
>> Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>
>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>> Cc: Anthony Perard <anthony.perard@citrix.com>
>> Cc: Paul Durrant <paul@xen.org>
>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
>> Cc: Laszlo Ersek <lersek@redhat.com>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> Cc: Stefan Berger <stefanb@linux.ibm.com>
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
>> Cc: qemu-block@nongnu.org
>> Cc: qemu-devel@nongnu.org
>> Cc: xen-devel@lists.xenproject.org
>>
>>   include/qapi/error.h                          |   3 +
>>   scripts/coccinelle/auto-propagated-errp.cocci | 231 ++++++++++++++++++
>>   2 files changed, 234 insertions(+)
>>   create mode 100644 scripts/coccinelle/auto-propagated-errp.cocci
>>
>> diff --git a/include/qapi/error.h b/include/qapi/error.h
>> index bb9bcf02fb..fbfc6f1c0b 100644
>> --- a/include/qapi/error.h
>> +++ b/include/qapi/error.h
>> @@ -211,6 +211,9 @@
>>    *         }
>>    *         ...
>>    *     }
>> + *
>> + * For mass conversion use script
>=20
> mass-conversion (we're not converting mass, we're converting en masse)
>=20
>> + *   scripts/coccinelle/auto-propagated-errp.cocci
>>    */
>>  =20
>>   #ifndef ERROR_H
>> diff --git a/scripts/coccinelle/auto-propagated-errp.cocci b/scripts/coc=
cinelle/auto-propagated-errp.cocci
>> new file mode 100644
>> index 0000000000..bff274bd6d
>> --- /dev/null
>> +++ b/scripts/coccinelle/auto-propagated-errp.cocci
>=20
> Preface to my review of this script: may aim isn't to make it
> bullet-proof.  I want to (1) make it good enough (explained in a
> jiffie), and (2) automatically identify the spots where it still isn't
> obviously safe for manual review.
>=20
> The latter may involve additional scripting.  That's okay.
>=20
> The script is good enough when the number of possibly unsafe spots is
> low enough for careful manual review.
>=20
> When I ask for improvements that, in your opinion, go beyond "good
> enough", please push back.  I'm sure we can work it out together.
>=20
>> @@ -0,0 +1,231 @@
>> +// Use ERRP_AUTO_PROPAGATE (see include/qapi/error.h)
>> +//
>> +// Copyright (c) 2020 Virtuozzo International GmbH.
>> +//
>> +// This program is free software; you can redistribute it and/or modify
>> +// it under the terms of the GNU General Public License as published by
>> +// the Free Software Foundation; either version 2 of the License, or
>> +// (at your option) any later version.
>> +//
>> +// This program is distributed in the hope that it will be useful,
>> +// but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +// GNU General Public License for more details.
>> +//
>> +// You should have received a copy of the GNU General Public License
>> +// along with this program.  If not, see <http://www.gnu.org/licenses/>=
.
>> +//
>> +// Usage example:
>> +// spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>> +//  --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff \
>> +//  --max-width 80 blockdev-nbd.c qemu-nbd.c \
>=20
> You have --max-width 80 here, but not in the commit message.  Default
> seems to be 78.  Any particular reason to change it to 80?

Hmm. As I remember, without this parameter, reindenting doesn't work correc=
tly.
So, I'm OK with "--max-width 78", but I doubt that it will work without a p=
arameter.
Still, may be I'm wrong, we can check it.

>=20
>> +//  {block/nbd*,nbd/*,include/block/nbd*}.[hc]
>> +
>> +// Switch unusual (Error **) parameter names to errp
>=20
> Let's drop the parenthesis around Error **
>=20
>> +// (this is necessary to use ERRP_AUTO_PROPAGATE).
>=20
> Perhaps ERRP_AUTO_PROPAGATE() should be ERRP_AUTO_PROPAGATE(errp) to
> make the fact we're messing with @errp more obvious.  Too late; I
> shouldn't rock the boat that much now.
>=20
>> +//
>> +// Disable optional_qualifier to skip functions with "Error *const *err=
p"
>> +// parameter.
>> +//
>> +// Skip functions with "assert(_errp && *_errp)" statement, as they hav=
e
>> +// non generic semantics and may have unusual Error ** argument name fo=
r purpose
>=20
> non-generic
>=20
> for a purpose
>=20
> Wrap comment lines around column 70, please.  It's easier to read.
>=20
> Maybe
>=20
>     // Skip functions with "assert(_errp && *_errp)" statement, because t=
hat
>     // signals unusual semantics, and the parameter name may well serve a
>     // purpose.

Sounds good.

>=20
>> +// (like nbd_iter_channel_error()).
>> +//
>> +// Skip util/error.c to not touch, for example, error_propagate and
>> +// error_propagate_prepend().
>=20
> error_propagate()
>=20
> I much appreciate your meticulous explanation of what you skip and why.
>=20
>> +@ depends on !(file in "util/error.c") disable optional_qualifier@
>> +identifier fn;
>> +identifier _errp !=3D errp;
>> +@@
>> +
>> + fn(...,
>> +-   Error **_errp
>> ++   Error **errp
>> +    ,...)
>> + {
>> +(
>> +     ... when !=3D assert(_errp && *_errp)
>> +&
>> +     <...
>> +-    _errp
>> ++    errp
>> +     ...>
>> +)
>> + }
>=20
> This rule is required to make the actual transformations (below) work
> even for parameters with names other than @errp.  I believe it's not
> used in this series.  In fact, I can't see a use for it in the entire
> tree right now.  Okay anyway.
>=20
>> +
>> +// Add invocation of ERRP_AUTO_PROPAGATE to errp-functions where necess=
ary
>> +//
>> +// Note, that without "when any" final "..." may not want to mach somet=
hing
>=20
> s/final "..." may not mach/the final "..." does not match/
>=20
>> +// matched by previous pattern, i.e. the rule will not match double
>> +// error_prepend in control flow like in vfio_set_irq_signaling().
>=20
> Can't say I fully understand Coccinelle there.  I figure you came to
> this knowledge the hard way.

It's follows from smpl grammar document:

"Implicitly, =E2=80=9C...=E2=80=9D matches the shortest path between someth=
ing that matches the pattern before the dots (or the beginning of the funct=
ion, if there is nothing before the dots) and something that matches the pa=
ttern after the dots (or the end of the function, if there is nothing after=
 the dots)."
...
"_when any_ removes the aforementioned constraint that =E2=80=9C...=E2=80=
=9D matches the shortest path"

>=20
>> +//
>> +// Note, "exists" says that we want apply rule even if it matches not o=
n
>> +// all possible control flows (otherwise, it will not match standard pa=
ttern
>> +// when error_propagate() call is in if branch).
>=20
> Learned something new.  Example: kvm_set_kvm_shadow_mem().
>=20
> Spelling it "exists disable optional_qualifier" would avoid giving
> readers the idea we're disabling "exists", but Coccinelle doesn't let
> us.  Oh well.
>=20
>> +@ disable optional_qualifier exists@
>> +identifier fn, local_err, errp;
>=20
> I believe this causes
>=20
>      warning: line 98: errp, previously declared as a metavariable, is us=
ed as an identifier
>      warning: line 104: errp, previously declared as a metavariable, is u=
sed as an identifier
>      warning: line 106: errp, previously declared as a metavariable, is u=
sed as an identifier
>      warning: line 131: errp, previously declared as a metavariable, is u=
sed as an identifier
>      warning: line 192: errp, previously declared as a metavariable, is u=
sed as an identifier
>      warning: line 195: errp, previously declared as a metavariable, is u=
sed as an identifier
>      warning: line 228: errp, previously declared as a metavariable, is u=
sed as an identifier
>=20
> Making @errp symbol instead of identifier should fix this.

Hmm, I didn't see these warnings.. But yes, it should be symbol.

>=20
>> +@@
>> +
>> + fn(..., Error **errp, ...)
>> + {
>> ++   ERRP_AUTO_PROPAGATE();
>> +    ...  when !=3D ERRP_AUTO_PROPAGATE();
>> +(
>> +    error_append_hint(errp, ...);
>> +|
>> +    error_prepend(errp, ...);
>> +|
>> +    error_vprepend(errp, ...);
>> +|
>> +    Error *local_err =3D NULL;
>> +    ...
>> +(
>> +    error_propagate_prepend(errp, local_err, ...);
>> +|
>> +    error_propagate(errp, local_err);
>> +)
>> +)
>> +    ... when any
>> + }
>> +
>> +
>> +// Match scenarios with propagation of local error to errp.
>> +@rule1 disable optional_qualifier exists@
>> +identifier fn, local_err;
>> +symbol errp;
>> +@@
>> +
>> + fn(..., Error **errp, ...)
>> + {
>> +     ...
>> +     Error *local_err =3D NULL;
>> +     ...
>> +(
>> +    error_propagate_prepend(errp, local_err, ...);
>> +|
>> +    error_propagate(errp, local_err);
>> +)
>=20
> Indentation off by one.
>=20
>> +     ...
>> + }
>> +
>> +// Convert special case with goto in separate.
>=20
> s/in separate/separately/
>=20
>> +// We can probably merge this into the following hunk with help of ( | =
)
>> +// operator, but it significantly reduce performance on block.c parsing=
 (or it
>=20
> s/reduce/reduces/
>=20
>> +// hangs, I don't know)
>=20
> Sounds like you tried to merge this into the following hunk, but then
> spatch took so long on block.c that you killed it.  Correct?

Yes.

>=20
>> +//
>> +// Note interesting thing: if we don't do it here, and try to fixup "ou=
t: }"
>> +// things later after all transformations (the rule will be the same, j=
ust
>> +// without error_propagate() call), coccinelle fails to match this "out=
: }".
>=20
> Weird, but not worth further investigation.

It partially match to the idea which I saw somewhere in coccinelle document=
ation,
that coccinelle converts correct C code to correct C code. "out: }" is an e=
xample
of incorrect, impossible code flow, and coccinelle can't work with it... Bu=
t it's
just a thought.

>=20
>> +@@
>> +identifier rule1.fn, rule1.local_err, out;
>> +symbol errp;
>> +@@
>> +
>> + fn(...)
>> + {
>> +     <...
>> +-    goto out;
>> ++    return;
>> +     ...>
>> +- out:
>> +-    error_propagate(errp, local_err);
>=20
> You neglect to match error_propagate_prepend().  Okay, because (1) that
> pattern doesn't occur in the tree right now, and (2) if it gets added,
> gcc will complain.

No, because it should not removed. error_propagate_prepend should be conver=
ted
to prepend, not removed. So, corresponding gotos should not be removed as w=
ell.

>=20
>> + }
>> +
>> +// Convert most of local_err related staff.
>=20
> s/staff/stuff/
>=20
>> +//
>> +// Note, that we update everything related to matched by rule1 function=
 name
>> +// and local_err name. We may match something not related to the patter=
n
>> +// matched by rule1. For example, local_err may be defined with the sam=
e name
>> +// in different blocks inside one function, and in one block follow the
>> +// propagation pattern and in other block doesn't. Or we may have sever=
al
>> +// functions with the same name (for different configurations).
>=20
> Context: rule1 matches functions that have all three of
>=20
> * an Error **errp parameter
>=20
> * an Error *local_err =3D NULL variable declaration
>=20
> * an error_propagate(errp, local_err) or error_propagate_prepend(errp,
>    local_err, ...) expression, where @errp is the parameter and
>    @local_err is the variable.
>=20
> If I understand you correctly, you're pointing out two potential issues:
>=20
> 1. This rule can match functions rule1 does not match if there is
> another function with the same name that rule1 does match.
>=20
> 2. This rule matches in the entire function matched by rule1, even when
> parts of that function use a different @errp or @local_err.
>=20
> I figure these apply to all rules with identifier rule1.fn, not just
> this one.  Correct?

Yes.

>=20
> Regarding 1.  There must be a better way to chain rules together, but I
> don't know it.
>  Can we make Coccinelle at least warn us when it converts
> multiple functions with the same name?  What about this:
>=20
>     @initialize:python@
>     @@
>     fnprev =3D {}
>=20
>     def pr(fn, p):
>         print("### %s:%s: %s()" % (p[0].file, p[0].line, fn))
>=20
>     @r@
>     identifier rule1.fn;
>     position p;
>     @@
>      fn(...)@p
>      {
>          ...
>      }
>     @script:python@
>         fn << rule1.fn;
>         p << r.p;
>     @@
>     if fn not in fnprev:
>         fnprev[fn] =3D p
>     else:
>         if fnprev[fn]:

hmm, the condition can't be false

>             pr(fn, fnprev[fn])
>             fnprev[fn] =3D None
>         pr(fn, p)

and we'll miss next duplication..

But I like the idea.

>=20
> For each function @fn matched by rule1, fncnt[fn] is an upper limit of
> the number of functions with the same name we touch.  If it's more than
> one, we print.
>=20
> Reports about a dozen function names for the whole tree in my testing.
> Inspecting the changes to them manually is feasible.  None of them are
> in files touched by this series.
>=20
> The line printed for the first match is pretty useless for me: it points
> to a Coccinelle temporary file *shrug*.
>=20
> Regarding 2.  Shadowing @errp or @local_err would be in bad taste, and I
> sure hope we don't do that.  Multiple @local_err variables... hmm.
> Perhaps we could again concoct some script rules to lead us to spots to
> check manually.  See below for my attempt.
>=20
> What's the worst that could happen if we blindly converted such code?
> The answer to that question tells us how hard to work on finding and
> checking these guys.
>=20
>> +//
>> +// Note also that errp-cleaning functions
>> +//   error_free_errp
>> +//   error_report_errp
>> +//   error_reportf_errp
>> +//   warn_report_errp
>> +//   warn_reportf_errp
>> +// are not yet implemented. They must call corresponding Error* - freei=
ng
>> +// function and then set *errp to NULL, to avoid further propagation to
>> +// original errp (consider ERRP_AUTO_PROPAGATE in use).
>> +// For example, error_free_errp may look like this:
>> +//
>> +//    void error_free_errp(Error **errp)
>> +//    {
>> +//        error_free(*errp);
>> +//        *errp =3D NULL;
>> +//    }
>> +@ exists@
>> +identifier rule1.fn, rule1.local_err;
>> +expression list args;
>> +symbol errp;
>> +@@
>> +
>> + fn(...)
>> + {
>> +     <...
>> +(
>=20
> Each of the following patterns applies anywhere in the function.
>=20
> First pattern: delete @local_err
>=20
>> +-    Error *local_err =3D NULL;
>=20
> Common case: occurs just once, not nested.  Anything else is suspicious.
>=20
> Both can be detected in the resulting patches with a bit of AWK
> wizardry:
>=20
>      $ git-diff -U0 master..review-error-v8 | awk '/^@@ / { ctx =3D $5; f=
or (i =3D 6; i <=3D NF; i++) ctx =3D ctx " " $i; if (ctx !=3D octx) { octx =
=3D ctx; n =3D 0 } } /^- *Error *\* *[A-Za-z0-9_]+ *=3D *NULL;/ { if (index=
($0, "E") > 6) print "nested\n    " ctx; if (n) print "more than one\n    "=
 ctx; n++ }'
>      nested
>          static void xen_block_drive_destroy(XenBlockDrive *drive, Error =
**errp)
>      nested
>          static void xen_block_device_destroy(XenBackendInstance *backend=
,
>      nested
>          static void xen_block_device_destroy(XenBackendInstance *backend=
,
>      more than one
>          static void xen_block_device_destroy(XenBackendInstance *backend=
,
>=20
> Oh.
>=20
> xen_block_drive_destroy() nests its Error *local_err in a conditional.
>=20
> xen_block_device_destroy() has multiple Error *local_err.
>=20
> In both cases, manual review is required to ensure the conversion is
> okay.  I believe it is.
>=20
> Note that the AWK script relies on diff showing the function name in @@
> lines, which doesn't always work due to our coding style.
>=20
> For the whole tree, I get some 30 spots.  Feasible.
>=20
>> +|
>=20
> Second pattern: clear @errp after freeing it
>=20
>> +
>> +// Convert error clearing functions
>=20
> Suggest: Ensure @local_err is cleared on free
>=20
>> +(
>> +-    error_free(local_err);
>> ++    error_free_errp(errp);
>> +|
>> +-    error_report_err(local_err);
>> ++    error_report_errp(errp);
>> +|
>> +-    error_reportf_err(local_err, args);
>> ++    error_reportf_errp(errp, args);
>> +|
>> +-    warn_report_err(local_err);
>> ++    warn_report_errp(errp);
>> +|
>> +-    warn_reportf_err(local_err, args);
>> ++    warn_reportf_errp(errp, args);
>> +)
>=20
> As you mention above, these guys don't exist, yet.  Builds anyway,
> because this part of the rule is not used in this patch series.  You
> don't want to omit it, because then the script becomes unsafe to use.
>=20
> We could also open-code:
>=20
>     // Convert error clearing functions
>     (
>     -    error_free(local_err);
>     +    error_free(*errp);
>     +    *errp =3D NULL;
>     |
>     ... and so forth ...
>     )
>=20
> Matter of taste.  Whatever is easier to explain in the comments.  Since
> you already wrote one...

I just feel that using helper functions is safer way..

>=20
> We talked about extending this series slightly so these guys are used.
> I may still look into that.
>=20
>> +?-    local_err =3D NULL;
>> +
>=20
> The new helpers clear @local_err.  Assignment now redundant, delete.
> Okay.
>=20
>> +|
>=20
> Third and fourth pattern: delete error_propagate()
>=20
>> +-    error_propagate_prepend(errp, local_err, args);
>> ++    error_prepend(errp, args);
>> +|
>> +-    error_propagate(errp, local_err);
>> +|
>=20
> Fifth pattern: use @errp directly
>=20
>> +-    &local_err
>> ++    errp
>> +)
>> +     ...>
>> + }
>> +
>> +// Convert remaining local_err usage. It should be different kinds of e=
rror
>> +// checking in if operators. We can't merge this into previous hunk, as=
 this
>=20
> In if conditionals, I suppose.  It's the case for this patch.  If I
> apply the script to the whole tree, the rule gets also applied in other
> contexts.  The sentence might mislead as much as it helps.  Keep it or
> delete it?

Maybe, just be more honest: "It should be ..., but it may be any other patt=
ern, be careful"

>=20
>> +// conflicts with other substitutions in it (at least with "- local_err=
 =3D NULL").
>> +@@
>> +identifier rule1.fn, rule1.local_err;
>> +symbol errp;
>> +@@
>> +
>> + fn(...)
>> + {
>> +     <...
>> +-    local_err
>> ++    *errp
>> +     ...>
>> + }
>> +
>> +// Always use the same patter for checking error
>=20
> s/patter/pattern/
>=20
>> +@@
>> +identifier rule1.fn;
>> +symbol errp;
>> +@@
>> +
>> + fn(...)
>> + {
>> +     <...
>> +-    *errp !=3D NULL
>> ++    *errp
>> +     ...>
>> + }
>=20


--=20
Best regards,
Vladimir

