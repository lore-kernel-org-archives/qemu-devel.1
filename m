Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EB5C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:13:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A21B20708
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I165UW3n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A21B20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFwAE-0007jn-LU
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 05:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kFw9L-0006PF-6s
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 05:12:19 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:38449)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kFw9J-0003S1-NL
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 05:12:18 -0400
Received: by mail-wr1-x42d.google.com with SMTP id g4so2096917wrs.5
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 02:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=UlSOZRIKnPj8ZhSGeBPrN1HQo5MANA2QZo049vriwK0=;
 b=I165UW3n09XEGXvdVqrn+qiTeA57EU5Fjx6IidSjvsYwdnU3XORDa20oVr8UOqzmb7
 Ir6/TRSDEpupTkqenrOIkdNTkCTFecAvJYMuZ7imrlq4O1gchIBXeHHUIbkriRb635LU
 esWdTrrFlon7XJy3iCyTb6D1T9nwcSnj+aRtezy7cPd2c//U04dRMGJ/RMFn4j4FOtXu
 5IVdUcSIGXrbpVCozfH6792HV55/BzCsTmNqh8h2msxEzcbaqqoWQbeM369pbPYzv98E
 jRlmUD9EElhjSRjp1b1XDbhMulsdEtg8hnEuLdBqvh17ueJewYKO5yIul1r/gI2gML8D
 EwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UlSOZRIKnPj8ZhSGeBPrN1HQo5MANA2QZo049vriwK0=;
 b=H4q7ul8GY5uB6TwGopmPXfQHm2uBDW8E9lT3Gsj2ko1Vx3S9vKlaTwmexYZimewz9z
 RYd0/somhaWGQkttqHgyd2V7xg3wz45wtniw2TnL7f9m5tMSqQZ+W6f8HMCyflyZMoDN
 TZcHCqf0A9uy4iYPi3Vp8T8FO6qeWtfdT7Y3Yk0A29nJy0DCSEUZ/3iCPPdYAspAbSHu
 Lu9TVYENLOG+EnWTHMTDv9aNdVpfwltUWWJPqBFw6PQtfE4t4IMPmYkoEzTgVMUd/hqF
 fq9DAJkeQH9+9/3GAllcSlkOic18on+0bkalvQlk9iUNrx9KxJnbyiWvO8qJgSl4DWDL
 ioUQ==
X-Gm-Message-State: AOAM533aMcdL/LW2IDRsCXEKfT80JERNM9b23eGYn/ek/aJj+7N4MzKS
 QwTo08G8OHDU2OY4HYajDlM=
X-Google-Smtp-Source: ABdhPJwY5PS5dyCs0GoGKBSWI8wWuYZneHCdtaA+akRKZa7LHni3MGYZqMSB334eW5eVeoAIuBbniA==
X-Received: by 2002:a5d:4710:: with SMTP id y16mr2898882wrq.203.1599642735921; 
 Wed, 09 Sep 2020 02:12:15 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id b1sm3173751wru.54.2020.09.09.02.12.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 02:12:14 -0700 (PDT)
Date: Tue, 8 Sep 2020 15:17:01 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: Should we apply for GitLab's open source program?
Message-ID: <20200908141701.GB7154@stefanha-x1.localdomain>
References: <878sdp4ks9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline
In-Reply-To: <878sdp4ks9.fsf@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x42d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "qemu@sfconservancy.org" <qemu@sfconservancy.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 04, 2020 at 04:35:34PM +0100, Alex Benn=E9e wrote:
> Given our growing reliance on GitLab and the recent announcement about
> free tier minutes:
>=20
>   https://about.gitlab.com/pricing/faq-consumption-cicd/
>=20
> is it time we officially apply for GitLab's Open Source Program:
>=20
>   https://about.gitlab.com/solutions/open-source/program/
>=20
> ?
>=20
> From what I can see the QEMU project will easily qualify - the only
> minor inconvenience is needing to reapply every year. So far it seems as
> a public project their are no usage limits anyway. We are currently
> listed as 0 of 50,000 minutes:
>=20
>   https://gitlab.com/groups/qemu-project/-/usage_quotas#pipelines-quota-t=
ab
>=20
> So we are in no pressing hurry to do this for the minutes but I suspect
> there may be other things that are made easier by having access to all
> the toys GitLab provides. Daniel has already posted to the forum
> requesting details about how this might affect our workflow so maybe we
> should just wait for feedback until pressing on?
>=20
>   https://forum.gitlab.com/t/ci-cd-minutes-for-free-tier/40241/33

Yes, please apply. If there is anything I can help with, please let me
know.

QEMU has Rackspace hosting credit so we can run x86 CI runners. I can
help set that up but need input regarding the number of instances, RAM,
OSes, etc.

Stefan

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9Xkl0ACgkQnKSrs4Gr
c8g98AgAueo43foqCdIo2mHlMb1TBwRgEFnsh24LFRPp8QanDcxDI4m9JAoknVrd
4bxpHVz/UE6CbXaVE3PKOsHRmupVXTzJ95aHGDXQRAo1LW3wAsFwm500W7mxv7Gx
iTKw1SPJ6mo8T8crv0Kw1k7DzdLuU4lbvURtjgpWLwnKI62LD9NZE/HU0RKnUg1Z
TpxwauKm3RKVo9p5parpeOTmVZkckrsIuOQF+XJo3MWTzUlZmVChXyr6f+38wCx4
zXFWnk/Vss6l8420/uxozmetMiUPwr55vA+aRK+rNKyIPqf9reDGGKrdUln1BR4/
MalrSY72PDzrm0OQL8qGSL0PLT7pIg==
=iBHP
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--

