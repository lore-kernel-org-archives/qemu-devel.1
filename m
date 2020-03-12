Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC06C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 22:21:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 189BE20637
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 22:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EnMBrHgq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 189BE20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCWCV-0005n6-B5
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 18:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58613)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jCWBY-0003qz-8z
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 18:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jCWBV-00055q-6N
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 18:20:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26125
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jCWBV-00054k-0e
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 18:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584051608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eLVQZAYgwHpB2gEAiucZfyq4TDXUck2RWQ+TQ6Pceyw=;
 b=EnMBrHgqJdkqe78JaIEORqs7PyVsd3+DwkarqMH94svhLB50ARxdBwheOOtXJSHrHAZeeI
 9Kgcogtou/kwJfzPm/+xzlFb8eCx63G+w62JZEcSafQONt7l5jFGZ4AcCuVudgmi3175KA
 kz9+nb9B4lucmvIWV8KccHsN++GulOk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-9RypKjPTP66LjL8rgBPyig-1; Thu, 12 Mar 2020 18:19:57 -0400
X-MC-Unique: 9RypKjPTP66LjL8rgBPyig-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 407FE1005510;
 Thu, 12 Mar 2020 22:19:56 +0000 (UTC)
Received: from [10.10.125.118] (ovpn-125-118.rdu2.redhat.com [10.10.125.118])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9AC819A6A;
 Thu, 12 Mar 2020 22:19:55 +0000 (UTC)
Subject: Re: [PATCH] iotests/026: Move v3-exclusive test to new file
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200311140707.1243218-1-mreitz@redhat.com>
From: John Snow <jsnow@redhat.com>
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d7c67c4f-67a9-d42d-acbd-8d4bcd5cf4ee@redhat.com>
Date: Thu, 12 Mar 2020 18:19:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200311140707.1243218-1-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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



On 3/11/20 10:07 AM, Max Reitz wrote:
> data_file does not work with v2, and we probably want 026 to keep
> working for v2 images.  Thus, open a new file for v3-exclusive error
> path test cases.
>=20
> Fixes: 81311255f217859413c94f2cd9cebf2684bbda94
>        (=E2=80=9Ciotests/026: Test EIO on allocation in a data-file=E2=80=
=9D)
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Let me start this reply with something good, or at least something
that's not bad. It's value neutral at worst.

Reviewed-by: John Snow <jsnow@redhat.com>
Tested-by: John Snow <jsnow@redhat.com>


Now, let's get cracking on some prime nonsense.

I assume this patch is still 'pending'. Here's a complete tangent
unrelated to your patch in every single way:

What's the best way to use patchew to see series that are "pending" in
some way? I'd like to:

- Search only the block list (to:qemu-block@nongnu.org. I assume this
catches CCs too.)
- Exclude series that are merged (-is:merged)
- Exclude obsoleted series (-is:obsolete)

This gets a bit closer to things that are interesting in some way --
give or take some fuzziness with patchew's detection of "merged" or
"obsoleted" sometimes.

- Exclude pull requests. (-is:pull seems broken, actually.)
- Exclude reviewed series (-is:reviewed -- what does patchew consider
'reviewed'? does this mean fully reviewed, or any reviews?)

This gives me something a bit more useful.

- Exclude 'expired' series. I use 30 days as a mental model for this. It
might be nice to formalize this and mark patches that received no
replies and didn't detect any other state change as "expired" and send
an autoreply from the bot.

(I.e., patches that are complete, applied, passed CI, were not
obsoleted, did not appear to be merged, and received no replies from
anyone except the patch author)


("Hi, this patch received no replies from anyone except the author (you)
for 30 days. The series is being dropped from the pending queue and is
being marked expired. If the patches are still important, please rebase
them and re-send to the list.

Please use scripts/get_maintainers.pl to identify candidate maintainers
and reviewers and make sure they are CC'd.

This series appears to touch files owned by the following maintainers:
- Blah
- Etc
- And so on

For more information on the contribution process, please visit:
<wiki links to contribution guides, etc>")

We don't have anything like that, so age:<30d suffices. Alright, this
list is starting to look *pretty* decent.

project:QEMU to:qemu-block@nongnu.org not:obsolete not:merged
-is:reviewed age:<30d

Lastly, maybe we can exclude series that don't have replies yet. It's
not clear to patchew which replies are:

- Unrelated comments, like this one here
- Requests for a change
- A question for the submitter
- A softly-worded N-A-C-K

and without a concept of designated reviewer, perhaps lack of replies is
good evidence that the series is untouched and needs someone to 'pick it
up'; (-has:replies)

https://patchew.org/search?q=3Dproject%3AQEMU+to%3Aqemu-block%40nongnu.org+=
not%3Aobsolete+not%3Amerged+-is%3Areviewed+age%3A%3C30d+-has%3Areplies

Alright, that's pretty good, actually.

OK, yes, this patch still needs love as far as patchew understands.

> ---
>  tests/qemu-iotests/026             | 31 -----------
>  tests/qemu-iotests/026.out         |  6 --
>  tests/qemu-iotests/026.out.nocache |  6 --
>  tests/qemu-iotests/289             | 89 ++++++++++++++++++++++++++++++
>  tests/qemu-iotests/289.out         |  8 +++
>  tests/qemu-iotests/group           |  1 +
>  6 files changed, 98 insertions(+), 43 deletions(-)
>  create mode 100755 tests/qemu-iotests/289
>  create mode 100644 tests/qemu-iotests/289.out
>=20
> diff --git a/tests/qemu-iotests/026 b/tests/qemu-iotests/026
> index b05a4692cf..b9713eb591 100755
> --- a/tests/qemu-iotests/026
> +++ b/tests/qemu-iotests/026
> @@ -240,37 +240,6 @@ $QEMU_IO -c "write 0 $CLUSTER_SIZE" "$BLKDBG_TEST_IM=
G" | _filter_qemu_io
> =20
>  _check_test_img
> =20
> -echo
> -echo =3D=3D=3D Avoid freeing external data clusters on failure =3D=3D=3D
> -echo
> -
> -# Similar test as the last one, except we test what happens when there
> -# is an error when writing to an external data file instead of when
> -# writing to a preallocated zero cluster
> -_make_test_img -o "data_file=3D$TEST_IMG.data_file" $CLUSTER_SIZE
> -
> -# Put blkdebug above the data-file, and a raw node on top of that so
> -# that blkdebug will see a write_aio event and emit an error
> -$QEMU_IO -c "write 0 $CLUSTER_SIZE" \
> -    "json:{
> -         'driver': 'qcow2',
> -         'file': { 'driver': 'file', 'filename': '$TEST_IMG' },
> -         'data-file': {
> -             'driver': 'raw',
> -             'file': {
> -                 'driver': 'blkdebug',
> -                 'config': '$TEST_DIR/blkdebug.conf',
> -                 'image': {
> -                     'driver': 'file',
> -                     'filename': '$TEST_IMG.data_file'
> -                 }
> -             }
> -         }
> -     }" \
> -    | _filter_qemu_io
> -
> -_check_test_img
> -
>  # success, all done
>  echo "*** done"
>  rm -f $seq.full
> diff --git a/tests/qemu-iotests/026.out b/tests/qemu-iotests/026.out
> index c1b3b58482..83989996ff 100644
> --- a/tests/qemu-iotests/026.out
> +++ b/tests/qemu-iotests/026.out
> @@ -653,10 +653,4 @@ wrote 1024/1024 bytes at offset 0
>  1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  write failed: Input/output error
>  No errors were found on the image.
> -
> -=3D=3D=3D Avoid freeing external data clusters on failure =3D=3D=3D
> -
> -Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1024 data_file=3DTES=
T_DIR/t.IMGFMT.data_file
> -write failed: Input/output error
> -No errors were found on the image.
>  *** done
> diff --git a/tests/qemu-iotests/026.out.nocache b/tests/qemu-iotests/026.=
out.nocache
> index 8d5001648a..9359d26d7e 100644
> --- a/tests/qemu-iotests/026.out.nocache
> +++ b/tests/qemu-iotests/026.out.nocache
> @@ -661,10 +661,4 @@ wrote 1024/1024 bytes at offset 0
>  1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  write failed: Input/output error
>  No errors were found on the image.
> -
> -=3D=3D=3D Avoid freeing external data clusters on failure =3D=3D=3D
> -
> -Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1024 data_file=3DTES=
T_DIR/t.IMGFMT.data_file
> -write failed: Input/output error
> -No errors were found on the image.
>  *** done
> diff --git a/tests/qemu-iotests/289 b/tests/qemu-iotests/289
> new file mode 100755
> index 0000000000..1c11d4030e
> --- /dev/null
> +++ b/tests/qemu-iotests/289
> @@ -0,0 +1,89 @@
> +#!/usr/bin/env bash
> +#
> +# qcow2 v3-exclusive error path testing
> +# (026 tests paths common to v2 and v3)
> +#
> +# Copyright (C) 2020 Red Hat, Inc.
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +#
> +
> +seq=3D$(basename $0)
> +echo "QA output created by $seq"
> +
> +status=3D1=09# failure is the default!
> +
> +_cleanup()
> +{
> +    _cleanup_test_img
> +    rm "$TEST_DIR/blkdebug.conf"
> +    rm -f "$TEST_IMG.data_file"
> +}
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +# get standard environment, filters and checks
> +. ./common.rc
> +. ./common.filter
> +. ./common.pattern
> +
> +_supported_fmt qcow2
> +_supported_proto file
> +# This is a v3-exclusive test;
> +# As for data_file, error paths often very much depend on whether
> +# there is an external data file or not; so we create one exactly when
> +# we want to test it
> +_unsupported_imgopts 'compat=3D0.10' data_file
> +
> +echo
> +echo =3D=3D=3D Avoid freeing external data clusters on failure =3D=3D=3D
> +echo
> +
> +cat > "$TEST_DIR/blkdebug.conf" <<EOF
> +[inject-error]
> +event =3D "write_aio"
> +errno =3D "5"
> +once =3D "on"
> +EOF
> +
> +# Test what happens when there is an error when writing to an external
> +# data file instead of when writing to a preallocated zero cluster
> +_make_test_img -o "data_file=3D$TEST_IMG.data_file" 64k
> +
> +# Put blkdebug above the data-file, and a raw node on top of that so
> +# that blkdebug will see a write_aio event and emit an error.  This
> +# will then trigger the alloc abort code, which we want to test here.
> +$QEMU_IO -c "write 0 64k" \
> +    "json:{
> +         'driver': 'qcow2',
> +         'file': { 'driver': 'file', 'filename': '$TEST_IMG' },
> +         'data-file': {
> +             'driver': 'raw',
> +             'file': {
> +                 'driver': 'blkdebug',
> +                 'config': '$TEST_DIR/blkdebug.conf',
> +                 'image': {
> +                     'driver': 'file',
> +                     'filename': '$TEST_IMG.data_file'
> +                 }
> +             }
> +         }
> +     }" \
> +    | _filter_qemu_io
> +
> +_check_test_img
> +
> +# success, all done
> +echo "*** done"
> +rm -f $seq.full
> +status=3D0
> diff --git a/tests/qemu-iotests/289.out b/tests/qemu-iotests/289.out
> new file mode 100644
> index 0000000000..e54e2629d4
> --- /dev/null
> +++ b/tests/qemu-iotests/289.out
> @@ -0,0 +1,8 @@
> +QA output created by 289
> +
> +=3D=3D=3D Avoid freeing external data clusters on failure =3D=3D=3D
> +
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D65536 data_file=3DTE=
ST_DIR/t.IMGFMT.data_file
> +write failed: Input/output error
> +No errors were found on the image.
> +*** done
> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> index 559edc139a..a898fe2c26 100644
> --- a/tests/qemu-iotests/group
> +++ b/tests/qemu-iotests/group
> @@ -294,3 +294,4 @@
>  284 rw
>  286 rw quick
>  288 quick
> +289 rw quick
>=20

--=20
=E2=80=94js


