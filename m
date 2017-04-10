Received: from eggs.gnu.org ([2001:4830:134:3::10]:36489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cxdRF-00082n-Sy
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 13:49:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cxdRF-0006Lq-0H
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 13:49:17 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:33533)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cxdRE-0006LU-Pp
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 13:49:16 -0400
Received: by mail-pg0-x242.google.com with SMTP id 79so26567096pgf.0
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 10:49:16 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170410060655.32289-1-nikunj@linux.vnet.ibm.com>
	<fc0b737f-738a-1bc2-1b94-aa041ab8ae6c@twiddle.net>
	<CAFEAcA95xYVh6fwjNJ6QaXgwXsqH_zYMANfkdEUh7OkZ22aqRQ@mail.gmail.com>
	<20170410194414.7f829fee@bahia.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <3b38d5f9-3611-6ec8-df14-a6054d574dc2@twiddle.net>
Date: Mon, 10 Apr 2017 10:49:12 -0700
MIME-Version: 1.0
In-Reply-To: <20170410194414.7f829fee@bahia.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
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
To: Greg Kurz <groug@kaod.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

On 04/10/2017 10:44 AM, Greg Kurz wrote:
> On Mon, 10 Apr 2017 18:29:57 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
>> On 10 April 2017 at 18:26, Richard Henderson <rth@twiddle.net> wrote:
>>> On 04/09/2017 11:06 PM, Nikunj A Dadhania wrote:
>>>> --- a/cpus.c
>>>> +++ b/cpus.c
>>>> @@ -202,7 +202,7 @@ void qemu_tcg_configure(QemuOpts *opts, Error **errp)
>>>>              } else if (use_icount) {
>>>>                  error_setg(errp, "No MTTCG when icount is enabled");
>>>>              } else {
>>>> -#ifndef TARGET_SUPPORT_MTTCG
>>>> +#ifndef TARGET_SUPPORTS_MTTCG
>>>
>>>
>>> This sort of thing is why glibc moved to using -Wundef.
>>>
>>> It would be a huge amount of work to convert our existing sources, but it
>>> would probably pay off in the long run.
>>
>> We already build with -Wundef...
>>
>
> From the gcc info page:
>
> '-Wundef'
>      Warn if an undefined identifier is evaluated in an '#if' directive.
>
> and BTW, isn't the purpose of #ifndef precisely to detect that the
> identifier is undefined ?

Yes, but it also has the typo problem above, whereas

   #if !TARGET_SUPPORTS_MTTCG

plus -Wundef would have caught that error.


r~
