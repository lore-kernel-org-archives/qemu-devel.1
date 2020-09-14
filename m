Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD7EC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:38:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 036F6207EA
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vf976JL0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 036F6207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHpcp-0003qt-To
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 10:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kHpJ4-0001g0-JF
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:18:10 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40062)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kHpJ2-0000ji-MR
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:18:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600093087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JbW8jfD6KzkJkrDs0OhdLFg3ucolLTgAlu14OYKqyjc=;
 b=Vf976JL0KlPpejH9QH6hOetxju3U8TKPAUU81xgVfT9cm3WWyuLVWxPhGi30gPk+xng1HP
 2rmxXi16oX4CXTYK200JdB8J0+Zpq8vfhvOyAmWMUsygnLpGA/xixW8HQG/WtiXyQjXCB0
 di++FpAKqofASkgKmoeofswL3XbUMIA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-NiOyPfoXNWuoNiOWergLUw-1; Mon, 14 Sep 2020 10:18:02 -0400
X-MC-Unique: NiOyPfoXNWuoNiOWergLUw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E15DE801ADA;
 Mon, 14 Sep 2020 14:18:00 +0000 (UTC)
Received: from localhost (ovpn-114-32.ams2.redhat.com [10.36.114.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5DD7D7A414;
 Mon, 14 Sep 2020 14:18:00 +0000 (UTC)
Date: Mon, 14 Sep 2020 14:27:38 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: Re: [PATCH v1 0/2] Add timeout mechanism to qmp actions
Message-ID: <20200914132738.GL579094@stefanha-x1.localdomain>
References: <20200810145246.1049-1-yezhenyu2@huawei.com>
 <20200810153811.GF14538@linux.fritz.box>
 <c6d75e49-3e36-6a76-fdc8-cdf09e7c3393@huawei.com>
MIME-Version: 1.0
In-Reply-To: <c6d75e49-3e36-6a76-fdc8-cdf09e7c3393@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Mit9XoPEfICDqq/V"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 00:11:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, fam@euphon.net, qemu-block@nongnu.org,
 armbru@redhat.com, xiexiangyou@huawei.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Mit9XoPEfICDqq/V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2020 at 09:54:08PM +0800, Zhenyu Ye wrote:
> Hi Kevin,
>=20
> On 2020/8/10 23:38, Kevin Wolf wrote:
> > Am 10.08.2020 um 16:52 hat Zhenyu Ye geschrieben:
> >> Before doing qmp actions, we need to lock the qemu_global_mutex,
> >> so the qmp actions should not take too long time.
> >>
> >> Unfortunately, some qmp actions need to acquire aio context and
> >> this may take a long time.  The vm will soft lockup if this time
> >> is too long.
> >=20
> > Do you have a specific situation in mind where getting the lock of an
> > AioContext can take a long time? I know that the main thread can
> > block for considerable time, but QMP commands run in the main thread, s=
o
> > this patch doesn't change anything for this case. It would be effective
> > if an iothread blocks, but shouldn't everything running in an iothread
> > be asynchronous and therefore keep the AioContext lock only for a short
> > time?
> >=20
>=20
> Theoretically, everything running in an iothread is asynchronous. However=
,
> some 'asynchronous' actions are not non-blocking entirely, such as
> io_submit().  This will block while the iodepth is too big and I/O pressu=
re
> is too high.  If we do some qmp actions, such as 'info block', at this ti=
me,
> may cause vm soft lockup.  This series can make these qmp actions safer.
>=20
> I constructed the scene as follow:
> 1. create a vm with 4 disks, using iothread.
> 2. add press to the CPU on the host.  In my scene, the CPU usage exceeds =
95%.
> 3. add press to the 4 disks in the vm at the same time.  I used the fio a=
nd
> some parameters are:
>=20
> =09 fio -rw=3Drandrw -bs=3D1M -size=3D1G -iodepth=3D512 -ioengine=3Dlibai=
o -numjobs=3D4
>=20
> 4. do block query actions, for example, by virsh:
>=20
> =09virsh qemu-monitor-command [vm name] --hmp info block
>=20
> Then the vm will soft lockup, the calltrace is:
>=20
> [  192.311393] watchdog: BUG: soft lockup - CPU#1 stuck for 42s! [kworker=
/1:1:33]

Hi,
Sorry I haven't had time to investigate this myself yet.

Do you also have a QEMU backtrace when the hang occurs?

Let's find out if QEMU is stuck in the io_submit(2) syscall or whether
there's an issue in QEMU itself that causes the softlockup (for example,
aio_poll() with the global mutex held).

Stefan

--Mit9XoPEfICDqq/V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9fb8kACgkQnKSrs4Gr
c8gdlgf+K3yZ69f783TTQuSp94r9d/2lOo1Ve02Y66+76qmQ4PwoP+OQAs4CHu/i
bIrGFpPlcow+Y9sINabj8Lqpuocmf+UCeWXn3b+6wCujMzYL19giwUu/CM+yvV3l
lXpbrq8LPxKhuHuwQjsOniz+RkPjEVabmSLRnPEsmooCru3MVXrCuVYla2szIgSF
+onRTRwm7yG6pCFhC34wtJAtMdaS7eAqWSZ5q/+wAsa1Qw7hfgEh1uO7cEt82OqU
Kk2JE2aGlksey4vqcFtf1SrQqHdYPbtBNktJK5TD/XqMCVcY3GnhhyyoApSqB5y/
DpfwzrRh4ieF1wg3xNivOCLsV1YafA==
=4huk
-----END PGP SIGNATURE-----

--Mit9XoPEfICDqq/V--


