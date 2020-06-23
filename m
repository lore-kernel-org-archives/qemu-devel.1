Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE7BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:06:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0587720774
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mngUCcGx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0587720774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnkVb-0003c0-58
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 11:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jnkTw-0001i0-20
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 11:05:04 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36980)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jnkTu-0000av-8q
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 11:05:03 -0400
Received: by mail-wr1-x441.google.com with SMTP id a6so18935237wrm.4
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 08:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=lU27h3focvbgoLfr0h4prGMxg1a7SxSdgbHNcPtkQBE=;
 b=mngUCcGx/Kfwc6M9dRYN3b3MFgPNgIDBGPOZU9WFrxt0GaxI8I6zinmXYt8j8qcMya
 htOjg07dB16E7xefQmcE+q+/wwFfHQhfHC8A2FWHwez3jAcxUEsgMdSLgcc6SfhFgcfq
 cCAFvvjURhH4pISTOmQ5F5JgiWEdz0BE693XGHt/iuWNLLSq4jjAr2XXJJueoFXHSlUB
 9lsQxzB/xyRvkzrIiz9ONX6Q9TlJKRbUkME2jcrXFROEvqyBEtidQmEQ5fptrHEu4knj
 MEgpr/QpriCQ24P5a5JsdeOpi+EwtxcI02Z8Gsuk2hyYNfA+5XwOeGWohPfp+44G+x8W
 MVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lU27h3focvbgoLfr0h4prGMxg1a7SxSdgbHNcPtkQBE=;
 b=ClismB+pUjfotO6P/hhFLXYsfdwGWCpZ+gQMa0RXebeFC3EZRuQFcZGDsmRbw6/0Hp
 Asn0qm6SaE7UzE7Rlob6kit2buDc/Mn2O2nSGU7I7lVTi3IarbSn5eTWWAepfejRHBTS
 VxDhptlLoWent3fo5wcFp6MFvUu82/scpFNT0I8RoMQ/+ijqQaoCpZ+fEfEwwnSf72If
 M/Utn+nQPfno1Zch2fHiNPcqDxZuMyvZReHvuTn3NMAxOhW7EVztKgSA10GCtXbI6QfD
 CDuEz9Ow1WBNhkJAbGrZIcMWoED+2aPh5zwxTdsdzwZa96DaDFb2azkM8yJ8pjHPFDR+
 QG4A==
X-Gm-Message-State: AOAM533I2IYavyMiC5eLse7ZnWYJyPcu/4xQDM/NPUbx6xmBq5yWkcB4
 HKqgkJwu4e2FUeabuoTx8sU=
X-Google-Smtp-Source: ABdhPJx76PMh9Zh6fLZBGbQsVekKRNp6M/+xuOugKdJmpMLxu/qHCl/Riv2cL8gjpOJ9O8ZtbfgZXA==
X-Received: by 2002:a5d:4c86:: with SMTP id z6mr14250913wrs.345.1592924700510; 
 Tue, 23 Jun 2020 08:05:00 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id u20sm3970662wmc.44.2020.06.23.08.04.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 08:04:59 -0700 (PDT)
Date: Tue, 23 Jun 2020 16:04:58 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v4 0/7] build some devices as modules.
Message-ID: <20200623150458.GU36568@stefanha-x1.localdomain>
References: <20200622135601.12433-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="H5pgEA8DvTwLpheO"
Content-Disposition: inline
In-Reply-To: <20200622135601.12433-1-kraxel@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: dinechin@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--H5pgEA8DvTwLpheO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 22, 2020 at 03:55:54PM +0200, Gerd Hoffmann wrote:
> Specifically devices which depend on shared libraries,
> to reduce the runtime dependencies of core qemu.

Just wanted to say great that you are doing this! Nice that progress is
being made on QEMU modularization.

Stefan

--H5pgEA8DvTwLpheO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7yGhoACgkQnKSrs4Gr
c8j8/AgAmZNGqiKYOpbeugii6kxPyE2c2nABwyspCVIdczaMyiqjoyr4JmaTEGmn
ETD9kNT9TJSNYalFnTsno+7NIBar+S/M5FkSNbqRRgItPahiYOmWqPlletLNe30O
KWzcjSanZpiISSPKXhv3mBgGAY421kBX1cWlQaLMx8wrNu4dS+tCaokuCA6Q4JIK
PWlksPIppZ/yJxU0qJW3PyT/Selko4pg+r3YZVlTwU+IDr7G1KkOsHM+/lNPROPk
IRUUr/sXVZwpFxxGbX4tALrFOSnlmzDj0ymASe9A2cDyl7R5OgUX7Ci1K+kn/zgC
DKf2Fg7t9MdvnH9wmX/4mr08RfJHRg==
=ffIu
-----END PGP SIGNATURE-----

--H5pgEA8DvTwLpheO--

