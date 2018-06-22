Received: from eggs.gnu.org ([2001:4830:134:3::10]:44724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWN8B-00072Y-8a
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:33:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWN87-0007ZH-90
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:33:43 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:34813)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWN87-0007Z3-2b
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:33:39 -0400
Received: by mail-qk0-x242.google.com with SMTP id q70-v6so3773130qke.1
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 07:33:38 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180622140223.26056-1-f4bug@amsat.org>
	<20180622142305.GM23296@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f693508b-37d0-8eb1-4e08-a69b36088eea@amsat.org>
Date: Fri, 22 Jun 2018 11:33:33 -0300
MIME-Version: 1.0
In-Reply-To: <20180622142305.GM23296@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH] docker: Add fedora-xtensa-cross image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org

On 06/22/2018 11:23 AM, Daniel P. Berrangé wrote:
> On Fri, Jun 22, 2018 at 11:02:23AM -0300, Philippe Mathieu-Daudé wrote:
>> As of this commit:
>>
>>   $ xtensa-linux-gnu-as -v
>>   GNU assembler version 2.29.1 (xtensa-linux-gnu) using BFD version version 2.29.1-1.fc27
>>
>>   $ xtensa-linux-gnu-gcc -v
>>   Target: xtensa-linux-gnu
>>   gcc version 7.2.1 20170915 (Red Hat Cross 7.2.1-1) (GCC)
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  tests/docker/dockerfiles/fedora-xtensa-cross.docker | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>  create mode 100644 tests/docker/dockerfiles/fedora-xtensa-cross.docker
>>
>> diff --git a/tests/docker/dockerfiles/fedora-xtensa-cross.docker b/tests/docker/dockerfiles/fedora-xtensa-cross.docker
>> new file mode 100644
>> index 0000000000..6f9521520c
>> --- /dev/null
>> +++ b/tests/docker/dockerfiles/fedora-xtensa-cross.docker
>> @@ -0,0 +1,7 @@
>> +FROM fedora:latest
> 
> IIRC, we decided using ':latest' is not a good idea because its meaning
> will change over time and lead to inconsistent results for devs. We saw
> this before when patchew reported failure on fedora while developers saw
> nothing, due to patchew having cached a ":latest" image which was different.

I totally agree with you :)

"FROM fedora:28" works.

> 
>> +ENV PACKAGES \
>> +    binutils-xtensa-linux-gnu \
>> +    gcc-xtensa-linux-gnu
>> +
>> +RUN dnf install -y $PACKAGES
>> +RUN rpm -q $PACKAGES | sort > /packages.txt
> 
> 
> Regards,
> Daniel
> 
