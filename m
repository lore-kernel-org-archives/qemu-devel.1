Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BC4C2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 21:25:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F189420857
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 21:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e6T4FFQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F189420857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPYUX-000474-5l
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 17:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56473)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jPYTZ-0002jG-I3
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 17:24:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jPYTT-0005bj-UP
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 17:24:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26621
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jPYTS-0005Xq-4p
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 17:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587158672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O2PRcZrDcmt/14gR+cuBquy5C19t4TI3JDQN5oBAsEo=;
 b=e6T4FFQkl6d6O4jq1RUANRlEB0wQXiP31oiGbCX/oaSGF88wMyWB6nn3egtR5eVdYtLMKF
 5z7J2BclCxTSfmFldCw5+1tGduS7Z/rMk37to9JI1lH6+nFaN7M5hBOVbsWQAJu8qm9eBX
 TIEvRI6OdJljP3ryy4DHPYNR6iyagk8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-C1gwYVncNmeu7HICH68cwg-1; Fri, 17 Apr 2020 17:24:24 -0400
X-MC-Unique: C1gwYVncNmeu7HICH68cwg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08D98108442F;
 Fri, 17 Apr 2020 21:24:23 +0000 (UTC)
Received: from [10.3.115.59] (ovpn-115-59.phx2.redhat.com [10.3.115.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E97CA09AF;
 Fri, 17 Apr 2020 21:24:21 +0000 (UTC)
Subject: Re: [PATCH v18 4/4] iotests: 287: add qcow2 compression type test
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200402063645.23685-1-dplotnikov@virtuozzo.com>
 <20200402063645.23685-5-dplotnikov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <cbb2e89c-a46d-a3f2-a19b-97c6a1deaf6f@redhat.com>
Date: Fri, 17 Apr 2020 16:24:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200402063645.23685-5-dplotnikov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/2/20 1:36 AM, Denis Plotnikov wrote:
> The test checks fulfilling qcow2 requiriements for the compression

requirements

> type feature and zstd compression type operability.
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   tests/qemu-iotests/287     | 167 +++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/287.out |  70 ++++++++++++++++
>   tests/qemu-iotests/group   |   1 +
>   3 files changed, 238 insertions(+)
>   create mode 100755 tests/qemu-iotests/287
>   create mode 100644 tests/qemu-iotests/287.out
> 

> +# Check if we can run this test.
> +if IMGOPTS='compression_type=zstd' _make_test_img 64M |
> +    grep "Invalid parameter 'zstd'"; then
> +    _notrun "ZSTD is disabled"
> +fi

Side effect - this created an image (which gets cleaned up when 
skipping, so no problem there)...

> +
> +# Test: when compression is zlib the incompatible bit is unset
> +echo
> +echo "=== Testing compression type incompatible bit setting for zlib ==="
> +echo
> +
> +IMGOPTS='compression_type=zlib' _make_test_img 64M

...and this recreates the same image.  You could drop this line as 
redundant.

> +$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
> +
> +# Test: when compression differs from zlib the incompatible bit is set
> +echo
> +echo "=== Testing compression type incompatible bit setting for zstd ==="
> +echo

The duplication of '# Test xyz' and 'echo "=== Test xyz"' is awkward; 
you can safely delete the redundant # lines.

> +
> +IMGOPTS='compression_type=zstd' _make_test_img 64M
> +$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
> +
> +# Test: an image can't be opened if compression type is zlib and
> +#       incompatible feature compression type is set
> +echo
> +echo "=== Testing zlib with incompatible bit set ==="
> +echo
> +
> +IMGOPTS='compression_type=zlib' _make_test_img 64M
> +$PYTHON qcow2.py "$TEST_IMG" set-feature-bit incompatible 3
> +# to make sure the bit was actually set
> +$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
> +$QEMU_IMG info "$TEST_IMG" 2>1 1>/dev/null

This creates a file named '1' populated with stderr from qemu-img.  I 
don't think that was your intent; you probably meant 2>&1 (if you wanted 
stderr to be logged with the rest of this script's output).

> +if (($?==0)); then
> +    echo "Error: The image opened successfully. The image must not be opened"
> +fi

Although this is valid bash, the use of (()) is documented as being 
something you should avoid in modern scripts (it can be confused for a 
nested subshell).  So, rewriting these last few lines:

if $QEMU_IMG info "$TEST_IMG" 2>&1 >/dev/null ; then
     echo "Error ..."
fi

> +
> +# Test: an image can't be opened if compression type is NOT zlib and
> +#       incompatible feature compression type is UNSET
> +echo
> +echo "=== Testing zstd with incompatible bit unset ==="
> +echo
> +
> +IMGOPTS='compression_type=zstd' _make_test_img 64M
> +$PYTHON qcow2.py "$TEST_IMG" set-header incompatible_features 0
> +# to make sure the bit was actually unset
> +$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
> +$QEMU_IMG info "$TEST_IMG" 2>1 1>/dev/null

Another bad redirect,

> +if (($?==0)); then

and another awkward (()).

> +    echo "Error: The image opened successfully. The image must not be opened"
> +fi
> +# Test: check compression type values
> +echo
> +echo "=== Testing compression type values ==="
> +echo
> +# zlib=0
> +IMGOPTS='compression_type=zlib' _make_test_img 64M
> +od -j104 -N1 -An -vtu1 "$TEST_IMG"

We recently added peek_file_be in common.rc that would be a lot nicer 
than writing your own od command line.  Use it as:

peek_file_be "$TEST_IMG" 104 1

> +
> +# zstd=1
> +IMGOPTS='compression_type=zstd' _make_test_img 64M
> +od -j104 -N1 -An -vtu1 "$TEST_IMG"

and again

> +echo "=== Testing incompressible cluster processing with zstd ==="
> +echo
> +
> +dd if=/dev/urandom of="$RAND_FILE" bs=1M count=1
> +
> +_make_test_img 64M
> +
> +# fill the image with likely incompressible and compressible clusters
> +
> +# TODO: if RAND_FILE variable contain a whitespace, the following will fail.
> +# We need to support some kind of quotes to make possible file paths with
> +# white spaces for -s option

In the meantime, you can make this test robust, by adding up front 
(copying from test 197 for example):

# Sanity check: our use of $RAND_FILE fails if $TEST_DIR contains spaces
# or other problems
case "$TEST_DIR" in
     *[^-_a-zA-Z0-9/]*)
         _notrun "Suspicious TEST_DIR='$TEST_DIR', cowardly refusing to 
run" ;;
esac

> +$QEMU_IO -c "write -c -s $RAND_FILE 0 1M " "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IO -c "write -c -P 0xFA 1M 1M " "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IMG convert -O $IMGFMT -c -o compression_type=zstd \
> +                  "$TEST_IMG" "$COMPR_IMG"
> +$QEMU_IMG compare "$TEST_IMG" "$COMPR_IMG"

You test that data read in as compressed in zlib and written back out as 
zstd compares as equal, which is not quite as strong as whether what is 
read back out matches the original $RAND_FILE, but this is still a 
pretty good round-trip test (it did not prove whether zlib is 
corruption-free, but does show that zstd is coruption-free, and the 
point of this test is what zstd does).

If you want to avoid the issues with 'write -c -s $RAND_FILE' being 
risky, you could instead do:

$QEMU_IO -c "write -P 0xFA 1M 1M" "$RAND_FILE"
$QEMU_IMG convert -f raw -O $IMGFMT -c "$RAND_FILE" "$TEST_IMG"

for creating the zlib file.

Overall, I'm liking how this looks.  There are still a few shell bugs to 
clean up, and I'm not sure which maintainer will be incorporating this, 
but I'm hoping v19 goes into 5.1 rather early in the cycle.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


