Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6072C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 12:49:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DB472078B
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 12:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MF12B1aX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DB472078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJcoW-00049t-LI
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 08:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58011)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJcmR-00020Z-DT
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 08:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJcmP-0005gV-8o
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 08:47:38 -0400
Received: from mail-am6eur05on2096.outbound.protection.outlook.com
 ([40.107.22.96]:26080 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jJcmO-0005cy-GD
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 08:47:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1tCyVeNsfUScsSyaMOcKPrcZizCGxFviV10kTe18haFVzLq6C/iRTVbK8/Prmzz6bv2jELm+25y9DR5EMNsIfLQjIbGvhNnNOBlPRvvt4FquoHMvaGjZ8tSfQtDUiDA8x97foG364LqT/wcBTF+RhvAR/mmnflIPYMq2sUzG9GtZXZxugaGuio1y8mkzPKj+zMSCcRFdAPgvHTaWx0lc9SfWOziLrxM2We+Wf93hkQlITe+HE5t0tGbowCibkubg74A/ld8sV+mJZrHumsKSvOLZ5SdDkfePnaasU1s9DO138TiKmSDiMYHorMWxqgLZVteFfyZraSFFhAJfLgUZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGMPnb2DmVmzGRtopoyn2Tj+DDTS5cbZczLuqQtisUY=;
 b=gVs4B3XLLiKJpWiiVWxLYdv0VFHRIcGm1j7BYMKRFrbk9AECI3ZeDqu29uo2hAVyLqGnvL6fqu/JFeD9k3/cItVMBfhU9Abn041GgFqf2MfspxOvX3pZDtWx2vYHYiW0Urnfa/eBldjMIBoR86eTZA6ui8vi3ItypTGr/H/20gDu4acsbhkX3+NuKIaGxy9aRul4X6nxznuvv7y1+QlMleQEBJ/SOV8XZjchj0yn0+Vltri+slZDsHoLeuZ0hit9wUWT3v6Q+T3WUadqaPA+89sfnjKwAFzotGjGXVT5bdYs0t0TFQLUq3cq/IcTY1Ph7bXKQ8OMf9kFbvtQdXgUKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGMPnb2DmVmzGRtopoyn2Tj+DDTS5cbZczLuqQtisUY=;
 b=MF12B1aXGiAWRd39E4PQWPapQGuj5QzwoL1HV+/dOZL0aadn+rZE/rPk4tIGaSM1aAkyqOpHz/sq3OI6MJ8hvk5G200bDQACRDQkMLwGFmr8blFZK8boYtzjY7Gs0NfxdObS1j+/EgYnoLxJ5fMG5FPyZjSY+y379zzq8rBJ+UI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5302.eurprd08.prod.outlook.com (10.141.171.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Wed, 1 Apr 2020 12:47:34 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.014; Wed, 1 Apr 2020
 12:47:34 +0000
Subject: Re: Questionable aspects of QEMU Error's design
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <87o8sblgto.fsf@dusky.pond.sub.org>
 <20200401124422.GC393810@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200401154732635
Message-ID: <78f18b8e-720e-8826-e35f-3fbba8c97124@virtuozzo.com>
Date: Wed, 1 Apr 2020 15:47:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200401124422.GC393810@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR05CA0082.eurprd05.prod.outlook.com
 (2603:10a6:208:136::22) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.23) by
 AM0PR05CA0082.eurprd05.prod.outlook.com (2603:10a6:208:136::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend
 Transport; Wed, 1 Apr 2020 12:47:34 +0000
X-Tagtoolbar-Keys: D20200401154732635
X-Originating-IP: [185.215.60.23]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b56194fa-f56f-40c2-265b-08d7d63ad998
X-MS-TrafficTypeDiagnostic: AM7PR08MB5302:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5302B69698FCA077C3B185DFC1C90@AM7PR08MB5302.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03607C04F0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(39840400004)(366004)(136003)(346002)(376002)(316002)(86362001)(478600001)(66946007)(36756003)(31686004)(6486002)(31696002)(186003)(5660300002)(52116002)(26005)(16576012)(8676002)(66556008)(110136005)(4326008)(956004)(81166006)(2906002)(2616005)(16526019)(81156014)(8936002)(66476007);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kf2Pywhbva7dcR85xUnAf+ppwvt5XHO7aUzZWl9X/nGOLFLa9pnEUeuqXHICpoIF+wj55QGUum4hzkUkdJJ6gMHatXQxUXDm7v/PSprq6DZhkBBbrkXpgn3adlgkdtENWmSvyH7B8rD91dOVnYGL0F6PHweS11wKEW4JugYy/Nd/WRsPevKIK3TfmC/JRyNz3Je07tKXmHGXlNWF3sTX8+mfuZNd4s2Ew8KAsuoTu0bm+/W74+Tqqi8OEsNJzNb5isSCMUevEatJS/Yq1wO8pfdKPs6tsLE0ABSrHiVlJJk4SufiPtto7PM2ejOIukbzPFBE5oF/2JJHG8kOdu8NYC7sQfK6NLcfj+Un2pmJ3rJcHV4H32sCCgBoumJmnyRk7eY29CaedFNl3K2ZHHsR74psS1ic2dtMUI5vI1Hsqthp7yjeBvD8Ec/GhcBOCdIm
X-MS-Exchange-AntiSpam-MessageData: 4rljAmN+JWxgplNAeIyFOu4g87iyhjwomrV/k3mwsrtseETmQCYtxZkWHXEyLnZpwxfRToFuUqTTJpVCoac8ObDX7rm3BQRn3Z/py4kiSwj/qkZgMv/n35R+3Iac/hhHPicHe0gXdn+9/lWRXdY67w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b56194fa-f56f-40c2-265b-08d7d63ad998
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 12:47:34.4682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i/pqFA0Q0v47UB/vudwCdniReUkJRWl3aGkHDyZFmCrYFb8b5uLhfLDcwA2ziTMfsGFUABwe9oa24jEskWhPL+/pxCVOlp5v/+6WjNRv7v4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5302
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

01.04.2020 15:44, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Apr 01, 2020 at 11:02:11AM +0200, Markus Armbruster wrote:
>> QEMU's Error was patterned after GLib's GError.  Differences include:
>>
>> * &error_fatal, &error_abort for convenience
>=20
> I think this doesn't really need to exist, and is an artifact
> of the later point "return values" where we commonly make methds
> return void.  If we adopted a non-void return value, then these
> are no longer so compelling.
>=20
> Consider if we didn't have &error_fatal right now, then we would
> need to
>=20
>     Error *local_err =3D NULL;
>     qemu_boot_set(boot_once, &local_err)
>     if (*local_err)
>        abort();
>=20
> This is tedious, so we invented &error_abort to make our lives
> better
>=20
>     qemu_boot_set(boot_once, &error_abort)
>=20
>=20
> If we had a "bool" return value though, we would probably have just
> ended up doing:
>=20
>     assert(qemu_boot_set(boot_once, NULL));

But error_abort is better: it crashes where error fired and backtrace
in core file is backtrace of and error.

>=20
> or
>=20
>     if (!qemu_boot_set(boot_once, NULL))
>         abort()
>=20
> and would never have invented &error_fatal.
>=20
>> * Distinguishing different errors
>>
>>    Where Error has ErrorClass, GError has Gquark domain, gint code.  Use
>>    of ErrorClass other than ERROR_CLASS_GENERIC_ERROR is strongly
>>    discouraged.  When we need callers to distinguish errors, we return
>>    suitable error codes separately.
>=20
> The GQuark is just a static string, and in most cases this ends up being
> defined per-file, or sometimes per functional group. So essentially you
> can consider it to approximately a source file in most cases. The code
> is a constant of some arbitrary type that is generally considered to be
> scoped within the context of the GQuark domain.
>=20
>> * Return value conventions
>>
>>    Common: non-void functions return a distinct error value on failure
>>    when such a value can be defined.  Patterns:
>>
>>    - Functions returning non-null pointers on success return null pointe=
r
>>      on failure.
>>
>>    - Functions returning non-negative integers on success return a
>>      negative error code on failure.
>>
>>    Different: GLib discourages void functions, because these lead to
>>    awkward error checking code.  We have tons of them, and tons of
>>    awkward error checking code:
>>
>>      Error *err =3D NULL;
>>      frobnicate(arg, &err);
>>      if (err) {
>>          ... recover ...
>>          error_propagate(errp, err);
>>      }
>=20
> Yeah, I really dislike this verbose style...
>=20
>>
>>    instead of
>>
>>      if (!frobnicate(arg, errp))
>>          ... recover ...
>>      }
>=20
> ...so I've followed this style for any code I've written in QEMU
> where possible.
>=20
>>
>>    Can also lead to pointless creation of Error objects.
>>
>>    I consider this a design mistake.  Can we still fix it?  We have more
>>    than 2000 void functions taking an Error ** parameter...
>=20
> Even if we don't do full conversion, we can at least encourage the
> simpler style - previously reviewers have told me to rewrite code
> to use the more verbose style, which I resisted. So at the very
> least setting the expectations for preferred style is useful.
>=20
>>    Transforming code that receives and checks for errors with Coccinelle
>>    shouldn't be hard.  Transforming code that returns errors seems more
>>    difficult.  We need to transform explicit and implicit return to
>>    either return true or return false, depending on what we did to the
>>    @errp parameter on the way to the return.  Hmm.
>=20
> Even if we only converted methods which are currently void, that
> would be a notable benefit I think.
>=20
> It is a shame we didn't just use GError from the start, but I guess
> its probably too late to consider changing that now.
>=20
> Regards,
> Daniel
>=20


--=20
Best regards,
Vladimir

