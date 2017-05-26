Received: from eggs.gnu.org ([2001:4830:134:3::10]:58773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dEOVa-0004gW-D3
	for qemu-devel@nongnu.org; Fri, 26 May 2017 19:19:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dEOVX-0002O4-8X
	for qemu-devel@nongnu.org; Fri, 26 May 2017 19:19:02 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:33500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dEOVX-0002Mw-3a
	for qemu-devel@nongnu.org; Fri, 26 May 2017 19:18:59 -0400
Received: by mail-oi0-x243.google.com with SMTP id h4so3874261oib.0
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 16:18:59 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170521032956.27446-1-f4bug@amsat.org>
	<20170521032956.27446-3-f4bug@amsat.org>
	<20170524052123.GJ12279@lemon.lan>
	<20170524053425.GM12279@lemon.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9990e767-03aa-477c-a6d0-031910bd8ef1@amsat.org>
Date: Fri, 26 May 2017 20:18:56 -0300
MIME-Version: 1.0
In-Reply-To: <20170524053425.GM12279@lemon.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 02/24] docker: add --include-files
 argument to 'build' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On 05/24/2017 02:34 AM, Fam Zheng wrote:
> On Wed, 05/24 13:21, Fam Zheng wrote:
>>> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
>>> index 6ddc6e4c2a..68cca25f89 100755
>>> --- a/tests/docker/docker.py
>>> +++ b/tests/docker/docker.py
>>> @@ -237,6 +237,11 @@ class BuildCommand(SubCommand):
>>>                              help="""Specify a binary that will be copied to the
>>>                              container together with all its dependent
>>>                              libraries""")
>>> +        parser.add_argument("--extra-files", "-f", nargs='*',
>>> +                            help="""Specify files that will be sent to the
>>> +                            Docker daemon. The daemon will copy those files into
>>> +                            the built image. The ADD directive of the Dockerfile
>>> +                            specify where a file is placed into the image""")
>>
>> Or more precisely, "The daemon will copy these files into the docker build
>> directory, which can be copied to the built image with ADD directives in
>> Dockerfile"?
>
> Hmm, not copied by daemon, maybe "The files will be sent...". But you have the
> idea.

I tried to keep it simple like this:
"Specify files that will be copied in the Docker image, fulfilling the 
ADD directives from the Dockerfile"
