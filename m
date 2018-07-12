Received: from eggs.gnu.org ([2001:4830:134:3::10]:41229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fdZ59-0001Mc-14
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 06:44:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fdZ55-0007KH-0I
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 06:44:19 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:46327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fdZ54-0007I9-NS
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 06:44:14 -0400
Received: by mail-ed1-x541.google.com with SMTP id r17-v6so21520461edo.13
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 03:44:14 -0700 (PDT)
References: <20180709152117.21585-1-alex.bennee@linaro.org>
	<20180709152117.21585-3-alex.bennee@linaro.org>
	<1de61649-ac83-234a-0d97-3f9f4b51767e@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1de61649-ac83-234a-0d97-3f9f4b51767e@amsat.org>
Date: Thu, 12 Jul 2018 11:44:12 +0100
Message-ID: <87pnzsd98j.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 3.0 02/10] docker: debian-tricore add
 git tools
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 07/09/2018 12:21 PM, Alex Benn=C3=A9e wrote:
>> As we check out we need git installed before we start. We would have
>> had this based on the heavier qemu:debian9 image but we only use plain
>> debian:9 here.
>
> I first thought "weird, I checked this already" then noticed you rebased
> on debian:9.
> 'stretch-slim' is an alias for '9-slim' and should be tinier (the
> previous RFC image is 323MB).

Hmm why not just switch to qemu:debian9 as we need the compiler as well?
It's not like there will be many users only carrying this image in their
docker setup.

>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>> ---
>>  tests/docker/dockerfiles/debian-tricore-cross.docker | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/test=
s/docker/dockerfiles/debian-tricore-cross.docker
>> index 898b8dd511..5ba3ca88a7 100644
>> --- a/tests/docker/dockerfiles/debian-tricore-cross.docker
>> +++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
>> @@ -11,6 +11,9 @@ FROM debian:9
>>
>>  MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>
>> +RUN apt-get update && \
>> +    DEBIAN_FRONTEND=3Dnoninteractive apt-get install -yy git
>> +
>>  RUN git clone --single-branch \
>>          https://github.com/bkoppelmann/tricore-binutils.git \
>>          /usr/src/binutils && \
>>


--
Alex Benn=C3=A9e
