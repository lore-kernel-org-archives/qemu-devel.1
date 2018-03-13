Received: from eggs.gnu.org ([2001:4830:134:3::10]:45904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1evkJJ-00010x-TI
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 09:49:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1evkJG-0001NK-0x
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 09:49:49 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:43195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1evkJF-0001Mq-Qt
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 09:49:45 -0400
Received: by mail-wr0-f175.google.com with SMTP id o1so11145106wro.10
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 06:49:45 -0700 (PDT)
References: <20180209141514.18840-1-alex.bennee@linaro.org>
	<20180209141514.18840-2-alex.bennee@linaro.org>
	<20180313134017.GA24191@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2f452164-d9d7-80ae-c5fe-bdc1889633f8@redhat.com>
Date: Tue, 13 Mar 2018 14:49:42 +0100
MIME-Version: 1.0
In-Reply-To: <20180313134017.GA24191@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 1/1] .travis.yml: add --disable-linux-user
 for some jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 13/03/2018 14:40, Daniel P. Berrangé wrote:
>> @@ -52,9 +52,9 @@ env:
>>      - CONFIG=""
>>      - CONFIG="--enable-debug --enable-debug-tcg --enable-trace-backends=log"
>>      - CONFIG="--disable-linux-aio --disable-cap-ng --disable-attr --disable-brlapi --disable-uuid --disable-libusb"
>> -    - CONFIG="--enable-modules"
>> -    - CONFIG="--with-coroutine=ucontext"
>> -    - CONFIG="--with-coroutine=sigaltstack"
>> +    - CONFIG="--enable-modules --disable-linux-user"
>> +    - CONFIG="--with-coroutine=ucontext --disable-linux-user"
>> +    - CONFIG="--with-coroutine=sigaltstack --disable-linux-user"
> Since this merged, the 4th, 5th & 6th jobs are now reliably completing in
> time, but the 1st and 3rd jobs are hitting timeouts on the majority of
> runs :-(
> 
> We've already got a lot of jobs, but for sake of reliability should we
> consider splitting the 1st & 3rd jobs. Add --disable-linux-user to both
> of the existing jobs, and then adding 2 new jobs with --disable-system
> and --disable-tools set ?

Out of curiosity, why do we need the third job at all?  And
--enable-trace-backends=log is the default, so "--enable-debug
--enable-debug-tcg" should be enough.

Paolo
