Received: from eggs.gnu.org ([209.51.188.92]:50195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLq9I-0004PW-FF
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:23:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLq9F-0003ko-DT
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:23:52 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLq9F-0003kJ-6C
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:23:49 -0400
Received: by mail-wr1-x441.google.com with SMTP id k23so1799583wrd.4
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 07:23:49 -0700 (PDT)
References: <20190428155451.15653-1-thuth@redhat.com>
	<20190428155451.15653-3-thuth@redhat.com>
	<877eba77ps.fsf@zen.linaroharston>
	<3911e5a6-fe1c-9b4b-d6f8-2da54a47742c@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <3911e5a6-fe1c-9b4b-d6f8-2da54a47742c@redhat.com>
Date: Wed, 01 May 2019 15:23:46 +0100
Message-ID: <8736ly6yod.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/8] tests/qemu-iotests/005: Add a
 sanity check for large sparse file support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Ed Maste <emaste@freebsd.org>, Christophe Fergeau <cfergeau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Markus Armbruster <armbru@redhat.com>


Thomas Huth <thuth@redhat.com> writes:

> On 01/05/2019 13.08, Alex Benn=C3=A9e wrote:
>>
>> Thomas Huth <thuth@redhat.com> writes:
>>
>>> "check -raw 005" fails when running on ext4 filesystems - these do not
>>> support such large sparse files. Use the same check as in test 220 to
>>> skip the test in this case.
>>>
>>> Suggested-by: Eric Blake <eblake@redhat.com>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  tests/qemu-iotests/005 | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/tests/qemu-iotests/005 b/tests/qemu-iotests/005
>>> index 2fef63af88..6136ced5c8 100755
>>> --- a/tests/qemu-iotests/005
>>> +++ b/tests/qemu-iotests/005
>>> @@ -55,6 +55,15 @@ if [ "$IMGPROTO" =3D "sheepdog" ]; then
>>>      _notrun "image protocol $IMGPROTO does not support large image siz=
es"
>>>  fi
>>>
>>> +# Sanity check: For raw, we require a file system that permits the cre=
ation
>>> +# of a HUGE (but very sparse) file.  tmpfs works, ext4 does not.
>>
>> Is this comment correct? Running on my ext4 home partition this test
>> seems to be running fine and not skipping.
> Maybe it depends on the kernel version (I'm still using a 3.10-based
> kernel here) or the way how the file system was created? It fails at
> least for me on my ext4 partition.
> But I can adjust a little bit for sure.

  # Sanity check: For raw, we require a file system that permits the
  # creation of a HUGE (but very sparse) file. Check we can create such
  # a file before continuing.

?

>
>  Thomas


--
Alex Benn=C3=A9e
