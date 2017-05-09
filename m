Received: from eggs.gnu.org ([2001:4830:134:3::10]:47634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d7vBs-00060Z-Hl
	for qemu-devel@nongnu.org; Mon, 08 May 2017 22:47:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d7vBp-0005My-FD
	for qemu-devel@nongnu.org; Mon, 08 May 2017 22:47:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1d7vBp-0005MS-5R
	for qemu-devel@nongnu.org; Mon, 08 May 2017 22:47:53 -0400
References: <149401298097.195.8271310158086528604@c05f1edc8ed1>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a93a627d-6fa7-16ce-a335-a410e3a1337e@redhat.com>
Date: Tue, 9 May 2017 10:47:40 +0800
MIME-Version: 1.0
In-Reply-To: <149401298097.195.8271310158086528604@c05f1edc8ed1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Revert "Change net/socket.c to use
 socket_*() functions" again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, berrange@redhat.com
Cc: famz@redhat.com, stefanha@redhat.com, ashijeetacharya@gmail.com, pbonzini@redhat.com, marcandre.lureau@redhat.com



On 2017=E5=B9=B405=E6=9C=8806=E6=97=A5 03:36, no-reply@patchew.org wrote:
> Hi,
>
> This series seems to have some coding style problems. See output below =
for
> more information:
>
> Type: series
> Subject: [Qemu-devel] [PATCH] Revert "Change net/socket.c to use socket=
_*() functions" again
> Message-id: 20170505162305.15763-1-berrange@redhat.com
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
>  From https://github.com/patchew-project/qemu
>   - [tag update]      patchew/20170504173745.27414-1-eblake@redhat.com =
-> patchew/20170504173745.27414-1-eblake@redhat.com
> Switched to a new branch 'test'
> 89f6b9d Revert "Change net/socket.c to use socket_*() functions" again
>
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> Checking PATCH 1/1: Revert "Change net/socket.c to use socket_*() funct=
ions" again...
> ERROR: braces {} are necessary for all arms of this statement
> #56: FILE: net/socket.c:495:
> +    if (parse_host_port(&saddr, host_str) < 0)
> [...]
>
> ERROR: braces {} are necessary for all arms of this statement
> #159: FILE: net/socket.c:540:
> +    if (parse_host_port(&saddr, host_str) < 0)
> [...]
>
> ERROR: space required before the open parenthesis '('
> #172: FILE: net/socket.c:551:
> +    for(;;) {
>
> ERROR: braces {} are necessary for all arms of this statement
> #192: FILE: net/socket.c:571:
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

Acked-by: Jason Wang <jasowang@redhat.com>
