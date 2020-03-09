Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0625C10F29
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:11:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAEB620873
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAEB620873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBK46-0001Fd-15
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBK2G-0007H5-8n
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:09:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBK2F-0007YP-7t
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:09:40 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:39165)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jBK29-0007U2-EG; Mon, 09 Mar 2020 11:09:33 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MJm8N-1iw7ce3yYr-00K8ZL; Mon, 09 Mar 2020 16:08:50 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 03/33] build-sys: Move the print-variable rule to rules.mak
Date: Mon,  9 Mar 2020 16:08:07 +0100
Message-Id: <20200309150837.3193387-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309150837.3193387-1-laurent@vivier.eu>
References: <20200309150837.3193387-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Ai7ynpyxzGre05ka6l4GHxtd8qdyahqT071p9CAte9wTwaVdbM3
 pHDOymBtC/BvQqlP10iUnTuKFyHWpDKASXeJ/bW6G0v0fVTGSF5Ljp4PCjGqP+TIJ9ZNDRF
 K6HMcD16Vs7MQh6h8BIGO8yntewAIqBTOekGCjOlFf2vEJIEV7rOrXubkpjFZ57I8MB07eU
 O+rjV/JwLevP1eAGA39mw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Sfa1dDNsXDU=:9u5wgKBUFXudeh8bQQnT2U
 hdCTsT6kbqwpRz7WgE7IHH/m+OwP6e+qOyrrV37mgpctyPzGgwd4pVO4zhtJJZMGm3K9fmsmr
 cfMDp+t3pwTTrcyCCsrlKo5ljsWP6qyu1dFFt4mtJKol1kOpoU7kudYcjRmR+yX9rT2sGvsuQ
 k2wiNcXnuJzvUze1hfR6MS3HSLrjGRk3u1KHYBnA+JDnraMuhRnfSXbR/VBhAH/9WzGKiTQUf
 c38sngokSEH+Kdx7DZs7U1rz70Ln/+5eDQmuUq0Snbclge1aZnKt8iEfaAQPh4pJh5BGJql7K
 Xp6NryO9xJrV/V8ekAZwWB8Q6QY3LFDEFuxkWbSDFtsVOgY1Bhq6HjKQ1r/Iy9OUvhEXhYJab
 ClcnAPME1ZKDIuLThJl0DHvkahAhJVFJhiz9yaQlGoJ5KSwFf12kc7VQy8ufGNcRfwMOUQ1iN
 rPmNU4x5+VM5TaDJP1kTA4StxGQMQXFZAm5+9kk2PpSnIX9ct9DRK6O8X1G0IXeskjiR0Hsmx
 D3gx/WAf4Fn17MUQvQE5txRg7MEE8LoBgwhiOazCpMzRHHRxZ1t0T15Rx30W9AIOLdc9r+iOl
 n2diFPff6lpEso40mpvi/sUNl8N1qyFoWOYnDJEY99qXC8Pb0kMy2mduiT18q0k6ys18+HPIE
 sAVLRQ8EoOLIL6P1b39TtKEdOmKHKj4VQzvuMpG1khli4vSfSgdyIA8LSnJqGeGDP9iHxhAXT
 8xdPd7qOaGHPh4ugoblbVTAM4oI+1I4vLASJXigLq2UzBmbJqxof15K69EzZKFp/ok+Zql7JY
 ERfm375SNigSccT6w0HvKAEPc5CeXgtBPj5Oq4PwtCUb+YWjF1Sj2e3Vy2FNf5KHIewmKww
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Alistair Francis <alistair@alistair23.me>, Greg Kurz <groug@kaod.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Currently the print-variable rule can only be used in the
root directory:

  $ make print-vhost-user-json-y
  vhost-user-json-y= contrib/vhost-user-gpu/50-qemu-gpu.json tools/virtiofsd/50-qemu-virtiofsd.json

  $ make -C i386-softmmu print-obj-y
  make: Entering directory 'build/i386-softmmu'
  make: *** No rule to make target 'print-obj-y'.  Stop.
  make: Leaving directory 'build/i386-softmmu'

Move it to rules.mak so we can use it from other directories:

  $ make -C i386-softmmu print-obj-y
  make: Entering directory 'build/i386-softmmu'
  obj-y=qapi-introspect.o qapi-types-machine-target.o qapi-types-misc-target.o qapi-types.o qapi-visit-machine-target.o qapi-visit-misc-target.o qapi-visit.o qapi-events-machine-target.o qapi-events-misc-target.o qapi-events.o qapi-commands-machine-target.o qapi-commands-misc-target.o qapi-commands.o qapi-init-commands.o
  make: Leaving directory 'build/i386-softmmu'

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200306170456.21977-1-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 Makefile  | 3 ---
 rules.mak | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 2e930688942b..37aed4a24422 100644
--- a/Makefile
+++ b/Makefile
@@ -15,9 +15,6 @@ UNCHECKED_GOALS := %clean TAGS cscope ctags dist \
     help check-help print-% \
     docker docker-% vm-help vm-test vm-build-%
 
-print-%:
-	@echo '$*=$($*)'
-
 # All following code might depend on configuration variables
 ifneq ($(wildcard config-host.mak),)
 # Put the all: rule here so that config-host.mak can contain dependencies.
diff --git a/rules.mak b/rules.mak
index e39b073d4648..694865b63ee8 100644
--- a/rules.mak
+++ b/rules.mak
@@ -435,3 +435,6 @@ sentinel = .$(subst $(SPACE),_,$(subst /,_,$1)).sentinel.
 atomic = $(eval $1: $(call sentinel,$1) ; @:) \
          $(call sentinel,$1) : $2 ; @touch $$@ \
          $(foreach t,$1,$(if $(wildcard $t),,$(shell rm -f $(call sentinel,$1))))
+
+print-%:
+	@echo '$*=$($*)'
-- 
2.24.1


