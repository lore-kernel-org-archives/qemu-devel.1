Received: from eggs.gnu.org ([2001:4830:134:3::10]:44049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dIUmY-0003Pv-Cb
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 02:49:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dIUmV-0000lB-Af
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 02:49:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dIUmV-0000l6-1i
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 02:49:27 -0400
References: <149680989846.5077.9990919734651031991@f98a8425f76e>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7ba2aeea-d2b2-2bf2-3ee2-cbef95a090fb@redhat.com>
Date: Wed, 7 Jun 2017 14:49:18 +0800
MIME-Version: 1.0
In-Reply-To: <149680989846.5077.9990919734651031991@f98a8425f76e>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/2] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, peter.maydell@linaro.org



On 2017=E5=B9=B406=E6=9C=8807=E6=97=A5 12:31, no-reply@patchew.org wrote:
> Hi,
>
> This series seems to have some coding style problems. See output below =
for
> more information:
>
> Type: series
> Subject: [Qemu-devel] [PULL 0/2] Net patches
> Message-id: 1496806444-27910-1-git-send-email-jasowang@redhat.com
>
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
>
> BASE=3Dbase
> n=3D1
> total=3D$(git log --oneline $BASE.. | wc -l)
> failed=3D0
>
> git config --local diff.renamelimit 0
> git config --local diff.renames True
>
> commits=3D"$(git log --format=3D%H --reverse $BASE..)"
> for c in $commits; do
>      echo "Checking PATCH $n/$total: $(git log -n 1 --format=3D%s $c)..=
."
>      if ! git show $c --format=3Demail | ./scripts/checkpatch.pl --mail=
back -; then
>          failed=3D1
>          echo
>      fi
>      n=3D$((n+1))
> done
>
> exit $failed
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Switched to a new branch 'test'
> a0be159 Revert "Change net/socket.c to use socket_*() functions" again
> 0e3dcc6 net/rocker: Cleanup the useless return value check
>
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> Checking PATCH 1/2: net/rocker: Cleanup the useless return value check.=
..
> Checking PATCH 2/2: Revert "Change net/socket.c to use socket_*() funct=
ions" again...
> ERROR: braces {} are necessary for all arms of this statement
> #58: FILE: net/socket.c:495:
> +    if (parse_host_port(&saddr, host_str) < 0)
> [...]
>
> ERROR: braces {} are necessary for all arms of this statement
> #161: FILE: net/socket.c:540:
> +    if (parse_host_port(&saddr, host_str) < 0)
> [...]
>
> ERROR: space required before the open parenthesis '('
> #174: FILE: net/socket.c:551:
> +    for(;;) {
>
> ERROR: braces {} are necessary for all arms of this statement
> #194: FILE: net/socket.c:571:
> +    if (!s)
> [...]
>
> total: 4 errors, 0 warnings, 162 lines checked
>
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>
> =3D=3D=3D OUTPUT END =3D=3D=3D
>
> Test command exited with code: 1
>
>
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org

This patch is a revert, so looks like it was a false positive.

Thanks
