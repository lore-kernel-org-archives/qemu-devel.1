Received: from eggs.gnu.org ([2001:4830:134:3::10]:51557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e89OK-0002LY-HO
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 14:30:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e89OF-0006aM-LT
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 14:30:00 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:50863)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e89OF-0006Zu-EI
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 14:29:55 -0400
Received: by mail-qt0-x244.google.com with SMTP id d9so9537415qtd.7
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 11:29:55 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171026140404.21948-1-ehabkost@redhat.com>
	<CAFEAcA8fu0PCd8snz3yqv+Oys=6zdD4XbyCtrezJQjZV4UO0Sw@mail.gmail.com>
	<20171027141014.GB2971@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ecd0c741-e4a2-9d44-49fc-846181896f89@amsat.org>
Date: Fri, 27 Oct 2017 15:29:45 -0300
MIME-Version: 1.0
In-Reply-To: <20171027141014.GB2971@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/39] x86/cpu/numa queue, 2017-10-26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 10/27/2017 11:10 AM, Eduardo Habkost wrote:
> On Fri, Oct 27, 2017 at 02:42:11PM +0100, Peter Maydell wrote:
[...]
>> Hi. I'm afraid this breaks the sh4 linux-user code:
>>
>> /home/petmay01/linaro/qemu-for-merges/build/all-linux-static/sh4-linux-user/qemu-sh4
>> -L ./gnemul/qemu-sh4 sh4/ls -l dummyfile
>> unable to find CPU model 'sh7785-superh-cpu'
> 
> A fixup patch from Igor was missing, sorry.  v2 will be sent
> soon.
> 
> BTW, is there a way we can include linux-user tests on travis-ci?

Good idea. I'm adding this on my TODO if no-one else paid to work on
QEMU can do it first.
