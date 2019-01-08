Received: from eggs.gnu.org ([209.51.188.92]:47610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ggvCZ-0000dx-Fd
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:30:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ggvCI-0005GV-LT
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:30:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ggvCI-0005DV-Dd
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:29:50 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-17-fli@suse.com>
	<874lakl5d2.fsf@dusky.pond.sub.org>
	<5007FDD8-8D3A-4E3F-B5A6-9B7B3189238F@126.com>
Date: Tue, 08 Jan 2019 18:29:47 +0100
In-Reply-To: <5007FDD8-8D3A-4E3F-B5A6-9B7B3189238F@126.com> (fei's message of
	"Wed, 9 Jan 2019 00:50:01 +0800")
Message-ID: <87pnt7awhg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v9 16/16] qemu_thread_join: fix
 segmentation fault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: fei <lifei1214@126.com>
Cc: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org, shirley17fei@gmail.com

fei <lifei1214@126.com> writes:

>> =E5=9C=A8 2019=E5=B9=B41=E6=9C=888=E6=97=A5=EF=BC=8C01:55=EF=BC=8CMarkus=
 Armbruster <armbru@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>>=20
>> Fei Li <fli@suse.com> writes:
>>=20
>>> To avoid the segmentation fault in qemu_thread_join(), just directly
>>> return when the QemuThread *thread failed to be created in either
>>> qemu-thread-posix.c or qemu-thread-win32.c.
>>>=20
>>> Cc: Stefan Weil <sw@weilnetz.de>
>>> Signed-off-by: Fei Li <fli@suse.com>
>>> Reviewed-by: Fam Zheng <famz@redhat.com>
>>> ---
>>> util/qemu-thread-posix.c | 3 +++
>>> util/qemu-thread-win32.c | 2 +-
>>> 2 files changed, 4 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
>>> index 39834b0551..3548935dac 100644
>>> --- a/util/qemu-thread-posix.c
>>> +++ b/util/qemu-thread-posix.c
>>> @@ -571,6 +571,9 @@ void *qemu_thread_join(QemuThread *thread)
>>>     int err;
>>>     void *ret;
>>>=20
>>> +    if (!thread->thread) {
>>> +        return NULL;
>>> +    }
>>=20
>> How can this happen?
> I think I have answered this earlier, please check the following link to =
see whether it helps:
> http://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg06554.html

Thanks for the pointer.  Unfortunately, I don't understand your
explanation.  You also wrote there "I will remove this patch in next
version"; looks like you've since changed your mind.

What exactly breaks if we omit this patch?  Assuming something does
break: imagine we did omit this patch, then forgot we ever saw it, and
now you've discovered the breakage.  Write us the bug report, complete
with reproducer.

[...]
