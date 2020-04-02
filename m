Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06553C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 14:12:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C654B206F5
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 14:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mFb4loHw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C654B206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK0aN-0004tV-VB
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 10:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jK0Zi-0004EZ-OH
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:12:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jK0Zg-0006rL-H5
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:12:05 -0400
Received: from mail-vi1eur05on2107.outbound.protection.outlook.com
 ([40.107.21.107]:16000 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jK0Zf-0006pB-Rq
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:12:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3N1utpZaYl5Jiv2P6umgUvG5Zj4MaQDhlSpWDtkROVG24WWpU/cPIn0koReLD1mim6TXQC+AHtJ10U+DIk+MQW9krXnp3lbhsP9uH5vDunAtXNojeehnjN1snvqW4y4+n+RU/W3pTP15SZg9mG/k+Cu7BALagiux1XnHShnIdkt1xIJ66xlsyK8FTUUjFBpKGjSm3awnCEePMuduTC4jlxl/As3woffwwO44BXa0aulVw9pPEwLCJrEMcagVR6bG7aQbbfQ6OflW2J2SCbmg8PvYFBbBKVBcwgkanCLH7BkceIlzFORr2Kta0mIGXiEzdhRwfo6JkVohxntDuKzDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYMB2Wj3hij077rR5CN2H/DaUOJY7MrqjQSSkJphbnI=;
 b=fQ7nWdfaSKv/uvSIap1gCjipVMR1wncrG0sdbcY8oO+NBLw9k1Wi/dFZZ2ZfSemMui8KCS7CZbjuhDbbKm+KIrBhpDNHaYMa4s1VWQSEmLOtEp7nyUQ7GSlsopIRD4yTMCqkRRuVIAD3v3ZczO8nC8VNZ05fzkuMIWqWn7X+0XVqCzxuBDb53RSvwoubY0MrOmTh0uWtXJ0bFbqXj4qHMVPwgbBts0Nu5+5etR1WlUfpHoORpQmDU2CyaLej0HxZ3cnO6IWBkP3a+CtfCrB9TYjGWo3uitNJnH3eJUHhBUdYT2qGkFHDb2g+jbi+8qfxzUbhF/nieAmUmua5TJk5qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYMB2Wj3hij077rR5CN2H/DaUOJY7MrqjQSSkJphbnI=;
 b=mFb4loHwZJCbZfPsIEpbs4F8Qk6HlwU4GaNpS9AK8FgO1G6+okyksTLMJgJZvu/5fArjQLjhrkX17V680NH1s24aVYeu2eMAlUGTZc80YOvdDXoxaFffBlDk/AnQyEmPM5qfchcmR/W7Goje580syZ7HnmxM8mql9z527p4Fd+s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5447.eurprd08.prod.outlook.com (10.141.173.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Thu, 2 Apr 2020 14:11:58 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.016; Thu, 2 Apr 2020
 14:11:58 +0000
Subject: Re: Questionable aspects of QEMU Error's design
To: BALATON Zoltan <balaton@eik.bme.hu>
References: <87o8sblgto.fsf@dusky.pond.sub.org>
 <CAFEAcA_b1gZ-B4NaEdQS2zffdvobW=FUx4ysEgXVAz+=cZ+R3Q@mail.gmail.com>
 <a3ca8c60-dd83-ea7b-c268-0c94e441bb52@virtuozzo.com>
 <alpine.BSF.2.22.395.2004021132270.75834@zero.eik.bme.hu>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200402171155320
Message-ID: <53df0069-8a7a-9de8-29cb-21362d88bb4e@virtuozzo.com>
Date: Thu, 2 Apr 2020 17:11:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <alpine.BSF.2.22.395.2004021132270.75834@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR0202CA0016.eurprd02.prod.outlook.com
 (2603:10a6:208:1::29) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.23) by
 AM0PR0202CA0016.eurprd02.prod.outlook.com (2603:10a6:208:1::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Thu, 2 Apr 2020 14:11:56 +0000
X-Tagtoolbar-Keys: D20200402171155320
X-Originating-IP: [185.215.60.23]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11b0475e-d38b-4a7d-0311-08d7d70fcda3
X-MS-TrafficTypeDiagnostic: AM7PR08MB5447:
X-Microsoft-Antispam-PRVS: <AM7PR08MB54475E259B0491897CDBCD4CC1C60@AM7PR08MB5447.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 0361212EA8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(366004)(376002)(346002)(136003)(396003)(39840400004)(66946007)(8676002)(66556008)(31686004)(5660300002)(4326008)(2906002)(66476007)(8936002)(186003)(16526019)(54906003)(36756003)(86362001)(956004)(31696002)(26005)(2616005)(81156014)(316002)(6916009)(16576012)(52116002)(478600001)(6486002)(81166006);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rI889aQ1B7JTOEN6N3al1EDuesSAl0veO80BPme4QQ2AgbwKv1pRaJLwBYTBXV8Bwyn/yp1c3h/AkelvJ7MDQ24KTXrdL4MyHoIRU+/siCKc+795UkN19KXz/HVY2aSDpaEO5kyvY8E+0o8MbKjckKuKfZxIs+yWiohw1Br1WfJN5qJbsxfHc5pgW3ZJAl4hE/vUHeNtn7eMrNfSW25q+y6E267AavcxTJ7xx2bm59qm+zzl+z57e4VB5wYGnlpK1dvCL4FsRLVSE7acjg2SomPPpRgCz2B+CLmGLyFbjmFOqwm7oJ1EvIuNrCoWis0Nasj1FLajPpWyOzrvJ7QqQW2Ol2cHPbR6GN7ulAlUjtFBDpmAx79K0KX6FjfyTzv36sdF+fvcc0v7a8DKmORkvtwNilMJV7VJ3QLU2iVsGWiwLzUnE8ccC5XCt48YN3mF
X-MS-Exchange-AntiSpam-MessageData: KymAcrucosiN7xEW17Md4RBqn4GfiePSa33xFB1z6AdfBdq5/LE0Hr7VUClQeokSMCaMdWKJEMyzdM4NzeEJFgEkSb+tg/EHUhOhQ6JQeMnsqOlnXZjfoWXOQnJC+5AN4f09vAGmPh3SJ1Fq4lBTqQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b0475e-d38b-4a7d-0311-08d7d70fcda3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2020 14:11:58.4477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hsEiuswEoogb3g2RJJIu57odGMT2B4uJPcSGlcdM2EEtaoKC+XHG+zRBkEIwLpjQ67wXlGF7xnxDO9kgUitXdDrlssze8mw0BSAAZWa8qCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5447
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.21.107
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

02.04.2020 12:36, BALATON Zoltan wrote:
> On Thu, 2 Apr 2020, Vladimir Sementsov-Ogievskiy wrote:
>> 01.04.2020 23:15, Peter Maydell wrote:
>>> On Wed, 1 Apr 2020 at 10:03, Markus Armbruster <armbru@redhat.com> wrot=
e:
>>>>
>>>> QEMU's Error was patterned after GLib's GError.=C2=A0 Differences incl=
ude:
>>>
>>> =C2=A0From my POV the major problem with Error as we have it today
>>> is that it makes the simple process of writing code like
>>> device realize functions horrifically boilerplate heavy;
>>> for instance this is from hw/arm/armsse.c:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_property_set_li=
nk(cpuobj, OBJECT(&s->cpu_container[i]),
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "memory", &err);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 error_propagate(errp, err);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_property_set_li=
nk(cpuobj, OBJECT(s), "idau", &err);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 error_propagate(errp, err);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_property_set_bo=
ol(cpuobj, true, "realized", &err);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 error_propagate(errp, err);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> 16 lines of code just to set 2 properties on an object
>>> and realize it. It's a lot of boilerplate and as
>>> a result we frequently get it wrong or take shortcuts
>>> (eg forgetting the error-handling entirely, calling
>>> error_propagate just once for a whole sequence of
>>> calls, taking the lazy approach and using err_abort
>>> or err_fatal when we ought really to be propagating
>>> an error, etc). I haven't looked at 'auto propagation'
>>> yet, hopefully it will help?
>>
>> Yes, after it the code above will look like this:
>>
>> ... some_func(..., errp)
>> {
>> =C2=A0=C2=A0 ERRP_AUTO_PROPAGATE(); # magic macro at function start, and=
 no "Error *err" definition
>>
>> ...
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_property_set_lin=
k(cpuobj, OBJECT(&s->cpu_container[i]),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "memory", errp);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (*errp) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 return;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_property_set_lin=
k(cpuobj, OBJECT(s), "idau", errp);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (*errp) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 return;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_property_set_boo=
l(cpuobj, true, "realized", errp);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (*errp) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 return;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> ...
>> }
>>
>> - propagation is automatic, errp is used directly and may be safely dere=
ferenced.
>=20
> Not much better. Could it be something like:

Actually, much better, as it solves some real problems around error propaga=
tion.

>=20
>  =C2=A0=C2=A0=C2=A0 ERRP_RET(object_property_set_link(cpuobj, OBJECT(&s->=
cpu_container[i]),
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "memory", errp));
>  =C2=A0=C2=A0=C2=A0 ERRP_RET(object_property_set_link(cpuobj, OBJECT(s), =
"idau", errp));
>  =C2=A0=C2=A0=C2=A0 ERRP_RET(object_property_set_bool(cpuobj, true, "real=
ized", errp));
>=20

and turn all

ret =3D func(...);
if (ret < 0) {
     return ret;
}

into

FAIL_RET(func(...))

?

Not a problem to make such macro.. But I think it's a bad idea to turn all =
the code
into sequence of macro invocations. It's hard to debug and follow.


--=20
Best regards,
Vladimir

