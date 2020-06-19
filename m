Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D484C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 16:37:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47A8D21527
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 16:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="K5YChjju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A8D21527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmK0q-0004JG-D8
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 12:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jmJtU-0000dg-UC; Fri, 19 Jun 2020 12:29:32 -0400
Received: from mout.web.de ([212.227.17.12]:46425)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jmJtT-0005py-DW; Fri, 19 Jun 2020 12:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1592584165;
 bh=St1j59LSnz4IVBAk9msZ/hohrdkyd1UVsM/s4+f1+bA=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=K5YChjjuTJ+zJpnHBxHdSpv1AXsi+p5tJBLx4XmnDfs3+mEhKiK4lSTH0TYmB8tlY
 Ecm0W58/75Bf8JxkrtpmirBHI9fztv87s1XsSQcq6gOyRnFFyl7L6fVm/DEsyH1/PP
 3du9cNU7Wy6SDHh0N0wsGf+qGOfDMlIOXUEYJw1g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.165]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LtWsC-1ilNUv1pCu-010qTP; Fri, 19
 Jun 2020 18:29:25 +0200
Date: Fri, 19 Jun 2020 18:29:24 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v4 1/4] Introduce yank feature
Message-ID: <20200619182924.7898035e@luklap>
In-Reply-To: <20200617151240.GM1728005@stefanha-x1.localdomain>
References: <cover.1590421341.git.lukasstraub2@web.de>
 <dc2724aead900db8fb3bed0a066f7c7e2654edb0.1590421341.git.lukasstraub2@web.de>
 <20200617151240.GM1728005@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jVE+tT8Sh_mdlovgU_6Pr1E";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:KRXQ+bXU8q97AqwsWcEKLOOz8vlGUdo+WxjEMK9xq982DXLTYN9
 WIhM++5iB+gPuwe+LecdqY42U0Wb/8Nk6x2rhnU4y5/wgzaUAim3lNDdC4KtBI2SuME999R
 k/2Z0iomoyS4YXn1RzxDAW0QFOdD8h/0DzviHCKqtwuggq2rdC+KAWLZtsedvbfaY7zJjbO
 Q/7/4vVBslUWrXPqy6OQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4WeV7zfiVDw=:8O/DUL8m+kYhLCu6DgmajS
 /WQL6sZOgPZwqVC5AHwxLFcluaDyyadxxT6BLFAuDcKFLzhVaqtHrZOfATAvunSjxgzIMfcWV
 XH+K7tskQme0CLRytBZIbECZBZbDsBryuIW/JrLw72n/DPTt1A/v7PvNz/KfNvP3Xo2yvYdsC
 X7qngRFTkMiLwWL2XNcqztnOtnMCxkSJcGIdnefsX14TZdBMOh6MSLRyFgEGCHULRYUNPl14w
 +PomS2PLzKmDKYkpz17TyW5b5czYI0qqA3sJTdFLBZsMtpwUmzbicZx/kskAV4vFaayGKDFr5
 WGtSylQ0rjsfTutP6y24qDbFYauSrdQ6Qz0L0tGdj0O8kgaDftoMlJtqg+L+Cr8mdxVkFyRah
 0OaJiZ86v1enfTc3KdtpDWfyc2F0jYmza734YmQIzWAAGAjuqYXUjVGqaWIxgwdfSbr2o6Wlq
 vi+chgJi9fVh+T0R/zC+SV7qaTO1BoBZCLVJZRa/RVTKrgptKdElvAgkdjFBreGH75dtQVMDm
 oKrxt8uH1+wfVyVsULxzt6HDvzB8hCy5oqZ1kLRzC6IX1KHVmJ6jZ9yiE4WHYwAGfBkFyUVN1
 OTK+fIv+cfsip56DX5xPJgD0w1lK0Kn5F9b8kNKzp778vd+uMBPtTHb4N/ECLZn4C+LXAhCVG
 m2kOswzDiBUpC0vJR7gyw0SXanyed37CIApHHS/N3bQx/R1KTpjuMHQbUfcngFhnJfXu9BaID
 m1qPzNGhPS/RHd5VfV60kaOXS2TylVmGQWu7OW+dc7bOpZuxCVXzTX6rDEPwivzVfA2AhiN5k
 E9n8vl3jFxJ0rbxw0+Q6jUheXclZ7bjo6iWGgsjU9XqOpGKDTPp/Twb0RXI9Fw91nA0HQF98R
 f2WqhgPRrC5e+xztfek9BJwibGgZWxZ0OgT1oHmvjOrz9zNkezh7aoCZLi9tVje1xP82iemAs
 ziCTCu2EmQKsg56AHz/0gLz9r/2oxlhG0csE2BiQ0iIaSZBFY1Ffp02jA1WHCLqaSJ2IVTVkH
 6ylZReWkU4VFKoRMe7/UqPeLTxDtjQwthWAI98nUfjtPz6rS7o0pp6x2myLYvk+sVz/gKW+Ky
 /ztjitHuOjJuNls/6v7nXKY0Q2Okl0EcGG4+S5pv7loAFEjw4oDB185zwPA/rO37WDsb5+CLP
 08fkuJ98xJ4MjMuXzGKpo2kS4uANeIJpkUtWog8LRgPtZIZfnGmbtGkl9bBSNR9bQ3cBCTX7L
 mOhL/DilbTjyP3k86
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 12:24:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 "Dr. David
 Alan Gilbert" <dgilbert@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/jVE+tT8Sh_mdlovgU_6Pr1E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Jun 2020 16:12:40 +0100
Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Mon, May 25, 2020 at 05:44:23PM +0200, Lukas Straub wrote:
> > +static struct YankInstance *yank_find_instance(char *name) =20
>=20
> There are const char * -> char * casts in later patches. Please use
> const char * where possible. Callers shouldn't need to cast away const.

nbd and chardev generate the instance name dynamically so it needs to be ch=
ar *, but in migration it's hardcoded.

Thanks,
Lukas Straub

--Sig_/jVE+tT8Sh_mdlovgU_6Pr1E
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7s5+QACgkQNasLKJxd
sliU5Q/+LHwqbyeQ6D7ZmJU35H7Q0LBAnuXkX75WblZOCguNQmjx6lqtAItyNQJY
SZyaRDasB2UNWSmyKSjzAeahZqP8HdGDYrg0qawAvrb7thdoA8wfH/HqUIX43GCx
lp2HiaeCnl2sFKvAqahY9HQVIncp6/lbBTvHdTGchOd03LcnQH+K2NpqQEv/D6sG
2juillVdb/f0T7pyrs6yxd8f2DvOBe7fgpaWnNJ+IodJsAFYM0Odvbk13B6jmwt9
EOQJlrtl+ZAhBy93W2Q3coojCj5eu8LzdTOgw4Lq1LD6PfJ5DyG8JtcIPtLG2+eC
MBKgx5plRQ+5B55hicrQBxkTRkvL0iDWrg+eaxhEijfXMeHnay0SEh+zwf9xnKhN
/vXgoaFVl6nwzYBaqTcskFB0MVzoq/lO8qw1rIqYZAgAbAYhzZnB3I2T/4oN6Lw5
VuYWKIdWTreB7uViCm3LuaxKImGVQ36GA1BEuYiXlkuN8kgn56392chSc4iVUrkh
5PEoDV279swP9F867gzZudtCBHjHxBXNER14uiNjj+uPY7MogAStMHnvb2dBuzo2
aa2/d4M8LhTC274L/5kTP52KRJhIVc0D90EXoFAGyvWGtDkQSU5Tlglbi14usq+S
dw5PspcRgxZj5sxG/uYDPBG6nDejFQ3Fhxm5/90aQNmZG/47ULg=
=dGr1
-----END PGP SIGNATURE-----

--Sig_/jVE+tT8Sh_mdlovgU_6Pr1E--

