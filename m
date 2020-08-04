Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD757C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:21:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F0EA2177B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="ZptSlHCn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F0EA2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2sCO-00012V-8Z
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 04:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k2s3G-0003j9-3P; Tue, 04 Aug 2020 04:12:02 -0400
Received: from mout.web.de ([212.227.17.11]:45101)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k2s3E-0006cB-E3; Tue, 04 Aug 2020 04:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1596528714;
 bh=GDIipmN+9j6zL/53PXYOAbRC04vVOsa/k8/m4RzVmUM=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=ZptSlHCnrSJ34uVU9C73l1g1omWy96JjwT96kEBzPGgqmlaRQKjcfVeu35LEjZZOb
 kHn34lJy+zyVngEWnbM0xTc4r3+5UFaoxkFvSrN9IdKs4OrO9alvtgAjVENCVVpIw1
 aUIOfCHOjkEhYcScTTrvcGVp4qlNm0dTPCGCy8vw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.220]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lk8gg-1kaYAi2DxS-00cBEU; Tue, 04
 Aug 2020 10:11:54 +0200
Date: Tue, 4 Aug 2020 10:11:53 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v7 6/8] io: Document thread-safety of qio_channel_shutdown
Message-ID: <5d49ec9f44d508ad675fdaed8154f0d80cd48739.1596528468.git.lukasstraub2@web.de>
In-Reply-To: <cover.1596528468.git.lukasstraub2@web.de>
References: <cover.1596528468.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Y=5oQrS4z4fRE8IkMaKUsMr";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:BWYySGjNEtMmGTy2mJ9CkFtiKzhXOwvmFU4v3MWGzaP5W5NXqFU
 F86ltWVskJykPp1xHCLacNSVI5EbALSdMebq0jah8VdhTKUaFPlBPU2GkoScY1IqiTpU1HT
 tFBrj6DTtW2kMuLzdQI6Iq9zujbHLn2BgxfFeals8yT52oi4zSpWuEas17+iQciGU1Wklz5
 J7JvV8Ht4y7fn4JJa4irQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jYgKe4YoMec=:BR/c4zXDx1jZnVHo0A+XJ6
 99eIWsB38DtxmW+ikNaXiJ6ebm+T9dLBcg4PdB7Txuxqv65D2Wk5vC2KjqO4v1APPNSEL9fTq
 f8MyXYeli3l9UvuRQj8uGpGImr7NjTzkwKv6ZkozfSfWNyMXHHkh8ynUBAdXkI8kZoETuzYOV
 7blbFHfItFkikPcQhpEYuH1mbh4dZM1CHmAttwCx3pkFXBm1V52kZlOVE/C0eKzzJEDKt8xcW
 gD6xwiRXgr4QOQk7WU3xDLCOVdzvrMPGzWeOhc1N28FnWxAyiF2rQpHU90ZBRN6Y3e2P1f71N
 lwUW/t9v/2fdVmnvO/oVjvQgeYJkuXoIuhT2kMHZAuBwgkgG6AwM1skz/ZBJgbs75AXb6hOZn
 L/fDUI6QMffH2WqBI9gQF9A5Gpas2K71+mZdlV4wMbh6HCmLJoiuXzS316rZbFNZO0G40Betb
 EovH8sO+QpRoHpF2mFf030DKZMV+WWcz0xjRMIRXRyzG+2WMX0CJxiCwO3zF0+N10e1tWpyiP
 Ja3CzIvJyIyNk3CU54nUZ15Y2vSxWO7fsGSz0tioz+e/csEPKnmTWr+T1asLB67iQeKPl9ffx
 pnMZYdvFqG517Nbv1wFM+twM6pKuZguq5q6k8QQ6bYhTeDrd5ww6TzoDudqeUG1BXhGn+nlKe
 X5Ic+jABM8iyBoZoLsC4LVot7H28aQT1PhGHx3QwCdQGLrSnLIPCirLanwTca/o1YRvpkXjB2
 j7AZYzSykiMjLXFHGn9ZlQiya0YK2ubwOdNYpkWSDdry59B3TwUTDsgOpkDCA4JFo5uvj/wW8
 NlI18OzdgrqLscs8s2v2tr24chiaprP0Mrsxv/IYoockZUqcwelIHg9lDhxot9cnu3+d9vLBm
 08wVpu1g7BCgX+WjKgMXIUN5IvqDfsYDFiUQctMQEm465p/G/aTHaI1HABCuhoX8f5lgeWVCb
 WQDLPdQPGMVbAOb6A5QN0GjXV34+a3bkl77RNkkgvhEa6dLUBV+BK6RbwCPesHrYSBdQd5vFB
 D69JmjVGMp2RbFaJlUfL5F1qJnl3Ben3Rt8hHaxZNuO47hr8yLk8BBn2O05ghcaB5OlRNC+VA
 oCuKXEF8AyTPjsmaxcAwDB65mvHtBr4+6fdnXg5fXXc+4R2wdDrtySLgtKYQb5NJ2u5ch/h08
 eH9V30vWBwfnYsSveVd44YuzLQRceAkHksBl+5qTeKQZR7m0J/uxOGa8WvYVMBIXA8JN1zszZ
 KAk4uLfBCx5TouvVmjW4Xgx7H0lAeUnknvHpIhg==
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 04:11:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
 "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/Y=5oQrS4z4fRE8IkMaKUsMr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Migration and yank code assume that qio_channel_shutdown is thread
-safe. Document this after checking the code.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
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


--Sig_/Y=5oQrS4z4fRE8IkMaKUsMr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl8pGEkACgkQNasLKJxd
slhHPBAAhU9pjoH1LQrmZiBAUNfbcFOgtFPxCic1TLjMCJZeYfwZhF1XoHb/8BSh
M+SyjZDcc0E6JhEceJgglsu4DMwTUK10g1j2xE6EIimVhNKmzPB1QLLpnSvGJaZP
PoCy0hjlNBqgGYsQtTpwIRpEI3DuDouWhXNWbhbJ6DZykKJ5ArlBjBX/zcEDcUn5
zHqRVwzEyg47P1o+u4OXKNJItPJonFkcvQ57dktbNdyJBq/taLcqSUuPHlHch82R
Wmxsu4plyNeLrVPaleSPjWeB9+VuFyFApgoSvE7L3w9GDR+XcxufBiEuchxVs7qL
j/3lZA7W1Gum4u6XBTipg93Q1rKtK1a1vuG2lz0/2MCU4pz6bn2BKOQFS2ZWlB3Z
gcuOQnIj+xI7ZoX1BGa/Lg2KHD9eaT5kaOGmudFDHiEHuF88xaz4Qd0awV0hCdnn
8/x/RxxRK/cIrH/rFPngWqiso4L2aoN3dfEjoChfarTbc1Uo5tRY8yrRM9MiWrs8
L8UsoqOM7n644mRMxZpMbpBFRh4MzF9WEJPToz9JvX5lGLXn8Lj1vPqWbRZI6d3f
J5buKEEbBlgJOa1qLK2JnWmsVjnPamrDtjvFbz08THPDBmnDAxOZB8cKiOU/on5A
xqHYYQv1YlJC3ojLYvPlW1MGqpMcbsnQTauSkJz6KxG9Chq02ig=
=YOem
-----END PGP SIGNATURE-----

--Sig_/Y=5oQrS4z4fRE8IkMaKUsMr--

