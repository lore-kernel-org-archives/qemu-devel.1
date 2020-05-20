Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DFAC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 20:45:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA1D320823
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 20:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="REvlKdCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1D320823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbVbA-00082O-Ot
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 16:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jbVXj-0005j4-Qb
 for qemu-devel@nongnu.org; Wed, 20 May 2020 16:42:23 -0400
Received: from mout.web.de ([212.227.15.3]:38559)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jbVXi-00072E-QN
 for qemu-devel@nongnu.org; Wed, 20 May 2020 16:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590007330;
 bh=4mxVk7kMAqb0QjTJqBWNdZXrK3LObwX3IAZJW6rBUeQ=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=REvlKdCXE3llWFD5djYzAzeiOA14iKRFgwaUDlmtcL5ydbXGT13SoVsXa+kZt4beq
 hVJrb6LoYAQU5XyM8WVy2DOxx78Ma7LsN0dVcEaxQ2sYxaSdL63gsp2pOeJnZFFKms
 pHq6HtJNfKZ+JJG2UpJEIpvwhjD/sYg1Wr1rUXVc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.105]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQxnv-1jNWvl0J4J-00NxtO; Wed, 20
 May 2020 22:42:10 +0200
Date: Wed, 20 May 2020 22:42:00 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v2 0/6] colo: migration related bugfixes
Message-ID: <cover.1590007004.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_QT+bUPjP3ZCBj_nMK36oY=";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:pq1qzTll0V06yvcJWc5zDd3BcqxMaXjVRFTEiCRJVUoZeYQ2ZZ3
 /CmDVSg2ZM47kQMYEiuHzwaWFROVFIcRErAUgOb8fwhGNeJ3aJ0U8w+wtokD5EqeLZv49hl
 jSuhy3TSl7ONZ4EDk+SlJvUfDsY01mtI5FNvGIR3/nKhy9RzISsAiD9iZvaeVq2D9WT1fdY
 49WQvUU2tEkxg5QqfaTlw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n9mVGSsxFX0=:s/9Uzvu6GJEZaxZ5F0cH4I
 2tVpcM8SCCoQb1vjZ2IhSD42WSqmfbUE5Y12Cmj/CBkyr6uod1Oz7wHu30gAD16f9NJjl36hU
 HEFEymE1VoUD3KkK65dGj9P9Y8pmt0mDtUHB8bRMaPiwNQnwAM2hAG9Vyor2Hb8KMUaU/FjJp
 WPPHoWgnAiuFelCG8vfoda1H3DEZD/QmoTdNHVmGyLX7rjHEC+bHH4//s4VweIFavzCBiI5K8
 q6/8YfuMF2kPd2qRJ6ExLox2yEp9W9bfB138eOTaGRplOqxRBYr9lWP2B2YG7Upaq/0KSxwh0
 vGG+i0v5mnTkjOvyC34jhnY1BOoK3EHHfX7CmS9yR3LADRrdyzlbRy58wsM/P+/1Y6q1O0W3T
 P1XNCppu0szr3yNqdMK03qamvchOysFgn98PIv/CenxUrwxDWkM1WGiXwDeaCbV3t8ZAdIX2r
 vvN7pzrZ6NS6KWfvkqVdGpGG1srmo2RbsZk+1tfcCBhrWJrr2KljGAiSyVt6A3aL/9sWqdE+5
 dKtOsCkkdik/U8T9n+p760nz/gnvBfaXvsBeDWdcAoEHn6v8hIy93u4DwgNBflfrGDuz/Pk00
 5jdt88fleq9Hcm5oc0XG3ssWAWqCRkg0YEQKMIwNm1ZAxtKh8Pz0fDLM7Mv0A7fkwDcUhulZb
 NEMmo85Jqzz3x0mJR+Fr+VGFk2Xq/yPQORGMQ7lt3PpX01xO3mxvkGChLq85/2Gzvuj0+InrY
 Lu2J/5m8v/F9XazNlPVwwyyikZ8HgRt2UDzVW9q9ySHzXZn/hKoC3YSAuvoUhf8y2089XdFyO
 GpKxvJbmLyDhp0BA0zliiY2AT8KgHKfpZ1LUcG8NZYcOfEO6Z1CdnH5GpajzF8/nacIAVmN7w
 8OGMfn6dp6E10M6VLv9DSoOiigN0/VcHfCT2IBR/1h3iaw3lL+3rO9C1jRY/8lieCg20nJQeY
 HHGedeEf9+IzcCmA6Jq6pBsATymY/dQSnO3NuBc1jWNbeA9ukCIJxsTK1nHBw2gT5LQTE/uLQ
 Xsg01fWZ87Ca6HDuUo/zZJA/zHq7oHRvjVdEWFyW5D2YKr090dWM42heSwgrubPOw8Gn/ud5N
 Ge/hsLkKCgL786YgFdKp3WL7Q8JdYk4l+8YJ4szYTnm2dUFvLkgodwQS0ErkP17ZmePXb2vtQ
 QF6QlLzRdCNhvyOwY3DkapxkPQqoq2xl976o8q0Z+RjYUCt4Sfx8PCbos2C4DH+1PXE3kJ1J+
 INlgjSEEX7iW/zTjZ
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 16:42:20
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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

--Sig_/_QT+bUPjP3ZCBj_nMK36oY=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello Everyone,
Here are fixes for bugs that I found in my tests.

Regards,
Lukas Straub

v2:
 -Don't touch qemu_file_rate_limit, solve the problem in migration_rate_lim=
it

Lukas Straub (6):
  migration/colo.c: Use event instead of semaphore
  migration/colo.c: Use cpu_synchronize_all_states()
  migration/colo.c: Flush ram cache only after receiving device state
  migration/colo.c: Relaunch failover even if there was an error
  migration/colo.c: Move colo_notify_compares_event to the right place
  migration/migration.c: Fix hang in ram_save_host_page

 migration/colo.c      | 39 ++++++++++++++++++++++++---------------
 migration/migration.c |  4 ++++
 migration/migration.h |  4 ++--
 migration/ram.c       |  5 +----
 migration/ram.h       |  1 +
 5 files changed, 32 insertions(+), 21 deletions(-)

--
2.20.1

--Sig_/_QT+bUPjP3ZCBj_nMK36oY=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7FlhgACgkQNasLKJxd
slibdxAAjLz9ZowsfhziSYsTa7ysH25Hn5QyOUgP/hypLDvuvenanVeZoXJEQ9km
iR8k7jZj2JsJZOlGziHNanmUL3aHEtw3KP/sX33iYvzn8RhrsKug8+KV6TJJaVPn
7pE8Dp4wrr3S6Mlx0c4JsxADu9Z7yr1/6iIWMRopTDt/RF+6SzuK6oLK2HFEp2FL
DSWx8sHdk1WzfEe5jG8BNd/0CgYmjPLpwZsYT38Slb0kag6nhMkItBrGEaeG4vCI
dH/x+jF4n73Z+ZPIk0MDECeIwQ6qwzlyQJiaEiHY5pwclaaevkt8Erc4ukSw1bYV
VzHcigldFXqMdO9g+wssGbls4R98yJrK9oAZoXg/184rYI5Yks7+msuDC9dRNrPj
hid1vrEp4MX89YNoSlGSZNscCKncXldy7Vn0xhUkILz3ybrFra3zcQVHEnTntMHj
X5NZxiDzQ4F5SKtsrAWyllsUdD0I4mgmmVph0pE/X389Hd1julUoXPuOm/oQKIYV
+39vNeDizaKlqDicPwpRiq+6s4POSSbXGREnG9cEALSIc4MVklz7NI/lcVlPlqb1
4jmHLVIGej/2T/UrqWiFpVyGv4QIsx8t5hhg9Be455bkfnBGHl2awrIMdSgw1TFU
m/lG+7Wk8rkHNGuTLYEOk+I18GUzqi73dStXuGj9u8VUX4GTYQ4=
=NbM2
-----END PGP SIGNATURE-----

--Sig_/_QT+bUPjP3ZCBj_nMK36oY=--

