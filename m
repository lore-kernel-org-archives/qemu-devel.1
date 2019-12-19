Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0F7C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:19:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93701218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAyKbypr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93701218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihtq2-0003cT-Qb
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 06:19:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1ihtpO-0002wp-5b
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:18:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1ihtpM-0005HG-Og
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:18:45 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37835)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ihtpM-00058b-9A
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:18:44 -0500
Received: by mail-wm1-x341.google.com with SMTP id f129so5204165wmf.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 03:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=zJAgS20/zs8QilluW3kAGxec4zM74Hea/FaQMFwELkU=;
 b=bAyKbypr719QhiPNt2EHlym/iDDGumrd7duWFje5u0N9ZOxDOZoBk0SnZhQL0fe3NZ
 N/ubSR9RVeVg8V2DV9Jxs9sMdTJwYiHwZGzCGRatJ+SaoI1o/GDcq11m+jI160pEVrFk
 DQuraa9B1cOoydshNKKKSkgsdmqHVuYKveagqswWPkf293vtk+17bBNsSJQEkEjZ3VBa
 0zbRJ2aLnTT4QiAfzVk/LisraiHl9gYk28l5/Hsq3mRxavns60E8cHXP1bLupAhHx/9V
 T610PEqZxZvilmI9fdoA/dR51dW8EbnOfqBMlEBpNFnvne955zDwdcyQxdmKygj4McSG
 TuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=zJAgS20/zs8QilluW3kAGxec4zM74Hea/FaQMFwELkU=;
 b=dFn6dz3ecxTFLeqXM7av/7Sf45IwNBV4WP/+l/h0oTjMxd6LXw5pesvGxEpgst90L3
 FGpBzB4otdw1Jx86+lvU7DHdkqQK5bWJalD82pE1U0eNf1RO4ddJ7l/K7lLoQuZxxwLd
 gNvMBbneI0wZDUw97Dlgc4I5NNrdls046oXqS55rHjoJYIebJUz6Ahyaxr9flC0jdwBr
 isDyr2WrZbfidmUu1fAsTHm8wpVGNXPKCY8F0fiffu+szFGx4ZJnIDyBVsMAsVYX8vNM
 8JrRgxiVRvowamYDCY7mqVk1nmBxSwoHgdA/1XcaotqRFOS/ypeazvJb3A8cs1z6yzrh
 PwqQ==
X-Gm-Message-State: APjAAAV6m/6o5wji82S8UZE2WecFjGv8cBw7Eu4W76Ost+VLAQ8hSyVP
 l3NknAvMQKAx5APlYI8Ngw4=
X-Google-Smtp-Source: APXvYqxgvms0C1gkR8LRvY3QS6ujHiYY7uAUmU4uch4r+u0w0IKIxlkIdJkbT9kvp8kxfw530yqxBw==
X-Received: by 2002:a7b:cc6a:: with SMTP id n10mr9770455wmj.170.1576754322593; 
 Thu, 19 Dec 2019 03:18:42 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id n1sm5982902wrw.52.2019.12.19.03.18.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 03:18:41 -0800 (PST)
Date: Thu, 19 Dec 2019 11:18:39 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] vhost-vsock: report QMP event when
 setrunning
Message-ID: <20191219111839.GB1624084@stefanha-x1.localdomain>
References: <20190809134134.GA8594@stefanha-x1.localdomain>
 <201911281926474453744@zte.com.cn>
 <20191212110525.GA1141992@stefanha-x1.localdomain>
 <20191212062328-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
In-Reply-To: <20191212062328-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: ning.bo9@zte.com.cn, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2019 at 06:24:55AM -0500, Michael S. Tsirkin wrote:
> On Thu, Dec 12, 2019 at 11:05:25AM +0000, Stefan Hajnoczi wrote:
> > On Thu, Nov 28, 2019 at 07:26:47PM +0800, ning.bo9@zte.com.cn wrote:
> > > Let me describe the issue with an example via `nc-vsock`:
> > >=20
> > > Let's assume the Guest cid is 3.
> > > execute 'rmmod vmw_vsock_virtio_transport' in Guest,
> > > then execute 'while true; do nc-vsock 3 1234' in Host.
> > >=20
> > > Host                             Guest
> > >                                  # rmmod vmw_vsock_virtio_transport
> > >=20
> > > # while true; do ./nc-vsock 3 1234; done
> > > (after 2 second)
> > > connect: Connection timed out
> > > (after 2 second)
> > > connect: Connection timed out
> > > ...
> > >=20
> > >                                  # modprobe vmw_vsock_virtio_transport
> > >=20
> > > connect: Connection reset by peer
> > > connect: Connection reset by peer
> > > connect: Connection reset by peer
> > > ...
> > >=20
> > >                                  # nc-vsock -l 1234
> > >                                  Connetion from cid 2 port ***...
> > > (stop printing)
> > >=20
> > >=20
> > > The above process simulates the communication process between
> > > the `kata-runtime` and `kata-agent` after starting the Guest.
> > > In order to connect to `kata-agent` as soon as possible,=20
> > > `kata-runtime` will continuously try to connect to `kata-agent` in a =
loop.
> > > see https://github.com/kata-containers/runtime/blob/d054556f60f092335=
a22a288011fa29539ad4ccc/vendor/github.com/kata-containers/agent/protocols/c=
lient/client.go#L327
> > > But when the vsock device in the Guest is not ready, the connection
> > > will block for 2 seconds. This situation actually slows down
> > > the entire startup time of `kata-runtime`.
> >=20
> > This can be done efficiently as follows:
> > 1. kata-runtime listens on a vsock port
> > 2. kata-agent-port=3DPORT is added to the kernel command-line options
> > 3. kata-agent parses the port number and connects to the host
> >=20
> > This eliminates the reconnection attempts.
>=20
> Then we'll get the same problem in reverse, won't we?
> Agent must now be running before guest can boot ...
> Or did I miss anything?

kata-runtime launches QEMU.  The QEMU guest runs kata-agent.  Therefore
it is guaranteed that kata-runtime's listen socket will be set up before
the agent executes.

Stefan

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl37XI8ACgkQnKSrs4Gr
c8g2PAf9GwgOAoV6/Y/YUe2hJE2bn9gADOHqia3+F7XU5/Lh2382j4iTcQXy9Q6Q
3/GPcTqkiMI9D4HM3VmEYm8ZARJc8+15jDS9k3ZrDmW9RpS7hHMVv54DLzUSlVJV
0d10voEZNFZJ5IF9rXRTXYBO1AUMH3F+uBWfGveLVkwaXY6U1lsmjH61web/6BIb
6JALNCwagrVBObOtloCFDvDff3eKGpJtglc8Wf2B4B+ZBbgeCGugv2aMBIBzEBYt
AhrpH/wu2+DgUihP9n+z4O1JUi0Z33h0Ocl8fMbWWJgGpQBIoj6KBxDky0eluCeC
kPp/ZW5tvldZkEqyqFQe005gffCOlw==
=Ro50
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--

