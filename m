Received: from eggs.gnu.org ([2001:4830:134:3::10]:51463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWNdw-0006ZM-D7
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:06:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWNds-0006uH-BG
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:06:32 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fWNds-0006t3-2m
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:06:28 -0400
Received: by mail-wm0-x244.google.com with SMTP id v131-v6so3009638wma.1
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 08:06:28 -0700 (PDT)
References: <20180622140223.26056-1-f4bug@amsat.org>
	<20180622142305.GM23296@redhat.com>
	<f693508b-37d0-8eb1-4e08-a69b36088eea@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <f693508b-37d0-8eb1-4e08-a69b36088eea@amsat.org>
Date: Fri, 22 Jun 2018 16:06:25 +0100
Message-ID: <87a7rmvp1q.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] docker: Add fedora-xtensa-cross image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 06/22/2018 11:23 AM, Daniel P. Berrang=C3=A9 wrote:
>> On Fri, Jun 22, 2018 at 11:02:23AM -0300, Philippe Mathieu-Daud=C3=A9 wr=
ote:
>>> As of this commit:
>>>
>>>   $ xtensa-linux-gnu-as -v
>>>   GNU assembler version 2.29.1 (xtensa-linux-gnu) using BFD version ver=
sion 2.29.1-1.fc27
>>>
>>>   $ xtensa-linux-gnu-gcc -v
>>>   Target: xtensa-linux-gnu
>>>   gcc version 7.2.1 20170915 (Red Hat Cross 7.2.1-1) (GCC)
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>>  tests/docker/dockerfiles/fedora-xtensa-cross.docker | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>  create mode 100644 tests/docker/dockerfiles/fedora-xtensa-cross.docker
>>>
>>> diff --git a/tests/docker/dockerfiles/fedora-xtensa-cross.docker b/test=
s/docker/dockerfiles/fedora-xtensa-cross.docker
>>> new file mode 100644
>>> index 0000000000..6f9521520c
>>> --- /dev/null
>>> +++ b/tests/docker/dockerfiles/fedora-xtensa-cross.docker
>>> @@ -0,0 +1,7 @@
>>> +FROM fedora:latest
>>
>> IIRC, we decided using ':latest' is not a good idea because its meaning
>> will change over time and lead to inconsistent results for devs. We saw
>> this before when patchew reported failure on fedora while developers saw
>> nothing, due to patchew having cached a ":latest" image which was differ=
ent.
>
> I totally agree with you :)
>
> "FROM fedora:28" works.

Queued with the fedora:28 fix

>
>>
>>> +ENV PACKAGES \
>>> +    binutils-xtensa-linux-gnu \
>>> +    gcc-xtensa-linux-gnu
>>> +
>>> +RUN dnf install -y $PACKAGES
>>> +RUN rpm -q $PACKAGES | sort > /packages.txt
>>
>>
>> Regards,
>> Daniel
>>


--
Alex Benn=C3=A9e
