Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189EBC282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 08:31:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23DD920880
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 08:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23DD920880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49282 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDPgA-0007Oh-CH
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 04:30:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hDPfJ-00070H-EL
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hDPfI-0008H6-6J
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:30:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hDPfH-0008FS-N4
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:30:04 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CE5F2C05001C
	for <qemu-devel@nongnu.org>; Mon,  8 Apr 2019 08:30:01 +0000 (UTC)
Received: from localhost (ovpn-116-217.ams2.redhat.com [10.36.116.217])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2FEC61018A0E;
	Mon,  8 Apr 2019 08:29:58 +0000 (UTC)
Date: Mon, 8 Apr 2019 09:29:58 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Message-ID: <20190408082958.GF15001@stefanha-x1.localdomain>
References: <20190326131822.GD15011@stefanha-x1.localdomain>
	<878swomn42.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gdTfX7fkYsEEjebm"
Content-Disposition: inline
In-Reply-To: <878swomn42.fsf@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Mon, 08 Apr 2019 08:30:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] QEMU event loop optimizations
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408082958.SGeSDSVyXxyTAw3ogozVNfp2p0lAVf7tAE8QFI_0QAU@z>


--gdTfX7fkYsEEjebm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2019 at 06:29:49PM +0200, Sergio Lopez wrote:
>=20
> Stefan Hajnoczi writes:
>=20
> > Hi Sergio,
> > Here are the forgotten event loop optimizations I mentioned:
> >
> >   https://github.com/stefanha/qemu/commits/event-loop-optimizations
> >
> > The goal was to eliminate or reorder syscalls so that useful work (like
> > executing BHs) occurs as soon as possible after an event is detected.
> >
> > I remember that these optimizations only shave off a handful of
> > microseconds, so they aren't a huge win.  They do become attractive on
> > fast SSDs with <10us read/write latency.
> >
> > These optimizations are aggressive and there is a possibility of
> > introducing regressions.
> >
> > If you have time to pick up this work, try benchmarking each commit
> > individually so performance changes are attributed individually.
> > There's no need to send them together in a single patch series, the
> > changes are quite independent.
>=20
> It took me a while to find a way to get meaningful numbers to evaluate
> those optimizations. The problem is that here (Xeon E5-2640 v3 and EPYC
> 7351P) the cost of event_notifier_set() is just ~0.4us when the code
> path is hot, and it's hard differentiating it from the noise.
>=20
> To do so, I've used a patched kernel with a naive io_poll implementation
> for virtio_blk [1], an also patched QEMU with poll-inflight [2] (just to
> be sure we're polling) and ran the test on semi-isolated cores
> (nohz_full + rcu_nocbs + systemd_isolation) with idle siblings. The
> storage is simulated by null_blk with "completion_nsec=3D0 no_sched=3D1
> irqmode=3D0".
>=20
> # fio --time_based --runtime=3D30 --rw=3Drandread --name=3Drandread \
>  --filename=3D/dev/vdb --direct=3D1 --ioengine=3Dpvsync2 --iodepth=3D1 --=
hipri=3D1
>=20
> | avg_lat (us) | master | qbsn* |
> |   run1       | 11.32  | 10.96 |
> |   run2       | 11.37  | 10.79 |
> |   run3       | 11.42  | 10.67 |
> |   run4       | 11.32  | 11.06 |
> |   run5       | 11.42  | 11.19 |
> |   run6       | 11.42  | 10.91 |
>  * patched with aio: add optimized qemu_bh_schedule_nested() API
>=20
> Even though there's still some variance in the numbers, the 0.4us
> improvement can be clearly appreciated.
>=20
> I haven't tested the other 3 patches, as their optimizations only have
> effect when the event loop is not running in polling mode. Without
> polling, we get an additional overhead of, at least, 10us, in addition
> to a lot of noise, due to both direct costs (ppoll()...) and indirect
> ones (re-scheduling and TLB/cache pollution), so I don't think we can
> reliable benchmark them. Probably their impact won't be significant
> either, due to the costs I've just mentioned.

Thanks for benchmarking them.  We can leave them for now, since there is
a risk of introducing bugs and they don't make a great difference.

Stefan

> Sergio.
>=20
> [1] https://github.com/slp/linux/commit/d369b37db3e298933e8bb88c6eeacff07=
f39bc13
> [2] https://lists.nongnu.org/archive/html/qemu-devel/2019-04/msg00447.html



--gdTfX7fkYsEEjebm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcqwaGAAoJEJykq7OBq3PIH/8H/0jzP5E2RiPvSGgo3pYLhRyw
CZDNEHuV/hybIBFx4h9mQhBzN9ZYGi9sZhMJ7xOCrl87DJ7+gEOLWbvi3m5WBG08
MNNRUNf8EeVCU83Durw4grKNJNnR1r+9YllzqQpoVp3H2h4pdSU/I/MrZ+5jBHVi
xT+KtZin4eiCuaijxYiDyQxQDJ9bWawEHeVVVhg2UFXh/SnJpMMlGyX3FOVa068/
Zoh3M9XQpOl5lWG7qtzjp7OjoF2OOOwpasQF70ZcHrPq9Ase4bUa0c1r/tlGRiTI
nMG/n20ax0g39Y0JkUjbiYhZfetLTMm1crRORFUxVOTCWrQcP5FL4NXKGbH+NGA=
=4yAG
-----END PGP SIGNATURE-----

--gdTfX7fkYsEEjebm--

