Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6AFC35640
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 09:43:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C94C2207FD
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 09:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="knSBC7eU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94C2207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j54qA-000321-2U
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 04:43:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j54pB-0002WT-PX
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 04:42:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j54pA-0001OZ-4i
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 04:42:21 -0500
Received: from mail-vi1eur05on2139.outbound.protection.outlook.com
 ([40.107.21.139]:28641 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j54p5-0001FR-LN; Fri, 21 Feb 2020 04:42:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vy8V1kTAtHzczIRvLEqOLHjId+WLYiFBc3WM3kQxW8c9JrM/0PmJjSGoLu15sugthx4k+2hu1ahtCpIV4NK7GzdWRgGsxxSidQzwZPqJsVSMI7BliHmW30utXs1bq24GaCHsW7oHR1oCiO+dONKRG1xAZwu9rx0s28pnFI4cgkRvFIvbcvkJHyZabM3VrncNskCepjzMn+aR2M9hRnjBwHn/0hFbqIrNhij9ypsR83r4ww24sFtiBi1G4+pKdNAHqbuPaMd5NnUsL8Jw82gS5C8HYgOSqEUtj7XDUAFMNWCWooAuzqbqCI13kKKaodtstq/A9UY+kCZ/3WntRIZE5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANrgGt89xnsTdD129Tx6yS+FCPRYqGtcR2MAwyoM29M=;
 b=WDgOQqULarZahFgFCOmYWf6Xnd8in6w4wRotkL2KDCrLSi20OmAI0dx+iTReRcxlJJq+VGn9FsJxKcsDl/ds/Y7/HrjW5twLvA/G52gvc/d4SIvdcJ52UVvYAoQB0cTU/eG8aAsuCdy85ONzUFiu7fj861RuW3W3jKGON05crjyb5REyGLHtEwECG7wSXMch/Njo0kjHYPfYbWNezONtZ9S23zth5a97N7wIDgw8wI/bZL1VtLECM4fJbKt4cKRp6TcS1blJETTcAes96gZuCE1dPqDoyuOpq9j7zoYwO1+fX/a1exPMKa6vdlMBpMSLSsFTK3sJ1bMsAHIitQGwag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANrgGt89xnsTdD129Tx6yS+FCPRYqGtcR2MAwyoM29M=;
 b=knSBC7eUCCkGZ+FrwPBNQAJ+eKWPNHsIYJne6pgiFMF6VllkG5BBWvCtoRYPqTXRxY1WJwBbcOlYizRj2Bzhic28T0qyX8mYkrpFE16KzogFGaFr4TmmP65SyOm1xCtSzOatp7P8WGKT9DV86LzdP9FzH8U9sHATG02tTq71MHw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4294.eurprd08.prod.outlook.com (20.179.7.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18; Fri, 21 Feb 2020 09:42:09 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2750.016; Fri, 21 Feb 2020
 09:42:09 +0000
Subject: Re: [PATCH v7 02/11] error: auto propagated local_err
To: Markus Armbruster <armbru@redhat.com>
References: <20200131130118.1716-1-vsementsov@virtuozzo.com>
 <20200131130118.1716-3-vsementsov@virtuozzo.com>
 <87mu9c70x1.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200221124206439
Message-ID: <278458e5-c62c-8eaa-672f-cc70bbc15304@virtuozzo.com>
Date: Fri, 21 Feb 2020 12:42:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <87mu9c70x1.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0102CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::18) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0102CA0005.eurprd01.prod.exchangelabs.com (2603:10a6:7:14::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend
 Transport; Fri, 21 Feb 2020 09:42:08 +0000
X-Tagtoolbar-Keys: D20200221124206439
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f2feebc-7047-4aa6-e570-08d7b6b25225
X-MS-TrafficTypeDiagnostic: AM6PR08MB4294:
X-Microsoft-Antispam-PRVS: <AM6PR08MB42943483B302F6D533E7D675C1120@AM6PR08MB4294.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(39840400004)(366004)(346002)(396003)(376002)(189003)(199004)(316002)(31696002)(86362001)(16576012)(5660300002)(54906003)(4326008)(478600001)(66476007)(66946007)(36756003)(956004)(66556008)(2906002)(2616005)(8676002)(186003)(81156014)(81166006)(7416002)(16526019)(8936002)(52116002)(26005)(31686004)(6916009)(6486002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4294;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I7wbKiPONEjvWV/f9haDIzdFiYX64DysVot72b0litOjL4ACwxQIrg9vQaGsEBR4G9BfRsiQaU3IUv9bEXYGNS7FlIMIV4wYeuMSUwaeC7pVa/sax6Nz1JJV1mKY0/5azqu2XIz9fRzuGREtHGsHflEhozC24FWQT2TLiveQO30VOuRx9vdOWTamlfzFbAdS3N5VbyQj7I40QWvlKEZfzvU8hk237NWAeXWGw2SbhcGoIRaOjOwpBwJgFRjDTR+hqZ3kUxTAku6ONBHFa4F0jUYMvGYfLMa3TXv2Oar0gA3xNgzdNuMvYiOG2ko8LzgoBMUv3z4AXYFkaturIWjvPxBrO9FIK2IpmtgHj3riSsh62rdyrnA0CKrQFzLlAvkFIYiDo3tOyRjwT/jF7kJOIbZCLJvDp89pHW0+FEaRffkgVK6KURIolE1Ai2J/9LyO
X-MS-Exchange-AntiSpam-MessageData: 2OOje9fwgeLYxEnGJW/ZNUV0aisHJaLNhwzc1nHAJKFBUNBqFtuMLYRpCW1bnc+XnLsRaxfJmYpeJHKoN6uXON15ShQID/Zn0YKV7htrQnkrZsNnid0M2f5P8pyqX+r0oEAxeYCKckAppepDZjQLNQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2feebc-7047-4aa6-e570-08d7b6b25225
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 09:42:09.6262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eyUbEaOAWiCLXAf2K0VH7PSiTFLE0HsonBelcQgzC9DSlEfHKPM0pgiW7M7xNMOow6Iz95Ru67ybIxHB+smSvddBcZyW8kpyCWoP/DOQOL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4294
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.21.139
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
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

21.02.2020 12:19, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>=20
>> Here is introduced ERRP_AUTO_PROPAGATE macro, to be used at start of
>> functions with an errp OUT parameter.
>>
>> It has three goals:
>>
>> 1. Fix issue with error_fatal and error_prepend/error_append_hint: user
>> can't see this additional information, because exit() happens in
>> error_setg earlier than information is added. [Reported by Greg Kurz]
>>
>> 2. Fix issue with error_abort and error_propagate: when we wrap
>> error_abort by local_err+error_propagate, the resulting coredump will
>> refer to error_propagate and not to the place where error happened.
>> (the macro itself doesn't fix the issue, but it allows us to [3.] drop
>> the local_err+error_propagate pattern, which will definitely fix the
>> issue) [Reported by Kevin Wolf]
>>
>> 3. Drop local_err+error_propagate pattern, which is used to workaround
>> void functions with errp parameter, when caller wants to know resulting
>> status. (Note: actually these functions could be merely updated to
>> return int error code).
>>
>> To achieve these goals, later patches will add invocations
>> of this macro at the start of functions with either use
>> error_prepend/error_append_hint (solving 1) or which use
>> local_err+error_propagate to check errors, switching those
>> functions to use *errp instead (solving 2 and 3).
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Reviewed-by: Greg Kurz <groug@kaod.org>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> ---
>>
>> CC: Eric Blake <eblake@redhat.com>
>> CC: Kevin Wolf <kwolf@redhat.com>
>> CC: Max Reitz <mreitz@redhat.com>
>> CC: Greg Kurz <groug@kaod.org>
>> CC: Stefano Stabellini <sstabellini@kernel.org>
>> CC: Anthony Perard <anthony.perard@citrix.com>
>> CC: Paul Durrant <paul@xen.org>
>> CC: Stefan Hajnoczi <stefanha@redhat.com>
>> CC: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
>> CC: Laszlo Ersek <lersek@redhat.com>
>> CC: Gerd Hoffmann <kraxel@redhat.com>
>> CC: Stefan Berger <stefanb@linux.ibm.com>
>> CC: Markus Armbruster <armbru@redhat.com>
>> CC: Michael Roth <mdroth@linux.vnet.ibm.com>
>> CC: qemu-block@nongnu.org
>> CC: xen-devel@lists.xenproject.org
>>
>>   include/qapi/error.h | 83 +++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 82 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/qapi/error.h b/include/qapi/error.h
>> index d34987148d..b9452d4806 100644
>> --- a/include/qapi/error.h
>> +++ b/include/qapi/error.h
>> @@ -78,7 +78,7 @@
>>    * Call a function treating errors as fatal:
>>    *     foo(arg, &error_fatal);
>>    *
>> - * Receive an error and pass it on to the caller:
>> + * Receive an error and pass it on to the caller (DEPRECATED*):
>>    *     Error *err =3D NULL;
>>    *     foo(arg, &err);
>>    *     if (err) {
>> @@ -98,6 +98,50 @@
>>    *     foo(arg, errp);
>>    * for readability.
>>    *
>> + * DEPRECATED* This pattern is deprecated now, the use ERRP_AUTO_PROPAG=
ATE macro
>> + * instead (defined below).
>> + * It's deprecated because of two things:
>> + *
>> + * 1. Issue with error_abort and error_propagate: when we wrap error_ab=
ort by
>> + * local_err+error_propagate, the resulting coredump will refer to
>> + * error_propagate and not to the place where error happened.
>> + *
>> + * 2. A lot of extra code of the same pattern
>> + *
>> + * How to update old code to use ERRP_AUTO_PROPAGATE?
>> + *
>> + * All you need is to add ERRP_AUTO_PROPAGATE() invocation at function =
start,
>> + * than you may safely dereference errp to check errors and do not need=
 any
>> + * additional local Error variables or calls to error_propagate().
>> + *
>> + * Example:
>> + *
>> + * old code
>> + *
>> + *     void fn(..., Error **errp) {
>> + *         Error *err =3D NULL;
>> + *         foo(arg, &err);
>> + *         if (err) {
>> + *             handle the error...
>> + *             error_propagate(errp, err);
>> + *             return;
>> + *         }
>> + *         ...
>> + *     }
>> + *
>> + * updated code
>> + *
>> + *     void fn(..., Error **errp) {
>> + *         ERRP_AUTO_PROPAGATE();
>> + *         foo(arg, errp);
>> + *         if (*errp) {
>> + *             handle the error...
>> + *             return;
>> + *         }
>> + *         ...
>> + *     }
>> + *
>> + *
>>    * Receive and accumulate multiple errors (first one wins):
>>    *     Error *err =3D NULL, *local_err =3D NULL;
>>    *     foo(arg, &err);
>=20
> Let's explain what should be done *first*, and only then talk about the
> deprecated pattern and how to convert it to current usage.
>=20
>> @@ -348,6 +392,43 @@ void error_set_internal(Error **errp,
>>                           ErrorClass err_class, const char *fmt, ...)
>>       GCC_FMT_ATTR(6, 7);
>>  =20
>> +typedef struct ErrorPropagator {
>> +    Error *local_err;
>> +    Error **errp;
>> +} ErrorPropagator;
>> +
>> +static inline void error_propagator_cleanup(ErrorPropagator *prop)
>> +{
>> +    error_propagate(prop->errp, prop->local_err);
>> +}
>> +
>> +G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(ErrorPropagator, error_propagator_clea=
nup);
>> +
>> +/*
>> + * ERRP_AUTO_PROPAGATE
>> + *
>> + * This macro is created to be the first line of a function which use
>> + * Error **errp parameter to report error. It's needed only in cases wh=
ere we
>> + * want to use error_prepend, error_append_hint or dereference *errp. I=
t's
>> + * still safe (but useless) in other cases.
>> + *
>> + * If errp is NULL or points to error_fatal, it is rewritten to point t=
o a
>> + * local Error object, which will be automatically propagated to the or=
iginal
>> + * errp on function exit (see error_propagator_cleanup).
>> + *
>> + * After invocation of this macro it is always safe to dereference errp
>> + * (as it's not NULL anymore) and to add information by error_prepend o=
r
>> + * error_append_hint (as, if it was error_fatal, we swapped it with a
>> + * local_error to be propagated on cleanup).
>> + *
>> + * Note: we don't wrap the error_abort case, as we want resulting cored=
ump
>> + * to point to the place where the error happened, not to error_propaga=
te.
>=20
> Tradeoff: we gain more useful backtraces, we lose message improvements
> from error_prepend(), error_append_hint() and such, if any.  Makes
> sense.
>=20
>> + */
>=20
> The comment's contents looks okay to me.  I'll want to tweak formatting
> to better blend in with the rest of this file, but let's not worry about
> that now.
>=20
>> +#define ERRP_AUTO_PROPAGATE()                                  \
>> +    g_auto(ErrorPropagator) _auto_errp_prop =3D {.errp =3D errp};  \
>> +    errp =3D ((errp =3D=3D NULL || *errp =3D=3D error_fatal)           =
  \
>> +            ? &_auto_errp_prop.local_err : errp)
>> +
>>   /*
>>    * Special error destination to abort on error.
>>    * See error_setg() and error_propagate() for details.
>=20
> *errp =3D=3D error_fatal tests *errp =3D=3D NULL, which is not what you w=
ant.
> You need to test errp =3D=3D &error_fatal, just like error_handle_fatal()=
.

Oops, great bug) And nobody noticed before) Of course, you are right.

>=20
> Superfluous parenthesis around the first operand of ?:.
>=20
> Wouldn't
>=20
>     #define ERRP_AUTO_PROPAGATE()                                  \
>         g_auto(ErrorPropagator) _auto_errp_prop =3D {.errp =3D errp};  \
>         if (!errp || errp =3D=3D &error_fatal) {                       \
>             errp =3D &_auto_errp_prop.local_err;                     \
>         }
>=20
> be clearer?
>=20

Hmm, notation with "if" will allow omitting ';' after macro invocation, whi=
ch seems not good..
And if I'm not wrong we've already discussed it somewhere in previous versi=
ons.

Still, no objections for s/errp =3D=3D NULL/!errp/ and we need s/*errp =3D=
=3D error_fatal/errp =3D=3D &error_fatal/ for sure.

--=20
Best regards,
Vladimir

