Received: from eggs.gnu.org ([2001:4830:134:3::10]:44792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebmma-00009i-Pr
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 07:25:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebmmU-0003th-Tq
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 07:25:32 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:43692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebmmU-0003tH-Ln
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 07:25:26 -0500
Received: by mail-qt0-x243.google.com with SMTP id s3so22243261qtb.10
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 04:25:26 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180115143500.22631-1-f4bug@amsat.org>
	<20180115143500.22631-5-f4bug@amsat.org> <873734og3l.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e90885c2-5e8e-605e-bf5d-749b06c2beaf@amsat.org>
Date: Wed, 17 Jan 2018 09:25:22 -0300
MIME-Version: 1.0
In-Reply-To: <873734og3l.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 4/8] docker: do not use Trusty APT
 source in Xenial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 01/17/2018 08:54 AM, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> probably missed in 7fc581c29518
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  tests/docker/dockerfiles/ubuntu.docker | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/dockerfiles/ubuntu.docker
>> index dabbf2a8a4..686d90ae8c 100644
>> --- a/tests/docker/dockerfiles/ubuntu.docker
>> +++ b/tests/docker/dockerfiles/ubuntu.docker
>> @@ -1,6 +1,4 @@
>>  FROM ubuntu:16.04
>> -RUN echo "deb http://archive.ubuntu.com/ubuntu/ trusty universe multiverse" >> \
>> -    /etc/apt/sources.list
> 
> do we not need anything in universe or multiverse?

Since this image is Xenial based, surely not from Trusty :)

This line is now included in the base image, I'll update the commit
description.

> 
>>  RUN apt-get update
>>  ENV PACKAGES flex bison \
>>      libusb-1.0-0-dev libiscsi-dev librados-dev libncurses5-dev libncursesw5-dev \
> 
> 
> --
> Alex Bennée
> 
