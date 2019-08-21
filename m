Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551E4C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:41:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27CA622D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CA622D6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0OzH-0002tE-A6
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 07:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i0Ofg-0005W6-JB
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i0OfZ-0006ky-Hh
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:20:56 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:42937)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1i0OfZ-0006kA-8O; Wed, 21 Aug 2019 07:20:49 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N0F9t-1iD08N1wCF-00xHPp; Wed, 21 Aug 2019 13:20:08 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:19:42 +0200
Message-Id: <20190821111947.26580-10-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821111947.26580-1-laurent@vivier.eu>
References: <20190821111947.26580-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LC4f+dfAljIEcCQ1REYw2lGRpTrvXt53bCf+1c1lJIZihbJTgyC
 5sWySJUsf9Rmg7bNn7LZ6r84o257RZpjq8lO/NUkGMthXVszNsoDOneT/5gIcZy7caIjxVZ
 jrIEqkl+ZDzGMN5mLDFLW1f0uh1GegdodD8yn0senDHIwPLe493pdvHEQ9f1vQ+XeztMnPm
 lf/onC5Rua93OjYvJmizA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PgMaRYuJqzQ=:T/JqyOOFPbLTAWb18T0MgJ
 phT3UYjHKPJ/jF6OjW68yAmHFrmjpsF/7J3dMP1ObMuM3gqDjQ5lhNIR5f67iwEzFqNfncBBZ
 c4wFFIjk4uDPa73X64eQMR5Wx1nc9bqycjp/QYfpP8pXG8omSWVO93UpjfCbtE5iAd9d3XAo9
 7DVPg6AUdCEfsF0opLCuUFTO7vT0E8EiO2HHybakoLqEYHxAnSp1RAjf0PwV9e4D3B3tE9Iz9
 ad21NIw+QJV8K4obEZQcELHSjmx/fNHBxe5muGFFAxmgQ7q63R5PdA98VcBingmJXsK3CXGGp
 Su5DJSdkgJSGC4IlMIcmvn4NEIA2pB1eN8cwf0PVP9WxcZpRtq8Rv+Swi28J5DPVtY6zRAgzv
 JlnnEPkzae4tft/FvPxg53adBu7gdS12bDXnRqCumf0P8QzC8wkMayw6swWJaoWUHfIIRzS4U
 Ss9eyrhyQKdB/ftADt6XjnkSCQr/+9Jprwq5qTISqUitxiP0uvr4vCCB6TJMzI6QI5/uXhpgd
 GLLORwDbUjToZ7wgaEOuIrhJQIzpUXXA/7iN++OWBQNBxB8NVuKa0GtWr/YHLcbU8BSggPBij
 y6IbUNgkQ1qC0Rn9q1QJMlXb4yCCs4fSLmFpB1aLvm/DReo0QkN2JdPYVN+xYTXM9lwiQsIMW
 7WCt3XRfXUWf6MXZ1uJtFNu1ew1V1WqrQ9lRJh95TVOxh0JcT9L9dIp3QI+nymnGFnzjlw5ds
 Li+zrlT21DMgONOBXUiEB/ZVmoj+A8tYyiSVWLOJ9Qh7js1fglbMCDLTX5E=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: [Qemu-devel] [PULL 09/14] hw/ipmi: Rewrite a fall through comment
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Corey Minyard <cminyard@mvista.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Corey Minyard <minyard@acm.org>, Juan Quintela <quintela@redhat.com>,
 qemu-trivial@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

GCC9 is confused by this comment when building with CFLAG
-Wimplicit-fallthrough=2:

  hw/ipmi/ipmi_bmc_extern.c: In function ‘addchar’:
  hw/ipmi/ipmi_bmc_extern.c:178:12: error: this statement may fall through [-Werror=implicit-fallthrough=]
    178 |         ch |= 0x10;
        |         ~~~^~~~~~~
  hw/ipmi/ipmi_bmc_extern.c:181:5: note: here
    181 |     default:
        |     ^~~~~~~
  cc1: all warnings being treated as errors
  make: *** [rules.mak:69: hw/ipmi/ipmi_bmc_extern.o] Error 1

Rewrite the comment using 'fall through' which is recognized by
GCC and static analyzers.

Reported-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Corey Minyard <cminyard@mvista.com>
Message-Id: <20190719131425.10835-5-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/ipmi/ipmi_bmc_extern.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index 573428eca1b2..87da9ff99cf5 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -177,8 +177,7 @@ static void addchar(IPMIBmcExtern *ibe, unsigned char ch)
         ibe->outbuf[ibe->outlen] = VM_ESCAPE_CHAR;
         ibe->outlen++;
         ch |= 0x10;
-        /* No break */
-
+        /* fall through */
     default:
         ibe->outbuf[ibe->outlen] = ch;
         ibe->outlen++;
-- 
2.21.0


