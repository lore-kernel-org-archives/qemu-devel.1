Received: from eggs.gnu.org ([2001:4830:134:3::10]:34757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYuob-0000st-IR
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:56:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYuoW-0003JX-Je
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:56:01 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:42079)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYuoW-0003HY-DW
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:55:56 -0400
Received: by mail-qt0-x243.google.com with SMTP id y31-v6so8051140qty.9
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 07:55:56 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180628164643.9668-1-f4bug@amsat.org>
	<20180628164643.9668-5-f4bug@amsat.org> <876021vg3t.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c0cedd84-3598-7a6b-8ffb-b4f737ab4728@amsat.org>
Date: Fri, 29 Jun 2018 11:55:51 -0300
MIME-Version: 1.0
In-Reply-To: <876021vg3t.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 4/8] docker: Add packages required to
 build a Linux kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Fam Zheng <famz@redhat.com>, Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 06/29/2018 11:09 AM, Alex Bennée wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> Being able to also cross build Linux kernels with our docker cross
>> images allow us to add more complex qemu-system acceptance tests.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> This is not required to build QEMU, so I might resend it in the
>> acceptance-test series which actually requires this patch.
>>
>>  tests/docker/dockerfiles/debian-sid.docker | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/docker/dockerfiles/debian-sid.docker b/tests/docker/dockerfiles/debian-sid.docker
>> index 9a3d168705..846021b032 100644
>> --- a/tests/docker/dockerfiles/debian-sid.docker
>> +++ b/tests/docker/dockerfiles/debian-sid.docker
>> @@ -22,11 +22,15 @@ RUN DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata
>>  RUN DEBIAN_FRONTEND=noninteractive eatmydata \
>>      apt install -y --no-install-recommends \
>>          bison \
>> +        binutils-multiarch \
>>          build-essential \
>>          ca-certificates \
>> +        curl \
>>          flex \
>> +        gettext \
>>          git \
>> +        gnupg \
>>          pkg-config \
>>          psmisc \
>> -        python \
>> +        python-minimal \
> 
> Hmm don't we need full python for QEMU though?

I'm not sure, but the goal of this image is to be useful, not tiny, so
I'm happy with the normal package (I cherry-picked this from an older
series and did not notice this particular change).

> 
>>          texinfo || { echo "Failed to build - see debian-sid.docker notes"; exit 1; }
> 
> 
> --
> Alex Bennée
> 
