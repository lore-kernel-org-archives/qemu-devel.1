Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C8AC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:12:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BE9424528
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE9424528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44236 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWiGf-0003wv-Gk
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 10:12:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hWi7E-0005vB-Jo
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:02:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hWi7C-00016S-Jx
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:02:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hWi6q-0000Ip-3h; Fri, 31 May 2019 10:02:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 091927E42C;
	Fri, 31 May 2019 14:02:08 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-126.ams2.redhat.com
	[10.36.117.126])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 59FE75DE70;
	Fri, 31 May 2019 14:02:05 +0000 (UTC)
Date: Fri, 31 May 2019 16:02:03 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190531140203.GE9842@localhost.localdomain>
References: <20190524172812.27308-1-mreitz@redhat.com>
	<20190524172812.27308-2-mreitz@redhat.com>
	<20190529221010.GC3471@localhost.localdomain>
	<9690f4f9-d618-4d0d-4094-356f8e5c922a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <9690f4f9-d618-4d0d-4094-356f8e5c922a@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Fri, 31 May 2019 14:02:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC 1/3] block: Add ImageRotationalInfo
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
Cc: Alberto Garcia <berto@igalia.com>,
	Anton Nefedov <anton.nefedov@virtuozzo.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 31.05.2019 um 13:51 hat Max Reitz geschrieben:
> On 30.05.19 00:10, Kevin Wolf wrote:
> > Am 24.05.2019 um 19:28 hat Max Reitz geschrieben:
> >> This enum indicates whether a file is stored on a rotating disk or a
> >> solid-state drive.  Drivers report it via the .bdrv_get_info() callbac=
k,
> >> and if they do not, the global bdrv_get_info() implementation
> >> automatically takes it from bs->file or bs->backing, if available.
> >=20
> > Good that you wrote "bs->file or bs->backing" explicitly. Otherwise, I
> > might have missed that it begs one big question: What is the correct
> > answer for a qcow2 file that has bs->file on an SSD, but bs->backing on
> > a rotating disk?
> >=20
> > I don't think there is a correct answer for the whole device, so maybe
> > this information shouldn't be per device in BlockDriverInfo, but per
> > block in bdrv_co_block_status() (optionally determined if the caller
> > requests it)?
>=20
> I think that=E2=80=99s taking it a bit too far.  There is no heavy implic=
ation
> in making the wrong choice here, it=E2=80=99s just a performance problem.
> Having to call block_status for every block where we want to know what
> to do seems like the opposite of performance optimization to me.  (We
> could add a flag to block_status to only query that status, but that
> sounds plainly wrong.)
>=20
> So, in this series I decided that since all writes go to bs->file, that
> seemed like what mostly determines the behavior of @bs.  (After my =E2=80=
=9CDeal
> with filters=E2=80=9D series, that would become a decision of bdrv_storag=
e_bs()
> vs. bdrv_filtered_cow_bs().)

Okay, if we consider the existing qcow2 case as the only case, writes
are what matters. Then we can ignore backing files. (However, it
shouldn't check bs->file, but s->data_file, I think.)

> (Note that it has to get even funnier with vmdk, if your extents are on
> an HDD, but your descriptor file is on an SSD.  I don=E2=80=99t care too =
much
> about vmdk=E2=80=99s performance, though.)
>=20
> In my v1, I=E2=80=99ll add a per-node @rotational parameter with which th=
e user
> can override the status we guessed.  In fact, currently, my commit
> message explicitly notes that case:
>=20
> https://git.xanclic.moe/XanClic/qemu/commit/0834f1ce77b4c27f0c00f1e4fbee0=
99278e530b2
>=20
> (Point 4)
>=20
> (from
> https://git.xanclic.moe/XanClic/qemu/commits/branch/spinning-rust-next)
>=20
>=20
> Alternatively to making bs->file take precedence over bs->backing, we
> could also just set the status to unknown if bs->file and bs->backing
> differ in their status.
>=20
> I think it=E2=80=99s generally better to prefer what bs->file says.  This=
 is an
> optimization case, so I think it=E2=80=99s more important to get it right=
 most
> of the time (and guess wrong sometimes) than to stop guessing in all
> cases where we could be wrong.

Fair enough, but let's improve the documentation (both QAPI schema and
comments in the code) to be explicit about these details, how the result
is determined for nodes with multiple children, and what it means and
doesn't mean therefore.

Kevin

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJc8TPbAAoJEH8JsnLIjy/WrU8P/2DUtcqKScre+sdLP2gsDqCX
Ua4DKBCxzAvW78MAqPLbBer3Vq7tT0+kWxbstv1pFKPgbMhpGl2Y4zz8iCd7paVT
KIfhQoMXvkuL4KDz15YDPxCxoE6DfTiynoUeQBgloFcENaDWBuIm5lmSQPmpMveT
KrHu2z9+rTQtAjh2KqH8/rppBMAOiwTlOkoqSMkT7zBQOucqTn9QJqbmYJghsSQo
Vld934sHl3ybPIPnj+65R2ZRX8b4BpnolSKvGX5OhRCdizt/0c7Ur6n5rSvKLTqT
K1Ef/5isDdclCr/t9+r2aCXA1v2lMWnlY0LRKzxTgIPOwDxJGb49W8bahTteJ8Ql
IA2pasRk8kwgwPJc/F1rHaH26oGS/j/mHLZ5OsoSF/m3OSWEEBxaZZnQxKBPKEif
LtLtJRKVIsWtA6wt6AUDeKXOiK4WPaCCdl0essZb7Q5vtQk4q02xfh+TfmuBFBSi
G8eCoMW9Bxx3c1c8vfmRENwtQNp6fbUnNI91IHk7aqPzgPvA7//QbeUV5eMaEWJM
WpY//S5w1XGEnv39vbrP7P56ljgMQBqt6oU0zbjoLCRbWGjQkwNckU97l/JGcAku
aU28OOTxOViVKnRT0LT2mglDTQmT9Cxd5aPC1sGzcCFuILTrfut4WT44lwBizBp2
1h75+1/N6sIqLhmzl5Rr
=ZLXI
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--

