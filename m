Received: from eggs.gnu.org ([2001:4830:134:3::10]:43155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gM7JK-00054D-Eh
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:11:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gM7JH-0005Nv-6p
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:11:06 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52095)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1gM7JG-0005N7-W6
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:11:03 -0500
Received: by mail-wm1-x342.google.com with SMTP id w7-v6so7461071wmc.1
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 00:11:02 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20181111000259.7665-1-f4bug@amsat.org>
	<49746241-61a1-0ac8-8d94-3afeafa6d176@linaro.org>
	<CAAdtpL69Guy-gyjYOEBfaZOODjUw236SWOk2XhMkWr_8bohEEw@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a4fbaaa8-b5b1-f5be-20ae-3cf9540689ff@twiddle.net>
Date: Mon, 12 Nov 2018 09:10:56 +0100
MIME-Version: 1.0
In-Reply-To: <CAAdtpL69Guy-gyjYOEBfaZOODjUw236SWOk2XhMkWr_8bohEEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] decodetree: Force Python to print unsigned
 values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 11/12/18 12:06 AM, Philippe Mathieu-Daudé wrote:
>> On 11/11/18 1:02 AM, Philippe Mathieu-Daudé wrote:
>>> Python internal representation is signed, so unsigned values
>>> bigger than 31-bit are interpreted as signed (and printed with
>>> a '-' signed).
>>> Mask out to force unsigned values.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>>  scripts/decodetree.py | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> Queued, thanks.
> 
> Can you drop this from your queue? I'll send a cleaner approach (as
> RFC, and I also want to log the error I got in the commit msg).

Done.


r~
