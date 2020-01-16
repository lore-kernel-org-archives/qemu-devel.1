Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851D2C32771
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 00:56:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F69624656
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 00:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fujitsu.onmicrosoft.com header.i=@fujitsu.onmicrosoft.com header.b="jy8kTh3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F69624656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irtSg-00031E-ER
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 19:56:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33835)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1irtRp-0002Zq-3Z
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 19:55:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1irtRn-0005eM-9D
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 19:55:44 -0500
Received: from esa14.fujitsucc.c3s2.iphmx.com ([68.232.156.101]:19976)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1irtRm-0005cd-PC
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 19:55:43 -0500
IronPort-SDR: Q1ZwBQxWT+G2hJGuFzkbecpKun72uTGgOTW/EQF5oCgzCvMl0Q3Ur5w09jAP72xXXvci+kAiSM
 gKzpH5Zx6pJXeZWwXZ+cuT7OfJ+Lzltzt/LgcZ3j3AmjCWLK8P83a8CsA4MgtCEB1qmYkoDcZU
 PFG/I9uo19EefYJpPqG8/dsBRb1DbpBY562LlpJUGakBw0xH6W/MNoGodRY5SpAV/1TParUC2o
 eN9R/6jRg9ICIo9qLPKkNeXnLRdRssdGiZdaGdzHDJ+pfb2j4LF3ehYPSBGXuMe2i7E8HlQMmR
 hkA=
X-IronPort-AV: E=McAfee;i="6000,8403,9501"; a="9405482"
X-IronPort-AV: E=Sophos;i="5.70,323,1574089200"; 
   d="scan'208";a="9405482"
Received: from mail-os2jpn01lp2055.outbound.protection.outlook.com (HELO
 JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.55])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2020 09:55:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CudERjj1B9PYWKz64B59UcdYTZXSOrTZI6JhEMEE+KbtJP5sKdEOKFRRRjscC2mrp5m2g8KaEmqE2JsCp1I0ydBbLhh7zVRS+L1j1Iffa5lkm8Zw4Vi9VbdV35iprLhABV8rmH5dFUL1dutVVaPJ/F9jkT+Xz/7xkZJmdOM54Ikkm9XcY1hcuwIKEi8o2j8wjySL9AXagftoh8q4QYJPMrFXD6D8z6oq9o1lLOsO8DKS5DNaLXjfugXA+nTyapDPv+xtligL0/NjKpJCOzzrGms8hmnIhJ4SNdw+5N/hw0JuDWMPlL1ow+ERXsXgCMrs00f9Ioh1MdUTby5XbG/pRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Yf+fZ4mCg9/whppBYdP24EDDYJlXCj7kybGpS68cP4=;
 b=ZIxQHi/y+k6ipsG7pH4MFC1DlNbLpSJGp5KOEMJOnPsch8BycqExh/jKu8Y8VeVEVjP8du9P2SJyMj3MTpkWDb9FbYlrzGIAa1S9670SROCNQ2RhHoM4EloCTEYzFrUopHuSsvop/TNFcIiT7Xc6tuw71Z1QIGsERbGMZn0HtnibWF8GCzYVrNUKFc875Yzli36mgQEaWZtJh6IZlLrlLIwJ5UZe8TbjmmPFuZamiHB33nbRPcp1dWuJYWScT8VmYBRmD7UR3iM+DB6fjY5/38SA5AmGwWt4WyddzDGTzeBsbOQ0YEaK83hLoOg/D2KJL5OXp7cxMoMhOpZhHyojCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Yf+fZ4mCg9/whppBYdP24EDDYJlXCj7kybGpS68cP4=;
 b=jy8kTh3SM5lz8GelkHlUlSDPkkm8tTsSQMTe6kw3ttQmQgcUcWzvZWK+g82+525pvUyAQF2dkDOBazT5hDkSCeWabHZSkrwYeJEgE0ZyDqBdFUpqapjgz8bGY69RQpFg2iwg3dOgQPfEvbx9MEtvs6M2BxjbDzsaVVydUlOiq0g=
Received: from OSBPR01MB4582.jpnprd01.prod.outlook.com (20.179.181.21) by
 OSBPR01MB4805.jpnprd01.prod.outlook.com (20.179.182.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Thu, 16 Jan 2020 00:55:34 +0000
Received: from OSBPR01MB4582.jpnprd01.prod.outlook.com
 ([fe80::1127:602f:66e2:ba38]) by OSBPR01MB4582.jpnprd01.prod.outlook.com
 ([fe80::1127:602f:66e2:ba38%4]) with mapi id 15.20.2623.017; Thu, 16 Jan 2020
 00:55:34 +0000
From: "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
To: "'Dr. David Alan Gilbert'" <dgilbert@redhat.com>
Subject: RE: [PATCH 084/104] Virtiofsd: fix memory leak on fuse queueinfo
Thread-Topic: [PATCH 084/104] Virtiofsd: fix memory leak on fuse queueinfo
Thread-Index: AQHVy5Sip5x02RmsOEiCFdeq59uyeafr8oAAgACD55A=
Date: Thu, 16 Jan 2020 00:54:24 +0000
Deferred-Delivery: Thu, 16 Jan 2020 00:55:24 +0000
Message-ID: <OSBPR01MB4582846F726005E9405A84C2E5360@OSBPR01MB4582.jpnprd01.prod.outlook.com>
References: <20191212163904.159893-85-dgilbert@redhat.com>
 <20200115112006.32659-1-misono.tomohiro@jp.fujitsu.com>
 <20200115165712.GE3811@work-vm>
In-Reply-To: <20200115165712.GE3811@work-vm>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckermailid: dfc70c58aecc4cc297d3bfd1412c569a
x-securitypolicycheck: OK by SHieldMailChecker v2.6.3
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=misono.tomohiro@fujitsu.com; 
x-originating-ip: [210.170.118.190]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 392dd01a-9802-44ca-7998-08d79a1ecb50
x-ms-traffictypediagnostic: OSBPR01MB4805:
x-microsoft-antispam-prvs: <OSBPR01MB4805BA3FEEE4136B3D0C78BDE5360@OSBPR01MB4805.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(189003)(199004)(7696005)(85182001)(33656002)(8936002)(478600001)(66476007)(66556008)(55016002)(5660300002)(6916009)(6666004)(81156014)(64756008)(66446008)(52536014)(4326008)(6506007)(8676002)(316002)(54906003)(71200400001)(66946007)(186003)(26005)(86362001)(81166006)(2906002)(9686003)(76116006)(777600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:OSBPR01MB4805;
 H:OSBPR01MB4582.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KmLx9TA2Pzhj1LpXUvF2uKqE86Yt61dMV+o2R80k2lEB7zdLOvu048Z9ZTN+jUU43FN2TwNQgbo8cptevGWB4fdw8xYaU2v7xnMmjJedZgkclBVoUIJv8EDmeLThWeFZhFDKLG9mPJDz+axasqb2Bc3g3FYmJKGsNwLXf8bnimWOx2uJzKT9xoqyRGWDZJYkUkVhOjPOZ0gETu9qX9Lf/ctJMzDoPNaYXka6ct+QCeqVvuwnvm7wuUizI1iHpfhbxXumfW68Dg+cMr2ICPFEEFPglHbiR7iThMGKcf44CycU3DifFwxa7jc8eoISArQj+PKfAPdgi1FE3hEiUUNco1boPLCWq7WoxqM+eOKfUXX0j6R0ByWKrGksZWD5TLo40x1RwUOQz8jUfGSZsZt4xEy04HZrILabSx51wiu6zYN3Ilm8p5mrfZR0SaJGuG0HSHKcw3VWLDm0Qi2pm21WHo/iMpiY1k2Sr7zbrdqVvDuJvmcY1HGfJVsIbg0OKX4a
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 392dd01a-9802-44ca-7998-08d79a1ecb50
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 00:55:34.6280 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0k6wnIHdwNqN/JviFG/1QdtFoHvp6EEFwkhdXgtIIcrPSAq7HA3UsLbtd7IzPdPQ2cs6YQSEVeVwbsWRtRF75TZbUqAC+ijBf8L5IT8VOKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4805
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.156.101
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "vgoyal@redhat.com" <vgoyal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> * Misono Tomohiro (misono.tomohiro@jp.fujitsu.com) wrote:
> > > From: Liu Bo <bo.liu@linux.alibaba.com>
> > >
> > > For fuse's queueinfo, both queueinfo array and queueinfos are
> > > allocated in
> > > fv_queue_set_started() but not cleaned up when the daemon process qui=
ts.
> > >
> > > This fixes the leak in proper places.
> > >
> > > Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
> > > Signed-off-by: Eric Ren <renzhen@linux.alibaba.com>
> > > ---
> > >  tools/virtiofsd/fuse_virtio.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/tools/virtiofsd/fuse_virtio.c
> > > b/tools/virtiofsd/fuse_virtio.c index 7b22ae8d4f..a364f23d5d 100644
> > > --- a/tools/virtiofsd/fuse_virtio.c
> > > +++ b/tools/virtiofsd/fuse_virtio.c
> > > @@ -671,6 +671,8 @@ static void fv_queue_set_started(VuDev *dev, int =
qidx, bool started)
> > >          }
> > >          close(ourqi->kill_fd);
> > >          ourqi->kick_fd =3D -1;
> > > +        free(vud->qi[qidx]);
> > > +        vud->qi[qidx] =3D NULL;
> > >      }
> > >  }
> > >
> > > @@ -878,6 +880,13 @@ int virtio_session_mount(struct fuse_session
> > > *se)  void virtio_session_close(struct fuse_session *se)  {
> > >      close(se->vu_socketfd);
> >
> > I beleve above close() should be removed as it is called 6 line below.
>=20
> You're right, I think that's my fault from when I merged this patch with =
'Virtiofsd: fix segfault when quit before dev init'.
>=20
> Fixed.

Given that:
 Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>

Thanks.

> Thanks.
>=20
> Dave
>=20
> > > +
> > > +    if (!se->virtio_dev) {
> > > +        return;
> > > +    }
> > > +
> > > +    close(se->vu_socketfd);
> > > +    free(se->virtio_dev->qi);
> > >      free(se->virtio_dev);
> > >      se->virtio_dev =3D NULL;
> > >  }
> > > --
> > > 2.23.0
> >
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


