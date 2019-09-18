Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8102C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 09:23:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74072214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 09:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDnokD4b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74072214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAWBC-0000Yj-Ke
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 05:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iAW9n-0007ri-4e
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:21:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iAW9m-0005g6-61
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:21:51 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45053)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1iAW9l-0005fV-VB; Wed, 18 Sep 2019 05:21:50 -0400
Received: by mail-wr1-x441.google.com with SMTP id i18so6038006wru.11;
 Wed, 18 Sep 2019 02:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=mpLWiORolXcg2AC+7bGIrO5UBG7wuQ0MQP49c2wu588=;
 b=QDnokD4b9APx/XGp6dhZMQ+v34ELgFvA/XGxNXpVKajUtLH1GcBCA9iInPQ+L+1c6o
 OOIZ1GSZsVv5hb8mvQzBMKkAb4LOJEyXw1ayu9+ZizqO/Y0RFVkZ2HWqIXYiJRYIYy4d
 uZ4m14UYW23zbcSpA8xfLD/ZT+SljVFcUV1dycizDyNAPzTF5kpKc+N9vxEDVOmOjnp9
 Cs6CRam8ekMxj5R0ebGf1R6+qn0RI5wa8FZ7fVDOaW6Sw8bC0Fltr7vLIJ1mUYomgDzV
 cRCXO8vPcj5bDZoQznX1bd1QwIXcF/fWxannF9Hz6yNTktsOsZyS0wKrpcQGuLgJ0do0
 hzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=mpLWiORolXcg2AC+7bGIrO5UBG7wuQ0MQP49c2wu588=;
 b=Pq6UFh+kvc1kIQDyqdcdDAp4wO6MDbq2h5BYvRcit3IsQn/t0MyODgqrf0EL+7Zfzv
 PoWwLt1DG5HOK9Fvq+ufuxpGN7HCDMVuJIdm9NrCVVr7E8bPpT0Ztc4735C6umhOZze+
 YqtFxhCQzqiwylSGAryCqL3WfT2Fgh3pptM4KF2wlGHjEiet8nYZzbz4i2vKRIZZnS2L
 D6JiSy79b+fyLl+QJXE1R+cJ8KLMM6PgG4IMp3V4nb7CknMQwS8ISAWZNi3t9cpz5RRs
 FQJ9GgR+kRyHCYK4NAXJLlb5ruDCagsenDKtOLjpAlUTayAoQRGYyx9KC68+mQu0hHiu
 Jj0w==
X-Gm-Message-State: APjAAAURDL9NqJxi12BlRkKAUNT4hpnp+I2iziZQ3Pd0eODIKy89M/Q5
 4ZnY2ZoTgWshtF+3vkww86nUXo7WlCU=
X-Google-Smtp-Source: APXvYqzR/IX1o2VC+WznTJfFfX29nPocRx1Is5BtV8De4PRdEbFQKxu7tzrkrKQWCURZJuJnxgBJJQ==
X-Received: by 2002:a05:6000:45:: with SMTP id
 k5mr2291798wrx.259.1568798509036; 
 Wed, 18 Sep 2019 02:21:49 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id w8sm7572068wmc.1.2019.09.18.02.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 02:21:48 -0700 (PDT)
Date: Wed, 18 Sep 2019 10:21:47 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190918092147.GB26027@stefanha-x1.localdomain>
References: <20190916095121.29506-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
Content-Disposition: inline
In-Reply-To: <20190916095121.29506-1-philmd@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 0/2] trace: Forbid trailing
 newline in event format
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
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2019 at 11:51:19AM +0200, Philippe Mathieu-Daud=E9 wrote:
> Hi Stefan,
>=20
> I'v been confused by trailing newline in trace reports,
> so this series aims to fix this, by cleaning current
> formats and add a check to catch new one introduced.
>=20
> v2:
> - Use regex format (easier to review)
> - Added R-b
>=20
> Regards,
>=20
> Phil.
>=20
> Philippe Mathieu-Daud=E9 (2):
>   trace: Remove trailing newline in events
>   trace: Forbid event format ending with newline character
>=20
>  docs/devel/tracing.txt        |  2 ++
>  hw/misc/trace-events          | 10 +++++-----
>  hw/scsi/trace-events          |  2 +-
>  hw/sd/trace-events            |  2 +-
>  nbd/trace-events              |  4 ++--
>  net/trace-events              |  6 +++---
>  scripts/tracetool/__init__.py |  3 +++
>  7 files changed, 17 insertions(+), 12 deletions(-)

We can continue the broader discussion about whether trace events may
contain newlines in string arguments (John's AHCI case) or in
non-trailing position in the format string.  These patches look fine
though and are ready to go.

Thanks, applied (with Eric's typo fix) to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2B9ysACgkQnKSrs4Gr
c8gfLAgAuAxzkRz1M/ZAvq3svNEwW6mBGGxS477rS1kZyE/5ccjMovmKDmnbEng/
fUPnteQSoP8bp7LFWcTXAAmPa9qOxIdNuxrUcQGDKsWYn4HSsD4zOY3Bwjk8nL/k
4g/vgGOI3g6o5E9jEzlTqUEqzIM0KRNdVuXVcVsJStSNJwQoM3DFiLxXg0ZWhoT4
9b6sZjL74WbZ/HVDlGfJlw8oPEgiA3L2MmfyxXqzHYqp1LElSH0GjNLzGg8MdJsw
crEZdzGvUy4ppIYMjnqJqVRkK95/6/g/49WEql5+9CcjqZpRgNMZZjUjgTXhvN4j
3eZV2O28Q/AQooUmQI5tbF9hxNZhlg==
=37RP
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--

