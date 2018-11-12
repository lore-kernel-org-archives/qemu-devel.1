Received: from eggs.gnu.org ([2001:4830:134:3::10]:45716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiezhide@huawei.com>) id 1gM0ma-0000zz-Na
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 20:12:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiezhide@huawei.com>) id 1gM0mX-0004qD-GX
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 20:12:52 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2287 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xiezhide@huawei.com>) id 1gM0mX-0004kx-1J
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 20:12:49 -0500
From: xiezhide <xiezhide@huawei.com>
Date: Mon, 12 Nov 2018 01:12:33 +0000
Message-ID: <A02D6AA901860840B46E751C5E9E38B43CC96A40@DGGEML532-MBX.china.huawei.com>
References: <A02D6AA901860840B46E751C5E9E38B42AFDB15F@DGGEML532-MBX.china.huawei.com>
In-Reply-To: <A02D6AA901860840B46E751C5E9E38B42AFDB15F@DGGEML532-MBX.china.huawei.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] virtio-9p:  fix coding style issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "armbru@redhat.com" <armbru@redhat.com>, "groug@kaod.org" <groug@kaod.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "berto@igalia.com" <berto@igalia.com>"dgilbert@redhat.com" <dgilbert@redhat.com>"armbru@redhat.com" <armbru@redhat.com>, "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>, "eblake@redhat.com" <eblake@redhat.com>

fix two coding style issue

Signed-off-by: x00390961 <xiezhide@huawei.com<mailto:xiezhide@huawei.com>>
---
 fsdev/qemu-fsdev-throttle.c      | 2 +-
 include/qemu/throttle-options.h   | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fsdev/qemu-fsdev-throttle.c b/fsdev/qemu-fsdev-throttle.c
index 7d313f2..fa2b0c8 100644
--- a/fsdev/qemu-fsdev-throttle.c
+++ b/fsdev/qemu-fsdev-throttle.c
@@ -116,7 +116,7 @@ void fsdev_get_io_throttle(FsThrottle *fst, FsdevIOThro=
ttle **fs9pcfg,
     ThrottleLimits *tlimits;
     FsdevIOThrottle *fscfg =3D g_malloc(sizeof(*fscfg));
     tlimits =3D qapi_FsdevIOThrottle_base(fscfg);
-     fscfg->has_id =3D true;
+    fscfg->has_id =3D true;
     fscfg->id =3D g_strdup(fsdevice);
     throttle_config_to_limits(&cfg, tlimits);
     *fs9pcfg =3D fscfg;
diff --git a/include/qemu/throttle-options.h b/include/qemu/throttle-option=
s.h
index 7134690..3eb1825 100644
--- a/include/qemu/throttle-options.h
+++ b/include/qemu/throttle-options.h
@@ -111,6 +111,5 @@
             .type =3D QEMU_OPT_NUMBER,\
             .help =3D "when limiting by iops max size of an I/O in bytes",=
\
         }
-
     void throttle_parse_options(ThrottleConfig *, QemuOpts *);
 #endif
--
1.8.3.1
