Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BF7C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 12:27:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97D0E2076A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 12:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EkZiXEjD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D0E2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGMAV-0001zU-Pc
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 08:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jGM7l-0006mJ-5I
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 08:24:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jGM7i-0006OI-Ne
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 08:24:09 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:27689)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jGM7i-0006Nx-Gt
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 08:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584966246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+jqvGnNqR6a3bGPMVoWPMoSN+3l45CBZzOgiRZ3+Hds=;
 b=EkZiXEjDiO3kdXgG7HRQeMDtnzMnNmrom1c+wt4To+f5c+OeOlIku1AJ1QLhx3kbOed5Vg
 GuSEK5rQ57WWjRdwtiskmZ9rozKnNxBs9dCRy/VF++EhCl/kvCN3Vcc8TIfl+7kQIL6R53
 Gl7GnR2J4H04PihBDY5zwsaDNE59hlQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-xYzBpNTTO4Wb3zIbVh9Wqg-1; Mon, 23 Mar 2020 08:24:00 -0400
X-MC-Unique: xYzBpNTTO4Wb3zIbVh9Wqg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39408800D5A;
 Mon, 23 Mar 2020 12:23:59 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-242.ams2.redhat.com
 [10.36.114.242])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AA7260BE2;
 Mon, 23 Mar 2020 12:23:57 +0000 (UTC)
Subject: Re: [PATCH] iotests/026: Move v3-exclusive test to new file
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
References: <20200311140707.1243218-1-mreitz@redhat.com>
 <d7c67c4f-67a9-d42d-acbd-8d4bcd5cf4ee@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <1a6b6aea-ace9-4eb0-0c71-5be08fe7f188@redhat.com>
Date: Mon, 23 Mar 2020 13:23:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <d7c67c4f-67a9-d42d-acbd-8d4bcd5cf4ee@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jcPJwa06o9PCWj2shdtbHq6YsJEe2kvfp"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
--jcPJwa06o9PCWj2shdtbHq6YsJEe2kvfp
Content-Type: multipart/mixed; boundary="A9lRdGEV77qomwHlSDf4PReLOfLphmeB4"

--A9lRdGEV77qomwHlSDf4PReLOfLphmeB4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.03.20 23:19, John Snow wrote:
>=20
>=20
> On 3/11/20 10:07 AM, Max Reitz wrote:
>> data_file does not work with v2, and we probably want 026 to keep
>> working for v2 images.  Thus, open a new file for v3-exclusive error
>> path test cases.
>>
>> Fixes: 81311255f217859413c94f2cd9cebf2684bbda94
>>        (=E2=80=9Ciotests/026: Test EIO on allocation in a data-file=E2=
=80=9D)
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
> Let me start this reply with something good, or at least something
> that's not bad. It's value neutral at worst.
>=20
> Reviewed-by: John Snow <jsnow@redhat.com>
> Tested-by: John Snow <jsnow@redhat.com>

Thanks. :)

> Now, let's get cracking on some prime nonsense.
>=20
> I assume this patch is still 'pending'. Here's a complete tangent
> unrelated to your patch in every single way:

Reasonable, but it=E2=80=99s a bit of a shame you bury it here.  I feel lik=
e
this makes it unlikely to reach the people you want to reach.

> What's the best way to use patchew to see series that are "pending" in
> some way? I'd like to:
>=20
> - Search only the block list (to:qemu-block@nongnu.org. I assume this
> catches CCs too.)
> - Exclude series that are merged (-is:merged)
> - Exclude obsoleted series (-is:obsolete)
>=20
> This gets a bit closer to things that are interesting in some way --
> give or take some fuzziness with patchew's detection of "merged" or
> "obsoleted" sometimes.
>=20
> - Exclude pull requests. (-is:pull seems broken, actually.)
> - Exclude reviewed series (-is:reviewed -- what does patchew consider
> 'reviewed'? does this mean fully reviewed, or any reviews?)
>=20
> This gives me something a bit more useful.
>=20
> - Exclude 'expired' series. I use 30 days as a mental model for this. It
> might be nice to formalize this and mark patches that received no
> replies and didn't detect any other state change as "expired" and send
> an autoreply from the bot.
>=20
> (I.e., patches that are complete, applied, passed CI, were not
> obsoleted, did not appear to be merged, and received no replies from
> anyone except the patch author)
>=20
>=20
> ("Hi, this patch received no replies from anyone except the author (you)
> for 30 days. The series is being dropped from the pending queue and is
> being marked expired. If the patches are still important, please rebase
> them and re-send to the list.
>=20
> Please use scripts/get_maintainers.pl to identify candidate maintainers
> and reviewers and make sure they are CC'd.
>=20
> This series appears to touch files owned by the following maintainers:
> - Blah
> - Etc
> - And so on
>=20
> For more information on the contribution process, please visit:
> <wiki links to contribution guides, etc>")
>=20
> We don't have anything like that, so age:<30d suffices. Alright, this
> list is starting to look *pretty* decent.
>=20
> project:QEMU to:qemu-block@nongnu.org not:obsolete not:merged
> -is:reviewed age:<30d
>=20
> Lastly, maybe we can exclude series that don't have replies yet.

Maybe Patchew should ping these after 14 days or so.

That=E2=80=99s about the only thing I can contribute, because I don=E2=80=
=99t really use
Patchew myself...  I keep patches in a subfolder of my inbox on unread;
and I keep my own pending series in a separate folder.  (Before I did
that, I was much more prone to forgetting my own patches rather than
someone else=E2=80=99s.)

Max

> It's
> not clear to patchew which replies are:
>=20
> - Unrelated comments, like this one here
> - Requests for a change
> - A question for the submitter
> - A softly-worded N-A-C-K
>=20
> and without a concept of designated reviewer, perhaps lack of replies is
> good evidence that the series is untouched and needs someone to 'pick it
> up'; (-has:replies)
>=20
> https://patchew.org/search?q=3Dproject%3AQEMU+to%3Aqemu-block%40nongnu.or=
g+not%3Aobsolete+not%3Amerged+-is%3Areviewed+age%3A%3C30d+-has%3Areplies
>=20
> Alright, that's pretty good, actually.
>=20
> OK, yes, this patch still needs love as far as patchew understands.
>=20
>> ---
>>  tests/qemu-iotests/026             | 31 -----------
>>  tests/qemu-iotests/026.out         |  6 --
>>  tests/qemu-iotests/026.out.nocache |  6 --
>>  tests/qemu-iotests/289             | 89 ++++++++++++++++++++++++++++++
>>  tests/qemu-iotests/289.out         |  8 +++
>>  tests/qemu-iotests/group           |  1 +
>>  6 files changed, 98 insertions(+), 43 deletions(-)
>>  create mode 100755 tests/qemu-iotests/289
>>  create mode 100644 tests/qemu-iotests/289.out
>>
>> diff --git a/tests/qemu-iotests/026 b/tests/qemu-iotests/026
>> index b05a4692cf..b9713eb591 100755
>> --- a/tests/qemu-iotests/026
>> +++ b/tests/qemu-iotests/026
>> @@ -240,37 +240,6 @@ $QEMU_IO -c "write 0 $CLUSTER_SIZE" "$BLKDBG_TEST_I=
MG" | _filter_qemu_io
>> =20
>>  _check_test_img
>> =20
>> -echo
>> -echo =3D=3D=3D Avoid freeing external data clusters on failure =3D=3D=
=3D
>> -echo
>> -
>> -# Similar test as the last one, except we test what happens when there
>> -# is an error when writing to an external data file instead of when
>> -# writing to a preallocated zero cluster
>> -_make_test_img -o "data_file=3D$TEST_IMG.data_file" $CLUSTER_SIZE
>> -
>> -# Put blkdebug above the data-file, and a raw node on top of that so
>> -# that blkdebug will see a write_aio event and emit an error
>> -$QEMU_IO -c "write 0 $CLUSTER_SIZE" \
>> -    "json:{
>> -         'driver': 'qcow2',
>> -         'file': { 'driver': 'file', 'filename': '$TEST_IMG' },
>> -         'data-file': {
>> -             'driver': 'raw',
>> -             'file': {
>> -                 'driver': 'blkdebug',
>> -                 'config': '$TEST_DIR/blkdebug.conf',
>> -                 'image': {
>> -                     'driver': 'file',
>> -                     'filename': '$TEST_IMG.data_file'
>> -                 }
>> -             }
>> -         }
>> -     }" \
>> -    | _filter_qemu_io
>> -
>> -_check_test_img
>> -
>>  # success, all done
>>  echo "*** done"
>>  rm -f $seq.full
>> diff --git a/tests/qemu-iotests/026.out b/tests/qemu-iotests/026.out
>> index c1b3b58482..83989996ff 100644
>> --- a/tests/qemu-iotests/026.out
>> +++ b/tests/qemu-iotests/026.out
>> @@ -653,10 +653,4 @@ wrote 1024/1024 bytes at offset 0
>>  1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>  write failed: Input/output error
>>  No errors were found on the image.
>> -
>> -=3D=3D=3D Avoid freeing external data clusters on failure =3D=3D=3D
>> -
>> -Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1024 data_file=3DTE=
ST_DIR/t.IMGFMT.data_file
>> -write failed: Input/output error
>> -No errors were found on the image.
>>  *** done
>> diff --git a/tests/qemu-iotests/026.out.nocache b/tests/qemu-iotests/026=
.out.nocache
>> index 8d5001648a..9359d26d7e 100644
>> --- a/tests/qemu-iotests/026.out.nocache
>> +++ b/tests/qemu-iotests/026.out.nocache
>> @@ -661,10 +661,4 @@ wrote 1024/1024 bytes at offset 0
>>  1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>  write failed: Input/output error
>>  No errors were found on the image.
>> -
>> -=3D=3D=3D Avoid freeing external data clusters on failure =3D=3D=3D
>> -
>> -Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1024 data_file=3DTE=
ST_DIR/t.IMGFMT.data_file
>> -write failed: Input/output error
>> -No errors were found on the image.
>>  *** done
>> diff --git a/tests/qemu-iotests/289 b/tests/qemu-iotests/289
>> new file mode 100755
>> index 0000000000..1c11d4030e
>> --- /dev/null
>> +++ b/tests/qemu-iotests/289
>> @@ -0,0 +1,89 @@
>> +#!/usr/bin/env bash
>> +#
>> +# qcow2 v3-exclusive error path testing
>> +# (026 tests paths common to v2 and v3)
>> +#
>> +# Copyright (C) 2020 Red Hat, Inc.
>> +#
>> +# This program is free software; you can redistribute it and/or modify
>> +# it under the terms of the GNU General Public License as published by
>> +# the Free Software Foundation; either version 2 of the License, or
>> +# (at your option) any later version.
>> +#
>> +# This program is distributed in the hope that it will be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> +#
>> +
>> +seq=3D$(basename $0)
>> +echo "QA output created by $seq"
>> +
>> +status=3D1=09# failure is the default!
>> +
>> +_cleanup()
>> +{
>> +    _cleanup_test_img
>> +    rm "$TEST_DIR/blkdebug.conf"
>> +    rm -f "$TEST_IMG.data_file"
>> +}
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +# get standard environment, filters and checks
>> +. ./common.rc
>> +. ./common.filter
>> +. ./common.pattern
>> +
>> +_supported_fmt qcow2
>> +_supported_proto file
>> +# This is a v3-exclusive test;
>> +# As for data_file, error paths often very much depend on whether
>> +# there is an external data file or not; so we create one exactly when
>> +# we want to test it
>> +_unsupported_imgopts 'compat=3D0.10' data_file
>> +
>> +echo
>> +echo =3D=3D=3D Avoid freeing external data clusters on failure =3D=3D=
=3D
>> +echo
>> +
>> +cat > "$TEST_DIR/blkdebug.conf" <<EOF
>> +[inject-error]
>> +event =3D "write_aio"
>> +errno =3D "5"
>> +once =3D "on"
>> +EOF
>> +
>> +# Test what happens when there is an error when writing to an external
>> +# data file instead of when writing to a preallocated zero cluster
>> +_make_test_img -o "data_file=3D$TEST_IMG.data_file" 64k
>> +
>> +# Put blkdebug above the data-file, and a raw node on top of that so
>> +# that blkdebug will see a write_aio event and emit an error.  This
>> +# will then trigger the alloc abort code, which we want to test here.
>> +$QEMU_IO -c "write 0 64k" \
>> +    "json:{
>> +         'driver': 'qcow2',
>> +         'file': { 'driver': 'file', 'filename': '$TEST_IMG' },
>> +         'data-file': {
>> +             'driver': 'raw',
>> +             'file': {
>> +                 'driver': 'blkdebug',
>> +                 'config': '$TEST_DIR/blkdebug.conf',
>> +                 'image': {
>> +                     'driver': 'file',
>> +                     'filename': '$TEST_IMG.data_file'
>> +                 }
>> +             }
>> +         }
>> +     }" \
>> +    | _filter_qemu_io
>> +
>> +_check_test_img
>> +
>> +# success, all done
>> +echo "*** done"
>> +rm -f $seq.full
>> +status=3D0
>> diff --git a/tests/qemu-iotests/289.out b/tests/qemu-iotests/289.out
>> new file mode 100644
>> index 0000000000..e54e2629d4
>> --- /dev/null
>> +++ b/tests/qemu-iotests/289.out
>> @@ -0,0 +1,8 @@
>> +QA output created by 289
>> +
>> +=3D=3D=3D Avoid freeing external data clusters on failure =3D=3D=3D
>> +
>> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D65536 data_file=3DT=
EST_DIR/t.IMGFMT.data_file
>> +write failed: Input/output error
>> +No errors were found on the image.
>> +*** done
>> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
>> index 559edc139a..a898fe2c26 100644
>> --- a/tests/qemu-iotests/group
>> +++ b/tests/qemu-iotests/group
>> @@ -294,3 +294,4 @@
>>  284 rw
>>  286 rw quick
>>  288 quick
>> +289 rw quick
>>
>=20



--A9lRdGEV77qomwHlSDf4PReLOfLphmeB4--

--jcPJwa06o9PCWj2shdtbHq6YsJEe2kvfp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl54qlgACgkQ9AfbAGHV
z0CR1gf9FxDWvIoKN6mfpovp+L5Uv/PiRPFYpROGt/vNwf8DZOzXAy5Mod/z5ALE
vkSWXS4+iJmiyHhqPCXYXaC7boO3Q6CLM8R8W2V0Do0L/tOMF0xHEX9nR2iFEYFT
Rj7U+mtDNJSvD/ogWeTdbOnGBquIBp6qXsxj3U9rPIHJBtd4zKN8lkAtDU2RsDcP
yGvrWhIcmOn1xFiFsLxwsOxDyjQN4JCWjdcgJmm6sD3cFaLvx50NUUGFvpuRiYUr
AvNJ6nT8/mC2KtBdZzUnBm+zwqBwqquiQ201bPK9WRFGaA2hDDSaDqHfCaddeGZ3
nRc18kBhYh6rHo+ES5wWyuFw4FR3jQ==
=19nH
-----END PGP SIGNATURE-----

--jcPJwa06o9PCWj2shdtbHq6YsJEe2kvfp--


