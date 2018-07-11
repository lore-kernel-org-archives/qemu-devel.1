Received: from eggs.gnu.org ([2001:4830:134:3::10]:55309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fd2fc-00077f-0Y
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 20:07:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fd2fX-0006O4-S0
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 20:07:47 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:41094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fd2fX-0006Nw-No
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 20:07:43 -0400
Received: by mail-qt0-x242.google.com with SMTP id e19-v6so5766303qtp.8
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 17:07:43 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20180709152117.21585-1-alex.bennee@linaro.org>
	<20180709152117.21585-3-alex.bennee@linaro.org>
	<1de61649-ac83-234a-0d97-3f9f4b51767e@amsat.org>
Message-ID: <98422236-678c-1f18-35d9-94295f24c987@amsat.org>
Date: Tue, 10 Jul 2018 21:07:37 -0300
MIME-Version: 1.0
In-Reply-To: <1de61649-ac83-234a-0d97-3f9f4b51767e@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 07/10/2018 05:44 PM, Philippe Mathieu-Daudé wrote:
> On 07/09/2018 12:21 PM, Alex Bennée wrote:
>> As we check out we need git installed before we start. We would have
>> had this based on the heavier qemu:debian9 image but we only use plain
>> debian:9 here.
> 
> I first thought "weird, I checked this already" then noticed you rebased
> on debian:9.
> 'stretch-slim' is an alias for '9-slim' and should be tinier (the
> previous RFC image is 323MB).
> 
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>> ---
>>  tests/docker/dockerfiles/debian-tricore-cross.docker | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tests/docker/dockerfiles/debian-tricore-cross.docker
>> index 898b8dd511..5ba3ca88a7 100644
>> --- a/tests/docker/dockerfiles/debian-tricore-cross.docker
>> +++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
>> @@ -11,6 +11,9 @@ FROM debian:9
>>  
>>  MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
>>  
>> +RUN apt-get update && \
>> +    DEBIAN_FRONTEND=noninteractive apt-get install -yy git
>> +
>>  RUN git clone --single-branch \
>>          https://github.com/bkoppelmann/tricore-binutils.git \
>>          /usr/src/binutils && \
>>

Apparently this is not enough:

 ---> Running in a044a41d4521
Cloning into '/usr/src/binutils'...
Configuring for a x86_64-unknown-linux-gnu host.
Created "Makefile" in /usr/src/binutils
./configure: 8: /tmp/cNf15/cNf15.pos: cc: not found
*** The command 'cc -o conftest -w   conftest.c' failed.
*** You must set the environment variable CC to a working compiler.
subprocess.CalledProcessError: Command '['docker', 'build', '-t',
'qemu:debian-tricore-cross', '-f',
'/tmp/docker_build10CkqB/tmpEx12gW.docker', '/tmp/docker_build10CkqB']'
returned non-zero exit status 1
make: *** [docker-image-debian-tricore-cross] Error 1
