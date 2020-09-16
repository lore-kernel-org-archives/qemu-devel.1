Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E01C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:11:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7777721655
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHmVRqnB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7777721655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIVL9-0006SD-7b
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 07:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kIVKa-0005xZ-JA
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:10:33 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:50241)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kIVKY-0002xh-BK
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:10:32 -0400
Received: by mail-wm1-x333.google.com with SMTP id e17so2372775wme.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 04:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=cTOOgJawC+D28LtZqTAkElvRwhrjcXoWLqGjM6pqQS0=;
 b=NHmVRqnBrGKMTdkzuAKvGPIgOI2vOCGnTi5DzV048v0QAtxePngcbsm2nqVDyUY6p5
 Shf7P8xE2CpP3ZDE06+2kQzTpYqYd4VQUZERDSyhzCCnRfx8QBiryKJdHTTFHVkxcir6
 xmpP9Pb9Tx/Qxx4z6v9ycH/yNNWrv+WnZu3zBXmDGrH7PAb0RhebNbw1/q9UR4YlJ9gL
 jeG7r7yidAWdC3s2XfYRl8Pf5gG5CuTquGYZDZ11nVsEynvNxL6Y/CzxzQXYcXSOohpz
 DAY82lS7uU+7MB4B4tBV3xJs1ocycxgBlDWN6QlDDKykPK+KLnRsW0gnLC6eoaeInJSF
 rQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cTOOgJawC+D28LtZqTAkElvRwhrjcXoWLqGjM6pqQS0=;
 b=lT14+cCfzbiID6DBaJB+xkg3n7N9a/ECLCI3jBrDAFFuRnWVz9w3zExb11r6TCbUsN
 +5p75B4dYToWJLxdtbfpHsGT8/LmWk2RJAgWSnDsX6yo3M8wnLRENJUz1F4JqMBlNxY0
 uathDz6JwTr/ysGfBwv8dACuuKx02RscIlCbAEYkiIsok5mT4p4j/Hiq4cXanapEfbxz
 OAeGSLwGvvwh7rs0JtvqBc6SNDQ9naiOqheAdOH1ZVmnjWnIXhCnAKuKmL0uieFfpYgV
 UMlIDQXsBnOywY41Yr66qGhqwKXKVbF0a9sjdqyJQQQlscslmVuOnwFYWJf9snzE8JCu
 P8kA==
X-Gm-Message-State: AOAM531yVLGziQxyJxX9RPA75BZ9j7BulO4MNQiNuHXNEg8AZroAuvgN
 jDI39jXRMmAlc31gxczp2vc=
X-Google-Smtp-Source: ABdhPJzNg5f0wBF+TO1WhwG9dTw5Ig/1ZS3lqGB567yrZ/sS78wjdL/RA7HV93AorSFRV1CqP5Gy+w==
X-Received: by 2002:a1c:e4c5:: with SMTP id b188mr3302884wmh.67.1600254628207; 
 Wed, 16 Sep 2020 04:10:28 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id a81sm5024629wmf.32.2020.09.16.04.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 04:10:26 -0700 (PDT)
Date: Wed, 16 Sep 2020 12:10:25 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: P J P <ppandit@redhat.com>
Subject: Re: About 'qemu-security' mailing list
Message-ID: <20200916111025.GA756728@stefanha-x1.localdomain>
References: <nycvar.YSQ.7.78.906.2009111910280.36374@xnncv>
 <CAFEAcA_9BVbqFCHJqS8jj6L3OqVNc60NCjAjRs516VyLH2EFfw@mail.gmail.com>
 <20200914101517.GD579094@stefanha-x1.localdomain>
 <nycvar.YSQ.7.78.906.2009151536090.10832@xnncv>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.78.906.2009151536090.10832@xnncv>
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x333.google.com
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
Cc: peter.maydell@linaro.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2020 at 04:18:47PM +0530, P J P wrote:
> +-- On Fri, 11 Sep 2020, Peter Maydell wrote --+
> | Way way back, the idea of a qemu-security list was proposed, and it was=
=20
> | decided against because there wasn't a clear way that people could send=
=20
> | encrypted mail to the security team if it was just a mailing list. So t=
hat's=20
> | why we have the "handful of individual contacts" approach. Is that stil=
l=20
> | something people care about ?
>=20
> * So far issue reports have mostly been unencrypted.
>=20
> * All issue reports may not need encryption.
>=20
> * If someone still wants to send an encrypted report, few contacts with t=
heir=20
>   GPG keys could be made available, as is available now.

I'm surprised the lack of encryption doesn't bother you. The security
bug reporting process should be confidential to prevent disclosure of
0-days.

I think it's worth investigating whether GitLab Issues can be configured
in a secure-enough way for security bug reporting. That way HTTPS is
used and only GitLab stores the confidential information (this isn't
end-to-end encryption but seems better than unencrypted SMTP and
plaintext emails copied across machines).

> +-- On Mon, 14 Sep 2020, Stefan Hajnoczi wrote --+
> | On Fri, Sep 11, 2020 at 04:51:49PM +0100, Peter Maydell wrote:
> | > want it to be a larger grouping than that and maybe also want to use =
it as=20
> | > a mechanism for informing downstream distros etc about QEMU security=
=20
> | > issues, which is to say you're proposing an overhaul and change to ou=
r=20
> | > security process, not merely "we'd like to create a mailing list" ?
> |=20
> | Yes, please discuss the reasons for wanting a mailing list:
> |=20
> | Is the goal to involve more people in triaging CVEs in a timely manner?
>=20
>   This will be welcome for fix patches.

Triaging and fixing are different things. Where is the bottleneck,
triaging or fixing?

> | Is the goal to include new people who have recently asked to participat=
e?
>=20
>   We've not received such request yet.
>=20
> | Is the goal to use an easier workflow than manually sending encrypted
> | email to a handful of people?
>=20
> * Current proposal is more for enabling communities and downstream distro=
s to=20
>   know about the issues as and when they are reported. Ie. heads-up mecha=
nism.
>=20
>   Just to note, we've not received any request for such notifications.

Do downstream maintainers want to know about potential security bug
reports that have not been triaged yet?

Maybe there should there be a pre-announce list for bugs that have been
triaged?

That saves downstream from being spammed with confidential info
that they probably can't use.

> * If maintainers are on this list, that could help with the triage and fi=
x=20
>   patches.

I don't think a broadcast model works well for assigning responsibility.
If maintainers constantly receive security-related emails (most of which
don't affect them), they will ignore them. This is what happens with
broadcast CI and fuzzing results.

Instead someone should assign security bug reports to relevant maintainers.

Another option is to let reporters directly contact the maintainers
(e.g. QEMU's MAINTAINERS file), but this is hard to get right and if a
maintainer is on vacation the report may go unnoticed.

Anyway, it's unclear to me what the motivation for creating a list and
changing the process is. Please share your goals and reasoning in more
detail.

Stefan

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9h8qEACgkQnKSrs4Gr
c8hEhAf/SUfGhhzQxDgxGk5IuErzcYXEGhph6vciDQTU4Do1T/j/nDiOybcc9Ay+
acCx/eoihtBO3AkLg2Vvjcu36G+bptRD/4eSHNoJqXV6A27YMxkty4gfEZLPZCvC
eVgZlOnBwn0286MbDvSn+mZ2iEiwZIFucOC+sgjrSsplPw+b3IFiGBbV4CJqHhdG
kVynd25VNiPil/Q8FIANPsSxi/FzpLQjO/Z9HUwhatuEUCsUKz/FSgV1C7p2UFFV
swgx3yUaLh+PYEp17Hrov8JIdAtbSudCBsm8yE9bes3IyGecDXEVmqWaO/8SjM/e
rF/65E1eiphkgVtN/mobp2nTgCpMEA==
=wq8k
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--

