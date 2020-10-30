Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5977DC00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 16:48:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B65AA20725
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 16:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="XrCobd9q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B65AA20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYXZk-0004IQ-9O
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 12:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kYXTF-0004qA-QK; Fri, 30 Oct 2020 12:41:45 -0400
Received: from mout.web.de ([212.227.17.11]:33509)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kYXTD-00031J-V0; Fri, 30 Oct 2020 12:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1604076096;
 bh=X7NTJwhv339GojGnpIWvTWY2vjpKyTMPXb5fxDVgfME=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=XrCobd9qYSkI5vMWkHWErBjadoIzk2DrPx1xpX8aSq+9GiC4sYcqQSYSf1rOdZbEa
 AWHmdE2hkljCap+W4Oed2eJnATcpSCt7R4EiNxfPCzsIVUPESk27Ca0RDUojoddu20
 Bw9Th7gQjV0aVPnqdSTgQmjXOQ8ZR/VDtggKeOrg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.100]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXGK4-1krmUY1bva-00Yiek; Fri, 30
 Oct 2020 17:41:36 +0100
Date: Fri, 30 Oct 2020 17:41:34 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v10 6/8] io: Document qmp oob suitability of
 qio_channel_shutdown and io_shutdown
Message-ID: <20201030174134.531eed50@luklap>
In-Reply-To: <cover.1604075469.git.lukasstraub2@web.de>
References: <cover.1604075469.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xHxb8Q3cJGCnDAn7EYdcPgF";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:/6QXYb2vV0dW0aZhPO9ZwUQTEa4PFsnCwGKwvflxPve9zGKf/VY
 6i4gFx5JOGB0NPvy2q63KvRyCNJQA4w8gQhhKdBqORajrbP9F+cTdHv+FBpnGwciREMgNj/
 cEBZnQ+GaRMxnaTvF00wWzRWJv3rp8g7SYEGJFsDpjGXX15btmoOuCd50ZttEMQNgnsisRP
 IFp3WMKX1bMxA6x3j/D9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F1jVa089wr8=:phEhAUtDD42ipz2kscGEsQ
 PEXWXvuvneozr2aoprv4W5bHF1y01xsLztGqd9/dHQVmYLtUAOUgl9PhtlsabnUZmQLk+GrqN
 WpWN/gdsXbunTY0tTaK6haAEVdTW2m11jEhIPlEhC40cgp44t08jEpX8yIPAc7+KrBFEWXved
 gFtiIMtBhUKWWm1OkrepAIIhqOdf27XtbxABQnvLF5jF7FPN03/SBjIcxWVbCFWgpopQ6eBhE
 liFCFz+30vbfWXJ6df+1bazUU/osCKhpHj6vPp09OJeMOy7a2blV5lwUG7mXpnD/OMLbi7FaZ
 gCw3ySHLeosYwwda2AmXrCWlYFPLitsi8YSp426mMmcQqF7MjcAr8i+h6yRKdng7KREZvYR+2
 pwvc7gCPA4SG4AGAhRanAK7lsKDxrH++Xj0W5fqBX5ogvhWBza/Ov6RZ+IU8yfRDHDn+j7EZx
 5Lpq8MV7zn9e0ZTrhPvtSlOw58a6u+JwEQkHsSk/ohZWJgW2Y/InBDjywL1lf69QirIb8hvZy
 q9vCzBstGyqh7KPzZpgyncX5lCov8y6mj/YMHk4kbn24DORtgKus/o4nR3hcPtBZrPH5LnyiN
 A0sZxk1tonga11aOQGsI5d3pSTXGjnM+5tvvYeiH/z8vMO+SW6dCy/X4OkleBHPGQdPDo1+sM
 vF4oE12mPHnvE3eMZTwITfJHkQK3JdgRl8nLLB5AmCe2eE4Vif1ijUKIpR76LXgBJPXiOxWfR
 vI4qD9UF5n8UUTecVXMeoKhmwtOoJtB7KzEorrEzz/xESa4xHCWvBmzRz7jn9WbW1j4DOzCnH
 viEXajpJ/nzLAukug1Tcyd6kWSX1y7OBYtwF1eGs/PO+IrWafNyK7Bm8j2Fq194wVovGL2g7T
 bt1XrYO4oh3acEycy2NA==
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

--Sig_/xHxb8Q3cJGCnDAn7EYdcPgF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Migration and yank code assume that qio_channel_shutdown is thread
-safe and can be called from qmp oob handler. Document this after
checking the code.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 include/io/channel.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/io/channel.h b/include/io/channel.h
index 3c04f0edda..e0b9fc615d 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -92,7 +92,8 @@ struct QIOChannel {
  * provide additional optional features.
  *
  * Consult the corresponding public API docs for a description
- * of the semantics of each callback
+ * of the semantics of each callback. io_shutdown in particular
+ * must be thread-safe, terminate quickly and must not block.
  */
 struct QIOChannelClass {
     ObjectClass parent;
@@ -510,6 +511,8 @@ int qio_channel_close(QIOChannel *ioc,
  * QIO_CHANNEL_FEATURE_SHUTDOWN prior to calling
  * this method.
  *
+ * This function is thread-safe, terminates quickly and does not block.
+ *
  * Returns: 0 on success, -1 on error
  */
 int qio_channel_shutdown(QIOChannel *ioc,
--
2.20.1


--Sig_/xHxb8Q3cJGCnDAn7EYdcPgF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl+cQj4ACgkQNasLKJxd
sli3Nw/+KnSvgXD5Qex+AjAlZdEht8HxnvAItcAbUh6M2TPBZkDgqGZKaJdDPAHd
9Quu1KpKcQBdLLeViEHLGj6HwXO+pVWfpZieKL/uJNuQk6YAr/WOYIJQtNkSgS/2
pxe7oHRr+rx+40eJl0mGoCcfBcwZ/8tq3FHIc4ezLNu0wneZMFsXb9CavG5JC3gE
k/BRJNj7NqOi/Tm+Fk6g54LDPqHNc0rcdyhCEUMwyTpoCmmjmzg1oNdoUTmRjyo2
4lfRumXzqRQ2/Zo1zYhxzAUKKErdblFFB/8hZ2dh+XlrwjEscMsW9yc8n1S3+cbx
FfOUBKFBVFOV2RuYBZmKsS+v6cEEPaMED1FESdGunIb2r00BivTOg7jwWKRLKmB3
FZ8NXnVOFnCmq7YkPdHvOwoQLMK+wV/oiZh0R09tIHc/ljOiNZsw8UD1zt9OJFxb
qjf9ewm1orNA7PbMqmKe7l/aRC2WbIB/09zQy2KZlFYp3sm/dfiTf6sCa/JtP7co
32q2GkKGBOH21yx4qrWaSwoO0T/rBgCTnO9mU0cP9HAs0JJsw2/cLVDksTbqC3bn
IHnj9P/SlmlvA1+nmnOpfB4nh+GSdlM0H98c2omKwP++Jm1IkkFWXNBAGtmbXorJ
l3rWk2jyxLu44pYvz+bNdLqPWnQCs5zmr8cNxp9GWg2ow6C5DT0=
=mXwJ
-----END PGP SIGNATURE-----

--Sig_/xHxb8Q3cJGCnDAn7EYdcPgF--

