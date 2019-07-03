Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA3DC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 15:32:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84B072184C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 15:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84B072184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hihFO-0006df-MI
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 11:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40006)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hih8p-0000Nq-QS
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:25:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hih8n-0007c4-RQ
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:25:51 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:44739)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1hih8m-0007b3-8j; Wed, 03 Jul 2019 11:25:48 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MStT6-1i6J3w0BHa-00UM6v; Wed, 03 Jul 2019 17:25:18 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed,  3 Jul 2019 17:25:12 +0200
Message-Id: <20190703152513.29166-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190703152513.29166-1-laurent@vivier.eu>
References: <20190703152513.29166-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JcaF5sjwHTFCt7aHzuKIJ0KCl4QgWlIzcfph3RCg81DUWUmrX69
 eR8qDI9rxShWmJepn9PJthE1svivmyONywZACPDy+FTlpbOmnx0O3POyUfMmgmARr95lXZo
 zGrgJypDvtiDzJn4PJSTwF4VuK7m71jF9ISIpRibMf488EfO7etAu+xe6ZDKQVSicAMht6s
 oJjpetiF9bLXhiQjCYNlw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:74keQtL+OR8=:KBsknnQfnpANKM6ZOdFTXk
 so2pcTbNZab8lWa2zgjemHNvHFraTX3mkNj5Z9sQWw50l3u+DcLmQ84hqbhYQMGcpGZMnVDYH
 yK5oyKX6hkVRplIQVebNuAvsnEfMTsyXfPDMIlGf39+0S9hGKxDlWq8zYtadF6w8/9EC/FQg3
 q2QN+sSdF7yR2hK/9EDvYhCGjZ+blKylkw10nj63yn2+LsVIIle5Ul//Yv4nWCZRA9Q2+vi9x
 IVkWbLiDa8ydmUiacj66ux5naM+5ZQh2fpepjZSyCn74u1Neyna1QqAzmJ55M3JbF3K8O6E7k
 TQ5mqqv4pXNnyLpRRxyGrfKAepKhC8flqAN3+eG1FchFvDZbfd79Y5nlueBEBDT4MCO6ayK4z
 ZKYe+uFd0Y7XdOG14BH3eovnXk1IMTB7HFpRn4R2DVXm2r2rFcAQY9cr92dJzet0anWw5tXpt
 CNwF11Xzot3K2vPaiAzsD+4X+/AyLsqF9attxbGy+roM8TDZ1KrhT3lJ5Ajh42riJ/MZ090fR
 aVgS+sIimG/ckqFVpBr6SarVm+b4Nuz4j+5rkIPaMOg5yy8k++RO4tl3mPHNkaq0Yctms3tgZ
 C2rpAH06sGlKqFAQAc874EL1UbOT7TvVWPf7j+sxVFnIakwGTIwfdOlR4vzAW8gOX0ntwKUIR
 6qytn3at1IXi0mXX2Z9rucfqq53oCFWf7JFVmbrryBD5bBxhwui4zamuxUqG4Lh6SUPmlqVZc
 4Qgu/znARPVHZI+c7hadDwGR9676dGcyExOuq0K+t1GHZQCpIni6ARwg+GQ=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Subject: [Qemu-devel] [PULL v2 1/2] VirtIO-RNG: Update default entropy
 source to `/dev/urandom`
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>, qemu-trivial@nongnu.org,
 Amit Shah <amit@kernel.org>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kashyap Chamarthy <kchamart@redhat.com>

When QEMU exposes a VirtIO-RNG device to the guest, that device needs a
source of entropy, and that source needs to be "non-blocking", like
`/dev/urandom`.  However, currently QEMU defaults to the problematic
`/dev/random`, which on Linux is "blocking" (as in, it waits until
sufficient entropy is available).

Why prefer `/dev/urandom` over `/dev/random`?
---------------------------------------------

The man pages of urandom(4) and random(4) state:

    "The /dev/random device is a legacy interface which dates back to a
    time where the cryptographic primitives used in the implementation
    of /dev/urandom were not widely trusted.  It will return random
    bytes only within the estimated number of bits of fresh noise in the
    entropy pool, blocking if necessary.  /dev/random is suitable for
    applications that need high quality randomness, and can afford
    indeterminate delays."

Further, the "Usage" section of the said man pages state:

    "The /dev/random interface is considered a legacy interface, and
    /dev/urandom is preferred and sufficient in all use cases, with the
    exception of applications which require randomness during early boot
    time; for these applications, getrandom(2) must be used instead,
    because it will block until the entropy pool is initialized.

    "If a seed file is saved across reboots as recommended below (all
    major Linux distributions have done this since 2000 at least), the
    output is cryptographically secure against attackers without local
    root access as soon as it is reloaded in the boot sequence, and
    perfectly adequate for network encryption session keys.  Since reads
    from /dev/random may block, users will usually want to open it in
    nonblocking mode (or perform a read with timeout), and provide some
    sort of user notification if the desired entropy is not immediately
    available."

And refer to random(7) for a comparison of `/dev/random` and
`/dev/urandom`.

What about other OSes?
----------------------

`/dev/urandom` exists and works on OS-X, FreeBSD, DragonFlyBSD, NetBSD
and OpenBSD, which cover all the non-Linux platforms we explicitly
support, aside from Windows.

On Windows `/dev/random` doesn't work either so we don't regress.
This is actually another argument in favour of using the newly
proposed 'rng-builtin' backend by default, as that will work on
Windows.

    - - -

Given the above, change the entropy source for VirtIO-RNG device to
`/dev/urandom`.

Related discussion in these[1][2] past threads.

[1] https://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg08335.html
    -- "RNG: Any reason QEMU doesn't default to `/dev/urandom`?"
[2] https://lists.nongnu.org/archive/html/qemu-devel/2018-09/msg02724.html
    -- "[RFC] Virtio RNG: Consider changing the default entropy source to
       /dev/urandom"

Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20190529143106.11789-2-lvivier@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 backends/rng-random.c | 2 +-
 qemu-options.hx       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/backends/rng-random.c b/backends/rng-random.c
index aa5b9285f04d..a81058139330 100644
--- a/backends/rng-random.c
+++ b/backends/rng-random.c
@@ -113,7 +113,7 @@ static void rng_random_init(Object *obj)
                             rng_random_set_filename,
                             NULL);
 
-    s->filename = g_strdup("/dev/random");
+    s->filename = g_strdup("/dev/urandom");
     s->fd = -1;
 }
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 0d8beb4afdef..2aae19b0f925 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4328,7 +4328,7 @@ Creates a random number generator backend which obtains entropy from
 a device on the host. The @option{id} parameter is a unique ID that
 will be used to reference this entropy backend from the @option{virtio-rng}
 device. The @option{filename} parameter specifies which file to obtain
-entropy from and if omitted defaults to @option{/dev/random}.
+entropy from and if omitted defaults to @option{/dev/urandom}.
 
 @item -object rng-egd,id=@var{id},chardev=@var{chardevid}
 
-- 
2.21.0


