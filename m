Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD74C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 13:03:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2CF322274
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 13:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aVxuEfqf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2CF322274
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLRPY-0002M7-T0
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 09:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45103)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jLROr-0001rb-E2
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 09:02:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jLROp-00052n-9D
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 09:02:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49909
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jLROp-000528-01
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 09:02:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586178166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S/JyN9hiq6m34WQB/t0aBNzJDrdxFmU7FUACTsBKT7c=;
 b=aVxuEfqf1HR3n3wTS1uZs+sR4ZwtI92JIeW219nD8tfpifIrByiwgMExCIJw+FjPrmNMjG
 KyTG4ZgNMgBtBSlewLZJtPthZ7/hFbPpJFiWP2NEEMIVFe3xU0SKBFCGPiEEOVcQ9ZcIZ4
 pX0mhJ0Ua8HUBjLIZVJP8fEV16ueV1k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-F7BSf-nMPN-vL3QFxF3FwA-1; Mon, 06 Apr 2020 09:02:43 -0400
X-MC-Unique: F7BSf-nMPN-vL3QFxF3FwA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8238C800D4E;
 Mon,  6 Apr 2020 13:02:42 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-161.ams2.redhat.com
 [10.36.114.161])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3560CB19D6;
 Mon,  6 Apr 2020 13:02:38 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] iotests: rework test finding
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200325102131.23270-1-vsementsov@virtuozzo.com>
 <20200325102131.23270-3-vsementsov@virtuozzo.com>
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
Message-ID: <d3ff5ccf-88cc-5be7-d56c-49f394c0ba23@redhat.com>
Date: Mon, 6 Apr 2020 15:02:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200325102131.23270-3-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cgMojx4wl48OTRIyg0Zp1ta2OFW90xKkf"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cgMojx4wl48OTRIyg0Zp1ta2OFW90xKkf
Content-Type: multipart/mixed; boundary="hBCkt9MooVavgjZCcMo1dIt1Oj3SJ7sSp"

--hBCkt9MooVavgjZCcMo1dIt1Oj3SJ7sSp
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.03.20 11:21, Vladimir Sementsov-Ogievskiy wrote:
> Add python script with new logic of searching for tests:
>=20
> Old behavior:
>  - tests are named [0-9][0-9][0-9]
>  - tests must be registered in group file (even if test doesn't belong
>    to any group, like 142)
>=20
> New behavior:
>  - group file is dropped
>  - tests are searched by file-name instead of group file, so it's not
>    needed more to "register the test", just create it with name
>    test-*. Old names like [0-9][0-9][0-9] are supported too, but not
>    recommended for new tests
>  - groups are parsed from '# group: ' line inside test files
>  - optional file group.local may be used to define some additional
>    groups for downstreams
>  - 'disabled' group is used to temporary disable tests. So instead of
>    commenting tests in old 'group' file you now can add them to
>    disabled group with help of 'group.local' file
>=20
> Benefits:
>  - no rebase conflicts in group file on patch porting from branch to
>    branch
>  - no conflicts in upstream, when different series want to occupy same
>    test number
>  - meaningful names for test files
>    For example, with digital number, when some person wants to add some
>    test about block-stream, he most probably will just create a new
>    test. But if there would be test-block-stream test already, he will
>    at first look at it and may be just add a test-case into it.
>    And anyway meaningful names are better and test-* notation is
>    already used in tests directory.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  docs/devel/testing.rst           |  51 +++++-
>  tests/qemu-iotests/check         |  20 +--
>  tests/qemu-iotests/find_tests.py |  72 ++++++++
>  tests/qemu-iotests/group         | 298 -------------------------------
>  4 files changed, 132 insertions(+), 309 deletions(-)
>  create mode 100755 tests/qemu-iotests/find_tests.py
>  delete mode 100644 tests/qemu-iotests/group

[...]

> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index f7a2d3d6c3..09b2ced2f0 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -168,9 +168,7 @@ do
>      if $group
>      then
>          # arg after -g
> -        group_list=3D$(sed -n <"$source_iotests/group" -e 's/$/ /' -e "/=
^[0-9][0-9][0-9].* $r /"'{
> -s/ .*//p
> -}')
> +        group_list=3D$(./find_tests.py "$r")
>          if [ -z "$group_list" ]
>          then
>              echo "Group \"$r\" is empty or not defined?"
> @@ -193,10 +191,8 @@ s/ .*//p
>      then
>          # arg after -x
>          # Populate $tmp.list with all tests
> -        awk '/^[0-9]{3,}/ {print $1}' "${source_iotests}/group" > $tmp.l=
ist 2>/dev/null
> -        group_list=3D$(sed -n <"$source_iotests/group" -e 's/$/ /' -e "/=
^[0-9][0-9][0-9].* $r /"'{
> -s/ .*//p
> -}')
> +        ./find_tests.py > $tmp.list 2>/dev/null
> +        group_list=3D$(./find_tests.py "$r")
>          if [ -z "$group_list" ]
>          then
>              echo "Group \"$r\" is empty or not defined?"
> @@ -486,10 +482,14 @@ testlist options
>              fi
>              ;;
> =20
> -        *)
> +        [0-9]*)
>              start=3D$r
>              end=3D$r
>              ;;
> +        *)

Should this be test-*, or do we really want to allow any filename here?

> +            echo $r >> $tmp.list
> +            xpand=3Dfalse
> +            ;;
> =20
>      esac
> =20
> @@ -504,7 +504,7 @@ testlist options
>  BEGIN        { for (t=3D'$start'; t<=3D'$end'; t++) printf "%03d\n",t }'=
 \
>          | while read id
>          do
> -            if grep -s "^$id\( \|\$\)" "$source_iotests/group" >/dev/nul=
l
> +            if (./find_tests.py | grep "$id")

I... Actually have no idea what this loop is supposed to do, but
couldn=92t we cache the find_tests.py output?

>              then
>                  # in group file ... OK
>                  echo $id >>$tmp.list
> @@ -566,7 +566,7 @@ else
>          touch $tmp.list
>      else
>          # no test numbers, do everything from group file
> -        sed -n -e '/^[0-9][0-9][0-9]*/s/^\([0-9]*\).*/\1/p' <"$source_io=
tests/group" >$tmp.list
> +        find_tests.py > $tmp.list
>      fi
>  fi
> =20

The modifications to check seem a bit too tame to me.  Can=92t we do some
more radical changes to drastically reduce the complexity of the check
script and move it to the new Python script?  Do we need the whole code
to handle a number of groups and excluded groups there?  Can=92t we just
give the Python scripts a list of groups to include and a list of groups
to exclude and let it handle the rest?

> diff --git a/tests/qemu-iotests/find_tests.py b/tests/qemu-iotests/find_t=
ests.py
> new file mode 100755
> index 0000000000..5de0615ebc
> --- /dev/null
> +++ b/tests/qemu-iotests/find_tests.py
> @@ -0,0 +1,72 @@
> +#!/usr/bin/env python3
> +
> +import os
> +import glob
> +from collections import defaultdict
> +
> +
> +class TestFinder:
> +    def __init__(self):
> +        self.groups =3D defaultdict(set)
> +        self.all_tests =3D glob.glob('[0-9][0-9][0-9]')
> +
> +        self.all_tests +=3D [f for f in glob.iglob('test-*')
> +                           if not f.endswith('.out')]
> +
> +        for t in self.all_tests:
> +            with open(t) as f:
> +                for line in f:
> +                    if line.startswith('# group: '):
> +                        for g in line.split()[2:]:
> +                            self.groups[g].add(t)
> +
> +    def add_group_file(self, fname):
> +        with open(fname) as f:
> +            for line in f:
> +                line =3D line.strip()
> +
> +                if (not line) or line[0] =3D=3D '#':
> +                    continue
> +
> +                words =3D line.split()
> +                test_file =3D words[0]
> +                groups =3D words[1:]
> +
> +                if test_file not in self.all_tests:
> +                    print('Warning: {}: "{}" test is not found. '
> +                          'Skip.'.format(fname, test_file))
> +                    continue
> +
> +                for g in groups:
> +                    self.groups[g].add(test_file)> +
> +    def find_tests(self, group=3DNone):
> +        if group is None:
> +            tests =3D self.all_tests

Should we exclude the disabled group here?

> +        elif group not in self.groups:
> +            tests =3D []
> +        elif group !=3D 'disabled' and 'disabled' in self.groups:
> +            tests =3D self.groups[group] - self.groups['disabled']
> +        else:
> +            tests =3D self.groups[group]
> +
> +        return sorted(tests)
> +
> +
> +if __name__ =3D=3D '__main__':
> +    import sys
> +
> +    if len(sys.argv) > 2:
> +        print("Usage ./find_tests.py [group]")
> +        sys.exit(1)
> +
> +    tf =3D TestFinder()
> +    if os.path.isfile('group'):
> +        tf.add_group_file('group')

So is it =93group=94 or =94group.local=94? :)

Max

> +
> +    if len(sys.argv) =3D=3D 2:
> +        tests =3D tf.find_tests(sys.argv[1])
> +    else:
> +        tests =3D tf.find_tests()
> +
> +    print('\n'.join(tests))


--hBCkt9MooVavgjZCcMo1dIt1Oj3SJ7sSp--

--cgMojx4wl48OTRIyg0Zp1ta2OFW90xKkf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6LKG0ACgkQ9AfbAGHV
z0DCwQgAqN0cwuHugawiFVoN4wa899ygwXjEoAVGVe4S7qX9oh4UM1gK84l/qPk4
QlYRR0rlCOrdjGgYA1Wxywuqz+kaaP65ePlKbVTBxuNLyyGFKSX3xeOZMsVLCE6O
bcBkG78+3D+QzBxYL+EXSIJtN1JB29BHGLBBK81ITxcYqFtcUXTKUw/bajFl9wlU
Rde7U0XOfwwKYqFkosycHPwAmHkFL6qhgxCvrydPPtK10StcUJ7lyL02uH354BgL
uRP0cylMPUMIPFhT10fPoHZdrayTd8LaGwJBy7sy81saB1zEraTnsIaAMTU1xa8r
2hxRU373s5Y8vuTAnFzkFBLGXpLctA==
=xJ5D
-----END PGP SIGNATURE-----

--cgMojx4wl48OTRIyg0Zp1ta2OFW90xKkf--


