Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9C0C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 17:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8ECF2084A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 17:54:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8ECF2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51878 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQbd1-0000NG-4O
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 13:54:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hQbcB-0008LX-Go
	for qemu-devel@nongnu.org; Tue, 14 May 2019 13:53:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hQbcA-00083P-FF
	for qemu-devel@nongnu.org; Tue, 14 May 2019 13:53:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hQbc7-00081I-VQ; Tue, 14 May 2019 13:53:20 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5D9B8309B15A;
	Tue, 14 May 2019 17:53:18 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-242.ams2.redhat.com [10.36.116.242])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 12E3A10027CD;
	Tue, 14 May 2019 17:53:16 +0000 (UTC)
Date: Tue, 14 May 2019 19:53:15 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190514175315.GC18881@linux.fritz.box>
References: <20180312150218.1314-1-kwolf@redhat.com>
	<20180312150218.1314-3-kwolf@redhat.com>
	<20190514111330.GA8548@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190514111330.GA8548@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Tue, 14 May 2019 17:53:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/6] luks: Create
 block_crypto_co_create_generic()
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 14.05.2019 um 13:13 hat Daniel P. Berrang=E9 geschrieben:
> On Mon, Mar 12, 2018 at 04:02:14PM +0100, Kevin Wolf wrote:
> > Everything that refers to the protocol layer or QemuOpts is moved out=
 of
> > block_crypto_create_generic(), so that the remaining function is
> > suitable to be called by a .bdrv_co_create implementation.
> >=20
> > LUKS is the only driver that actually implements the old interface, a=
nd
> > we don't intend to use it in any new drivers, so put the moved out co=
de
> > directly into a LUKS function rather than creating a generic
> > intermediate one.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > ---
> >  block/crypto.c | 95 +++++++++++++++++++++++++++++++++++++-----------=
----------
> >  1 file changed, 61 insertions(+), 34 deletions(-)
>=20
>=20
> Reviving a year old commit...
>=20
> The LUKS driver doesn't implement preallocation during create.
>=20
> Before this commit this would be reported
>=20
>  $ qemu-img create -f luks --object secret,id=3Dsec0,data=3Dbase -o key=
-secret=3Dsec0 base.luks 1G -o preallocation=3Dfull
>  Formatting 'base.luks', fmt=3Dluks size=3D1073741824 key-secret=3Dsec0=
 preallocation=3Dfull
>  qemu-img: base.luks: Parameter 'preallocation' is unexpected
>=20
> After this commit, there is no error reported - it just silently
> ignores the preallocation=3Dfull option.
>=20
> I'm a bit lost in block layer understanding where is the right
> place to fix the error reporting in this case.

Hmm, this looked strange at first, but I see now where the difference
is.

In the old state, crypto used qemu_opts_to_qdict() and then fed all
options to its own visitor. I'm not sure whether I can clearly call this
a bug, but it's different from other format drivers, which parse all
options they know and pass the rest to the protocol driver.

The new version was converted to use qemu_opts_to_qdict_filtered() like
in all other drivers, so we got the same behaviour in crypto: Unknown
options are passed to the protocol.

As it happens, file-posix does support 'preallocation', so the operation
will return success now. Of course, passing the preallocation to the
protocol level is questionable for non-raw image formats, and completely
useless when you create the protocol level with size 0 and you'll call
blk_truncate() later.

I think we would get back to the old state if you just changed the
qemu_opts_to_qdict_filtered() call back to qemu_opts_to_qdict(). But it
make the driver inconsistent with other drivers again.

Maybe the best way to solve this would be to just implement
preallocation. It should be as easy as adding a 'preallocation' create
option (in QAPI and block_crypto_create_opts_luks), putting the
PreallocMode into BlockCryptoCreateData and then passing it to the
blk_truncate() call in block_crypto_init_func().

Kevin

