Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F434C2D0F4
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 12:15:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E19FA20714
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 12:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gxhffePH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19FA20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJcHO-0003Pg-MJ
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 08:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJcG9-0002xh-4N
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 08:14:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJcG7-0005Ak-NV
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 08:14:17 -0400
Received: from mail-eopbgr150132.outbound.protection.outlook.com
 ([40.107.15.132]:10307 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jJcG7-00059e-GV
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 08:14:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTXiHh6rjRYUiEUOSNsFMNp7meDLWlZ+76WBmxzXZSSoBBb1TiSdcF3eDUBYF8n7xF+w099fLTRbkCCEyjllmyksKKxrFUo0SCFxNdJZbVqPaOnAOq8gYugeiqBxeQ/aiU7g2gPTr2yNrf9DNyc8tygoviXZ8WurD9/E2QXFK1wiRn8RI+YmT6ldfomc5IeIUkt8BEhOto/92eOIo/cev6NuK0G9OEf4zP0fBFDrbsKT5zvHCHzT/E5G0T8q4YSMFMgWZiabLxAtMJYoZg7mA5wR+jbq7WdyDpgE7kVo6B3J5qyHAz6VDQO/y/noQ/Y7AEYJaBoSN5KsUzmELP6bxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dw/onZ5Z8WN8Nr1Tcs9y5+1THcWErytesir0hCAFjzU=;
 b=YS43aSRmLR91x6wxicF00sWBw0tHOMzuA4k3ffaxfnxjqh3T6m+eAXG+V19SFIp9mOC3mFYRXJ9ZQ6z2SDpnKJvf2GND/fh4wfKzh3Q1xFcndEhpwvaEEM31AzmqS93YGt72zT3L7BnBM5U9iuAvPcWDGb9Fd0ua540XzZYC0HX7xx98xLdu2e+XkhyMt/We73Wxt1YcLgXzNe219NXSB+Qf2jlBFPwvksQ7VoQ8ERCWr4PbBN4fh+RREC+w11ohXFcj3fDGebqUkOrpTrS8hro32pce81MIsBBrlshuOe2gRbQ/OSEbDVIDV+PARpTQKykyVkCYO80ql/wnoo8l0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dw/onZ5Z8WN8Nr1Tcs9y5+1THcWErytesir0hCAFjzU=;
 b=gxhffePH5s6jK08oZHfxicqYX3u9MasRTt0Wb1Ji9VsIgZ2MoKzvHiZ5jaKGDECZ2BJjtUmoX1ypH66XZ8z6nzoOZeMZVZYghq7M+F9K8fMWMkIlojWYn3PW4ULqbHEfhvW1W38vWESffE054a6BjkMnk4hV9mUPP5+mzYK7nhY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5527.eurprd08.prod.outlook.com (10.141.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Wed, 1 Apr 2020 12:14:13 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.014; Wed, 1 Apr 2020
 12:14:13 +0000
Subject: Re: Questionable aspects of QEMU Error's design
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <87o8sblgto.fsf@dusky.pond.sub.org>
 <e980477d-3951-2a2b-fa38-dee8e1895019@virtuozzo.com>
X-Tagtoolbar-Keys: D20200401151412180
Message-ID: <b7f46fa1-e89e-161a-b4d9-c7b6fd3b13be@virtuozzo.com>
Date: Wed, 1 Apr 2020 15:14:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <e980477d-3951-2a2b-fa38-dee8e1895019@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM3PR07CA0138.eurprd07.prod.outlook.com
 (2603:10a6:207:8::24) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.23) by
 AM3PR07CA0138.eurprd07.prod.outlook.com (2603:10a6:207:8::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.9 via Frontend Transport; Wed, 1 Apr 2020 12:14:13 +0000
X-Tagtoolbar-Keys: D20200401151412180
X-Originating-IP: [185.215.60.23]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57bdacdb-de21-4013-e837-08d7d6363101
X-MS-TrafficTypeDiagnostic: AM7PR08MB5527:
X-Microsoft-Antispam-PRVS: <AM7PR08MB55278CFA5FB75EC6C4F290AAC1C90@AM7PR08MB5527.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 03607C04F0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(39840400004)(136003)(396003)(366004)(376002)(346002)(316002)(36756003)(5660300002)(478600001)(86362001)(66946007)(186003)(66476007)(31696002)(956004)(2616005)(26005)(16526019)(66556008)(31686004)(8676002)(16576012)(2906002)(8936002)(81166006)(81156014)(6486002)(52116002)(4326008);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5AxaJVUff8bFGbjX32uXQxR8RIh/Gv/Qq9mvibrDUEYw2nsIEjf8fGUzcYWiDn7kpWwHHtHh8ACcLfy3bes5vmqn2nnZPnY2d8oryymfsXkwQ7rGZ19uhB08+YEk5c3ti0yKwfRu8Tn3XmQh08boLB//VUuPYCOWA28o/6WgRvSEFgxDpCaGJChj5VdIsgq2dzDjxzRgU91RT7dDU+M6tMNy/0QKe76mCbXg8IonuRAiWhAaxQGK+zQClhlS/fen1m1hIFuOs83vH5dbk7t+ME+DuvGgZbYAio9cU7DHixgbq0mPfxUVNx71r9H1ltjxG0sxBP8VujGBmxPq9CQok3c4zInRzfEs9uqUYZFKk3jtJtV4jviu2Dx1voIejs2b5n3tM9ip++ptN9vWsmweqF+Nzjy4EkF917C6ZZGhI4HjKhWhIBEIsAPF7EH0eicJ
X-MS-Exchange-AntiSpam-MessageData: QMfi7K2YLNdewNLgGdBFi3XFsfLWi/N18Utoi7h6Qoo3vp4tDt7rHFhoLrUiOUr8C5INUZZtBDcKxBsJHD4TAk/W1uMlMG6PFoOFs9J923yFitrABgS0n7jSNfbU4JjejX67qkW9VQsLqa5wHEgzCA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57bdacdb-de21-4013-e837-08d7d6363101
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 12:14:13.6345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FmAU/7WLNCLK+1VsrA/AN7b+XDbpRgrdv+fkmhRJ6OynGT4e05EDfxvBvd17Cr+OBEsENSKXxoPHGnYqhsYfFm3XFK1KGTnggtpiWKDzelQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5527
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.15.132
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

01.04.2020 15:10, Vladimir Sementsov-Ogievskiy wrote:
> 01.04.2020 12:02, Markus Armbruster wrote:
>> QEMU's Error was patterned after GLib's GError.=C2=A0 Differences includ=
e:
>>
>> * &error_fatal, &error_abort for convenience
>>
>> * Error can optionally store hints
>>
>> * Pointlessly different names: error_prepend() vs. g_error_prefix() and
>> =C2=A0=C2=A0 so forth *shrug*
>>
>> * Propagating errors
>>
>> =C2=A0=C2=A0 Thanks to Vladimir, we'll soon have "auto propagation", whi=
ch is less
>> =C2=A0=C2=A0 verbose and less error-prone.
>>
>> * Accumulating errors
>>
>> =C2=A0=C2=A0 error_propagate() permits it, g_propagate_error() does not[=
*].
>>
>> =C2=A0=C2=A0 I believe this feature is used rarely.=C2=A0 Perhaps we'd b=
e better off
>> =C2=A0=C2=A0 without it.=C2=A0 The problem is identifying its uses.=C2=
=A0 If I remember
>> =C2=A0=C2=A0 correctly, Vladimir struggled with that for his "auto propa=
gation"
>> =C2=A0=C2=A0 work.
>>
>> =C2=A0=C2=A0 Perhaps "auto propagation" will reduce the number of manual
>> =C2=A0=C2=A0 error_propagate() to the point where we can identify accumu=
lations.
>> =C2=A0=C2=A0 Removing the feature would become feasible then.
>>
>> * Distinguishing different errors
>>
>> =C2=A0=C2=A0 Where Error has ErrorClass, GError has Gquark domain, gint =
code.=C2=A0 Use
>> =C2=A0=C2=A0 of ErrorClass other than ERROR_CLASS_GENERIC_ERROR is stron=
gly
>> =C2=A0=C2=A0 discouraged.=C2=A0 When we need callers to distinguish erro=
rs, we return
>> =C2=A0=C2=A0 suitable error codes separately.
>>
>> * Return value conventions
>>
>> =C2=A0=C2=A0 Common: non-void functions return a distinct error value on=
 failure
>> =C2=A0=C2=A0 when such a value can be defined.=C2=A0 Patterns:
>>
>> =C2=A0=C2=A0 - Functions returning non-null pointers on success return n=
ull pointer
>> =C2=A0=C2=A0=C2=A0=C2=A0 on failure.
>>
>> =C2=A0=C2=A0 - Functions returning non-negative integers on success retu=
rn a
>> =C2=A0=C2=A0=C2=A0=C2=A0 negative error code on failure.
>>
>> =C2=A0=C2=A0 Different: GLib discourages void functions, because these l=
ead to
>> =C2=A0=C2=A0 awkward error checking code.=C2=A0 We have tons of them, an=
d tons of
>> =C2=A0=C2=A0 awkward error checking code:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 Error *err =3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0 frobnicate(arg, &err);
>> =C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ... recover ...
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate(errp, e=
rr);
>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> =C2=A0=C2=A0 instead of
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 if (!frobnicate(arg, errp))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ... recover ...
>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> =C2=A0=C2=A0 Can also lead to pointless creation of Error objects.
>>
>> =C2=A0=C2=A0 I consider this a design mistake.=C2=A0 Can we still fix it=
?=C2=A0 We have more
>> =C2=A0=C2=A0 than 2000 void functions taking an Error ** parameter...
>>
>> =C2=A0=C2=A0 Transforming code that receives and checks for errors with =
Coccinelle
>> =C2=A0=C2=A0 shouldn't be hard.=C2=A0 Transforming code that returns err=
ors seems more
>> =C2=A0=C2=A0 difficult.=C2=A0 We need to transform explicit and implicit=
 return to
>> =C2=A0=C2=A0 either return true or return false, depending on what we di=
d to the
>> =C2=A0=C2=A0 @errp parameter on the way to the return.=C2=A0 Hmm.
>>
>>
>> [*] According to documentation; the code merely calls g_warning() then,
>> in typical GLib fashion.
>>
>=20
>=20
> Side question:
>=20
> Can we somehow implement a possibility to reliably identify file and line=
 number
> where error is set by error message?
>=20
> It's where debug of error-bugs always starts: try to imagine which parts =
of the error
> message are "%s", and how to grep for it in the code, keeping in mind als=
o,
> that error massage may be split into several lines..
>=20
> Put file:line into each error? Seems too noisy for users.. A lot of error=
s are not
> bugs: use do something wrong and see the error, and understands what he i=
s doing
> wrong.. It's not usual practice to print file:line into each message for =
user.
>=20
>=20
> But what if we do some kind of mapping file:line <-> error code, so user =
will see
> something like:
>=20
>=20
>  =C2=A0=C2=A0 Error 12345: Device drive-scsi0-0-0-0 is not found
>=20
> ....
>=20
> Hmm, maybe, just add one more argument to error_setg:
>=20
> error_setg(errp, 12345, "Device %s is not found", device_name);
>=20
> - it's enough grep-able.
>=20


Or, maybe, go the hard way, add a script, which smartly search for error me=
ssage in code-base,
correctly handling "%s" and multi-line messages.. And add to checkpatch a c=
heck
that new added error messages doesn't match to any of existing.

Hmm. I think, I'll try to do something like this.



--=20
Best regards,
Vladimir

