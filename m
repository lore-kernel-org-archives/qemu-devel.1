Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD4CC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:30:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40AF42075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40AF42075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38489 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMWOM-0001Rd-BR
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 07:30:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWEu-0000VD-QJ
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:20:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWEt-0002JJ-Sq
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:20:28 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:40855)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hMWEt-0002Hb-JH; Fri, 03 May 2019 07:20:27 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1M5wY1-1hPZAr1p9f-007XLN; Fri, 03 May 2019 13:20:14 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 13:19:52 +0200
Message-Id: <20190503111958.30825-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503111958.30825-1-laurent@vivier.eu>
References: <20190503111958.30825-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:5c8cLYEFEaCDa2jxSETb9VyU7iiN0xkqspb7BfYpEQy7Ya5mkLm
	zkjyVZB3ZGxwEbhwIumSoR7NurB6u/Bf/FMqQ4vXa84eex94kNDNhU/wDVzi2zVlJarrHwf
	8T2YBuIXgCegw07VIvxwW7jlwJ/7BT5TI/KkAQsm7PvUQOC9YsuuPJNFTDBSQNtj3Al1ECC
	XulYxwgxA1EUdHtchJTXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g0W8zismQL0=:pxkC4prXYU02nw5rSx6QwC
	j46GK6ArIz/WRVoPcSdATvxyF89Pvqf+eXpuEKp7MQIejRYJ0vdE17Ro/sF8YY3kpVkI2NrPB
	/E8TgKeJ2PsVzpEsTGIWb3QhH6k3tRmaPCF+vymnifewUZ1jwDskPnR6UlJCz0laxkMcyHn8h
	atQXW1aL4gfq4jhx6AKZfR+2XSvizRrbZ/HV6NU78ksTkGG2VbJJX23uxPWZRVrJxht4UMMGv
	29vZMveVyXU6GoAfdr8Do7FMAje2LcSIaK50qmQRXghFJAfnG3CSruhUzBLLbc3TauqUwt1N/
	mGdpDt7NMYKU6rhdVEVPpuT/Fz1lk7sOPX2whYPiEi57+dHin87ZghZsJwqWb2oXFkQsu2Zxu
	4+bLqEeGl4s23e9dshPm/o6pUc8E/UOMDcwyogPjIxYWxh5+cQ6bCOdy53x2zGHMGeYfAbRnI
	gH134i0BKvsOHNwBS1Dm1VeYl8+6EoAaczqvHIlFED3TTFa5xOI/xzFjaIJZ39mvlCscsLfa2
	75fZ7iIR1nsBlEsoA4CbGC0oZzwAsTWRUGIRvMbXbsJLNDqFLtFfNTpFdwC+d8CfEjoyfMVpH
	NDs4i6KTu0z14nFgD87qdWUNesHBHHdScOuNLmo8AY/UBgv5vrNMKvNMTgeW+qfv0PB8Oy1KY
	WcHkqI23sdw6uWJoZ39ksM8K4C+jjEk7/RdzSAMKo/Avi/4/u6nCVBEWXrCJ0mPHOSMo1Xi77
	UVi9cn96XZ/cTmllIW+F1JsiiihdK16qwOgu7ptU274fjA3EwCyvkOAj1W4=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
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
Message-ID: <20190503111952.A1-JCAETJncgHbqk3NP38D32b7lsQdS40Iol9-HO1qA@z>

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


