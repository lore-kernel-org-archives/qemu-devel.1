Received: from eggs.gnu.org ([2001:4830:134:3::10]:59885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxd8u-0007fw-W5
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 13:30:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxd8u-0005ZN-1e
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 13:30:21 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:34024)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cxd8t-0005Ym-Qb
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 13:30:19 -0400
Received: by mail-wr0-x231.google.com with SMTP id z109so13695548wrb.1
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 10:30:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fc0b737f-738a-1bc2-1b94-aa041ab8ae6c@twiddle.net>
References: <20170410060655.32289-1-nikunj@linux.vnet.ibm.com>
	<fc0b737f-738a-1bc2-1b94-aa041ab8ae6c@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Apr 2017 18:29:57 +0100
Message-ID: <CAFEAcA95xYVh6fwjNJ6QaXgwXsqH_zYMANfkdEUh7OkZ22aqRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH fix for-2.9] cpus: fix wrong define name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 10 April 2017 at 18:26, Richard Henderson <rth@twiddle.net> wrote:
> On 04/09/2017 11:06 PM, Nikunj A Dadhania wrote:
>> --- a/cpus.c
>> +++ b/cpus.c
>> @@ -202,7 +202,7 @@ void qemu_tcg_configure(QemuOpts *opts, Error **errp)
>>              } else if (use_icount) {
>>                  error_setg(errp, "No MTTCG when icount is enabled");
>>              } else {
>> -#ifndef TARGET_SUPPORT_MTTCG
>> +#ifndef TARGET_SUPPORTS_MTTCG
>
>
> This sort of thing is why glibc moved to using -Wundef.
>
> It would be a huge amount of work to convert our existing sources, but it
> would probably pay off in the long run.

We already build with -Wundef...

thanks
-- PMM
