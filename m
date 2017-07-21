Received: from eggs.gnu.org ([2001:4830:134:3::10]:39751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dYao0-0003FB-4L
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 12:29:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dYanx-0002Pf-1s
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 12:29:32 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170718061005.29518-1-f4bug@amsat.org>
	<20170718061005.29518-17-f4bug@amsat.org>
	<501136f163a5ab92df3d839360483774@walle.cc>
	<f8dcb381-0935-bf7a-55a7-79d24f51e1dc@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c5c611af-2285-f98b-6159-e866ebbe9b60@amsat.org>
Date: Fri, 21 Jul 2017 13:29:23 -0300
MIME-Version: 1.0
In-Reply-To: <f8dcb381-0935-bf7a-55a7-79d24f51e1dc@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 16/29] lm32: use QEMU_IS_ALIGNED macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Michael Walle <michael@walle.cc>
Cc: qemu-trivial@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philippe.mathieu.daude@gmail.com>, qemu-devel@nongnu.org

On 07/18/2017 11:37 AM, Thomas Huth wrote:
> On 18.07.2017 13:42, Michael Walle wrote:
>> Am 2017-07-18 08:09, schrieb Philippe Mathieu-Daudé:
>>> Applied using the Coccinelle semantic patch
>>> scripts/coccinelle/use_osdep.cocci
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>
>> QEMU_IS_ALIGNED() sounds like it is used to check if a memory access is
>> aligned. Although it does the same, the line in question is used for
>> formatted output. I'm not sure if this macro should be used here.
> 
> +1
> 
> I think we should not replace every usage of % blindly. It does really
> look wrong in this case here.

Dropped, will wear my glasses next time ;)
