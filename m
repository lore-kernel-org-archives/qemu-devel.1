Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC16C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:32:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2879420721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="fyP+n7YQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2879420721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVYOe-0000CN-5t
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 06:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jVYKi-000768-09
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:28:20 -0400
Received: from mout.web.de ([217.72.192.78]:59219)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jVYKb-0002NF-T6
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1588588078;
 bh=8m327vC4mbzkn2Z3YsuDaO+Rj157s51JcvLBKqzMFhI=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=fyP+n7YQ7yZqmEKpEDZZVp7nMQG9K1xuR9av715C5u8nDqEt9IAJ1ATsUn3eOEQkk
 7RwQ47Bspxpb0G9aaag4W9iWjO3cSrvlAFKGBYpaYhL70Bis2tRma80QcfxRssTYAN
 Z3NzY9ggU5ILguAs4vJtqeRIoN1N6X9Mh0S/HlgY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.27]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N943B-1j7Ovq3s51-0161Na; Mon, 04
 May 2020 12:27:57 +0200
Date: Mon, 4 May 2020 12:27:47 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v4 0/6] colo-compare bugfixes
Message-ID: <cover.1588587700.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wK+pS.NC1/c1zChK=qs=Bst";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:di3Cf7VpRJDLM3H5J54M8qaB3Uv/CBH08d0mYeG4N7LX1z4aICk
 iU9AJjgfhoRQiK3ldjrB2bGbric0nqXjiX+FqOFLSvza8mYqQnx6KCuRQoI44F2Ru6t7IvF
 1f4MuoRMtp8GHrz0WLtP1hX7h3LHY9gRZf8H8QrTt7HludKHqE0QVEFIT7mpmv352UboY7G
 n9bviHPAH54mooHDAdH7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6ZOMH18T8tk=:1uLNkdrAuoKlVJm2J3vFWf
 DFMnUp7Eux/qbgAabuIlTgZiZ8FGhD9qgWiUQDJvQ7kZWWXWD3LqTshNO1y9hYHfD8JV+RWlg
 MhjYpSQ15PzR/SiTBa/gr/3bXmCbdjKVwM6G4rJ48IsBkTDUn+oqnJ9UFOBDoOUyU6wTeg/e7
 iRKqBB/tEgf+lGG8DS7Il4yLqTjpzrdXM2e8EkMW5XSI+xZZoianmhG2mX/08MokFBQpY3/xK
 fl3oZx/2HbcKNbxjStwmnlr8lHDvWlAf9SbE6OIvn0CkDcDrxpdZoeNcSESOJWVfsL92QZwUb
 l/Xxm+BYgjwm5BdkIS06Ikv6ldEqU17tnxt/XnF038aTUY6JMfdOwYGVM4hr326xr+IhNe+ho
 f6Pcge79Rwhs4cfZqHn6Ze5KlfBPVaGQOSuvTngFp+Kkf12FQ1pZZklnNaB/0y6ZOIkMeUah/
 ENXZeFYikdbjyrbkhnwwhUBVJPVXM/jHqKWQ82/npIxLDa1OehJecp+a0VFp2BE+Gu45r9FwR
 cyt59lm+upNU19ceqgRTDCXUVJ5fMhv/kqFz+L8BGwUDRxSCatMT9y/xk66UxFp2T0OidJehi
 FH1jJ/3ayPo7BS/VrCXZa8OpLgziaymmpbS8z+EcoILbrqKBiMZ421BsqF5i3+t+pUX56VMF0
 +EL63jdarDJcNr6MLYRNkMa7QYifjFLV4RAol3VdHxqhMxXGlWoSPIfg31zXRNVhMa9tNi1mL
 lrPS03scCjdg63NSyKAeHomAPAjZgHAQ7hKOVD7PL+BJeWwGSDivNU+ViKkred71YkZCjCE1E
 7JdnfS2th80hM7vU8GzMaJUn6gl6WaXfAOTJivfVeoCm2Q59WG+u9leRGEzJbg5F9ebbjIfnV
 iw/lFLh7Uqmy2mTyK4F/vfzOxnI7I3U89CGtFTGLVukywVwPW5vsdlKvXrYwnlHZzwyOu8i2f
 W2QiAZ8VVnc0WwL19ixjm+QIVKiFLSSKHnv/q7QweRNGgxcxHPRjyi2qWpG6lhYhaTAlpVqbx
 1yE5Tcc+RhPCieRDxnKqI750u4ezdFQt1DEQxpGAY0ZTUEhGic8T9sb+ftgTRAYfhKmOafrmi
 PUzlx/x2okrhVrHkSh4BU1QLuFx9kjyIsAyDrn1VWhEX6carGQ6Yr2gQvV+zb9a4cj5NgQ0Sr
 S1FwQhSE8nJANh8ynTbxRc0xQPGpdb0x1bSbbORtw+0Jkj2V0lzj5iwH6hQfZRgtbBLMHuoIV
 FP0iYtAkRDEHSJomw
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 06:28:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/wK+pS.NC1/c1zChK=qs=Bst
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello Everyone,
Here are fixes for bugs that I found in my tests.

Benchmark results:
Client-to-server tcp:
without patch: ~63 Mbit/s
with patch: ~66 Mbit/s
Server-to-client tcp:
without patch: ~771 Kbit/s
with patch: ~702 Kbit/s

Regards,
Lukas Straub

Version changes:
v4:
 -fix potential deadlock with notify_remote_frame
 -avoid malloc and memcpy in many cases

v3:
 -fix checkpatch.pl error

v2:
 -better wording
 -fix performance-regression in patch 3 "net/colo-compare.c: Fix deadlock i=
n compare_chr_send"
 -add more bugfixes


Lukas Straub (6):
  net/colo-compare.c: Create event_bh with the right AioContext
  chardev/char.c: Use qemu_co_sleep_ns if in coroutine
  net/colo-compare.c: Fix deadlock in compare_chr_send
  net/colo-compare.c: Only hexdump packets if tracing is enabled
  net/colo-compare.c, softmmu/vl.c: Check that colo-compare is active
  net/colo-compare.c: Correct ordering in complete and finalize

 chardev/char.c     |   7 +-
 net/colo-compare.c | 250 +++++++++++++++++++++++++++++++++------------
 net/colo-compare.h |   1 +
 net/colo.c         |   7 ++
 net/colo.h         |   1 +
 softmmu/vl.c       |   2 +
 6 files changed, 204 insertions(+), 64 deletions(-)

--=20
2.20.1

--Sig_/wK+pS.NC1/c1zChK=qs=Bst
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6v7iMACgkQNasLKJxd
slhT7g//XGqjRP7xuAQj8F/AU6nN3KPnVbDHEV1ddUk2R0ObBRHbc9BZeZin7YA2
+Y9oQKt3ui34aK/DGIKPMzWZwWNzC4MvFbZ/IL+kVvfNza02Sih+mSar4Z+h+Lao
7L4rsIP82HqH4jiNLbm2cuVFPjq+NH9jgHUatWHAIFArre1tpivtG19Qi2kX8Bkq
GoZlLHEVZO+P3F1QDrz49nYRftjisxc+dqxWnZXVgrtUVeLAmhq3KyiUUj7dZ3yb
OsNDEBJE0ndj2A5HTOXz7dcIdF+ZE71KdPoicxl4Ck9JtIzFytVwA70J8OBDeTgq
Z1uwr9QKqxq66aWcSUDGDolOW+olCDkAz0WhWj5TBac0x5r+jPwd3tyyE9hHAW7a
/2SSKjynPQS2ejLkSGZPZcXIZdWuHLnAWOII2Ryih78uKxetGpgiJS6SQPrs/Rsx
VXheMno50oZLyKlN2vnzcQ/S29Kj3BRzsqaEAadzx6wtqQ8tRnLp1ovKmKxxVmEL
pk0yXK8xl8igZpKIqZeUaTLcgpHLnJNc5pAp+RAfUSpTmc+/2r9lMOvs/vIuyh0B
am32cbjtuKWoPIu4sQQ/sfN0fCpaC07RPX/nx1NBtoP0mVOTLJZ03E5kB+1gDqLk
rdq2ustWcn6Bkh3kZgXHOem4MdELV+R9rqs3cxij/U1stAMSeWA=
=AAKs
-----END PGP SIGNATURE-----

--Sig_/wK+pS.NC1/c1zChK=qs=Bst--

