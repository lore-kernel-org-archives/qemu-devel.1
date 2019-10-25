Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B0CCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:24:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5C7E20578
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fujitsu.onmicrosoft.com header.i=@fujitsu.onmicrosoft.com header.b="octTcv9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C7E20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNwls-0004y8-JW
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 06:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33177)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1iNwRU-0002Oa-2u
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1iNwRR-0006R3-PQ
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:03:35 -0400
Received: from esa20.fujitsucc.c3s2.iphmx.com ([216.71.158.65]:21702)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1iNwRQ-0006PC-R0
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:03:33 -0400
IronPort-SDR: ZjJSLw4Ik4C8Ge3U1KJBKJMED9qI1Q8ezCPtqoMSl0FqygEUgLWj4J7BVleX4VxUmmvPO7fzus
 jip9DJDG4vNmF75Sh5ackVZpcHWW0qgWYpt/dQVHvuSnf8nlTSxkud/NovRfc6X3A+6meYmbxU
 2VynjUgeUjAIrfikefRL+C5/pMRW9bN3I2BWfg3n+s+pQa6ErEI8tMKbpj1AqoJKAMA3z+QlZR
 PHqNLeIBgQsRGUFni9Kcz6cP73sZQS08S2Y47kzDzFDmQJ9jM5Vn9wEYsSzCPpjACdKufbg6o9
 nZk=
X-IronPort-AV: E=McAfee;i="6000,8403,9420"; a="7199208"
X-IronPort-AV: E=Sophos;i="5.68,228,1569250800"; 
   d="scan'208";a="7199208"
Received: from mail-os2jpn01lp2056.outbound.protection.outlook.com (HELO
 JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.56])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA384;
 25 Oct 2019 19:03:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuncTAkpXPuSLrAFO2ZG7IDVfhiuV+jCzh/CcwPofZv/P7kTyvKYQjvNcg7TJo4eBU7dcHVi0/iY/YD/ZAp6H5nihGNGnAGFduUCCjN6d+rkxBg0njH010e6GxGJPrSqaEkmNyXWlmxYAZ2153AXafgcbjfR6aLEQ272bMRpVZ4JaPRPT8qCtlnid79hrZnPEmHOtfYz4eGH8GlpkvKirAbIBF+cYz6wtDGAfxW/lV6zPsJU/hYSn/omFr9NdU7hUJug/A+KTiDRLrUrAPNRQtB59soA1krVlb2qhbghnh6dM8QLg2lMyVA9uq0r/Lt8Tc7dCWg4nM8Hil2qhi7Qfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AYpuHX1wtQ/0fFfwjO8rvZU1GAc451NIEN8ZWQ5UH4=;
 b=YTTqnkVjQp+OL4xv6QJRjZQ7ts6KpseHyk37Do466LuIcwOPqKrpOu9xga/0bfIIrxfuImjgzJHR9niB6wKQdqfjsYDJ4rZ4OJBztoQetIlW2XJzHB/ACoCVBoG37jobFZQKrrOEEjpKJpZO6NeDKE8FSfPQTEl4zkB3K06X5a0QS5y03NUAwEoKYuP+LC81pcnjsi/imYFwuZ5A40b2dOfmHAotyA4RASe3nBgvpdfkB21rXYli+biegHu0lb4RtzpCIKH/9a7hje4HyNk20sa9FU4gc2AqzBa0M70xWRMShIh2UTY4Dokq35C+pwpgAubSoxgVqi6oP4mwCXYjYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AYpuHX1wtQ/0fFfwjO8rvZU1GAc451NIEN8ZWQ5UH4=;
 b=octTcv9VcXjU6tqQBzVXPgarIsQZdDBwjleer0hjJl1r85Ic12+YRSU48LnQ4vl7UQBk8/5iMdLeP3DYDGuLeJosYjWm68X8WOjWc7NXWcygl1m7GdtaqhjCOCy//jMCCXDCu/Q5h6E55SbhZbF0IGr1n2m3GC0r4zjLSBQGuzo=
Received: from OSBPR01MB3783.jpnprd01.prod.outlook.com (20.178.96.203) by
 OSBPR01MB3848.jpnprd01.prod.outlook.com (20.178.98.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.20; Fri, 25 Oct 2019 10:03:22 +0000
Received: from OSBPR01MB3783.jpnprd01.prod.outlook.com
 ([fe80::4cef:c2a5:21f3:9f3c]) by OSBPR01MB3783.jpnprd01.prod.outlook.com
 ([fe80::4cef:c2a5:21f3:9f3c%5]) with mapi id 15.20.2387.023; Fri, 25 Oct 2019
 10:03:22 +0000
From: "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
To: 'Vivek Goyal' <vgoyal@redhat.com>
Subject: RE: [Virtio-fs] [PATCH] virtiofsd: Fix data corruption with O_APPEND
 wirte in writeback mode
Thread-Topic: [Virtio-fs] [PATCH] virtiofsd: Fix data corruption with O_APPEND
 wirte in writeback mode
Thread-Index: AQHViZvpLbfW+G+A2EG+Hrhspumg2Kdop+EAgAE8/oCAAT3lEA==
Date: Fri, 25 Oct 2019 10:02:22 +0000
Deferred-Delivery: Fri, 25 Oct 2019 10:03:21 +0000
Message-ID: <OSBPR01MB3783EBE1BB481BD1B14B8D45E5650@OSBPR01MB3783.jpnprd01.prod.outlook.com>
References: <20191023122523.1816-1-misono.tomohiro@jp.fujitsu.com>
 <20191023200752.GB6942@redhat.com> <20191024150225.GB6903@redhat.com>
In-Reply-To: <20191024150225.GB6903@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 7329cb6ca78b416d8928eb061d33cb6e
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=misono.tomohiro@fujitsu.com; 
x-originating-ip: [114.160.30.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 063065f7-cb75-4f35-52bb-08d75932917d
x-ms-traffictypediagnostic: OSBPR01MB3848:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <OSBPR01MB384846C0FFD3B459A041B0EAE5650@OSBPR01MB3848.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(199004)(189003)(85182001)(33656002)(6306002)(446003)(7736002)(6436002)(9686003)(99286004)(11346002)(71200400001)(76116006)(55016002)(71190400001)(25786009)(4326008)(6116002)(3846002)(476003)(81166006)(486006)(66476007)(66556008)(64756008)(66446008)(305945005)(8676002)(6246003)(86362001)(81156014)(256004)(14444005)(54906003)(966005)(66946007)(186003)(6916009)(14454004)(478600001)(316002)(76176011)(26005)(8936002)(7696005)(6506007)(74316002)(52536014)(102836004)(229853002)(5660300002)(2906002)(66066001)(777600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:OSBPR01MB3848;
 H:OSBPR01MB3783.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wtUPXHhDeDGqflJfjJ46EEvQ6xzORSzwHtRJB6MNKdDAMTPvmPhu+DX/rwH0chmSzTFetXR6NyjjDn0QepLWutgwmoghq9Iy60xJQtinWjpCPPiOzkRw54Ui1yM1VbSknSkeK8tmteATEaHh8c+1TtKESmYnoLTXr8io+M82iPa7zZjQFs9VyqB0QgpXeeDUNzKDXSCNmEC+Fkpls3JsiFm5Io31+yLJuqukyZ6b/ZmIpOHLE0c+NmJuug642+HaEOKhx30OYIRLJUQLC+PhMo3AP262Ea48MG/yzX1nnbyoBJgz9dXLbajeP/8mns+glWKdLC6IiDY+rELcXJySfMjlaT/L0fTYcNA/Xbr7Q6R1DuEa4hYI715Wfke2oHcyskqkUxmILwPxBSI5xY4Ejcsx5wAb0q465X9cE2cVFm4TZxiVljaKw6gjfzHtQ0lWaY80W/mMQNQvEZ9oSbieH22f7ShyE6+VjZQ+CwhINVA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 063065f7-cb75-4f35-52bb-08d75932917d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 10:03:21.9841 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vMlvn70aM5M6ze3da/wAEkVOWm7rapVytZvtFPWDNIjaIZa/kDmxRdQDwpwKazOUhXySUXK4BHybdarawfvkBFwNgLXVywJK7wIGV9UxMXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3848
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.158.65
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> On Wed, Oct 23, 2019 at 04:07:52PM -0400, Vivek Goyal wrote:
> > On Wed, Oct 23, 2019 at 09:25:23PM +0900, Misono Tomohiro wrote:
> > > When writeback mode is enabled (-o writeback), O_APPEND handling is
> > > done in kernel. Therefore virtiofsd clears O_APPEND flag when open.
> > > Otherwise O_APPEND flag takes precedence over pwrite() and write
> > > data may corrupt.
> > >
> > > Currently clearing O_APPEND flag is done in lo_open(), but we also
> > > need the same operation in lo_create().
> >
> > > So, factor out the flag
> > > update operation in lo_open() to update_open_flags() and call it in
> > > both lo_open() and lo_create().
> > >
> > > This fixes the failure of xfstest generic/069 in writeback mode
> > > (which tests O_APPEND write data integrity).
> > >
>=20
> Hi Misono,
>=20
> Have you tried running pjdfstests. Looks like with the patch applied I se=
e following tests failing which were passing without
> the patch. Can you please have a look. I ran daemon with options "-o cach=
e=3Dalways -o writeback"

Sorry, I didn't run pjdfstests. I will run the test and check the results.

Thanks,
Misono

>=20
> /root/git/pjdfstest/tests/chmod/00.t          (Wstat: 0 Tests: 119 Failed=
: 1)
>   Failed test:  64
> /root/git/pjdfstest/tests/chown/00.t          (Wstat: 0 Tests: 1323 Faile=
d: 1)
>   Failed test:  946
>   TODO passed:   1107, 1112, 1116, 1122, 1127, 1131, 1137
>                 1142, 1146, 1152, 1157, 1161, 1167, 1172
>                 1176, 1182, 1187
> /root/git/pjdfstest/tests/link/00.t           (Wstat: 0 Tests: 202 Failed=
: 1)
>   Failed test:  134
> /root/git/pjdfstest/tests/utimensat/01.t      (Wstat: 0 Tests: 7 Failed: =
1)
>   Failed test:  4
> Files=3D232, Tests=3D8789, 375 wallclock secs ( 4.00 usr  2.65 sys + 51.4=
8 cusr 262.19 csys =3D 320.32 CPU) Thanks Vivek
>=20
> >
> > Hi,
> >
> > Consolidating updation of flags both for lo_create() and lo_open()
> > makes sense to me. I will test it tomorrow.
> >
> > Thanks
> > Vivek
> >
> > > Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
> > > ---
> > >  contrib/virtiofsd/passthrough_ll.c | 56
> > > +++++++++++++++---------------
> > >  1 file changed, 28 insertions(+), 28 deletions(-)
> > >
> > > diff --git a/contrib/virtiofsd/passthrough_ll.c
> > > b/contrib/virtiofsd/passthrough_ll.c
> > > index e8892c3c32..79fb78ecce 100644
> > > --- a/contrib/virtiofsd/passthrough_ll.c
> > > +++ b/contrib/virtiofsd/passthrough_ll.c
> > > @@ -1733,6 +1733,32 @@ static void lo_releasedir(fuse_req_t req, fuse=
_ino_t ino, struct fuse_file_info
> > >  	fuse_reply_err(req, 0);
> > >  }
> > >
> > > +static void update_open_flags(int writeback, struct fuse_file_info
> > > +*fi) {
> > > +	/* With writeback cache, kernel may send read requests even
> > > +	   when userspace opened write-only */
> > > +	if (writeback && (fi->flags & O_ACCMODE) =3D=3D O_WRONLY) {
> > > +		fi->flags &=3D ~O_ACCMODE;
> > > +		fi->flags |=3D O_RDWR;
> > > +	}
> > > +
> > > +	/* With writeback cache, O_APPEND is handled by the kernel.
> > > +	   This breaks atomicity (since the file may change in the
> > > +	   underlying filesystem, so that the kernel's idea of the
> > > +	   end of the file isn't accurate anymore). In this example,
> > > +	   we just accept that. A more rigorous filesystem may want
> > > +	   to return an error here */
> > > +	if (writeback && (fi->flags & O_APPEND))
> > > +		fi->flags &=3D ~O_APPEND;
> > > +
> > > +	/*
> > > +	 * O_DIRECT in guest should not necessarily mean bypassing page
> > > +	 * cache on host as well. If somebody needs that behavior, it
> > > +	 * probably should be a configuration knob in daemon.
> > > +	 */
> > > +	fi->flags &=3D ~O_DIRECT;
> > > +}
> > > +
> > >  static void lo_create(fuse_req_t req, fuse_ino_t parent, const char =
*name,
> > >  		      mode_t mode, struct fuse_file_info *fi)  { @@ -1760,12
> > > +1786,7 @@ static void lo_create(fuse_req_t req, fuse_ino_t parent, c=
onst char *name,
> > >  	if (err)
> > >  		goto out;
> > >
> > > -	/*
> > > -	 * O_DIRECT in guest should not necessarily mean bypassing page
> > > -	 * cache on host as well. If somebody needs that behavior, it
> > > -	 * probably should be a configuration knob in daemon.
> > > -	 */
> > > -	fi->flags &=3D ~O_DIRECT;
> > > +	update_open_flags(lo->writeback, fi);
> > >
> > >  	fd =3D openat(parent_inode->fd, name,
> > >  		    (fi->flags | O_CREAT) & ~O_NOFOLLOW, mode); @@ -1966,28
> > > +1987,7 @@ static void lo_open(fuse_req_t req, fuse_ino_t ino,
> > > struct fuse_file_info *fi)
> > >
> > >  	fuse_log(FUSE_LOG_DEBUG, "lo_open(ino=3D%" PRIu64 ", flags=3D%d)\n"=
,
> > > ino, fi->flags);
> > >
> > > -	/* With writeback cache, kernel may send read requests even
> > > -	   when userspace opened write-only */
> > > -	if (lo->writeback && (fi->flags & O_ACCMODE) =3D=3D O_WRONLY) {
> > > -		fi->flags &=3D ~O_ACCMODE;
> > > -		fi->flags |=3D O_RDWR;
> > > -	}
> > > -
> > > -	/* With writeback cache, O_APPEND is handled by the kernel.
> > > -	   This breaks atomicity (since the file may change in the
> > > -	   underlying filesystem, so that the kernel's idea of the
> > > -	   end of the file isn't accurate anymore). In this example,
> > > -	   we just accept that. A more rigorous filesystem may want
> > > -	   to return an error here */
> > > -	if (lo->writeback && (fi->flags & O_APPEND))
> > > -		fi->flags &=3D ~O_APPEND;
> > > -
> > > -	/*
> > > -	 * O_DIRECT in guest should not necessarily mean bypassing page
> > > -	 * cache on host as well. If somebody needs that behavior, it
> > > -	 * probably should be a configuration knob in daemon.
> > > -	 */
> > > -	fi->flags &=3D ~O_DIRECT;
> > > +	update_open_flags(lo->writeback, fi);
> > >
> > >  	sprintf(buf, "%i", lo_fd(req, ino));
> > >  	fd =3D openat(lo->proc_self_fd, buf, fi->flags & ~O_NOFOLLOW);
> > > --
> > > 2.21.0
> > >
> > > _______________________________________________
> > > Virtio-fs mailing list
> > > Virtio-fs@redhat.com
> > > https://www.redhat.com/mailman/listinfo/virtio-fs
> >
> > _______________________________________________
> > Virtio-fs mailing list
> > Virtio-fs@redhat.com
> > https://www.redhat.com/mailman/listinfo/virtio-fs


