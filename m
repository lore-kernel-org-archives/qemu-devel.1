Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16A3C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 11:11:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9085206D5
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 11:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="iTKJpsdC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9085206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWHxw-0000DK-RW
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 07:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jWHxL-00088D-6B; Wed, 06 May 2020 07:11:15 -0400
Received: from mail-bn7nam10on2068.outbound.protection.outlook.com
 ([40.107.92.68]:6210 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jWHxJ-0008GJ-1K; Wed, 06 May 2020 07:11:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZ8t6USF0wUXAiM3rSU7o3iK5oI+Q9rPXohiGNMSlcw965PJdn5FgexpfLu2X3+lLUke0tpmayppA6XLDTOj3IkiBhkoEQ2UpRZAGHSOFGXedJm2yY8O5EMEypivqzr6l8swcMZVIyetb1At9zxcmeXzFRXeG5x04GMSdQv4nXtIzhJ9okFxoKRmqh/qljc7SsWV0oigrA4u8dZGxiHDSFhBPiM9xoUAq0RHEo1DuSby8TE5OHZ0dK6s5mOcEeQmb0VubzWjz1O+2ZXzzCC0C5fEycP4swzN8m5V7qgqwJyFG1kJVKPb4Hq+jZ1q7unxGM+reTeTeVD9BjpBTa3FsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpQnZHThzIxwCiEnQuWpC3GhN00vVxp9Hm1uAJCkZE8=;
 b=T8RhyKtL7V0XF7scS2N602EbQRP0g4ZSCeWw6MmBYgUt/VbPo4omsKsOeKkW2UQSJekHMmIW3LAAfSadgZ3vvbgur56eBV4E6c7h7mVo0Zo9lhiTfqyzXT58oob4hqpKtqL1H30kiZwJkXRjJBNnU75z2tOTT1a8YXsebDZ+IvKD/XRJYEwUndhAMPnbsk9LAJbmcWuR9omW2QpncQ1xawdpOsB/f9Ogl3/JPiNe3dFHXIV/lDqWNrOuNMh1lI9SBBI1oI9Fv2K/+XDhaY99oKPdww9Nr6hH4FgCvQ7VV10JnBEL3rVETBZiDMVNj0344Yfp37Ww3zbvW1IObw1w4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpQnZHThzIxwCiEnQuWpC3GhN00vVxp9Hm1uAJCkZE8=;
 b=iTKJpsdCkDv7/e+2ly69sA2b1BSzQtZw5reRP/cmToqubphkNL1HoWkYurxoxIxT2Y1f8ztnv3iua/qeQMSWE8j861UalYB/HE/MEQNv6eJ1RZ8WCv9tMMraFtDRyNBTOvsif15jPednEco0Qh55jcvaHJZSaq21AlXmk76MRsA=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BY5PR02MB6019.namprd02.prod.outlook.com (2603:10b6:a03:1b0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Wed, 6 May
 2020 11:11:08 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::9165:a37e:f249:48f6]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::9165:a37e:f249:48f6%9]) with mapi id 15.20.2979.028; Wed, 6 May 2020
 11:11:08 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: RE: [PATCH v2 05/10] net: cadence_gem: Set ISR according to queue in
 use
Thread-Topic: [PATCH v2 05/10] net: cadence_gem: Set ISR according to queue in
 use
Thread-Index: AQHWIiUKuv9PPYFuuUy8ET3A7v8AR6ia6Z9A
Date: Wed, 6 May 2020 11:11:08 +0000
Message-ID: <BY5PR02MB67720356425EBA4F8AACA294CAA40@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1588601168-27576-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1588601168-27576-6-git-send-email-sai.pavan.boddu@xilinx.com>
 <20200504150229.GE5519@toto>
In-Reply-To: <20200504150229.GE5519@toto>
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
x-ms-office365-filtering-correlation-id: 06ca1dbe-dbd1-410d-3297-08d7f1ae2da5
x-ms-traffictypediagnostic: BY5PR02MB6019:|BY5PR02MB6019:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB6019FF8EBDE41641BCE91D3BCAA40@BY5PR02MB6019.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 03950F25EC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UOPLE7VpiyE/nWtRL9BwXU1e0f0XohPDO40Hlv+uuLqUQixBwP0+ShDb/H5Mw+C2GPhCQKvvFuL3S/9Wh/lHjjSGrEdxoFAFQWxNlUSy+B1SBxxCqQdpvNxtXuIv+MjFcozKkVJpQM+hAH+OffjpZJwhxE5yrSGCEuZUoWVPaOz9J4BMNjRLbHDHin2yT8soPDtU/Mi/1YwsywyaX2t9HrK47RS24HxqQ+WC+UNgP95y5AQ4kCLqKBW+p4iQhbu6wJrli3IznOkXpjTdJssz9b8ZpjdX2E3dFpOZTgNqOCHX4T5L/TIibNWSj2vT/+mT4xBpDSJRJVQjhgroAPcLTF4bNgPGSLF6QpeZy38T2IP2SVSvUUcWUOWO/fL+1MirL/q8DSujzWutuR+LCk7Bba6yu002SkMLbULE5+7KqDpU272ykvzSjQUxoELt3odMCZQpRCYPA7KdkBuD9tJ38t3WM16WqbEMZOqrS08vxjpv46SOE6yRg7hvtuEcz6Z//MWGObO1YwfK0Y9I2Cb4TQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(136003)(346002)(366004)(376002)(39860400002)(33430700001)(2906002)(6916009)(7696005)(478600001)(8936002)(6506007)(5660300002)(66446008)(53546011)(86362001)(66476007)(66946007)(54906003)(316002)(76116006)(64756008)(66556008)(33440700001)(26005)(55016002)(186003)(4326008)(71200400001)(52536014)(8676002)(9686003)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: +PlNmfInOBi60gHRp/Hf19GISSuA3OfnoveMRd92R/ILoDs/p61a5/czGab4tZisnCvCfjbdE2iBOA1F1vE5+RT3nIDqoT6NFCSWdxPbOw+tPkaQHVmZTSDJpaJ7WjWs7SlRqbiw+HZ70VqZUxH/WtG0IkcJaib0n4pQyRpBh7O0b+vYcJVkACRKO9c25gv4sv++exdcr/5YkKh+23BGiIbBus9eLHFlMDD+EUPsJ8OwtLq26cdoa/yvGQ+seMiqdgXhnruoBgKjP6zJTN5F3wbFefFD6H5pYBUAKISJ1gQOEGC0zYI/N6L1cMYNR3B8K/xs5JAANyeJF9Xg7svvGE1MtfGS5w1GlHu+xzsGmKhy+1yQIHfpmAUaREw4gHohhxyUwWZYgRq7S2nkSrp2yDOiKHmRa4CSDmUS2NJMK6gIUd1TuepZODP62wqwJSM87TbNmirNs1AB5lNejKWkkt2p8E3Ly1GLNGt3ILtd2iKvaRra3i7lpdxE08Ullf3imtGVY8atQMG/sOYHuSRjRL2SRgthWV6cQOnekurreejHZNmdMPCcSUzUGKrcLtukxt4yMs1QbWSutcaxhd1NUVPCVHzRNxMUeAwem7RP2+Na46Kx9IOrmBxIa2+hoGup3yXlVdHtPEIe6tpp7Rlc21+VfdnElBo+vzOB9xGzOxdDTC4yt60sYT32MHfCZ2BVQ3kqEChSG4eo3MmqeZaTE0MdnosZMBxd3X5x08PSCIHuPkpKujaGHvusRdfgQHE5rdLr44haZvXQaK4KULsUJyGGiB5lClrQ2IEKMw3ZFEQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ca1dbe-dbd1-410d-3297-08d7f1ae2da5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2020 11:11:08.7792 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F2zRGM0Uo0bPxZ4v8Z/wW6yvjTVidhuBVGUkziHTyquAjbGNedLQerSsFhb4vqE3ML78X/6Y65+h3K0v+yZR/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6019
Received-SPF: pass client-ip=40.107.92.68; envelope-from=saipava@xilinx.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 07:11:10
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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

> -----Original Message-----
> From: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> Sent: Monday, May 4, 2020 8:32 PM
> To: Sai Pavan Boddu <saipava@xilinx.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>; Peter Maydell
> <peter.maydell@linaro.org>; Jason Wang <jasowang@redhat.com>; Markus
> Armbruster <armbru@redhat.com>; Philippe Mathieu-Daud=E9
> <philmd@redhat.com>; Tong Ho <tongh@xilinx.com>; Ramon Fried
> <rfried.dev@gmail.com>; qemu-arm@nongnu.org; qemu-
> devel@nongnu.org
> Subject: Re: [PATCH v2 05/10] net: cadence_gem: Set ISR according to queu=
e
> in use
>=20
> On Mon, May 04, 2020 at 07:36:03PM +0530, Sai Pavan Boddu wrote:
> > Set ISR according to queue in use, added interrupt support for all
> > queues.
>=20
> Would it help to add a gem_set_isr(CadenceGEMState *s, int q, uint32_t
> flag) ?
> Instead of open coding these if (q =3D=3D 0) else... all over the place..=
.
[Sai Pavan Boddu] Yeah, it would be nice. Will try to include this in v3

Thanks,
Sai Pavan
>=20
> Anyway, the logic looks good to me:
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>=20
>=20
>=20
> >
> > Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> > ---
> >  hw/net/cadence_gem.c | 31 ++++++++++++++++++++++---------
> >  1 file changed, 22 insertions(+), 9 deletions(-)
> >
> > diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c index
> > c532a14..beb38ec 100644
> > --- a/hw/net/cadence_gem.c
> > +++ b/hw/net/cadence_gem.c
> > @@ -896,7 +896,13 @@ static void gem_get_rx_desc(CadenceGEMState
> *s, int q)
> >      if (rx_desc_get_ownership(s->rx_desc[q]) =3D=3D 1) {
> >          DB_PRINT("descriptor 0x%" HWADDR_PRIx " owned by sw.\n",
> desc_addr);
> >          s->regs[GEM_RXSTATUS] |=3D GEM_RXSTATUS_NOBUF;
> > -        s->regs[GEM_ISR] |=3D GEM_INT_RXUSED & ~(s->regs[GEM_IMR]);
> > +        if (q =3D=3D 0) {
> > +            s->regs[GEM_ISR] |=3D GEM_INT_RXUSED & ~(s->regs[GEM_IMR])=
;
> > +        } else {
> > +            s->regs[GEM_INT_Q1_STATUS + q - 1] |=3D GEM_INT_RXUSED &
> > +                                          ~(s->regs[GEM_INT_Q1_MASK + =
q - 1]);
> > +        }
> > +
> >          /* Handle interrupt consequences */
> >          gem_update_int_status(s);
> >      }
> > @@ -1071,8 +1077,12 @@ static ssize_t gem_receive(NetClientState *nc,
> const uint8_t *buf, size_t size)
> >      gem_receive_updatestats(s, buf, size);
> >
> >      s->regs[GEM_RXSTATUS] |=3D GEM_RXSTATUS_FRMRCVD;
> > -    s->regs[GEM_ISR] |=3D GEM_INT_RXCMPL & ~(s->regs[GEM_IMR]);
> > -
> > +    if (q =3D=3D 0) {
> > +        s->regs[GEM_ISR] |=3D GEM_INT_RXCMPL & ~(s->regs[GEM_IMR]);
> > +    } else {
> > +        s->regs[GEM_INT_Q1_STATUS + q - 1] |=3D GEM_INT_RXCMPL &
> > +                                      ~(s->regs[GEM_INT_Q1_MASK + q - =
1]);
> > +    }
> >      /* Handle interrupt consequences */
> >      gem_update_int_status(s);
> >
> > @@ -1223,12 +1233,12 @@ static void gem_transmit(CadenceGEMState
> *s)
> >                  DB_PRINT("TX descriptor next: 0x%08x\n",
> > s->tx_desc_addr[q]);
> >
> >                  s->regs[GEM_TXSTATUS] |=3D GEM_TXSTATUS_TXCMPL;
> > -                s->regs[GEM_ISR] |=3D GEM_INT_TXCMPL & ~(s->regs[GEM_I=
MR]);
> > -
> > +                if (q =3D=3D 0) {
> > +                    s->regs[GEM_ISR] |=3D GEM_INT_TXCMPL & ~(s-
> >regs[GEM_IMR]);
> > +                } else {
> >                  /* Update queue interrupt status */
> > -                if (s->num_priority_queues > 1) {
> > -                    s->regs[GEM_INT_Q1_STATUS + q] |=3D
> > -                            GEM_INT_TXCMPL & ~(s->regs[GEM_INT_Q1_MASK=
 + q]);
> > +                    s->regs[GEM_INT_Q1_STATUS + q - 1] |=3D
> > +                            GEM_INT_TXCMPL & ~s->regs[GEM_INT_Q1_MASK
> > + + q - 1];
> >                  }
> >
> >                  /* Handle interrupt consequences */ @@ -1280,7
> > +1290,10 @@ static void gem_transmit(CadenceGEMState *s)
> >
> >          if (tx_desc_get_used(desc)) {
> >              s->regs[GEM_TXSTATUS] |=3D GEM_TXSTATUS_USED;
> > -            s->regs[GEM_ISR] |=3D GEM_INT_TXUSED & ~(s->regs[GEM_IMR])=
;
> > +            /* IRQ TXUSED is defined only for queue 0 */
> > +            if (q =3D=3D 0) {
> > +                s->regs[GEM_ISR] |=3D GEM_INT_TXUSED & ~(s-
> >regs[GEM_IMR]);
> > +            }
> >              gem_update_int_status(s);
> >          }
> >      }
> > --
> > 2.7.4
> >

