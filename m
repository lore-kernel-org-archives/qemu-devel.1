Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46656C2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 15:08:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08DEB206E6
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 15:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFgSOT7k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08DEB206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1in25V-00033j-3z
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 10:08:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1in24n-0002ar-HT
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 10:07:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1in24m-000580-6j
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 10:07:53 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:39423)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1in24l-00057c-Uc; Thu, 02 Jan 2020 10:07:52 -0500
Received: by mail-wr1-x42f.google.com with SMTP id y11so39508574wrt.6;
 Thu, 02 Jan 2020 07:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=JnsbJaq/0PhJWjVpuIX8zRiFsDu/eckSo/lDL+fg2xE=;
 b=SFgSOT7kF3qtpt4fIklFTlXPcr2X1d2MYkjuAqaWO584qqpRhnh1e1R8RIOiW40htn
 sUe9tbYVb2rmQoQY3ZxEZUQKLgVuKBLbyrHj6LNIciIbY7b18qK6pOYSR1PIvLgKYqzM
 R/HBcYcXTPewiAJ5yCW7grLl1YhEHczXGbwA/GHyyGdz5jwD2wiBTLiApKYL0xQneuMT
 n5/NjM1RUXOqLYEKp91kQqcMzRrmU5mV9UVc9iNoGz5NV1xASzV4OxkasDslv3ET43VZ
 QKg+GNhhR7YbKcdxVQR/pV7Qs8Uif5r7UGXkRArg3VQf4vlzGet9ZshAkdSrR6HhD/Cg
 l2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JnsbJaq/0PhJWjVpuIX8zRiFsDu/eckSo/lDL+fg2xE=;
 b=KqhJ3DnhxzEKuPseTcRPQ6/tYXeC2Uqry2eEQOmPFJH0rgdNZ7bs2wbCzeuErKXsUX
 47wWsMTGZwE+/dFMBjqE+3BR6SPefJklgt9MusT5D0Z/9YLFL/CS+QlxxHo+z/k/1wCC
 7guB94PHSSxSaAW6rjz1oFBBJ3CCWHf3xjPq/ENIBEPM9DNOE1rf4h+rkSSdZRSWQQk2
 4BC4C9lqQ1kky69tVyAo4jwOpegIOInhKjz87+Fo82R/M+CF22Yjx1u6yFTi4+9EuXZk
 m3KrAg2BWamQ0mBS7RbbT9hhvJCAiJjkw9YoTknYeJKAJtLavsr4Je8kdFhx1W+EhZMX
 A3VA==
X-Gm-Message-State: APjAAAX5ZFrIaKo6aCLgr+3uIyf08Lj2FdNd722WB33qAUl4CuOk+RBp
 2NQbXxrlRJj3LJArnthi5z8=
X-Google-Smtp-Source: APXvYqyoV3dpwq0qQ+5ktq3S4Us9GgbzP67wejOdfCm57kUMkH4KMBhP3PNeNWsLDtpm9O28d/BOeA==
X-Received: by 2002:adf:ea0f:: with SMTP id q15mr80260470wrm.324.1577977670637; 
 Thu, 02 Jan 2020 07:07:50 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id g199sm9009126wmg.12.2020.01.02.07.07.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2020 07:07:49 -0800 (PST)
Date: Thu, 2 Jan 2020 15:07:47 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: =?utf-8?B?5byg5rW35paM?= <xtay.haibin@gmail.com>
Subject: Re: How to impove downtime of Live-Migration caused bdrv_drain_all()
Message-ID: <20200102150747.GO121208@stefanha-x1.localdomain>
References: <CAP0gKjUf4+Jf2GSZy8u5fwQAU2V9bk-viuSBByB5bo78NWHpbQ@mail.gmail.com>
 <20190328170759.GH18536@stefanha-x1.localdomain>
 <CAP0gKjVqMEKF2gq4Xq8hX=zo-cM3vw2Xw70pajfQOvFj4-wvbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NT59pYSnj1ZLVgEN"
Content-Disposition: inline
In-Reply-To: <CAP0gKjVqMEKF2gq4Xq8hX=zo-cM3vw2Xw70pajfQOvFj4-wvbA@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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
Cc: qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com, Felipe Franciosi <felipe@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--NT59pYSnj1ZLVgEN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 26, 2019 at 05:40:22PM +0800, =E5=BC=A0=E6=B5=B7=E6=96=8C wrote:
> Stefan Hajnoczi <stefanha@redhat.com> =E4=BA=8E2019=E5=B9=B43=E6=9C=8829=
=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=881:08=E5=86=99=E9=81=93=EF=BC=
=9A
> >
> > On Thu, Mar 28, 2019 at 05:53:34PM +0800, =E5=BC=A0=E6=B5=B7=E6=96=8C w=
rote:
> > > hi, stefan
> > >
> > > I have faced the same problem you wrote in
> > > https://lists.gnu.org/archive/html/qemu-devel/2016-08/msg04025.html
> > >
> > > Reproduce as follow:
> > > 1. Clone qemu code from https://git.qemu.org/git/qemu.git, add some
> > > debug information and compile
> > > 2. Start a new VM
> > > 3. In VM, use fio randwrite to add pressure for disk
> > > 4. Live migrate
> > >
> > > Log show as follow:
> > > [2019-03-28 15:10:40.206] /data/qemu/cpus.c:1086: enter do_vm_stop
> > > [2019-03-28 15:10:40.212] /data/qemu/cpus.c:1097: call bdrv_drain_all
> > > [2019-03-28 15:10:40.989] /data/qemu/cpus.c:1099: call replay_disable=
_events
> > > [2019-03-28 15:10:40.989] /data/qemu/cpus.c:1101: call bdrv_flush_all
> > > [2019-03-28 15:10:41.004] /data/qemu/cpus.c:1104: done do_vm_stop
> > >
> > > Calling bdrv_drain_all() costs 792 mini-seconds.
> > > I just add a bdrv_drain_all() at start of do_vm_stop() before
> > > pause_all_vcpus(), but it doesn't work.
> > > Is there any way to improve live-migration downtime cause by bdrv_dra=
in_all()?

I believe there were ideas about throttling storage controller devices
during the later phases of live migration to reduce the number of
pending I/Os.

In other words, if QEMU's virtio-blk/scsi emulation code reduces the
queue depth as live migration nears the handover point, bdrv_drain_all()
should become cheaper because fewer I/O requests will be in-flight.

A simple solution would reduce the queue depth during live migration
(e.g. queue depth 1).  A smart solution would look at I/O request
latency to decide what queue depth is acceptable.  For example, if
requests are taking 4 ms to complete then we might allow 2 or 3 requests
to achieve a ~10 ms bdrv_drain_all() downtime target.

As far as I know this has not been implemented.

Do you want to try implementing this?

Stefan

--NT59pYSnj1ZLVgEN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4OB0MACgkQnKSrs4Gr
c8jhewf/RkwNbztd2txAo2+Tywc786C0+GqZ7lgZNa4oseWf3OJgd02DYP6VVdk5
K8XXgqODQAj2pSwBObMVozWy7vAhHi8F3breJA4JMqqa7r9il9Spj32xBCKgXe6x
uEq1pO5z/mfPO1UmQfSrtM8dp5z1LSNL3nE93ioM+j825M5aS2Ok1t2XZq5gFnBH
4jIAB5Q663RQMtCWVQ37LadqJ2Z91vhs4bHuFa6fsqRwBnhh5Pzz3kjnJZcYV8el
WlpBoPL0N3EJMfpoaIDLS1T2ZSSF9VxKnZme2lEFx+Cbqbe86Nof7LvSNF/6WDGy
5QYcuWcLTY/or4mSzkog6XZUhCPSKA==
=Kp4b
-----END PGP SIGNATURE-----

--NT59pYSnj1ZLVgEN--

