Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AD2C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:59:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54A0420780
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="PmXbJZl9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A0420780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnkOg-00017p-FK
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 10:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jnk8i-00047O-SV; Tue, 23 Jun 2020 10:43:08 -0400
Received: from mout.web.de ([212.227.17.11]:42367)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jnk8g-0002Ys-Ss; Tue, 23 Jun 2020 10:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1592923380;
 bh=3cHbGcz3lZmcKJXuzmvXzd3SToaDH2ofaQrw3xL/jKU=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=PmXbJZl9h+nIAZN0Y5bfufaoTYV/qWlRlR9gGsSiBEyRQgIOPDHKBPaxKVdxfXolQ
 7MN7E+tc3iwwXUCMvXONWD6XCwODScs0jlnTe9TIpM5Fg+Km8gHQvZOeQEhjKq/l6A
 WGIQ1z0/RoPy1iy7FI+xccu7nB+toQ4PDrPeg2Rc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.8]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MINAx-1jqm8x2ONj-0048Fa; Tue, 23
 Jun 2020 16:43:00 +0200
Date: Tue, 23 Jun 2020 16:42:59 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v5 6/7] io: Document thread-safety of qio_channel_shutdown
Message-ID: <8d567c499f0d778501d57007b90ec3450aba9947.1592923201.git.lukasstraub2@web.de>
In-Reply-To: <cover.1592923201.git.lukasstraub2@web.de>
References: <cover.1592923201.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZFzCLsMCkWFZbmz/W1rYMZI";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:UYMpYLGEX++84fzRIrzOsAtFaWAxdWVv5LLvfKJOhQ0OpegHXTq
 k37T+6cWZMmSMrz7V1HGWaU4b7rX4NF0msUKrMOElHadbyUWI29Lk0yQeUbEr3qvpKzu8D7
 uSXQe6XuV8W+yxxWfRwDVFbhI+kSWWxT9crSYOlOTBNfuByg5/lP7o4rLTr2Rde/MM2DoJk
 ZV0iczqJpAOk4Z0XnpJLQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+ou0dN+nVwQ=:wuW8Q8N65P+uZ1K9aqscRw
 4ywdEfK3IKhVWoONkia1qcE+KhkdTzTke+q3Rh0465tv9HI/lELug/BsT5fRlIGbecpCW20ES
 EIuKdtkAk9UWHqUs6wHRFKMS5k91kYi629dn5FudjLt8HqOhu8n6YVSDDR5glQfGtVPJg/gwo
 gxjmWH7FIiPcCekMCjP8xz7E9CszVNnx6cXZiEibqJT7wDR5U+xiwe8cGRJLO9JkO+sJbAoIC
 HTjGRYTvblXXxj0OBZzxyMZsE8RZy0tJBjDz8vzGhQwGNxkRoSU3q3k2W414oTzZAHFFNeGn/
 RJYd6OrOsYCXkHgH8tzirGW4e8Expx7ixo3wUi3L9MFUYUV895/vAeP6gbgy05f/YEw536POP
 E/iTl1qZPxOj/qc0ObeHMxOI1KAhCfCtjeexNbSahRQ387phFWebrJE7jyaOwqQqGxrFFddNw
 QMUNwX7e3R6c3vgCf8THCumRUDpeIi2KMN54ahRgbyagwPZ2b22Nl0ecYN/ApGCWt9fbAw5cu
 h974ZyT3exxTf7uvujpExFsYlDpd0L3yXOzwbgpin3nysLcbkOja+Zov+yCuCn81KKGe/KYj5
 xQgXh7ljIcWI55ODCakpI+SGH31eQxWkb9glCcYZgeJZh0tsFR2fUbft+mhgk4W61qbzEPWaz
 2IwRGcIpm3xctVQxWGHDReKINPvMoCiI4lSkrKuYEb58k7v5rOXg7XszrSRXQtF3p0EtxhLe6
 Hox7h/DalZRC5Kd9MGKghYoklbw1TU/YmF6YTnN6wb0HutNSkB27J8tUVwFQlQUVldpdHAXjM
 cjNtOr34qdsyCjwcZL0g5k9MbNUd9Jj6vPNz6excVPv5C8FX+XUlmCOXkjNnp0Gd+4KNHcIOZ
 FkF/oA42sy2vYRtIH939YkR5u4z9wy0UdVVRFfhnOnKJTH1WdEeFMtemKCZ9OFv5vb2SJtWzU
 /aNLXiYznmMUd346TiUUBZbq+bVMYMEUXP8pvtpVl/GIrn0/n9a47BTqoV3MKtZqdQXtIGSxb
 CY+lGgAvkKhKrgd8oWvFo/tOC0E88zl6ZGFhWnbWX+7kEJ8nHLWqVBPvqrknm6RKHHkx7Rx7U
 ajz5bwRxWg0d190hJ2eOfV1bmfk/oPrM8ZccvYY3XqBXjt5Yc5sc79yhYfZcehH/Emu8H8I3w
 K5gHWtVEY/mqX94lhdtv+1ahywVhpvHWm2+XA7uyCbCQUzcCQxtq+/6Rv1i2t6BpJKdoVhXEx
 YIWxwnoRsFOxLsc7v
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 10:42:51
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
 "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/ZFzCLsMCkWFZbmz/W1rYMZI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Migration and yank code assume that qio_channel_shutdown is thread
-safe. Document this after checking the code.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 include/io/channel.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/io/channel.h b/include/io/channel.h
index d4557f0930..6b8a2b87b8 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -516,6 +516,8 @@ int qio_channel_close(QIOChannel *ioc,
  * QIO_CHANNEL_FEATURE_SHUTDOWN prior to calling
  * this method.
  *
+ * This function is thread-safe.
+ *
  * Returns: 0 on success, -1 on error
  */
 int qio_channel_shutdown(QIOChannel *ioc,
--
2.20.1


--Sig_/ZFzCLsMCkWFZbmz/W1rYMZI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7yFPMACgkQNasLKJxd
sljkyhAApEe2ylR31ukEb+tqEi4w5OjJFVbq+vyaoX+z0BFX2s+J9vWmWrhAOKz5
8io16Z4P8oxMklGomRZQKixM8ypK1fdplonKQd3qGlv/C7VCZKLy+lImlZI4V+cj
5kMve88IaNNcUljAUmRbTsYiW5zP6ULRAQPwVUSL0FHGeNgmQdFGjxx9IkghKVok
d7qjcoB5tYWqfzbSbsKonyFXRFBAXXClX/578v4vpT7jj6wXw+LnDzRThlU0RQBK
I5vyGnQgwWdKmjV1pCkyR/vHN7zSjxqmCy2o5QBvRzwWz7Dj5LkNf5ruzSHHXxe/
LS1Luh6O+GfHtr7pMM4TcbOW0XdPc4XnAXPQCSBDXBvC5ukuw3/5ps43eEMrhtsm
DZKGcjzeRHKHTks8caevChMEkd1k/bYd0nw9FmqC2cJdID0DXsLdZyqnGLpoCDnP
XrxXk9AQngISbG7tH9yWXroH4zcGdyshsiDoY2vzpn2vTqvzxEaXvha2EYDyfmUg
tv96NAmxYUl31MaU2qcAbdTmIfrEBMzBg94JQq92w/i+rlU4gHHVdwo7RQLqK7hn
9ayPPHVLTNdYiRoOiQMnmwv/gEULSwzy12Eq07x2dIDr2xLE1UMbSTXDJoDaV+iK
ZvwDUue/rvgHpRRwNkN4hD0CBEkxbdmoArBTrAgnKLqJObf60kw=
=u/f+
-----END PGP SIGNATURE-----

--Sig_/ZFzCLsMCkWFZbmz/W1rYMZI--

