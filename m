Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72342C4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 16:48:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 999A020725
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 16:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Vset/olP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 999A020725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYXZV-0004DV-JY
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 12:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kYXTM-00053q-17; Fri, 30 Oct 2020 12:41:52 -0400
Received: from mout.web.de ([212.227.17.11]:40829)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kYXTK-00031o-00; Fri, 30 Oct 2020 12:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1604076104;
 bh=+FKqBqao7ItTK71ZCGq6sHXUeOqTRGtg3DJ0zS0YP10=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Vset/olPEF0ONfW62YdhkiNhkvz2e822mHNlyr+AsRfReKScyxvJRCjDP2K+yHo1W
 t/hK7UR4x7gGj3XmDbtYB+3WHiPiUTXVOAS0JbAeRBUNyL6akKkYD0M8VqEe9PGgxn
 sTPvn56lRRKYa2G0PwfHWg7s7PctykEq4wfxJUtU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.100]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M1X0v-1kF5sH1qjR-00tQcT; Fri, 30
 Oct 2020 17:41:44 +0100
Date: Fri, 30 Oct 2020 17:41:43 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v10 8/8] tests/test-char.c: Wait for the chardev to connect
 in char_socket_client_dupid_test
Message-ID: <20201030174143.0269a488@luklap>
In-Reply-To: <cover.1604075469.git.lukasstraub2@web.de>
References: <cover.1604075469.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LdbojqvvVGG/z.uIgt61==w";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:sOrMWSQPC62ykrJxQ16jjdCfqRo5qIBQdcam8vzgVCIg6rhdCZP
 fZJtgDAg7DO01VJ5WMbRGzdZ89/vKE+X5T9Kg/kr7X0HLWXFODZebh6vAMyYqwzz6f/5tBV
 l3BK2r9vOrZdM7RgN2FzcRLUcnQiM6PcuIs70paY6ePA1l3/np99QVWpaxshzD1nLq6k2zM
 pn2tcvgNh1UOJOQFP8Gnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H+NixxWgGqA=:NJWtyplGuMoxEnyPXYlyfP
 5Tyciu7S+UW94z+V3OYnNv+GMmiFHNa0ZUTXfgMB/nfS9y9VlxP0wNnbBwBiE4IBfq+sqx2ga
 Aj+577QWhPo2vrfcn71bJJvhnRtfS1/RazIvZdmrON0g1wBfdozcXjZkecTpzs8/vp5ITmgrC
 CSbeCsQVJDsRJni03Xfw6M8F+DCUSXIDIRZu1bV9Ss16wWjPbdNifr2UCpg4uK+rFWHxPo83u
 qNJgFekWtS7yeg01Bd+sD6Slxylfi5Pp6ZeBFY+KHdEb475ou1u0AJWoftxhOO87WQ/pmhRT8
 4zT7ZTGBN+O3A/ccCELxij9rmWVHh2TMfFqHOJhyeamKSRb8bii4P6dvOixmuHOB8Cwf65+9x
 72oZB4W+bSPs+3721ndeGiUcc5G+ADPP9/hQZmQ5ywosnQHD8lH9YBZMPi2pnSG1WgzKZ44n8
 mr/LNkcs8pdQaJBpOEGGhrBav+izvZYBtYhpw/jeKwGJ6D7AEdXeZFg6eH8c1PSbJvG6nEySz
 Jt9hKB3b404W3gjKu5NNhhSps7FFtBJBNxnOvdmChGq43SqwXK+80r3fPuNvX+33l1rgGYhZ2
 D2+Qv2GbR+gmUIPk9KgXygmVymYsYN+0buVEGMGxKsoPRsCU3SbNzP4W8TTq9I/tC0BOYQG2p
 KR1ykVVw7noIzYdtq9+SqWzIvG5YcCE4Pe4x119TMglhfo1WrMZ+Nay+NTpYo3eXFDl3+dmIy
 QGQXV9532th9Nmx3euEk1YyDylqQTRylZAZSXJEAqlC1iwdp6k9JBjJKuvRHV+Go0dQwo5v3B
 ruV96QsiAJQSJ0WsdmVMdQl9diPqdm63EkRxVmOGrP4J4IHBc5HLZR0FgLbYz7ZGpflt7toyj
 xSxB3zQqbEgQD/BDO6pQ==
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 11:19:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/LdbojqvvVGG/z.uIgt61==w
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

A connecting chardev object has an additional reference by the connecting
thread, so if the chardev is still connecting by the end of the test,
then the chardev object won't be freed. This in turn means that the yank
instance won't be unregistered and when running the next test-case
yank_register_instance will abort, because the yank instance is
already/still registered.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tests/test-char.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/test-char.c b/tests/test-char.c
index 9196e566e9..aedb5c9eda 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -937,6 +937,7 @@ static void char_socket_client_dupid_test(gconstpointer=
 opaque)
     g_assert_nonnull(opts);
     chr1 =3D qemu_chr_new_from_opts(opts, NULL, &error_abort);
     g_assert_nonnull(chr1);
+    qemu_chr_wait_connected(chr1, &error_abort);

     chr2 =3D qemu_chr_new_from_opts(opts, NULL, &local_err);
     g_assert_null(chr2);
--
2.20.1

--Sig_/LdbojqvvVGG/z.uIgt61==w
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl+cQkcACgkQNasLKJxd
slgiBA/+L8Rr2tUiS0nIJSMQACbXazLCJdW4Te9LUUk30XS5ep9CfpgFgPbYw0vO
AYvKPyYN6QD5qIrtfbbXSyzhjF4YZRtToxR/NbE3V5cF4JEmK44CgkZp9jAlG1th
EgAD6SUI6iUP8N2VQoPJj/24Zq87LQOuPXol3WuKjTsJY6rHWCON39X4v1H53zfr
fKmz9YTXU3ZckQZczmWoeDU+WxUFrE4vURrQ9VzhHIx75h+eZOEvzS14JIcZyrzK
qkFGPAP3oWsDiQ0b77W6H03H2+oweX4FYtEZH2Q+q1NVjWjXLQT4u139BYNY5WBA
ujzlt4RdupEiwrtPRF0i8AQE8bm9IIDQZhxrmYo5JM2Jgj1rrn5vYBhiPhLNT2XU
B7MfEyXOHLLho/fuOpUzUXVIhWu4eEz2fLpBcfZrgcpMHxrM0gZ3i16oGfvS+eAb
JUJIecC6BQghvBh+1EYBb99OEbVCHNkfO1Wlhd7w6Ef47ju995aesFn4KFvQGDWj
R8hwHMgnahRqjITsazr7Jo+oPigvpUavMtZPvG9vmuC/IqigWzc3jLchSJu1PRuj
r9vs+5flX4KN1A/WD3lVYCJvPZRMAzWxsJrnFH6izPK7d6NtQB2xJ0fqLp589Mq2
BRPtOlQrtUN1LLpjKZ1lyTtQdlwyTczL3gTvG0pcuCx61qjJl4g=
=lMnR
-----END PGP SIGNATURE-----

--Sig_/LdbojqvvVGG/z.uIgt61==w--

