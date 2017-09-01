Received: from eggs.gnu.org ([2001:4830:134:3::10]:51818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dno1Y-0006qK-EJ
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dno1O-0001lu-0K
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dno1N-0001kA-KO
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 973D42DDB9
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 15:38:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-75.ams2.redhat.com
	[10.36.116.75])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B310C808E6
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 15:38:11 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Sep 2017 17:37:55 +0200
Message-Id: <20170901153758.8628-45-armbru@redhat.com>
In-Reply-To: <20170901153758.8628-1-armbru@redhat.com>
References: <20170901153758.8628-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 44/47] qapi: Mechanically convert
 FOO_lookup[...] to FOO_str(...)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1503564371-26090-14-git-send-email-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 backends/hostmem.c                  |  2 +-
 block/backup.c                      |  2 +-
 block/file-posix.c                  |  4 +--
 block/file-win32.c                  |  2 +-
 block/gluster.c                     |  4 +--
 block/iscsi.c                       |  2 +-
 block/nfs.c                         |  2 +-
 block/qcow2.c                       |  4 +--
 block/qed.c                         |  2 +-
 block/rbd.c                         |  2 +-
 block/sheepdog.c                    |  2 +-
 blockdev.c                          |  4 +--
 blockjob.c                          |  6 ++---
 chardev/char.c                      |  4 +--
 crypto/block-luks.c                 | 12 ++++-----
 crypto/block.c                      |  4 +--
 crypto/cipher-afalg.c               |  2 +-
 crypto/cipher-builtin.c             |  8 +++---
 crypto/cipher-gcrypt.c              |  4 +--
 crypto/cipher-nettle.c              |  8 +++---
 crypto/hmac-gcrypt.c                |  2 +-
 crypto/hmac-glib.c                  |  2 +-
 crypto/hmac-nettle.c                |  2 +-
 crypto/pbkdf-gcrypt.c               |  2 +-
 crypto/pbkdf-nettle.c               |  2 +-
 hmp.c                               | 54 ++++++++++++++++++-------------=
------
 hw/block/fdc.c                      |  6 ++---
 hw/char/escc.c                      |  2 +-
 hw/input/virtio-input-hid.c         |  4 +--
 migration/colo-failover.c           |  4 +--
 migration/colo.c                    | 14 +++++-----
 migration/global_state.c            |  2 +-
 monitor.c                           | 16 +++++------
 net/net.c                           |  4 +--
 qapi/qmp-dispatch.c                 |  2 +-
 tests/test-qapi-util.c              |  2 +-
 tests/test-qobject-input-visitor.c  |  4 +--
 tests/test-qobject-output-visitor.c |  2 +-
 tests/test-string-input-visitor.c   |  2 +-
 tests/test-string-output-visitor.c  |  4 +--
 tpm.c                               |  2 +-
 ui/input-legacy.c                   |  4 +--
 ui/input.c                          | 12 ++++-----
 ui/vnc.c                            |  6 ++---
 vl.c                                |  6 ++---
 45 files changed, 121 insertions(+), 121 deletions(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 4606b73849..06e8898e40 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -304,7 +304,7 @@ host_memory_backend_memory_complete(UserCreatable *uc=
, Error **errp)
             return;
         } else if (maxnode =3D=3D 0 && backend->policy !=3D MPOL_DEFAULT=
) {
             error_setg(errp, "host-nodes must be set for policy %s",
-                       HostMemPolicy_lookup[backend->policy]);
+                       HostMemPolicy_str(backend->policy));
             return;
         }
=20
diff --git a/block/backup.c b/block/backup.c
index 504a089150..517c300a49 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -596,7 +596,7 @@ BlockJob *backup_job_create(const char *job_id, Block=
DriverState *bs,
         error_setg(errp,
                    "a sync_bitmap was provided to backup_run, "
                    "but received an incompatible sync_mode (%s)",
-                   MirrorSyncMode_lookup[sync_mode]);
+                   MirrorSyncMode_str(sync_mode));
         return NULL;
     }
=20
diff --git a/block/file-posix.c b/block/file-posix.c
index d81eccc191..bfef91db63 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1724,7 +1724,7 @@ static int raw_regular_truncate(int fd, int64_t off=
set, PreallocMode prealloc,
     default:
         result =3D -ENOTSUP;
         error_setg(errp, "Unsupported preallocation mode: %s",
-                   PreallocMode_lookup[prealloc]);
+                   PreallocMode_str(prealloc));
         return result;
     }
=20
@@ -1759,7 +1759,7 @@ static int raw_truncate(BlockDriverState *bs, int64=
_t offset,
=20
     if (prealloc !=3D PREALLOC_MODE_OFF) {
         error_setg(errp, "Preallocation mode '%s' unsupported for this "
-                   "non-regular file", PreallocMode_lookup[prealloc]);
+                   "non-regular file", PreallocMode_str(prealloc));
         return -ENOTSUP;
     }
=20
diff --git a/block/file-win32.c b/block/file-win32.c
index 192ea819d9..f2a1830060 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -469,7 +469,7 @@ static int raw_truncate(BlockDriverState *bs, int64_t=
 offset,
=20
     if (prealloc !=3D PREALLOC_MODE_OFF) {
         error_setg(errp, "Unsupported preallocation mode '%s'",
-                   PreallocMode_lookup[prealloc]);
+                   PreallocMode_str(prealloc));
         return -ENOTSUP;
     }
=20
diff --git a/block/gluster.c b/block/gluster.c
index 0614e0c8aa..29f9427e47 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -1047,7 +1047,7 @@ static int qemu_gluster_create(const char *filename=
,
     default:
         ret =3D -EINVAL;
         error_setg(errp, "Unsupported preallocation mode: %s",
-                   PreallocMode_lookup[prealloc]);
+                   PreallocMode_str(prealloc));
         break;
     }
=20
@@ -1099,7 +1099,7 @@ static int qemu_gluster_truncate(BlockDriverState *=
bs, int64_t offset,
=20
     if (prealloc !=3D PREALLOC_MODE_OFF) {
         error_setg(errp, "Unsupported preallocation mode '%s'",
-                   PreallocMode_lookup[prealloc]);
+                   PreallocMode_str(prealloc));
         return -ENOTSUP;
     }
=20
diff --git a/block/iscsi.c b/block/iscsi.c
index d557c99668..8b47d30dcc 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2087,7 +2087,7 @@ static int iscsi_truncate(BlockDriverState *bs, int=
64_t offset,
=20
     if (prealloc !=3D PREALLOC_MODE_OFF) {
         error_setg(errp, "Unsupported preallocation mode '%s'",
-                   PreallocMode_lookup[prealloc]);
+                   PreallocMode_str(prealloc));
         return -ENOTSUP;
     }
=20
diff --git a/block/nfs.c b/block/nfs.c
index bec16b72a6..337fcd9c84 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -772,7 +772,7 @@ static int nfs_file_truncate(BlockDriverState *bs, in=
t64_t offset,
=20
     if (prealloc !=3D PREALLOC_MODE_OFF) {
         error_setg(errp, "Unsupported preallocation mode '%s'",
-                   PreallocMode_lookup[prealloc]);
+                   PreallocMode_str(prealloc));
         return -ENOTSUP;
     }
=20
diff --git a/block/qcow2.c b/block/qcow2.c
index 3a93983e3f..cbe9681fb0 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2715,7 +2715,7 @@ static int qcow2_create2(const char *filename, int6=
4_t total_size,
         int64_t prealloc_size =3D
             qcow2_calc_prealloc_size(total_size, cluster_size, refcount_=
order);
         qemu_opt_set_number(opts, BLOCK_OPT_SIZE, prealloc_size, &error_=
abort);
-        qemu_opt_set(opts, BLOCK_OPT_PREALLOC, PreallocMode_lookup[preal=
loc],
+        qemu_opt_set(opts, BLOCK_OPT_PREALLOC, PreallocMode_str(prealloc=
),
                      &error_abort);
     }
=20
@@ -3080,7 +3080,7 @@ static int qcow2_truncate(BlockDriverState *bs, int=
64_t offset,
         prealloc !=3D PREALLOC_MODE_FALLOC && prealloc !=3D PREALLOC_MOD=
E_FULL)
     {
         error_setg(errp, "Unsupported preallocation mode '%s'",
-                   PreallocMode_lookup[prealloc]);
+                   PreallocMode_str(prealloc));
         return -ENOTSUP;
     }
=20
diff --git a/block/qed.c b/block/qed.c
index dc54bf4a93..28e2ec89e8 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1399,7 +1399,7 @@ static int bdrv_qed_truncate(BlockDriverState *bs, =
int64_t offset,
=20
     if (prealloc !=3D PREALLOC_MODE_OFF) {
         error_setg(errp, "Unsupported preallocation mode '%s'",
-                   PreallocMode_lookup[prealloc]);
+                   PreallocMode_str(prealloc));
         return -ENOTSUP;
     }
=20
diff --git a/block/rbd.c b/block/rbd.c
index 9c3aa638e7..144f350e1f 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -944,7 +944,7 @@ static int qemu_rbd_truncate(BlockDriverState *bs, in=
t64_t offset,
=20
     if (prealloc !=3D PREALLOC_MODE_OFF) {
         error_setg(errp, "Unsupported preallocation mode '%s'",
-                   PreallocMode_lookup[prealloc]);
+                   PreallocMode_str(prealloc));
         return -ENOTSUP;
     }
=20
diff --git a/block/sheepdog.c b/block/sheepdog.c
index abb2e79065..1052098ec5 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -2176,7 +2176,7 @@ static int sd_truncate(BlockDriverState *bs, int64_=
t offset,
=20
     if (prealloc !=3D PREALLOC_MODE_OFF) {
         error_setg(errp, "Unsupported preallocation mode '%s'",
-                   PreallocMode_lookup[prealloc]);
+                   PreallocMode_str(prealloc));
         return -ENOTSUP;
     }
=20
diff --git a/blockdev.c b/blockdev.c
index f90bc9399a..bfb2a95299 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1466,8 +1466,8 @@ static int action_check_completion_mode(BlkActionSt=
ate *s, Error **errp)
         error_setg(errp,
                    "Action '%s' does not support Transaction property "
                    "completion-mode =3D %s",
-                   TransactionActionKind_lookup[s->action->type],
-                   ActionCompletionMode_lookup[s->txn_props->completion_=
mode]);
+                   TransactionActionKind_str(s->action->type),
+                   ActionCompletionMode_str(s->txn_props->completion_mod=
e));
         return -1;
     }
     return 0;
diff --git a/blockjob.c b/blockjob.c
index 70a78188b7..3a0c49137e 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -208,7 +208,7 @@ static char *child_job_get_parent_desc(BdrvChild *c)
 {
     BlockJob *job =3D c->opaque;
     return g_strdup_printf("%s job '%s'",
-                           BlockJobType_lookup[job->driver->job_type],
+                           BlockJobType_str(job->driver->job_type),
                            job->id);
 }
=20
@@ -553,7 +553,7 @@ BlockJobInfo *block_job_query(BlockJob *job, Error **=
errp)
         return NULL;
     }
     info =3D g_new0(BlockJobInfo, 1);
-    info->type      =3D g_strdup(BlockJobType_lookup[job->driver->job_ty=
pe]);
+    info->type      =3D g_strdup(BlockJobType_str(job->driver->job_type)=
);
     info->device    =3D g_strdup(job->id);
     info->len       =3D job->len;
     info->busy      =3D job->busy;
@@ -666,7 +666,7 @@ void *block_job_create(const char *job_id, const Bloc=
kJobDriver *driver,
     job->refcnt        =3D 1;
=20
     error_setg(&job->blocker, "block device is in use by block job: %s",
-               BlockJobType_lookup[driver->job_type]);
+               BlockJobType_str(driver->job_type));
     block_job_add_bdrv(job, "main node", bs, 0, BLK_PERM_ALL, &error_abo=
rt);
     bs->job =3D job;
=20
diff --git a/chardev/char.c b/chardev/char.c
index 5d283b90d3..b6fd5eb6a6 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -931,7 +931,7 @@ ChardevReturn *qmp_chardev_add(const char *id, Charde=
vBackend *backend,
     ChardevReturn *ret;
     Chardev *chr;
=20
-    cc =3D char_get_class(ChardevBackendKind_lookup[backend->type], errp=
);
+    cc =3D char_get_class(ChardevBackendKind_str(backend->type), errp);
     if (!cc) {
         return NULL;
     }
@@ -989,7 +989,7 @@ ChardevReturn *qmp_chardev_change(const char *id, Cha=
rdevBackend *backend,
         return NULL;
     }
=20
-    cc =3D char_get_class(ChardevBackendKind_lookup[backend->type], errp=
);
+    cc =3D char_get_class(ChardevBackendKind_str(backend->type), errp);
     if (!cc) {
         return NULL;
     }
diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 84d189a426..4e828951d4 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -257,7 +257,7 @@ qcrypto_block_luks_cipher_alg_lookup(QCryptoCipherAlg=
orithm alg,
     }
=20
     error_setg(errp, "Algorithm '%s' not supported",
-               QCryptoCipherAlgorithm_lookup[alg]);
+               QCryptoCipherAlgorithm_str(alg));
     return NULL;
 }
=20
@@ -392,7 +392,7 @@ qcrypto_block_luks_essiv_cipher(QCryptoCipherAlgorith=
m cipher,
         break;
     default:
         error_setg(errp, "Cipher %s not supported with essiv",
-                   QCryptoCipherAlgorithm_lookup[cipher]);
+                   QCryptoCipherAlgorithm_str(cipher));
         return 0;
     }
 }
@@ -962,16 +962,16 @@ qcrypto_block_luks_create(QCryptoBlock *block,
         goto error;
     }
=20
-    cipher_mode =3D QCryptoCipherMode_lookup[luks_opts.cipher_mode];
-    ivgen_alg =3D QCryptoIVGenAlgorithm_lookup[luks_opts.ivgen_alg];
+    cipher_mode =3D QCryptoCipherMode_str(luks_opts.cipher_mode);
+    ivgen_alg =3D QCryptoIVGenAlgorithm_str(luks_opts.ivgen_alg);
     if (luks_opts.has_ivgen_hash_alg) {
-        ivgen_hash_alg =3D QCryptoHashAlgorithm_lookup[luks_opts.ivgen_h=
ash_alg];
+        ivgen_hash_alg =3D QCryptoHashAlgorithm_str(luks_opts.ivgen_hash=
_alg);
         cipher_mode_spec =3D g_strdup_printf("%s-%s:%s", cipher_mode, iv=
gen_alg,
                                            ivgen_hash_alg);
     } else {
         cipher_mode_spec =3D g_strdup_printf("%s-%s", cipher_mode, ivgen=
_alg);
     }
-    hash_alg =3D QCryptoHashAlgorithm_lookup[luks_opts.hash_alg];
+    hash_alg =3D QCryptoHashAlgorithm_str(luks_opts.hash_alg);
=20
=20
     if (strlen(cipher_alg) >=3D QCRYPTO_BLOCK_LUKS_CIPHER_NAME_LEN) {
diff --git a/crypto/block.c b/crypto/block.c
index b097d451af..c382393d9a 100644
--- a/crypto/block.c
+++ b/crypto/block.c
@@ -61,7 +61,7 @@ QCryptoBlock *qcrypto_block_open(QCryptoBlockOpenOption=
s *options,
     if (options->format >=3D G_N_ELEMENTS(qcrypto_block_drivers) ||
         !qcrypto_block_drivers[options->format]) {
         error_setg(errp, "Unsupported block driver %s",
-                   QCryptoBlockFormat_lookup[options->format]);
+                   QCryptoBlockFormat_str(options->format));
         g_free(block);
         return NULL;
     }
@@ -92,7 +92,7 @@ QCryptoBlock *qcrypto_block_create(QCryptoBlockCreateOp=
tions *options,
     if (options->format >=3D G_N_ELEMENTS(qcrypto_block_drivers) ||
         !qcrypto_block_drivers[options->format]) {
         error_setg(errp, "Unsupported block driver %s",
-                   QCryptoBlockFormat_lookup[options->format]);
+                   QCryptoBlockFormat_str(options->format));
         g_free(block);
         return NULL;
     }
diff --git a/crypto/cipher-afalg.c b/crypto/cipher-afalg.c
index 01343b2b7c..cd72284690 100644
--- a/crypto/cipher-afalg.c
+++ b/crypto/cipher-afalg.c
@@ -52,7 +52,7 @@ qcrypto_afalg_cipher_format_name(QCryptoCipherAlgorithm=
 alg,
         return NULL;
     }
=20
-    mode_name =3D QCryptoCipherMode_lookup[mode];
+    mode_name =3D QCryptoCipherMode_str(mode);
     name =3D g_strdup_printf("%s(%s)", mode_name, alg_name);
=20
     return name;
diff --git a/crypto/cipher-builtin.c b/crypto/cipher-builtin.c
index 16a36d4532..d8c811fd33 100644
--- a/crypto/cipher-builtin.c
+++ b/crypto/cipher-builtin.c
@@ -247,7 +247,7 @@ qcrypto_cipher_init_aes(QCryptoCipherMode mode,
         mode !=3D QCRYPTO_CIPHER_MODE_ECB &&
         mode !=3D QCRYPTO_CIPHER_MODE_XTS) {
         error_setg(errp, "Unsupported cipher mode %s",
-                   QCryptoCipherMode_lookup[mode]);
+                   QCryptoCipherMode_str(mode));
         return NULL;
     }
=20
@@ -379,7 +379,7 @@ qcrypto_cipher_init_des_rfb(QCryptoCipherMode mode,
=20
     if (mode !=3D QCRYPTO_CIPHER_MODE_ECB) {
         error_setg(errp, "Unsupported cipher mode %s",
-                   QCryptoCipherMode_lookup[mode]);
+                   QCryptoCipherMode_str(mode));
         return NULL;
     }
=20
@@ -440,7 +440,7 @@ static QCryptoCipherBuiltin *qcrypto_cipher_ctx_new(Q=
CryptoCipherAlgorithm alg,
         break;
     default:
         error_setg(errp, "Unsupported cipher mode %s",
-                   QCryptoCipherMode_lookup[mode]);
+                   QCryptoCipherMode_str(mode));
         return NULL;
     }
=20
@@ -460,7 +460,7 @@ static QCryptoCipherBuiltin *qcrypto_cipher_ctx_new(Q=
CryptoCipherAlgorithm alg,
     default:
         error_setg(errp,
                    "Unsupported cipher algorithm %s",
-                   QCryptoCipherAlgorithm_lookup[alg]);
+                   QCryptoCipherAlgorithm_str(alg));
         return NULL;
     }
=20
diff --git a/crypto/cipher-gcrypt.c b/crypto/cipher-gcrypt.c
index 0489147398..10d75da75d 100644
--- a/crypto/cipher-gcrypt.c
+++ b/crypto/cipher-gcrypt.c
@@ -105,7 +105,7 @@ static QCryptoCipherGcrypt *qcrypto_cipher_ctx_new(QC=
ryptoCipherAlgorithm alg,
         break;
     default:
         error_setg(errp, "Unsupported cipher mode %s",
-                   QCryptoCipherMode_lookup[mode]);
+                   QCryptoCipherMode_str(mode));
         return NULL;
     }
=20
@@ -160,7 +160,7 @@ static QCryptoCipherGcrypt *qcrypto_cipher_ctx_new(QC=
ryptoCipherAlgorithm alg,
=20
     default:
         error_setg(errp, "Unsupported cipher algorithm %s",
-                   QCryptoCipherAlgorithm_lookup[alg]);
+                   QCryptoCipherAlgorithm_str(alg));
         return NULL;
     }
=20
diff --git a/crypto/cipher-nettle.c b/crypto/cipher-nettle.c
index c51f119cbc..3848cb3b3a 100644
--- a/crypto/cipher-nettle.c
+++ b/crypto/cipher-nettle.c
@@ -281,7 +281,7 @@ static QCryptoCipherNettle *qcrypto_cipher_ctx_new(QC=
ryptoCipherAlgorithm alg,
         break;
     default:
         error_setg(errp, "Unsupported cipher mode %s",
-                   QCryptoCipherMode_lookup[mode]);
+                   QCryptoCipherMode_str(mode));
         return NULL;
     }
=20
@@ -420,7 +420,7 @@ static QCryptoCipherNettle *qcrypto_cipher_ctx_new(QC=
ryptoCipherAlgorithm alg,
=20
     default:
         error_setg(errp, "Unsupported cipher algorithm %s",
-                   QCryptoCipherAlgorithm_lookup[alg]);
+                   QCryptoCipherAlgorithm_str(alg));
         goto error;
     }
=20
@@ -491,7 +491,7 @@ qcrypto_nettle_cipher_encrypt(QCryptoCipher *cipher,
=20
     default:
         error_setg(errp, "Unsupported cipher mode %s",
-                   QCryptoCipherMode_lookup[cipher->mode]);
+                   QCryptoCipherMode_str(cipher->mode));
         return -1;
     }
     return 0;
@@ -537,7 +537,7 @@ qcrypto_nettle_cipher_decrypt(QCryptoCipher *cipher,
=20
     default:
         error_setg(errp, "Unsupported cipher mode %s",
-                   QCryptoCipherMode_lookup[cipher->mode]);
+                   QCryptoCipherMode_str(cipher->mode));
         return -1;
     }
     return 0;
diff --git a/crypto/hmac-gcrypt.c b/crypto/hmac-gcrypt.c
index 76ca61ba24..0c6f979711 100644
--- a/crypto/hmac-gcrypt.c
+++ b/crypto/hmac-gcrypt.c
@@ -52,7 +52,7 @@ void *qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
=20
     if (!qcrypto_hmac_supports(alg)) {
         error_setg(errp, "Unsupported hmac algorithm %s",
-                   QCryptoHashAlgorithm_lookup[alg]);
+                   QCryptoHashAlgorithm_str(alg));
         return NULL;
     }
=20
diff --git a/crypto/hmac-glib.c b/crypto/hmac-glib.c
index 8cf6b221ed..a6c1730291 100644
--- a/crypto/hmac-glib.c
+++ b/crypto/hmac-glib.c
@@ -58,7 +58,7 @@ void *qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
=20
     if (!qcrypto_hmac_supports(alg)) {
         error_setg(errp, "Unsupported hmac algorithm %s",
-                   QCryptoHashAlgorithm_lookup[alg]);
+                   QCryptoHashAlgorithm_str(alg));
         return NULL;
     }
=20
diff --git a/crypto/hmac-nettle.c b/crypto/hmac-nettle.c
index 1d5a915f03..ec2d61bdde 100644
--- a/crypto/hmac-nettle.c
+++ b/crypto/hmac-nettle.c
@@ -106,7 +106,7 @@ void *qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
=20
     if (!qcrypto_hmac_supports(alg)) {
         error_setg(errp, "Unsupported hmac algorithm %s",
-                   QCryptoHashAlgorithm_lookup[alg]);
+                   QCryptoHashAlgorithm_str(alg));
         return NULL;
     }
=20
diff --git a/crypto/pbkdf-gcrypt.c b/crypto/pbkdf-gcrypt.c
index 40289858bf..54ca0d9c75 100644
--- a/crypto/pbkdf-gcrypt.c
+++ b/crypto/pbkdf-gcrypt.c
@@ -68,7 +68,7 @@ int qcrypto_pbkdf2(QCryptoHashAlgorithm hash,
         hash_map[hash] =3D=3D GCRY_MD_NONE) {
         error_setg_errno(errp, ENOSYS,
                          "PBKDF does not support hash algorithm %s",
-                         QCryptoHashAlgorithm_lookup[hash]);
+                         QCryptoHashAlgorithm_str(hash));
         return -1;
     }
=20
diff --git a/crypto/pbkdf-nettle.c b/crypto/pbkdf-nettle.c
index 6fb2671656..212b3e816b 100644
--- a/crypto/pbkdf-nettle.c
+++ b/crypto/pbkdf-nettle.c
@@ -110,7 +110,7 @@ int qcrypto_pbkdf2(QCryptoHashAlgorithm hash,
     default:
         error_setg_errno(errp, ENOSYS,
                          "PBKDF does not support hash algorithm %s",
-                         QCryptoHashAlgorithm_lookup[hash]);
+                         QCryptoHashAlgorithm_str(hash));
         return -1;
     }
     return 0;
diff --git a/hmp.c b/hmp.c
index 5d980acb1e..30819fe602 100644
--- a/hmp.c
+++ b/hmp.c
@@ -106,7 +106,7 @@ void hmp_info_status(Monitor *mon, const QDict *qdict=
)
                    info->singlestep ? " (single step mode)" : "");
=20
     if (!info->running && info->status !=3D RUN_STATE_PAUSED) {
-        monitor_printf(mon, " (%s)", RunState_lookup[info->status]);
+        monitor_printf(mon, " (%s)", RunState_str(info->status));
     }
=20
     monitor_printf(mon, "\n");
@@ -171,7 +171,7 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdic=
t)
         monitor_printf(mon, "capabilities: ");
         for (cap =3D caps; cap; cap =3D cap->next) {
             monitor_printf(mon, "%s: %s ",
-                           MigrationCapability_lookup[cap->value->capabi=
lity],
+                           MigrationCapability_str(cap->value->capabilit=
y),
                            cap->value->state ? "on" : "off");
         }
         monitor_printf(mon, "\n");
@@ -179,7 +179,7 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdic=
t)
=20
     if (info->has_status) {
         monitor_printf(mon, "Migration status: %s",
-                       MigrationStatus_lookup[info->status]);
+                       MigrationStatus_str(info->status));
         if (info->status =3D=3D MIGRATION_STATUS_FAILED &&
             info->has_error_desc) {
             monitor_printf(mon, " (%s)\n", info->error_desc);
@@ -277,7 +277,7 @@ void hmp_info_migrate_capabilities(Monitor *mon, cons=
t QDict *qdict)
     if (caps) {
         for (cap =3D caps; cap; cap =3D cap->next) {
             monitor_printf(mon, "%s: %s\n",
-                           MigrationCapability_lookup[cap->value->capabi=
lity],
+                           MigrationCapability_str(cap->value->capabilit=
y),
                            cap->value->state ? "on" : "off");
         }
     }
@@ -294,48 +294,48 @@ void hmp_info_migrate_parameters(Monitor *mon, cons=
t QDict *qdict)
     if (params) {
         assert(params->has_compress_level);
         monitor_printf(mon, "%s: %" PRId64 "\n",
-            MigrationParameter_lookup[MIGRATION_PARAMETER_COMPRESS_LEVEL=
],
+            MigrationParameter_str(MIGRATION_PARAMETER_COMPRESS_LEVEL),
             params->compress_level);
         assert(params->has_compress_threads);
         monitor_printf(mon, "%s: %" PRId64 "\n",
-            MigrationParameter_lookup[MIGRATION_PARAMETER_COMPRESS_THREA=
DS],
+            MigrationParameter_str(MIGRATION_PARAMETER_COMPRESS_THREADS)=
,
             params->compress_threads);
         assert(params->has_decompress_threads);
         monitor_printf(mon, "%s: %" PRId64 "\n",
-            MigrationParameter_lookup[MIGRATION_PARAMETER_DECOMPRESS_THR=
EADS],
+            MigrationParameter_str(MIGRATION_PARAMETER_DECOMPRESS_THREAD=
S),
             params->decompress_threads);
         assert(params->has_cpu_throttle_initial);
         monitor_printf(mon, "%s: %" PRId64 "\n",
-            MigrationParameter_lookup[MIGRATION_PARAMETER_CPU_THROTTLE_I=
NITIAL],
+            MigrationParameter_str(MIGRATION_PARAMETER_CPU_THROTTLE_INIT=
IAL),
             params->cpu_throttle_initial);
         assert(params->has_cpu_throttle_increment);
         monitor_printf(mon, "%s: %" PRId64 "\n",
-            MigrationParameter_lookup[MIGRATION_PARAMETER_CPU_THROTTLE_I=
NCREMENT],
+            MigrationParameter_str(MIGRATION_PARAMETER_CPU_THROTTLE_INCR=
EMENT),
             params->cpu_throttle_increment);
         assert(params->has_tls_creds);
         monitor_printf(mon, "%s: '%s'\n",
-            MigrationParameter_lookup[MIGRATION_PARAMETER_TLS_CREDS],
+            MigrationParameter_str(MIGRATION_PARAMETER_TLS_CREDS),
             params->tls_creds);
         assert(params->has_tls_hostname);
         monitor_printf(mon, "%s: '%s'\n",
-            MigrationParameter_lookup[MIGRATION_PARAMETER_TLS_HOSTNAME],
+            MigrationParameter_str(MIGRATION_PARAMETER_TLS_HOSTNAME),
             params->tls_hostname);
         assert(params->has_max_bandwidth);
         monitor_printf(mon, "%s: %" PRId64 " bytes/second\n",
-            MigrationParameter_lookup[MIGRATION_PARAMETER_MAX_BANDWIDTH]=
,
+            MigrationParameter_str(MIGRATION_PARAMETER_MAX_BANDWIDTH),
             params->max_bandwidth);
         assert(params->has_downtime_limit);
         monitor_printf(mon, "%s: %" PRId64 " milliseconds\n",
-            MigrationParameter_lookup[MIGRATION_PARAMETER_DOWNTIME_LIMIT=
],
+            MigrationParameter_str(MIGRATION_PARAMETER_DOWNTIME_LIMIT),
             params->downtime_limit);
         assert(params->has_x_checkpoint_delay);
         monitor_printf(mon, "%s: %" PRId64 "\n",
-            MigrationParameter_lookup[MIGRATION_PARAMETER_X_CHECKPOINT_D=
ELAY],
+            MigrationParameter_str(MIGRATION_PARAMETER_X_CHECKPOINT_DELA=
Y),
             params->x_checkpoint_delay);
         assert(params->has_block_incremental);
         monitor_printf(mon, "%s: %s\n",
-            MigrationParameter_lookup[MIGRATION_PARAMETER_BLOCK_INCREMEN=
TAL],
-                       params->block_incremental ? "on" : "off");
+            MigrationParameter_str(MIGRATION_PARAMETER_BLOCK_INCREMENTAL=
),
+            params->block_incremental ? "on" : "off");
     }
=20
     qapi_free_MigrationParameters(params);
@@ -431,7 +431,7 @@ static void print_block_info(Monitor *mon, BlockInfo =
*info,
         }
         if (info->has_io_status && info->io_status !=3D BLOCK_DEVICE_IO_=
STATUS_OK) {
             monitor_printf(mon, "    I/O status:       %s\n",
-                           BlockDeviceIoStatus_lookup[info->io_status]);
+                           BlockDeviceIoStatus_str(info->io_status));
         }
=20
         if (info->removable) {
@@ -461,7 +461,7 @@ static void print_block_info(Monitor *mon, BlockInfo =
*info,
=20
     if (inserted->detect_zeroes !=3D BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF)=
 {
         monitor_printf(mon, "    Detect zeroes:    %s\n",
-                       BlockdevDetectZeroesOptions_lookup[inserted->dete=
ct_zeroes]);
+                BlockdevDetectZeroesOptions_str(inserted->detect_zeroes)=
);
     }
=20
     if (inserted->bps  || inserted->bps_rd  || inserted->bps_wr  ||
@@ -612,7 +612,7 @@ static void hmp_info_VncBasicInfo(Monitor *mon, VncBa=
sicInfo *info,
                    name,
                    info->host,
                    info->service,
-                   NetworkAddressFamily_lookup[info->family],
+                   NetworkAddressFamily_str(info->family),
                    info->websocket ? " (Websocket)" : "");
 }
=20
@@ -622,8 +622,8 @@ static void hmp_info_vnc_authcrypt(Monitor *mon, cons=
t char *indent,
                                    VncVencryptSubAuth *vencrypt)
 {
     monitor_printf(mon, "%sAuth: %s (Sub: %s)\n", indent,
-                   VncPrimaryAuth_lookup[auth],
-                   vencrypt ? VncVencryptSubAuth_lookup[*vencrypt] : "no=
ne");
+                   VncPrimaryAuth_str(auth),
+                   vencrypt ? VncVencryptSubAuth_str(*vencrypt) : "none"=
);
 }
=20
 static void hmp_info_vnc_clients(Monitor *mon, VncClientInfoList *client=
)
@@ -738,7 +738,7 @@ void hmp_info_spice(Monitor *mon, const QDict *qdict)
     monitor_printf(mon, "        auth: %s\n", info->auth);
     monitor_printf(mon, "    compiled: %s\n", info->compiled_version);
     monitor_printf(mon, "  mouse-mode: %s\n",
-                   SpiceQueryMouseMode_lookup[info->mouse_mode]);
+                   SpiceQueryMouseMode_str(info->mouse_mode));
=20
     if (!info->has_channels || info->channels =3D=3D NULL) {
         monitor_printf(mon, "Channels: none\n");
@@ -1009,10 +1009,10 @@ void hmp_info_tpm(Monitor *mon, const QDict *qdic=
t)
     for (info =3D info_list; info; info =3D info->next) {
         TPMInfo *ti =3D info->value;
         monitor_printf(mon, " tpm%d: model=3D%s\n",
-                       c, TpmModel_lookup[ti->model]);
+                       c, TpmModel_str(ti->model));
=20
         monitor_printf(mon, "  \\ %s: type=3D%s",
-                       ti->id, TpmTypeOptionsKind_lookup[ti->options->ty=
pe]);
+                       ti->id, TpmTypeOptionsKind_str(ti->options->type)=
);
=20
         switch (ti->options->type) {
         case TPM_TYPE_OPTIONS_KIND_PASSTHROUGH:
@@ -2368,7 +2368,7 @@ void hmp_info_memdev(Monitor *mon, const QDict *qdi=
ct)
         monitor_printf(mon, "  prealloc: %s\n",
                        m->value->prealloc ? "true" : "false");
         monitor_printf(mon, "  policy: %s\n",
-                       HostMemPolicy_lookup[m->value->policy]);
+                       HostMemPolicy_str(m->value->policy));
         visit_complete(v, &str);
         monitor_printf(mon, "  host nodes: %s\n", str);
=20
@@ -2399,7 +2399,7 @@ void hmp_info_memory_devices(Monitor *mon, const QD=
ict *qdict)
                 di =3D value->u.dimm.data;
=20
                 monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
-                               MemoryDeviceInfoKind_lookup[value->type],
+                               MemoryDeviceInfoKind_str(value->type),
                                di->id ? di->id : "");
                 monitor_printf(mon, "  addr: 0x%" PRIx64 "\n", di->addr)=
;
                 monitor_printf(mon, "  slot: %" PRId64 "\n", di->slot);
@@ -2793,7 +2793,7 @@ void hmp_info_dump(Monitor *mon, const QDict *qdict=
)
     DumpQueryResult *result =3D qmp_query_dump(NULL);
=20
     assert(result && result->status < DUMP_STATUS__MAX);
-    monitor_printf(mon, "Status: %s\n", DumpStatus_lookup[result->status=
]);
+    monitor_printf(mon, "Status: %s\n", DumpStatus_str(result->status));
=20
     if (result->status =3D=3D DUMP_STATUS_ACTIVE) {
         float percent =3D 0;
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 401129073b..db40e174c9 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -392,9 +392,9 @@ static int pick_geometry(FDrive *drv)
             FLOPPY_DPRINTF("User requested floppy drive type '%s', "
                            "but inserted medium appears to be a "
                            "%"PRId64" sector '%s' type\n",
-                           FloppyDriveType_lookup[drv->drive],
+                           FloppyDriveType_str(drv->drive),
                            nb_sectors,
-                           FloppyDriveType_lookup[parse->drive]);
+                           FloppyDriveType_str(parse->drive));
         }
         match =3D type_match;
     }
@@ -403,7 +403,7 @@ static int pick_geometry(FDrive *drv)
     if (match =3D=3D -1) {
         error_setg(&error_abort, "No candidate geometries present in tab=
le "
                    " for floppy drive type '%s'",
-                   FloppyDriveType_lookup[drv->drive]);
+                   FloppyDriveType_str(drv->drive));
     }
=20
     parse =3D &(fd_formats[match]);
diff --git a/hw/char/escc.c b/hw/char/escc.c
index 1aca564e33..3ab831a6a7 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -848,7 +848,7 @@ static void sunkbd_handle_event(DeviceState *dev, Qem=
uConsole *src,
     assert(evt->type =3D=3D INPUT_EVENT_KIND_KEY);
     key =3D evt->u.key.data;
     qcode =3D qemu_input_key_value_to_qcode(key->key);
-    trace_escc_sunkbd_event_in(qcode, QKeyCode_lookup[qcode],
+    trace_escc_sunkbd_event_in(qcode, QKeyCode_str(qcode),
                                key->down);
=20
     if (qcode =3D=3D Q_KEY_CODE_CAPS_LOCK) {
diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index 46c038110c..4d3afc1b14 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -209,7 +209,7 @@ static void virtio_input_handle_event(DeviceState *de=
v, QemuConsole *src,
         } else {
             if (key->down) {
                 fprintf(stderr, "%s: unmapped key: %d [%s]\n", __func__,
-                        qcode, QKeyCode_lookup[qcode]);
+                        qcode, QKeyCode_str(qcode));
             }
         }
         break;
@@ -224,7 +224,7 @@ static void virtio_input_handle_event(DeviceState *de=
v, QemuConsole *src,
             if (btn->down) {
                 fprintf(stderr, "%s: unmapped button: %d [%s]\n", __func=
__,
                         btn->button,
-                        InputButton_lookup[btn->button]);
+                        InputButton_str(btn->button));
             }
         }
         break;
diff --git a/migration/colo-failover.c b/migration/colo-failover.c
index f9914869c5..6563862b36 100644
--- a/migration/colo-failover.c
+++ b/migration/colo-failover.c
@@ -34,7 +34,7 @@ static void colo_failover_bh(void *opaque)
                                    FAILOVER_STATUS_ACTIVE);
     if (old_state !=3D FAILOVER_STATUS_REQUIRE) {
         error_report("Unknown error for failover, old_state =3D %s",
-                    FailoverStatus_lookup[old_state]);
+                    FailoverStatus_str(old_state));
         return;
     }
=20
@@ -64,7 +64,7 @@ FailoverStatus failover_set_state(FailoverStatus old_st=
ate,
=20
     old =3D atomic_cmpxchg(&failover_state, old_state, new_state);
     if (old =3D=3D old_state) {
-        trace_colo_failover_set_state(FailoverStatus_lookup[new_state]);
+        trace_colo_failover_set_state(FailoverStatus_str(new_state));
     }
     return old;
 }
diff --git a/migration/colo.c b/migration/colo.c
index a4255432ac..dee3aa8bf7 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -61,7 +61,7 @@ static void secondary_vm_do_failover(void)
                         FAILOVER_STATUS_RELAUNCH);
         if (old_state !=3D FAILOVER_STATUS_ACTIVE) {
             error_report("Unknown error while do failover for secondary =
VM,"
-                         "old_state: %s", FailoverStatus_lookup[old_stat=
e]);
+                         "old_state: %s", FailoverStatus_str(old_state))=
;
         }
         return;
     }
@@ -91,7 +91,7 @@ static void secondary_vm_do_failover(void)
                                    FAILOVER_STATUS_COMPLETED);
     if (old_state !=3D FAILOVER_STATUS_ACTIVE) {
         error_report("Incorrect state (%s) while doing failover for "
-                     "secondary VM", FailoverStatus_lookup[old_state]);
+                     "secondary VM", FailoverStatus_str(old_state));
         return;
     }
     /* Notify COLO incoming thread that failover work is finished */
@@ -126,7 +126,7 @@ static void primary_vm_do_failover(void)
                                    FAILOVER_STATUS_COMPLETED);
     if (old_state !=3D FAILOVER_STATUS_ACTIVE) {
         error_report("Incorrect state (%s) while doing failover for Prim=
ary VM",
-                     FailoverStatus_lookup[old_state]);
+                     FailoverStatus_str(old_state));
         return;
     }
     /* Notify COLO thread that failover work is finished */
@@ -222,7 +222,7 @@ static void colo_send_message(QEMUFile *f, COLOMessag=
e msg,
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Can't send COLO message");
     }
-    trace_colo_send_message(COLOMessage_lookup[msg]);
+    trace_colo_send_message(COLOMessage_str(msg));
 }
=20
 static void colo_send_message_value(QEMUFile *f, COLOMessage msg,
@@ -242,7 +242,7 @@ static void colo_send_message_value(QEMUFile *f, COLO=
Message msg,
     ret =3D qemu_file_get_error(f);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Failed to send value for message:%=
s",
-                         COLOMessage_lookup[msg]);
+                         COLOMessage_str(msg));
     }
 }
=20
@@ -261,7 +261,7 @@ static COLOMessage colo_receive_message(QEMUFile *f, =
Error **errp)
         error_setg(errp, "%s: Invalid message", __func__);
         return msg;
     }
-    trace_colo_receive_message(COLOMessage_lookup[msg]);
+    trace_colo_receive_message(COLOMessage_str(msg));
     return msg;
 }
=20
@@ -299,7 +299,7 @@ static uint64_t colo_receive_message_value(QEMUFile *=
f, uint32_t expect_msg,
     ret =3D qemu_file_get_error(f);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Failed to get value for COLO messa=
ge: %s",
-                         COLOMessage_lookup[expect_msg]);
+                         COLOMessage_str(expect_msg));
     }
     return value;
 }
diff --git a/migration/global_state.c b/migration/global_state.c
index 76cd3a13d4..8db2f19459 100644
--- a/migration/global_state.c
+++ b/migration/global_state.c
@@ -41,7 +41,7 @@ int global_state_store(void)
=20
 void global_state_store_running(void)
 {
-    const char *state =3D RunState_lookup[RUN_STATE_RUNNING];
+    const char *state =3D RunState_str(RUN_STATE_RUNNING);
     strncpy((char *)global_state.runstate,
            state, sizeof(global_state.runstate));
 }
diff --git a/monitor.c b/monitor.c
index 86438f4b75..9239f7adde 100644
--- a/monitor.c
+++ b/monitor.c
@@ -928,7 +928,7 @@ EventInfoList *qmp_query_events(Error **errp)
     QAPIEvent e;
=20
     for (e =3D 0 ; e < QAPI_EVENT__MAX ; e++) {
-        const char *event_name =3D QAPIEvent_lookup[e];
+        const char *event_name =3D QAPIEvent_str(e);
         assert(event_name !=3D NULL);
         info =3D g_malloc0(sizeof(*info));
         info->value =3D g_malloc0(sizeof(*info->value));
@@ -3250,7 +3250,7 @@ void netdev_add_completion(ReadLineState *rs, int n=
b_args, const char *str)
     len =3D strlen(str);
     readline_set_completion_index(rs, len);
     for (i =3D 0; i < NET_CLIENT_DRIVER__MAX; i++) {
-        add_completion_option(rs, str, NetClientDriver_lookup[i]);
+        add_completion_option(rs, str, NetClientDriver_str(i));
     }
 }
=20
@@ -3434,8 +3434,8 @@ void sendkey_completion(ReadLineState *rs, int nb_a=
rgs, const char *str)
     len =3D strlen(str);
     readline_set_completion_index(rs, len);
     for (i =3D 0; i < Q_KEY_CODE__MAX; i++) {
-        if (!strncmp(str, QKeyCode_lookup[i], len)) {
-            readline_add_completion(rs, QKeyCode_lookup[i]);
+        if (!strncmp(str, QKeyCode_str(i), len)) {
+            readline_add_completion(rs, QKeyCode_str(i));
         }
     }
 }
@@ -3538,7 +3538,7 @@ void watchdog_action_completion(ReadLineState *rs, =
int nb_args, const char *str)
     }
     readline_set_completion_index(rs, strlen(str));
     for (i =3D 0; i < WATCHDOG_EXPIRATION_ACTION__MAX; i++) {
-        add_completion_option(rs, str, WatchdogExpirationAction_lookup[i=
]);
+        add_completion_option(rs, str, WatchdogExpirationAction_str(i));
     }
 }
=20
@@ -3552,7 +3552,7 @@ void migrate_set_capability_completion(ReadLineStat=
e *rs, int nb_args,
     if (nb_args =3D=3D 2) {
         int i;
         for (i =3D 0; i < MIGRATION_CAPABILITY__MAX; i++) {
-            const char *name =3D MigrationCapability_lookup[i];
+            const char *name =3D MigrationCapability_str(i);
             if (!strncmp(str, name, len)) {
                 readline_add_completion(rs, name);
             }
@@ -3573,7 +3573,7 @@ void migrate_set_parameter_completion(ReadLineState=
 *rs, int nb_args,
     if (nb_args =3D=3D 2) {
         int i;
         for (i =3D 0; i < MIGRATION_PARAMETER__MAX; i++) {
-            const char *name =3D MigrationParameter_lookup[i];
+            const char *name =3D MigrationParameter_str(i);
             if (!strncmp(str, name, len)) {
                 readline_add_completion(rs, name);
             }
@@ -3852,7 +3852,7 @@ static void handle_qmp_command(JSONMessageParser *p=
arser, GQueue *tokens)
         qdict =3D qdict_get_qdict(qobject_to_qdict(rsp), "error");
         if (qdict
             && !g_strcmp0(qdict_get_try_str(qdict, "class"),
-                    QapiErrorClass_lookup[ERROR_CLASS_COMMAND_NOT_FOUND]=
)) {
+                    QapiErrorClass_str(ERROR_CLASS_COMMAND_NOT_FOUND))) =
{
             /* Provide a more useful error message */
             qdict_del(qdict, "desc");
             qdict_put_str(qdict, "desc", "Expecting capabilities negotia=
tion"
diff --git a/net/net.c b/net/net.c
index 0e28099554..2fa99c0497 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1064,7 +1064,7 @@ static int net_client_init1(const void *object, boo=
l is_netdev, Error **errp)
         /* FIXME drop when all init functions store an Error */
         if (errp && !*errp) {
             error_setg(errp, QERR_DEVICE_INIT_FAILED,
-                       NetClientDriver_lookup[netdev->type]);
+                       NetClientDriver_str(netdev->type));
         }
         return -1;
     }
@@ -1288,7 +1288,7 @@ void print_net_client(Monitor *mon, NetClientState =
*nc)
=20
     monitor_printf(mon, "%s: index=3D%d,type=3D%s,%s\n", nc->name,
                    nc->queue_index,
-                   NetClientDriver_lookup[nc->info->type],
+                   NetClientDriver_str(nc->info->type),
                    nc->info_str);
     if (!QTAILQ_EMPTY(&nc->filters)) {
         monitor_printf(mon, "filters:\n");
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 5ad36f8a09..b41fa174fe 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -118,7 +118,7 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds,=
 QObject *request,
 QObject *qmp_build_error_object(Error *err)
 {
     return qobject_from_jsonf("{ 'class': %s, 'desc': %s }",
-                              QapiErrorClass_lookup[error_get_class(err)=
],
+                              QapiErrorClass_str(error_get_class(err)),
                               error_get_pretty(err));
 }
=20
diff --git a/tests/test-qapi-util.c b/tests/test-qapi-util.c
index 7e1be1d851..0992bdb218 100644
--- a/tests/test-qapi-util.c
+++ b/tests/test-qapi-util.c
@@ -31,7 +31,7 @@ static void test_qapi_enum_parse(void)
     ret =3D qapi_enum_parse(QType_lookup, "none", -1, &error_abort);
     g_assert_cmpint(ret, =3D=3D, QTYPE_NONE);
=20
-    ret =3D qapi_enum_parse(QType_lookup, QType_lookup[QTYPE__MAX - 1],
+    ret =3D qapi_enum_parse(QType_lookup, QType_str(QTYPE__MAX - 1),
                           QTYPE__MAX - 1, &error_abort);
     g_assert_cmpint(ret, =3D=3D, QTYPE__MAX - 1);
 }
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-inpu=
t-visitor.c
index 5bbfb65a02..f8720aa5eb 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -385,7 +385,7 @@ static void test_visitor_in_enum(TestInputVisitorData=
 *data,
     for (i =3D 0; i < ENUM_ONE__MAX; i++) {
         EnumOne res =3D -1;
=20
-        v =3D visitor_input_test_init(data, "%s", EnumOne_lookup[i]);
+        v =3D visitor_input_test_init(data, "%s", EnumOne_str(i));
=20
         visit_type_EnumOne(v, NULL, &res, &error_abort);
         g_assert_cmpint(i, =3D=3D, res);
@@ -699,7 +699,7 @@ static void test_native_list_integer_helper(TestInput=
VisitorData *data,
         }
     }
     g_string_append_printf(gstr_union,  "{ 'type': '%s', 'data': [ %s ] =
}",
-                           UserDefNativeListUnionKind_lookup[kind],
+                           UserDefNativeListUnionKind_str(kind),
                            gstr_list->str);
     v =3D visitor_input_test_init_raw(data,  gstr_union->str);
=20
diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-out=
put-visitor.c
index 7eb162059c..d375100a52 100644
--- a/tests/test-qobject-output-visitor.c
+++ b/tests/test-qobject-output-visitor.c
@@ -133,7 +133,7 @@ static void test_visitor_out_enum(TestOutputVisitorDa=
ta *data,
=20
         qstr =3D qobject_to_qstring(visitor_get(data));
         g_assert(qstr);
-        g_assert_cmpstr(qstring_get_str(qstr), =3D=3D, EnumOne_lookup[i]=
);
+        g_assert_cmpstr(qstring_get_str(qstr), =3D=3D, EnumOne_str(i));
         visitor_reset(data);
     }
 }
diff --git a/tests/test-string-input-visitor.c b/tests/test-string-input-=
visitor.c
index e7a7b80c92..4f9c36bef1 100644
--- a/tests/test-string-input-visitor.c
+++ b/tests/test-string-input-visitor.c
@@ -282,7 +282,7 @@ static void test_visitor_in_enum(TestInputVisitorData=
 *data,
     for (i =3D 0; i < ENUM_ONE__MAX; i++) {
         EnumOne res =3D -1;
=20
-        v =3D visitor_input_test_init(data, EnumOne_lookup[i]);
+        v =3D visitor_input_test_init(data, EnumOne_str(i));
=20
         visit_type_EnumOne(v, NULL, &res, &err);
         g_assert(!err);
diff --git a/tests/test-string-output-visitor.c b/tests/test-string-outpu=
t-visitor.c
index e736db3af8..385cddb5d9 100644
--- a/tests/test-string-output-visitor.c
+++ b/tests/test-string-output-visitor.c
@@ -194,12 +194,12 @@ static void test_visitor_out_enum(TestOutputVisitor=
Data *data,
=20
         str =3D visitor_get(data);
         if (data->human) {
-            char *str_human =3D g_strdup_printf("\"%s\"", EnumOne_lookup=
[i]);
+            char *str_human =3D g_strdup_printf("\"%s\"", EnumOne_str(i)=
);
=20
             g_assert_cmpstr(str, =3D=3D, str_human);
             g_free(str_human);
         } else {
-            g_assert_cmpstr(str, =3D=3D, EnumOne_lookup[i]);
+            g_assert_cmpstr(str, =3D=3D, EnumOne_str(i));
         }
         visitor_reset(data);
     }
diff --git a/tpm.c b/tpm.c
index 38f3eb827f..111f1ca63f 100644
--- a/tpm.c
+++ b/tpm.c
@@ -62,7 +62,7 @@ static void tpm_display_backend_drivers(void)
             continue;
         }
         fprintf(stderr, "%12s   %s\n",
-                TpmType_lookup[i], be_drivers[i]->desc());
+                TpmType_str(i), be_drivers[i]->desc());
     }
     fprintf(stderr, "\n");
 }
diff --git a/ui/input-legacy.c b/ui/input-legacy.c
index a5f1e829c3..6bc3525499 100644
--- a/ui/input-legacy.c
+++ b/ui/input-legacy.c
@@ -62,8 +62,8 @@ int index_from_key(const char *key, size_t key_length)
     int i;
=20
     for (i =3D 0; i < Q_KEY_CODE__MAX; i++) {
-        if (!strncmp(key, QKeyCode_lookup[i], key_length) &&
-            !QKeyCode_lookup[i][key_length]) {
+        if (!strncmp(key, QKeyCode_str(i), key_length) &&
+            !QKeyCode_str(i)[key_length]) {
             break;
         }
     }
diff --git a/ui/input.c b/ui/input.c
index af05f06368..3422d4a8ef 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -151,7 +151,7 @@ void qmp_input_send_event(bool has_device, const char=
 *device,
         if (!qemu_input_find_handler(1 << event->type, con)) {
             error_setg(errp, "Input handler not found for "
                              "event type %s",
-                            InputEventKind_lookup[event->type]);
+                            InputEventKind_str(event->type));
             return;
         }
     }
@@ -213,12 +213,12 @@ static void qemu_input_event_trace(QemuConsole *src=
, InputEvent *evt)
         switch (key->key->type) {
         case KEY_VALUE_KIND_NUMBER:
             qcode =3D qemu_input_key_number_to_qcode(key->key->u.number.=
data);
-            name =3D QKeyCode_lookup[qcode];
+            name =3D QKeyCode_str(qcode);
             trace_input_event_key_number(idx, key->key->u.number.data,
                                          name, key->down);
             break;
         case KEY_VALUE_KIND_QCODE:
-            name =3D QKeyCode_lookup[key->key->u.qcode.data];
+            name =3D QKeyCode_str(key->key->u.qcode.data);
             trace_input_event_key_qcode(idx, name, key->down);
             break;
         case KEY_VALUE_KIND__MAX:
@@ -228,17 +228,17 @@ static void qemu_input_event_trace(QemuConsole *src=
, InputEvent *evt)
         break;
     case INPUT_EVENT_KIND_BTN:
         btn =3D evt->u.btn.data;
-        name =3D InputButton_lookup[btn->button];
+        name =3D InputButton_str(btn->button);
         trace_input_event_btn(idx, name, btn->down);
         break;
     case INPUT_EVENT_KIND_REL:
         move =3D evt->u.rel.data;
-        name =3D InputAxis_lookup[move->axis];
+        name =3D InputAxis_str(move->axis);
         trace_input_event_rel(idx, name, move->value);
         break;
     case INPUT_EVENT_KIND_ABS:
         move =3D evt->u.abs.data;
-        name =3D InputAxis_lookup[move->axis];
+        name =3D InputAxis_str(move->axis);
         trace_input_event_abs(idx, name, move->value);
         break;
     case INPUT_EVENT_KIND__MAX:
diff --git a/ui/vnc.c b/ui/vnc.c
index fd43f9b983..0b5dbc62e4 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -131,7 +131,7 @@ static void vnc_init_basic_info(SocketAddress *addr,
     case SOCKET_ADDRESS_TYPE_VSOCK:
     case SOCKET_ADDRESS_TYPE_FD:
         error_setg(errp, "Unsupported socket address type %s",
-                   SocketAddressType_lookup[addr->type]);
+                   SocketAddressType_str(addr->type));
         break;
     default:
         abort();
@@ -416,7 +416,7 @@ VncInfo *qmp_query_vnc(Error **errp)
         case SOCKET_ADDRESS_TYPE_VSOCK:
         case SOCKET_ADDRESS_TYPE_FD:
             error_setg(errp, "Unsupported socket address type %s",
-                       SocketAddressType_lookup[addr->type]);
+                       SocketAddressType_str(addr->type));
             goto out_error;
         default:
             abort();
@@ -1839,7 +1839,7 @@ static void vnc_release_modifiers(VncState *vs)
=20
 static const char *code2name(int keycode)
 {
-    return QKeyCode_lookup[qemu_input_key_number_to_qcode(keycode)];
+    return QKeyCode_str(qemu_input_key_number_to_qcode(keycode));
 }
=20
 static void key_event(VncState *vs, int down, uint32_t sym)
diff --git a/vl.c b/vl.c
index 8e247cc2a2..0b45e1b6fa 100644
--- a/vl.c
+++ b/vl.c
@@ -688,7 +688,7 @@ bool runstate_check(RunState state)
=20
 bool runstate_store(char *str, size_t size)
 {
-    const char *state =3D RunState_lookup[current_run_state];
+    const char *state =3D RunState_str(current_run_state);
     size_t len =3D strlen(state) + 1;
=20
     if (len > size) {
@@ -721,8 +721,8 @@ void runstate_set(RunState new_state)
=20
     if (!runstate_valid_transitions[current_run_state][new_state]) {
         error_report("invalid runstate transition: '%s' -> '%s'",
-                     RunState_lookup[current_run_state],
-                     RunState_lookup[new_state]);
+                     RunState_str(current_run_state),
+                     RunState_str(new_state));
         abort();
     }
     trace_runstate_set(new_state);
--=20
2.13.5
