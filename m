Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7543C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:48:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7767D207D8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="QuH1F56/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7767D207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbnRK-0002dB-I0
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 11:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jbnMy-0005K8-MA; Thu, 21 May 2020 11:44:28 -0400
Received: from mout.web.de ([212.227.15.14]:44837)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jbnMx-00017L-K1; Thu, 21 May 2020 11:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590075860;
 bh=SUURXh4jypd9G2t/iEjlri3DZHpTTvKrsSOE5CS2etA=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=QuH1F56/zmjJIRDMiW62LMvbDzSKFcer5sKVn55HfGCbdI8aszF+Vs0SUa/qcXG5v
 8+qsZCC+vYvCuCaj9S4LfiXaZn0oHfganSpIORrThl0IlFy3TfkawhBwuJ4zxoECxw
 5DSOR3+xAjTvGDjI6GPMjx+r/kJ5OnzQa8e4HA8o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.99]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MVtmK-1jZehA1VGa-00X3fw; Thu, 21
 May 2020 17:44:20 +0200
Date: Thu, 21 May 2020 17:44:19 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 4/4] migration: Add yank feature
Message-ID: <20200521174419.51909b9c@luklap>
In-Reply-To: <b3ca78c3b4b8ad903ca2f70795fc38218802afc4.1590008051.git.lukasstraub2@web.de>
References: <cover.1590008051.git.lukasstraub2@web.de>
 <b3ca78c3b4b8ad903ca2f70795fc38218802afc4.1590008051.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6.rtzgeIehzpFDWvs_MAiMZ";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:izJdfGEdFTjjZHuVThWgyLDs0PD1FTcbLzIo7aE/IJv5ekYOAvr
 DiU5PFu1BRz3Fkt5ZABzUMCoUJjwjU6QwXxszrI3A+sdo0ZgogrEfYNXhMO+8z+s9bkqJKy
 yNY6JtFjFVGmj8HAOuIpQRcIlJ0bFcJBvlAY0tBfVWXCKfUlJTbVgMa0LMAz6/UwWc0d8A2
 ZT9M4OGPI3FGPUaRYK0Bw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8UfWLW+Foy8=:IZyD7RDuXGuVfsowebc/hD
 PtA4h0rj+OHhqibCAkcmQwaC8BVb+J08sidmfvzaj04QsUHuAinW0j4Rpxn0PYz9GLLqYinK0
 Hdw+AEoRZeuDGDYe6yDysOTvHyh3Ec3o1WpC1PhCg1eegEexdTXkBMz2QaIbkiL8q2vmh1QaD
 Y5cbda24ZAa50oTQH8fAfiiQafJMaN4Qpojz0LuqxMSs99YAlFe7dDFZgZbcwkqsNTePbp/uL
 vdHB+5aUIWd04gLctgKE2GehwPLiuSQqxzXZ5HBeRjVK6Pbp0wyR1hd9DYFNL2n7lnAZlbbO2
 ZyEGSdTVYVWvvH9U5UvD3VoEyxCo0NX0HNucqqhp5Y1sokP9sUrq/T/Ebmql/2Iqsd9zCGcHH
 diJziyYFGa7zse96cO8vLxM2M5C8FSbkMUwNktGmGHQ1zzfNotO8rPwexeoCplEOg1u9R8BqU
 8l1kVc2HGAR/lioHf+7MwTkc4mt+mTzyKCFjfJWPlt62q0PQ9Uiw5f5uNT2d2uKxS/kha1G5V
 S3p0bG+Ja/OTVvWxI+42P+uRFFk6PY71/A3GQfk9OuX+eO3EPVdL1O6IQD1RGg+rfAXFkqCKc
 mUT0o9yj2+IYZdGrY59AI/s4Fwxww+R2VixYPzkEIKeRgnwBo+9YMqu3B6D9Jpoo6cPHD+bMk
 XFbsz/1CtVjp3C79yWTKP2H3aLDPMq7/afRjRJbkHg1iaUXJL3dVf0yk0KC7G/DbC/gjBckKo
 OrjeM8PIaSDGdPxy3hVu3750iTm8TbchQUR555fMkeoYhXew3LTLZNxcfZ6HeX87nCwbh28GT
 wRO2Zrcxz1KFNibQ7pRkLuer1aP5jcvh9orvWWvDcazQp/54+bzxgwmV4X0JY4cRYNK93IUFF
 jnHuhZN5TarcjEdur5nLSrLIKvl/PUmYwRTqnAVJvyVNFyxEg+7OQAe7zol1YDu5Cwf6YuO/E
 2dTo0os74M4yvRfMGlTkR8PKmgUSdcyAog/+Yqck/huTV7W71xewxJ5vl6UJQ/57jjCJagzLS
 /08RX9nqwyGwy6XIV1en6gD7FfjARpCXmRMvPbZxJTXQ05ELOoORcA8tsSGwuLNe+V07KTMOV
 Gk79wKZIhsdzcu+yTco+fekC+rWhD63bAVMIxDBMCfHPEfx5VE3qHZ6xG34AQlrqSTyT6f3Os
 Zvs3UTGXzUY8gmqAAoiQ4/O7kYeh+2IV8HkJpkNw41g3dwbj82xmMJIKcBFA9nvaJ4IAG1Vx1
 kLw0m1e2S7cYo5ycF
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 11:44:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/6.rtzgeIehzpFDWvs_MAiMZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 20 May 2020 23:05:50 +0200
Lukas Straub <lukasstraub2@web.de> wrote:

> Register yank functions on sockets to shut them down.
>=20
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>

Don't review this commit for now, I'll have to revamp it anyway.

Regards,
Lukas Straub

--Sig_/6.rtzgeIehzpFDWvs_MAiMZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7GodMACgkQNasLKJxd
slgLbQ/9EpNXzi6dvLR5WOMv6TgS+T/QOubZ5f1XcQ/M6jSeesfUNAx+tvCSbPGS
V06Uhuo+ZgVhGhXoMK6zNVPQaXNkWJnWmPC/fN7vQ7pqkdkjA9WB/MMzxJpAoLfK
bQjHflikSbwcUQKUcqFJ/nF4wkibqt0hh2CEFZFI7468W//FaW9CnF3WzgJiJTOs
izqnOvP9IVklkZLXU4Ljm7y2a0B18qvMJOQcLumEM9Zx7l0u9wUfMtduem4OcMP3
S9u+wwRqagWgThwphHDUhDkTSJ+XPxSqJQISkLvT9jJju18xLiHkukzGJIXDL7ql
RnEEnBC2Lo/1UBAYOJp/JKXC7RzsOkYZFmDe8gXhO/nWrD4tQycpY7lRu11M9NbP
4A5rwgyiv5Wq3qUP2bkyEsKpNFoAEaZWzAXkWImOINDjmUDTfLmXGi9Jf0Jbjsgk
0aK+ZWvtnRhw160Nf89aO7453FkV9HpnTTkoilofw1A0zxgSAtVegXvPpRLXs2n4
QmtAoAv1JauSK5OuChhSO62jxZSfG8RghGeZrmMlacGwXLQKQI7NZdqytiGn3sqf
s9y1BMSqUp4SB8O2utfxddbz0T16cYRs27gs8O06xlWJ4Y3sVSMDL5OJ2GObVexY
vVrtdE7j3ZIebO3AoL819AJRazLtX8IzfAqurLBAUrsNpHJ30vU=
=erQ5
-----END PGP SIGNATURE-----

--Sig_/6.rtzgeIehzpFDWvs_MAiMZ--

