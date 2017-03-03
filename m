Received: from eggs.gnu.org ([2001:4830:134:3::10]:50436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cjpei-0004GV-35
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:02:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cjpee-0007xP-71
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:02:08 -0500
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:34089)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1cjpee-0007xB-2k
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:02:04 -0500
Received: by mail-it0-x243.google.com with SMTP id r141so2756406ita.1
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 08:02:03 -0800 (PST)
In-Reply-To: <CAFEAcA-_p_N8c+4tu98MgvQsCP3SV9RD9mLP-+kj9FypqCeuJw@mail.gmail.com>
References: <mailman.56273.1488553194.22740.qemu-devel@nongnu.org>
	<8FB6923C-8F97-497C-95DC-6F2D937725BC@gmail.com>
	<20170303164426.42472535@bahia.lan>
	<AA7BADA2-06D5-4A20-A38F-57D374B6C58D@gmail.com>
	<CAFEAcA-_p_N8c+4tu98MgvQsCP3SV9RD9mLP-+kj9FypqCeuJw@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4B855DBB-6006-4099-8896-0CEB5C9D78EA@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Fri, 3 Mar 2017 11:02:00 -0500
Subject: Re: [Qemu-devel] git master build failure in 9pfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel qemu-devel <qemu-devel@nongnu.org>


On Mar 3, 2017, at 10:58 AM, Peter Maydell wrote:

> On 3 March 2017 at 15:55, G 3 <programmingkidx@gmail.com> wrote:
>> Here is the patch. I think we should let Mark or some else test it  
>> to see if
>> it does fix the problem before a real patch is submitted.
>>
>> ---
>>  hw/9pfs/9p-util.h | 4 ++++
>>  1 file changed, 4 insertions(+)
>
> We can't take any patch without a Signed-off-by: line, not
> even a three line one.

This was more of a RFC kind of patch. It is a pre-patch. I honestly  
don't know if it will work.

>
>>
>> diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
>> index 091f3ce..254d2a9 100644
>> --- a/hw/9pfs/9p-util.h
>> +++ b/hw/9pfs/9p-util.h
>> @@ -13,6 +13,10 @@
>>  #ifndef QEMU_9P_UTIL_H
>>  #define QEMU_9P_UTIL_H
>>
>> +#ifndef O_PATH
>> +    #define O_PATH 0
>> +#endif
>
> Could use a comment explaining why it's OK to define it in
> a way that means it's a no-op on hosts without it.

Ok.

>
>> +
>>  static inline void close_preserve_errno(int fd)
>>  {
>>      int serrno = errno;
>> --
>> 2.10.2
>
> thanks
> -- PMM

Thank you.
