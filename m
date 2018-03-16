Received: from eggs.gnu.org ([2001:4830:134:3::10]:35933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewt1s-0004Yo-39
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 13:20:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewt1r-0005Pg-8y
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 13:20:32 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:43333)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ewt1q-0005OM-QO
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 13:20:30 -0400
Received: by mail-oi0-x243.google.com with SMTP id y27so5023629oix.10
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 10:20:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a876446f-d4a4-4df2-c986-4e45a64b9436@redhat.com>
References: <20180316170122.fmo2nghyxpeaq7hp@kamzik.brq.redhat.com>
	<a876446f-d4a4-4df2-c986-4e45a64b9436@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Mar 2018 17:20:09 +0000
Message-ID: <CAFEAcA-4T04uw_KA5+Qn0PGPUVvQu5hk-NKYkiks43GrLAQq0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qemu master build failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Andrew Jones <drjones@redhat.com>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On 16 March 2018 at 17:11, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 16/03/2018 18:01, Andrew Jones wrote:
>> Hi Thomas,
>>
>> QEMU master is failing to build on an AArch64 machine with GCC 4.8. I ge=
t
>>
>>   ...
>>   CC      qemu-nbd.o
>> /home/drjones/code/qemu/qemu-nbd.c: In function =E2=80=98version=E2=80=
=99:
>> /home/drjones/code/qemu/qemu-nbd.c:133:7: error: expected =E2=80=98)=E2=
=80=99 before =E2=80=98QEMU_FULL_VERSION=E2=80=99
>>  "%s " QEMU_FULL_VERSION "\n"
>>        ^
>> /home/drjones/code/qemu/qemu-nbd.c:139:5: error: format =E2=80=98%s=E2=
=80=99 expects a matching =E2=80=98char *=E2=80=99 argument [-Werror=3Dform=
at=3D]
>>      , name);
>>      ^
>> cc1: all warnings being treated as errors
>> make: *** [qemu-nbd.o] Error 1
>>
>>
>> Reverting 7e563bfb8 fixes the build. I figured I'd report it now,
>> but I won't have time to look closer until Monday.
>
> You probably have a stray qemu-version.h file somewhere.  No worries, I
> was puzzled by the same thing after I applied Thomas's patch. :)

Yep, stray qemu-version.h in the source tree. That bit me on one of
my build systems and also mstsirkin...

(MST had a suggestion on IRC that if we used #include <> for generated
headers rather than "" this would avoid that problem because it would
not search the source tree before the build tree. I haven't tested that
idea...)

thanks
-- PMM
