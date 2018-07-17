Received: from eggs.gnu.org ([2001:4830:134:3::10]:50315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffG9A-00056J-MV
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 22:55:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffG96-0002Wz-Pn
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 22:55:28 -0400
Received: from mail-ua0-x242.google.com ([2607:f8b0:400c:c08::242]:42343)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffG96-0002Ws-Js
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 22:55:24 -0400
Received: by mail-ua0-x242.google.com with SMTP id w7-v6so3473005uan.9
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 19:55:24 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180713121741.19262-1-alex.bennee@linaro.org>
	<20180713121741.19262-4-alex.bennee@linaro.org>
	<87601jclkq.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2eec22eb-e169-52fc-2d26-763b12934b48@amsat.org>
Date: Mon, 16 Jul 2018 23:55:18 -0300
MIME-Version: 1.0
In-Reply-To: <87601jclkq.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 for 3.0 03/16] shippable: Build the
 TriCore docker image
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

On 07/13/2018 10:27 AM, Alex Bennée wrote:
> 
> Alex Bennée <alex.bennee@linaro.org> writes:
> 
>> From: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>  .shippable.yml | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/.shippable.yml b/.shippable.yml
>> index f74a3de3ff..9670b13f8e 100644
>> --- a/.shippable.yml
>> +++ b/.shippable.yml
>> @@ -25,6 +25,8 @@ env:
>>        TARGET_LIST=mips64el-softmmu,mips64el-linux-user
>>      - IMAGE=debian-ppc64el-cross
>>        TARGET_LIST=ppc64-softmmu,ppc64-linux-user,ppc64abi32-linux-user
>> +    - IMAGE=debian-tricore-cross
>> +      TARGET_LIST=
>>  build:
>>    pre_ci:
>>      - make docker-image-${IMAGE} V=1
> 
> Serves me right for not waiting until the shippable build finished. This
> needs to be dropped as while we can build the image we can't use it to
> build anything.

It was tagged 'RFC' ;)
