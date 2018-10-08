Received: from eggs.gnu.org ([2001:4830:134:3::10]:56306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1g9Zzb-000360-O8
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1g9ZkB-0006Vk-2M
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:55:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47048
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1g9ZkA-0006U9-JD
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:54:58 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w98Hrrnc047562
	for <qemu-devel@nongnu.org>; Mon, 8 Oct 2018 13:54:57 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2n0a44w2tp-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 13:54:56 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Mon, 8 Oct 2018 13:54:55 -0400
From: Farhan Ali <alifm@linux.ibm.com>
Date: Mon,  8 Oct 2018 13:54:52 -0400
In-Reply-To: <cover.1539020852.git.alifm@linux.ibm.com>
References: <cover.1539020852.git.alifm@linux.ibm.com>
Message-Id: <4e79b7522a0da8a5635024a97f3b04cfd64fe900.1539020852.git.alifm@linux.ibm.com>
Subject: [Qemu-devel] [RFC v1 1/1] qemu-iotests: Fix output for testcase 082
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, famz@redhat.com, alifm@linux.ibm.com

Commit 9cbef9d68ee: qemu-option: improve qemu_opts_print_help() output,
changed some of the output for qemu-img tool but did not
update the corresponding 082 test case file. This broke
qemu-iotests.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 tests/qemu-iotests/082.out | 956 ++++++++++++++++++++++-----------------------
 1 file changed, 478 insertions(+), 478 deletions(-)

diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index 19e9fb1..2672349 100644
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
2.7.4
