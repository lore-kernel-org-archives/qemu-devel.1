Received: from eggs.gnu.org ([2001:4830:134:3::10]:53120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dvJZf-0001HQ-1U
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 04:44:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dvJZd-0006yy-VA
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 04:44:39 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:43551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dvJZd-0006x6-OU
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 04:44:37 -0400
Received: by mail-wm0-x22b.google.com with SMTP id m72so1134426wmc.0
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 01:44:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87vakbi1hj.fsf@secure.laptop>
References: <20170921230812.7095-1-quintela@redhat.com>
	<150603654377.39.6000423576102095707@d650bbe78fe3>
	<20170922055146.GI30661@pxdev.xzpeter.org>
	<87vakbi1hj.fsf@secure.laptop>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Sep 2017 09:44:16 +0100
Message-ID: <CAFEAcA_Lm9zpakMbqepJeSygLxdHQVm6SSN2sNjiQJcp2vcoGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/18] Migration PULL request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 22 September 2017 at 09:25, Juan Quintela <quintela@redhat.com> wrote:
> Peter Xu <peterx@redhat.com> wrote:
>> On Thu, Sep 21, 2017 at 04:29:04PM -0700, no-reply@patchew.org wrote:
>>
>> [...]
>>
>>> /var/tmp/patchew-tester-tmp-b0y2ycie/src/util/bitmap.c: In function =E2=
=80=98bitmap_to_from_le=E2=80=99:
>>> /var/tmp/patchew-tester-tmp-b0y2ycie/src/util/bitmap.c:383:6: error: "_=
_WORD_SIZE" is not defined [-Werror=3Dundef]
>>>  # if __WORD_SIZE =3D=3D 64
>>>       ^~~~~~~~~~~
>>>   CC      util/acl.o
>>> cc1: all warnings being treated as errors
>>> /var/tmp/patchew-tester-tmp-b0y2ycie/src/rules.mak:66: recipe for targe=
t 'util/bitmap.o' failed
>>> make: *** [util/bitmap.o] Error 1
>>> make: *** Waiting for unfinished jobs....
>>> =3D=3D=3D OUTPUT END =3D=3D=3D
>>>
>>> Test command exited with code: 2
>>
>> This is the same error with previous one.  We need to replace the
>> single usage of __WORD_SIZE into either __WORDSIZE or HOST_LONG_BITS
>> (as suggested by Dave).
>>
>> Again, please let me know if you want me to repost, and sorry for the
>> trouble!
>
> I think we can let that in in the PULL request and fix it later if
> needed, not?

No, a compile failure will always make me reject a merge. Otherwise
I can't easily test anybody else's subsequent merge, and also
patchew will send complaining emails to every patch that's posted
to the list until the breakage in master is fixed...

thanks
-- PMM
