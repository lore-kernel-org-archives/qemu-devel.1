Received: from eggs.gnu.org ([2001:4830:134:3::10]:50789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gWJUc-0000iK-AV
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 06:12:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gWJUZ-0005Hy-3H
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 06:12:54 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:38878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gWJUY-0005FH-Qq
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 06:12:51 -0500
Received: by mail-wm1-f43.google.com with SMTP id m22so10804295wml.3
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 03:12:50 -0800 (PST)
References: <CAHmME9qhe0ZemTkc2jkEO=_hu6PhvKUKGHC9QYTj2j+QHhNf8g@mail.gmail.com>
	<CAFEAcA8fYaKTZkLR8Ja3P590bSWy1cu61-gSxyf6+wXCfCLoxA@mail.gmail.com>
	<CAHmME9qQo4XfRgZUZDt3xbx=5KmRoYbO3N0+3m9gdKi9hvnZQA@mail.gmail.com>
	<96301756-f879-84d1-f5ef-d2615257d309@redhat.com>
	<CAFEAcA-J8gWONJye0JvuwG5warWKZD1MX-GW8=BPuCo9wF5ziQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f6cc8816-65ea-fe75-2f00-2c741566dda8@redhat.com>
Date: Mon, 10 Dec 2018 12:12:47 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-J8gWONJye0JvuwG5warWKZD1MX-GW8=BPuCo9wF5ziQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] more serial ports on arm?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 12/10/18 12:09 PM, Peter Maydell wrote:
> On Mon, 10 Dec 2018 at 11:00, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> Hi Jason,
>>
>> On 12/7/18 5:42 AM, Jason A. Donenfeld wrote:
>>> On Tue, Nov 20, 2018 at 11:08 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>>>> It's still stuck, because unconditionally adding a second serial
>>>> port to the virt board breaks some commonly used existing guest
>>>> code (UEFI + Linux), and it's not clear to me what the best
>>>> command line UI is for allowing the user to request the second
>>>> serial port.
>>>
>>> Can the UI be the same more or less as for x86? Specify a second
>>> -serial, and then the machine gets one added? If it's in secure mode,
>>> then it's added as serial 3 instead of 2, to remain backwards
>>> compatible.
>>
>> You can use various -serial arguments.
>>
>> If a board supports 4 serials and you only want to see the 3rd (secure
>> mode as your example) you could use:
>>
>> ./qemu -serial null -serial null -serial stdio
> 
> That's the opposite of Jason's issue, which is that the 'virt'
> board only supports 1 serial port but he would like 2...

Oh sorry Jason, I misunderstood your question.

Regards,

Phil.
