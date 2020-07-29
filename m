Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0EDC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 10:44:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8419207E8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 10:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TG0Phmes"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8419207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0jZS-0001Up-S4
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 06:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k0jXr-0000Xw-NX
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 06:42:47 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40549)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k0jXq-00045i-5Q
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 06:42:47 -0400
Received: by mail-wm1-x341.google.com with SMTP id k20so2423456wmi.5
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 03:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=aLxzbmQheGGj5wrPLvVqgrnkKvFXFMxKU72nCd0jvRc=;
 b=TG0PhmesLsaYJVnuyK7RyyYDtX09FAyuIKNIkfkdJPEGrb/U1albJG9IOKhWe7CRK2
 bBl8+oNonJniZK3r0o9mfEirOHBEWgjt5tzy6LqVRtfyfncK3sW1D3aA7JKYK5cl0OIj
 IJgv7cwlhFLMTaMwzd5/t5DM8rtWigjlGV0Ax7mnHBHcf6NfDLXYrcs77dBpVf7eN7Zf
 1EVae5IWPdZLiJDKXqeqN9r73hayxLcJ8i+eYQDjXbb+nc64o0uCOUEdoLdrraEZXK2i
 TulLlr5DLJZeBPsaXeBEPQDtrjadMJTEt7UGPFss+k6NnOyB+DSgh/XxFvRKBfFez9nL
 P4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aLxzbmQheGGj5wrPLvVqgrnkKvFXFMxKU72nCd0jvRc=;
 b=UoR0pVh+UrRTDZqYQnlEJC6VzEU+/v+e+LTQpY6nL2b74quNQQItSZtwqczM6B2bmr
 DEoEaJkd5QslK95t+6b3saFrzbX4F4kS03pRXo2wT6u8jbeOKQd+uli222Z4K+FzOFMT
 gF7rgvbybnkkIFLAgHPhxSVylUJVRjspf0su1N5lXlKUkrqvQHEkz8BPpU+evI3jjyQC
 WH7BnoW2qtYvM81MNNAeltnI91GGI2hPFeUEGnW92ndHETZl6NeVbqX7RvwTfzd0TFp/
 1DOjFK4GXS/yS6xopID0l3Fnl4PHs+t5O63Jq+5SgET2o4//soxxuUvA4EhkFesUXGcM
 28zw==
X-Gm-Message-State: AOAM531NUEBNV8TvKdgpca1BTONJcSFHwWZy0YYA8vaX0XBYiwEapTni
 50Hzo7MtMKJNmtWHpYzebX0=
X-Google-Smtp-Source: ABdhPJxP7wNmywRP2PgdJiTEVaiXTzg2XcsKfmtJEKGGYOKdZxYzt3pF3tgEja+ds47a33XAgq/U1g==
X-Received: by 2002:a1c:23c2:: with SMTP id j185mr1394420wmj.84.1596019364442; 
 Wed, 29 Jul 2020 03:42:44 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id z8sm4053640wmf.42.2020.07.29.03.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2020 03:42:43 -0700 (PDT)
Date: Wed, 29 Jul 2020 11:42:41 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Jingqi Liu <jingqi.liu@intel.com>
Subject: Re: [PATCH] docs/nvdimm: add 'pmem=on' for the device dax backend file
Message-ID: <20200729104241.GE37763@stefanha-x1.localdomain>
References: <20200715025429.28657-1-jingqi.liu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MIdTMoZhcV1D07fI"
Content-Disposition: inline
In-Reply-To: <20200715025429.28657-1-jingqi.liu@intel.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x341.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--MIdTMoZhcV1D07fI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2020 at 10:54:29AM +0800, Jingqi Liu wrote:
> At the end of live migration, QEMU uses msync() to flush the data to
> the backend storage. When the backend file is a character device dax,
> the pages explicitly avoid the page cache. It will return failure from ms=
ync().
> The following warning is output.
>=20
>     "warning: qemu_ram_msync: failed to sync memory range=E2=80=9C
>=20
> So we add 'pmem=3Don' to avoid calling msync(), use the QEMU command line:
>=20
>     -object memory-backend-file,id=3Dmem1,pmem=3Don,mem-path=3D/dev/dax0.=
0,size=3D4G
>=20
> Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
> ---
>  docs/nvdimm.txt | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--MIdTMoZhcV1D07fI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8hUqEACgkQnKSrs4Gr
c8j6QggAlVJzvaCrpX40kqBgH8qePZEm4XucTKQn+bTGzSlm7Q1qC011LTK2NV7d
rGrujdkZ3RcgbwGNC4jnX/6WpYXQXXlbikhjw3CX96G8U90J1EdaomeTuxxnUlzu
j8U2hx2s2CeWZFTZosIJfDjNzC5n4crk/jVL+K/QuB/9XkHuSL1omt/59P6/MdZp
oQkWp+clIrPza1smu/WGgMYQXnqQQ9NMTrhvyGnUOlvWLdrYLIRFz2gIfz8/szwu
3zB7aUsvtluv2EobSxG9CysFNvLo+gH7U2h+2pt3xXSwnWWW3hRpKqKAYpad82Y8
rb8FgiQnBXgU74cu8URXxa8O8bQviQ==
=kbzP
-----END PGP SIGNATURE-----

--MIdTMoZhcV1D07fI--

