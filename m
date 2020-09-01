Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C56C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:32:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F382205CB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="DtMH31QB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F382205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD2em-0000Ft-Ig
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 05:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kD2O6-0002lK-QT; Tue, 01 Sep 2020 05:15:34 -0400
Received: from mout.web.de ([212.227.17.12]:34913)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kD2O4-0007JS-Pm; Tue, 01 Sep 2020 05:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1598951727;
 bh=xAfFk+1GpNfhWU5jVhEM5S9s3tlNI5aCZKFADiMs8rs=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=DtMH31QBhti5RV02/tizZ5kdNJcATWnln1yV4AeFS8UrPAOjw6PNjDLq4gdHOEMqF
 riYdFzTaCKAFUh2t0PR4QLjDNfQyzqu77zLcQ025CR+CtInARr7VEbeAFu8LCh6EVr
 gmQEheqiVwhCAiKNWQQ/9M7A4TMgo7BGmrYNX6wE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.220]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lc8c5-1kuNwY2Icv-00jZtU; Tue, 01
 Sep 2020 11:15:27 +0200
Date: Tue, 1 Sep 2020 11:15:25 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v8 6/8] io: Document qmp oob suitability of
 qio_channel_shutdown and io_shutdown
Message-ID: <cd6eaf1915c834e7070a5c3cad083372a43edb82.1598951375.git.lukasstraub2@web.de>
In-Reply-To: <cover.1598951375.git.lukasstraub2@web.de>
References: <cover.1598951375.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gZoCt9kruQ_rV2X1IiLrSn_";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:GZthgDTWeDdi57QP0iqQtvXjml5F/NRUmThVXeJAHBKiPYRactx
 YaFuhmbhxIiqebyCYID4RiM/PrGx0KTFfKzExVaQOokjTHC8MUl8Xva/b7TpL+sYLQwy7f8
 Mdyt8GpFGj3atNXa5G8GePWEXCUiTTY9vrKp4NxomDD1XiIY67fCGM67IRvXTqqigrOVenm
 TNRtk3aielVoXau5rewXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QqAxWhWLByg=:pKA1esqGSXSDGiB3m3n2gN
 VL2aCzP49Kj+C1wkk30wIXCsaX2YXAaMOg+t3AreOhTrM2fcy6WXrNHLBANQIXvKetNidFtW/
 x7mV6HEnvXkzvlTUiapmmkwNncNQwdaNff49WuK/tJq8PfxC1r+I/9arJfWfGpXX6Yw5UQXHP
 aa7CHp9yA4ynMb5crWpnv38YZQ63YsMMaShm8jB7SvpLGJsQWixoryUAd8BoF18W635TTxapH
 ibrZjC9frE1Q2dS0XKNV0Ub9gcNIXIk/HxAVOUM54UBwamOVl9UdMwPkczjUoN2rlo99+el8S
 Fd6gBzSteOPVzAvr6N34qHsE+xNPTLmR8fn7IH+Ko9lP6hr6fBt/wtBYR7zLbDFwIRYQkY2Vu
 pCndaEIgIP2EnYc8uoveLVW64Q8gCWeTOFb0HAFtKQ2tkA5P1qn5gPCY30yNOIKYLUxzRgIKW
 0ZoOCAte4u3wfwYIme54DU7AN6TQUUMl2y0MjxcnG0HQyoH81IrkLwj4jvU6BS91AStrOqW6J
 /FCbf44HKhPvYfrHRrZTj0YcYm+5kbrQRjbHIf03b6UedrbrwSQC6LgCWScp5FLVs+YtlXSOf
 4rXoI6Px1z7KSq1z5MlPYqSd1TA/VZqGrwfzc4e+xC4LjB5XlIToxt2udfE+KAtSxMjQR6mco
 S8OpsKgok3407nM3xK9fmlmOT/oYk6IeAOzziJKsnE2NoVeXxJObjJgPh5+IKE+m+IUpSPdfJ
 UFNUYPfw9CTjz20AaTkEPMopy2G4AJYL9i+d9rzsx+lrDc781DZ9UhVyY0VBxTyQQpuYMAMiF
 231LWVm/wxQJCvSUchTjRjrBQnshBU49ez76+MwCn7NsMTteq8UxwKN+ESzw9h1dnPV53+maZ
 StQdFaCmWUBOYqKcNfiX/nB+mZe5tQ9YbgQ9Yw3HXKEk5JcWyFLR9W5UmjHqVJ7khD6X4I0Z0
 05v52TmA1LMjxU0s/jT2x2lv684d3GTU1ibujDm2Yw1ToOWsvdJJo3NMKxtQH2fiaApa5lkrS
 6MGM8fu2eBUPMuaiJKbrbz6IOFuePTe673uvsNK7TI/wKHb/CMHbS4Ti1XzNNL7St+uRHunfv
 os+Ty2iXp2cHiKo6/X1kDTbrWJyp8mLTK0YXFB2+wivNhbfqTc7/A2e4H8qt7O6aatzm0ZnJv
 /YWFVyMv/lluGaxg+WFh9hIOhueWXHpXByzviKTr9kAzg5WeZulDOn17AG25xW4lVvaCAh7QZ
 54Pyc4qdMvdwxZ4p2qrK/p4wIQ40hk9rqJR5sjA==
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 05:15:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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

--Sig_/gZoCt9kruQ_rV2X1IiLrSn_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Migration and yank code assume that qio_channel_shutdown is thread
-safe and can be called from qmp oob handler. Document this after
checking the code.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/io/channel.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/io/channel.h b/include/io/channel.h
index d4557f0930..46156d84f5 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -98,7 +98,8 @@ struct QIOChannel {
  * provide additional optional features.
  *
  * Consult the corresponding public API docs for a description
- * of the semantics of each callback
+ * of the semantics of each callback. io_shutdown in particular
+ * must be thread-safe, terminate quickly and must not block.
  */
 struct QIOChannelClass {
     ObjectClass parent;
@@ -516,6 +517,8 @@ int qio_channel_close(QIOChannel *ioc,
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


--Sig_/gZoCt9kruQ_rV2X1IiLrSn_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl9OES0ACgkQNasLKJxd
sljgbQ//ViBrC+Cn+nhiU5HNeyljFEHuM0QQT3Nl4QDTNvVW+pQB6xa0vRdhiO5R
O/jARDR21pJ2ThQVX2a+72Z4IxVSDhBJEXJkx2RXN7wdvruq2nwfeBQvEfhuzKaY
7ekASknDbwKIKKM0OMebLUfp9lD3IgrsfO7JOvnmLwL6JMI6CUhMKHurgmTzUPzf
ALuLw1eVut71VJAymoLy1PL6ar2yoYq8lmYsu5ZlnXV0w5Gdab51CK84D86aFw3p
ukRZF0itdIEzM6hvBWV4yTJ8YiqiD4C8NIqvbVhAy5SE59n9Lop1paZJ43fRZZNd
NzY1w6x7wqcfQzDmKbranAUdDbyzkFutITa8R1e1BBzUt+7sZtScDxUPqJ5S8MZF
a9sKxuZcjFG2UIrUrsMCyU+gpt6KKQRjv52+U1cchIWwkNVbDMXUba/jKEq35JlD
AtVwYq61ouzwxL3FTIxrFq7NfeXVUxqvy+fp5wrRQ7ZZ38qQtBD+jFFOpTmbSlV+
Jyb+US7qn9o5nLNQmhXdePGGOUsDPmWOAtCayPB0JzqZ06o45cSxJ4x/RXL9NUuQ
mQfWuDaFlbzRGhhaAFzZ5wyHB8+04knEvGNdaVjhC6eWqq3IRhpMtjYPqACDvlii
KPnZD8uNY0WAy0RCKaaoJdW7MMwPYj+qMYNUBKc4EUlc+0s3pA8=
=nqT3
-----END PGP SIGNATURE-----

--Sig_/gZoCt9kruQ_rV2X1IiLrSn_--

