Received: from eggs.gnu.org ([2001:4830:134:3::10]:45512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9MvA-0000Xk-Fw
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 23:41:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9Mv7-0002ka-CC
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 23:41:12 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:47061)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9Mv7-0002kC-66
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 23:41:09 -0400
Received: by mail-qt0-x242.google.com with SMTP id h4-v6so8156027qtn.13
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 20:41:09 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180420024005.30245-1-f4bug@amsat.org>
	<20180420025759.GD17690@lemon.usersys.redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <75c31fea-a067-eaf3-4f12-41d166b77749@amsat.org>
Date: Fri, 20 Apr 2018 00:41:05 -0300
MIME-Version: 1.0
In-Reply-To: <20180420025759.GD17690@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] docker: Rename the amd64 image as
 amd64-cross
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

On 04/19/2018 11:57 PM, Fam Zheng wrote:
> On Thu, 04/19 23:40, Philippe Mathieu-Daudé wrote:
>> Like the other images, this one is also used to cross-compile.
>> Name it accordingly, matching directory pattern.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  tests/docker/Makefile.include                                   | 2 +-
>>  .../{debian-amd64.docker => debian-amd64-cross.docker}          | 0
>>  2 files changed, 1 insertion(+), 1 deletion(-)
>>  rename tests/docker/dockerfiles/{debian-amd64.docker => debian-amd64-cross.docker} (100%)
>>
>> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
>> index de87341528..a113a15f77 100644
>> --- a/tests/docker/Makefile.include
>> +++ b/tests/docker/Makefile.include
>> @@ -49,7 +49,7 @@ docker-image-debian-powerpc-cross: EXTRA_FILES:=$(SRC_PATH)/tests/docker/dockerf
>>  # Enforce dependancies for composite images
>>  docker-image-debian: docker-image-debian9
>>  docker-image-debian8-mxe: docker-image-debian8
>> -docker-image-debian-amd64: docker-image-debian9
>> +docker-image-debian-amd64-cross: docker-image-debian9
>>  docker-image-debian-armel-cross: docker-image-debian9
>>  docker-image-debian-armhf-cross: docker-image-debian9
>>  docker-image-debian-arm64-cross: docker-image-debian9
>> diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
>> similarity index 100%
>> rename from tests/docker/dockerfiles/debian-amd64.docker
>> rename to tests/docker/dockerfiles/debian-amd64-cross.docker
> 
> But the dockerfile is written differently: it doesn't use the --cross-prefix
> configure option, plus, amd64 is usually the "native" arch making it non-cross
> build.

Indeed, the goal of this dockerfile is to let a developer build QEMU
with as much dependencies as possible, without having to install them on
his own workstation.

> What do you need this patch for beside the consistency?

I was thinking it might be easier for Alex to use these images in his
last series "fix building of tests/tcg" (having the same pattern).

On another hand I'm trying to cross-build on a arm32v7 host to be able
to natively run 32-bit qtests [1]. But for that this patch is incomplete.

[1]:
https://github.com/docker-library/official-images#architectures-other-than-amd64

Regards,

Phil.
