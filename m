Received: from eggs.gnu.org ([2001:4830:134:3::10]:59108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gHlUe-0007ZQ-Vc
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 04:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gHlUX-0000lW-Dt
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 04:04:47 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 31 Oct 2018 16:04:15 +0800
Message-Id: <20181031080415.23637-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] iotests: 082: Update output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Commit 9cbef9d68e (qemu-option: improve qemu_opts_print_help() output)
affected qemu-img help output, and broke this test case.

Update the output reference to fix it.

Signed-off-by: Fam Zheng <famz@redhat.com>

---

I'm once again looking at enabling iotests on patchew (via vm based
tests), but immediately got blocked by this. :(
---
 tests/qemu-iotests/082.out | 956 ++++++++++++++++++-------------------
 1 file changed, 478 insertions(+), 478 deletions(-)

diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index 19e9fb13ff..2672349e1d 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -44,171 +44,171 @@ cluster_size: 8192
 
 Testing: create -f qcow2 -o help TEST_DIR/t.qcow2 128M
 Supported options:
-size             Virtual disk size
-compat           Compatibility level (0.10 or 1.1)
-backing_file     File name of a base image
-backing_fmt      Image format of the base image
-encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
-encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
-encrypt.cipher-alg Name of encryption cipher algorithm
-encrypt.cipher-mode Name of encryption cipher mode
-encrypt.ivgen-alg Name of IV generator algorithm
-encrypt.ivgen-hash-alg Name of IV generator hash algorithm
-encrypt.hash-alg Name of encryption hash algorithm
-encrypt.iter-time Time to spend in PBKDF in milliseconds
-cluster_size     qcow2 cluster size
-preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
-lazy_refcounts   Postpone refcount updates
-refcount_bits    Width of a reference count entry in bits
-nocow            Turn off copy-on-write (valid only on btrfs)
+backing_file=str - File name of a base image
+backing_fmt=str - Image format of the base image
+cluster_size=size - qcow2 cluster size
+compat=str - Compatibility level (0.10 or 1.1)
+encrypt.cipher-alg=str - Name of encryption cipher algorithm
+encrypt.cipher-mode=str - Name of encryption cipher mode
+encrypt.format=str - Encrypt the image, format choices: 'aes', 'luks'
+encrypt.hash-alg=str - Name of encryption hash algorithm
+encrypt.iter-time=num - Time to spend in PBKDF in milliseconds
+encrypt.ivgen-alg=str - Name of IV generator algorithm
+encrypt.ivgen-hash-alg=str - Name of IV generator hash algorithm
+encrypt.key-secret=str - ID of secret providing qcow AES key or LUKS passphrase
+encryption=bool (on/off) - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+lazy_refcounts=bool (on/off) - Postpone refcount updates
+nocow=bool (on/off) - Turn off copy-on-write (valid only on btrfs)
+preallocation=str - Preallocation mode (allowed values: off, metadata, falloc, full)
+refcount_bits=num - Width of a reference count entry in bits
+size=size - Virtual disk size
 
 Testing: create -f qcow2 -o ? TEST_DIR/t.qcow2 128M
 Supported options:
-size             Virtual disk size
-compat           Compatibility level (0.10 or 1.1)
-backing_file     File name of a base image
-backing_fmt      Image format of the base image
-encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
-encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
-encrypt.cipher-alg Name of encryption cipher algorithm
-encrypt.cipher-mode Name of encryption cipher mode
-encrypt.ivgen-alg Name of IV generator algorithm
-encrypt.ivgen-hash-alg Name of IV generator hash algorithm
-encrypt.hash-alg Name of encryption hash algorithm
-encrypt.iter-time Time to spend in PBKDF in milliseconds
-cluster_size     qcow2 cluster size
-preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
-lazy_refcounts   Postpone refcount updates
-refcount_bits    Width of a reference count entry in bits
-nocow            Turn off copy-on-write (valid only on btrfs)
+backing_file=str - File name of a base image
+backing_fmt=str - Image format of the base image
+cluster_size=size - qcow2 cluster size
+compat=str - Compatibility level (0.10 or 1.1)
+encrypt.cipher-alg=str - Name of encryption cipher algorithm
+encrypt.cipher-mode=str - Name of encryption cipher mode
+encrypt.format=str - Encrypt the image, format choices: 'aes', 'luks'
+encrypt.hash-alg=str - Name of encryption hash algorithm
+encrypt.iter-time=num - Time to spend in PBKDF in milliseconds
+encrypt.ivgen-alg=str - Name of IV generator algorithm
+encrypt.ivgen-hash-alg=str - Name of IV generator hash algorithm
+encrypt.key-secret=str - ID of secret providing qcow AES key or LUKS passphrase
+encryption=bool (on/off) - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+lazy_refcounts=bool (on/off) - Postpone refcount updates
+nocow=bool (on/off) - Turn off copy-on-write (valid only on btrfs)
+preallocation=str - Preallocation mode (allowed values: off, metadata, falloc, full)
+refcount_bits=num - Width of a reference count entry in bits
+size=size - Virtual disk size
 
 Testing: create -f qcow2 -o cluster_size=4k,help TEST_DIR/t.qcow2 128M
 Supported options:
-size             Virtual disk size
-compat           Compatibility level (0.10 or 1.1)
-backing_file     File name of a base image
-backing_fmt      Image format of the base image
-encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
-encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
-encrypt.cipher-alg Name of encryption cipher algorithm
-encrypt.cipher-mode Name of encryption cipher mode
-encrypt.ivgen-alg Name of IV generator algorithm
-encrypt.ivgen-hash-alg Name of IV generator hash algorithm
-encrypt.hash-alg Name of encryption hash algorithm
-encrypt.iter-time Time to spend in PBKDF in milliseconds
-cluster_size     qcow2 cluster size
-preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
-lazy_refcounts   Postpone refcount updates
-refcount_bits    Width of a reference count entry in bits
-nocow            Turn off copy-on-write (valid only on btrfs)
+backing_file=str - File name of a base image
+backing_fmt=str - Image format of the base image
+cluster_size=size - qcow2 cluster size
+compat=str - Compatibility level (0.10 or 1.1)
+encrypt.cipher-alg=str - Name of encryption cipher algorithm
+encrypt.cipher-mode=str - Name of encryption cipher mode
+encrypt.format=str - Encrypt the image, format choices: 'aes', 'luks'
+encrypt.hash-alg=str - Name of encryption hash algorithm
+encrypt.iter-time=num - Time to spend in PBKDF in milliseconds
+encrypt.ivgen-alg=str - Name of IV generator algorithm
+encrypt.ivgen-hash-alg=str - Name of IV generator hash algorithm
+encrypt.key-secret=str - ID of secret providing qcow AES key or LUKS passphrase
+encryption=bool (on/off) - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+lazy_refcounts=bool (on/off) - Postpone refcount updates
+nocow=bool (on/off) - Turn off copy-on-write (valid only on btrfs)
+preallocation=str - Preallocation mode (allowed values: off, metadata, falloc, full)
+refcount_bits=num - Width of a reference count entry in bits
+size=size - Virtual disk size
 
 Testing: create -f qcow2 -o cluster_size=4k,? TEST_DIR/t.qcow2 128M
 Supported options:
-size             Virtual disk size
-compat           Compatibility level (0.10 or 1.1)
-backing_file     File name of a base image
-backing_fmt      Image format of the base image
-encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
-encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
-encrypt.cipher-alg Name of encryption cipher algorithm
-encrypt.cipher-mode Name of encryption cipher mode
-encrypt.ivgen-alg Name of IV generator algorithm
-encrypt.ivgen-hash-alg Name of IV generator hash algorithm
-encrypt.hash-alg Name of encryption hash algorithm
-encrypt.iter-time Time to spend in PBKDF in milliseconds
-cluster_size     qcow2 cluster size
-preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
-lazy_refcounts   Postpone refcount updates
-refcount_bits    Width of a reference count entry in bits
-nocow            Turn off copy-on-write (valid only on btrfs)
+backing_file=str - File name of a base image
+backing_fmt=str - Image format of the base image
+cluster_size=size - qcow2 cluster size
+compat=str - Compatibility level (0.10 or 1.1)
+encrypt.cipher-alg=str - Name of encryption cipher algorithm
+encrypt.cipher-mode=str - Name of encryption cipher mode
+encrypt.format=str - Encrypt the image, format choices: 'aes', 'luks'
+encrypt.hash-alg=str - Name of encryption hash algorithm
+encrypt.iter-time=num - Time to spend in PBKDF in milliseconds
+encrypt.ivgen-alg=str - Name of IV generator algorithm
+encrypt.ivgen-hash-alg=str - Name of IV generator hash algorithm
+encrypt.key-secret=str - ID of secret providing qcow AES key or LUKS passphrase
+encryption=bool (on/off) - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+lazy_refcounts=bool (on/off) - Postpone refcount updates
+nocow=bool (on/off) - Turn off copy-on-write (valid only on btrfs)
+preallocation=str - Preallocation mode (allowed values: off, metadata, falloc, full)
+refcount_bits=num - Width of a reference count entry in bits
+size=size - Virtual disk size
 
 Testing: create -f qcow2 -o help,cluster_size=4k TEST_DIR/t.qcow2 128M
 Supported options:
-size             Virtual disk size
-compat           Compatibility level (0.10 or 1.1)
-backing_file     File name of a base image
-backing_fmt      Image format of the base image
-encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
-encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
-encrypt.cipher-alg Name of encryption cipher algorithm
-encrypt.cipher-mode Name of encryption cipher mode
-encrypt.ivgen-alg Name of IV generator algorithm
-encrypt.ivgen-hash-alg Name of IV generator hash algorithm
-encrypt.hash-alg Name of encryption hash algorithm
-encrypt.iter-time Time to spend in PBKDF in milliseconds
-cluster_size     qcow2 cluster size
-preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
-lazy_refcounts   Postpone refcount updates
-refcount_bits    Width of a reference count entry in bits
-nocow            Turn off copy-on-write (valid only on btrfs)
+backing_file=str - File name of a base image
+backing_fmt=str - Image format of the base image
+cluster_size=size - qcow2 cluster size
+compat=str - Compatibility level (0.10 or 1.1)
+encrypt.cipher-alg=str - Name of encryption cipher algorithm
+encrypt.cipher-mode=str - Name of encryption cipher mode
+encrypt.format=str - Encrypt the image, format choices: 'aes', 'luks'
+encrypt.hash-alg=str - Name of encryption hash algorithm
+encrypt.iter-time=num - Time to spend in PBKDF in milliseconds
+encrypt.ivgen-alg=str - Name of IV generator algorithm
+encrypt.ivgen-hash-alg=str - Name of IV generator hash algorithm
+encrypt.key-secret=str - ID of secret providing qcow AES key or LUKS passphrase
+encryption=bool (on/off) - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+lazy_refcounts=bool (on/off) - Postpone refcount updates
+nocow=bool (on/off) - Turn off copy-on-write (valid only on btrfs)
+preallocation=str - Preallocation mode (allowed values: off, metadata, falloc, full)
+refcount_bits=num - Width of a reference count entry in bits
+size=size - Virtual disk size
 
 Testing: create -f qcow2 -o ?,cluster_size=4k TEST_DIR/t.qcow2 128M
 Supported options:
-size             Virtual disk size
-compat           Compatibility level (0.10 or 1.1)
-backing_file     File name of a base image
-backing_fmt      Image format of the base image
-encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
-encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
-encrypt.cipher-alg Name of encryption cipher algorithm
-encrypt.cipher-mode Name of encryption cipher mode
-encrypt.ivgen-alg Name of IV generator algorithm
-encrypt.ivgen-hash-alg Name of IV generator hash algorithm
-encrypt.hash-alg Name of encryption hash algorithm
-encrypt.iter-time Time to spend in PBKDF in milliseconds
-cluster_size     qcow2 cluster size
-preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
-lazy_refcounts   Postpone refcount updates
-refcount_bits    Width of a reference count entry in bits
-nocow            Turn off copy-on-write (valid only on btrfs)
+backing_file=str - File name of a base image
+backing_fmt=str - Image format of the base image
+cluster_size=size - qcow2 cluster size
+compat=str - Compatibility level (0.10 or 1.1)
+encrypt.cipher-alg=str - Name of encryption cipher algorithm
+encrypt.cipher-mode=str - Name of encryption cipher mode
+encrypt.format=str - Encrypt the image, format choices: 'aes', 'luks'
+encrypt.hash-alg=str - Name of encryption hash algorithm
+encrypt.iter-time=num - Time to spend in PBKDF in milliseconds
+encrypt.ivgen-alg=str - Name of IV generator algorithm
+encrypt.ivgen-hash-alg=str - Name of IV generator hash algorithm
+encrypt.key-secret=str - ID of secret providing qcow AES key or LUKS passphrase
+encryption=bool (on/off) - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+lazy_refcounts=bool (on/off) - Postpone refcount updates
+nocow=bool (on/off) - Turn off copy-on-write (valid only on btrfs)
+preallocation=str - Preallocation mode (allowed values: off, metadata, falloc, full)
+refcount_bits=num - Width of a reference count entry in bits
+size=size - Virtual disk size
 
 Testing: create -f qcow2 -o cluster_size=4k -o help TEST_DIR/t.qcow2 128M
 Supported options:
-size             Virtual disk size
-compat           Compatibility level (0.10 or 1.1)
-backing_file     File name of a base image
-backing_fmt      Image format of the base image
-encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
-encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
-encrypt.cipher-alg Name of encryption cipher algorithm
-encrypt.cipher-mode Name of encryption cipher mode
-encrypt.ivgen-alg Name of IV generator algorithm
-encrypt.ivgen-hash-alg Name of IV generator hash algorithm
-encrypt.hash-alg Name of encryption hash algorithm
-encrypt.iter-time Time to spend in PBKDF in milliseconds
-cluster_size     qcow2 cluster size
-preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
-lazy_refcounts   Postpone refcount updates
-refcount_bits    Width of a reference count entry in bits
-nocow            Turn off copy-on-write (valid only on btrfs)
+backing_file=str - File name of a base image
+backing_fmt=str - Image format of the base image
+cluster_size=size - qcow2 cluster size
+compat=str - Compatibility level (0.10 or 1.1)
+encrypt.cipher-alg=str - Name of encryption cipher algorithm
+encrypt.cipher-mode=str - Name of encryption cipher mode
+encrypt.format=str - Encrypt the image, format choices: 'aes', 'luks'
+encrypt.hash-alg=str - Name of encryption hash algorithm
+encrypt.iter-time=num - Time to spend in PBKDF in milliseconds
+encrypt.ivgen-alg=str - Name of IV generator algorithm
+encrypt.ivgen-hash-alg=str - Name of IV generator hash algorithm
+encrypt.key-secret=str - ID of secret providing qcow AES key or LUKS passphrase
+encryption=bool (on/off) - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+lazy_refcounts=bool (on/off) - Postpone refcount updates
+nocow=bool (on/off) - Turn off copy-on-write (valid only on btrfs)
+preallocation=str - Preallocation mode (allowed values: off, metadata, falloc, full)
+refcount_bits=num - Width of a reference count entry in bits
+size=size - Virtual disk size
 
 Testing: create -f qcow2 -o cluster_size=4k -o ? TEST_DIR/t.qcow2 128M
 Supported options:
-size             Virtual disk size
-compat           Compatibility level (0.10 or 1.1)
-backing_file     File name of a base image
-backing_fmt      Image format of the base image
-encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
-encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
-encrypt.cipher-alg Name of encryption cipher algorithm
-encrypt.cipher-mode Name of encryption cipher mode
-encrypt.ivgen-alg Name of IV generator algorithm
-encrypt.ivgen-hash-alg Name of IV generator hash algorithm
-encrypt.hash-alg Name of encryption hash algorithm
-encrypt.iter-time Time to spend in PBKDF in milliseconds
-cluster_size     qcow2 cluster size
-preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
-lazy_refcounts   Postpone refcount updates
-refcount_bits    Width of a reference count entry in bits
-nocow            Turn off copy-on-write (valid only on btrfs)
+backing_file=str - File name of a base image
+backing_fmt=str - Image format of the base image
+cluster_size=size - qcow2 cluster size
+compat=str - Compatibility level (0.10 or 1.1)
+encrypt.cipher-alg=str - Name of encryption cipher algorithm
+encrypt.cipher-mode=str - Name of encryption cipher mode
+encrypt.format=str - Encrypt the image, format choices: 'aes', 'luks'
+encrypt.hash-alg=str - Name of encryption hash algorithm
+encrypt.iter-time=num - Time to spend in PBKDF in milliseconds
+encrypt.ivgen-alg=str - Name of IV generator algorithm
+encrypt.ivgen-hash-alg=str - Name of IV generator hash algorithm
+encrypt.key-secret=str - ID of secret providing qcow AES key or LUKS passphrase
+encryption=bool (on/off) - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+lazy_refcounts=bool (on/off) - Postpone refcount updates
+nocow=bool (on/off) - Turn off copy-on-write (valid only on btrfs)
+preallocation=str - Preallocation mode (allowed values: off, metadata, falloc, full)
+refcount_bits=num - Width of a reference count entry in bits
+size=size - Virtual disk size
 
 Testing: create -f qcow2 -u -o backing_file=TEST_DIR/t.qcow2,,help TEST_DIR/t.qcow2 128M
 Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/t.qcow2,,help cluster_size=65536 lazy_refcounts=off refcount_bits=16
@@ -227,27 +227,27 @@ qemu-img: Invalid option list: ,,
 
 Testing: create -f qcow2 -o help
 Supported options:
-size             Virtual disk size
-compat           Compatibility level (0.10 or 1.1)
-backing_file     File name of a base image
-backing_fmt      Image format of the base image
-encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
-encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
-encrypt.cipher-alg Name of encryption cipher algorithm
-encrypt.cipher-mode Name of encryption cipher mode
-encrypt.ivgen-alg Name of IV generator algorithm
-encrypt.ivgen-hash-alg Name of IV generator hash algorithm
-encrypt.hash-alg Name of encryption hash algorithm
-encrypt.iter-time Time to spend in PBKDF in milliseconds
-cluster_size     qcow2 cluster size
-preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
-lazy_refcounts   Postpone refcount updates
-refcount_bits    Width of a reference count entry in bits
+backing_file=str - File name of a base image
+backing_fmt=str - Image format of the base image
+cluster_size=size - qcow2 cluster size
+compat=str - Compatibility level (0.10 or 1.1)
+encrypt.cipher-alg=str - Name of encryption cipher algorithm
+encrypt.cipher-mode=str - Name of encryption cipher mode
+encrypt.format=str - Encrypt the image, format choices: 'aes', 'luks'
+encrypt.hash-alg=str - Name of encryption hash algorithm
+encrypt.iter-time=num - Time to spend in PBKDF in milliseconds
+encrypt.ivgen-alg=str - Name of IV generator algorithm
+encrypt.ivgen-hash-alg=str - Name of IV generator hash algorithm
+encrypt.key-secret=str - ID of secret providing qcow AES key or LUKS passphrase
+encryption=bool (on/off) - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+lazy_refcounts=bool (on/off) - Postpone refcount updates
+preallocation=str - Preallocation mode (allowed values: off, metadata, falloc, full)
+refcount_bits=num - Width of a reference count entry in bits
+size=size - Virtual disk size
 
 Testing: create -o help
 Supported options:
-size             Virtual disk size
+size=size - Virtual disk size
 
 Testing: create -f bochs -o help
 qemu-img: Format driver 'bochs' does not support image creation
@@ -300,171 +300,171 @@ cluster_size: 8192
 
 Testing: convert -O qcow2 -o help TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 Supported options:
-size             Virtual disk size
-compat           Compatibility level (0.10 or 1.1)
-backing_file     File name of a base image
-backing_fmt      Image format of the base image
-encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
-encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
-encrypt.cipher-alg Name of encryption cipher algorithm
-encrypt.cipher-mode Name of encryption cipher mode
-encrypt.ivgen-alg Name of IV generator algorithm
-encrypt.ivgen-hash-alg Name of IV generator hash algorithm
-encrypt.hash-alg Name of encryption hash algorithm
-encrypt.iter-time Time to spend in PBKDF in milliseconds
-cluster_size     qcow2 cluster size
-preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
-lazy_refcounts   Postpone refcount updates
-refcount_bits    Width of a reference count entry in bits
-nocow            Turn off copy-on-write (valid only on btrfs)
+backing_file=str - File name of a base image
+backing_fmt=str - Image format of the base image
+cluster_size=size - qcow2 cluster size
+compat=str - Compatibility level (0.10 or 1.1)
+encrypt.cipher-alg=str - Name of encryption cipher algorithm
+encrypt.cipher-mode=str - Name of encryption cipher mode
+encrypt.format=str - Encrypt the image, format choices: 'aes', 'luks'
+encrypt.hash-alg=str - Name of encryption hash algorithm
+encrypt.iter-time=num - Time to spend in PBKDF in milliseconds
+encrypt.ivgen-alg=str - Name of IV generator algorithm
+encrypt.ivgen-hash-alg=str - Name of IV generator hash algorithm
+encrypt.key-secret=str - ID of secret providing qcow AES key or LUKS passphrase
+encryption=bool (on/off) - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+lazy_refcounts=bool (on/off) - Postpone refcount updates
+nocow=bool (on/off) - Turn off copy-on-write (valid only on btrfs)
+preallocation=str - Preallocation mode (allowed values: off, metadata, falloc, full)
+refcount_bits=num - Width of a reference count entry in bits
+size=size - Virtual disk size
 
 Testing: convert -O qcow2 -o ? TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 Supported options:
-size             Virtual disk size
-compat           Compatibility level (0.10 or 1.1)
-backing_file     File name of a base image
-backing_fmt      Image format of the base image
-encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
-encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
-encrypt.cipher-alg Name of encryption cipher algorithm
-encrypt.cipher-mode Name of encryption cipher mode
-encrypt.ivgen-alg Name of IV generator algorithm
-encrypt.ivgen-hash-alg Name of IV generator hash algorithm
-encrypt.hash-alg Name of encryption hash algorithm
-encrypt.iter-time Time to spend in PBKDF in milliseconds
-cluster_size     qcow2 cluster size
-preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
-lazy_refcounts   Postpone refcount updates
-refcount_bits    Width of a reference count entry in bits
-nocow            Turn off copy-on-write (valid only on btrfs)
+backing_file=str - File name of a base image
+backing_fmt=str - Image format of the base image
+cluster_size=size - qcow2 cluster size
+compat=str - Compatibility level (0.10 or 1.1)
+encrypt.cipher-alg=str - Name of encryption cipher algorithm
+encrypt.cipher-mode=str - Name of encryption cipher mode
+encrypt.format=str - Encrypt the image, format choices: 'aes', 'luks'
+encrypt.hash-alg=str - Name of encryption hash algorithm
+encrypt.iter-time=num - Time to spend in PBKDF in milliseconds
+encrypt.ivgen-alg=str - Name of IV generator algorithm
+encrypt.ivgen-hash-alg=str - Name of IV generator hash algorithm
+encrypt.key-secret=str - ID of secret providing qcow AES key or LUKS passphrase
+encryption=bool (on/off) - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+lazy_refcounts=bool (on/off) - Postpone refcount updates
+nocow=bool (on/off) - Turn off copy-on-write (valid only on btrfs)
+preallocation=str - Preallocation mode (allowed values: off, metadata, falloc, full)
+refcount_bits=num - Width of a reference count entry in bits
+size=size - Virtual disk size
 
 Testing: convert -O qcow2 -o cluster_size=4k,help TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 Supported options:
-size             Virtual disk size
-compat           Compatibility level (0.10 or 1.1)
-backing_file     File name of a base image
-backing_fmt      Image format of the base image
-encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
-encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
-encrypt.cipher-alg Name of encryption cipher algorithm
-encrypt.cipher-mode Name of encryption cipher mode
-encrypt.ivgen-alg Name of IV generator algorithm
-encrypt.ivgen-hash-alg Name of IV generator hash algorithm
-encrypt.hash-alg Name of encryption hash algorithm
-encrypt.iter-time Time to spend in PBKDF in milliseconds
-cluster_size     qcow2 cluster size
-preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
-lazy_refcounts   Postpone refcount updates
-refcount_bits    Width of a reference count entry in bits
-nocow            Turn off copy-on-write (valid only on btrfs)
+backing_file=str - File name of a base image
+backing_fmt=str - Image format of the base image
+cluster_size=size - qcow2 cluster size
+compat=str - Compatibility level (0.10 or 1.1)
+encrypt.cipher-alg=str - Name of encryption cipher algorithm
+encrypt.cipher-mode=str - Name of encryption cipher mode
+encrypt.format=str - Encrypt the image, format choices: 'aes', 'luks'
+encrypt.hash-alg=str - Name of encryption hash algorithm
+encrypt.iter-time=num - Time to spend in PBKDF in milliseconds
+encrypt.ivgen-alg=str - Name of IV generator algorithm
+encrypt.ivgen-hash-alg=str - Name of IV generator hash algorithm
+encrypt.key-secret=str - ID of secret providing qcow AES key or LUKS passphrase
+encryption=bool (on/off) - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+lazy_refcounts=bool (on/off) - Postpone refcount updates
+nocow=bool (on/off) - Turn off copy-on-write (valid only on btrfs)
+preallocation=str - Preallocation mode (allowed values: off, metadata, falloc, full)
+refcount_bits=num - Width of a reference count entry in bits
+size=size - Virtual disk size
 
 Testing: convert -O qcow2 -o cluster_size=4k,? TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 Supported options:
-size             Virtual disk size
-compat           Compatibility level (0.10 or 1.1)
-backing_file     File name of a base image
-backing_fmt      Image format of the base image
-encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
-encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
-encrypt.cipher-alg Name of encryption cipher algorithm
-encrypt.cipher-mode Name of encryption cipher mode
-encrypt.ivgen-alg Name of IV generator algorithm
-encrypt.ivgen-hash-alg Name of IV generator hash algorithm
-encrypt.hash-alg Name of encryption hash algorithm
-encrypt.iter-time Time to spend in PBKDF in milliseconds
-cluster_size     qcow2 cluster size
-preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
-lazy_refcounts   Postpone refcount updates
-refcount_bits    Width of a reference count entry in bits
-nocow            Turn off copy-on-write (valid only on btrfs)
+backing_file=str - File name of a base image
+backing_fmt=str - Image format of the base image
+cluster_size=size - qcow2 cluster size
+compat=str - Compatibility level (0.10 or 1.1)
+encrypt.cipher-alg=str - Name of encryption cipher algorithm
+encrypt.cipher-mode=str - Name of encryption cipher mode
+encrypt.format=str - Encrypt the image, format choices: 'aes', 'luks'
+encrypt.hash-alg=str - Name of encryption hash algorithm
+encrypt.iter-time=num - Time to spend in PBKDF in milliseconds
+encrypt.ivgen-alg=str - Name of IV generator algorithm
+encrypt.ivgen-hash-alg=str - Name of IV generator hash algorithm
+encrypt.key-secret=str - ID of secret providing qcow AES key or LUKS passphrase
+encryption=bool (on/off) - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+lazy_refcounts=bool (on/off) - Postpone refcount updates
+nocow=bool (on/off) - Turn off copy-on-write (valid only on btrfs)
+preallocation=str - Preallocation mode (allowed values: off, metadata, falloc, full)
+refcount_bits=num - Width of a reference count entry in bits
+size=size - Virtual disk size
 
 Testing: convert -O qcow2 -o help,cluster_size=4k TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 Supported options:
-size             Virtual disk size
-compat           Compatibility level (0.10 or 1.1)
-backing_file     File name of a base image
-backing_fmt      Image format of the base image
-encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
-encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
-encrypt.cipher-alg Name of encryption cipher algorithm
-encrypt.cipher-mode Name of encryption cipher mode
-encrypt.ivgen-alg Name of IV generator algorithm
-encrypt.ivgen-hash-alg Name of IV generator hash algorithm
-encrypt.hash-alg Name of encryption hash algorithm
-encrypt.iter-time Time to spend in PBKDF in milliseconds
-cluster_size     qcow2 cluster size
-preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
-lazy_refcounts   Postpone refcount updates
-refcount_bits    Width of a reference count entry in bits
-nocow            Turn off copy-on-write (valid only on btrfs)
+backing_file=str - File name of a base image
+backing_fmt=str - Image format of the base image
+cluster_size=size - qcow2 cluster size
+compat=str - Compatibility level (0.10 or 1.1)
+encrypt.cipher-alg=str - Name of encryption cipher algorithm
+encrypt.cipher-mode=str - Name of encryption cipher mode
+encrypt.format=str - Encrypt the image, format choices: 'aes', 'luks'
+encrypt.hash-alg=str - Name of encryption hash algorithm
+encrypt.iter-time=num - Time to spend in PBKDF in milliseconds
+encrypt.ivgen-alg=str - Name of IV generator algorithm
+encrypt.ivgen-hash-alg=str - Name of IV generator hash algorithm
+encrypt.key-secret=str - ID of secret providing qcow AES key or LUKS passphrase
+encryption=bool (on/off) - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+lazy_refcounts=bool (on/off) - Postpone refcount updates
+nocow=bool (on/off) - Turn off copy-on-write (valid only on btrfs)
+preallocation=str - Preallocation mode (allowed values: off, metadata, falloc, full)
+refcount_bits=num - Width of a reference count entry in bits
+size=size - Virtual disk size
 
 Testing: convert -O qcow2 -o ?,cluster_size=4k TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 Supported options:
-size             Virtual disk size
-compat           Compatibility level (0.10 or 1.1)
-backing_file     File name of a base image
-backing_fmt      Image format of the base image
-encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
-encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
-encrypt.cipher-alg Name of encryption cipher algorithm
-encrypt.cipher-mode Name of encryption cipher mode
-encrypt.ivgen-alg Name of IV generator algorithm
-encrypt.ivgen-hash-alg Name of IV generator hash algorithm
-encrypt.hash-alg Name of encryption hash algorithm
-encrypt.iter-time Time to spend in PBKDF in milliseconds
-cluster_size     qcow2 cluster size
-preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
-lazy_refcounts   Postpone refcount updates
-refcount_bits    Width of a reference count entry in bits
-nocow            Turn off copy-on-write (valid only on btrfs)
+backing_file=str - File name of a base image
+backing_fmt=str - Image format of the base image
+cluster_size=size - qcow2 cluster size
+compat=str - Compatibility level (0.10 or 1.1)
+encrypt.cipher-alg=str - Name of encryption cipher algorithm
+encrypt.cipher-mode=str - Name of encryption cipher mode
+encrypt.format=str - Encrypt the image, format choices: 'aes', 'luks'
+encrypt.hash-alg=str - Name of encryption hash algorithm
+encrypt.iter-time=num - Time to spend in PBKDF in milliseconds
+encrypt.ivgen-alg=str - Name of IV generator algorithm
+encrypt.ivgen-hash-alg=str - Name of IV generator hash algorithm
+encrypt.key-secret=str - ID of secret providing qcow AES key or LUKS passphrase
+encryption=bool (on/off) - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+lazy_refcounts=bool (on/off) - Postpone refcount updates
+nocow=bool (on/off) - Turn off copy-on-write (valid only on btrfs)
+preallocation=str - Preallocation mode (allowed values: off, metadata, falloc, full)
+refcount_bits=num - Width of a reference count entry in bits
+size=size - Virtual disk size
 
 Testing: convert -O qcow2 -o cluster_size=4k -o help TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 Supported options:
-size             Virtual disk size
-compat           Compatibility level (0.10 or 1.1)
-backing_file     File name of a base image
-backing_fmt      Image format of the base image
-encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
-encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
-encrypt.cipher-alg Name of encryption cipher algorithm
-encrypt.cipher-mode Name of encryption cipher mode
-encrypt.ivgen-alg Name of IV generator algorithm
-encrypt.ivgen-hash-alg Name of IV generator hash algorithm
-encrypt.hash-alg Name of encryption hash algorithm
-encrypt.iter-time Time to spend in PBKDF in milliseconds
-cluster_size     qcow2 cluster size
-preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
-lazy_refcounts   Postpone refcount updates
-refcount_bits    Width of a reference count entry in bits
-nocow            Turn off copy-on-write (valid only on btrfs)
+backing_file=str - File name of a base image
+backing_fmt=str - Image format of the base image
+cluster_size=size - qcow2 cluster size
+compat=str - Compatibility level (0.10 or 1.1)
+encrypt.cipher-alg=str - Name of encryption cipher algorithm
+encrypt.cipher-mode=str - Name of encryption cipher mode
+encrypt.format=str - Encrypt the image, format choices: 'aes', 'luks'
+encrypt.hash-alg=str - Name of encryption hash algorithm
+encrypt.iter-time=num - Time to spend in PBKDF in milliseconds
+encrypt.ivgen-alg=str - Name of IV generator algorithm
+encrypt.ivgen-hash-alg=str - Name of IV generator hash algorithm
+encrypt.key-secret=str - ID of secret providing qcow AES key or LUKS passphrase
+encryption=bool (on/off) - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+lazy_refcounts=bool (on/off) - Postpone refcount updates
+nocow=bool (on/off) - Turn off copy-on-write (valid only on btrfs)
+preallocation=str - Preallocation mode (allowed values: off, metadata, falloc, full)
+refcount_bits=num - Width of a reference count entry in bits
+size=size - Virtual disk size
 
 Testing: convert -O qcow2 -o cluster_size=4k -o ? TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 Supported options:
-size             Virtual disk size
-compat           Compatibility level (0.10 or 1.1)
-backing_file     File name of a base image
-backing_fmt      Image format of the base image
-encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
-encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
-encrypt.cipher-alg Name of encryption cipher algorithm
-encrypt.cipher-mode Name of encryption cipher mode
-encrypt.ivgen-alg Name of IV generator algorithm
-encrypt.ivgen-hash-alg Name of IV generator hash algorithm
-encrypt.hash-alg Name of encryption hash algorithm
-encrypt.iter-time Time to spend in PBKDF in milliseconds
-cluster_size     qcow2 cluster size
-preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
-lazy_refcounts   Postpone refcount updates
-refcount_bits    Width of a reference count entry in bits
-nocow            Turn off copy-on-write (valid only on btrfs)
+backing_file=str - File name of a base image
+backing_fmt=str - Image format of the base image
+cluster_size=size - qcow2 cluster size
+compat=str - Compatibility level (0.10 or 1.1)
+encrypt.cipher-alg=str - Name of encryption cipher algorithm
+encrypt.cipher-mode=str - Name of encryption cipher mode
+encrypt.format=str - Encrypt the image, format choices: 'aes', 'luks'
+encrypt.hash-alg=str - Name of encryption hash algorithm
+encrypt.iter-time=num - Time to spend in PBKDF in milliseconds
+encrypt.ivgen-alg=str - Name of IV generator algorithm
+encrypt.ivgen-hash-alg=str - Name of IV generator hash algorithm
+encrypt.key-secret=str - ID of secret providing qcow AES key or LUKS passphrase
+encryption=bool (on/off) - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+lazy_refcounts=bool (on/off) - Postpone refcount updates
+nocow=bool (on/off) - Turn off copy-on-write (valid only on btrfs)
+preallocation=str - Preallocation mode (allowed values: off, metadata, falloc, full)
+refcount_bits=num - Width of a reference count entry in bits
+size=size - Virtual disk size
 
 Testing: convert -O qcow2 -o backing_file=TEST_DIR/t.qcow2,,help TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 qemu-img: Could not open 'TEST_DIR/t.qcow2.base': Could not open backing file: Could not open 'TEST_DIR/t.qcow2,help': No such file or directory
@@ -483,27 +483,27 @@ qemu-img: Invalid option list: ,,
 
 Testing: convert -O qcow2 -o help
 Supported options:
-size             Virtual disk size
-compat           Compatibility level (0.10 or 1.1)
-backing_file     File name of a base image
-backing_fmt      Image format of the base image
-encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
-encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
-encrypt.cipher-alg Name of encryption cipher algorithm
-encrypt.cipher-mode Name of encryption cipher mode
-encrypt.ivgen-alg Name of IV generator algorithm
-encrypt.ivgen-hash-alg Name of IV generator hash algorithm
-encrypt.hash-alg Name of encryption hash algorithm
-encrypt.iter-time Time to spend in PBKDF in milliseconds
-cluster_size     qcow2 cluster size
-preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
-lazy_refcounts   Postpone refcount updates
-refcount_bits    Width of a reference count entry in bits
+backing_file=str - File name of a base image
+backing_fmt=str - Image format of the base image
+cluster_size=size - qcow2 cluster size
+compat=str - Compatibility level (0.10 or 1.1)
+encrypt.cipher-alg=str - Name of encryption cipher algorithm
+encrypt.cipher-mode=str - Name of encryption cipher mode
+encrypt.format=str - Encrypt the image, format choices: 'aes', 'luks'
+encrypt.hash-alg=str - Name of encryption hash algorithm
+encrypt.iter-time=num - Time to spend in PBKDF in milliseconds
+encrypt.ivgen-alg=str - Name of IV generator algorithm
+encrypt.ivgen-hash-alg=str - Name of IV generator hash algorithm
+encrypt.key-secret=str - ID of secret providing qcow AES key or LUKS passphrase
+encryption=bool (on/off) - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+lazy_refcounts=bool (on/off) - Postpone refcount updates
+preallocation=str - Preallocation mode (allowed values: off, metadata, falloc, full)
+refcount_bits=num - Width of a reference count entry in bits
+size=size - Virtual disk size
 
 Testing: convert -o help
 Supported options:
-size             Virtual disk size
+size=size - Virtual disk size
 
 Testing: convert -O bochs -o help
 qemu-img: Format driver 'bochs' does not support image creation
@@ -564,177 +564,177 @@ cluster_size: 65536
 
 Testing: amend -f qcow2 -o help TEST_DIR/t.qcow2
 Creation options for 'qcow2':
-size             Virtual disk size
-compat           Compatibility level (0.10 or 1.1)
-backing_file     File name of a base image
-backing_fmt      Image format of the base image
-encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
-encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
-encrypt.cipher-alg Name of encryption cipher algorithm
-encrypt.cipher-mode Name of encryption cipher mode
-encrypt.ivgen-alg Name of IV generator algorithm
-encrypt.ivgen-hash-alg Name of IV generator hash algorithm
-encrypt.hash-alg Name of encryption hash algorithm
-encrypt.iter-time Time to spend in PBKDF in milliseconds
-cluster_size     qcow2 cluster size
-preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
-lazy_refcounts   Postpone refcount updates
-refcount_bits    Width of a reference count entry in bits
+qcow2-create-opts.backing_file=str - File name of a base image
+qcow2-create-opts.backing_fmt=str - Image format of the base image
+qcow2-create-opts.cluster_size=size - qcow2 cluster size
+qcow2-create-opts.compat=str - Compatibility level (0.10 or 1.1)
+qcow2-create-opts.encrypt.cipher-alg=str - Name of encryption cipher algorithm
+qcow2-create-opts.encrypt.cipher-mode=str - Name of encryption cipher mode
+qcow2-create-opts.encrypt.format=str - Encrypt the image, format choices: 'aes', 'luks'
+qcow2-create-opts.encrypt.hash-alg=str - Name of encryption hash algorithm
+qcow2-create-opts.encrypt.iter-time=num - Time to spend in PBKDF in milliseconds
+qcow2-create-opts.encrypt.ivgen-alg=str - Name of IV generator algorithm
+qcow2-create-opts.encrypt.ivgen-hash-alg=str - Name of IV generator hash algorithm
+qcow2-create-opts.encrypt.key-secret=str - ID of secret providing qcow AES key or LUKS passphrase
+qcow2-create-opts.encryption=bool (on/off) - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+qcow2-create-opts.lazy_refcounts=bool (on/off) - Postpone refcount updates
+qcow2-create-opts.preallocation=str - Preallocation mode (allowed values: off, metadata, falloc, full)
+qcow2-create-opts.refcount_bits=num - Width of a reference count entry in bits
+qcow2-create-opts.size=size - Virtual disk size
 
 Note that not all of these options may be amendable.
 
 Testing: amend -f qcow2 -o ? TEST_DIR/t.qcow2
 Creation options for 'qcow2':
-size             Virtual disk size
-compat           Compatibility level (0.10 or 1.1)
-backing_file     File name of a base image
-backing_fmt      Image format of the base image
-encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
-encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
-encrypt.cipher-alg Name of encryption cipher algorithm
-encrypt.cipher-mode Name of encryption cipher mode
-encrypt.ivgen-alg Name of IV generator algorithm
-encrypt.ivgen-hash-alg Name of IV generator hash algorithm
-encrypt.hash-alg Name of encryption hash algorithm
-encrypt.iter-time Time to spend in PBKDF in milliseconds
-cluster_size     qcow2 cluster size
-preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
-lazy_refcounts   Postpone refcount updates
-refcount_bits    Width of a reference count entry in bits
+qcow2-create-opts.backing_file=str - File name of a base image
+qcow2-create-opts.backing_fmt=str - Image format of the base image
+qcow2-create-opts.cluster_size=size - qcow2 cluster size
+qcow2-create-opts.compat=str - Compatibility level (0.10 or 1.1)
+qcow2-create-opts.encrypt.cipher-alg=str - Name of encryption cipher algorithm
+qcow2-create-opts.encrypt.cipher-mode=str - Name of encryption cipher mode
+qcow2-create-opts.encrypt.format=str - Encrypt the image, format choices: 'aes', 'luks'
+qcow2-create-opts.encrypt.hash-alg=str - Name of encryption hash algorithm
+qcow2-create-opts.encrypt.iter-time=num - Time to spend in PBKDF in milliseconds
+qcow2-create-opts.encrypt.ivgen-alg=str - Name of IV generator algorithm
+qcow2-create-opts.encrypt.ivgen-hash-alg=str - Name of IV generator hash algorithm
+qcow2-create-opts.encrypt.key-secret=str - ID of secret providing qcow AES key or LUKS passphrase
+qcow2-create-opts.encryption=bool (on/off) - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+qcow2-create-opts.lazy_refcounts=bool (on/off) - Postpone refcount updates
+qcow2-create-opts.preallocation=str - Preallocation mode (allowed values: off, metadata, falloc, full)
+qcow2-create-opts.refcount_bits=num - Width of a reference count entry in bits
+qcow2-create-opts.size=size - Virtual disk size
 
 Note that not all of these options may be amendable.
 
 Testing: amend -f qcow2 -o cluster_size=4k,help TEST_DIR/t.qcow2
 Creation options for 'qcow2':
-size             Virtual disk size
-compat           Compatibility level (0.10 or 1.1)
-backing_file     File name of a base image
-backing_fmt      Image format of the base image
-encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
-encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
-encrypt.cipher-alg Name of encryption cipher algorithm
-encrypt.cipher-mode Name of encryption cipher mode
-encrypt.ivgen-alg Name of IV generator algorithm
-encrypt.ivgen-hash-alg Name of IV generator hash algorithm
-encrypt.hash-alg Name of encryption hash algorithm
-encrypt.iter-time Time to spend in PBKDF in milliseconds
-cluster_size     qcow2 cluster size
-preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
-lazy_refcounts   Postpone refcount updates
-refcount_bits    Width of a reference count entry in bits
+qcow2-create-opts.backing_file=str - File name of a base image
+qcow2-create-opts.backing_fmt=str - Image format of the base image
+qcow2-create-opts.cluster_size=size - qcow2 cluster size
+qcow2-create-opts.compat=str - Compatibility level (0.10 or 1.1)
+qcow2-create-opts.encrypt.cipher-alg=str - Name of encryption cipher algorithm
+qcow2-create-opts.encrypt.cipher-mode=str - Name of encryption cipher mode
+qcow2-create-opts.encrypt.format=str - Encrypt the image, format choices: 'aes', 'luks'
+qcow2-create-opts.encrypt.hash-alg=str - Name of encryption hash algorithm
+qcow2-create-opts.encrypt.iter-time=num - Time to spend in PBKDF in milliseconds
+qcow2-create-opts.encrypt.ivgen-alg=str - Name of IV generator algorithm
+qcow2-create-opts.encrypt.ivgen-hash-alg=str - Name of IV generator hash algorithm
+qcow2-create-opts.encrypt.key-secret=str - ID of secret providing qcow AES key or LUKS passphrase
+qcow2-create-opts.encryption=bool (on/off) - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+qcow2-create-opts.lazy_refcounts=bool (on/off) - Postpone refcount updates
+qcow2-create-opts.preallocation=str - Preallocation mode (allowed values: off, metadata, falloc, full)
+qcow2-create-opts.refcount_bits=num - Width of a reference count entry in bits
+qcow2-create-opts.size=size - Virtual disk size
 
 Note that not all of these options may be amendable.
 
 Testing: amend -f qcow2 -o cluster_size=4k,? TEST_DIR/t.qcow2
 Creation options for 'qcow2':
-size             Virtual disk size
-compat           Compatibility level (0.10 or 1.1)
-backing_file     File name of a base image
-backing_fmt      Image format of the base image
-encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
-encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
-encrypt.cipher-alg Name of encryption cipher algorithm
-encrypt.cipher-mode Name of encryption cipher mode
-encrypt.ivgen-alg Name of IV generator algorithm
-encrypt.ivgen-hash-alg Name of IV generator hash algorithm
-encrypt.hash-alg Name of encryption hash algorithm
-encrypt.iter-time Time to spend in PBKDF in milliseconds
-cluster_size     qcow2 cluster size
-preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
-lazy_refcounts   Postpone refcount updates
-refcount_bits    Width of a reference count entry in bits
+qcow2-create-opts.backing_file=str - File name of a base image
+qcow2-create-opts.backing_fmt=str - Image format of the base image
+qcow2-create-opts.cluster_size=size - qcow2 cluster size
+qcow2-create-opts.compat=str - Compatibility level (0.10 or 1.1)
+qcow2-create-opts.encrypt.cipher-alg=str - Name of encryption cipher algorithm
+qcow2-create-opts.encrypt.cipher-mode=str - Name of encryption cipher mode
+qcow2-create-opts.encrypt.format=str - Encrypt the image, format choices: 'aes', 'luks'
+qcow2-create-opts.encrypt.hash-alg=str - Name of encryption hash algorithm
+qcow2-create-opts.encrypt.iter-time=num - Time to spend in PBKDF in milliseconds
+qcow2-create-opts.encrypt.ivgen-alg=str - Name of IV generator algorithm
+qcow2-create-opts.encrypt.ivgen-hash-alg=str - Name of IV generator hash algorithm
+qcow2-create-opts.encrypt.key-secret=str - ID of secret providing qcow AES key or LUKS passphrase
+qcow2-create-opts.encryption=bool (on/off) - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+qcow2-create-opts.lazy_refcounts=bool (on/off) - Postpone refcount updates
+qcow2-create-opts.preallocation=str - Preallocation mode (allowed values: off, metadata, falloc, full)
+qcow2-create-opts.refcount_bits=num - Width of a reference count entry in bits
+qcow2-create-opts.size=size - Virtual disk size
 
 Note that not all of these options may be amendable.
 
 Testing: amend -f qcow2 -o help,cluster_size=4k TEST_DIR/t.qcow2
 Creation options for 'qcow2':
-size             Virtual disk size
-compat           Compatibility level (0.10 or 1.1)
-backing_file     File name of a base image
-backing_fmt      Image format of the base image
-encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
-encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
-encrypt.cipher-alg Name of encryption cipher algorithm
-encrypt.cipher-mode Name of encryption cipher mode
-encrypt.ivgen-alg Name of IV generator algorithm
-encrypt.ivgen-hash-alg Name of IV generator hash algorithm
-encrypt.hash-alg Name of encryption hash algorithm
-encrypt.iter-time Time to spend in PBKDF in milliseconds
-cluster_size     qcow2 cluster size
-preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
-lazy_refcounts   Postpone refcount updates
-refcount_bits    Width of a reference count entry in bits
+qcow2-create-opts.backing_file=str - File name of a base image
+qcow2-create-opts.backing_fmt=str - Image format of the base image
+qcow2-create-opts.cluster_size=size - qcow2 cluster size
+qcow2-create-opts.compat=str - Compatibility level (0.10 or 1.1)
+qcow2-create-opts.encrypt.cipher-alg=str - Name of encryption cipher algorithm
+qcow2-create-opts.encrypt.cipher-mode=str - Name of encryption cipher mode
+qcow2-create-opts.encrypt.format=str - Encrypt the image, format choices: 'aes', 'luks'
+qcow2-create-opts.encrypt.hash-alg=str - Name of encryption hash algorithm
+qcow2-create-opts.encrypt.iter-time=num - Time to spend in PBKDF in milliseconds
+qcow2-create-opts.encrypt.ivgen-alg=str - Name of IV generator algorithm
+qcow2-create-opts.encrypt.ivgen-hash-alg=str - Name of IV generator hash algorithm
+qcow2-create-opts.encrypt.key-secret=str - ID of secret providing qcow AES key or LUKS passphrase
+qcow2-create-opts.encryption=bool (on/off) - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+qcow2-create-opts.lazy_refcounts=bool (on/off) - Postpone refcount updates
+qcow2-create-opts.preallocation=str - Preallocation mode (allowed values: off, metadata, falloc, full)
+qcow2-create-opts.refcount_bits=num - Width of a reference count entry in bits
+qcow2-create-opts.size=size - Virtual disk size
 
 Note that not all of these options may be amendable.
 
 Testing: amend -f qcow2 -o ?,cluster_size=4k TEST_DIR/t.qcow2
 Creation options for 'qcow2':
-size             Virtual disk size
-compat           Compatibility level (0.10 or 1.1)
-backing_file     File name of a base image
-backing_fmt      Image format of the base image
-encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
-encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
-encrypt.cipher-alg Name of encryption cipher algorithm
-encrypt.cipher-mode Name of encryption cipher mode
-encrypt.ivgen-alg Name of IV generator algorithm
-encrypt.ivgen-hash-alg Name of IV generator hash algorithm
-encrypt.hash-alg Name of encryption hash algorithm
-encrypt.iter-time Time to spend in PBKDF in milliseconds
-cluster_size     qcow2 cluster size
-preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
-lazy_refcounts   Postpone refcount updates
-refcount_bits    Width of a reference count entry in bits
+qcow2-create-opts.backing_file=str - File name of a base image
+qcow2-create-opts.backing_fmt=str - Image format of the base image
+qcow2-create-opts.cluster_size=size - qcow2 cluster size
+qcow2-create-opts.compat=str - Compatibility level (0.10 or 1.1)
+qcow2-create-opts.encrypt.cipher-alg=str - Name of encryption cipher algorithm
+qcow2-create-opts.encrypt.cipher-mode=str - Name of encryption cipher mode
+qcow2-create-opts.encrypt.format=str - Encrypt the image, format choices: 'aes', 'luks'
+qcow2-create-opts.encrypt.hash-alg=str - Name of encryption hash algorithm
+qcow2-create-opts.encrypt.iter-time=num - Time to spend in PBKDF in milliseconds
+qcow2-create-opts.encrypt.ivgen-alg=str - Name of IV generator algorithm
+qcow2-create-opts.encrypt.ivgen-hash-alg=str - Name of IV generator hash algorithm
+qcow2-create-opts.encrypt.key-secret=str - ID of secret providing qcow AES key or LUKS passphrase
+qcow2-create-opts.encryption=bool (on/off) - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+qcow2-create-opts.lazy_refcounts=bool (on/off) - Postpone refcount updates
+qcow2-create-opts.preallocation=str - Preallocation mode (allowed values: off, metadata, falloc, full)
+qcow2-create-opts.refcount_bits=num - Width of a reference count entry in bits
+qcow2-create-opts.size=size - Virtual disk size
 
 Note that not all of these options may be amendable.
 
 Testing: amend -f qcow2 -o cluster_size=4k -o help TEST_DIR/t.qcow2
 Creation options for 'qcow2':
-size             Virtual disk size
-compat           Compatibility level (0.10 or 1.1)
-backing_file     File name of a base image
-backing_fmt      Image format of the base image
-encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
-encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
-encrypt.cipher-alg Name of encryption cipher algorithm
-encrypt.cipher-mode Name of encryption cipher mode
-encrypt.ivgen-alg Name of IV generator algorithm
-encrypt.ivgen-hash-alg Name of IV generator hash algorithm
-encrypt.hash-alg Name of encryption hash algorithm
-encrypt.iter-time Time to spend in PBKDF in milliseconds
-cluster_size     qcow2 cluster size
-preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
-lazy_refcounts   Postpone refcount updates
-refcount_bits    Width of a reference count entry in bits
+qcow2-create-opts.backing_file=str - File name of a base image
+qcow2-create-opts.backing_fmt=str - Image format of the base image
+qcow2-create-opts.cluster_size=size - qcow2 cluster size
+qcow2-create-opts.compat=str - Compatibility level (0.10 or 1.1)
+qcow2-create-opts.encrypt.cipher-alg=str - Name of encryption cipher algorithm
+qcow2-create-opts.encrypt.cipher-mode=str - Name of encryption cipher mode
+qcow2-create-opts.encrypt.format=str - Encrypt the image, format choices: 'aes', 'luks'
+qcow2-create-opts.encrypt.hash-alg=str - Name of encryption hash algorithm
+qcow2-create-opts.encrypt.iter-time=num - Time to spend in PBKDF in milliseconds
+qcow2-create-opts.encrypt.ivgen-alg=str - Name of IV generator algorithm
+qcow2-create-opts.encrypt.ivgen-hash-alg=str - Name of IV generator hash algorithm
+qcow2-create-opts.encrypt.key-secret=str - ID of secret providing qcow AES key or LUKS passphrase
+qcow2-create-opts.encryption=bool (on/off) - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+qcow2-create-opts.lazy_refcounts=bool (on/off) - Postpone refcount updates
+qcow2-create-opts.preallocation=str - Preallocation mode (allowed values: off, metadata, falloc, full)
+qcow2-create-opts.refcount_bits=num - Width of a reference count entry in bits
+qcow2-create-opts.size=size - Virtual disk size
 
 Note that not all of these options may be amendable.
 
 Testing: amend -f qcow2 -o cluster_size=4k -o ? TEST_DIR/t.qcow2
 Creation options for 'qcow2':
-size             Virtual disk size
-compat           Compatibility level (0.10 or 1.1)
-backing_file     File name of a base image
-backing_fmt      Image format of the base image
-encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
-encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
-encrypt.cipher-alg Name of encryption cipher algorithm
-encrypt.cipher-mode Name of encryption cipher mode
-encrypt.ivgen-alg Name of IV generator algorithm
-encrypt.ivgen-hash-alg Name of IV generator hash algorithm
-encrypt.hash-alg Name of encryption hash algorithm
-encrypt.iter-time Time to spend in PBKDF in milliseconds
-cluster_size     qcow2 cluster size
-preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
-lazy_refcounts   Postpone refcount updates
-refcount_bits    Width of a reference count entry in bits
+qcow2-create-opts.backing_file=str - File name of a base image
+qcow2-create-opts.backing_fmt=str - Image format of the base image
+qcow2-create-opts.cluster_size=size - qcow2 cluster size
+qcow2-create-opts.compat=str - Compatibility level (0.10 or 1.1)
+qcow2-create-opts.encrypt.cipher-alg=str - Name of encryption cipher algorithm
+qcow2-create-opts.encrypt.cipher-mode=str - Name of encryption cipher mode
+qcow2-create-opts.encrypt.format=str - Encrypt the image, format choices: 'aes', 'luks'
+qcow2-create-opts.encrypt.hash-alg=str - Name of encryption hash algorithm
+qcow2-create-opts.encrypt.iter-time=num - Time to spend in PBKDF in milliseconds
+qcow2-create-opts.encrypt.ivgen-alg=str - Name of IV generator algorithm
+qcow2-create-opts.encrypt.ivgen-hash-alg=str - Name of IV generator hash algorithm
+qcow2-create-opts.encrypt.key-secret=str - ID of secret providing qcow AES key or LUKS passphrase
+qcow2-create-opts.encryption=bool (on/off) - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+qcow2-create-opts.lazy_refcounts=bool (on/off) - Postpone refcount updates
+qcow2-create-opts.preallocation=str - Preallocation mode (allowed values: off, metadata, falloc, full)
+qcow2-create-opts.refcount_bits=num - Width of a reference count entry in bits
+qcow2-create-opts.size=size - Virtual disk size
 
 Note that not all of these options may be amendable.
 
@@ -757,29 +757,29 @@ qemu-img: Invalid option list: ,,
 
 Testing: amend -f qcow2 -o help
 Creation options for 'qcow2':
-size             Virtual disk size
-compat           Compatibility level (0.10 or 1.1)
-backing_file     File name of a base image
-backing_fmt      Image format of the base image
-encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
-encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
-encrypt.cipher-alg Name of encryption cipher algorithm
-encrypt.cipher-mode Name of encryption cipher mode
-encrypt.ivgen-alg Name of IV generator algorithm
-encrypt.ivgen-hash-alg Name of IV generator hash algorithm
-encrypt.hash-alg Name of encryption hash algorithm
-encrypt.iter-time Time to spend in PBKDF in milliseconds
-cluster_size     qcow2 cluster size
-preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
-lazy_refcounts   Postpone refcount updates
-refcount_bits    Width of a reference count entry in bits
+qcow2-create-opts.backing_file=str - File name of a base image
+qcow2-create-opts.backing_fmt=str - Image format of the base image
+qcow2-create-opts.cluster_size=size - qcow2 cluster size
+qcow2-create-opts.compat=str - Compatibility level (0.10 or 1.1)
+qcow2-create-opts.encrypt.cipher-alg=str - Name of encryption cipher algorithm
+qcow2-create-opts.encrypt.cipher-mode=str - Name of encryption cipher mode
+qcow2-create-opts.encrypt.format=str - Encrypt the image, format choices: 'aes', 'luks'
+qcow2-create-opts.encrypt.hash-alg=str - Name of encryption hash algorithm
+qcow2-create-opts.encrypt.iter-time=num - Time to spend in PBKDF in milliseconds
+qcow2-create-opts.encrypt.ivgen-alg=str - Name of IV generator algorithm
+qcow2-create-opts.encrypt.ivgen-hash-alg=str - Name of IV generator hash algorithm
+qcow2-create-opts.encrypt.key-secret=str - ID of secret providing qcow AES key or LUKS passphrase
+qcow2-create-opts.encryption=bool (on/off) - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+qcow2-create-opts.lazy_refcounts=bool (on/off) - Postpone refcount updates
+qcow2-create-opts.preallocation=str - Preallocation mode (allowed values: off, metadata, falloc, full)
+qcow2-create-opts.refcount_bits=num - Width of a reference count entry in bits
+qcow2-create-opts.size=size - Virtual disk size
 
 Note that not all of these options may be amendable.
 
 Testing: convert -o help
 Supported options:
-size             Virtual disk size
+size=size - Virtual disk size
 
 Testing: amend -f bochs -o help
 qemu-img: Format driver 'bochs' does not support option amendment
-- 
2.17.2
