Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944E1CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 10:10:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F59420830
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 10:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fujitsu.onmicrosoft.com header.i=@fujitsu.onmicrosoft.com header.b="WscZu5ba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F59420830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPOSD-00017g-Ei
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 06:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1iPOR1-0000Lh-7y
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:09:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1iPOQy-0000Lp-Ux
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:09:06 -0400
Received: from esa17.fujitsucc.c3s2.iphmx.com ([216.71.158.34]:14558)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1iPOQy-0000GJ-Hg
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:09:04 -0400
IronPort-SDR: E9SfGs9a+egdV8jDiSMq22ipmqi7x/Tipn1B0b/E7AguphAg1MbvBwOFLfX0cN7Bplz+oh4Tse
 i43sOoYGu2/YfMoCycIW66u4yC+5VfHEZS2hIxAm7WKgXHq0g8F0+LKXSqaZVyjt2qMyHHo+0T
 nMQ6PONuTtuCO77bGH1/bIY1l01oFvESNKLYMkUAwMuic0C6jW2IjCVowFA1ecQRgjlbHGHda0
 flEaZBpToS/IIchyUygBm2xY8+9HOql+5OifqVPRr6uUE6ywxYtKK6pkAkOhRwPXQu2/ZdZBxJ
 7Nk=
X-IronPort-AV: E=McAfee;i="6000,8403,9424"; a="7203759"
X-IronPort-AV: E=Sophos;i="5.68,243,1569250800"; 
   d="scan'208";a="7203759"
Received: from mail-os2jpn01lp2056.outbound.protection.outlook.com (HELO
 JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.56])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA384;
 29 Oct 2019 19:08:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHZd2trVb+Jun98yyAxdE40aVbQ+wqmjhLgRT63bVcDVp4iHjJbA7/G2xYEkbvUxz1lbafSFT/Rv+/Q0ErobSRkyUN0RUYPgSsr7Hy+z82Qre73MpH0RqikAgrB6QmwQb9fcmtK2PtyCqLVlO3gvvHkq2lvMq6LmayxxwB56YMew/igC6qhDEWrSlhp2vfnf2d6tAQiXKdQpRHFYWgtfM6KsrrKcBmCbNS+DZ7sgUZkFIbpzMrqBKF+1HAfA+YYb3ugafrtU+aEXxwWNPTQVmU/UZ+faFK38x9lYo/zIX5U2z711e5pkutK8LYZJZwliK84dFiAR4+LUytPdkpCqQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mriqFQuu221J4VBkZbXKWCeYAtB6hs4p7RT8P4hNADs=;
 b=Q61BG5veczPpGAmwpu0na3gwfseLimL/fskKSaIGHeF9pkfDZl51QTE085t0jGSpHeIzEwG/6qh/f6AF2C5KPeajkDlSnYXgp9QXUCx/N6aCFHwJ80UiAce4qEJ8cDcvrBMlL6MdeqqvjSHFo7JBiJN0vvGMAza34yuk91xD46/5JtcqplFbvI7o3Kr3wKbaYDmmQTqJfIMC8BrMdhWvv4SdFz4KkzgJM7sRKeJNU1n90tkQGmQfBoo5vHG4lk94GQxTH+GnUq3LnGgRk6BKaS6iQkc576ILiQH2GGZoUFfFZWFHhyvQ0LPSL7Vsj4HLO6Y0E8EbZ21Fcp4s71EHLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mriqFQuu221J4VBkZbXKWCeYAtB6hs4p7RT8P4hNADs=;
 b=WscZu5baOZdcvRMNooJzPj726XytkHaZWHY17HyzBtrdsPPvgzDL6df6dd72FIQ5BDQ16XTVQCiVX7yqVY1Adk9ruSvfKBBv6GPEfZ9K/IDakpSumwQ5A11aWpA9jFQgmGTfhuwwTQH40IPV9gVdcM2jPcYPrxSo+W2KMxXrrhk=
Received: from OSBPR01MB3783.jpnprd01.prod.outlook.com (20.178.96.203) by
 OSBPR01MB2440.jpnprd01.prod.outlook.com (52.134.254.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Tue, 29 Oct 2019 10:08:53 +0000
Received: from OSBPR01MB3783.jpnprd01.prod.outlook.com
 ([fe80::4cef:c2a5:21f3:9f3c]) by OSBPR01MB3783.jpnprd01.prod.outlook.com
 ([fe80::4cef:c2a5:21f3:9f3c%5]) with mapi id 15.20.2387.023; Tue, 29 Oct 2019
 10:08:53 +0000
From: "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
To: "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>, 'Vivek Goyal'
 <vgoyal@redhat.com>
Subject: RE: [Virtio-fs] [PATCH] virtiofsd: Fix data corruption with O_APPEND
 wirte in writeback mode
Thread-Topic: [Virtio-fs] [PATCH] virtiofsd: Fix data corruption with O_APPEND
 wirte in writeback mode
Thread-Index: AQHViZvpLbfW+G+A2EG+Hrhspumg2Kdop+EAgAE8/oCAAT3lEIAGLehA
Date: Tue, 29 Oct 2019 10:07:49 +0000
Deferred-Delivery: Tue, 29 Oct 2019 10:08:48 +0000
Message-ID: <OSBPR01MB37833C9325AD3D9190108FAEE5610@OSBPR01MB3783.jpnprd01.prod.outlook.com>
References: <20191023122523.1816-1-misono.tomohiro@jp.fujitsu.com>
 <20191023200752.GB6942@redhat.com> <20191024150225.GB6903@redhat.com>
 <OSBPR01MB3783EBE1BB481BD1B14B8D45E5650@OSBPR01MB3783.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB3783EBE1BB481BD1B14B8D45E5650@OSBPR01MB3783.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 1672c1ef385a4f42b2ae57bf49481b15
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=misono.tomohiro@fujitsu.com; 
x-originating-ip: [210.162.184.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20e381eb-34c7-497c-c395-08d75c5800e3
x-ms-traffictypediagnostic: OSBPR01MB2440:|OSBPR01MB2440:
x-ms-exchange-transport-forked: True
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <OSBPR01MB24404463939906750BE264C1E5610@OSBPR01MB2440.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(13464003)(199004)(189003)(486006)(6666004)(53546011)(6436002)(110136005)(229853002)(54906003)(6506007)(66476007)(66066001)(14454004)(966005)(478600001)(66556008)(64756008)(11346002)(446003)(66946007)(66446008)(14444005)(316002)(476003)(2906002)(5660300002)(9686003)(6306002)(71200400001)(6246003)(71190400001)(55016002)(256004)(4326008)(6116002)(3846002)(76116006)(85182001)(99286004)(76176011)(186003)(26005)(102836004)(8676002)(33656002)(81166006)(74316002)(86362001)(8936002)(7696005)(7736002)(52536014)(305945005)(25786009)(81156014)(777600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:OSBPR01MB2440;
 H:OSBPR01MB3783.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: INwru4Gbys8SAcUo/qEJMDH7pSfAgi/B4kUTcBrzxuSjWrnD+P2P6QG2MN2NBaBQ5gCX6GlPZQAPN0izmhWOl/fDxeOjAo2cCgQFWm7rPTG+ovcPZoFHxAW1qWu/QIIGNaq5Na8JPeRJZtquy5vkgmBo83k4NISmoMtLcfDmuh+SBBcKm2FnNY8xMbLWZ9YQ/7HK7v584vB99rOtHIyoiYCSVPMNaOmW7hhiBRdYFTLuMO6egfxjMbgbo797fs+V9eUTraiMaYj+f07F/w9vy0ZK3dc6Lbz0ayA4hK33GZVgMce1EGNo4FK6+qsQ+R0u52ARxnzAdUr4OevTDDdTCqKLmvUlSa8E6zTDNUFQmVdV6XguKidvbtt7o6Tr0yWUCnjoJbWIZ/F7QHCfe9pliI/4Zf2xRqZXz6AUUIBfBavYqe/2Te7bk/z3AA2sdczDfmVvWLuOCVgH5hKtFizaQDZ09l5cWyN19Ze8k3mPX/M=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e381eb-34c7-497c-c395-08d75c5800e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 10:08:53.7199 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iFKambYAwpnsrmiDaZPtgZJwvuHguJVrQzGQypuJci/vCpjSSl5c2yIYhsGlTjAS+NgQj/dcJQdzH2Ksduea6dX/hFoWzdk7Z+Bt3/QZg5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2440
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.158.34
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
Cc: "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: virtio-fs-bounces@redhat.com [mailto:virtio-fs-bounces@redhat.com] =
On Behalf Of misono.tomohiro@fujitsu.com
> Sent: Friday, October 25, 2019 7:02 PM
> To: 'Vivek Goyal' <vgoyal@redhat.com>
> Cc: virtio-fs@redhat.com; qemu-devel@nongnu.org
> Subject: Re: [Virtio-fs] [PATCH] virtiofsd: Fix data corruption with O_AP=
PEND wirte in writeback mode
>=20
> > On Wed, Oct 23, 2019 at 04:07:52PM -0400, Vivek Goyal wrote:
> > > On Wed, Oct 23, 2019 at 09:25:23PM +0900, Misono Tomohiro wrote:
> > > > When writeback mode is enabled (-o writeback), O_APPEND handling
> > > > is done in kernel. Therefore virtiofsd clears O_APPEND flag when op=
en.
> > > > Otherwise O_APPEND flag takes precedence over pwrite() and write
> > > > data may corrupt.
> > > >
> > > > Currently clearing O_APPEND flag is done in lo_open(), but we also
> > > > need the same operation in lo_create().
> > >
> > > > So, factor out the flag
> > > > update operation in lo_open() to update_open_flags() and call it
> > > > in both lo_open() and lo_create().
> > > >
> > > > This fixes the failure of xfstest generic/069 in writeback mode
> > > > (which tests O_APPEND write data integrity).
> > > >
> >
> > Hi Misono,
> >
> > Have you tried running pjdfstests. Looks like with the patch applied I
> > see following tests failing which were passing without the patch. Can y=
ou please have a look. I ran daemon with options "-o
> cache=3Dalways -o writeback"

I see these errors in both with and without this patch but not always.
Do you always see the failure?

I use:
  Kernel: Fuse's for-next branch
  Qemu: virtio-fs-dev branch
  backend: XFS (relatime)

These tests fail because a/c/m time is not updated as expected.
So it seems this is related to the failure of xfstest generic/003.
I will look into the problem more.

Thanks,
Misono

>=20
> >
> > /root/git/pjdfstest/tests/chmod/00.t          (Wstat: 0 Tests: 119 Fail=
ed: 1)
> >   Failed test:  64
> > /root/git/pjdfstest/tests/chown/00.t          (Wstat: 0 Tests: 1323 Fai=
led: 1)
> >   Failed test:  946
> >   TODO passed:   1107, 1112, 1116, 1122, 1127, 1131, 1137
> >                 1142, 1146, 1152, 1157, 1161, 1167, 1172
> >                 1176, 1182, 1187
> > /root/git/pjdfstest/tests/link/00.t           (Wstat: 0 Tests: 202 Fail=
ed: 1)
> >   Failed test:  134
> > /root/git/pjdfstest/tests/utimensat/01.t      (Wstat: 0 Tests: 7 Failed=
: 1)
> >   Failed test:  4
> > Files=3D232, Tests=3D8789, 375 wallclock secs ( 4.00 usr  2.65 sys + 51=
.48
> > cusr 262.19 csys =3D 320.32 CPU) Thanks Vivek
> >
> > >
> > > Hi,
> > >
> > > Consolidating updation of flags both for lo_create() and lo_open()
> > > makes sense to me. I will test it tomorrow.
> > >
> > > Thanks
> > > Vivek
> > >
> > > > Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
> > > > ---
> > > >  contrib/virtiofsd/passthrough_ll.c | 56
> > > > +++++++++++++++---------------
> > > >  1 file changed, 28 insertions(+), 28 deletions(-)
> > > >
> > > > diff --git a/contrib/virtiofsd/passthrough_ll.c
> > > > b/contrib/virtiofsd/passthrough_ll.c
> > > > index e8892c3c32..79fb78ecce 100644
> > > > --- a/contrib/virtiofsd/passthrough_ll.c
> > > > +++ b/contrib/virtiofsd/passthrough_ll.c
> > > > @@ -1733,6 +1733,32 @@ static void lo_releasedir(fuse_req_t req, fu=
se_ino_t ino, struct fuse_file_info
> > > >  	fuse_reply_err(req, 0);
> > > >  }
> > > >
> > > > +static void update_open_flags(int writeback, struct
> > > > +fuse_file_info
> > > > +*fi) {
> > > > +	/* With writeback cache, kernel may send read requests even
> > > > +	   when userspace opened write-only */
> > > > +	if (writeback && (fi->flags & O_ACCMODE) =3D=3D O_WRONLY) {
> > > > +		fi->flags &=3D ~O_ACCMODE;
> > > > +		fi->flags |=3D O_RDWR;
> > > > +	}
> > > > +
> > > > +	/* With writeback cache, O_APPEND is handled by the kernel.
> > > > +	   This breaks atomicity (since the file may change in the
> > > > +	   underlying filesystem, so that the kernel's idea of the
> > > > +	   end of the file isn't accurate anymore). In this example,
> > > > +	   we just accept that. A more rigorous filesystem may want
> > > > +	   to return an error here */
> > > > +	if (writeback && (fi->flags & O_APPEND))
> > > > +		fi->flags &=3D ~O_APPEND;
> > > > +
> > > > +	/*
> > > > +	 * O_DIRECT in guest should not necessarily mean bypassing page
> > > > +	 * cache on host as well. If somebody needs that behavior, it
> > > > +	 * probably should be a configuration knob in daemon.
> > > > +	 */
> > > > +	fi->flags &=3D ~O_DIRECT;
> > > > +}
> > > > +
> > > >  static void lo_create(fuse_req_t req, fuse_ino_t parent, const cha=
r *name,
> > > >  		      mode_t mode, struct fuse_file_info *fi)  { @@ -1760,12
> > > > +1786,7 @@ static void lo_create(fuse_req_t req, fuse_ino_t
> > > > +parent, const char *name,
> > > >  	if (err)
> > > >  		goto out;
> > > >
> > > > -	/*
> > > > -	 * O_DIRECT in guest should not necessarily mean bypassing page
> > > > -	 * cache on host as well. If somebody needs that behavior, it
> > > > -	 * probably should be a configuration knob in daemon.
> > > > -	 */
> > > > -	fi->flags &=3D ~O_DIRECT;
> > > > +	update_open_flags(lo->writeback, fi);
> > > >
> > > >  	fd =3D openat(parent_inode->fd, name,
> > > >  		    (fi->flags | O_CREAT) & ~O_NOFOLLOW, mode); @@ -1966,28
> > > > +1987,7 @@ static void lo_open(fuse_req_t req, fuse_ino_t ino,
> > > > struct fuse_file_info *fi)
> > > >
> > > >  	fuse_log(FUSE_LOG_DEBUG, "lo_open(ino=3D%" PRIu64 ", flags=3D%d)\=
n",
> > > > ino, fi->flags);
> > > >
> > > > -	/* With writeback cache, kernel may send read requests even
> > > > -	   when userspace opened write-only */
> > > > -	if (lo->writeback && (fi->flags & O_ACCMODE) =3D=3D O_WRONLY) {
> > > > -		fi->flags &=3D ~O_ACCMODE;
> > > > -		fi->flags |=3D O_RDWR;
> > > > -	}
> > > > -
> > > > -	/* With writeback cache, O_APPEND is handled by the kernel.
> > > > -	   This breaks atomicity (since the file may change in the
> > > > -	   underlying filesystem, so that the kernel's idea of the
> > > > -	   end of the file isn't accurate anymore). In this example,
> > > > -	   we just accept that. A more rigorous filesystem may want
> > > > -	   to return an error here */
> > > > -	if (lo->writeback && (fi->flags & O_APPEND))
> > > > -		fi->flags &=3D ~O_APPEND;
> > > > -
> > > > -	/*
> > > > -	 * O_DIRECT in guest should not necessarily mean bypassing page
> > > > -	 * cache on host as well. If somebody needs that behavior, it
> > > > -	 * probably should be a configuration knob in daemon.
> > > > -	 */
> > > > -	fi->flags &=3D ~O_DIRECT;
> > > > +	update_open_flags(lo->writeback, fi);
> > > >
> > > >  	sprintf(buf, "%i", lo_fd(req, ino));
> > > >  	fd =3D openat(lo->proc_self_fd, buf, fi->flags & ~O_NOFOLLOW);
> > > > --
> > > > 2.21.0
> > > >
> > > > _______________________________________________
> > > > Virtio-fs mailing list
> > > > Virtio-fs@redhat.com
> > > > https://www.redhat.com/mailman/listinfo/virtio-fs
> > >
> > > _______________________________________________
> > > Virtio-fs mailing list
> > > Virtio-fs@redhat.com
> > > https://www.redhat.com/mailman/listinfo/virtio-fs
>=20
>=20
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://www.redhat.com/mailman/listinfo/virtio-fs


