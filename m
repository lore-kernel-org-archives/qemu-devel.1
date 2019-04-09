Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EFFC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 11:31:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6883D20857
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 11:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fs7LfkUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6883D20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39417 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDoyk-0001Af-MA
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 07:31:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hDoxa-0000eL-Rc
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 07:30:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hDoxZ-0003mt-P8
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 07:30:38 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>)
	id 1hDoxX-0003kI-52; Tue, 09 Apr 2019 07:30:35 -0400
Received: by mail-wm1-x341.google.com with SMTP id h18so2919278wml.1;
	Tue, 09 Apr 2019 04:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=ZjUCggDY8+jbUlcI6k3awUO7/Jl+popLE+V1+SB0yF0=;
	b=Fs7LfkUkc8dxqewUZQubH5d9cfOc38bcoTWgJ+gb+3kY7S3RdtG1c41oZwuOFMFD4c
	XuMpYhiyEffBZ4VQxTgrycFjBLxNP9NkD2MIbZjcSRRZQey0KKAqkCk+DSwHOFO3uKmU
	x3/ZILybqDzSlarFbSaOFdyUXTchLMiEkZMBPM9WShk3u9x7RUg7Z2qB/LY/as4v9o+6
	OMHvsfercIjLhkYidyiUledMXi30qobgDMuvBEArZzROekX2c6Y/eK6GDIzzbHtCEBvj
	oHhYIoAeHBfXB/E/mUgTQLCA7j5OB4vMijHAtmV6F30DFI6Rg1sp8FdLzZWW/l3zCwBx
	Q4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=ZjUCggDY8+jbUlcI6k3awUO7/Jl+popLE+V1+SB0yF0=;
	b=DnsOzU+xw1LXIuyqgPcstV4rsh0BssnDHRvq6eOTOqi7C7ZvEd5oaNFlrqw9xcP7fh
	J2Z/KRKbXR4uvqjrcuhVHo4oujLv1RVWZyWMCjZHLcov3dh+7tDYeOTh8BWWw8Y9kUXn
	981+/brj+WiNkBB00M2Wa9HVdxFicEYVnPfJ/Y/kC8OsuATlvMgDhAtS+0YZL4UtnWSD
	YdTMK965IzjsysXCwuScX6MD+iS5Mn9JzjacNleAc3McxyLxVHdVD0QHWOPMNRQjNVSU
	oRMXJFABKiUmbvOePgl+IIYjR1uvt5IU8ebmXBHLs+sZFxEjHSK26IS1Q5ivRYBp7XQz
	MvsA==
X-Gm-Message-State: APjAAAUv+XzTQlw6ZaiJNb82RinrKuNf6qd+FopI5ZmH6Dev6Y4m0xsG
	H5pfy6Z2cpkR9MDixJaqDRA=
X-Google-Smtp-Source: APXvYqx+WNT0Pt6ozvK0+IpgrdGooqG096pgJqvY1VS160LnX8em7Y8JRrUVluX363ARnebXPeyCvQ==
X-Received: by 2002:a7b:cb16:: with SMTP id u22mr21172981wmj.60.1554809433961; 
	Tue, 09 Apr 2019 04:30:33 -0700 (PDT)
Received: from localhost ([46.233.112.222]) by smtp.gmail.com with ESMTPSA id
	q4sm46113612wrx.25.2019.04.09.04.30.32
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 09 Apr 2019 04:30:33 -0700 (PDT)
Date: Tue, 9 Apr 2019 12:26:08 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Sergio Lopez <slp@redhat.com>
Message-ID: <20190409112608.GD16944@stefanha-x1.localdomain>
References: <20190402121908.44081-1-slp@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hoZxPH4CaxYzWscb"
Content-Disposition: inline
In-Reply-To: <20190402121908.44081-1-slp@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH] aio: Add a knob to always
 poll if there are in-flight requests
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
	qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
	pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409112608.12wnll9S9LjQQC5yUIyXBxRKQz77n3bEY0nmeyBI8oE@z>


--hoZxPH4CaxYzWscb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2019 at 02:19:08PM +0200, Sergio Lopez wrote:
> The polling mode in aio_poll is able to trim down ~20us on the average
> request latency, but it needs manual fine tuning to adjust it to the
> characteristics of the storage.
>=20
> Here we add a new knob to the IOThread object, "poll-inflight". When
> this knob is enabled, aio_poll will always use polling if there are
> in-flight requests, ignoring the rest of poll-* parameters. If there
> aren't any in-flight requests, the usual polling rules apply, which is
> useful given that the default poll-max-ns value of 32us is usually
> enough to catch a new request in the VQ when the Guest is putting
> pressure on us.
>=20
> To keep track of the number of in-flight requests, AioContext has a
> new counter which is increased/decreased by thread-pool.c and
> linux-aio.c on request submission/completion.
>=20
> With poll-inflight, users willing to spend more Host CPU resources in
> exchange for a lower latency just need to enable a single knob.
>=20
> This is just an initial version of this feature and I'm just sharing
> it to get some early feedback. As such, managing this property through
> QAPI is not yet implemented.
>=20
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>  block/linux-aio.c         |  7 +++++++
>  include/block/aio.h       |  9 ++++++++-
>  include/sysemu/iothread.h |  1 +
>  iothread.c                | 33 +++++++++++++++++++++++++++++++++
>  util/aio-posix.c          | 32 +++++++++++++++++++++++++++++++-
>  util/thread-pool.c        |  3 +++
>  6 files changed, 83 insertions(+), 2 deletions(-)

Hi Sergio,
More polling modes are useful for benchmarking and performance analysis.
=46rom this perspective I think poll-inflight is worthwhile.

Like most performance optimizations, the effectiveness of this new
polling mode depends on the workload.  It could waste CPU, especially on
a queue depth 1 workload with a slow disk.

Do you think better self-tuning is possible?  Then users don't need to
set tunables like this one.

Stefan

--hoZxPH4CaxYzWscb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcrIFQAAoJEJykq7OBq3PI8qEH/iryfV2vz33+lmOKyk29N+b+
qk05411mD/cl8TAmQm05SIKmr9A0CNgdI0zCb8vLPtEadtV/yQA9wwFubTxcGKGS
fZwQljUFVApmcARAIBRgZRQVXmGVGZ1+n5NbsPN1m4bchjpS1JslVLRFJrybSJ3z
Xva4M4oQf/IL4OqDmhrJKQpFwPG/zBalvQEkQHPlsXdyR/ijpNl/hxA0uNW6ZCkp
a4g7s8by5i43v5xCuK8Eb41hmGa3vpnpTatU7hm6WlguvVZKFpFGgQEBFVM7kh7O
8kV5pJWbVKUACaf/C8mTeU12GIPiua6dXeijTya9x6kgmncJipeFMhtlx9T6N94=
=L82Y
-----END PGP SIGNATURE-----

--hoZxPH4CaxYzWscb--

