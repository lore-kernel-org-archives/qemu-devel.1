Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D05C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:22:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 970022082F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 970022082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Oh4-000787-59
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 07:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53103)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i0Oez-0004M1-Ng
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i0Oey-0006L1-Od
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:20:13 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:53255)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1i0Oey-0006KI-Fd; Wed, 21 Aug 2019 07:20:12 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M6EOc-1hto1S1adU-006hG6; Wed, 21 Aug 2019 13:20:02 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:19:38 +0200
Message-Id: <20190821111947.26580-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821111947.26580-1-laurent@vivier.eu>
References: <20190821111947.26580-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qzR5HNnO6FY7LGx0tZ0b6gMXbFXJvxbxC156Z+PBSbIxM+DXenD
 YUNVZX3yOe4338y5su+c7Y2AbEE3LqLKqc3aoz3prxZMjA+m6A5XEXpiNTGx5yHz0OSvNpf
 K4W2W5g5oBq3PBYnDx++LqqUdbWR0No6faQiChNygLJwIvKbFAr3vfwHob6cVqn6BlVSgAu
 8XzTBpNY1GAPXorywxN7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U928ZJdrwHE=:vlZvRbvlAJUrfcrRTtoV7P
 Y6TKwYAWp0qZenfkVEVlU/Y+Q9mOH1eNUvWtyzr1HwZIMFA8zlqxAXceMSTeOdnKldVkThGub
 bGrXhU0lVM+evvYUBpgrInf7Cl3thPtLkUbNS/pn+AvMupQRBf7QE4ZbTOH8z1eKBEcrpI6Wp
 1D19HvETiZ9JHGl/7Dv1nYQk7UyAu0lSTweb95GuMIcHhhdp9JSfrwmPkWUkyZZLBMUSEe3/X
 I0Yw4BbqRfT/3V5C6FGQtdNxe0bfaZ8lBmJrBq/70Y3ksxogY55yEQdpUOc7d42Li68KL6Wmo
 Rk35szsMKdnEWdAj+ZswvzTePvRv8uECkvZPwRJpOFI5ru4ZvxYrv/nAIVIpQM2kVQNTHwkN/
 MubdEWWimn0TCyZvMw/bm6zmuiv7fsTYhxlO4di5FPXBWA5dlVAwZ2HKDmPkcJ/VjX23hHlo7
 BngVyUgYtlYcLzr7HqR805jR6xcuuOcGyr42J6O+5T6D4Xj053ronssbip6xeNgV5b5e9+N1u
 /35q5+5t+6T4Ob/x8PwN0xqnjnavGLSp/SRKn8NY9tujweewa8fWKjC/J8OxZLWjg+CU9I6ZX
 4765MiiEZ7n10Iootlu7B1DnuhOSaRZ+3CtgI8Tnrg7KfwS2WD0hLx5i4nEXZtHgC4C3U53Mc
 idyILR3iV3lOFNBtkK7hxMp3e7Yt7EA0Q0r0nBSj5vH0+t/uSG78unKDQWVny/7M0cb5Xa01q
 UcROufOUnraJqSv9gflcHcH6n2rAKzduV+wZZDTmbBzYcTVb7V2mv1ProG8=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Subject: [Qemu-devel] [PULL 05/14] .gitignore: ignore some vhost-user*
 related files
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
 Michal Privoznik <mprivozn@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Markus Armbruster <armbru@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michal Privoznik <mprivozn@redhat.com>

Commit d52c454aadc creates
'/contrib/vhost-user-gpu/50-qemu-gpu.json' and '/vhost-user-gpu'
and commit 06914c97d3a creates '/vhost-user-input' neither of
which is ignored by git.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <db150a03315a89a849ab9968e4a5a26110d41424.1562942402.git.mprivozn@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 .gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitignore b/.gitignore
index fd6e6c38c7b9..e9bbc006d39e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -65,6 +65,8 @@
 /scsi/qemu-pr-helper
 /vhost-user-scsi
 /vhost-user-blk
+/vhost-user-gpu
+/vhost-user-input
 /fsdev/virtfs-proxy-helper
 *.tmp
 *.[1-9]
@@ -131,6 +133,7 @@
 /docs/interop/qemu-qmp-ref.info*
 /docs/interop/qemu-qmp-ref.txt
 /docs/version.texi
+/contrib/vhost-user-gpu/50-qemu-gpu.json
 *.tps
 .stgit-*
 .git-submodule-status
-- 
2.21.0


