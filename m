Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED06C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 12:45:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B34462064A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 12:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34462064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiIAG-0003xG-PI
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 08:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49001)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hiI31-0004lQ-A0
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 08:38:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hiI2z-0001bK-C5
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 08:38:11 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:48663)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1hiI2x-0001XU-I6; Tue, 02 Jul 2019 08:38:09 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N3sZs-1ihzKA1p8i-00zriC; Tue, 02 Jul 2019 14:37:18 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 14:37:12 +0200
Message-Id: <20190702123713.14396-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702123713.14396-1-laurent@vivier.eu>
References: <20190702123713.14396-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1fJWR8t1SpO4AXdBUiKTVkC1hTdcQ/ZgZ8ezmEUn/fuXp9VRann
 G9VGhGu1va2qXoL4Nv12IsyUZFrrophVaVJYYoQvTUI4WfE+/sEQBgfApnw4iufH3qWcBQI
 U0tluDr99IP3KXMuXi4QS3VIGEGztov0fo8mp0BrTFSYKxSnnGJFq650xha7rNOONbboyFx
 /u2/esoDiYdDEBD7alYCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V465oCSTkvE=:JJuAnpaG8iTh7p5d12IYZB
 q57K/yWlEUZCnWTvn5PSWP+BvS+bJ/BA6rwqxdWzPQJZYMumNgYJHBlCnfRRlnM0UKAles480
 LfUttKtSIcZ2Bo/rPnvKFD8Ian7RG5bRynsemCKiCj01E+9dEstF0gRoXmeEupSnc5SB/Lm1z
 66WSlZ+R6LkPPxOvLjvTC1CHJsyuJsLt0YjgPgtVWnN6WCX7YaohznLDclvLwzD9KS/Kf+w2Y
 JP1hCyjr2l6k+uNDTMksxxcQ7ff1kAirz0lxg728HaxhrsP32hpSNrlW32ZpjdPQrcbeln4Vg
 3WH2Uvl6iIWGhzobKRZrS+TOljApDc8LAmoer01kKFttlNrPNOM86vt/7w/eKi2Fmcrhz/TZr
 pGqNhRl6rcUsUZ0/iWHZVscEsulaWEGg7IMQtcp3MFWlC1hveiiYnz+3Rpcz0rldHAB/WBJqk
 El54HYqJDzdh+20MIRT+WUdWA1YvGQH8pEoJo8yn3aQSDVr6DsZj27/0MVaZ/vqYlyQ/4sWKQ
 DiIwsK8B8BQaRPNDPSGRW10nbnqqvoSS/oVphod3WjDm6Qr7CNOj2AZyMS8HYs9B8AkZuaR2C
 UBdbUP8a/gp0wq4XIHUVzpyBWr6X+AR1zRW+VXoySN6Unl2GxjXn8VI+xq2vElSL79jo0rhVl
 ADDsny6r6bFljjVuEzxIMSxfHfYv2jasTXYPDVNHCwi36MzASqmTBt0KVEXfhaxCz0eFnomIE
 LRTjCPAYNmfDQ3Tgt0HHD1xiEWOJTIjwbCXc3/4UqGtz1/OCKodjsYrMGvo=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
Subject: [Qemu-devel] [PULL 2/3] VirtIO-RNG: Update default entropy source
 to `/dev/urandom`
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


