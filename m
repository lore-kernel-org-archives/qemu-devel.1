Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B495C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 11:24:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B83720880
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 11:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="is2G9vWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B83720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39337 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDorM-0007N5-Om
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 07:24:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hDoqY-00075w-Ou
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 07:23:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hDoqT-0000cO-LI
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 07:23:22 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>)
	id 1hDoqT-0000bl-8J; Tue, 09 Apr 2019 07:23:17 -0400
Received: by mail-wm1-x343.google.com with SMTP id v14so2879099wmf.2;
	Tue, 09 Apr 2019 04:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=bdcCYNR1q2XGqS33UR+SiMQo2z+e5Ieufy7g/wv0qgI=;
	b=is2G9vWPel8G/PG+pKA2u/KElYGMrCSYaqZ3C0EoXVIJ/IFvn8A67rLfq6eBkt1rKZ
	6RItTsQ2nNvrN3u4uVTmwqfrFQZJGL+RGE7pMYgpzNBgBhVS0nEGuC0lpRtOE2nwZk9B
	yggQCVYcpRe+Yhvavwnt0Q2eTIR/I+MySuH+MEPvVUjzUHgxbLe98+NkGlKj8gjkQtGP
	hCSq/MzAogfQSyhyKCG+se1T1t5qUw8Ch4lrjIilPvV2z3TABGOl92LHWuGLaAN5xzbA
	4z2ne6GScaM6Pog5kDPQSQMOLICFYAdlnVCv2FKToTmzaceMpexNN5GUrq2sEySu0x39
	EvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=bdcCYNR1q2XGqS33UR+SiMQo2z+e5Ieufy7g/wv0qgI=;
	b=eQq6Aix04RuyQKI+GHbJKbwscqHkorMD9hTLIXAdKxWjWmIIWFA7knS6ms/h2eC7yU
	B1abtFR2WOsoa1uid8j/jNmln8PXtfxo4WgUdHSYunna5xr+YJca9hbNDc0/FU6qIqbv
	Dn6rRH8QWpvJC0ZX5S9vmIUe+NbRyqs0e60PUsLFoWTD0qf4nmldLbG2zFbB9D8Rijiu
	gXqO4owqxFtbfHYnhJwNIl+5OyqEyWZbImNSvpDNbD1ar1IEIcjRafBJ64qZdoFhzPvV
	CIdO2QXoeRQp7o6nbZZI/lcnxmYnDPj+KVqWKUf/uFWdBtwxhLu0gIgKPxkYMg7TlyAD
	RFVQ==
X-Gm-Message-State: APjAAAVbJbRbatizd/ho7nRc86QcnAX4/2/tvGmvnRcpfDIyoEO6OQIw
	gUjRKdTZtiIdsPsFrh006cU=
X-Google-Smtp-Source: APXvYqyQ9moDITvMBK1BsD6mvn494PDwb94WvsBIY/hSwnpKPyjV2gWVXC0PpCUzs3v4+Axlfxx6uQ==
X-Received: by 2002:a05:600c:2293:: with SMTP id
	19mr21365938wmf.77.1554808995669; 
	Tue, 09 Apr 2019 04:23:15 -0700 (PDT)
Received: from localhost ([46.233.112.222]) by smtp.gmail.com with ESMTPSA id
	y197sm18812042wmd.34.2019.04.09.04.23.14
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 09 Apr 2019 04:23:14 -0700 (PDT)
Date: Tue, 9 Apr 2019 12:18:52 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
Message-ID: <20190409111852.GC16944@stefanha-x1.localdomain>
References: <20190406040422.5276-1-aruna.15@cse.mrt.ac.lk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Content-Disposition: inline
In-Reply-To: <20190406040422.5276-1-aruna.15@cse.mrt.ac.lk>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH 4/4] Header cleanups: Removed unwanted
 includes from cpu-common.h
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
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409111852.EnkY3uUgElLLzIJHaZtKJYeJaLIffmGAeMlWffJBtSY@z>


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 06, 2019 at 09:34:22AM +0530, Aruna Jayasena wrote:
> Removed unwanted includes from cpu-common.h
> This task was under https://wiki.qemu.org/Contribute/BiteSizedTasks
>=20
> Signed-off-by: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
> ---
>  include/exec/cpu-common.h | 2 --
>  1 file changed, 2 deletions(-)

Hi Aruna,
I'd like to review and apply your patches.  It's a little difficult
to understand the structure since there are several email threads with
subject lines ("PATCH 4/4") that imply a relationship, but they were
sent on different dates.

The usual structure of the first patch submission is:

  [PATCH 0/4] qemu-common.h: clean up qemu-common.h
  +--- [PATCH 1/4] qemu-common.h: drop unused includes in util/
  +--- [PATCH 2/4] ...
  +--- [PATCH 3/4] ...
  +--- [PATCH 4/4] ...

Here PATCH 0 is a cover letter that describes the purpose of this patch
series.  The actual patches (1, 2, 3, and 4) are part of the email
thread started by the cover letter.  This relationship allows tools to
treat the emails as a single patch series and it makes it easier for
human reviewers to review your patches in their inbox.

If you send a new revision of the patch series to address code review
feedback:

  [PATCH v2 0/4] qemu-common.h: clean up qemu-common.h
  +--- [PATCH v2 1/4] qemu-common.h: drop unused includes in util/
  +--- [PATCH v2 2/4] ...
  +--- [PATCH v2 3/4] ...
  +--- [PATCH v2 4/4] ...

The "v2" revision number indicates that this series obsoletes the first
patch submission.

Please resend your patches and follow this structure.  You can use
git-send-email --thread --no-chain-reply-to master.. to send the patch
series.  Normally --thread and --no-chain-reply-to are defaults and you
don't have to specify them explicitly.

If you need help, feel free to ping me on IRC.  You may find it useful
to send the email to yourself as a test first before sending to
qemu-devel@nongnu.org.

Stefan

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcrH+cAAoJEJykq7OBq3PIdXYH/0Ry2IGRPtOjpvHkAJoS4VyR
ycCZ8cGS6rR7qOCKP/9BKOBdx71qAyAcp2EFtd1HYYAm28J3XXVaSnpcaDZ3q3ir
dBo/JH/z/WhsGLM8guNtlwiE//we2zCyAJWJgC6dGFZ5EuvsIBsWmiqJkopM+SZG
LIrT+DjgCNKSKJBJI31vwDL+OkqDsHtAYDc0cjQ/nKpkE95D6teAo9jyYye3QU9j
jsJicjSWbsfvk52SUCMIDtNjz96zJvYaMn/1vyhL6xiOm9lXRwYUEjI5WAFm4mRl
uLxMiYY9SMrEEMmkrKJbPvW7BnTkAYKFnsKiP11Rwns/zO2i/p8MdOBnW2YPXSA=
=n19E
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--

