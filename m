Received: from eggs.gnu.org ([2001:4830:134:3::10]:60315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cxdAW-0008P9-8R
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 13:32:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cxdAV-00069K-8g
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 13:32:00 -0400
Received: from mail-pg0-x22e.google.com ([2607:f8b0:400e:c05::22e]:33674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cxdAV-000693-3i
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 13:31:59 -0400
Received: by mail-pg0-x22e.google.com with SMTP id x125so109225433pgb.0
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 10:31:59 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170410060655.32289-1-nikunj@linux.vnet.ibm.com>
	<fc0b737f-738a-1bc2-1b94-aa041ab8ae6c@twiddle.net>
	<CAFEAcA95xYVh6fwjNJ6QaXgwXsqH_zYMANfkdEUh7OkZ22aqRQ@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a5f66b3c-228a-90ff-705a-0370d8d8d0b0@twiddle.net>
Date: Mon, 10 Apr 2017 10:31:54 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA95xYVh6fwjNJ6QaXgwXsqH_zYMANfkdEUh7OkZ22aqRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH fix for-2.9] cpus: fix wrong define name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 04/10/2017 10:29 AM, Peter Maydell wrote:
> On 10 April 2017 at 18:26, Richard Henderson <rth@twiddle.net> wrote:
>> On 04/09/2017 11:06 PM, Nikunj A Dadhania wrote:
>>> --- a/cpus.c
>>> +++ b/cpus.c
>>> @@ -202,7 +202,7 @@ void qemu_tcg_configure(QemuOpts *opts, Error **errp)
>>>              } else if (use_icount) {
>>>                  error_setg(errp, "No MTTCG when icount is enabled");
>>>              } else {
>>> -#ifndef TARGET_SUPPORT_MTTCG
>>> +#ifndef TARGET_SUPPORTS_MTTCG
>>
>>
>> This sort of thing is why glibc moved to using -Wundef.
>>
>> It would be a huge amount of work to convert our existing sources, but it
>> would probably pay off in the long run.
>
> We already build with -Wundef...

Ah, but then you also have to stop using #ifdef and #ifndef, and use only #if. 
Thus my incomplete comment above about conversion.


r~
