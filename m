Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE2DC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 10:02:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B51520753
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 10:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="NvcZ8T77"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B51520753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWGsN-0006tv-4H
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 06:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jWGmc-0007Xs-9N; Wed, 06 May 2020 05:56:06 -0400
Received: from mail-eopbgr680044.outbound.protection.outlook.com
 ([40.107.68.44]:25333 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jWGma-0006J0-7l; Wed, 06 May 2020 05:56:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCZpA7+FxXlBBxDQIZQpFwDFI99vlXp364naCLKTsbVXEomZ9ABsDZshv1apNB7MziiqxikOlH9/sFX6hv6A9Xt5fYke0T1yZrqpaVyR5+b46EGnnaAbQ4e0hX6gDCQPshEwZPHbaZ4F4bhGezmZJRujmMoK6WtKDd5ii1CrPWmUUgdNKqIEZ/G3XOiwTuhsgBcK/mXWg7ZmIN1KJwthHo/slnOkTjvDHDl8lUCESDrOQrwI7yhtVdG5rUJlS+5r/aFB+U3Bh6Ui4R7yImAfjXxgcTlBUH3Bqy4lTFhJoxoKhTDP7XKJINS1XoYi53+im3Rsi0dMpOY1Ksp3zUZ9/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbfVs4kuxmnwygnH71wKIccBArEm0K2R2Qpun73jLnQ=;
 b=g4vK5Zrw/AwNhtIMiIDTBsnxD2ymBC8QA3+sFN23o6SAdUirNMuhlpu0dZmvfhjQR2dJ/utIsI8OMhzCaRuY6X+bQ5f6sXp/0pPYQZA+CYucJfuo4UocXbH3crikF66IBmvyg/in9TQa1Az3lFEGC/10K3dYpr9xV4V0mbtskg64jj4jMZK1NJm3VeTTEhaKRvj6Ac39/vGnYBA/tma2T2LQkIp0r5MW3srqQ3SOZGX7Nn1IkH9zW0G+W6H7wPUJI06mkRl5ZwhCaln6CPosHf8Knok8PybRx58zwN623pZtsb8c86X0tMvqsct8ycAC+83tqvp5RnisMBUGnygP7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbfVs4kuxmnwygnH71wKIccBArEm0K2R2Qpun73jLnQ=;
 b=NvcZ8T77Q598Pp2Uu6sOJiPzrK0pr8EjQOHEXYjoN6SXVKA1E+NbzSL4vXQWjjlGkud7zhj8asfAlSKWouemnpWHCILV80TXy1cYPZZdlIw0EqI+8JTjsVqcjwVvWBOUVJaYvejGFnWrxqaj9QURLy9ukSip7vZFIsZYrK51oMY=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BY5PR02MB7012.namprd02.prod.outlook.com (2603:10b6:a03:233::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Wed, 6 May
 2020 09:56:00 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::9165:a37e:f249:48f6]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::9165:a37e:f249:48f6%9]) with mapi id 15.20.2979.028; Wed, 6 May 2020
 09:56:00 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: RE: [PATCH v2 01/10] net: cadence_gem: Fix debug statements
Thread-Topic: [PATCH v2 01/10] net: cadence_gem: Fix debug statements
Thread-Index: AQHWIiHPl6U+Xp63S0WC+U+KRE83B6ia1LhA
Date: Wed, 6 May 2020 09:55:59 +0000
Message-ID: <BY5PR02MB67727CCA1C24483DE5CBBF45CAA40@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1588601168-27576-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1588601168-27576-2-git-send-email-sai.pavan.boddu@xilinx.com>
 <20200504143922.GB5519@toto>
In-Reply-To: <20200504143922.GB5519@toto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 28b6cac6-ea3e-4d6f-0e39-08d7f1a3ae35
x-ms-traffictypediagnostic: BY5PR02MB7012:|BY5PR02MB7012:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB7012FB6DEC4BA5C1FDDA8124CAA40@BY5PR02MB7012.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:230;
x-forefront-prvs: 03950F25EC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IwVxcBP8EkFGZLNTfgaOFxYKXexbkTYhIYzcqo5GNTbPdvI9jFeYnjnknB7XuD5cLC7S+IU9Uw1vHSRt8EUeBFtS2jS7/5K0wiUPE2+aN7LueoVqd4EBArvKpcX73EnQoG2XFhYG9caKMbc0m3dakaapiFKj68kIOHrjSgHBuL5GEY17qfEB+LHqzwDG4QevRHPxGSjAlYIC74CaSeqSXLs3/cXGJJBCF/txrmpzbXr2xwtWXjKVE/l89DPTRLQZdDgJ7h5WjDf8VxiEyDy5e7rrs6/5Jxf7S4QfeicrU08eta6F9n2NV6zwSCGQPhcb+VLEDOTwLDTgbER3gbdPjEpVsfW8Ji+GWf5dgFp8WkgXMz8V8gLhm4V55dUZ/mF3GfXMl1fdFpLABv9Ayy7H2M1xH8pyHvhNrcF/n9fzH2wfeJHFhLtypKI+6qE/jq9vc/TzFtdC+DTcU8ZMcO6bAHhekU6Mk6flbMJf0vOzKh84owbjY2GtC+De9mz+JlW3DxOPWJg4pk5GSHEWpNOefg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(396003)(39860400002)(366004)(136003)(376002)(33430700001)(316002)(33440700001)(52536014)(5660300002)(8676002)(53546011)(186003)(55016002)(54906003)(2906002)(86362001)(26005)(9686003)(64756008)(6916009)(71200400001)(66446008)(66946007)(7696005)(66556008)(66476007)(6506007)(33656002)(4326008)(76116006)(8936002)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: bMPwRZwM17SbkIPwL5liAUd8giwWg3AQfSBKhUpoRubS5qYaTp/z13S5YQyMWHrk0TY6ryVhjXMy97S0IRklX+ZwE38AKOzPVuMbek7xRV+FIfxItGxCtQAw7edcaWOB7wmgzNHLc9CNaebm0tzMumy02p1osb2hQ2kL8BwgeI+654Y2GCdvcmHk11+hcPi3HC6a26Y/IyS8myO8h9dV3GE4ogwoDjENeXsQrtyzSOv9+CXYDgRa6/xVFvZwbWkRnIFd4fqK3+Sxt1ONFW5PurvVvyTooqDiK7aoGCoHim9t9j/yrKd9whDYLRl1mvBN6nvJXk5SNAhwe8o4lqZvGhA3eJfcPORFFXn2OvP+Ki3K0Dr9BgUvrt06HRUai1Yt2AU3mT4DzJpxvhc++Rcm0edW7JEgpTmdqR2hI9nrd4EkuvTLpcoQJ7x1oqL5dbIVYgUGe9P5hIL0H0YY6meIUYOwd1rhiK6kkyx7UPRqbUplLsBKuDMqNz4l0CkZh8kUsmwDuSjyULHu63WE57QOQki7tkr9WppxtpYf/TaAUPc/jM5qlBU/cC/5uzI/7tn/noG08myM/urM4v9O/eA+9ZiKUWX9xH05+M6/ZsLc2HBRyK43KUUQ9DxCoL7vKzPpi6T7+Fd/dDScY82fDQz7inSK4u3etyfwPqdOqmr39UzIvGJcgANotd1CDDlconCLbacER0el74vQm798W57ZpE22wOMQOow17BSSs41Uzz4VbtIrgjVoKlmwqK94MfPa3BJetDyhdHpIHJcWO/WiaboMqtRoQ8yKsgtSrQ+3UnU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b6cac6-ea3e-4d6f-0e39-08d7f1a3ae35
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2020 09:55:59.9267 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S2OGq0STtu7cZdk0Lz0MNvObn/QmrR5ydzQcmyPUvPESwGDPlkhqQMzNOcLdb5W7Iahqpejygtn/hpRy4zNLiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7012
Received-SPF: pass client-ip=40.107.68.44; envelope-from=saipava@xilinx.com;
 helo=NAM04-BN3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 05:56:01
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Tong Ho <tongh@xilinx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Edgar,

Below comments will be taken care in V3.

Thanks,
Sai Pavan

> -----Original Message-----
> From: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> Sent: Monday, May 4, 2020 8:09 PM
> To: Sai Pavan Boddu <saipava@xilinx.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>; Peter Maydell
> <peter.maydell@linaro.org>; Jason Wang <jasowang@redhat.com>; Markus
> Armbruster <armbru@redhat.com>; Philippe Mathieu-Daud=E9
> <philmd@redhat.com>; Tong Ho <tongh@xilinx.com>; Ramon Fried
> <rfried.dev@gmail.com>; qemu-arm@nongnu.org; qemu-
> devel@nongnu.org
> Subject: Re: [PATCH v2 01/10] net: cadence_gem: Fix debug statements
>=20
> On Mon, May 04, 2020 at 07:35:59PM +0530, Sai Pavan Boddu wrote:
> > Enabling debug breaks the build, Fix them and make debug statements
> > always compilable. Fix few statements to use sized integer casting.
> >
> > Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> > ---
> >  hw/net/cadence_gem.c | 28 ++++++++++++++--------------
> >  1 file changed, 14 insertions(+), 14 deletions(-)
> >
> > diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c index
> > 22a0b1b..2f244eb 100644
> > --- a/hw/net/cadence_gem.c
> > +++ b/hw/net/cadence_gem.c
> > @@ -35,14 +35,13 @@
> >  #include "sysemu/dma.h"
> >  #include "net/checksum.h"
> >
> > -#ifdef CADENCE_GEM_ERR_DEBUG
> > -#define DB_PRINT(...) do { \
> > -    fprintf(stderr,  ": %s: ", __func__); \
> > -    fprintf(stderr, ## __VA_ARGS__); \
> > -    } while (0)
> > -#else
> > -    #define DB_PRINT(...)
> > -#endif
> > +#define CADENCE_GEM_ERR_DEBUG 0
> > +#define DB_PRINT(...) do {\
> > +    if (CADENCE_GEM_ERR_DEBUG) {   \
> > +        qemu_log(": %s: ", __func__); \
> > +        qemu_log(__VA_ARGS__); \
> > +    } \
> > +} while (0)
> >
> >  #define GEM_NWCTRL        (0x00000000/4) /* Network Control reg */
> >  #define GEM_NWCFG         (0x00000004/4) /* Network Config reg */
> > @@ -979,7 +978,8 @@ static ssize_t gem_receive(NetClientState *nc,
> const uint8_t *buf, size_t size)
> >          size +=3D 4;
> >      }
> >
> > -    DB_PRINT("config bufsize: %d packet size: %ld\n", rxbufsize, size)=
;
> > +    DB_PRINT("config bufsize: %" PRIu64 " packet size: %" PRIu64 "\n",
> > +             (uint64_t) rxbufsize, (uint64_t) size);
>=20
> Shouldn't these be %u and %zd rather than casting to uint64_t?
>=20
>=20
> >
> >      /* Find which queue we are targeting */
> >      q =3D get_queue_from_screen(s, rxbuf_ptr, rxbufsize); @@ -992,9
> > +992,9 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t
> *buf, size_t size)
> >              return -1;
> >          }
> >
> > -        DB_PRINT("copy %u bytes to 0x%" PRIx64 "\n",
> > -                 MIN(bytes_to_copy, rxbufsize),
> > -                 rx_desc_get_buffer(s, s->rx_desc[q]));
> > +        DB_PRINT("copy %" PRIu32 " bytes to 0x%" PRIx64 "\n",
> > +                MIN(bytes_to_copy, rxbufsize),
> > +                rx_desc_get_buffer(s, s->rx_desc[q] + rxbuf_offset));
>=20
> Looks like this is changing what we print (+ rxbuf_offset), was that
> intentional? (it was not mentioned in the commit message)
>=20
>=20
> >
> >          /* Copy packet data to emulated DMA buffer */
> >          address_space_write(&s->dma_as, rx_desc_get_buffer(s,
> > s->rx_desc[q]) + @@ -1160,8 +1160,8 @@ static void
> gem_transmit(CadenceGEMState *s)
> >               */
> >              if ((tx_desc_get_buffer(s, desc) =3D=3D 0) ||
> >                  (tx_desc_get_length(desc) =3D=3D 0)) {
> > -                DB_PRINT("Invalid TX descriptor @ 0x%x\n",
> > -                         (unsigned)packet_desc_addr);
> > +                DB_PRINT("Invalid TX descriptor @ 0x%" HWADDR_PRIx "\n=
",
> > +                         packet_desc_addr);
> >                  break;
> >              }
> >
> > --
> > 2.7.4
> >

