Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84B3C54E4B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:15:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 800C220722
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="IPYisHWW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800C220722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY6Ou-00087D-DQ
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 07:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jY6Km-0004p3-Hy
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:10:56 -0400
Received: from mout.web.de ([212.227.17.12]:34251)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jY6Kl-0005kU-F9
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589195441;
 bh=h7cHtPLnjN4dSH0Rl7oc6q+EpVug8yB3vvCx6daQaSc=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=IPYisHWWWwpWm8SJeQ6OgkjlQhKl2bUH1gD4li5K2LlqMqEpVuzeDLHdJpn/uqhvK
 N5/gu6Li70LSVV1DmHJrhXE/daLmK3v6ekCI2rhkgqgrn/+3ND8plLqrMJLmFc86nB
 2HuqzIxKT/WU8POB6UT4JZD2bth3pGbbwbJKtWgw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.192]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Llna8-1iz2Yq3sJc-00ZOAp; Mon, 11
 May 2020 13:10:40 +0200
Date: Mon, 11 May 2020 13:10:31 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH 0/6] colo: migration related bugfixes
Message-ID: <cover.1589193382.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_czAUCoP3zPmJvNOZ8/pV7M";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:aYWW+2Ydd6t3DQ+hp/xpHlnKetHZcZ58JTGVwjrtSvrFfv3+qLs
 AY8oiMCtvO1vYf0fsyDj+uCgjAAjvrqrCRJZ2N8gbyakQi4lDDI5hDVnb+vZfaVB0YjHKdd
 EJ6BdrTOnYjdsLy5+Rchg7ESjdtCs9mirHVu/9TRq67vZRONskCi5meznbk5ma3GNMrpNqN
 rGGg8B/hLzUq5xQ+TBCQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kUnbbJkZdIc=:eDP3bU8Y1fTlCyy96Sy4Jl
 nn9/nUwatSqCeYEkK0m0imDjmekY0/9agYJvxZzSm1lAFY1swB5xJmSBMsqf2zzo7d1mClmrE
 tA6x535vaKOrKPu8oj7lRLr8cttww6tlS9vRzSvAl2LhgMJM3vDxbpywfdi6b8KSh4yPIEwtB
 i7GgP4s16lk0NSHGea7ZMU2Fs7DQlmSOLokAWdKQEc3s9k7h+mH22YzqE1Vy6DZc7wZ+GYg+2
 WuB1t3GWSjEdDt4EZQKPzl02igRH1UKvd4p6nLl7pxwhX0Mg519/6Li0tpUT4SetTjNNaW9+O
 ItMJgBrd0WOkprT9n5GF3zI/KqQ124ZmU8Jit4JhAa+mtQw7M4O2E9iMnVqJqVHho1mH19Ulm
 WNQTDeKz9gwCk+4v/YlGP/E7ZxcIfyX52sogF2+yPNu1PrMD0pUhYM00MUsv7QyZ7xr+DW+b3
 8KraeSIBVolrWnSus//MwS8kV+YoQ8tkf9bQO6i2aZvtR62QE5fWKaYJC2snKO4rRwlK/Xxjn
 5fKdZ2xecpMm2NGvY+hQyk5j/6ux71H03wAXkdaDRFFryNfduNb7mLKVqv7V6b5twShWo9V/W
 sz0rieNIWd8ONUlVbxoBtthEEZ3TW5T7k3EUEqjunwklQ3aD1Sodon++lx+phXHCGVjTRAmDO
 Oe/fU8hOkJLUwOcL1fSOxdDl4oWqQYBhsfGVOixoCNOEta2/UMLvemdxrNHo9pj1/cq76C5KT
 kv5IEHROAsOnQNSOs9koHIOU6EFB6pc0s9GvetbmJW2aW7/ckw4rXRnlQVSy3RsGkuQpIIBap
 oZCdml8ozlCVbkiQgYq0PuopOT0d0X5KZzUJQQj+wpVcSILxFXjTFP7gK7W74Rz2F5+B+Bxtq
 4IYA58d71OMzMkDYhA9+QBeEA7lTmJHwJqbBmtK4olZeAN+RaQeRPf5Gzjl7YOs0w/KnOisVO
 2QMvClmj9nHBewjuqnmopG8sKJ7tVVYJicl2fVrUpPXGQ98AESjAM6sJjnqtsGNmc9RvklFRi
 alY6WpMTOb2Rpw1b5xT6xn2gVQcIcQnXMJnSsTuRC33Qo4oj6tsh1mPptYz2H3Q0gCqApZLQD
 qc/b30IhxmOPsZQiVbEVssTfsjpuXkiQNNAhZwpGpjlEmSTMxzjomjRj9tk/4kdt75rV7YcJW
 Av4nOcvzlkJuH8VUnWqlF2qeZHGGZ9Xm4614KLhjAKf666HisA8lshmH9pdhExPv1GwSHy114
 2s2RU8h1JkwcbFdwR
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 07:10:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Hailiang Zhang <zhang.zhanghailiang@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/_czAUCoP3zPmJvNOZ8/pV7M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello Everyone,
Here are fixes for bugs that I found in my tests.

Regards,
Lukas Straub

Lukas Straub (6):
  migration/colo.c: Use event instead of semaphore
  migration/colo.c: Use cpu_synchronize_all_states()
  migration/colo.c: Flush ram cache only after receiving device state
  migration/colo.c: Relaunch failover even if there was an error
  migration/qemu-file.c: Don't ratelimit a shutdown fd
  migration/colo.c: Move colo_notify_compares_event to the right place

 migration/colo.c      | 39 ++++++++++++++++++++++++---------------
 migration/migration.h |  4 ++--
 migration/qemu-file.c |  2 +-
 migration/ram.c       |  5 +----
 migration/ram.h       |  1 +
 5 files changed, 29 insertions(+), 22 deletions(-)

--=20
2.20.1

--Sig_/_czAUCoP3zPmJvNOZ8/pV7M
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl65MqcACgkQNasLKJxd
sliD3g//Vi3QKo8okDEZkanns9J0nfHwmbwArbmqCgl8I/J0HVPgwIVez/mB5SZ/
dWYbrYKUKL9nK0yHNW9d0KD+kfPn23iFTx0jCqFtFUq8vmNNJu/NEehRT9mXk5Mz
dnbUiTbENDLyTebpoecvziNnGbP+18QfbK6PTin37lUWKug7UpS7dHoV1YsJDYBC
2WKbhcFnKqCRLrJXJ2LcgpnWyf90Gk2zlCfrKU7O8LaepI4m76TUCgbhourPweNp
wribDao8FXygFxq9kE6xL0uE/aFhWLKzJ6dAF9KF+ubuBwQzvWPa/OnIQ9ohNdOZ
O7zFZXa0JVQHH62GgdNycwAtjalhsUOZajgSM65aYTqMqP3lyUEfTYjHLQ+Bj0wb
4tKPr0sLlXgW/UorMMZIAgxThXgBKeOaTxe//+2uAz1nT/sub5p7a0CJcuuUoHWj
btFDi2BvPhssS5paq7sPWIj1jJX0I+M1NFpQLq3PwMc7UqrnIuV+MypJ0Qz30dln
gZlCJtf+yPCRrYRZgTumiW3TWKXyk7Fxpygkx5taGmOujpiWibCPq3aAb/KcZgGw
v4WgqGGzFY01kKSz5v2K6hCBbf1Y1OqZCcXmOwNGOP09CWMQtYJiaRQovaX4QJUi
ShVfGh1QkGf3iBU3wHEZbE5mHKXWy0xUQEeIZKaVS/U+t6VAiqU=
=6tVl
-----END PGP SIGNATURE-----

--Sig_/_czAUCoP3zPmJvNOZ8/pV7M--

