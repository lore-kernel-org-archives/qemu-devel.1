Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197B7C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:29:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF59C2075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF59C2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38483 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMWNb-0000hp-31
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 07:29:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWLW-0007ao-6Q
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:27:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWLV-00035O-6o
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:27:18 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:42163)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hMWLU-00031r-U8; Fri, 03 May 2019 07:27:17 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1MOm9H-1h6wEf1pdf-00QBIl; Fri, 03 May 2019 13:27:06 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 13:26:48 +0200
Message-Id: <20190503112654.4393-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503112654.4393-1-laurent@vivier.eu>
References: <20190503112654.4393-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:G1g65eP0H0efAzs12qRn+BsXmZsM6nBMNv988fXaIK8J+tSGW82
	x/mm6jEzXirjjJMyjGFnzZHomDgnhAAgsHzRik++tROZHcZIWW7WR7jab50thSRto2+UXtq
	y3CkIDFNe+ZWRf06/FQHv2OmXRt28Z/BekpnvyOQIP7Ll5rGoNbRaSnUqjca+7wPN+Rxr7g
	UrsXZSYh8Cg63JVMNa41g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jBCT4kIxxXA=:dIYgJ9udYmEvgucowX0j5c
	93H4TENxoYhgVxAVIkCM2/8MZ/3+ednL6QdoJZUJy6HTQBrGYvnv/zTWcF7STs3vp3UoMfAei
	VwnKAQ7CCbz501+FruwQgpBWQ0DQq7PsyKCweBn4GZaF7HMTYNOieIlTbOe2/YB5qZjIWQcmY
	VEZlOdoa99faf5VViRytZYClX6VhYllpIIFfN5a2QjNsLnPd0rioNIu6h++84+e9oSLnHaDVV
	eaoVEKHX44QZZXPCCSLBWR4WSCr6ozTNf1VLpYREJ+2GLQFwOOPRt2e4sYUS9JMDbZOK0aoSx
	NVP46EiWfomjZ4UPwQ4ZxN6kzK5xwLnMP9uEcWxB1BjsJ24B3daiqrN98I3sbQ/PA3Kyg1New
	N/JtZnqStUc1VIN4u7LLv+vTnlozCt9INS2OzdYzhWx6EurevjNh2awn5Fc2+35istb5s2III
	o/ZKSQpY622EUnALMVdKB0oo0QxzX0vLAmFJ1ZHZ1Nrv4Qdtr0bxtWt7uLsls0gd8I/+fgXeP
	lkqLe7EcYeMisHRdYG5/4mkmTjCrc3WlJylYH8dW8xJts1ST24q5hOxG4fdzTGhYhjSzgrxfd
	Xhkcbnj2HmRNHE3AUfKzWUExrg1kNgU0PTEvRF+3uZGF9aNPr23kVRQkJPgkcg1DMe8mKH8Qi
	AZ52J969q7IjVKg8SDFrsWtZBMPBq/eG7hwTuUF0YZ1HomV1gAxnmoshN3oyxD0SMWRFM1NAZ
	yraX/I+fkCxyMwv8x/VBpui4DPaOfcfgVSQXDvGOpgIO/8P+rR2kZjBeCZeo6zxj/lRz2gUVt
	Do2yRDyqjUCCCZzzbO7RdyRIOi6DaG3ctIveGLDnpTskjVEvhDY3NgfGUckP8gPw8aBfhKhBq
	J4uKGFwrxbmcoq6N5rIPz67OI7BzKh2Z2n+SfdjJQth44e53yCWDaSDB+ouSD+I1AhnPM/s/g
	bR/Gpab9sHw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
Subject: [Qemu-devel] [PULL v2 06/12] configure: fix pam test warning
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-trivial@nongnu.org,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
	Laurent Vivier <laurent@vivier.eu>, Fabien Chouteau <chouteau@adacore.com>,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503112648.fkctuooM9oHlmaw30CHKoC950OpGdyVn3eYHnFHmeW8@z>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The pam test generates a warning on Fedora 29 with -O3 compilation
because the headers declare that the pam_conversation pointer to
pam_start must be non-NULL.  Change it to use the same 0 initialised
structure as we actually use in qauthz.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190404091725.20595-1-dgilbert@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 configure | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 60719ddcc5b0..a2607afb3408 100755
--- a/configure
+++ b/configure
@@ -2940,9 +2940,9 @@ if test "$auth_pam" != "no"; then
 int main(void) {
    const char *service_name = "qemu";
    const char *user = "frank";
-   const struct pam_conv *pam_conv = NULL;
+   const struct pam_conv pam_conv = { 0 };
    pam_handle_t *pamh = NULL;
-   pam_start(service_name, user, pam_conv, &pamh);
+   pam_start(service_name, user, &pam_conv, &pamh);
    return 0;
 }
 EOF
-- 
2.20.1


