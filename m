Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F08C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 19:57:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49D6F20659
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 19:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D6F20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsYFH-0001gb-9t
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 15:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33001)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hsYEe-0001AO-Ge
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 15:56:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hsYEY-0004Bm-7F
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 15:56:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48014)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hsYEM-00046V-MN; Tue, 30 Jul 2019 15:56:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 39F6483F4C;
 Tue, 30 Jul 2019 19:56:17 +0000 (UTC)
Received: from [10.3.116.93] (ovpn-116-93.phx2.redhat.com [10.3.116.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 97C695D9C8;
 Tue, 30 Jul 2019 19:56:16 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20190730172508.19911-1-mreitz@redhat.com>
 <20190730172508.19911-14-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=eblake@redhat.com; keydata=
 xsBNBEvHyWwBCACw7DwsQIh0kAbUXyqhfiKAKOTVu6OiMGffw2w90Ggrp4bdVKmCaEXlrVLU
 xphBM8mb+wsFkU+pq9YR621WXo9REYVIl0FxKeQo9dyQBZ/XvmUMka4NOmHtFg74nvkpJFCD
 TUNzmqfcjdKhfFV0d7P/ixKQeZr2WP1xMcjmAQY5YvQ2lUoHP43m8TtpB1LkjyYBCodd+LkV
 GmCx2Bop1LSblbvbrOm2bKpZdBPjncRNob73eTpIXEutvEaHH72LzpzksfcKM+M18cyRH+nP
 sAd98xIbVjm3Jm4k4d5oQyE2HwOur+trk2EcxTgdp17QapuWPwMfhaNq3runaX7x34zhABEB
 AAHNHkVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPsLAegQTAQgAJAIbAwULCQgHAwUV
 CgkICwUWAgMBAAIeAQIXgAUCS8fL9QIZAQAKCRCnoWtKJSdDahBHCACbl/5FGkUqJ89GAjeX
 RjpAeJtdKhujir0iS4CMSIng7fCiGZ0fNJCpL5RpViSo03Q7l37ss+No+dJI8KtAp6ID+PMz
 wTJe5Egtv/KGUKSDvOLYJ9WIIbftEObekP+GBpWP2+KbpADsc7EsNd70sYxExD3liwVJYqLc
 Rw7so1PEIFp+Ni9A1DrBR5NaJBnno2PHzHPTS9nmZVYm/4I32qkLXOcdX0XElO8VPDoVobG6
 gELf4v/vIImdmxLh/w5WctUpBhWWIfQDvSOW2VZDOihm7pzhQodr3QP/GDLfpK6wI7exeu3P
 pfPtqwa06s1pae3ad13mZGzkBdNKs1HEm8x6zsBNBEvHyWwBCADGkMFzFjmmyqAEn5D+Mt4P
 zPdO8NatsDw8Qit3Rmzu+kUygxyYbz52ZO40WUu7EgQ5kDTOeRPnTOd7awWDQcl1gGBXgrkR
 pAlQ0l0ReO57Q0eglFydLMi5bkwYhfY+TwDPMh3aOP5qBXkm4qIYSsxb8A+i00P72AqFb9Q7
 3weG/flxSPApLYQE5qWGSXjOkXJv42NGS6o6gd4RmD6Ap5e8ACo1lSMPfTpGzXlt4aRkBfvb
 NCfNsQikLZzFYDLbQgKBA33BDeV6vNJ9Cj0SgEGOkYyed4I6AbU0kIy1hHAm1r6+sAnEdIKj
 cHi3xWH/UPrZW5flM8Kqo14OTDkI9EtlABEBAAHCwF8EGAEIAAkFAkvHyWwCGwwACgkQp6Fr
 SiUnQ2q03wgAmRFGDeXzc58NX0NrDijUu0zx3Lns/qZ9VrkSWbNZBFjpWKaeL1fdVeE4TDGm
 I5mRRIsStjQzc2R9b+2VBUhlAqY1nAiBDv0Qnt+9cLiuEICeUwlyl42YdwpmY0ELcy5+u6wz
 mK/jxrYOpzXKDwLq5k4X+hmGuSNWWAN3gHiJqmJZPkhFPUIozZUCeEc76pS/IUN72NfprZmF
 Dp6/QDjDFtfS39bHSWXKVZUbqaMPqlj/z6Ugk027/3GUjHHr8WkeL1ezWepYDY7WSoXwfoAL
 2UXYsMAr/uUncSKlfjvArhsej0S4zbqim2ZY6S8aRWw94J3bSvJR+Nwbs34GPTD4Pg==
Organization: Red Hat, Inc.
Message-ID: <9883f164-3d1a-4d8c-61a4-3f34f9148072@redhat.com>
Date: Tue, 30 Jul 2019 14:56:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190730172508.19911-14-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qwxJlFtLVx7bkdJUK4C6Wx3Eg0VHQNRbb"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 30 Jul 2019 19:56:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.2 13/13] iotests: Test qcow2's
 snapshot table handling
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qwxJlFtLVx7bkdJUK4C6Wx3Eg0VHQNRbb
Content-Type: multipart/mixed; boundary="8kSBBW3TMjYSu0RS9Fl6yXubkWvJFWy61";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <9883f164-3d1a-4d8c-61a4-3f34f9148072@redhat.com>
Subject: Re: [PATCH for-4.2 13/13] iotests: Test qcow2's snapshot table
 handling
References: <20190730172508.19911-1-mreitz@redhat.com>
 <20190730172508.19911-14-mreitz@redhat.com>
In-Reply-To: <20190730172508.19911-14-mreitz@redhat.com>

--8kSBBW3TMjYSu0RS9Fl6yXubkWvJFWy61
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/30/19 12:25 PM, Max Reitz wrote:
> Add a test how our qcow2 driver handles extra data in snapshot table
> entries, and how it repairs overly long snapshot tables.

May need tweaking if we drop 9 and 10.

>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/261     | 449 +++++++++++++++++++++++++++++++++++++=

>  tests/qemu-iotests/261.out | 321 ++++++++++++++++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 771 insertions(+)
>  create mode 100755 tests/qemu-iotests/261
>  create mode 100644 tests/qemu-iotests/261.out
>=20
> +
> +# Parameters:
> +#   $1: image filename
> +#   $2: snapshot table entry offset in the image
> +snapshot_table_entry_size()
> +{
> +    id_len=3D$(peek_file_be "$1" $(($2 + 12)) 2)
> +    name_len=3D$(peek_file_be "$1" $(($2 + 14)) 2)
> +    extra_len=3D$(peek_file_be "$1" $(($2 + 36)) 4)
> +
> +    full_len=3D$((40 + extra_len + id_len + name_len))
> +    if [ $((full_len % 8)) =3D 0 ]; then
> +        echo $full_len
> +    else
> +        echo $((full_len + 8 - full_len % 8))

Could replace the entire if with:
 echo $(( (full_len + 7) / 8 * 8 ))
but what you have works.

> +    fi
> +}
> +
> +# Parameter:
> +#   $1: image filename
> +print_snapshot_table()
> +{
> +    nb_entries=3D$(peek_file_be "$1" 60 4)
> +    offset=3D$(peek_file_be "$1" 64 8)
> +
> +    echo "Snapshots in $1:" | _filter_testdir | _filter_imgfmt

Should a separate patch add support in 'qemu-img info'/'qemu-img
snapshot -l' for letting users know how much extra info is in each
snapshot?  It seems useful enough without having to recode this
low-level iotest introspection.

> +
> +    for ((i =3D 0; i < nb_entries; i++)); do
> +        id_len=3D$(peek_file_be "$1" $((offset + 12)) 2)
> +        name_len=3D$(peek_file_be "$1" $((offset + 14)) 2)
> +        extra_len=3D$(peek_file_be "$1" $((offset + 36)) 4)
> +
> +        extra_ofs=3D$((offset + 40))
> +        id_ofs=3D$((extra_ofs + extra_len))
> +        name_ofs=3D$((id_ofs + id_len))
> +
> +        echo "  [$i]"
> +        echo "    ID: $(peek_file_raw "$1" $id_ofs $id_len)"
> +        echo "    Name: $(peek_file_raw "$1" $name_ofs $name_len)"

We're relying on the files having sane strings at those offsets - but
that's fine for the iotest.

> +        echo "    Extra data size: $extra_len"
> +        if [ $extra_len -ge 8 ]; then
> +            echo "    VM state size: $(peek_file_be "$1" $extra_ofs 8)=
"
> +        fi
> +        if [ $extra_len -ge 16 ]; then
> +            echo "    Disk size: $(peek_file_be "$1" $((extra_ofs + 8)=
) 8)"
> +        fi
> +        if [ $extra_len -gt 16 ]; then
> +            echo '    Unknown extra data:' \
> +                "$(peek_file_raw "$1" $((extra_ofs + 16)) $((extra_len=
 - 16)) \
> +                   | tr -d '\0')"

Printing the unknown extra data seems fishy, especially if you are going
to sanitize out the NUL bytes.  An od dump of every byte might be more
useful, but I'd also be happy with just printing the number of unknown
bytes without actually worrying about printing the contents of those byte=
s.


> +echo
> +echo '=3D=3D=3D Create v2 template =3D=3D=3D'
> +echo
> +
> +# Create v2 image with a snapshot table with three entries:
> +# [0]: No extra data (valid with v2, not valid with v3)
> +# [1]: Has extra data unknown to qemu
> +# [2]: Has the 64-bit VM state size, but not the disk size (again,
> +#      valid with v2, not valid with v3)

Cool - and covers cases that are not possible to do with current
'qemu-img create -f qcow2 -o compat=3Dv2' (if you have a CentOS 6 machine=

hanging around, you can create v2 images like entry [0]; but these days,
modern qemu-img creates v2 images with the 16 extra bytes as they will
be used by v3).

> +
> +TEST_IMG=3D"$TEST_IMG.v2.orig" IMGOPTS=3D'compat=3D0.10' _make_test_im=
g 64M
> +$QEMU_IMG snapshot -c sn0 "$TEST_IMG.v2.orig"
> +$QEMU_IMG snapshot -c sn1 "$TEST_IMG.v2.orig"
> +$QEMU_IMG snapshot -c sn2 "$TEST_IMG.v2.orig"
> +
> +# Copy out all existing snapshot table entries

> +
> +# Amend them, one by one
> +# Set sn0's extra data size to 0
> +poke_file "$TEST_DIR/sn0-pre" 36 '\x00\x00\x00\x00'
> +truncate -s 0 "$TEST_DIR/sn0-extra"
> +# Grow sn0-post to pad
> +truncate -s $(($(snapshot_table_entry_size "$TEST_DIR/sn0-pre") - 40))=
 \
> +    "$TEST_DIR/sn0-post"
> +
> +# Set sn1's extra data size to 42

Nice - not a multiple of 8, to test our code handling of rounding :)

> +poke_file "$TEST_DIR/sn1-pre" 36 '\x00\x00\x00\x2a'
> +truncate -s 42 "$TEST_DIR/sn1-extra"
> +poke_file "$TEST_DIR/sn1-extra" 16 'very important data'
> +# Grow sn1-post to pad
> +truncate -s $(($(snapshot_table_entry_size "$TEST_DIR/sn1-pre") - 82))=
 \
> +    "$TEST_DIR/sn1-post"
> +
> +# Set sn2's extra data size to 8
> +poke_file "$TEST_DIR/sn2-pre" 36 '\x00\x00\x00\x08'
> +truncate -s 8 "$TEST_DIR/sn2-extra"
> +# Grow sn2-post to pad
> +truncate -s $(($(snapshot_table_entry_size "$TEST_DIR/sn2-pre") - 48))=
 \
> +    "$TEST_DIR/sn2-post"
> +
> +# Construct snapshot table
> +cat "$TEST_DIR"/sn0-{pre,extra,post} \
> +    "$TEST_DIR"/sn1-{pre,extra,post} \
> +    "$TEST_DIR"/sn2-{pre,extra,post} \
> +    | dd of=3D"$TEST_IMG.v2.orig" bs=3D1 seek=3D$sn_table_ofs conv=3Dn=
otrunc \
> +          &> /dev/null
> +
> +# Done!

Hairy, but looks like a valid v2 image.

> +TEST_IMG=3D"$TEST_IMG.v2.orig" _check_test_img
> +print_snapshot_table "$TEST_IMG.v2.orig"
> +
> +echo
> +echo '=3D=3D=3D Upgrade to v3 =3D=3D=3D'
> +echo
> +
> +cp "$TEST_IMG.v2.orig" "$TEST_IMG.v3.orig"
> +$QEMU_IMG amend -o compat=3D1.1 "$TEST_IMG.v3.orig"
> +TEST_IMG=3D"$TEST_IMG.v3.orig" _check_test_img
> +print_snapshot_table "$TEST_IMG.v3.orig"
> +
> +echo
> +echo '=3D=3D=3D Repair botched v3 =3D=3D=3D'
> +echo
> +
> +# Force the v2 file to be v3.  v3 requires each snapshot table entry
> +# to have at least 16 bytes of extra data, so it will not comply to
> +# the qcow2 v3 specification; but we can fix that.
> +cp "$TEST_IMG.v2.orig" "$TEST_IMG"
> +
> +# Set version
> +poke_file "$TEST_IMG" 4 '\x00\x00\x00\x03'
> +# Increase header length (necessary for v3)
> +poke_file "$TEST_IMG" 100 '\x00\x00\x00\x68'
> +# Set refcount order (necessary for v3)
> +poke_file "$TEST_IMG" 96 '\x00\x00\x00\x04'
> +
> +_check_test_img -r all
> +print_snapshot_table "$TEST_IMG"

Good - you're testing that we can now flag and fix images that we were
previously silently using in spite of their non-compliance.

> +
> +
> +# From now on, just test the qcow2 version we are supposed to test.
> +# (v3 by default, v2 by choice through $IMGOPTS.)
> +# That works because we always write all known extra data when
> +# updating the snapshot table, independent of the version.
> +
> +if echo "$IMGOPTS" | grep -q 'compat=3D\(0\.10\|v2\)' 2> /dev/null; th=
en
> +    subver=3Dv2
> +else
> +    subver=3Dv3
> +fi
> +
> +echo
> +echo '=3D=3D=3D Add new snapshot =3D=3D=3D'
> +echo
> +
> +cp "$TEST_IMG.$subver.orig" "$TEST_IMG"
> +$QEMU_IMG snapshot -c sn3 "$TEST_IMG"
> +_check_test_img
> +print_snapshot_table "$TEST_IMG"
> +
> +echo
> +echo '=3D=3D=3D Remove different snapshots =3D=3D=3D'
> +
> +for sn in sn0 sn1 sn2; do
> +    echo
> +    echo "--- $sn ---"
> +
> +    cp "$TEST_IMG.$subver.orig" "$TEST_IMG"
> +    $QEMU_IMG snapshot -d $sn "$TEST_IMG"
> +    _check_test_img
> +    print_snapshot_table "$TEST_IMG"
> +done
> +
> +echo
> +echo '=3D=3D=3D Reject too much unknown extra data =3D=3D=3D'
> +echo
> +
> +cp "$TEST_IMG.$subver.orig" "$TEST_IMG"
> +$QEMU_IMG snapshot -c sn3 "$TEST_IMG"
> +
> +sn_table_ofs=3D$(peek_file_be "$TEST_IMG" 64 8)
> +sn0_ofs=3D$sn_table_ofs
> +sn1_ofs=3D$((sn0_ofs + $(snapshot_table_entry_size "$TEST_IMG" $sn0_of=
s)))
> +sn2_ofs=3D$((sn1_ofs + $(snapshot_table_entry_size "$TEST_IMG" $sn1_of=
s)))
> +sn3_ofs=3D$((sn2_ofs + $(snapshot_table_entry_size "$TEST_IMG" $sn2_of=
s)))
> +
> +# 64 kB of extra data should be rejected
> +# (Note that this also induces a refcount error, because it spills
> +# over to the next cluster.  That's a good way to test that we can
> +# handle simultaneous snapshot table and refcount errors.)
> +poke_file "$TEST_IMG" $((sn3_ofs + 36)) '\x00\x01\x00\x00'
> +
> +# Print error
> +_img_info
> +echo
> +_check_test_img
> +echo
> +
> +# Should be repairable
> +_check_test_img -r all

Nice.

> +
> +echo
> +echo '=3D=3D=3D Snapshot table too big =3D=3D=3D'
> +echo
> +
> +sn_table_ofs=3D$(peek_file_be "$TEST_IMG.v3.orig" 64 8)
> +
> +# Fill a snapshot with 1 kB of extra data, a 65535-char ID, and a
> +# 65535-char name, and repeat it as many times as necessary to fill
> +# 64 MB (the maximum supported by qemu)
> +
> +touch "$TEST_DIR/sn0"
> +
> +# Full size (fixed + extra + ID + name + padding)
> +sn_size=3D$((40 + 1024 + 65535 + 65535 + 2))
> +
> +# We only need the fixed part, though.
> +truncate -s 40 "$TEST_DIR/sn0"
> +
> +# 65535-char ID string
> +poke_file "$TEST_DIR/sn0" 12 '\xff\xff'
> +# 65535-char name
> +poke_file "$TEST_DIR/sn0" 14 '\xff\xff'

Do we care that there are NUL bytes in the id and name?  (The spec is
clear that id and name are not NUL-terminated, but does not actually
seem to forbid the use of arbitrary binary values as names...)

> +# 1 kB of extra data
> +poke_file "$TEST_DIR/sn0" 36 '\x00\x00\x04\x00'
> +
> +# Create test image
> +_make_test_img 64M
> +
> +# Hook up snapshot table somewhere safe (at 1 MB)
> +poke_file "$TEST_IMG" 64 '\x00\x00\x00\x00\x00\x10\x00\x00'
> +
> +offset=3D1048576
> +size_written=3D0
> +sn_count=3D0
> +while [ $size_written -le $((64 * 1048576)) ]; do
> +    dd if=3D"$TEST_DIR/sn0" of=3D"$TEST_IMG" bs=3D1 seek=3D$offset con=
v=3Dnotrunc \
> +        &> /dev/null
> +    offset=3D$((offset + sn_size))
> +    size_written=3D$((size_written + sn_size))
> +    sn_count=3D$((sn_count + 1))
> +done
> +
> +# Give the last snapshot (the one to be removed) an L1 table so we can=

> +# see how that is handled when repairing the image
> +# (Put it two clusters before 1 MB, and one L2 table one cluster
> +# before 1 MB)
> +poke_file "$TEST_IMG" $((offset - sn-size + 0)) \
> +    '\x00\x00\x00\x00\x00\x0e\x00\x00'
> +poke_file "$TEST_IMG" $((offset - sn-size + 8)) \
> +    '\x00\x00\x00\x01'
> +
> +# Hook up the L2 table
> +poke_file "$TEST_IMG" $((1048576 - 2 * 65536)) \
> +    '\x80\x00\x00\x00\x00\x0f\x00\x00'
> +
> +# Make sure all of the clusters we just hooked up are allocated:
> +# - The snapshot table
> +# - The last snapshot's L1 and L2 table
> +refblock0_allocate $((1048576 - 2 * 65536)) $offset
> +
> +poke_file "$TEST_IMG" 60 \
> +    "$(printf '%08x' $sn_count | sed -e 's/\(..\)/\\x\1/g')"

Wow - you went to a lot of work to produce this image :)

> +
> +# Print error
> +_img_info
> +echo
> +_check_test_img
> +echo
> +
> +# Should be repairable
> +_check_test_img -r all

Depending on our decision on 9 and 10.

> +
> +echo
> +echo "$((sn_count - 1)) snapshots should remain:"
> +echo "  qemu-img info reports $(_img_info | grep -c '^ \{34\}') snapsh=
ots"
> +echo "  Image header reports $(peek_file_be "$TEST_IMG" 60 4) snapshot=
s"
> +
> +echo
> +echo '=3D=3D=3D Too many snapshots =3D=3D=3D'
> +echo
> +
> +# Create a v2 image, for speeds' sake: All-zero snapshot table entries=

> +# are only valid in v2.
> +IMGOPTS=3D'compat=3D0.10' _make_test_img 64M
> +
> +# Hook up snapshot table somewhere safe (at 1 MB)
> +poke_file "$TEST_IMG" 64 '\x00\x00\x00\x00\x00\x10\x00\x00'
> +# "Create" more than 65536 snapshots (twice that many here)
> +poke_file "$TEST_IMG" 60 '\x00\x02\x00\x00'
> +
> +# 40-byte all-zero snapshot table entries are valid snapshots, but
> +# only in v2 (v3 needs 16 bytes of extra data, so we would have to
> +# write 131072x '\x10').
> +truncate -s $((1048576 + 40 * 131072)) "$TEST_IMG"
> +
> +# But let us give one of the snapshots to be removed an L1 table so
> +# we can see how that is handled when repairing the image.
> +# (Put it two clusters before 1 MB, and one L2 table one cluster
> +# before 1 MB)
> +poke_file "$TEST_IMG" $((1048576 + 40 * 65536 + 0)) \
> +    '\x00\x00\x00\x00\x00\x0e\x00\x00'
> +poke_file "$TEST_IMG" $((1048576 + 40 * 65536 + 8)) \
> +    '\x00\x00\x00\x01'
> +
> +# Hook up the L2 table
> +poke_file "$TEST_IMG" $((1048576 - 2 * 65536)) \
> +    '\x80\x00\x00\x00\x00\x0f\x00\x00'
> +
> +# Make sure all of the clusters we just hooked up are allocated:
> +# - The snapshot table
> +# - The last snapshot's L1 and L2 table
> +refblock0_allocate $((1048576 - 2 * 65536)) $((1048576 + 40 * 131072))=

> +

Another fun image creation.

> +# Print error
> +_img_info
> +echo
> +_check_test_img
> +echo
> +
> +# Should be repairable
> +_check_test_img -r all
> +
> +echo
> +echo '65536 snapshots should remain:'
> +echo "  qemu-img info reports $(_img_info | grep -c '^ \{34\}') snapsh=
ots"
> +echo "  Image header reports $(peek_file_be "$TEST_IMG" 60 4) snapshot=
s"
> +
> +# success, all done
> +echo "*** done"
> +status=3D0

Overall, looks like a nice test.  I'm comfortable giving:

Reviewed-by: Eric Blake <eblake@redhat.com>

> +++ b/tests/qemu-iotests/261.out
> @@ -0,0 +1,321 @@
> +QA output created by 261
> +
> +=3D=3D=3D Create v2 template =3D=3D=3D
> +
> +Formatting 'TEST_DIR/t.IMGFMT.v2.orig', fmt=3DIMGFMT size=3D67108864
> +No errors were found on the image.
> +Snapshots in TEST_DIR/t.IMGFMT.v2.orig:
> +  [0]
> +    ID: 1
> +    Name: sn0
> +    Extra data size: 0
> +  [1]
> +    ID: 2
> +    Name: sn1
> +    Extra data size: 42
> +    VM state size: 0
> +    Disk size: 67108864
> +    Unknown extra data: very important data

Again, if qemu-img is improved to output more information natively
instead of you hand-scraping it, I don't think that printing the
contents of extra data is viable in that context.  But it looks fun here
in this test.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--8kSBBW3TMjYSu0RS9Fl6yXubkWvJFWy61--

--qwxJlFtLVx7bkdJUK4C6Wx3Eg0VHQNRbb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1AoN8ACgkQp6FrSiUn
Q2qQ8wf/VpYMUAHSX7drx1bpH93291F7v21+4swsSsKZ4rmLCzAO8RXbyNGaS/se
sgFwXxH9erQtEXYDVjJHx4fI+/pbFR91TiGn7Y10NldwrV0CR6IBP0zJMPWyZJQ4
O7EZiW/NSX9/gX6ff+ofTTvUsDNPbunXHmCmf5RVvDTbETDPeSu+8zgGfOy3E5jM
Jt83MGaHoGrlCzjf5wJTE21Wsfy1lT+PaNee+AZD5DByvkDPdw00RJ7itGrNmQBu
0CUBbhfL7o2+HS0eI8QdoNUUOz1bpitDzjZWqnCRFrebDF3eAFV3evQUtypJ0p2F
lGQJslCz8Ycp94MxkbQudRr5WkqCcw==
=uLYo
-----END PGP SIGNATURE-----

--qwxJlFtLVx7bkdJUK4C6Wx3Eg0VHQNRbb--

