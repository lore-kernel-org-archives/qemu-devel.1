Received: from eggs.gnu.org ([2001:4830:134:3::10]:32942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1clFMe-0001yC-11
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 08:41:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1clFMb-0006Ws-Gc
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 08:41:20 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:37602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1clFMb-0006WF-AQ
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 08:41:17 -0500
Received: by mail-wm0-x229.google.com with SMTP id n11so5109886wma.0
	for <qemu-devel@nongnu.org>; Tue, 07 Mar 2017 05:41:17 -0800 (PST)
References: <20170306112848.659-1-alex.bennee@linaro.org>
	<20170307103744.GA6117@lemon.lan>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170307103744.GA6117@lemon.lan>
Date: Tue, 07 Mar 2017 13:41:23 +0000
Message-ID: <87d1dti4qk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] docker/dockerfiles/debian-s390-cross:
 include clang
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org


Fam Zheng <famz@redhat.com> writes:

> On Mon, 03/06 11:28, Alex Bennée wrote:
>> It's a silly little limitation on Shippable that is looks for clang
>> in the container even though we won't use it. The arm/aarch64 cross
>> builds inherit this from debian.docker but as we needed to use
>> debian-testing for this we add it here. We also collapse the update
>> step into one RUN line to remove and intermediate layer of the docker
>> build.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>  tests/docker/dockerfiles/debian-s390x-cross.docker | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
>> index bbb21ed088..3a687feda0 100644
>> --- a/tests/docker/dockerfiles/debian-s390x-cross.docker
>> +++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
>> @@ -13,8 +13,8 @@ RUN cat /etc/apt/sources.list | sed "s/deb/deb-src/" >> /etc/apt/sources.list
>>  RUN dpkg --add-architecture s390x
>>
>>  # Grab the updated list of packages
>> -RUN apt update
>> -RUN apt dist-upgrade -yy
>> +RUN apt update && apt dist-upgrade -yy
>> +RUN apt install -yy build-essential clang
>>  RUN apt-get build-dep -yy -a s390x qemu || apt-get -f install
>>  RUN apt install -yy gcc-multilib-s390x-linux-gnu binutils-multiarch
>>
>> --
>> 2.11.0
>>
>
> Looks sane. Is this for 2.9?

Yes please. The s390x cross build on shippable is currently broken
without it although we can use the container locally.

--
Alex Bennée
