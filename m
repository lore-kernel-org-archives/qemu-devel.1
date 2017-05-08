Received: from eggs.gnu.org ([2001:4830:134:3::10]:58439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7mps-0001jn-CR
	for qemu-devel@nongnu.org; Mon, 08 May 2017 13:52:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7mpq-0000TF-BB
	for qemu-devel@nongnu.org; Mon, 08 May 2017 13:52:40 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36357)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7mpq-0000Sf-6e
	for qemu-devel@nongnu.org; Mon, 08 May 2017 13:52:38 -0400
Received: by mail-qt0-x244.google.com with SMTP id j13so10556330qta.3
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 10:52:38 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170508045715.21770-1-f4bug@amsat.org>
	<20170508050230.22039-1-f4bug@amsat.org> <87vapb8uf2.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ebe59b22-8600-b906-0194-067d23e042d9@amsat.org>
Date: Mon, 8 May 2017 14:52:34 -0300
MIME-Version: 1.0
In-Reply-To: <87vapb8uf2.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 18/23] shippable: temporary disable
 mips64el-softmmu build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>

On 05/08/2017 08:22 AM, Alex Bennée wrote:
>
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  .shippable.yml | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/.shippable.yml b/.shippable.yml
>> index 6601243060..7e714991f9 100644
>> --- a/.shippable.yml
>> +++ b/.shippable.yml
>> @@ -15,8 +15,9 @@ env:
>>        TARGET_LIST=aarch64-softmmu,aarch64-linux-user
>>      - IMAGE=debian-s390x-cross
>>        TARGET_LIST=s390x-softmmu,s390x-linux-user
>> +    # mips64el-softmmu disabled due to libfdt problem
>>      - IMAGE=debian-mipsel-cross
>> -      TARGET_LIST=mipsel-softmmu,mips64el-softmmu,mipsel-linux-user,mips64el-linux-user
>> +      TARGET_LIST=mipsel-softmmu,mipsel-linux-user,mips64el-linux-user
>>  build:
>>    pre_ci:
>>      - make docker-image-${IMAGE}
>
>
> If you fix the order of your patches you can get rid of this noise.

I'll squash with patch 11 (removing your R-B).

> --
> Alex Bennée
>
