Received: from eggs.gnu.org ([2001:4830:134:3::10]:47324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gC546-0001A8-0r
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 11:45:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gC540-0002v3-Cs
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 11:45:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1gC53z-0002ug-QW
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 11:45:48 -0400
References: <cover.1539020852.git.alifm@linux.ibm.com>
	<4e79b7522a0da8a5635024a97f3b04cfd64fe900.1539020852.git.alifm@linux.ibm.com>
	<f851ad95-5bcc-f186-0806-571fb3ba1a40@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f1949902-8cfe-b9c0-0cc3-f680893dc025@redhat.com>
Date: Mon, 15 Oct 2018 17:45:38 +0200
MIME-Version: 1.0
In-Reply-To: <f851ad95-5bcc-f186-0806-571fb3ba1a40@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aCDH2czHxkC7b6kdv2JhGKDCxpvwSF9JG"
Subject: Re: [Qemu-devel] [RFC v1 1/1] qemu-iotests: Fix output for testcase
 082
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, marcandre.lureau@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aCDH2czHxkC7b6kdv2JhGKDCxpvwSF9JG
From: Max Reitz <mreitz@redhat.com>
To: Cleber Rosa <crosa@redhat.com>, Farhan Ali <alifm@linux.ibm.com>,
 qemu-devel@nongnu.org
Cc: famz@redhat.com, marcandre.lureau@redhat.com
Message-ID: <f1949902-8cfe-b9c0-0cc3-f680893dc025@redhat.com>
Subject: Re: [Qemu-devel] [RFC v1 1/1] qemu-iotests: Fix output for testcase
 082
References: <cover.1539020852.git.alifm@linux.ibm.com>
 <4e79b7522a0da8a5635024a97f3b04cfd64fe900.1539020852.git.alifm@linux.ibm.com>
 <f851ad95-5bcc-f186-0806-571fb3ba1a40@redhat.com>
In-Reply-To: <f851ad95-5bcc-f186-0806-571fb3ba1a40@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.10.18 17:40, Cleber Rosa wrote:
>=20
>=20
> On 10/8/18 1:54 PM, Farhan Ali wrote:
>> Commit 9cbef9d68ee: qemu-option: improve qemu_opts_print_help() output=
,
>> changed some of the output for qemu-img tool but did not
>> update the corresponding 082 test case file. This broke
>> qemu-iotests.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>  tests/qemu-iotests/082.out | 956 ++++++++++++++++++++++--------------=
---------
>>  1 file changed, 478 insertions(+), 478 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
>> index 19e9fb1..2672349 100644
>> --- a/tests/qemu-iotests/082.out
>> +++ b/tests/qemu-iotests/082.out
>> @@ -44,171 +44,171 @@ cluster_size: 8192
>> =20
>>  Testing: create -f qcow2 -o help TEST_DIR/t.qcow2 128M
>>  Supported options:
>> -size             Virtual disk size
>> -compat           Compatibility level (0.10 or 1.1)
>> -backing_file     File name of a base image
>> -backing_fmt      Image format of the base image
>> -encryption       Encrypt the image with format 'aes'. (Deprecated in =
favor of encrypt.format=3Daes)
>> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
>> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passph=
rase
>> -encrypt.cipher-alg Name of encryption cipher algorithm
>> -encrypt.cipher-mode Name of encryption cipher mode
>> -encrypt.ivgen-alg Name of IV generator algorithm
>> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
>> -encrypt.hash-alg Name of encryption hash algorithm
>> -encrypt.iter-time Time to spend in PBKDF in milliseconds
>> -cluster_size     qcow2 cluster size
>> -preallocation    Preallocation mode (allowed values: off, metadata, f=
alloc, full)
>> -lazy_refcounts   Postpone refcount updates
>> -refcount_bits    Width of a reference count entry in bits
>> -nocow            Turn off copy-on-write (valid only on btrfs)
>> +backing_file=3Dstr - File name of a base image
>> +backing_fmt=3Dstr - Image format of the base image
>> +cluster_size=3Dsize - qcow2 cluster size
>> +compat=3Dstr - Compatibility level (0.10 or 1.1)
>> +encrypt.cipher-alg=3Dstr - Name of encryption cipher algorithm
>> +encrypt.cipher-mode=3Dstr - Name of encryption cipher mode
>> +encrypt.format=3Dstr - Encrypt the image, format choices: 'aes', 'luk=
s'
>> +encrypt.hash-alg=3Dstr - Name of encryption hash algorithm
>> +encrypt.iter-time=3Dnum - Time to spend in PBKDF in milliseconds
>> +encrypt.ivgen-alg=3Dstr - Name of IV generator algorithm
>> +encrypt.ivgen-hash-alg=3Dstr - Name of IV generator hash algorithm
>> +encrypt.key-secret=3Dstr - ID of secret providing qcow AES key or LUK=
S passphrase
>> +encryption=3Dbool (on/off) - Encrypt the image with format 'aes'. (De=
precated in favor of encrypt.format=3Daes)
>> +lazy_refcounts=3Dbool (on/off) - Postpone refcount updates
>> +nocow=3Dbool (on/off) - Turn off copy-on-write (valid only on btrfs)
>> +preallocation=3Dstr - Preallocation mode (allowed values: off, metada=
ta, falloc, full)
>> +refcount_bits=3Dnum - Width of a reference count entry in bits
>> +size=3Dsize - Virtual disk size
>> =20
>>  Testing: create -f qcow2 -o ? TEST_DIR/t.qcow2 128M
>>  Supported options:
>> -size             Virtual disk size
>> -compat           Compatibility level (0.10 or 1.1)
>> -backing_file     File name of a base image
>> -backing_fmt      Image format of the base image
>> -encryption       Encrypt the image with format 'aes'. (Deprecated in =
favor of encrypt.format=3Daes)
>> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
>> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passph=
rase
>> -encrypt.cipher-alg Name of encryption cipher algorithm
>> -encrypt.cipher-mode Name of encryption cipher mode
>> -encrypt.ivgen-alg Name of IV generator algorithm
>> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
>> -encrypt.hash-alg Name of encryption hash algorithm
>> -encrypt.iter-time Time to spend in PBKDF in milliseconds
>> -cluster_size     qcow2 cluster size
>> -preallocation    Preallocation mode (allowed values: off, metadata, f=
alloc, full)
>> -lazy_refcounts   Postpone refcount updates
>> -refcount_bits    Width of a reference count entry in bits
>> -nocow            Turn off copy-on-write (valid only on btrfs)
>> +backing_file=3Dstr - File name of a base image
>> +backing_fmt=3Dstr - Image format of the base image
>> +cluster_size=3Dsize - qcow2 cluster size
>> +compat=3Dstr - Compatibility level (0.10 or 1.1)
>> +encrypt.cipher-alg=3Dstr - Name of encryption cipher algorithm
>> +encrypt.cipher-mode=3Dstr - Name of encryption cipher mode
>> +encrypt.format=3Dstr - Encrypt the image, format choices: 'aes', 'luk=
s'
>> +encrypt.hash-alg=3Dstr - Name of encryption hash algorithm
>> +encrypt.iter-time=3Dnum - Time to spend in PBKDF in milliseconds
>> +encrypt.ivgen-alg=3Dstr - Name of IV generator algorithm
>> +encrypt.ivgen-hash-alg=3Dstr - Name of IV generator hash algorithm
>> +encrypt.key-secret=3Dstr - ID of secret providing qcow AES key or LUK=
S passphrase
>> +encryption=3Dbool (on/off) - Encrypt the image with format 'aes'. (De=
precated in favor of encrypt.format=3Daes)
>> +lazy_refcounts=3Dbool (on/off) - Postpone refcount updates
>> +nocow=3Dbool (on/off) - Turn off copy-on-write (valid only on btrfs)
>> +preallocation=3Dstr - Preallocation mode (allowed values: off, metada=
ta, falloc, full)
>> +refcount_bits=3Dnum - Width of a reference count entry in bits
>> +size=3Dsize - Virtual disk size
>> =20
>>  Testing: create -f qcow2 -o cluster_size=3D4k,help TEST_DIR/t.qcow2 1=
28M
>>  Supported options:
>> -size             Virtual disk size
>> -compat           Compatibility level (0.10 or 1.1)
>> -backing_file     File name of a base image
>> -backing_fmt      Image format of the base image
>> -encryption       Encrypt the image with format 'aes'. (Deprecated in =
favor of encrypt.format=3Daes)
>> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
>> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passph=
rase
>> -encrypt.cipher-alg Name of encryption cipher algorithm
>> -encrypt.cipher-mode Name of encryption cipher mode
>> -encrypt.ivgen-alg Name of IV generator algorithm
>> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
>> -encrypt.hash-alg Name of encryption hash algorithm
>> -encrypt.iter-time Time to spend in PBKDF in milliseconds
>> -cluster_size     qcow2 cluster size
>> -preallocation    Preallocation mode (allowed values: off, metadata, f=
alloc, full)
>> -lazy_refcounts   Postpone refcount updates
>> -refcount_bits    Width of a reference count entry in bits
>> -nocow            Turn off copy-on-write (valid only on btrfs)
>> +backing_file=3Dstr - File name of a base image
>> +backing_fmt=3Dstr - Image format of the base image
>> +cluster_size=3Dsize - qcow2 cluster size
>> +compat=3Dstr - Compatibility level (0.10 or 1.1)
>> +encrypt.cipher-alg=3Dstr - Name of encryption cipher algorithm
>> +encrypt.cipher-mode=3Dstr - Name of encryption cipher mode
>> +encrypt.format=3Dstr - Encrypt the image, format choices: 'aes', 'luk=
s'
>> +encrypt.hash-alg=3Dstr - Name of encryption hash algorithm
>> +encrypt.iter-time=3Dnum - Time to spend in PBKDF in milliseconds
>> +encrypt.ivgen-alg=3Dstr - Name of IV generator algorithm
>> +encrypt.ivgen-hash-alg=3Dstr - Name of IV generator hash algorithm
>> +encrypt.key-secret=3Dstr - ID of secret providing qcow AES key or LUK=
S passphrase
>> +encryption=3Dbool (on/off) - Encrypt the image with format 'aes'. (De=
precated in favor of encrypt.format=3Daes)
>> +lazy_refcounts=3Dbool (on/off) - Postpone refcount updates
>> +nocow=3Dbool (on/off) - Turn off copy-on-write (valid only on btrfs)
>> +preallocation=3Dstr - Preallocation mode (allowed values: off, metada=
ta, falloc, full)
>> +refcount_bits=3Dnum - Width of a reference count entry in bits
>> +size=3Dsize - Virtual disk size
>> =20
>>  Testing: create -f qcow2 -o cluster_size=3D4k,? TEST_DIR/t.qcow2 128M=

>>  Supported options:
>> -size             Virtual disk size
>> -compat           Compatibility level (0.10 or 1.1)
>> -backing_file     File name of a base image
>> -backing_fmt      Image format of the base image
>> -encryption       Encrypt the image with format 'aes'. (Deprecated in =
favor of encrypt.format=3Daes)
>> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
>> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passph=
rase
>> -encrypt.cipher-alg Name of encryption cipher algorithm
>> -encrypt.cipher-mode Name of encryption cipher mode
>> -encrypt.ivgen-alg Name of IV generator algorithm
>> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
>> -encrypt.hash-alg Name of encryption hash algorithm
>> -encrypt.iter-time Time to spend in PBKDF in milliseconds
>> -cluster_size     qcow2 cluster size
>> -preallocation    Preallocation mode (allowed values: off, metadata, f=
alloc, full)
>> -lazy_refcounts   Postpone refcount updates
>> -refcount_bits    Width of a reference count entry in bits
>> -nocow            Turn off copy-on-write (valid only on btrfs)
>> +backing_file=3Dstr - File name of a base image
>> +backing_fmt=3Dstr - Image format of the base image
>> +cluster_size=3Dsize - qcow2 cluster size
>> +compat=3Dstr - Compatibility level (0.10 or 1.1)
>> +encrypt.cipher-alg=3Dstr - Name of encryption cipher algorithm
>> +encrypt.cipher-mode=3Dstr - Name of encryption cipher mode
>> +encrypt.format=3Dstr - Encrypt the image, format choices: 'aes', 'luk=
s'
>> +encrypt.hash-alg=3Dstr - Name of encryption hash algorithm
>> +encrypt.iter-time=3Dnum - Time to spend in PBKDF in milliseconds
>> +encrypt.ivgen-alg=3Dstr - Name of IV generator algorithm
>> +encrypt.ivgen-hash-alg=3Dstr - Name of IV generator hash algorithm
>> +encrypt.key-secret=3Dstr - ID of secret providing qcow AES key or LUK=
S passphrase
>> +encryption=3Dbool (on/off) - Encrypt the image with format 'aes'. (De=
precated in favor of encrypt.format=3Daes)
>> +lazy_refcounts=3Dbool (on/off) - Postpone refcount updates
>> +nocow=3Dbool (on/off) - Turn off copy-on-write (valid only on btrfs)
>> +preallocation=3Dstr - Preallocation mode (allowed values: off, metada=
ta, falloc, full)
>> +refcount_bits=3Dnum - Width of a reference count entry in bits
>> +size=3Dsize - Virtual disk size
>> =20
>>  Testing: create -f qcow2 -o help,cluster_size=3D4k TEST_DIR/t.qcow2 1=
28M
>>  Supported options:
>> -size             Virtual disk size
>> -compat           Compatibility level (0.10 or 1.1)
>> -backing_file     File name of a base image
>> -backing_fmt      Image format of the base image
>> -encryption       Encrypt the image with format 'aes'. (Deprecated in =
favor of encrypt.format=3Daes)
>> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
>> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passph=
rase
>> -encrypt.cipher-alg Name of encryption cipher algorithm
>> -encrypt.cipher-mode Name of encryption cipher mode
>> -encrypt.ivgen-alg Name of IV generator algorithm
>> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
>> -encrypt.hash-alg Name of encryption hash algorithm
>> -encrypt.iter-time Time to spend in PBKDF in milliseconds
>> -cluster_size     qcow2 cluster size
>> -preallocation    Preallocation mode (allowed values: off, metadata, f=
alloc, full)
>> -lazy_refcounts   Postpone refcount updates
>> -refcount_bits    Width of a reference count entry in bits
>> -nocow            Turn off copy-on-write (valid only on btrfs)
>> +backing_file=3Dstr - File name of a base image
>> +backing_fmt=3Dstr - Image format of the base image
>> +cluster_size=3Dsize - qcow2 cluster size
>> +compat=3Dstr - Compatibility level (0.10 or 1.1)
>> +encrypt.cipher-alg=3Dstr - Name of encryption cipher algorithm
>> +encrypt.cipher-mode=3Dstr - Name of encryption cipher mode
>> +encrypt.format=3Dstr - Encrypt the image, format choices: 'aes', 'luk=
s'
>> +encrypt.hash-alg=3Dstr - Name of encryption hash algorithm
>> +encrypt.iter-time=3Dnum - Time to spend in PBKDF in milliseconds
>> +encrypt.ivgen-alg=3Dstr - Name of IV generator algorithm
>> +encrypt.ivgen-hash-alg=3Dstr - Name of IV generator hash algorithm
>> +encrypt.key-secret=3Dstr - ID of secret providing qcow AES key or LUK=
S passphrase
>> +encryption=3Dbool (on/off) - Encrypt the image with format 'aes'. (De=
precated in favor of encrypt.format=3Daes)
>> +lazy_refcounts=3Dbool (on/off) - Postpone refcount updates
>> +nocow=3Dbool (on/off) - Turn off copy-on-write (valid only on btrfs)
>> +preallocation=3Dstr - Preallocation mode (allowed values: off, metada=
ta, falloc, full)
>> +refcount_bits=3Dnum - Width of a reference count entry in bits
>> +size=3Dsize - Virtual disk size
>> =20
>>  Testing: create -f qcow2 -o ?,cluster_size=3D4k TEST_DIR/t.qcow2 128M=

>>  Supported options:
>> -size             Virtual disk size
>> -compat           Compatibility level (0.10 or 1.1)
>> -backing_file     File name of a base image
>> -backing_fmt      Image format of the base image
>> -encryption       Encrypt the image with format 'aes'. (Deprecated in =
favor of encrypt.format=3Daes)
>> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
>> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passph=
rase
>> -encrypt.cipher-alg Name of encryption cipher algorithm
>> -encrypt.cipher-mode Name of encryption cipher mode
>> -encrypt.ivgen-alg Name of IV generator algorithm
>> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
>> -encrypt.hash-alg Name of encryption hash algorithm
>> -encrypt.iter-time Time to spend in PBKDF in milliseconds
>> -cluster_size     qcow2 cluster size
>> -preallocation    Preallocation mode (allowed values: off, metadata, f=
alloc, full)
>> -lazy_refcounts   Postpone refcount updates
>> -refcount_bits    Width of a reference count entry in bits
>> -nocow            Turn off copy-on-write (valid only on btrfs)
>> +backing_file=3Dstr - File name of a base image
>> +backing_fmt=3Dstr - Image format of the base image
>> +cluster_size=3Dsize - qcow2 cluster size
>> +compat=3Dstr - Compatibility level (0.10 or 1.1)
>> +encrypt.cipher-alg=3Dstr - Name of encryption cipher algorithm
>> +encrypt.cipher-mode=3Dstr - Name of encryption cipher mode
>> +encrypt.format=3Dstr - Encrypt the image, format choices: 'aes', 'luk=
s'
>> +encrypt.hash-alg=3Dstr - Name of encryption hash algorithm
>> +encrypt.iter-time=3Dnum - Time to spend in PBKDF in milliseconds
>> +encrypt.ivgen-alg=3Dstr - Name of IV generator algorithm
>> +encrypt.ivgen-hash-alg=3Dstr - Name of IV generator hash algorithm
>> +encrypt.key-secret=3Dstr - ID of secret providing qcow AES key or LUK=
S passphrase
>> +encryption=3Dbool (on/off) - Encrypt the image with format 'aes'. (De=
precated in favor of encrypt.format=3Daes)
>> +lazy_refcounts=3Dbool (on/off) - Postpone refcount updates
>> +nocow=3Dbool (on/off) - Turn off copy-on-write (valid only on btrfs)
>> +preallocation=3Dstr - Preallocation mode (allowed values: off, metada=
ta, falloc, full)
>> +refcount_bits=3Dnum - Width of a reference count entry in bits
>> +size=3Dsize - Virtual disk size
>> =20
>>  Testing: create -f qcow2 -o cluster_size=3D4k -o help TEST_DIR/t.qcow=
2 128M
>>  Supported options:
>> -size             Virtual disk size
>> -compat           Compatibility level (0.10 or 1.1)
>> -backing_file     File name of a base image
>> -backing_fmt      Image format of the base image
>> -encryption       Encrypt the image with format 'aes'. (Deprecated in =
favor of encrypt.format=3Daes)
>> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
>> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passph=
rase
>> -encrypt.cipher-alg Name of encryption cipher algorithm
>> -encrypt.cipher-mode Name of encryption cipher mode
>> -encrypt.ivgen-alg Name of IV generator algorithm
>> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
>> -encrypt.hash-alg Name of encryption hash algorithm
>> -encrypt.iter-time Time to spend in PBKDF in milliseconds
>> -cluster_size     qcow2 cluster size
>> -preallocation    Preallocation mode (allowed values: off, metadata, f=
alloc, full)
>> -lazy_refcounts   Postpone refcount updates
>> -refcount_bits    Width of a reference count entry in bits
>> -nocow            Turn off copy-on-write (valid only on btrfs)
>> +backing_file=3Dstr - File name of a base image
>> +backing_fmt=3Dstr - Image format of the base image
>> +cluster_size=3Dsize - qcow2 cluster size
>> +compat=3Dstr - Compatibility level (0.10 or 1.1)
>> +encrypt.cipher-alg=3Dstr - Name of encryption cipher algorithm
>> +encrypt.cipher-mode=3Dstr - Name of encryption cipher mode
>> +encrypt.format=3Dstr - Encrypt the image, format choices: 'aes', 'luk=
s'
>> +encrypt.hash-alg=3Dstr - Name of encryption hash algorithm
>> +encrypt.iter-time=3Dnum - Time to spend in PBKDF in milliseconds
>> +encrypt.ivgen-alg=3Dstr - Name of IV generator algorithm
>> +encrypt.ivgen-hash-alg=3Dstr - Name of IV generator hash algorithm
>> +encrypt.key-secret=3Dstr - ID of secret providing qcow AES key or LUK=
S passphrase
>> +encryption=3Dbool (on/off) - Encrypt the image with format 'aes'. (De=
precated in favor of encrypt.format=3Daes)
>> +lazy_refcounts=3Dbool (on/off) - Postpone refcount updates
>> +nocow=3Dbool (on/off) - Turn off copy-on-write (valid only on btrfs)
>> +preallocation=3Dstr - Preallocation mode (allowed values: off, metada=
ta, falloc, full)
>> +refcount_bits=3Dnum - Width of a reference count entry in bits
>> +size=3Dsize - Virtual disk size
>> =20
>>  Testing: create -f qcow2 -o cluster_size=3D4k -o ? TEST_DIR/t.qcow2 1=
28M
>>  Supported options:
>> -size             Virtual disk size
>> -compat           Compatibility level (0.10 or 1.1)
>> -backing_file     File name of a base image
>> -backing_fmt      Image format of the base image
>> -encryption       Encrypt the image with format 'aes'. (Deprecated in =
favor of encrypt.format=3Daes)
>> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
>> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passph=
rase
>> -encrypt.cipher-alg Name of encryption cipher algorithm
>> -encrypt.cipher-mode Name of encryption cipher mode
>> -encrypt.ivgen-alg Name of IV generator algorithm
>> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
>> -encrypt.hash-alg Name of encryption hash algorithm
>> -encrypt.iter-time Time to spend in PBKDF in milliseconds
>> -cluster_size     qcow2 cluster size
>> -preallocation    Preallocation mode (allowed values: off, metadata, f=
alloc, full)
>> -lazy_refcounts   Postpone refcount updates
>> -refcount_bits    Width of a reference count entry in bits
>> -nocow            Turn off copy-on-write (valid only on btrfs)
>> +backing_file=3Dstr - File name of a base image
>> +backing_fmt=3Dstr - Image format of the base image
>> +cluster_size=3Dsize - qcow2 cluster size
>> +compat=3Dstr - Compatibility level (0.10 or 1.1)
>> +encrypt.cipher-alg=3Dstr - Name of encryption cipher algorithm
>> +encrypt.cipher-mode=3Dstr - Name of encryption cipher mode
>> +encrypt.format=3Dstr - Encrypt the image, format choices: 'aes', 'luk=
s'
>> +encrypt.hash-alg=3Dstr - Name of encryption hash algorithm
>> +encrypt.iter-time=3Dnum - Time to spend in PBKDF in milliseconds
>> +encrypt.ivgen-alg=3Dstr - Name of IV generator algorithm
>> +encrypt.ivgen-hash-alg=3Dstr - Name of IV generator hash algorithm
>> +encrypt.key-secret=3Dstr - ID of secret providing qcow AES key or LUK=
S passphrase
>> +encryption=3Dbool (on/off) - Encrypt the image with format 'aes'. (De=
precated in favor of encrypt.format=3Daes)
>> +lazy_refcounts=3Dbool (on/off) - Postpone refcount updates
>> +nocow=3Dbool (on/off) - Turn off copy-on-write (valid only on btrfs)
>> +preallocation=3Dstr - Preallocation mode (allowed values: off, metada=
ta, falloc, full)
>> +refcount_bits=3Dnum - Width of a reference count entry in bits
>> +size=3Dsize - Virtual disk size
>> =20
>>  Testing: create -f qcow2 -u -o backing_file=3DTEST_DIR/t.qcow2,,help =
TEST_DIR/t.qcow2 128M
>>  Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D134217728 backing_f=
ile=3DTEST_DIR/t.qcow2,,help cluster_size=3D65536 lazy_refcounts=3Doff re=
fcount_bits=3D16
>> @@ -227,27 +227,27 @@ qemu-img: Invalid option list: ,,
>> =20
>>  Testing: create -f qcow2 -o help
>>  Supported options:
>> -size             Virtual disk size
>> -compat           Compatibility level (0.10 or 1.1)
>> -backing_file     File name of a base image
>> -backing_fmt      Image format of the base image
>> -encryption       Encrypt the image with format 'aes'. (Deprecated in =
favor of encrypt.format=3Daes)
>> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
>> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passph=
rase
>> -encrypt.cipher-alg Name of encryption cipher algorithm
>> -encrypt.cipher-mode Name of encryption cipher mode
>> -encrypt.ivgen-alg Name of IV generator algorithm
>> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
>> -encrypt.hash-alg Name of encryption hash algorithm
>> -encrypt.iter-time Time to spend in PBKDF in milliseconds
>> -cluster_size     qcow2 cluster size
>> -preallocation    Preallocation mode (allowed values: off, metadata, f=
alloc, full)
>> -lazy_refcounts   Postpone refcount updates
>> -refcount_bits    Width of a reference count entry in bits
>> +backing_file=3Dstr - File name of a base image
>> +backing_fmt=3Dstr - Image format of the base image
>> +cluster_size=3Dsize - qcow2 cluster size
>> +compat=3Dstr - Compatibility level (0.10 or 1.1)
>> +encrypt.cipher-alg=3Dstr - Name of encryption cipher algorithm
>> +encrypt.cipher-mode=3Dstr - Name of encryption cipher mode
>> +encrypt.format=3Dstr - Encrypt the image, format choices: 'aes', 'luk=
s'
>> +encrypt.hash-alg=3Dstr - Name of encryption hash algorithm
>> +encrypt.iter-time=3Dnum - Time to spend in PBKDF in milliseconds
>> +encrypt.ivgen-alg=3Dstr - Name of IV generator algorithm
>> +encrypt.ivgen-hash-alg=3Dstr - Name of IV generator hash algorithm
>> +encrypt.key-secret=3Dstr - ID of secret providing qcow AES key or LUK=
S passphrase
>> +encryption=3Dbool (on/off) - Encrypt the image with format 'aes'. (De=
precated in favor of encrypt.format=3Daes)
>> +lazy_refcounts=3Dbool (on/off) - Postpone refcount updates
>> +preallocation=3Dstr - Preallocation mode (allowed values: off, metada=
ta, falloc, full)
>> +refcount_bits=3Dnum - Width of a reference count entry in bits
>> +size=3Dsize - Virtual disk size
>> =20
>>  Testing: create -o help
>>  Supported options:
>> -size             Virtual disk size
>> +size=3Dsize - Virtual disk size
>> =20
>>  Testing: create -f bochs -o help
>>  qemu-img: Format driver 'bochs' does not support image creation
>> @@ -300,171 +300,171 @@ cluster_size: 8192
>> =20
>>  Testing: convert -O qcow2 -o help TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.b=
ase
>>  Supported options:
>> -size             Virtual disk size
>> -compat           Compatibility level (0.10 or 1.1)
>> -backing_file     File name of a base image
>> -backing_fmt      Image format of the base image
>> -encryption       Encrypt the image with format 'aes'. (Deprecated in =
favor of encrypt.format=3Daes)
>> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
>> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passph=
rase
>> -encrypt.cipher-alg Name of encryption cipher algorithm
>> -encrypt.cipher-mode Name of encryption cipher mode
>> -encrypt.ivgen-alg Name of IV generator algorithm
>> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
>> -encrypt.hash-alg Name of encryption hash algorithm
>> -encrypt.iter-time Time to spend in PBKDF in milliseconds
>> -cluster_size     qcow2 cluster size
>> -preallocation    Preallocation mode (allowed values: off, metadata, f=
alloc, full)
>> -lazy_refcounts   Postpone refcount updates
>> -refcount_bits    Width of a reference count entry in bits
>> -nocow            Turn off copy-on-write (valid only on btrfs)
>> +backing_file=3Dstr - File name of a base image
>> +backing_fmt=3Dstr - Image format of the base image
>> +cluster_size=3Dsize - qcow2 cluster size
>> +compat=3Dstr - Compatibility level (0.10 or 1.1)
>> +encrypt.cipher-alg=3Dstr - Name of encryption cipher algorithm
>> +encrypt.cipher-mode=3Dstr - Name of encryption cipher mode
>> +encrypt.format=3Dstr - Encrypt the image, format choices: 'aes', 'luk=
s'
>> +encrypt.hash-alg=3Dstr - Name of encryption hash algorithm
>> +encrypt.iter-time=3Dnum - Time to spend in PBKDF in milliseconds
>> +encrypt.ivgen-alg=3Dstr - Name of IV generator algorithm
>> +encrypt.ivgen-hash-alg=3Dstr - Name of IV generator hash algorithm
>> +encrypt.key-secret=3Dstr - ID of secret providing qcow AES key or LUK=
S passphrase
>> +encryption=3Dbool (on/off) - Encrypt the image with format 'aes'. (De=
precated in favor of encrypt.format=3Daes)
>> +lazy_refcounts=3Dbool (on/off) - Postpone refcount updates
>> +nocow=3Dbool (on/off) - Turn off copy-on-write (valid only on btrfs)
>> +preallocation=3Dstr - Preallocation mode (allowed values: off, metada=
ta, falloc, full)
>> +refcount_bits=3Dnum - Width of a reference count entry in bits
>> +size=3Dsize - Virtual disk size
>> =20
>>  Testing: convert -O qcow2 -o ? TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base=

>>  Supported options:
>> -size             Virtual disk size
>> -compat           Compatibility level (0.10 or 1.1)
>> -backing_file     File name of a base image
>> -backing_fmt      Image format of the base image
>> -encryption       Encrypt the image with format 'aes'. (Deprecated in =
favor of encrypt.format=3Daes)
>> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
>> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passph=
rase
>> -encrypt.cipher-alg Name of encryption cipher algorithm
>> -encrypt.cipher-mode Name of encryption cipher mode
>> -encrypt.ivgen-alg Name of IV generator algorithm
>> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
>> -encrypt.hash-alg Name of encryption hash algorithm
>> -encrypt.iter-time Time to spend in PBKDF in milliseconds
>> -cluster_size     qcow2 cluster size
>> -preallocation    Preallocation mode (allowed values: off, metadata, f=
alloc, full)
>> -lazy_refcounts   Postpone refcount updates
>> -refcount_bits    Width of a reference count entry in bits
>> -nocow            Turn off copy-on-write (valid only on btrfs)
>> +backing_file=3Dstr - File name of a base image
>> +backing_fmt=3Dstr - Image format of the base image
>> +cluster_size=3Dsize - qcow2 cluster size
>> +compat=3Dstr - Compatibility level (0.10 or 1.1)
>> +encrypt.cipher-alg=3Dstr - Name of encryption cipher algorithm
>> +encrypt.cipher-mode=3Dstr - Name of encryption cipher mode
>> +encrypt.format=3Dstr - Encrypt the image, format choices: 'aes', 'luk=
s'
>> +encrypt.hash-alg=3Dstr - Name of encryption hash algorithm
>> +encrypt.iter-time=3Dnum - Time to spend in PBKDF in milliseconds
>> +encrypt.ivgen-alg=3Dstr - Name of IV generator algorithm
>> +encrypt.ivgen-hash-alg=3Dstr - Name of IV generator hash algorithm
>> +encrypt.key-secret=3Dstr - ID of secret providing qcow AES key or LUK=
S passphrase
>> +encryption=3Dbool (on/off) - Encrypt the image with format 'aes'. (De=
precated in favor of encrypt.format=3Daes)
>> +lazy_refcounts=3Dbool (on/off) - Postpone refcount updates
>> +nocow=3Dbool (on/off) - Turn off copy-on-write (valid only on btrfs)
>> +preallocation=3Dstr - Preallocation mode (allowed values: off, metada=
ta, falloc, full)
>> +refcount_bits=3Dnum - Width of a reference count entry in bits
>> +size=3Dsize - Virtual disk size
>> =20
>>  Testing: convert -O qcow2 -o cluster_size=3D4k,help TEST_DIR/t.qcow2 =
TEST_DIR/t.qcow2.base
>>  Supported options:
>> -size             Virtual disk size
>> -compat           Compatibility level (0.10 or 1.1)
>> -backing_file     File name of a base image
>> -backing_fmt      Image format of the base image
>> -encryption       Encrypt the image with format 'aes'. (Deprecated in =
favor of encrypt.format=3Daes)
>> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
>> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passph=
rase
>> -encrypt.cipher-alg Name of encryption cipher algorithm
>> -encrypt.cipher-mode Name of encryption cipher mode
>> -encrypt.ivgen-alg Name of IV generator algorithm
>> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
>> -encrypt.hash-alg Name of encryption hash algorithm
>> -encrypt.iter-time Time to spend in PBKDF in milliseconds
>> -cluster_size     qcow2 cluster size
>> -preallocation    Preallocation mode (allowed values: off, metadata, f=
alloc, full)
>> -lazy_refcounts   Postpone refcount updates
>> -refcount_bits    Width of a reference count entry in bits
>> -nocow            Turn off copy-on-write (valid only on btrfs)
>> +backing_file=3Dstr - File name of a base image
>> +backing_fmt=3Dstr - Image format of the base image
>> +cluster_size=3Dsize - qcow2 cluster size
>> +compat=3Dstr - Compatibility level (0.10 or 1.1)
>> +encrypt.cipher-alg=3Dstr - Name of encryption cipher algorithm
>> +encrypt.cipher-mode=3Dstr - Name of encryption cipher mode
>> +encrypt.format=3Dstr - Encrypt the image, format choices: 'aes', 'luk=
s'
>> +encrypt.hash-alg=3Dstr - Name of encryption hash algorithm
>> +encrypt.iter-time=3Dnum - Time to spend in PBKDF in milliseconds
>> +encrypt.ivgen-alg=3Dstr - Name of IV generator algorithm
>> +encrypt.ivgen-hash-alg=3Dstr - Name of IV generator hash algorithm
>> +encrypt.key-secret=3Dstr - ID of secret providing qcow AES key or LUK=
S passphrase
>> +encryption=3Dbool (on/off) - Encrypt the image with format 'aes'. (De=
precated in favor of encrypt.format=3Daes)
>> +lazy_refcounts=3Dbool (on/off) - Postpone refcount updates
>> +nocow=3Dbool (on/off) - Turn off copy-on-write (valid only on btrfs)
>> +preallocation=3Dstr - Preallocation mode (allowed values: off, metada=
ta, falloc, full)
>> +refcount_bits=3Dnum - Width of a reference count entry in bits
>> +size=3Dsize - Virtual disk size
>> =20
>>  Testing: convert -O qcow2 -o cluster_size=3D4k,? TEST_DIR/t.qcow2 TES=
T_DIR/t.qcow2.base
>>  Supported options:
>> -size             Virtual disk size
>> -compat           Compatibility level (0.10 or 1.1)
>> -backing_file     File name of a base image
>> -backing_fmt      Image format of the base image
>> -encryption       Encrypt the image with format 'aes'. (Deprecated in =
favor of encrypt.format=3Daes)
>> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
>> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passph=
rase
>> -encrypt.cipher-alg Name of encryption cipher algorithm
>> -encrypt.cipher-mode Name of encryption cipher mode
>> -encrypt.ivgen-alg Name of IV generator algorithm
>> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
>> -encrypt.hash-alg Name of encryption hash algorithm
>> -encrypt.iter-time Time to spend in PBKDF in milliseconds
>> -cluster_size     qcow2 cluster size
>> -preallocation    Preallocation mode (allowed values: off, metadata, f=
alloc, full)
>> -lazy_refcounts   Postpone refcount updates
>> -refcount_bits    Width of a reference count entry in bits
>> -nocow            Turn off copy-on-write (valid only on btrfs)
>> +backing_file=3Dstr - File name of a base image
>> +backing_fmt=3Dstr - Image format of the base image
>> +cluster_size=3Dsize - qcow2 cluster size
>> +compat=3Dstr - Compatibility level (0.10 or 1.1)
>> +encrypt.cipher-alg=3Dstr - Name of encryption cipher algorithm
>> +encrypt.cipher-mode=3Dstr - Name of encryption cipher mode
>> +encrypt.format=3Dstr - Encrypt the image, format choices: 'aes', 'luk=
s'
>> +encrypt.hash-alg=3Dstr - Name of encryption hash algorithm
>> +encrypt.iter-time=3Dnum - Time to spend in PBKDF in milliseconds
>> +encrypt.ivgen-alg=3Dstr - Name of IV generator algorithm
>> +encrypt.ivgen-hash-alg=3Dstr - Name of IV generator hash algorithm
>> +encrypt.key-secret=3Dstr - ID of secret providing qcow AES key or LUK=
S passphrase
>> +encryption=3Dbool (on/off) - Encrypt the image with format 'aes'. (De=
precated in favor of encrypt.format=3Daes)
>> +lazy_refcounts=3Dbool (on/off) - Postpone refcount updates
>> +nocow=3Dbool (on/off) - Turn off copy-on-write (valid only on btrfs)
>> +preallocation=3Dstr - Preallocation mode (allowed values: off, metada=
ta, falloc, full)
>> +refcount_bits=3Dnum - Width of a reference count entry in bits
>> +size=3Dsize - Virtual disk size
>> =20
>>  Testing: convert -O qcow2 -o help,cluster_size=3D4k TEST_DIR/t.qcow2 =
TEST_DIR/t.qcow2.base
>>  Supported options:
>> -size             Virtual disk size
>> -compat           Compatibility level (0.10 or 1.1)
>> -backing_file     File name of a base image
>> -backing_fmt      Image format of the base image
>> -encryption       Encrypt the image with format 'aes'. (Deprecated in =
favor of encrypt.format=3Daes)
>> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
>> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passph=
rase
>> -encrypt.cipher-alg Name of encryption cipher algorithm
>> -encrypt.cipher-mode Name of encryption cipher mode
>> -encrypt.ivgen-alg Name of IV generator algorithm
>> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
>> -encrypt.hash-alg Name of encryption hash algorithm
>> -encrypt.iter-time Time to spend in PBKDF in milliseconds
>> -cluster_size     qcow2 cluster size
>> -preallocation    Preallocation mode (allowed values: off, metadata, f=
alloc, full)
>> -lazy_refcounts   Postpone refcount updates
>> -refcount_bits    Width of a reference count entry in bits
>> -nocow            Turn off copy-on-write (valid only on btrfs)
>> +backing_file=3Dstr - File name of a base image
>> +backing_fmt=3Dstr - Image format of the base image
>> +cluster_size=3Dsize - qcow2 cluster size
>> +compat=3Dstr - Compatibility level (0.10 or 1.1)
>> +encrypt.cipher-alg=3Dstr - Name of encryption cipher algorithm
>> +encrypt.cipher-mode=3Dstr - Name of encryption cipher mode
>> +encrypt.format=3Dstr - Encrypt the image, format choices: 'aes', 'luk=
s'
>> +encrypt.hash-alg=3Dstr - Name of encryption hash algorithm
>> +encrypt.iter-time=3Dnum - Time to spend in PBKDF in milliseconds
>> +encrypt.ivgen-alg=3Dstr - Name of IV generator algorithm
>> +encrypt.ivgen-hash-alg=3Dstr - Name of IV generator hash algorithm
>> +encrypt.key-secret=3Dstr - ID of secret providing qcow AES key or LUK=
S passphrase
>> +encryption=3Dbool (on/off) - Encrypt the image with format 'aes'. (De=
precated in favor of encrypt.format=3Daes)
>> +lazy_refcounts=3Dbool (on/off) - Postpone refcount updates
>> +nocow=3Dbool (on/off) - Turn off copy-on-write (valid only on btrfs)
>> +preallocation=3Dstr - Preallocation mode (allowed values: off, metada=
ta, falloc, full)
>> +refcount_bits=3Dnum - Width of a reference count entry in bits
>> +size=3Dsize - Virtual disk size
>> =20
>>  Testing: convert -O qcow2 -o ?,cluster_size=3D4k TEST_DIR/t.qcow2 TES=
T_DIR/t.qcow2.base
>>  Supported options:
>> -size             Virtual disk size
>> -compat           Compatibility level (0.10 or 1.1)
>> -backing_file     File name of a base image
>> -backing_fmt      Image format of the base image
>> -encryption       Encrypt the image with format 'aes'. (Deprecated in =
favor of encrypt.format=3Daes)
>> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
>> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passph=
rase
>> -encrypt.cipher-alg Name of encryption cipher algorithm
>> -encrypt.cipher-mode Name of encryption cipher mode
>> -encrypt.ivgen-alg Name of IV generator algorithm
>> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
>> -encrypt.hash-alg Name of encryption hash algorithm
>> -encrypt.iter-time Time to spend in PBKDF in milliseconds
>> -cluster_size     qcow2 cluster size
>> -preallocation    Preallocation mode (allowed values: off, metadata, f=
alloc, full)
>> -lazy_refcounts   Postpone refcount updates
>> -refcount_bits    Width of a reference count entry in bits
>> -nocow            Turn off copy-on-write (valid only on btrfs)
>> +backing_file=3Dstr - File name of a base image
>> +backing_fmt=3Dstr - Image format of the base image
>> +cluster_size=3Dsize - qcow2 cluster size
>> +compat=3Dstr - Compatibility level (0.10 or 1.1)
>> +encrypt.cipher-alg=3Dstr - Name of encryption cipher algorithm
>> +encrypt.cipher-mode=3Dstr - Name of encryption cipher mode
>> +encrypt.format=3Dstr - Encrypt the image, format choices: 'aes', 'luk=
s'
>> +encrypt.hash-alg=3Dstr - Name of encryption hash algorithm
>> +encrypt.iter-time=3Dnum - Time to spend in PBKDF in milliseconds
>> +encrypt.ivgen-alg=3Dstr - Name of IV generator algorithm
>> +encrypt.ivgen-hash-alg=3Dstr - Name of IV generator hash algorithm
>> +encrypt.key-secret=3Dstr - ID of secret providing qcow AES key or LUK=
S passphrase
>> +encryption=3Dbool (on/off) - Encrypt the image with format 'aes'. (De=
precated in favor of encrypt.format=3Daes)
>> +lazy_refcounts=3Dbool (on/off) - Postpone refcount updates
>> +nocow=3Dbool (on/off) - Turn off copy-on-write (valid only on btrfs)
>> +preallocation=3Dstr - Preallocation mode (allowed values: off, metada=
ta, falloc, full)
>> +refcount_bits=3Dnum - Width of a reference count entry in bits
>> +size=3Dsize - Virtual disk size
>> =20
>>  Testing: convert -O qcow2 -o cluster_size=3D4k -o help TEST_DIR/t.qco=
w2 TEST_DIR/t.qcow2.base
>>  Supported options:
>> -size             Virtual disk size
>> -compat           Compatibility level (0.10 or 1.1)
>> -backing_file     File name of a base image
>> -backing_fmt      Image format of the base image
>> -encryption       Encrypt the image with format 'aes'. (Deprecated in =
favor of encrypt.format=3Daes)
>> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
>> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passph=
rase
>> -encrypt.cipher-alg Name of encryption cipher algorithm
>> -encrypt.cipher-mode Name of encryption cipher mode
>> -encrypt.ivgen-alg Name of IV generator algorithm
>> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
>> -encrypt.hash-alg Name of encryption hash algorithm
>> -encrypt.iter-time Time to spend in PBKDF in milliseconds
>> -cluster_size     qcow2 cluster size
>> -preallocation    Preallocation mode (allowed values: off, metadata, f=
alloc, full)
>> -lazy_refcounts   Postpone refcount updates
>> -refcount_bits    Width of a reference count entry in bits
>> -nocow            Turn off copy-on-write (valid only on btrfs)
>> +backing_file=3Dstr - File name of a base image
>> +backing_fmt=3Dstr - Image format of the base image
>> +cluster_size=3Dsize - qcow2 cluster size
>> +compat=3Dstr - Compatibility level (0.10 or 1.1)
>> +encrypt.cipher-alg=3Dstr - Name of encryption cipher algorithm
>> +encrypt.cipher-mode=3Dstr - Name of encryption cipher mode
>> +encrypt.format=3Dstr - Encrypt the image, format choices: 'aes', 'luk=
s'
>> +encrypt.hash-alg=3Dstr - Name of encryption hash algorithm
>> +encrypt.iter-time=3Dnum - Time to spend in PBKDF in milliseconds
>> +encrypt.ivgen-alg=3Dstr - Name of IV generator algorithm
>> +encrypt.ivgen-hash-alg=3Dstr - Name of IV generator hash algorithm
>> +encrypt.key-secret=3Dstr - ID of secret providing qcow AES key or LUK=
S passphrase
>> +encryption=3Dbool (on/off) - Encrypt the image with format 'aes'. (De=
precated in favor of encrypt.format=3Daes)
>> +lazy_refcounts=3Dbool (on/off) - Postpone refcount updates
>> +nocow=3Dbool (on/off) - Turn off copy-on-write (valid only on btrfs)
>> +preallocation=3Dstr - Preallocation mode (allowed values: off, metada=
ta, falloc, full)
>> +refcount_bits=3Dnum - Width of a reference count entry in bits
>> +size=3Dsize - Virtual disk size
>> =20
>>  Testing: convert -O qcow2 -o cluster_size=3D4k -o ? TEST_DIR/t.qcow2 =
TEST_DIR/t.qcow2.base
>>  Supported options:
>> -size             Virtual disk size
>> -compat           Compatibility level (0.10 or 1.1)
>> -backing_file     File name of a base image
>> -backing_fmt      Image format of the base image
>> -encryption       Encrypt the image with format 'aes'. (Deprecated in =
favor of encrypt.format=3Daes)
>> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
>> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passph=
rase
>> -encrypt.cipher-alg Name of encryption cipher algorithm
>> -encrypt.cipher-mode Name of encryption cipher mode
>> -encrypt.ivgen-alg Name of IV generator algorithm
>> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
>> -encrypt.hash-alg Name of encryption hash algorithm
>> -encrypt.iter-time Time to spend in PBKDF in milliseconds
>> -cluster_size     qcow2 cluster size
>> -preallocation    Preallocation mode (allowed values: off, metadata, f=
alloc, full)
>> -lazy_refcounts   Postpone refcount updates
>> -refcount_bits    Width of a reference count entry in bits
>> -nocow            Turn off copy-on-write (valid only on btrfs)
>> +backing_file=3Dstr - File name of a base image
>> +backing_fmt=3Dstr - Image format of the base image
>> +cluster_size=3Dsize - qcow2 cluster size
>> +compat=3Dstr - Compatibility level (0.10 or 1.1)
>> +encrypt.cipher-alg=3Dstr - Name of encryption cipher algorithm
>> +encrypt.cipher-mode=3Dstr - Name of encryption cipher mode
>> +encrypt.format=3Dstr - Encrypt the image, format choices: 'aes', 'luk=
s'
>> +encrypt.hash-alg=3Dstr - Name of encryption hash algorithm
>> +encrypt.iter-time=3Dnum - Time to spend in PBKDF in milliseconds
>> +encrypt.ivgen-alg=3Dstr - Name of IV generator algorithm
>> +encrypt.ivgen-hash-alg=3Dstr - Name of IV generator hash algorithm
>> +encrypt.key-secret=3Dstr - ID of secret providing qcow AES key or LUK=
S passphrase
>> +encryption=3Dbool (on/off) - Encrypt the image with format 'aes'. (De=
precated in favor of encrypt.format=3Daes)
>> +lazy_refcounts=3Dbool (on/off) - Postpone refcount updates
>> +nocow=3Dbool (on/off) - Turn off copy-on-write (valid only on btrfs)
>> +preallocation=3Dstr - Preallocation mode (allowed values: off, metada=
ta, falloc, full)
>> +refcount_bits=3Dnum - Width of a reference count entry in bits
>> +size=3Dsize - Virtual disk size
>> =20
>>  Testing: convert -O qcow2 -o backing_file=3DTEST_DIR/t.qcow2,,help TE=
ST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
>>  qemu-img: Could not open 'TEST_DIR/t.qcow2.base': Could not open back=
ing file: Could not open 'TEST_DIR/t.qcow2,help': No such file or directo=
ry
>> @@ -483,27 +483,27 @@ qemu-img: Invalid option list: ,,
>> =20
>>  Testing: convert -O qcow2 -o help
>>  Supported options:
>> -size             Virtual disk size
>> -compat           Compatibility level (0.10 or 1.1)
>> -backing_file     File name of a base image
>> -backing_fmt      Image format of the base image
>> -encryption       Encrypt the image with format 'aes'. (Deprecated in =
favor of encrypt.format=3Daes)
>> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
>> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passph=
rase
>> -encrypt.cipher-alg Name of encryption cipher algorithm
>> -encrypt.cipher-mode Name of encryption cipher mode
>> -encrypt.ivgen-alg Name of IV generator algorithm
>> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
>> -encrypt.hash-alg Name of encryption hash algorithm
>> -encrypt.iter-time Time to spend in PBKDF in milliseconds
>> -cluster_size     qcow2 cluster size
>> -preallocation    Preallocation mode (allowed values: off, metadata, f=
alloc, full)
>> -lazy_refcounts   Postpone refcount updates
>> -refcount_bits    Width of a reference count entry in bits
>> +backing_file=3Dstr - File name of a base image
>> +backing_fmt=3Dstr - Image format of the base image
>> +cluster_size=3Dsize - qcow2 cluster size
>> +compat=3Dstr - Compatibility level (0.10 or 1.1)
>> +encrypt.cipher-alg=3Dstr - Name of encryption cipher algorithm
>> +encrypt.cipher-mode=3Dstr - Name of encryption cipher mode
>> +encrypt.format=3Dstr - Encrypt the image, format choices: 'aes', 'luk=
s'
>> +encrypt.hash-alg=3Dstr - Name of encryption hash algorithm
>> +encrypt.iter-time=3Dnum - Time to spend in PBKDF in milliseconds
>> +encrypt.ivgen-alg=3Dstr - Name of IV generator algorithm
>> +encrypt.ivgen-hash-alg=3Dstr - Name of IV generator hash algorithm
>> +encrypt.key-secret=3Dstr - ID of secret providing qcow AES key or LUK=
S passphrase
>> +encryption=3Dbool (on/off) - Encrypt the image with format 'aes'. (De=
precated in favor of encrypt.format=3Daes)
>> +lazy_refcounts=3Dbool (on/off) - Postpone refcount updates
>> +preallocation=3Dstr - Preallocation mode (allowed values: off, metada=
ta, falloc, full)
>> +refcount_bits=3Dnum - Width of a reference count entry in bits
>> +size=3Dsize - Virtual disk size
>> =20
>>  Testing: convert -o help
>>  Supported options:
>> -size             Virtual disk size
>> +size=3Dsize - Virtual disk size
>> =20
>>  Testing: convert -O bochs -o help
>>  qemu-img: Format driver 'bochs' does not support image creation
>> @@ -564,177 +564,177 @@ cluster_size: 65536
>> =20
>>  Testing: amend -f qcow2 -o help TEST_DIR/t.qcow2
>>  Creation options for 'qcow2':
>> -size             Virtual disk size
>> -compat           Compatibility level (0.10 or 1.1)
>> -backing_file     File name of a base image
>> -backing_fmt      Image format of the base image
>> -encryption       Encrypt the image with format 'aes'. (Deprecated in =
favor of encrypt.format=3Daes)
>> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
>> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passph=
rase
>> -encrypt.cipher-alg Name of encryption cipher algorithm
>> -encrypt.cipher-mode Name of encryption cipher mode
>> -encrypt.ivgen-alg Name of IV generator algorithm
>> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
>> -encrypt.hash-alg Name of encryption hash algorithm
>> -encrypt.iter-time Time to spend in PBKDF in milliseconds
>> -cluster_size     qcow2 cluster size
>> -preallocation    Preallocation mode (allowed values: off, metadata, f=
alloc, full)
>> -lazy_refcounts   Postpone refcount updates
>> -refcount_bits    Width of a reference count entry in bits
>> +qcow2-create-opts.backing_file=3Dstr - File name of a base image
>> +qcow2-create-opts.backing_fmt=3Dstr - Image format of the base image
>> +qcow2-create-opts.cluster_size=3Dsize - qcow2 cluster size
>> +qcow2-create-opts.compat=3Dstr - Compatibility level (0.10 or 1.1)
>> +qcow2-create-opts.encrypt.cipher-alg=3Dstr - Name of encryption ciphe=
r algorithm
>> +qcow2-create-opts.encrypt.cipher-mode=3Dstr - Name of encryption ciph=
er mode
>> +qcow2-create-opts.encrypt.format=3Dstr - Encrypt the image, format ch=
oices: 'aes', 'luks'
>> +qcow2-create-opts.encrypt.hash-alg=3Dstr - Name of encryption hash al=
gorithm
>> +qcow2-create-opts.encrypt.iter-time=3Dnum - Time to spend in PBKDF in=
 milliseconds
>> +qcow2-create-opts.encrypt.ivgen-alg=3Dstr - Name of IV generator algo=
rithm
>> +qcow2-create-opts.encrypt.ivgen-hash-alg=3Dstr - Name of IV generator=
 hash algorithm
>> +qcow2-create-opts.encrypt.key-secret=3Dstr - ID of secret providing q=
cow AES key or LUKS passphrase
>> +qcow2-create-opts.encryption=3Dbool (on/off) - Encrypt the image with=
 format 'aes'. (Deprecated in favor of encrypt.format=3Daes)
>> +qcow2-create-opts.lazy_refcounts=3Dbool (on/off) - Postpone refcount =
updates
>> +qcow2-create-opts.preallocation=3Dstr - Preallocation mode (allowed v=
alues: off, metadata, falloc, full)
>> +qcow2-create-opts.refcount_bits=3Dnum - Width of a reference count en=
try in bits
>> +qcow2-create-opts.size=3Dsize - Virtual disk size
>> =20
>>  Note that not all of these options may be amendable.
>> =20
>>  Testing: amend -f qcow2 -o ? TEST_DIR/t.qcow2
>>  Creation options for 'qcow2':
>> -size             Virtual disk size
>> -compat           Compatibility level (0.10 or 1.1)
>> -backing_file     File name of a base image
>> -backing_fmt      Image format of the base image
>> -encryption       Encrypt the image with format 'aes'. (Deprecated in =
favor of encrypt.format=3Daes)
>> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
>> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passph=
rase
>> -encrypt.cipher-alg Name of encryption cipher algorithm
>> -encrypt.cipher-mode Name of encryption cipher mode
>> -encrypt.ivgen-alg Name of IV generator algorithm
>> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
>> -encrypt.hash-alg Name of encryption hash algorithm
>> -encrypt.iter-time Time to spend in PBKDF in milliseconds
>> -cluster_size     qcow2 cluster size
>> -preallocation    Preallocation mode (allowed values: off, metadata, f=
alloc, full)
>> -lazy_refcounts   Postpone refcount updates
>> -refcount_bits    Width of a reference count entry in bits
>> +qcow2-create-opts.backing_file=3Dstr - File name of a base image
>> +qcow2-create-opts.backing_fmt=3Dstr - Image format of the base image
>> +qcow2-create-opts.cluster_size=3Dsize - qcow2 cluster size
>> +qcow2-create-opts.compat=3Dstr - Compatibility level (0.10 or 1.1)
>> +qcow2-create-opts.encrypt.cipher-alg=3Dstr - Name of encryption ciphe=
r algorithm
>> +qcow2-create-opts.encrypt.cipher-mode=3Dstr - Name of encryption ciph=
er mode
>> +qcow2-create-opts.encrypt.format=3Dstr - Encrypt the image, format ch=
oices: 'aes', 'luks'
>> +qcow2-create-opts.encrypt.hash-alg=3Dstr - Name of encryption hash al=
gorithm
>> +qcow2-create-opts.encrypt.iter-time=3Dnum - Time to spend in PBKDF in=
 milliseconds
>> +qcow2-create-opts.encrypt.ivgen-alg=3Dstr - Name of IV generator algo=
rithm
>> +qcow2-create-opts.encrypt.ivgen-hash-alg=3Dstr - Name of IV generator=
 hash algorithm
>> +qcow2-create-opts.encrypt.key-secret=3Dstr - ID of secret providing q=
cow AES key or LUKS passphrase
>> +qcow2-create-opts.encryption=3Dbool (on/off) - Encrypt the image with=
 format 'aes'. (Deprecated in favor of encrypt.format=3Daes)
>> +qcow2-create-opts.lazy_refcounts=3Dbool (on/off) - Postpone refcount =
updates
>> +qcow2-create-opts.preallocation=3Dstr - Preallocation mode (allowed v=
alues: off, metadata, falloc, full)
>> +qcow2-create-opts.refcount_bits=3Dnum - Width of a reference count en=
try in bits
>> +qcow2-create-opts.size=3Dsize - Virtual disk size
>> =20
>>  Note that not all of these options may be amendable.
>> =20
>>  Testing: amend -f qcow2 -o cluster_size=3D4k,help TEST_DIR/t.qcow2
>>  Creation options for 'qcow2':
>> -size             Virtual disk size
>> -compat           Compatibility level (0.10 or 1.1)
>> -backing_file     File name of a base image
>> -backing_fmt      Image format of the base image
>> -encryption       Encrypt the image with format 'aes'. (Deprecated in =
favor of encrypt.format=3Daes)
>> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
>> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passph=
rase
>> -encrypt.cipher-alg Name of encryption cipher algorithm
>> -encrypt.cipher-mode Name of encryption cipher mode
>> -encrypt.ivgen-alg Name of IV generator algorithm
>> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
>> -encrypt.hash-alg Name of encryption hash algorithm
>> -encrypt.iter-time Time to spend in PBKDF in milliseconds
>> -cluster_size     qcow2 cluster size
>> -preallocation    Preallocation mode (allowed values: off, metadata, f=
alloc, full)
>> -lazy_refcounts   Postpone refcount updates
>> -refcount_bits    Width of a reference count entry in bits
>> +qcow2-create-opts.backing_file=3Dstr - File name of a base image
>> +qcow2-create-opts.backing_fmt=3Dstr - Image format of the base image
>> +qcow2-create-opts.cluster_size=3Dsize - qcow2 cluster size
>> +qcow2-create-opts.compat=3Dstr - Compatibility level (0.10 or 1.1)
>> +qcow2-create-opts.encrypt.cipher-alg=3Dstr - Name of encryption ciphe=
r algorithm
>> +qcow2-create-opts.encrypt.cipher-mode=3Dstr - Name of encryption ciph=
er mode
>> +qcow2-create-opts.encrypt.format=3Dstr - Encrypt the image, format ch=
oices: 'aes', 'luks'
>> +qcow2-create-opts.encrypt.hash-alg=3Dstr - Name of encryption hash al=
gorithm
>> +qcow2-create-opts.encrypt.iter-time=3Dnum - Time to spend in PBKDF in=
 milliseconds
>> +qcow2-create-opts.encrypt.ivgen-alg=3Dstr - Name of IV generator algo=
rithm
>> +qcow2-create-opts.encrypt.ivgen-hash-alg=3Dstr - Name of IV generator=
 hash algorithm
>> +qcow2-create-opts.encrypt.key-secret=3Dstr - ID of secret providing q=
cow AES key or LUKS passphrase
>> +qcow2-create-opts.encryption=3Dbool (on/off) - Encrypt the image with=
 format 'aes'. (Deprecated in favor of encrypt.format=3Daes)
>> +qcow2-create-opts.lazy_refcounts=3Dbool (on/off) - Postpone refcount =
updates
>> +qcow2-create-opts.preallocation=3Dstr - Preallocation mode (allowed v=
alues: off, metadata, falloc, full)
>> +qcow2-create-opts.refcount_bits=3Dnum - Width of a reference count en=
try in bits
>> +qcow2-create-opts.size=3Dsize - Virtual disk size
>> =20
>>  Note that not all of these options may be amendable.
>> =20
>>  Testing: amend -f qcow2 -o cluster_size=3D4k,? TEST_DIR/t.qcow2
>>  Creation options for 'qcow2':
>> -size             Virtual disk size
>> -compat           Compatibility level (0.10 or 1.1)
>> -backing_file     File name of a base image
>> -backing_fmt      Image format of the base image
>> -encryption       Encrypt the image with format 'aes'. (Deprecated in =
favor of encrypt.format=3Daes)
>> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
>> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passph=
rase
>> -encrypt.cipher-alg Name of encryption cipher algorithm
>> -encrypt.cipher-mode Name of encryption cipher mode
>> -encrypt.ivgen-alg Name of IV generator algorithm
>> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
>> -encrypt.hash-alg Name of encryption hash algorithm
>> -encrypt.iter-time Time to spend in PBKDF in milliseconds
>> -cluster_size     qcow2 cluster size
>> -preallocation    Preallocation mode (allowed values: off, metadata, f=
alloc, full)
>> -lazy_refcounts   Postpone refcount updates
>> -refcount_bits    Width of a reference count entry in bits
>> +qcow2-create-opts.backing_file=3Dstr - File name of a base image
>> +qcow2-create-opts.backing_fmt=3Dstr - Image format of the base image
>> +qcow2-create-opts.cluster_size=3Dsize - qcow2 cluster size
>> +qcow2-create-opts.compat=3Dstr - Compatibility level (0.10 or 1.1)
>> +qcow2-create-opts.encrypt.cipher-alg=3Dstr - Name of encryption ciphe=
r algorithm
>> +qcow2-create-opts.encrypt.cipher-mode=3Dstr - Name of encryption ciph=
er mode
>> +qcow2-create-opts.encrypt.format=3Dstr - Encrypt the image, format ch=
oices: 'aes', 'luks'
>> +qcow2-create-opts.encrypt.hash-alg=3Dstr - Name of encryption hash al=
gorithm
>> +qcow2-create-opts.encrypt.iter-time=3Dnum - Time to spend in PBKDF in=
 milliseconds
>> +qcow2-create-opts.encrypt.ivgen-alg=3Dstr - Name of IV generator algo=
rithm
>> +qcow2-create-opts.encrypt.ivgen-hash-alg=3Dstr - Name of IV generator=
 hash algorithm
>> +qcow2-create-opts.encrypt.key-secret=3Dstr - ID of secret providing q=
cow AES key or LUKS passphrase
>> +qcow2-create-opts.encryption=3Dbool (on/off) - Encrypt the image with=
 format 'aes'. (Deprecated in favor of encrypt.format=3Daes)
>> +qcow2-create-opts.lazy_refcounts=3Dbool (on/off) - Postpone refcount =
updates
>> +qcow2-create-opts.preallocation=3Dstr - Preallocation mode (allowed v=
alues: off, metadata, falloc, full)
>> +qcow2-create-opts.refcount_bits=3Dnum - Width of a reference count en=
try in bits
>> +qcow2-create-opts.size=3Dsize - Virtual disk size
>> =20
>>  Note that not all of these options may be amendable.
>> =20
>>  Testing: amend -f qcow2 -o help,cluster_size=3D4k TEST_DIR/t.qcow2
>>  Creation options for 'qcow2':
>> -size             Virtual disk size
>> -compat           Compatibility level (0.10 or 1.1)
>> -backing_file     File name of a base image
>> -backing_fmt      Image format of the base image
>> -encryption       Encrypt the image with format 'aes'. (Deprecated in =
favor of encrypt.format=3Daes)
>> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
>> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passph=
rase
>> -encrypt.cipher-alg Name of encryption cipher algorithm
>> -encrypt.cipher-mode Name of encryption cipher mode
>> -encrypt.ivgen-alg Name of IV generator algorithm
>> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
>> -encrypt.hash-alg Name of encryption hash algorithm
>> -encrypt.iter-time Time to spend in PBKDF in milliseconds
>> -cluster_size     qcow2 cluster size
>> -preallocation    Preallocation mode (allowed values: off, metadata, f=
alloc, full)
>> -lazy_refcounts   Postpone refcount updates
>> -refcount_bits    Width of a reference count entry in bits
>> +qcow2-create-opts.backing_file=3Dstr - File name of a base image
>> +qcow2-create-opts.backing_fmt=3Dstr - Image format of the base image
>> +qcow2-create-opts.cluster_size=3Dsize - qcow2 cluster size
>> +qcow2-create-opts.compat=3Dstr - Compatibility level (0.10 or 1.1)
>> +qcow2-create-opts.encrypt.cipher-alg=3Dstr - Name of encryption ciphe=
r algorithm
>> +qcow2-create-opts.encrypt.cipher-mode=3Dstr - Name of encryption ciph=
er mode
>> +qcow2-create-opts.encrypt.format=3Dstr - Encrypt the image, format ch=
oices: 'aes', 'luks'
>> +qcow2-create-opts.encrypt.hash-alg=3Dstr - Name of encryption hash al=
gorithm
>> +qcow2-create-opts.encrypt.iter-time=3Dnum - Time to spend in PBKDF in=
 milliseconds
>> +qcow2-create-opts.encrypt.ivgen-alg=3Dstr - Name of IV generator algo=
rithm
>> +qcow2-create-opts.encrypt.ivgen-hash-alg=3Dstr - Name of IV generator=
 hash algorithm
>> +qcow2-create-opts.encrypt.key-secret=3Dstr - ID of secret providing q=
cow AES key or LUKS passphrase
>> +qcow2-create-opts.encryption=3Dbool (on/off) - Encrypt the image with=
 format 'aes'. (Deprecated in favor of encrypt.format=3Daes)
>> +qcow2-create-opts.lazy_refcounts=3Dbool (on/off) - Postpone refcount =
updates
>> +qcow2-create-opts.preallocation=3Dstr - Preallocation mode (allowed v=
alues: off, metadata, falloc, full)
>> +qcow2-create-opts.refcount_bits=3Dnum - Width of a reference count en=
try in bits
>> +qcow2-create-opts.size=3Dsize - Virtual disk size
>> =20
>>  Note that not all of these options may be amendable.
>> =20
>>  Testing: amend -f qcow2 -o ?,cluster_size=3D4k TEST_DIR/t.qcow2
>>  Creation options for 'qcow2':
>> -size             Virtual disk size
>> -compat           Compatibility level (0.10 or 1.1)
>> -backing_file     File name of a base image
>> -backing_fmt      Image format of the base image
>> -encryption       Encrypt the image with format 'aes'. (Deprecated in =
favor of encrypt.format=3Daes)
>> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
>> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passph=
rase
>> -encrypt.cipher-alg Name of encryption cipher algorithm
>> -encrypt.cipher-mode Name of encryption cipher mode
>> -encrypt.ivgen-alg Name of IV generator algorithm
>> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
>> -encrypt.hash-alg Name of encryption hash algorithm
>> -encrypt.iter-time Time to spend in PBKDF in milliseconds
>> -cluster_size     qcow2 cluster size
>> -preallocation    Preallocation mode (allowed values: off, metadata, f=
alloc, full)
>> -lazy_refcounts   Postpone refcount updates
>> -refcount_bits    Width of a reference count entry in bits
>> +qcow2-create-opts.backing_file=3Dstr - File name of a base image
>> +qcow2-create-opts.backing_fmt=3Dstr - Image format of the base image
>> +qcow2-create-opts.cluster_size=3Dsize - qcow2 cluster size
>> +qcow2-create-opts.compat=3Dstr - Compatibility level (0.10 or 1.1)
>> +qcow2-create-opts.encrypt.cipher-alg=3Dstr - Name of encryption ciphe=
r algorithm
>> +qcow2-create-opts.encrypt.cipher-mode=3Dstr - Name of encryption ciph=
er mode
>> +qcow2-create-opts.encrypt.format=3Dstr - Encrypt the image, format ch=
oices: 'aes', 'luks'
>> +qcow2-create-opts.encrypt.hash-alg=3Dstr - Name of encryption hash al=
gorithm
>> +qcow2-create-opts.encrypt.iter-time=3Dnum - Time to spend in PBKDF in=
 milliseconds
>> +qcow2-create-opts.encrypt.ivgen-alg=3Dstr - Name of IV generator algo=
rithm
>> +qcow2-create-opts.encrypt.ivgen-hash-alg=3Dstr - Name of IV generator=
 hash algorithm
>> +qcow2-create-opts.encrypt.key-secret=3Dstr - ID of secret providing q=
cow AES key or LUKS passphrase
>> +qcow2-create-opts.encryption=3Dbool (on/off) - Encrypt the image with=
 format 'aes'. (Deprecated in favor of encrypt.format=3Daes)
>> +qcow2-create-opts.lazy_refcounts=3Dbool (on/off) - Postpone refcount =
updates
>> +qcow2-create-opts.preallocation=3Dstr - Preallocation mode (allowed v=
alues: off, metadata, falloc, full)
>> +qcow2-create-opts.refcount_bits=3Dnum - Width of a reference count en=
try in bits
>> +qcow2-create-opts.size=3Dsize - Virtual disk size
>> =20
>>  Note that not all of these options may be amendable.
>> =20
>>  Testing: amend -f qcow2 -o cluster_size=3D4k -o help TEST_DIR/t.qcow2=

>>  Creation options for 'qcow2':
>> -size             Virtual disk size
>> -compat           Compatibility level (0.10 or 1.1)
>> -backing_file     File name of a base image
>> -backing_fmt      Image format of the base image
>> -encryption       Encrypt the image with format 'aes'. (Deprecated in =
favor of encrypt.format=3Daes)
>> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
>> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passph=
rase
>> -encrypt.cipher-alg Name of encryption cipher algorithm
>> -encrypt.cipher-mode Name of encryption cipher mode
>> -encrypt.ivgen-alg Name of IV generator algorithm
>> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
>> -encrypt.hash-alg Name of encryption hash algorithm
>> -encrypt.iter-time Time to spend in PBKDF in milliseconds
>> -cluster_size     qcow2 cluster size
>> -preallocation    Preallocation mode (allowed values: off, metadata, f=
alloc, full)
>> -lazy_refcounts   Postpone refcount updates
>> -refcount_bits    Width of a reference count entry in bits
>> +qcow2-create-opts.backing_file=3Dstr - File name of a base image
>> +qcow2-create-opts.backing_fmt=3Dstr - Image format of the base image
>> +qcow2-create-opts.cluster_size=3Dsize - qcow2 cluster size
>> +qcow2-create-opts.compat=3Dstr - Compatibility level (0.10 or 1.1)
>> +qcow2-create-opts.encrypt.cipher-alg=3Dstr - Name of encryption ciphe=
r algorithm
>> +qcow2-create-opts.encrypt.cipher-mode=3Dstr - Name of encryption ciph=
er mode
>> +qcow2-create-opts.encrypt.format=3Dstr - Encrypt the image, format ch=
oices: 'aes', 'luks'
>> +qcow2-create-opts.encrypt.hash-alg=3Dstr - Name of encryption hash al=
gorithm
>> +qcow2-create-opts.encrypt.iter-time=3Dnum - Time to spend in PBKDF in=
 milliseconds
>> +qcow2-create-opts.encrypt.ivgen-alg=3Dstr - Name of IV generator algo=
rithm
>> +qcow2-create-opts.encrypt.ivgen-hash-alg=3Dstr - Name of IV generator=
 hash algorithm
>> +qcow2-create-opts.encrypt.key-secret=3Dstr - ID of secret providing q=
cow AES key or LUKS passphrase
>> +qcow2-create-opts.encryption=3Dbool (on/off) - Encrypt the image with=
 format 'aes'. (Deprecated in favor of encrypt.format=3Daes)
>> +qcow2-create-opts.lazy_refcounts=3Dbool (on/off) - Postpone refcount =
updates
>> +qcow2-create-opts.preallocation=3Dstr - Preallocation mode (allowed v=
alues: off, metadata, falloc, full)
>> +qcow2-create-opts.refcount_bits=3Dnum - Width of a reference count en=
try in bits
>> +qcow2-create-opts.size=3Dsize - Virtual disk size
>> =20
>>  Note that not all of these options may be amendable.
>> =20
>>  Testing: amend -f qcow2 -o cluster_size=3D4k -o ? TEST_DIR/t.qcow2
>>  Creation options for 'qcow2':
>> -size             Virtual disk size
>> -compat           Compatibility level (0.10 or 1.1)
>> -backing_file     File name of a base image
>> -backing_fmt      Image format of the base image
>> -encryption       Encrypt the image with format 'aes'. (Deprecated in =
favor of encrypt.format=3Daes)
>> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
>> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passph=
rase
>> -encrypt.cipher-alg Name of encryption cipher algorithm
>> -encrypt.cipher-mode Name of encryption cipher mode
>> -encrypt.ivgen-alg Name of IV generator algorithm
>> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
>> -encrypt.hash-alg Name of encryption hash algorithm
>> -encrypt.iter-time Time to spend in PBKDF in milliseconds
>> -cluster_size     qcow2 cluster size
>> -preallocation    Preallocation mode (allowed values: off, metadata, f=
alloc, full)
>> -lazy_refcounts   Postpone refcount updates
>> -refcount_bits    Width of a reference count entry in bits
>> +qcow2-create-opts.backing_file=3Dstr - File name of a base image
>> +qcow2-create-opts.backing_fmt=3Dstr - Image format of the base image
>> +qcow2-create-opts.cluster_size=3Dsize - qcow2 cluster size
>> +qcow2-create-opts.compat=3Dstr - Compatibility level (0.10 or 1.1)
>> +qcow2-create-opts.encrypt.cipher-alg=3Dstr - Name of encryption ciphe=
r algorithm
>> +qcow2-create-opts.encrypt.cipher-mode=3Dstr - Name of encryption ciph=
er mode
>> +qcow2-create-opts.encrypt.format=3Dstr - Encrypt the image, format ch=
oices: 'aes', 'luks'
>> +qcow2-create-opts.encrypt.hash-alg=3Dstr - Name of encryption hash al=
gorithm
>> +qcow2-create-opts.encrypt.iter-time=3Dnum - Time to spend in PBKDF in=
 milliseconds
>> +qcow2-create-opts.encrypt.ivgen-alg=3Dstr - Name of IV generator algo=
rithm
>> +qcow2-create-opts.encrypt.ivgen-hash-alg=3Dstr - Name of IV generator=
 hash algorithm
>> +qcow2-create-opts.encrypt.key-secret=3Dstr - ID of secret providing q=
cow AES key or LUKS passphrase
>> +qcow2-create-opts.encryption=3Dbool (on/off) - Encrypt the image with=
 format 'aes'. (Deprecated in favor of encrypt.format=3Daes)
>> +qcow2-create-opts.lazy_refcounts=3Dbool (on/off) - Postpone refcount =
updates
>> +qcow2-create-opts.preallocation=3Dstr - Preallocation mode (allowed v=
alues: off, metadata, falloc, full)
>> +qcow2-create-opts.refcount_bits=3Dnum - Width of a reference count en=
try in bits
>> +qcow2-create-opts.size=3Dsize - Virtual disk size
>> =20
>>  Note that not all of these options may be amendable.
>> =20
>> @@ -757,29 +757,29 @@ qemu-img: Invalid option list: ,,
>> =20
>>  Testing: amend -f qcow2 -o help
>>  Creation options for 'qcow2':
>> -size             Virtual disk size
>> -compat           Compatibility level (0.10 or 1.1)
>> -backing_file     File name of a base image
>> -backing_fmt      Image format of the base image
>> -encryption       Encrypt the image with format 'aes'. (Deprecated in =
favor of encrypt.format=3Daes)
>> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
>> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passph=
rase
>> -encrypt.cipher-alg Name of encryption cipher algorithm
>> -encrypt.cipher-mode Name of encryption cipher mode
>> -encrypt.ivgen-alg Name of IV generator algorithm
>> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
>> -encrypt.hash-alg Name of encryption hash algorithm
>> -encrypt.iter-time Time to spend in PBKDF in milliseconds
>> -cluster_size     qcow2 cluster size
>> -preallocation    Preallocation mode (allowed values: off, metadata, f=
alloc, full)
>> -lazy_refcounts   Postpone refcount updates
>> -refcount_bits    Width of a reference count entry in bits
>> +qcow2-create-opts.backing_file=3Dstr - File name of a base image
>> +qcow2-create-opts.backing_fmt=3Dstr - Image format of the base image
>> +qcow2-create-opts.cluster_size=3Dsize - qcow2 cluster size
>> +qcow2-create-opts.compat=3Dstr - Compatibility level (0.10 or 1.1)
>> +qcow2-create-opts.encrypt.cipher-alg=3Dstr - Name of encryption ciphe=
r algorithm
>> +qcow2-create-opts.encrypt.cipher-mode=3Dstr - Name of encryption ciph=
er mode
>> +qcow2-create-opts.encrypt.format=3Dstr - Encrypt the image, format ch=
oices: 'aes', 'luks'
>> +qcow2-create-opts.encrypt.hash-alg=3Dstr - Name of encryption hash al=
gorithm
>> +qcow2-create-opts.encrypt.iter-time=3Dnum - Time to spend in PBKDF in=
 milliseconds
>> +qcow2-create-opts.encrypt.ivgen-alg=3Dstr - Name of IV generator algo=
rithm
>> +qcow2-create-opts.encrypt.ivgen-hash-alg=3Dstr - Name of IV generator=
 hash algorithm
>> +qcow2-create-opts.encrypt.key-secret=3Dstr - ID of secret providing q=
cow AES key or LUKS passphrase
>> +qcow2-create-opts.encryption=3Dbool (on/off) - Encrypt the image with=
 format 'aes'. (Deprecated in favor of encrypt.format=3Daes)
>> +qcow2-create-opts.lazy_refcounts=3Dbool (on/off) - Postpone refcount =
updates
>> +qcow2-create-opts.preallocation=3Dstr - Preallocation mode (allowed v=
alues: off, metadata, falloc, full)
>> +qcow2-create-opts.refcount_bits=3Dnum - Width of a reference count en=
try in bits
>> +qcow2-create-opts.size=3Dsize - Virtual disk size
>> =20
>>  Note that not all of these options may be amendable.
>> =20
>>  Testing: convert -o help
>>  Supported options:
>> -size             Virtual disk size
>> +size=3Dsize - Virtual disk size
>> =20
>>  Testing: amend -f bochs -o help
>>  qemu-img: Format driver 'bochs' does not support option amendment
>>
>=20
> 082 is failing for me on master (046936ed), and this fixes it.
>=20
> I'm wondering if/why other people are not running into this, as 082 run=
s
> with qcow2 and is included on `make check-block`.
>=20
> + Max,
>=20
> FIY, I ran into this while reviewing/testing your Python 3 series.
>=20
> Tested-by: Cleber Rosa <crosa@redhat.com>

Thanks for CC-ing me, Cleber.

Farhan, I disagree with this fix, as I wrote here:

http://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg01488.html

I don't like the new output, so I think what we should do is change the
code that produces it.  Marc-Andr=C3=A9 seemed to agree, so I just need t=
o
write a patch (which I didn't get to so far).

Max


--aCDH2czHxkC7b6kdv2JhGKDCxpvwSF9JG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvEtiIACgkQ9AfbAGHV
z0AozwgAgcRW56kM1g1qJo9DqqpPvHvS2VDHe7U0xbliVD2XMuTAP1HTvCtRMX/t
nifSJTwKNPi60rWS1+4MOhs0ALffaV56DItPHakpzvWFysfurvliphnGx9MK3XWt
QX609ZWoL8AAP23tq44yD39NjjI7E/YLdOLgNZIw059SpqMnEQBoten94eDlO92v
yWl5/ylwa6eYFPB7mhAFArEVvSF7Ismbi3IFs9iLVdixa0fXIwN2wOFQvQUHRQqL
0sm4/rMV9dKeswl2luLAFipHJtoopWtMp5yMC5ETlEbIAKDM/ti9OdrvCChiPGBQ
g/yyPIojFbO9AL+WCTNHYyPZ7x6f3Q==
=3uAD
-----END PGP SIGNATURE-----

--aCDH2czHxkC7b6kdv2JhGKDCxpvwSF9JG--
