Received: from eggs.gnu.org ([2001:4830:134:3::10]:46749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dmcOv-00077e-0o
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dmcOq-0003qv-1F
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:01:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dmcOp-0003qX-Ok
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:01:31 -0400
References: <150338618197.30.13431977153264372738@205a2245145f>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d178cec4-e84f-4a1b-8f83-fa0d85d6f707@redhat.com>
Date: Tue, 29 Aug 2017 17:01:19 +0800
MIME-Version: 1.0
In-Reply-To: <150338618197.30.13431977153264372738@205a2245145f>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V4 0/3] Optimize COLO-compare performance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, zhangchen.fnst@cn.fujitsu.com, famz@redhat.com
Cc: lizhijian@cn.fujitsu.com



On 2017=E5=B9=B408=E6=9C=8822=E6=97=A5 15:16, no-reply@patchew.org wrote:
> Hi,
>
> This series seems to have some coding style problems. See output below =
for
> more information:
>
> Type: series
> Message-id: 1503305719-2512-1-git-send-email-zhangchen.fnst@cn.fujitsu.=
com
> Subject: [Qemu-devel] [PATCH V4 0/3] Optimize COLO-compare performance
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
> 37052358b5 net/colo-compare.c: Fix comments and scheme
> 46824a6565 net/colo-compare.c: Adjust net queue pop order for performan=
ce
> acea048383 net/colo-compare.c: Optimize unpredictable tcp options compa=
rison
>
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> Checking PATCH 1/3: net/colo-compare.c: Optimize unpredictable tcp opti=
ons comparison...
> Checking PATCH 2/3: net/colo-compare.c: Adjust net queue pop order for =
performance...
> Checking PATCH 3/3: net/colo-compare.c: Fix comments and scheme...
> ERROR: space prohibited after that '-' (ctx:WxW)
> #18: FILE: net/colo-compare.c:47:
> +  |   conn list   + - >      conn     + ------- >      conn     + -- >=
 .......
>                       ^
>
> ERROR: space prohibited after that '-' (ctx:OxW)
> #18: FILE: net/colo-compare.c:47:
> +  |   conn list   + - >      conn     + ------- >      conn     + -- >=
 .......
>                                                 ^
>
> ERROR: space required one side of that '--' (ctx:WxW)
> #18: FILE: net/colo-compare.c:47:
> +  |   conn list   + - >      conn     + ------- >      conn     + -- >=
 .......
>                                                                     ^
>
> total: 3 errors, 0 warnings, 40 lines checked
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

Fam, this looks like a false positive since it was actually an ascii=20
graph inside a comment?

Thanks
