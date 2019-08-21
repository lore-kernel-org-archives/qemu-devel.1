Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D640CC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:36:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93C5F22CE3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C5F22CE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0OuT-000674-6s
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 07:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53585)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i0OfS-00057H-Pk
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:20:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i0OfQ-0006dq-Ru
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:20:42 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:57473)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1i0OfO-0006Zw-1N; Wed, 21 Aug 2019 07:20:38 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MeC1p-1iYuj448dL-00bKij; Wed, 21 Aug 2019 13:19:58 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:19:35 +0200
Message-Id: <20190821111947.26580-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821111947.26580-1-laurent@vivier.eu>
References: <20190821111947.26580-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AQxPhlodgDaqZdj3nFfO5kylgpEg7MXdO5oZ7h/MRPjGk+4MM8r
 2bFp75yaqL0+e5WicFLnPxaOec1RKxPP/jJ1VOuuW9GxcIfA6t4nCULVPdBSJXsYet591qk
 sKMokVIs74Cp37XQTvZmYZA0HJWVHGZ2tVcEh3eu1rgZo1VdHn28jY5mHjs942DoDHWNWZM
 jf4AEsLgAcvkYrLkNTJow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OA2wNjpZBP4=:o7AjAppwGSdubTASaaO8qL
 E5XDSbc8LmSKBbf7XPE1NmNAg7aKi6ddD7wK70zPaHnaCGvVLVkllf6WHInAsWZK3B6vaQewN
 Ilg57YUUzM3it5fv42X6xtLlChZFq1rpIRazGRw7KaUH6gvLXWnPRNHtNf4HZT0nMvcpwy1Ok
 N+6k6REIC3WtdMIV57w0Wne8d/9sA1m6qYi+QzF2Sbb+1cwBt6JaGzDopyzb9K9KfuOz2XAlf
 EculVkYkRWGE/jZ+hxftS5WWQVzWzIYdlomTCsiDY0D0NeAiX5WVWoZ+NWHI4jHVTZj10g7Lu
 fj6szJUoV+lXRvrUIbFzdHjP8SWTbIXFZYhTCWlrLEKv/4z5SV7jL9VZriSmsyhAMgTq43mWu
 Td6dVU5gjocp6aLz4NU1eGzbcB7QwMjJE6kp0Lki0BbLJpBbhkukdn0hnmjthr0hM8sGgtg4B
 xURqTEe7lNd00JiFRhdYb0RwvEIadLbVabSbmhBpx8sDjcNW+dYFv25auuwLC2faaFhIWjXev
 pTI9dl82q/Jj/ZG+qAZgD4OUDYEqARBhMBj7qReNulEEdz6UmqsPo7dAjnUV6W216xGfgCl49
 0GOnfYdJbTajwiumgSgKT2UH1ahrX3Gr5AU4Os4sgjEvpUU0/6uysK5rpkndedEPd3CCdT0VT
 gN3bxNEedNkZpaLe7KCHI0xMPAP3GKtblt5jEuewHsSUJ6LhcJVJiQNiDKTbQ/wl5ErvoSn0R
 zDVVgHCem3V+KLTjVArvXJrzqs2KNlb1FDArUdPkh8aF8baMOyn+oOHOd5s=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
Subject: [Qemu-devel] [PULL 02/14] misc: fix naming scheme of compatiblity
 arrays
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
 Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>,
 Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Since merge 31ed41889e6e13699871040fe089a2884dca46cb ("Merge
remote-tracking branch
'remotes/elmarco/tags/machine-props-pull-request' into staging"), the
compat arrays are in lowercase.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20190708204909.10891-1-marcandre.lureau@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 docs/devel/migration.rst | 2 +-
 hw/i386/pc_piix.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
index 220059679ac9..f7668ae389c7 100644
--- a/docs/devel/migration.rst
+++ b/docs/devel/migration.rst
@@ -314,7 +314,7 @@ For example:
 
    a) Add a new property using ``DEFINE_PROP_BOOL`` - e.g. support-foo and
       default it to true.
-   b) Add an entry to the ``HW_COMPAT_`` for the previous version that sets
+   b) Add an entry to the ``hw_compat_`` for the previous version that sets
       the property to false.
    c) Add a static bool  support_foo function that tests the property.
    d) Add a subsection with a .needed set to the support_foo function
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 9e187f856a63..187d846af4b0 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -312,7 +312,7 @@ else {
  * pc_compat_*() functions that run on machine-init time and
  * change global QEMU state are deprecated. Please don't create
  * one, and implement any pc-*-2.4 (and newer) compat code in
- * HW_COMPAT_*, PC_COMPAT_*, or * pc_*_machine_options().
+ * hw_compat_*, pc_compat_*, or * pc_*_machine_options().
  */
 
 static void pc_compat_2_3_fn(MachineState *machine)
-- 
2.21.0


