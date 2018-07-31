Received: from eggs.gnu.org ([2001:4830:134:3::10]:36164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fkUgL-0008RH-HI
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 09:27:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fkUgI-0000Su-9v
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 09:27:21 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:53185)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fkUgI-0000SZ-17
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 09:27:18 -0400
Received: by mail-wm0-x243.google.com with SMTP id o11-v6so3068158wmh.2
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 06:27:17 -0700 (PDT)
References: <153303988145.29412.13761534940635173122@502c9da6d61e>
	<48b6bd17-feff-5f4b-05a7-4bc2370ea212@vivier.eu>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <48b6bd17-feff-5f4b-05a7-4bc2370ea212@vivier.eu>
Date: Tue, 31 Jul 2018 14:27:15 +0100
Message-ID: <87sh3z8rik.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/3] Linux user for 3.0 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, famz@redhat.com, riku.voipio@iki.fi


Laurent Vivier <laurent@vivier.eu> writes:

> Le 31/07/2018 =C3=A0 14:24, no-reply@patchew.org a =C3=A9crit:
>> Hi,
>>
>> This series seems to have some coding style problems. See output below f=
or
>> more information:
>>
>> Type: series
>> Message-id: 20180731084203.29959-1-laurent@vivier.eu
>> Subject: [Qemu-devel] [PULL 0/3] Linux user for 3.0 patches
>>
>> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
>> #!/bin/bash
>>
>> BASE=3Dbase
>> n=3D1
>> total=3D$(git log --oneline $BASE.. | wc -l)
>> failed=3D0
>>
>> git config --local diff.renamelimit 0
>> git config --local diff.renames True
>> git config --local diff.algorithm histogram
>>
>> commits=3D"$(git log --format=3D%H --reverse $BASE..)"
>> for c in $commits; do
>>     echo "Checking PATCH $n/$total: $(git log -n 1 --format=3D%s $c)..."
>>     if ! git show $c --format=3Demail | ./scripts/checkpatch.pl --mailba=
ck -; then
>>         failed=3D1
>>         echo
>>     fi
>>     n=3D$((n+1))
>> done
>>
>> exit $failed
>> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>>
>> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
>> Switched to a new branch 'test'
>> 806398c875 linux-user: ppc64: don't use volatile register during safe_sy=
scall
>> ba78346662 tests: add check_invalid_maps to test-mmap
>> 80fc1be868 linux-user/mmap.c: handle invalid len maps correctly
>>
>> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
>> Checking PATCH 1/3: linux-user/mmap.c: handle invalid len maps correctly=
...
>> Checking PATCH 2/3: tests: add check_invalid_maps to test-mmap...
>> ERROR: code indent should never use tabs
>> #62: FILE: tests/tcg/multiarch/test-mmap.c:498:
>> +^Icheck_invalid_mmaps();$

Sorry I should of flagged this in the commit message. I left the touched
bits as is and used spaces for new functions.

>>
>> total: 1 errors, 0 warnings, 40 lines checked
>
> I'm going to resend a pull request without the tab.
>
> Thanks,
> Laurent


--
Alex Benn=C3=A9e
