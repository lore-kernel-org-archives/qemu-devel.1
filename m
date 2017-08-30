Received: from eggs.gnu.org ([2001:4830:134:3::10]:43191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dms6f-0001Yo-2U
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 21:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dms6b-0005Lk-UD
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 21:47:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dms6b-0005LY-LA
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 21:47:45 -0400
References: <150338618197.30.13431977153264372738@205a2245145f>
	<d178cec4-e84f-4a1b-8f83-fa0d85d6f707@redhat.com>
	<20170829104526.GA8146@lemon>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a4d51cbf-1506-a38c-54b8-06d8d55e28a3@redhat.com>
Date: Wed, 30 Aug 2017 09:47:35 +0800
MIME-Version: 1.0
In-Reply-To: <20170829104526.GA8146@lemon>
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
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com



On 2017=E5=B9=B408=E6=9C=8829=E6=97=A5 18:45, Fam Zheng wrote:
> On Tue, 08/29 17:01, Jason Wang wrote:
>>
>> On 2017=E5=B9=B408=E6=9C=8822=E6=97=A5 15:16, no-reply@patchew.org wro=
te:
>>> Hi,
>>>
>>> This series seems to have some coding style problems. See output belo=
w for
>>> more information:
>>>
>>> Type: series
>>> Message-id: 1503305719-2512-1-git-send-email-zhangchen.fnst@cn.fujits=
u.com
>>> Subject: [Qemu-devel] [PATCH V4 0/3] Optimize COLO-compare performanc=
e
>>>
>>> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
>>> #!/bin/bash
>>>
>>> BASE=3Dbase
>>> n=3D1
>>> total=3D$(git log --oneline $BASE.. | wc -l)
>>> failed=3D0
>>>
>>> git config --local diff.renamelimit 0
>>> git config --local diff.renames True
>>>
>>> commits=3D"$(git log --format=3D%H --reverse $BASE..)"
>>> for c in $commits; do
>>>       echo "Checking PATCH $n/$total: $(git log -n 1 --format=3D%s $c=
)..."
>>>       if ! git show $c --format=3Demail | ./scripts/checkpatch.pl --m=
ailback -; then
>>>           failed=3D1
>>>           echo
>>>       fi
>>>       n=3D$((n+1))
>>> done
>>>
>>> exit $failed
>>> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>>>
>>> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
>>> Switched to a new branch 'test'
>>> 37052358b5 net/colo-compare.c: Fix comments and scheme
>>> 46824a6565 net/colo-compare.c: Adjust net queue pop order for perform=
ance
>>> acea048383 net/colo-compare.c: Optimize unpredictable tcp options com=
parison
>>>
>>> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
>>> Checking PATCH 1/3: net/colo-compare.c: Optimize unpredictable tcp op=
tions comparison...
>>> Checking PATCH 2/3: net/colo-compare.c: Adjust net queue pop order fo=
r performance...
>>> Checking PATCH 3/3: net/colo-compare.c: Fix comments and scheme...
>>> ERROR: space prohibited after that '-' (ctx:WxW)
>>> #18: FILE: net/colo-compare.c:47:
>>> +  |   conn list   + - >      conn     + ------- >      conn     + --=
 > .......
>>>                        ^
>>>
>>> ERROR: space prohibited after that '-' (ctx:OxW)
>>> #18: FILE: net/colo-compare.c:47:
>>> +  |   conn list   + - >      conn     + ------- >      conn     + --=
 > .......
>>>                                                  ^
>>>
>>> ERROR: space required one side of that '--' (ctx:WxW)
>>> #18: FILE: net/colo-compare.c:47:
>>> +  |   conn list   + - >      conn     + ------- >      conn     + --=
 > .......
>>>                                                                      =
^
>>>
>>> total: 3 errors, 0 warnings, 40 lines checked
>>>
>>> Your patch has style problems, please review.  If any of these errors
>>> are false positives report them to the maintainer, see
>>> CHECKPATCH in MAINTAINERS.
>>>
>>> =3D=3D=3D OUTPUT END =3D=3D=3D
>>>
>>> Test command exited with code: 1
>>>
>>>
>>> ---
>>> Email generated automatically by Patchew [http://patchew.org/].
>>> Please send your feedback to patchew-devel@freelists.org
>> Fam, this looks like a false positive since it was actually an ascii g=
raph
>> inside a comment?
>>
> Yes, let's just ignore this report.
>
> Fam

Thanks.

I've queued this series.
