Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22227C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 12:50:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E106A206D8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 12:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0RnYHTN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E106A206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0P3a-0004Hu-3L
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 08:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k0P2y-0003qf-Gk
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 08:49:32 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:54776)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k0P2w-0003mO-VA
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 08:49:32 -0400
Received: by mail-wm1-x32f.google.com with SMTP id d190so565118wmd.4
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 05:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=I2Aje/9fWwM/axs4cLx7AyK6EHxhwAn+NgArgD0BrbQ=;
 b=j0RnYHTNmg8fZtsmQPl5leoC4EUGc57auE3c/nALbh5iezOJLn0lPRwehkLoX8bTvA
 yYlbtoIhEd05Pa3QtOUbM2RC2zU1OHIScgSuKKTRt5/YjV8IouwQrq20kfdGhF7QGIDA
 xovd/yD6aemLd3M9pCro+eEuLrZpc2JZ8WEFRom1OgHHpGCRiDwcegC6Mzl3It1JDnHK
 OXzf58gHrdkpd4xjySTm7RgxnYP08gdeotktl8Eh4o+FZ1a6HNpu/ie2W72t1KVWm65+
 9nr4zclkQVAeRdckdlWKTZIdtE8acfQpIJjNsXKGnAt7+8Dr5p6SC3Nw78CBiUMp2zfP
 kd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=I2Aje/9fWwM/axs4cLx7AyK6EHxhwAn+NgArgD0BrbQ=;
 b=H2n2DxEI/bJeg1XqISdAEJeUnY0SBA/UTPnaCkkSo1vxdMD7/UgK6XfGoBV9LPOb5/
 yNBqKJZ42WmnlN2bD+1ZRe9iPPwnlZAwFOzToNZzoMc5d6NYl08cfLoSuo4kellDYewE
 IszIYZeJLE3jlkZiS46bZWlcMjsuWyoyWpNSwZfhoelvB7JXYiDhtsgzNedX9A6B6hFb
 RYr15Dz2Jk/kdyDqcCz6+oPlUC9g+ahD3kVUjVZ0DrR26QRWSX4cdTpCxunPitwt3ifJ
 +xlCg45QBb8yS1NV8a9fR8o4PZSjunZoIkYWT+iALxJQ34fmHQYySaHbZxSQ1Vq6lq17
 KNvA==
X-Gm-Message-State: AOAM530URqX93WzzQlnTjqgz38FU7lrscb0WwJSjeWxFUETduWZ+WWNl
 tnc8DH4X2lH6TGquV8jITUk=
X-Google-Smtp-Source: ABdhPJwWIx1vm6gmd0GI84uNg/F9ApujlgAQaUuGufaybv30TqmsYz9ixuThXA5y0LVPNQ721bQz1Q==
X-Received: by 2002:a1c:7e44:: with SMTP id z65mr4174689wmc.13.1595940569403; 
 Tue, 28 Jul 2020 05:49:29 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id g145sm5951957wmg.23.2020.07.28.05.49.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2020 05:49:28 -0700 (PDT)
Date: Tue, 28 Jul 2020 13:49:26 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Karaoui mohamed lamine <moharaka@gmail.com>
Subject: Re: Questions regarding the usage of the QIO API
Message-ID: <20200728124926.GE10336@stefanha-x1.localdomain>
References: <CAEEuMqfOGyMrF7kCSVV5w5SA1waGb+Jyn1oUGkKngS3+qqJyjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JBi0ZxuS5uaEhkUZ"
Content-Disposition: inline
In-Reply-To: <CAEEuMqfOGyMrF7kCSVV5w5SA1waGb+Jyn1oUGkKngS3+qqJyjA@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x32f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: danpb@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--JBi0ZxuS5uaEhkUZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 02, 2020 at 11:58:47AM +0200, Karaoui mohamed lamine wrote:
> I am currently debugging a problem related to the usage of the QIO
> interface (qio_channel_closee, qio_channel_add_watch, ...). Where can
> I find more information on the internal working of this queues? How
> does the "watch" work. Is there a thread in the background handling
> these operations?

QIOChannel is based on the glib event loop:
https://developer.gnome.org/programming-guidelines/unstable/main-contexts.html.en

Stefan

--JBi0ZxuS5uaEhkUZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8gHtYACgkQnKSrs4Gr
c8j0wwgAkFVw1rkmGWAVtHyOVGZ9TNtAmRFvKRZgyh2uIS2ic6YnoybqqSYB/+V1
fRneGY68az4hpeU8TMTrmCuEk4Y4NtJXH3/fpGscF5Wr8L5LG6lOF0axowsmsZdl
Nn6wHvIkEneHZcNDbnNo+/DHPvggyjePeLjWtO/vyDlHRzc58HLC205RN9SHR+9j
N0B2ENZGVF5IAqAsWnKdRkp3bPLVRC1pt/pmBB5kLpvXU4mMBKe+kcuXCiYT/LS1
VcUoje4iKJvMH3k6pKdBmELKgyGGF27t87L/MyGPiIR94FPN1H9GlKujYqqp2FoK
M/KsyeImtfstjbZ8kZr+zPFsa4fMTQ==
=q5Md
-----END PGP SIGNATURE-----

--JBi0ZxuS5uaEhkUZ--

