Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BDCC35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 10:16:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB21920700
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 10:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VxS7ZCvR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB21920700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFbgj-0002n1-TI
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 06:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53537)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rkagan@virtuozzo.com>) id 1iFbfl-0002EN-85
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 06:15:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rkagan@virtuozzo.com>) id 1iFbfj-0005nn-6s
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 06:15:52 -0400
Received: from mail-bgr052101135032.outbound.protection.outlook.com
 ([52.101.135.32]:20936 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
 id 1iFbfi-0005mz-I5; Wed, 02 Oct 2019 06:15:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9nrttVFb5i0InhnY+hEpTLMDA4Q0xv6IfZN6QKUldyvaEXKeNilXyK18g8hK/NuIyX9fDaefTEiFTG13M64qvKLbOi25/8N1aptHka3PoIik5wbsHqbRXTw1MOq6eWy/4djPi8sWDsyvebQqAxLWa/WNbReICItsHt7vNoMbwxoiZnF59XQ+p3jAag+1weppdYX3DE89sxorTGVNRg2D+VX/pi1r4YX0gvRmQO3nE0ZVnWX2zbRxwnpMnc/ItIbd6jcgPDQVlveB0pxxbE92xsdRd1llPkraIP2Db0ZZXYx4AQjQlJHNtmvDmbQq11c2T8DcVdjPXkj4Ov+hVhMEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQ2yvun1xhyL9SM51/wIh4yatjeXyuIGXn7tzbeeWq8=;
 b=LDfj6dlIvW5I4gzAdIE/zLuo+q1+HgjjFSeZFU4bJWXP5affI/KkAX8+Jd58vWSw+266eqXZ7cpTJ5f5c8cblJC7Qwe8TlDCg816dYwyfzLMDK4HCBu5txVMmaM3J0e++N6HSmSocrrGQ1NS6gIyBDogXXRs8mR46ytJYUsp82IlsOJWFRAQhC+vw4b2vLzLMGSk07b6nZCKkA1Pvvicpesr12PMQ6r4KxEI37PntCVtxkvHVG6djjQq7E10ZrjCy8z+tsKhOEKQsKPB/TVa5EDITDJr6kcOcGNJ/lUlhB+26P/DxWlnE0zRonj1Hnhspvi85nyV2Ym68t+6ZelJmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQ2yvun1xhyL9SM51/wIh4yatjeXyuIGXn7tzbeeWq8=;
 b=VxS7ZCvR2bi17KW00MF5JAxxz/uYxPjraTGxdkNoPHw9nEZmMlPU7brn/KamsGYXdTBxS7GZiyGViIZa/RQN8s5waws7K4LaC/paZFYxUCL2CGi2rC7at0hwQoG02kxo9XRqzYEljLUijPKnNyDiwD7cb0VGBtzf5Az3zccU/lQ=
Received: from AM0PR08MB5537.eurprd08.prod.outlook.com (20.179.36.87) by
 AM0PR08MB3844.eurprd08.prod.outlook.com (20.178.22.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Wed, 2 Oct 2019 10:15:40 +0000
Received: from AM0PR08MB5537.eurprd08.prod.outlook.com
 ([fe80::a8ea:5223:db78:dd3]) by AM0PR08MB5537.eurprd08.prod.outlook.com
 ([fe80::a8ea:5223:db78:dd3%7]) with mapi id 15.20.2305.022; Wed, 2 Oct 2019
 10:15:40 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v4 04/31] error: auto propagated local_err
Thread-Topic: [PATCH v4 04/31] error: auto propagated local_err
Thread-Index: AQHVeHShdnUXp1vh8EWixe39zoJi5KdHI7+A
Date: Wed, 2 Oct 2019 10:15:40 +0000
Message-ID: <20191002101535.GA30896@rkaganb.sw.ru>
References: <20191001155319.8066-1-vsementsov@virtuozzo.com>
 <20191001155319.8066-5-vsementsov@virtuozzo.com>
In-Reply-To: <20191001155319.8066-5-vsementsov@virtuozzo.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.12.1 (2019-06-15)
mail-followup-to: Roman Kagan <rkagan@virtuozzo.com>,	Vladimir
 Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,	qemu-devel@nongnu.org,
 fam@euphon.net, pburton@wavecomp.com,	peter.maydell@linaro.org,
 codyprime@gmail.com, jasowang@redhat.com,	mark.cave-ayland@ilande.co.uk,
 mdroth@linux.vnet.ibm.com,	kraxel@redhat.com, sundeep.lkml@gmail.com,
 qemu-block@nongnu.org,	quintela@redhat.com, arikalo@wavecomp.com,
 mst@redhat.com,	armbru@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com,	joel@jms.id.au, marcandre.lureau@redhat.com,
 rth@twiddle.net,	farman@linux.ibm.com, ehabkost@redhat.com, sw@weilnetz.de,
 groug@kaod.org, yuval.shaia@oracle.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, integration@gluster.org, clg@kaod.org,
 stefanha@redhat.com, david@redhat.com, jsnow@redhat.com,
 david@gibson.dropbear.id.au, kwolf@redhat.com, berrange@redhat.com,
 andrew@aj.id.au, cohuck@redhat.com, qemu-s390x@nongnu.org, mreitz@redhat.com, 
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,	pbonzini@redhat.com
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR0202CA0004.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::14) To AM0PR08MB5537.eurprd08.prod.outlook.com
 (2603:10a6:208:148::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b503372-c645-4768-d303-08d7472179ee
x-ms-traffictypediagnostic: AM0PR08MB3844:|AM0PR08MB3844:|AM0PR08MB3844:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB3844534E1B8765592D253B9BC99C0@AM0PR08MB3844.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:SPM;
 SFS:(10019020)(136003)(366004)(346002)(396003)(376002)(39840400004)(199004)(189003)(486006)(86362001)(81156014)(229853002)(8676002)(81166006)(4326008)(6862004)(25786009)(99286004)(8936002)(1076003)(71190400001)(6486002)(66476007)(66556008)(64756008)(66446008)(71200400001)(6436002)(476003)(6246003)(58126008)(54906003)(102836004)(5660300002)(186003)(478600001)(11346002)(52116002)(7736002)(6116002)(3846002)(316002)(2906002)(305945005)(76176011)(446003)(14454004)(7416002)(7406005)(256004)(6512007)(9686003)(33656002)(66946007)(26005)(386003)(6506007)(66066001)(36756003)(6636002)(30126002);
 DIR:OUT; SFP:1501; SCL:5; SRVR:AM0PR08MB3844;
 H:AM0PR08MB5537.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T1NolrBZD3NJQiXmFyutJUNL0JjrAdwNqamp7ClnOzzXkXvxzDx8ihfGj+UNx0ovJKBy4lhpO+FakMTGGRXZ11bTC0BJaukLBEvmxpoqIAmJGCrHxML9rNsTkzBpMe7oMmX4QPi+4/mDsrxQXY75nJh4PtNR2Sd+oYy5BrBI4Q2Uq8bkHZF0kNZOxN1hBOnBHy9uRaVtXKanzN/h3J+s9HXpZ/BkoPbsE5gY15EpW01cJinJSzaP0tW9I3lv7z0H3Ctaxcr8xPolbdOw3p2UfOZ7/6FCgc80PPVhjoA+r8c0OdmmhnLhYD+Jfqbxy0rQMii+bcqgaM6tFOpwjybyFT6CIJX8EP6pIE1A6JqqIz69wSU5XB1PA2YaTMyzpYGuiBBVMKTEGLOMSPcvJUjzaPuE1CueEe6j6zHY0EKlSP4FVvWRjPOWg/PKM33lQgUik3Jc/VyCVI96PqCpKXD7SR34IecmUadAcp4jQJrtpaPkMrCYaEtKAgX78dsjXXOz
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E2DD77A9F7BE654D90D9BB55DB58ABFF@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b503372-c645-4768-d303-08d7472179ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 10:15:40.4330 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zipra8lJQEMAZq5oVeCTEods+Pmk5IrQGqp2MkOavuv6XtFMGR6JfdpLwYoaUJQL2nZ+8kmRgKxzn235So4+Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3844
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 52.101.135.32
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
Cc: "fam@euphon.net" <fam@euphon.net>,
 "pburton@wavecomp.com" <pburton@wavecomp.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "codyprime@gmail.com" <codyprime@gmail.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "arikalo@wavecomp.com" <arikalo@wavecomp.com>,
 "mst@redhat.com" <mst@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
 "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
 "joel@jms.id.au" <joel@jms.id.au>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "farman@linux.ibm.com" <farman@linux.ibm.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "sw@weilnetz.de" <sw@weilnetz.de>,
 "groug@kaod.org" <groug@kaod.org>,
 "yuval.shaia@oracle.com" <yuval.shaia@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "clg@kaod.org" <clg@kaod.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "david@redhat.com" <david@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "integration@gluster.org" <integration@gluster.org>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "andrew@aj.id.au" <andrew@aj.id.au>, "cohuck@redhat.com" <cohuck@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 "sundeep.lkml@gmail.com" <sundeep.lkml@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 01, 2019 at 06:52:52PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Here is introduced ERRP_AUTO_PROPAGATE macro, to be used at start of
> functions with errp OUT parameter.
> 
> It has three goals:
> 
> 1. Fix issue with error_fatal & error_prepend/error_append_hint: user
> can't see this additional information, because exit() happens in
> error_setg earlier than information is added. [Reported by Greg Kurz]
> 
> 2. Fix issue with error_abort & error_propagate: when we wrap
> error_abort by local_err+error_propagate, resulting coredump will
> refer to error_propagate and not to the place where error happened.
> (the macro itself doesn't fix the issue, but it allows to [3.] drop all
> local_err+error_propagate pattern, which will definitely fix the issue)
> [Reported by Kevin Wolf]
> 
> 3. Drop local_err+error_propagate pattern, which is used to workaround
> void functions with errp parameter, when caller wants to know resulting
> status. (Note: actually these functions could be merely updated to
> return int error code).
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
> 
> CC: kwolf@redhat.com
> CC: mreitz@redhat.com
> CC: jsnow@redhat.com
> CC: fam@euphon.net
> CC: sw@weilnetz.de
> CC: codyprime@gmail.com
> CC: marcandre.lureau@redhat.com
> CC: pbonzini@redhat.com
> CC: groug@kaod.org
> CC: sundeep.lkml@gmail.com
> CC: peter.maydell@linaro.org
> CC: stefanha@redhat.com
> CC: pburton@wavecomp.com
> CC: arikalo@wavecomp.com
> CC: berrange@redhat.com
> CC: ehabkost@redhat.com
> CC: david@gibson.dropbear.id.au
> CC: clg@kaod.org
> CC: mst@redhat.com
> CC: marcel.apfelbaum@gmail.com
> CC: mark.cave-ayland@ilande.co.uk
> CC: yuval.shaia@oracle.com
> CC: cohuck@redhat.com
> CC: farman@linux.ibm.com
> CC: rth@twiddle.net
> CC: david@redhat.com
> CC: pasic@linux.ibm.com
> CC: borntraeger@de.ibm.com
> CC: kraxel@redhat.com
> CC: alex.williamson@redhat.com
> CC: andrew@aj.id.au
> CC: joel@jms.id.au
> CC: eblake@redhat.com
> CC: armbru@redhat.com
> CC: mdroth@linux.vnet.ibm.com
> CC: quintela@redhat.com
> CC: dgilbert@redhat.com
> CC: jasowang@redhat.com
> CC: qemu-block@nongnu.org
> CC: integration@gluster.org
> CC: qemu-arm@nongnu.org
> CC: qemu-ppc@nongnu.org
> CC: qemu-s390x@nongnu.org
> 
>  include/qapi/error.h | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/include/qapi/error.h b/include/qapi/error.h
> index 9376f59c35..02f967ac1d 100644
> --- a/include/qapi/error.h
> +++ b/include/qapi/error.h
> @@ -322,6 +322,43 @@ void error_set_internal(Error **errp,
>                          ErrorClass err_class, const char *fmt, ...)
>      GCC_FMT_ATTR(6, 7);
>  
> +typedef struct ErrorPropagator {
> +    Error *local_err;
> +    Error **errp;
> +} ErrorPropagator;
> +
> +static inline void error_propagator_cleanup(ErrorPropagator *prop)
> +{
> +    error_propagate(prop->errp, prop->local_err);
> +}
> +
> +G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(ErrorPropagator, error_propagator_cleanup);
> +
> +/*
> + * ERRP_AUTO_PROPAGATE
> + *
> + * This macro is created to be the first line of a function with Error **errp
> + * OUT parameter. It's needed only in cases where we want to use error_prepend,
> + * error_append_hint or dereference *errp. It's still safe (but useless) in
> + * other cases.
> + *
> + * If errp is NULL or points to error_fatal, it is rewritten to point to a
> + * local Error object, which will be automatically propagated to the original
> + * errp on function exit (see error_propagator_cleanup).
> + *
> + * After invocation of this macro it is always safe to dereference errp
> + * (as it's not NULL anymore) and to append hints (by error_append_hint)
> + * (as, if it was error_fatal, we swapped it with a local_error to be
> + * propagated on cleanup).
> + *
> + * Note: we don't wrap the error_abort case, as we want resulting coredump
> + * to point to the place where the error happened, not to error_propagate.
> + */
> +#define ERRP_AUTO_PROPAGATE() \
> +g_auto(ErrorPropagator) __auto_errp_prop = {.errp = errp}; \
> +errp = ((errp == NULL || *errp == error_fatal) ? \
> +    &__auto_errp_prop.local_err : errp)
> +

I guess it has been discussed but I couldn't find it, so: what's the
reason for casting in stone the name of the function parameter, which
isn't quite so obvious when you see this macro used in the code?  IMO
if the macro took errp as a parameter that would be easier to follow.

Thanks,
Roman.

