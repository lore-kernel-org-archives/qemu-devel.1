Received: from eggs.gnu.org ([209.51.188.92]:52779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hHToS-0001Ba-EK
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 09:44:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hHToR-0001jJ-GD
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 09:44:20 -0400
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143]:53082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1hHToR-0001id-Bc
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 09:44:19 -0400
Received: by mail-it1-x143.google.com with SMTP id x132so8324040itf.2
	for <qemu-devel@nongnu.org>; Fri, 19 Apr 2019 06:44:19 -0700 (PDT)
In-Reply-To: <723372ae-a37a-d7cd-098f-452c7513ce8a@redhat.com>
References: <20190418224706.14014-1-programmingkidx@gmail.com>
	<723372ae-a37a-d7cd-098f-452c7513ce8a@redhat.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4B73E5E6-2129-43B8-A35E-0CF7DCAE163B@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Fri, 19 Apr 2019 09:44:15 -0400
Subject: Re: [Qemu-devel] [PATCH] configure: Change capstone's default state
 to disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>


On Apr 19, 2019, at 3:10 AM, Thomas Huth wrote:

> On 19/04/2019 00.47, John Arbuckle wrote:
>> Capstone is not necessary in order to use QEMU. Disable it by  
>> default.
>> This will save the user the pain of having to figure why QEMU isn't
>> building when this library is missing.
>>
>> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
>> ---
>>  configure | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/configure b/configure
>> index 1c563a7027..77d7967f92 100755
>> --- a/configure
>> +++ b/configure
>> @@ -433,7 +433,7 @@ opengl_dmabuf="no"
>>  cpuid_h="no"
>>  avx2_opt=""
>>  zlib="yes"
>> -capstone=""
>> +capstone="no"
>>  lzo=""
>>  snappy=""
>>  bzip2=""
>
> AFAIK we ship capstone as a submodule, so how can this be missing?  
> Also,
> our philosophy is to keep everything enabled by default if  
> possible, so
> that the code paths don't bitrot. Thus I don't think that disabling  
> this
> by default is a good idea. ... so if you've got a problem here, there
> must be another solution (e.g. is the system capstone detection not
> working right on your system?).
>
>  Thomas

Thank you for replying. Capstone comes with QEMU? Every time I try to  
compile QEMU I see an error relating to Capstone not being on my  
system. Why do you feel that disabling Capstone by default is not a  
good idea?

Here is the error message I see when compiling QEMU:

CHK version_gen.h
make[1]: *** No rule to make target `/Users/John/qemu-git/capstone/ 
libcapstone.a'.  Stop.
make: *** [subdir-capstone] Error 2
