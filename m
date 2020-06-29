Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C88C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 12:55:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E384923CD4
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 12:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tf8QVc1O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E384923CD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jptJV-0007Yf-75
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 08:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jptIO-0006d9-2B
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 08:54:00 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45215)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jptIJ-0001Qb-HW
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 08:53:59 -0400
Received: by mail-wr1-x441.google.com with SMTP id s10so16392370wrw.12
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 05:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=avvZZCYQY47dzgtRr2kHEq4Nl/k+cSqzgkknq6iyYVY=;
 b=tf8QVc1O4SBaavnXfmEa4TOjYHM+DeDn9WFVXoNnCsz8FjWGopKHImzm2nVUauUyy8
 m1SUhqRn06qHvUzhk0VTmtUpbTC+MzfeF9SNgtm0sQbFZDBbY/MUTAoTWIpMKrXZWSvo
 LRH788aIcurpHPek1mst3p11HaFLLQjDTAHIlFm6SoiKJfMIjCBZGMiUWDFX7259xfgH
 N71KL5Z5ZV3yuq1ExDTozP9rqyJ5UOjkNQrgJXkmFd2wB82tQkukCQHkUumPTr2DPKY7
 +d/Vz74Z5rrCewoo1nRSyVg4+tQh75UDdyi2BqnFjwxRk+qIKvJembFbNGz5Yo4lGN+4
 PCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=avvZZCYQY47dzgtRr2kHEq4Nl/k+cSqzgkknq6iyYVY=;
 b=KwPIDisHzgNzsFCW9CU95y3+WqUqJlV4O++czvZJfJNUf5YUnkc26JXO3cbD+Xxb/e
 op4j/PEXdgUOpFlksGTqbs/kTCJEG6istXFN6iuir2B2gq8nDUbHTonG63oGdA9acxV1
 oS68U+VEuUjypDeddAXe7lr3re9JnmAjTx7/Vpx7bfCiv1uv5MvCBZiX+Rfc+JjLfOZA
 r99DWzy5xhq3fX22M/aL5nw3j3rUaijhJObOeXXk0LpfUn6XPYqpN1+Q5Du+5PZTHYvb
 h8x26XOV2tdbCPEtmSjYbG/qLZHXHaFTosTORvwSuSZF0SVlkAjI02IVYId1HpBBlFIu
 8jHg==
X-Gm-Message-State: AOAM533UGLbSn1i+ulGP6b+9AUxY+5baLqppoXrX3L8/Eu3rRXhw2IA+
 uM9N+qtz1me3kd8vZ7wzmws=
X-Google-Smtp-Source: ABdhPJz7OZ3yfHiZh4aYqForejpEmV4ymdieyRL+IVgQMbYzXh9LssHVxEtF5m7gMfJCbpgvBsgYOQ==
X-Received: by 2002:adf:c986:: with SMTP id f6mr17284729wrh.168.1593435234139; 
 Mon, 29 Jun 2020 05:53:54 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id m10sm28336146wru.4.2020.06.29.05.53.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 05:53:53 -0700 (PDT)
Date: Mon, 29 Jun 2020 13:53:51 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] tracetool: work around ust <sys/sdt.h> include conflict
Message-ID: <20200629125351.GI31392@stefanha-x1.localdomain>
References: <20200625140757.237012-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="k9xkV0rc9XGsukaG"
Content-Disposition: inline
In-Reply-To: <20200625140757.237012-1-stefanha@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--k9xkV0rc9XGsukaG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2020 at 03:07:57PM +0100, Stefan Hajnoczi wrote:
> Both the dtrace and ust backends may include <sys/sdt.h> but LTTng
> Userspace Tracer 2.11 and later requires SDT_USE_VARIADIC to be defined
> before including the header file.
>=20
> This is a classic problem with C header files included from different
> parts of a program. If the same header is included twice within the same
> compilation unit then the first inclusion determines the macro
> environment.
>=20
> Work around this by defining SDT_USE_VARIADIC in the dtrace backend too.
> It doesn't hurt and fixes a missing STAP_PROBEV() compiler error when
> the ust backend is enabled together with the dtrace backend.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> I am also sending a fix to the LTTng Userspace Tracer project to add
> -DSDT_USE_VARIADIC to the pkg-config CFLAGS so that applications define
> the macro consistently. But this patch is still needed as a workaround
> for lttng-ust 2.11.
> ---
>  scripts/tracetool/backend/dtrace.py | 6 ++++++
>  1 file changed, 6 insertions(+)

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--k9xkV0rc9XGsukaG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl755F8ACgkQnKSrs4Gr
c8hDpgf/Weo9rl7TfJs03u+g3aVQGimO3vuSudqkl5c2ZBj0squDULZATZqfAU+y
qWO5ZbSBVlpRKTWuoZ3P7nhjV7SnetE//JlbA4PPmJzVNOLFdNtX+RDkx2MJRNMY
mYivrXY1P42VE33HF6k5U/XYKNAG1ELxeXCfq2gDwxxXx4P69GNHjsyrCTH6CiOg
Xp+Y5mCys7UsQ9yJ3PcC0auXsUbvSilD34F8eojmwGu9ZtiXRT1n43CJlBno79UH
RnYPXv1UDS9WoWm1n70M5IsPm3X6M25oPwlaz/EdQh3O7fbeDFaxvs2Xn2chIVgT
FCYF3l3aU1stHICcZeCCIr36e9QQag==
=DzqU
-----END PGP SIGNATURE-----

--k9xkV0rc9XGsukaG--

