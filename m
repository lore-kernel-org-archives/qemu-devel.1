Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59E7C33CAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 00:50:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AA1820728
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 00:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fujitsu.onmicrosoft.com header.i=@fujitsu.onmicrosoft.com header.b="q88BUBuY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA1820728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isFqH-0006MF-Rb
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 19:50:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38702)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1isFob-0004TQ-C4
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 19:48:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1isFoY-0006wN-JM
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 19:48:44 -0500
Received: from esa11.fujitsucc.c3s2.iphmx.com ([216.71.156.121]:8622)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1isFoY-0006td-7a
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 19:48:42 -0500
IronPort-SDR: aniyOas3O/1K0mnYN/AttcuzMlwrDfbfxA42RMSIuvbEAGghpPrb+1QxMKCovjZRQQc8wAj9bp
 mzVJjLS8jKXUzCbZw8tajyZmErmef0MCKZdtFc8tuo1Aari2NI6ZLoBCFQytf8z2jSKa0OP67J
 4uBn4GjouX6ESVZjRds0eyPUB3mQS/cjJhonnTG3TE+DXa11co9YQuD9kon0XqVxbyTi5enSXf
 Q6ErNG8J0yFynRzbXyDkjui8CJXw+v0RFvJVbqZfy842nunB39uaZgvjpgHgI4EvlH9y1kCDdU
 n2c=
X-IronPort-AV: E=McAfee;i="6000,8403,9502"; a="9504688"
X-IronPort-AV: E=Sophos;i="5.70,327,1574089200"; 
   d="scan'208";a="9504688"
Received: from mail-os2jpn01lp2057.outbound.protection.outlook.com (HELO
 JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.57])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jan 2020 09:48:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CB4cFhC70tmHs7JLdL/eBOfzP7PxAHPXIouZ4iN1y5qUjvBCxlvCEx806msJNkqmJYOlOff4KwzVncL7afHyZyeDs2kyN+njBPAgBtlkq1sqzXK6JmrYZ63fB8HTlfugo9su9yAwcdgPmDRjZ1p+YZ+zFWbW5VZjTIbcKFPjKC93TPIuAmezBI2euIy9lHgApr00kwXg4M37C9RURn8jl4ApOQCQsrBOnTvPhUGuKILsqEtv5EQjYF0/L6fSEgm882euwOeXdLOnbrqO3sedPnd2rn5TL7K6T6fBsOVpmZgjXBYmY2sgVDTQhDRz4f6H5qu6tegmHainhr5ousF57g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzp4iL79DlZGZgRRiJiH19TX8Q+X/zlch25ARh1t6oI=;
 b=EkFpcAcR881Pje6v1yZ7mwEBosF5opqMLB/jc6IyEwSAXIaWt2FBKCl2PfQPX7/CRZocNybDYaM8dR3XwXy5uXuQHDE2WRVAJUphpqCIrD1D8/WDnGbC3nXDFOB0Qv/wNegmw69lRehidI9FnOJ9lEh+NeOiIZZVxz6lyDbd+rBXfUx6dTarYIaQbr5csr6BYEKve3vHaeRXO5Cj7BpSR6ZV8CyuCn2HHRJquJyVlboqOsS3EMHSiCljPtVYmy4etwE+29gC09ayIH0R8AS9IsX8z82IgzbGxF61ne5E3Kb+kpZG6aiqWM3SumWWrBmA3lAnRbfyy1Y3026h+znZpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzp4iL79DlZGZgRRiJiH19TX8Q+X/zlch25ARh1t6oI=;
 b=q88BUBuYXBce+3WVgTurGeT2L7Y8Vn/P2uLO912JPAXNxMndKa7RXP20IU6cd1LYSN7ViIn1RIDKftmLBJa/O5ZOime0Izs8KqRGJqjAqC0ZjHSaTTqrM+t+GYCHBqEV8SN/XfsaOTAb37oUL1LcbzJWslqMUTsgYLaAazA07Dg=
Received: from OSBPR01MB4582.jpnprd01.prod.outlook.com (20.179.181.21) by
 OSBPR01MB1957.jpnprd01.prod.outlook.com (52.134.241.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.22; Fri, 17 Jan 2020 00:48:34 +0000
Received: from OSBPR01MB4582.jpnprd01.prod.outlook.com
 ([fe80::1127:602f:66e2:ba38]) by OSBPR01MB4582.jpnprd01.prod.outlook.com
 ([fe80::1127:602f:66e2:ba38%4]) with mapi id 15.20.2623.017; Fri, 17 Jan 2020
 00:48:34 +0000
From: "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
To: "'Dr. David Alan Gilbert'" <dgilbert@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>
Subject: RE: [PATCH 093/104] virtiofsd: introduce inode refcount to prevent
 use-after-free
Thread-Topic: [PATCH 093/104] virtiofsd: introduce inode refcount to prevent
 use-after-free
Thread-Index: AQHVzGb5gdmHrDd+jkaq2qZ0Ngc3tqftihkAgAAF1ACAAHR7wA==
Date: Fri, 17 Jan 2020 00:47:24 +0000
Deferred-Delivery: Fri, 17 Jan 2020 00:48:24 +0000
Message-ID: <OSBPR01MB4582AEDD5EACD4DDDBB8D7B3E5310@OSBPR01MB4582.jpnprd01.prod.outlook.com>
References: <20191212163904.159893-94-dgilbert@redhat.com>
 <20200116122542.20873-1-misono.tomohiro@jp.fujitsu.com>
 <20200116172156.GA285238@stefanha-x1.localdomain>
 <20200116174248.GK3108@work-vm>
In-Reply-To: <20200116174248.GK3108@work-vm>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckermailid: 03b7ec5b772149ac9ddf7fb3df78a605
x-securitypolicycheck: OK by SHieldMailChecker v2.6.3
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=misono.tomohiro@fujitsu.com; 
x-originating-ip: [210.170.118.175]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f022f5b-0790-498e-bce7-08d79ae6fb23
x-ms-traffictypediagnostic: OSBPR01MB1957:
x-microsoft-antispam-prvs: <OSBPR01MB19575C0223212E188E2FAC10E5310@OSBPR01MB1957.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(189003)(199004)(8676002)(478600001)(4326008)(81156014)(6666004)(64756008)(66946007)(66446008)(66556008)(2906002)(81166006)(66476007)(76116006)(186003)(316002)(8936002)(110136005)(54906003)(4001150100001)(85182001)(26005)(5660300002)(55016002)(52536014)(86362001)(71200400001)(9686003)(6506007)(33656002)(966005)(7696005)(777600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:OSBPR01MB1957;
 H:OSBPR01MB4582.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PwBWYdyRPtQIlq6pgGPZJBXLVTEcK2szycTratMfktNAdIe5jmg4M6r5NNcSrn9OFNGIr91N/c1YI9nNHHzNVoFQCe3ZX4nGlNtKnUDVctyqeFuvmogB0XFVgcPZAlMMGLHR3U4cIwM1RfOzwByFZCuWfTnRIErftPgiktlLPg0ssdCtgG2lwAVg9DcD+aH/T+8+iR5d5NDHBt5j28T2JwC/+2VfuczJldgBB/LXzLuoNXzRKnku0vKgD4vNFm1IJ+hPwtL4vPWaQXUvA99gTqDcLpMJJQ96hAja67Bshjqi2RhzKN/ytnSf3boDqhNwNJFVAZkjsAxIMfNsSL9Zn6Cf3pDN94JJfuHMCLvwzRlbMbO8BVuqYfuWJiW3ILR/bjt6tG+gDUCNjnl1ALOxEVlOEsyi0ZBDLrRcXBEIMZt28RGg+1XJIX3DVNpS1rHzyesL0Gixal09f8wUtV+1HeicPnPmnRsq4GxwqoFJeCI+MmzCm5HqxlW48L0NdRHq+3ck7dJ9Us7772E1gxA+j1+88946s4ZySDmZ5KY1N80=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f022f5b-0790-498e-bce7-08d79ae6fb23
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 00:48:34.1774 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bkfiBoMp64jR8qvIEmko+WerztPeVMAQckrrp5iVgT8b+fJU8L1I6ys8h2ZoSRFb3G5Is7acMNu2PXERT67JgxgyOUV7hPZEN73NGlLzPZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1957
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.156.121
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
 "vgoyal@redhat.com" <vgoyal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > On Thu, Jan 16, 2020 at 09:25:42PM +0900, Misono Tomohiro wrote:
> > > > From: Stefan Hajnoczi <stefanha@redhat.com>
> > > >
> > > > If thread A is using an inode it must not be deleted by thread B
> > > > when processing a FUSE_FORGET request.
> > > >
> > > > The FUSE protocol itself already has a counter called nlookup that
> > > > is used in FUSE_FORGET messages.  We cannot trust this counter
> > > > since the untrusted client can manipulate it via FUSE_FORGET messag=
es.
> > > >
> > > > Introduce a new refcount to keep inodes alive for the required life=
span.
> > > > lo_inode_put() must be called to release a reference.  FUSE's
> > > > nlookup counter holds exactly one reference so that the inode
> > > > stays alive as long as the client still wants to remember it.
> > > >
> > > > Note that the lo_inode->is_symlink field is moved to avoid
> > > > creating a hole in the struct due to struct field alignment.
> > > >
> > > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > ---
> > > >  tools/virtiofsd/passthrough_ll.c | 168
> > > > ++++++++++++++++++++++++++-----
> > > >  1 file changed, 145 insertions(+), 23 deletions(-)
> > > >
> > > > diff --git a/tools/virtiofsd/passthrough_ll.c
> > > > b/tools/virtiofsd/passthrough_ll.c
> > > > index b19c9ee328..8f4ab8351c 100644
> > > > --- a/tools/virtiofsd/passthrough_ll.c
> > > > +++ b/tools/virtiofsd/passthrough_ll.c
> > > > @@ -99,7 +99,13 @@ struct lo_key {
> > > >
> > > >  struct lo_inode {
> > > >      int fd;
> > > > -    bool is_symlink;
> > > > +
> > > > +    /*
> > > > +     * Atomic reference count for this object.  The nlookup field =
holds a
> > > > +     * reference and release it when nlookup reaches 0.
> > > > +     */
> > > > +    gint refcount;
> > > > +
> > > >      struct lo_key key;
> > > >
> > > >      /*
> > > > @@ -118,6 +124,8 @@ struct lo_inode {
> > > >      fuse_ino_t fuse_ino;
> > > >      pthread_mutex_t plock_mutex;
> > > >      GHashTable *posix_locks; /* protected by
> > > > lo_inode->plock_mutex */
> > > > +
> > > > +    bool is_symlink;
> > > >  };
> > > >
> > > >  struct lo_cred {
> > > > @@ -473,6 +481,23 @@ static ssize_t lo_add_inode_mapping(fuse_req_t=
 req, struct lo_inode *inode)
> > > >      return elem - lo_data(req)->ino_map.elems;  }
> > > >
> > > > +static void lo_inode_put(struct lo_data *lo, struct lo_inode
> > > > +**inodep) {
> > > > +    struct lo_inode *inode =3D *inodep;
> > > > +
> > > > +    if (!inode) {
> > > > +        return;
> > > > +    }
> > > > +
> > > > +    *inodep =3D NULL;
> > > > +
> > > > +    if (g_atomic_int_dec_and_test(&inode->refcount)) {
> > > > +        close(inode->fd);
> > > > +        free(inode);
> > > > +    }
> > > > +}
> > > > +
> > > > +/* Caller must release refcount using lo_inode_put() */
> > > >  static struct lo_inode *lo_inode(fuse_req_t req, fuse_ino_t ino)
> > > > {
> > > >      struct lo_data *lo =3D lo_data(req); @@ -480,6 +505,9 @@ stati=
c
> > > > struct lo_inode *lo_inode(fuse_req_t req, fuse_ino_t ino)
> > > >
> > > >      pthread_mutex_lock(&lo->mutex);
> > > >      elem =3D lo_map_get(&lo->ino_map, ino);
> > > > +    if (elem) {
> > > > +        g_atomic_int_inc(&elem->inode->refcount);
> > > > +    }
> > > >      pthread_mutex_unlock(&lo->mutex);
> > > >
> > > >      if (!elem) {
> > > > @@ -489,10 +517,23 @@ static struct lo_inode *lo_inode(fuse_req_t r=
eq, fuse_ino_t ino)
> > > >      return elem->inode;
> > > >  }
> > > >
> > > > +/*
> > > > + * TODO Remove this helper and force callers to hold an inode
> > > > +refcount until
> > > > + * they are done with the fd.  This will be done in a later patch
> > > > +to make
> > > > + * review easier.
> > > > + */
> > > >  static int lo_fd(fuse_req_t req, fuse_ino_t ino)  {
> > > >      struct lo_inode *inode =3D lo_inode(req, ino);
> > > > -    return inode ? inode->fd : -1;
> > > > +    int fd;
> > > > +
> > > > +    if (!inode) {
> > > > +        return -1;
> > > > +    }
> > > > +
> > > > +    fd =3D inode->fd;
> > > > +    lo_inode_put(lo_data(req), &inode);
> > > > +    return fd;
> > > >  }
> > > >
> > > >  static void lo_init(void *userdata, struct fuse_conn_info *conn)
> > > > @@ -547,6 +588,10 @@ static void lo_getattr(fuse_req_t req, fuse_in=
o_t ino,
> > > >      fuse_reply_attr(req, &buf, lo->timeout);  }
> > > >
> > > > +/*
> > > > + * Increments parent->nlookup and caller must release refcount
> > > > +using
> > > > + * lo_inode_put(&parent).
> > > > + */
> > > >  static int lo_parent_and_name(struct lo_data *lo, struct lo_inode =
*inode,
> > > >                                char path[PATH_MAX], struct
> > > > lo_inode **parent)  { @@ -584,6 +629,7 @@ retry:
> > > >          p =3D &lo->root;
> > > >          pthread_mutex_lock(&lo->mutex);
> > > >          p->nlookup++;
> > > > +        g_atomic_int_inc(&p->refcount);
> > > >          pthread_mutex_unlock(&lo->mutex);
> > > >      } else {
> > > >          *last =3D '\0';
> > >
> > > We need lo_ionde_put() in error path, right?:
> > > https://gitlab.com/virtio-fs/qemu/blob/virtio-fs-as-posted-2019-12-1
> > > 2/tools/virtiofsd/passthrough_ll.c#L680
> >
> > Yes, thanks for spotting this bug!  The lo_parent_and_name() code
> > should look like this:
> >
> >   fail_unref:
> >       unref_inode_lolocked(lo, p, 1);
> >       lo_inode_put(lo, &p);
> >   ...
>=20
> I've merged that one in.

Thanks, so with that:
 Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>

>=20
> > > nit: if yes, unref_inode_lolocked() is always paired with lo_inode_pu=
t().
> > > So how about combine them in one function? As p->nloockup and
> > > p->refcount are both incremented in one place
> > > (lo_find/lo_parent_and_name) in these case, it seems natural for me t=
o decrement them in one function as well.
> >
> > Nice idea.  I would also drop the nlookup argument - this function
> > will only be used with nlookup=3D1.
>=20
> I'll leave that to you if you want to send a patch on top.
>=20
> Dave
>=20
> > Stefan
>=20
>=20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


