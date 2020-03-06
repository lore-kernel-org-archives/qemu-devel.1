Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1373C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 13:01:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 935FC2084E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 13:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="d+jiOdmO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 935FC2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jACbr-0007SO-OC
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 08:01:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jACaQ-0006OP-9i
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:00:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jACaN-0000Ix-RL
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:00:18 -0500
Received: from mail-db8eur05on2109.outbound.protection.outlook.com
 ([40.107.20.109]:15777 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jACaH-0007kf-24; Fri, 06 Mar 2020 08:00:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIQB3wgvpGFFtpQVITPUnfo+LdaBmCJD6l/5cvN7Wzc2ayVL8ijTmCkpnzkyDGrCo4MUGZH62ri+PCylHEpuimQSyEgeB2M+ugFxnjdO56b5C/7ry2vVyk5R8EgtllwIIJghWka5Ewh5b3iZ2+n9JA8WOMmGe0sY9eRkWrOKusV2TkM7dljSA72hsbhxw8otVpbJrYUJTj0BYIvd62J91lTeb+aQ9T8ayHUPLSYGFDfVW9s3fC7/WcmaYFWpC7bqVKHsvf/pERSM+vcLAE+H5lfyqbyP+jt3bQsGbUJ+0F15pPHmThEdWOgOFZg4483pvgynKG1pYbCBZDLArwVZCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYOTHtdyZJV+CMittP/gilw+4vDoPxL2uF1MWj6sgfI=;
 b=hPRYGv2fQTY/ZS+5+mYcHd1ZqWmGfQMyNHnItivlVJ4MjqGtJoF4RjyH81Cu2r+XFg7ElU0W3YnTAxNhL5tSkwXM8nKomTeFJ/TIdjW6/5tWDY+4szvubPCGSUmUfgT9P7lkFfcB696M4H2Lg0hhO+mbsy0bMh94K3yEdwEcpzoIkqFI7nG1NeCoeQaP4YAqA6rMW7NrBqx4uYgGV+tBVtgqt35dtUxv0IBul6JGYAaZiYfJ87DgNIjYCbcpLW7QReyE6QdbgpDid8WcmA/VQmrD1nO67UEfuBIhpmrdgf+6wVQXQdaTUt9+4o1IKG3GcNenKu8p4VpbKYZ/LxXOZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYOTHtdyZJV+CMittP/gilw+4vDoPxL2uF1MWj6sgfI=;
 b=d+jiOdmODS+odAbsRExvQ/Q2oeqXQLpRbN6JUmm/Ktfo5vv6l6t2LlXGQTil1yMxPUPOERMjk4IFNsMdaV5iNYGorTpsvqHigVL9UcfP3Sf9nK2OhdKmFi4sQPMwRjb35DUyfznjFx9zuUyCgzSKgACF8sTCHPqAv7EK8wQWx1g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3224.eurprd08.prod.outlook.com (52.135.164.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.22; Fri, 6 Mar 2020 13:00:03 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2793.013; Fri, 6 Mar 2020
 13:00:03 +0000
Subject: Re: [PATCH v8 01/10] error: auto propagated local_err
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200306051536.27803-1-vsementsov@virtuozzo.com>
 <20200306051536.27803-2-vsementsov@virtuozzo.com>
 <41229b66-eedb-1c30-4849-a8076080117e@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200306160000157
Message-ID: <faaca3b3-da86-2589-599c-806b35877863@virtuozzo.com>
Date: Fri, 6 Mar 2020 16:00:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <41229b66-eedb-1c30-4849-a8076080117e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR05CA0275.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::27) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR05CA0275.eurprd05.prod.outlook.com (2603:10a6:3:fc::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16 via Frontend Transport; Fri, 6 Mar 2020 13:00:01 +0000
X-Tagtoolbar-Keys: D20200306160000157
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5ac340f-f01a-4ee2-2979-08d7c1ce490f
X-MS-TrafficTypeDiagnostic: AM6PR08MB3224:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3224EF1044A7CE1A991999C9C1E30@AM6PR08MB3224.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0334223192
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(39850400004)(136003)(366004)(396003)(199004)(189003)(7416002)(6486002)(30864003)(36756003)(16576012)(478600001)(2906002)(316002)(86362001)(5660300002)(26005)(186003)(54906003)(31696002)(4326008)(8676002)(16526019)(956004)(66946007)(2616005)(81166006)(31686004)(53546011)(8936002)(66556008)(52116002)(66476007)(81156014);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3224;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZxARpEjWVuJyMP0SlU6+3eAEUz+S26X/QZI4gZaNc4eBaFBUfq4PcP7v/2pSqCdCQ38o9dY7DTjY+NKqa4Ps1JI+FGd4vDo0cyILoGcMd60edkdgd8A6Gc0CinlX9GQjHdZx6bmXRqEK77rxKw3Cj2X6AcLFbkDH/sN9OZa+nkOFPF0B0qiJe7FH5oCSUxiuJEXyBU/dUM1ToFEL3Yp+IkftS2XEsiKj+jZJQktnSWvSeyMwD7LOa+P88a49PTcEwLpC8oNb8JOleFO24lY37Bps/yf+1LRuyTYGy/odFZ8ev8EFSWaKdDzgVSv2px8ecPdeKE5x0Aj93XiHFsgzaf2cEKz8T6Apr6Zagpn5qvFjx2YuYldqUX5eRKILfDY2qKOg+gpgsyPn535GAwh02gidnKL0kuiMufbeJab3Jh7eK7kfnX61A3wemxRyFdCb
X-MS-Exchange-AntiSpam-MessageData: R5aoPRSYdrObEamexYe06f0k/m0afCEpEZmEkytUhCX01Zf/fUnNxBM+jzYJ28iNoOXpbPUbpbzF0/V20TEWc7ZCjZwdMGmZFXB2q73c7S2P6f5D84Qf8O/GNPU6RdT/F3uJaD0p3MZ8DlFXzEfpXA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ac340f-f01a-4ee2-2979-08d7c1ce490f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2020 13:00:03.1547 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UPGtJyrspTHANjgED7CzmBIbMt23pRDW/ybhmtGEnMTjhva+OzDZ9zRlBDJ51/KrMLi0VWz/KJbZVbjbEETayCE2HkTlVN+0EmwHWUZTCK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3224
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.20.109
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
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 armbru@redhat.com, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

06.03.2020 15:37, Eric Blake wrote:
> On 3/5/20 11:15 PM, Vladimir Sementsov-Ogievskiy wrote:
>> Here is introduced ERRP_AUTO_PROPAGATE macro, to be used at start of
>> functions with an errp OUT parameter.
>=20
> As an aid to writing imperative-style commit messages, I like to prepend =
an implicit "Apply this patch to..." before the user's text, to see if thin=
gs still make sense.=C2=A0 By that construct, this paragraph might read bet=
ter as:
>=20
> Introduce a new ERRP_AUTO_PROPAGATE macro, ...
>=20
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
>> ---
>=20
> I have lots of grammar suggestions for the comments (and I know Markus is=
 generally okay doing wording tweaks, so it may still end up different than=
 my suggestions):
>=20
>> +++ b/include/qapi/error.h
>> @@ -15,6 +15,8 @@
>> =C2=A0 /*
>> =C2=A0=C2=A0 * Error reporting system loosely patterned after Glib's GEr=
ror.
>> =C2=A0=C2=A0 *
>> + * =3D Deal with Error object =3D
>> + *
>> =C2=A0=C2=A0 * Create an error:
>> =C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(&err, "situation norma=
l, all fouled up");
>> =C2=A0=C2=A0 *
>> @@ -47,28 +49,88 @@
>> =C2=A0=C2=A0 * reporting it (primarily useful in testsuites):
>> =C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 error_free_or_abort(&err);
>> =C2=A0=C2=A0 *
>> - * Pass an existing error to the caller:
>> - *=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate(errp, err);
>> - * where Error **errp is a parameter, by convention the last one.
>> + * =3D Deal with Error ** function parameter =3D
>> =C2=A0=C2=A0 *
>> - * Pass an existing error to the caller with the message modified:
>> - *=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate_prepend(errp, err);
>> + * Function may use error system to return errors. In this case functio=
n
>> + * defines Error **errp parameter, which should be the last one (except=
 for
>> + * functions which varidic argument list), which has the following API:
>=20
> A function may use the error system to return errors.=C2=A0 In this case,=
 the function defines an Error **errp parameter, by convention the last one=
 (with exceptions for functions using ... or va_list).
>=20
>> =C2=A0=C2=A0 *
>> - * Avoid
>> - *=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate(errp, err);
>> - *=C2=A0=C2=A0=C2=A0=C2=A0 error_prepend(errp, "Could not frobnicate '%=
s': ", name);
>> - * because this fails to prepend when @errp is &error_fatal.
>> + * Caller may pass as errp:
>=20
> The caller may then pass in the following errp values:
>=20
>> + * 1. &error_abort
>> + *=C2=A0=C2=A0=C2=A0 This means abort on any error
>=20
> Any error will result in abort()
>=20
>> + * 2. &error_fatal
>> + *=C2=A0=C2=A0=C2=A0 Exit with non-zero return code on error
>=20
> Any error will result in exit() with a non-zero status
>=20
>> + * 3. NULL
>> + *=C2=A0=C2=A0=C2=A0 Ignore errors
>=20
> Any error will be ignored
>=20
>> + * 4. Another value
>=20
> 4. The address of a NULL-initialized Error *err
>=20
>> + *=C2=A0=C2=A0=C2=A0 On error allocate error object and set errp
>=20
> Any error will populate errp with an error object
>=20
>> =C2=A0=C2=A0 *
>> - * Create a new error and pass it to the caller:
>> - *=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "situation normal, all foul=
ed up");
>> + * Error API functions with Error ** (like error_setg) argument support=
s these
>> + * rules, so user functions just need to use them appropriately (read b=
elow).
>=20
> The following rules then implement the correct semantics desired by the c=
aller.
>=20
>> =C2=A0=C2=A0 *
>> - * Call a function and receive an error from it:
>> + * Simple pass error to the caller:
>=20
> Create a new error to pass to the caller:
>=20
>> + *=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Some error");
>=20
> You lost the fun wording in Markus' earlier example ("situation normal, a=
ll fouled up").
>=20
>> + *
>> + * Subcall of another errp-based function, passing the error to the cal=
ler
>> + *=C2=A0=C2=A0=C2=A0=C2=A0 f(..., errp);
>=20
> Calling another errp-based function:
>=20
>> + *
>> + * =3D=3D Checking success of subcall =3D=3D
>> + *
>> + * If function returns error code in addition to errp (which is recomme=
nded),
>=20
> If a function returns a value indicating an error in addition to setting =
errp (which is recommended), then
>=20
>> + * you don't need any additional code, just do:
>> + *=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D f(..., errp);
>> + *=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ... handle error ...
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> + *=C2=A0=C2=A0=C2=A0=C2=A0 }
>> + *
>> + * If function returns nothing (which is not recommended API) and the o=
nly way
>> + * to check success is checking errp, we must care about cases [1-3] ab=
ove. We
>> + * need to use macro ERRP_AUTO_PROPAGATE (see below for details) like t=
his:
>=20
> If a function returns nothing (not recommended for new code), the only wa=
y to check success is by consulting errp; doing this safely requires the us=
e of the ERRP_AUTO_PROPAGATE macro, like this:
>=20
>=20
>> + *
>> + *=C2=A0=C2=A0=C2=A0=C2=A0 int our_func(..., Error **errp) {
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ERRP_AUTO_PROPAGATE(=
);
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 subcall(..., errp);
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (*errp) {
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ...
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -ERRNO;
>=20
> do we want ERRNO capitalized here?

I wrote it capitalized to not conflict with errno variable, to make it obvi=
ous that this is just a pseudo-code. But yes, it looks weird anyway.

We can write -errno here, or just -EINVAL (I hope, nobady will thing, that =
EINVAL should always be used :)

>=20
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>> + *=C2=A0=C2=A0=C2=A0=C2=A0 }
>> + *
>> + * ERRP_AUTO_PROPAGATE cares about Error ** API, wraps original errp if=
 needed,
>> + * so that it can be safely used (including dereferencing), and auto-pr=
opagates
>> + * error to original errp on function end.
>=20
> ERRP_AUTO_PROPAGATE takes care of wrapping the original errp as needed, s=
o that the rest of the function can directly use errp (including dereferenc=
ing), where any errors will then be propagated on to the original errp when=
 leaving the function.
>=20
>> + *
>> + * In some cases, we need to check result of subcall, but do not want t=
o
>> + * propagate the Error object to our caller. In such cases we don't nee=
d
>> + * ERRP_AUTO_PROPAGATE, but just a local Error object:
>> + *
>> + * Receive an error and not pass it:
>> =C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 Error *err =3D NULL;
>> - *=C2=A0=C2=A0=C2=A0=C2=A0 foo(arg, &err);
>> + *=C2=A0=C2=A0=C2=A0=C2=A0 subcall(arg, &err);
>> =C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>> =C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 handle th=
e error...
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_free(err);
>> =C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0 *
>> + * Note, that before ERRP_AUTO_PROPAGATE introduction the pattern above=
 (with
>> + * error_propagate() instead of error_free()) was used to check and pas=
s error
>> + * to the caller. Now this is DEPRECATED* (see below).
>=20
> Hmm - if we bulk-convert the entire tree, then there won't be any depreca=
ted uses to be worth documenting.

Yes, I think we'll drop it after everything is converted.

>=C2=A0 But if we do keep this paragraph:
>=20
> Note that older code that did not use ERRP_AUTO_PROPAGATE would instead n=
eed a local Err variable and the use of error_propagate() to properly handl=
e all possible caller values of errp.
>=20
>> + *
>> + * Note also, that if you want to use error_append_hint/error_prepend o=
r their
>> + * variants, you must use ERRP_AUTO_PROPAGATE too. Otherwise, in case o=
f
>> + * error_fatal, you'll miss the chance to insert your additional inform=
ation
>> + * into Error object.
>=20
> Note that any function that wants to modify an error object, such as by c=
alling error_append_hint or error_prepend, must use ERRP_AUTO_PROPAGATE, in=
 order for a caller's use of &error_fatal to see the additional information=
.
>=20
>> + *
>> + * In rare cases, we need to pass existing Error object to the caller b=
y hand:
>> + *=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate(errp, err);
>> + *
>> + * Pass an existing error to the caller with the message modified:
>> + *=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate_prepend(errp, err);
>> + *
>> + *
>> =C2=A0=C2=A0 * Call a function ignoring errors:
>> =C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 foo(arg, NULL);
>> =C2=A0=C2=A0 *
>> @@ -78,26 +140,6 @@
>> =C2=A0=C2=A0 * Call a function treating errors as fatal:
>> =C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 foo(arg, &error_fatal);
>> =C2=A0=C2=A0 *
>> - * Receive an error and pass it on to the caller:
>> - *=C2=A0=C2=A0=C2=A0=C2=A0 Error *err =3D NULL;
>> - *=C2=A0=C2=A0=C2=A0=C2=A0 foo(arg, &err);
>> - *=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>> - *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 handle the error...
>> - *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate(errp=
, err);
>> - *=C2=A0=C2=A0=C2=A0=C2=A0 }
>> - * where Error **errp is a parameter, by convention the last one.
>> - *
>> - * Do *not* "optimize" this to
>> - *=C2=A0=C2=A0=C2=A0=C2=A0 foo(arg, errp);
>> - *=C2=A0=C2=A0=C2=A0=C2=A0 if (*errp) { // WRONG!
>> - *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 handle the error...
>> - *=C2=A0=C2=A0=C2=A0=C2=A0 }
>> - * because errp may be NULL!
>> - *
>> - * But when all you do with the error is pass it on, please use
>> - *=C2=A0=C2=A0=C2=A0=C2=A0 foo(arg, errp);
>> - * for readability.
>> - *
>> =C2=A0=C2=A0 * Receive and accumulate multiple errors (first one wins):
>> =C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 Error *err =3D NULL, *local_err =
=3D NULL;
>> =C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 foo(arg, &err);
>> @@ -114,6 +156,61 @@
>> =C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 handle th=
e error...
>> =C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0 * because this may pass a non-null err to bar().
>> + *
>> + * DEPRECATED*
>> + *
>=20
> Again, I'm not sure we need this section in the codebase if we do a bulk =
conversion.=C2=A0 But moving it to the commit message is still useful.

Conversion can't be atomic anyway, there would be several series. But I'm n=
ot against dropping the paragraph, so, it's up to Markus.

>=20
>> + * The following pattern of receiving checking and passing the caller o=
f the
>> + * error by hand is deprecated now:
>=20
> The following pattern of receiving, checking, and then forwarding an erro=
r to the caller by hand is now deprecated:
>=20
>> + *
>> + *=C2=A0=C2=A0=C2=A0=C2=A0 Error *err =3D NULL;
>> + *=C2=A0=C2=A0=C2=A0=C2=A0 foo(arg, &err);
>> + *=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 handle the error...
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate(errp=
, err);
>> + *=C2=A0=C2=A0=C2=A0=C2=A0 }
>> + *
>> + * Instead, use ERRP_AUTO_PROPAGATE macro (defined below).
>=20
> Drop "(defined below)".
>=20
>> + *
>> + * The old pattern is deprecated because of two things:
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
>> + *=C2=A0=C2=A0=C2=A0=C2=A0 void fn(..., Error **errp) {
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error *err =3D NULL;
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 foo(arg, &err);
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 handle the error...
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 error_propagate(errp, err);
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return;
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>> + *=C2=A0=C2=A0=C2=A0=C2=A0 }
>> + *
>> + * updated code
>> + *
>> + *=C2=A0=C2=A0=C2=A0=C2=A0 void fn(..., Error **errp) {
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ERRP_AUTO_PROPAGATE(=
);
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 foo(arg, errp);
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (*errp) {
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 handle the error...
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return;
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>> + *=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> Again, I'm thinking the above example is more useful in the commit messag=
e instead of permanently in the .h file.
>=20
>> =C2=A0=C2=A0 */
>> =C2=A0 #ifndef ERROR_H
>> @@ -322,6 +419,46 @@ void error_set_internal(Error **errp,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ErrorClass err_class, const char *fmt, ...)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GCC_FMT_ATTR(6, 7);
>> +typedef struct ErrorPropagator {
>> +=C2=A0=C2=A0=C2=A0 Error *local_err;
>> +=C2=A0=C2=A0=C2=A0 Error **errp;
>> +} ErrorPropagator;
>> +
>> +static inline void error_propagator_cleanup(ErrorPropagator *prop)
>> +{
>> +=C2=A0=C2=A0=C2=A0 error_propagate(prop->errp, prop->local_err);
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
>=20
> This macro exists to assist with proper error handling in a function whic=
h uses an Error **errp parameter.=C2=A0 It must be used as the first line o=
f a function which modifies an error (with error_prepend, error_append_hint=
, or similar) or which wants to dereference *errp.=C2=A0 It is still safe (=
but useless) to use in other functions.
>=20
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
>> + */
>> +#define ERRP_AUTO_PROPAGATE() \
>> +=C2=A0=C2=A0=C2=A0 g_auto(ErrorPropagator) _auto_errp_prop =3D {.errp =
=3D errp}; \
>> +=C2=A0=C2=A0=C2=A0 do { \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!errp || errp =3D=3D &er=
ror_fatal) { \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errp=
 =3D &_auto_errp_prop.local_err; \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } \
>> +=C2=A0=C2=A0=C2=A0 } while (0)
>> +
>> =C2=A0 /*
>> =C2=A0=C2=A0 * Special error destination to abort on error.
>> =C2=A0=C2=A0 * See error_setg() and error_propagate() for details.
>>
>=20
> The macro itself looks correct. I'll leave it up to Markus how to handle =
the comment text, but you can add:
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20

Thanks for reviewing and wording suggestions, all looks good, as always.

--=20
Best regards,
Vladimir

