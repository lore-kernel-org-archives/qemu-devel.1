Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_BTC_ID,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4E0C432C3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 14:53:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB694207DD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 14:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTX14H/R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB694207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic9Yd-0005b9-5E
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 09:53:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ic9BA-0003WC-0s
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 09:29:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ic9Aq-0008P0-92
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 09:29:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33655
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ic9Aq-00080U-3w
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 09:29:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575383342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=snQ569vxzEN+F9KN8eLrSAddooy2QKy2IgbuHNLzBu8=;
 b=MTX14H/R2Eh12TQWqPtPwfjCts3AbgXHe8HOs3pNdJNE78kP0B5Kdne3ScrJatCMyXI7Cv
 z8T3Z6HlA+UWO9BZjKVHSiu0KGeGsPf4GBuYNTplmYrg5iFi2AC0XUcj4ooEI9I9nW8J19
 43eJhmgc18wv7ghToiYVX8S0xcHM7g4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-fWGBPzUhO5CftzN2ERENkA-1; Tue, 03 Dec 2019 09:28:58 -0500
X-MC-Unique: fWGBPzUhO5CftzN2ERENkA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7279B1C5C;
 Tue,  3 Dec 2019 14:28:57 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-128.ams2.redhat.com [10.36.117.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B54E5DA60;
 Tue,  3 Dec 2019 14:28:46 +0000 (UTC)
Date: Tue, 3 Dec 2019 15:28:45 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 05/15] stubs: add stubs for io_uring interface
Message-ID: <20191203142845.GE5637@linux.fritz.box>
References: <20191025160444.31632-1-stefanha@redhat.com>
 <20191025160444.31632-6-stefanha@redhat.com>
 <20191111111347.GC7297@linux.fritz.box>
 <20191203111600.GA167235@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20191203111600.GA167235@stefanha-x1.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, oleksandr@redhat.com, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 03.12.2019 um 12:16 hat Stefan Hajnoczi geschrieben:
> On Mon, Nov 11, 2019 at 12:13:47PM +0100, Kevin Wolf wrote:
> > Am 25.10.2019 um 18:04 hat Stefan Hajnoczi geschrieben:
> > > From: Aarushi Mehta <mehta.aaru20@gmail.com>
> > >=20
> > > Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> >=20
> > This commit message needs to answer at least where these stubs are
> > actually used. Aren't all callers protected with #ifdef
> > CONFIG_LINUX_IO_URING? (And if they aren't, why is abort() okay?)
>=20
> Okay, I'll clarify in the commit description.
>=20
> I didn't find a program that actually requires these stubs today, but in
> theory they are required when:
> 1. A program links against util-obj-y but not block-obj-y (e.g.
>    vhost-user-gpu)
> AND
> 2. It uses util/async.o, which depends on luring_*() APIs
>=20
> You can test this by adding a call to qemu_bh_new() into
> vhost-user-gpu's main.c:
>=20
>   ld: libqemuutil.a(async.o): in function `aio_ctx_finalize':
>   qemu/util/async.c:281: undefined reference to `luring_detach_aio_contex=
t'
>   ld: /home/stefanha/qemu/util/async.c:282: undefined reference to `lurin=
g_cleanup'
>   ld: libqemuutil.a(async.o): in function `aio_setup_linux_io_uring':
>   qemu/util/async.c:358: undefined reference to `luring_init'
>   ld: /home/stefanha/qemu/util/async.c:363: undefined reference to `lurin=
g_attach_aio_context'
>=20
> The program may have no intention of using io_uring, just the QEMU main
> loop and BH, so there is an argument for avoiding linking block-obj-y*.
> That's the purpose of the stubs and why abort() is okay.

Okay, make sense to me then.

> * It's possible to argue against this and personally I'm not that
> convinced by stubs for this scenario.  But io_uring.o should be
> consistent with how things work today with linux-aio.o.  If you feel
> strongly against having stubs then the linux-aio.o stubs should also be
> removed (see commit c2b38b277a788).

I don't really like having block-specific things like Linux AIO or
io_uring in util/async.c, but given that they have per-AioContext state,
it's not clearly wrong either.

Maybe we could consider moving these functions to the file-posix driver,
it's the only caller of them. But it's nothing that should stop this
series.

Kevin

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJd5nEdAAoJEH8JsnLIjy/WCcoQAJowM650b+0ldT+07L2zoexb
bfCKOJmx+4A415CHx5jXqKnAurGRzeJEg6lq+uw/J9kQ/apMsgElJwfAuU5diO+i
aqvsBrMLlS6GM0A90f3QElDIX6RmcQPNJujs/CSJhxfXP9fn/uxGx1a6DrHfVMR0
FhtVJUCIcGHM8WH/aRl4NsGGjNeXKgEj690VRIHRZA/0OgSkaCcxrIIXx0ZUzNBO
dnzU78VscrJg3IFRU2EbRndfw6qfgzTmFAcOr0U9OCj+p93S0omJaZYr6kfjmaAQ
BTSPnimTSyZHH4GvV2Dkpk5O6b2J76joUZjKNE/I/CxDkqZ7l0nqaj/AT9Ji+/jA
RHjS0IJ4yNaOz7/euubLBZK/zOm6XqxV5Pm8ZjDI04uqpUawAY2xtVs06SvtNd5e
8mW4KW38wjNMgZA2jPMTPS1eu2yGdPxLNKDw0Fo64JCOdgJ2p3R5ipAEgmr8ew3a
fymex5JOxg6Tt6awMCzCfGuv+cOrSMBGPqnyg2QgXoux6OYAZoeX9gflq8OVr/rX
Zeol3yU97rv0pPVRGqkxzYk0lI0Hz0yNsVTxCkdRzRF1I0K15xIpL/h9BXt4EBF9
WQsl8XYjwC5rJKWPt7JoqRk/YPxC6hccSG+pa5DxgTXrQ4lDtq9CjV9wvypWBCKn
ZmIMeSP5b4EBtPD9w2eE
=VLku
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--


