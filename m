Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8F3C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:15:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B28832071C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmYsR2Gf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B28832071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVaw8-0007Jh-P1
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 09:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jVavA-0006ER-HX; Mon, 04 May 2020 09:14:08 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40526)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jVav8-00072G-Ut; Mon, 04 May 2020 09:14:08 -0400
Received: by mail-wr1-x444.google.com with SMTP id e16so15756394wra.7;
 Mon, 04 May 2020 06:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=AnRb0eZBrwoPn6RFXt5s6W3yLMQWDznSV0TSb1huZKE=;
 b=ZmYsR2Gfn7jJCpaVjic1/rz/FRaBdnOAus7VpU4J3l7PjRdf4gODcLcQsa/wW6jKBs
 gO9mXA7tiXzXta4LXEsWCt+2x7N4vTO3keiAawnXvJoIccHKl5Y+RtOEPziy1C8eeBGf
 3CahFT69wNrrPUdIxeQGzvA50TkFxkKc1RrGmLyEr0kcFROij1pF+CbRbe8VmA4XDHiJ
 r7obtQgH+Q8D6K0a+0h3L6SeSQ2zcA0CJMTkobjQQdpmG23ttEXulv1FPY0qdbWyYMN8
 Sx6YH94IxmhrRJbBq66vRnx01lJBMV/56B2yc75z2URyj3F2oIhkfyWhSSmFae8V+3zV
 H5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AnRb0eZBrwoPn6RFXt5s6W3yLMQWDznSV0TSb1huZKE=;
 b=Dn2WQtCaimh/bJt/6PQ6kdceyprSbs99u1p8Y9ExO3g1OBhe6NZ+tlW+cwlkXYtCbP
 Lf6Xd3eOWGGoOllYogLIH2GNXvIF1Ky81z5IcdA5wuwlmR/00bJbTjlxPMXAMu1KY/xk
 xiXDlMt4spJz7CJsayLNwPqOI9LyHPffLXpclwRvXbmqtsWPsbhuoAICJudsifhmTOOA
 3dDLOCHL8V+pruw2queS8CaDzhRFxmKoRuGgieR6vegO55AFg3dN0ZwcsFVXtF8SNomE
 R+5MkJijrh9Scxv+q1kYDtqjzp+I14YjTSZzxAjDyzpzdwYx3PimOpnX9F9RCyGRxUyk
 brjQ==
X-Gm-Message-State: AGi0PuaxvuaZXBR8ji7iH4kMmvGEs2DPSO5VojrxrFRoOgnhRQb3/B3/
 wgWjVV7/trsJnOl+at705iU=
X-Google-Smtp-Source: APiQypKKb+jGlpsgO9VhJO6spI5LN1wgpU/Wx3VvLKsdy/NTy3fETINepz3bQ3VaZco0ZdgSZ5m/UQ==
X-Received: by 2002:adf:ed07:: with SMTP id a7mr19804681wro.2.1588598045116;
 Mon, 04 May 2020 06:14:05 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id z22sm12774193wma.20.2020.05.04.06.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 06:14:04 -0700 (PDT)
Date: Mon, 4 May 2020 14:14:02 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] Makefile: Let the 'help' target list the helper targets
Message-ID: <20200504131402.GE354891@stefanha-x1.localdomain>
References: <20200423104345.5092-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PGNNI9BzQDUtgA2J"
Content-Disposition: inline
In-Reply-To: <20200423104345.5092-1-philmd@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--PGNNI9BzQDUtgA2J
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2020 at 12:43:45PM +0200, Philippe Mathieu-Daud=E9 wrote:
> List the name of the helper targets when calling 'make help',
> along with the tool targets:
>=20
>   $ make help
>   [...]
>=20
>   Helper targets:
>     fsdev/virtfs-proxy-helper      - Build virtfs-proxy-helper
>     scsi/qemu-pr-helper            - Build qemu-pr-helper
>     qemu-bridge-helper             - Build qemu-bridge-helper
>     vhost-user-gpu                 - Build vhost-user-gpu
>     virtiofsd                      - Build virtiofsd
>=20
>   Tools targets:
>     qemu-ga                        - Build qemu-ga tool
>     qemu-keymap                    - Build qemu-keymap tool
>     elf2dmp                        - Build elf2dmp tool
>     ivshmem-client                 - Build ivshmem-client tool
>     ivshmem-server                 - Build ivshmem-server tool
>     qemu-nbd                       - Build qemu-nbd tool
>     qemu-storage-daemon            - Build qemu-storage-daemon tool
>     qemu-img                       - Build qemu-img tool
>     qemu-io                        - Build qemu-io tool
>     qemu-edid                      - Build qemu-edid tool
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  configure | 5 +++--
>  Makefile  | 9 +++++++--
>  2 files changed, 10 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--PGNNI9BzQDUtgA2J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6wFRoACgkQnKSrs4Gr
c8h+rwf9Gyu4FIQ+zCZRInWW4GHT/urJ8Qpnctgi71UuE61xksRjxELp1zUs4lJp
XglTeXBZG8kgZqHeAc5/zzoko3uztcNZBYlFzIPCauCAvG6uVV/satFxrgc8vTl0
CcUuRs0ZPGQkDe5bnoK3+JH1j6Fy6ErE2/w7ncsgjoxdK8e3m+KdedXWRq9dDQt2
2jsUPC2nloJIix88o57LVFUlQeI77/15FqjM0imJNqN8T0NVZAg+Lt+lYmnhd4uh
neRcZSrqdhfbRVCk+G2nVUd+reW9jdtaCkNR15TJFsK6h1RuY3nvZIZz47GY9WjM
NV2nBm7E8BgPMu0RHHrRYrYfSg3DUg==
=zXGx
-----END PGP SIGNATURE-----

--PGNNI9BzQDUtgA2J--

