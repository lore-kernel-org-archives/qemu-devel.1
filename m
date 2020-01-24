Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D098BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:59:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ADDA2071A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qigLY4sX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ADDA2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuwgf-0005Jp-Sj
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 05:59:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iuwfr-0004QA-9f
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:58:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iuwfq-0000s7-1p
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:58:51 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46518)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iuwfp-0000r0-PE
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:58:50 -0500
Received: by mail-wr1-x443.google.com with SMTP id z7so1411076wrl.13
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 02:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=3aA2oAJCoddA0oWD5ByGuYaJh7hr3TALbXKYum+YPsM=;
 b=qigLY4sXo8D2HMcF9+qhz+E5NXvrV1xXUsMpJFudwbGXXg//0XgdOc2Ut9c5ZM8SMo
 V3PoG53hlNca2SiV/Jky1Pdpwmzqn6vvSL8/8XpJLIcFC10TT6t6qBT9qzoiE9oISOOZ
 TxegEtQHPACBr2Z/i8eJnUUPt2aV4e8ZDBKrPQnHyBffuDFDkJfR61qumjv34u/uu4Ld
 Ne//IAnNJfThI306qttpqFK03h+Qa3eayMwdXHfa4E8VTihQbmkqMRRwNer/00TeLO2J
 zn9Sc+CWxNuhK2sVGP8/k6JqJT8qePPCwuwMuCfoMYWPU/ZFAXpu4bzQty2v4B7EPZZA
 cIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3aA2oAJCoddA0oWD5ByGuYaJh7hr3TALbXKYum+YPsM=;
 b=cJSjOAMKGs3T+x+8NK7RGMsMrAdAfP4SLYnzG0pnSwBmzWPAvP9MDTnNXZzv9xnCEi
 Kzwj0SNcYtS81zgcmwAfbknpwBsVJBiXSUgpWUtOQUgDh9+I/5Ilcg2nzKHEV6WPr5RM
 jx+QmW2y/8+bmXGI5lj3KFAcupGICeCUrzjwrMqitUcZSZJpiVJR/msuMatRFA8BHACH
 Z+IJyqeWIQJMDcGch0wxdo6Xngzeh4ggaqArOyBRW6Ow12W2xSu8Ofsr4ft/fesj9hct
 yGe9NfyqMhXKwOZJqc2wsMjkLETpYZPl070fnQJeeJkoMLr9KpQMD0dsGpduk8UlrEfN
 r7Nw==
X-Gm-Message-State: APjAAAUxwYjNEsP8M5MJelIZaj6aDX/Oz2nksoW+AeV/gIeue9lm0rJU
 fjXn/XeEaANXMmxbw1IK6Mc=
X-Google-Smtp-Source: APXvYqyS5uzVn4X2gyyRKKDu1h8kb+TM8Q6+amy8JvIj/j2zaHXsol/TZiPW8AcOD5R3wZ+3zOgb2Q==
X-Received: by 2002:a5d:610a:: with SMTP id v10mr3532673wrt.267.1579863528100; 
 Fri, 24 Jan 2020 02:58:48 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id v14sm6988484wrm.28.2020.01.24.02.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 02:58:47 -0800 (PST)
Date: Fri, 24 Jan 2020 10:58:46 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: Maintainers, please add Message-Id: when merging patches
Message-ID: <20200124105846.GG736986@stefanha-x1.localdomain>
References: <CAJSP0QX22cYJvnpb+zDDXLaYg0yY4CV3Jn5QY+ExxJyFcmQ3Gw@mail.gmail.com>
 <20200122122831.GB13482@linux.fritz.box>
 <20200123171857.GC5021@linux.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HKEL+t8MFpg/ASTE"
Content-Disposition: inline
In-Reply-To: <20200123171857.GC5021@linux.fritz.box>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--HKEL+t8MFpg/ASTE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2020 at 06:18:57PM +0100, Kevin Wolf wrote:
> Am 22.01.2020 um 13:28 hat Kevin Wolf geschrieben:
> > Am 22.01.2020 um 13:02 hat Stefan Hajnoczi geschrieben:
> > > Around 66% of qemu.git commits since v4.1.0 include a Message-Id: tag=
=2E  Hooray!
> > >=20
> > > Message-Id: references the patch email that a commit was merged from.
> > > This information is helpful to anyone wishing to refer back to email
> > > discussions and patch series.
> > >=20
> > > Please use git-am(1) -m/--message-id or set am.messageid in your git-=
config(1).
> >=20
> > I've had -m in my scripts for a while (last time someone asked me to
> > make the change, I guess), but it wasn't effective, because my .muttrc
> > has 'set pipe_decode' enabled, which doesn't only decode the output, but
> > also throws away most headers.
> >=20
> > I seem to remember that this was necessary at some point because
> > otherwise some mails just wouldn't apply. Maybe 'git am' works better
> > these days and can actually parse the mails that used to give me
> > problems. I'll give it a try and disable pipe_decode.
>=20
> Here is the first patch for which it failed for me:
>=20
> Message-ID: <20200123124357.124019-1-felipe@nutanix.com>
>=20
> The problem seems to be related to line endings because the patch that
> git-apply sees eventually has "\r\n" whereas the file to be patched has
> only "\n".
>=20
> If I understand correctly (this is a bit of guesswork after reading man
> pages and trying out a few options), git-mailsplit would normally get
> rid of the "\r". However, this specific patch email is base64 encoded,
> so the encoded "\r" characters survive this stage.
>=20
> git-mailinfo later decodes the email, but doesn't seem to do anything
> about "\r" again, so it survives this one as well. This means feeding a
> patch with the wrong line endings to git-apply, which just fails.
>=20
> Any suggestion how to fix this? (For this patch, I just enabled
> pipe_decode again, so no Message-Id tag for it.)

This might be a good question for the git mailing list
<git@vger.kernel.org>.

Stefan

--HKEL+t8MFpg/ASTE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4qzeUACgkQnKSrs4Gr
c8jUVggAr7IAY8xNP2P0aE9EWLqfxvFzKBOdBK0t72PTJlOJHmXsPi2kLfdhxlds
DHqcdmckLS1gRqMe1BmKY45iv8QCDRbkNHPKCY5lj2zSVwX0sjIR2Rl+8/EbYU/a
mCXqyD3Mlhm1kf76OHGw4D/w7lBk94ElAVy6OgprxW/2jM64ApNe0wOH5DPTRaTi
toqrVvtSNTPloCDgC+6mXGG//01Ui3GjyZv5clRogPElLxVI1llYYJiiTpKt33QU
d7qQtBlP4hEHiqM+kxkU+dSBboWMIFxR3sD6yPoD7m2iz7TTPwsJvp2O/lQkGUmn
R2/sEuhnv3ubsVeuFFnN5M6i6x0Bgg==
=4icb
-----END PGP SIGNATURE-----

--HKEL+t8MFpg/ASTE--

