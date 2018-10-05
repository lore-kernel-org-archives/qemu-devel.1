Received: from eggs.gnu.org ([2001:4830:134:3::10]:51947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8QLT-00075b-LV
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:40:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8QLR-0007sY-P1
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:40:43 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g8QLP-0007pV-Q2
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:40:40 -0400
Received: by mail-ot1-x342.google.com with SMTP id j9-v6so12737136otl.2
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 06:40:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5616e4d4-938c-4e5f-6fe0-64e52d2fe6a7@redhat.com>
References: <20181004161852.11673-1-crosa@redhat.com>
	<20181004161852.11673-2-crosa@redhat.com>
	<5616e4d4-938c-4e5f-6fe0-64e52d2fe6a7@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Oct 2018 14:40:11 +0100
Message-ID: <CAFEAcA-7Z2qubiC-O2E-pg+YwYkzjYpB=J_xfLePieuZVSKmjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 01/10] qemu-img.c: comment typo fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>

On 4 October 2018 at 17:48, Eric Blake <eblake@redhat.com> wrote:
> On 10/4/18 11:18 AM, Cleber Rosa wrote:
>>
>> A trivial comment typo fix.
>>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>

>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -1085,7 +1085,7 @@ static int64_t find_nonzero(const uint8_t *buf,
>> int64_t n)
>>   }
>>     /*
>> - * Returns true iff the first sector pointed to by 'buf' contains at
>> least
>> + * Returns true if the first sector pointed to by 'buf' contains at least
>
>
> NACK.  You're not the first person to propose this change.  However, "iff"
> is an English word (albeit archaic) which is shorthand for "if and only if",
> which has a distinct logical meaning separate from the weaker "if".
> Spelling it out in longhand instead of calling it a typo is probably
> acceptable, though.

Yes; if you happen to have a mathematical background then it's
a familiar abbreviation; but otherwise it isn't, and it's more
confusing than helpful I think. (I don't think it's archaic; it's
just commonly used in university-and-higher-level maths and not
elsewhere.)

 git grep '\Wiff\W'
shows a surprisingly large number of uses. (NB that some of those
are in 3rd-party code, notably the libdecnumber stuff, and should
probably not be changed.)

thanks
-- PMM
