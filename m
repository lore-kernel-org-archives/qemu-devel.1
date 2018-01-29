Received: from eggs.gnu.org ([2001:4830:134:3::10]:46865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eg8aL-0006JI-1e
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:30:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eg8aJ-0002R2-PL
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:30:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eg8aJ-0002QA-Gz
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:30:51 -0500
References: <151721435440.776.955566177382694120@5adcb62bf0d6>
	<0a17662c-b713-5d96-a6dd-e7b84593f98b@redhat.com>
	<6e79281d-6f87-480e-b1ea-b628055bf8fa@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <847db803-9b7e-c090-eae8-3ab34cac31a6@redhat.com>
Date: Mon, 29 Jan 2018 20:30:43 +0800
MIME-Version: 1.0
In-Reply-To: <6e79281d-6f87-480e-b1ea-b628055bf8fa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/6] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, famz@redhat.com



On 2018=E5=B9=B401=E6=9C=8829=E6=97=A5 18:58, Thomas Huth wrote:
> On 29.01.2018 11:02, Jason Wang wrote:
>>
>> On 2018=E5=B9=B401=E6=9C=8829=E6=97=A5 16:25, no-reply@patchew.org wro=
te:
>>> Hi,
>>>
>>> This series seems to have some coding style problems. See output belo=
w
>>> for
>>> more information:
>>>
>>> Type: series
>>> Message-id: 1517213825-24085-1-git-send-email-jasowang@redhat.com
>>> Subject: [Qemu-devel] [PULL 0/6] Net patches
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
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 echo "Checking PATCH $n/$total: $(git log -=
n 1 --format=3D%s $c)..."
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 if ! git show $c --format=3Demail | ./scrip=
ts/checkpatch.pl
>>> --mailback -; then
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 failed=3D1
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 fi
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 n=3D$((n+1))
>>> done
>>>
>>> exit $failed
>>> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>>>
>>> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
>>>  =C2=A0From https://github.com/patchew-project/qemu
>>>  =C2=A0 * [new tag]
>>> patchew/1517213825-24085-1-git-send-email-jasowang@redhat.com ->
>>> patchew/1517213825-24085-1-git-send-email-jasowang@redhat.com
>>> Switched to a new branch 'test'
>>> f599bb830a MAINTAINERS: update Dmitry Fleytman email
>>> d7e337961c qemu-doc: Get rid of "vlan=3DX" example in the documentati=
on
>>> b7bc06c0f4 net: Allow netdevs to be used with 'hostfwd_add' and
>>> 'hostfwd_remove'
>>> 85b4cac4ac net: Allow hubports to connect to other netdevs
>>> b4a35413c4 colo: compare the packet based on the tcp sequence number
>>> f6781da302 colo: modified the payload compare function
>>>
>>> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
>>> Checking PATCH 1/6: colo: modified the payload compare function...
>>> Checking PATCH 2/6: colo: compare the packet based on the tcp sequenc=
e
>>> number...
>>> Checking PATCH 3/6: net: Allow hubports to connect to other netdevs..=
.
>>> Checking PATCH 4/6: net: Allow netdevs to be used with 'hostfwd_add'
>>> and 'hostfwd_remove'...
>>> ERROR: consider using qemu_strtol in preference to strtol
>>> #72: FILE: net/slirp.c:414:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 n=
c =3D net_hub_find_client_by_name(strtol(hub_id, NULL, 0),
>>> name);
>>>
>>> total: 1 errors, 0 warnings, 73 lines checked
>>>
>>> Your patch has style problems, please review.=C2=A0 If any of these e=
rrors
>>> are false positives report them to the maintainer, see
>>> CHECKPATCH in MAINTAINERS.
>>>
>>> Checking PATCH 5/6: qemu-doc: Get rid of "vlan=3DX" example in the
>>> documentation...
>>> Checking PATCH 6/6: MAINTAINERS: update Dmitry Fleytman email...
>>> =3D=3D=3D OUTPUT END =3D=3D=3D
>>>
>>> Test command exited with code: 1
>> Thomas, want to send a v2 for this patch?
> No, that strtol was already there in the code before my patch, I just
> changed the indentation. If we decide that we want to replace it, this
> should be done by a separate patch instead. Question is: Do we really
> want to replace it here? (the error message is saying "consider ..." -
> so maybe that should also rather be a warning instead of an error messa=
ge?)
>
>   Thomas
>

I see, then I'm fine to keep it as is. Any changes could be done on top.

Thanks
