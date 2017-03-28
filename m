Received: from eggs.gnu.org ([2001:4830:134:3::10]:36999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csq1U-0000bS-VJ
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 08:14:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csq1U-0003dj-4R
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 08:14:52 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:36821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1csq1T-0003dc-Rt
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 08:14:52 -0400
Received: by mail-wr0-x22a.google.com with SMTP id w11so84388671wrc.3
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 05:14:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7f7dd18e-1fd6-8d11-c446-58e150cd1518@weilnetz.de>
References: <20170327201146.1820-1-sw@weilnetz.de>
	<CAFEAcA-Jb8uQsQcfFfaQdXp5+DkD84tCDtMyW1kXN1yZ45fLGQ@mail.gmail.com>
	<7f7dd18e-1fd6-8d11-c446-58e150cd1518@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Mar 2017 13:14:29 +0100
Message-ID: <CAFEAcA92obh8joN2efLNrrXUD+ga7To1KZR9W3Lt5A0Y-e-qYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH for-2.9] Fix check for target OS support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developer <qemu-devel@nongnu.org>

On 28 March 2017 at 13:07, Stefan Weil <sw@weilnetz.de> wrote:
> Am 28.03.2017 um 09:10 schrieb Peter Maydell:
>> On 27 March 2017 at 21:11, Stefan Weil <sw@weilnetz.de> wrote:
>>>  *)
>>> -  error_exit "Unsupported host OS $targetos"
>>> +  supported_os="no"
>> This was deliberately an error_exit because anything
>> going down that path got the Linux defines/includes by
>> accident and we thought that would not work on
>> anything else. What was using it? If we need an extra
>> entry in the case statement we can add one.
>
> It remains an error (that's why I introduced a third state for
> supported_os), but must be handled later, after processing
> a potential --help option.

I think the right fix for this is to special case --help
to bypass more checks and to happen earlier. For instance
if you don't happen to have a 'python' on your PATH then
we do this:

netbsdvm# ./configure --help

ERROR: Python not found. Use --python=/path/to/python

I'll have a go at writing a patch.

thanks
-- PMM
