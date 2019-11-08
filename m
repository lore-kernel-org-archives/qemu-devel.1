Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48714FC6195
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:06:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F06C2178F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iFfB0w6Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F06C2178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT4uK-0001iA-68
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 09:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rkagan@virtuozzo.com>) id 1iT4tN-0000jU-If
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:05:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rkagan@virtuozzo.com>) id 1iT4tL-0002Zc-RE
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:05:37 -0500
Received: from mail-bgr052101133092.outbound.protection.outlook.com
 ([52.101.133.92]:38628 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
 id 1iT4tL-0002Z8-3m; Fri, 08 Nov 2019 09:05:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQXOA7ci4sbOhfPf/OO9uC2q8QNVX4G52yPLw1hi5r2Dknzt1M6tHS88KKb8O+92fE70Js7rFEQK9nuCsbzKyXg+xsLZwCjolN6Rd+sKT1VOg8AFEgatYUGqV5dtItkWutdRMoCsIUDrHcwrym61/wpZo0NsvqKxKLi/hjbpM3OVqOwcxQ97IR2mhxoCFvevoH2RPZQUgF2EY2c5hGWn/M2XT+dAg5rtSfUFMp0jLcirTz6i/AhF857buswXpLdtjH2sVKYYWLQAi1YjFMtXrfflGvz1K/TS9+AbNoyd6MohEcga24WPoq7m4l+EuHe/t6yWRoiwmR79Oy034hyNig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WW0nAHRQHf5ev0Fs/KqNwu75pi1r1PpbojcJNzqpTGM=;
 b=i2ylqCHgBXtj0Yn9dwc+pV0Ju333u2ufDnNKzLebeyN3ZQ+NPg0IVch6fCG0Fm1GQHCUAQsbWg9XWC34nlA1AlE2e6dNYPf/ZBq5w+BWTgGA6M0LBVUFJTAFdM/KIti/PnfjSydAXSkEwChvO7XYfdW2Epl5cYEO7+rCarWOsK91z+033Gt8eBSmUpH8eqM6ddNc+0UXHoVBqnHl1R09/QUYcg7qx6wuRaEVQRGVSSnRlIBawLymAwHGce8LqpfyFNv/v+fevkDlA4Ziv7xdUEV0++avHSa2ZN4poD+EDAO84uoHaldwkFDfLXGvGnN45dk82weR623jUzDLd2jfTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WW0nAHRQHf5ev0Fs/KqNwu75pi1r1PpbojcJNzqpTGM=;
 b=iFfB0w6ZhP/iyrV2gAMysDZ8IqOcx4xVo8e7AV1fCGE+Cp0Zdaz/SMyjSs9HW2laSL6fOoocesCBrEUXy0nEpqf2C+NxxTb9zKog1TPYJUFY0JOS8ypKLeCooT6yGyAwGt1R+OX6tQfSPlTnzB7PwYXcJKlyAsUIbd/5bU/6NCo=
Received: from VI1PR08MB4608.eurprd08.prod.outlook.com (20.178.80.22) by
 VI1PR08MB3790.eurprd08.prod.outlook.com (20.178.15.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Fri, 8 Nov 2019 14:05:31 +0000
Received: from VI1PR08MB4608.eurprd08.prod.outlook.com
 ([fe80::9465:ec66:befb:e8b5]) by VI1PR08MB4608.eurprd08.prod.outlook.com
 ([fe80::9465:ec66:befb:e8b5%3]) with mapi id 15.20.2430.023; Fri, 8 Nov 2019
 14:05:31 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v3] iotests: Test NBD client reconnection
Thread-Topic: [PATCH v3] iotests: Test NBD client reconnection
Thread-Index: AQHVkNUYkueRQi37cke6mp6VF9z0xKeBVR0AgAAEXYA=
Date: Fri, 8 Nov 2019 14:05:31 +0000
Message-ID: <20191108140527.GA63895@rkaganb.sw.ru>
References: <1572627272-23359-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <feb2b810-3436-6550-43b2-a07ec1fc5280@virtuozzo.com>
In-Reply-To: <feb2b810-3436-6550-43b2-a07ec1fc5280@virtuozzo.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.12.1 (2019-06-15)
mail-followup-to: Roman Kagan <rkagan@virtuozzo.com>,	Vladimir
 Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,	Andrey Shinkevich
 <andrey.shinkevich@virtuozzo.com>,	"qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>,	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "kwolf@redhat.com" <kwolf@redhat.com>,	Denis Lunev <den@virtuozzo.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR0701CA0064.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::32) To VI1PR08MB4608.eurprd08.prod.outlook.com
 (2603:10a6:803:c0::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61adef6b-bdac-426e-ac63-08d76454b75b
x-ms-traffictypediagnostic: VI1PR08MB3790:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR08MB3790CA5E410ACD7A977340A6C97B0@VI1PR08MB3790.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:SPM;
 SFS:(10019020)(979002)(376002)(396003)(39840400004)(346002)(366004)(136003)(199004)(189003)(81166006)(8936002)(6486002)(7736002)(305945005)(6862004)(5660300002)(66446008)(64756008)(66556008)(66476007)(6306002)(14444005)(186003)(6636002)(54906003)(33656002)(3846002)(66946007)(11346002)(476003)(6116002)(4326008)(76176011)(486006)(66066001)(256004)(52116002)(2906002)(99286004)(8676002)(446003)(229853002)(14454004)(386003)(6506007)(1076003)(25786009)(966005)(478600001)(81156014)(316002)(58126008)(102836004)(71190400001)(6436002)(6246003)(36756003)(9686003)(26005)(86362001)(6512007)(71200400001)(30126002)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1501; SCL:5; SRVR:VI1PR08MB3790;
 H:VI1PR08MB4608.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rF7L1pgZM57f8gvxKd5kYMN8CXVQdyrOP/x4Lvj805xN6WrI2LbcLdxb8tmKPOtGy7gamF6jsi1r4jgs6Vb/SM2tnsLda29KSjMMxl16bagPX8hQWyhz7TWwf6Vja9GJ2Q56vByLcmb3wCptIdpDRNRJ67kboI8RF6xluA93NUXrwUCiyBopgx2z8yngIRhWQrRhHttDkQHLAHl9+NRrGdb3lIDVzy1TrdvWoTcfe6jvbRBokcUvxlLXGcME7GNg7W6OQSl5ebi5Xoja8D0yK0UTExhqGQX0Ekvh+E/gAnudvkI7qlldHNDzADNPD5YYlJcjdt2vFjcf5dm/aoNKPS2YCtYUffO1m/YQUXAkcDSHxuk2afPtzFf9acYJxutnXAJA7vRDALpScSB62ye5h30KyuYQV0CGJlHm+jGKBf8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <091B2B1EEF049840B5F50F1157F6FE6E@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61adef6b-bdac-426e-ac63-08d76454b75b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 14:05:31.6121 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HOCZJmpDNiZU6/H/uW5CiOixx3GF+5JR0hnmlL9N1RhyuNgb2YA9q3ZrtSXgyh7snR4F6L6SYOv+RrTkTMTNHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3790
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 52.101.133.92
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 08, 2019 at 01:49:50PM +0000, Vladimir Sementsov-Ogievskiy wrote:
> 01.11.2019 19:54, Andrey Shinkevich wrote:
> > +def check_proc_NBD(proc, connector):
> > +    try:
> > +        exitcode = proc.wait(timeout=10)
> > +
> > +        if exitcode < 0:
> > +            log('NBD {}: EXIT SIGNAL {}\n'.format(connector, -exitcode))
> > +            log(proc.communicate()[0])
> > +        else:
> > +            line = proc.stdout.readline()
> 
> 
> could we use proc.communicate() for both cases, what is the difference?

In fact if proc produces any non-trivial amount of output you are better
off using .communicate() otherwise your child may block on output and
never exit.  See
https://docs.python.org/3/library/subprocess.html#subprocess.Popen.communicate
for how to express the above logic correctly.  The exit code *after*
.communicate is available in .returncode.

> 
> > +            log('NBD {}: {}'.format(connector, line.rstrip()))
> > +
> > +    except subprocess.TimeoutExpired:
> > +        proc.kill()
> > +        log('NBD {}: ERROR timeout expired'.format(connector))
> > +    finally:
> > +        if connector == 'server':
> > +            os.remove(nbd_sock)
> > +            os.remove(conf_file)

Roman.

