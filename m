Received: from eggs.gnu.org ([2001:4830:134:3::10]:54250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4nJ5-0007rs-Vp
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:18:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4nJ5-0004le-5X
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:18:43 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171017164426.25277-1-f4bug@amsat.org>
	<20171017164426.25277-17-f4bug@amsat.org>
	<2466fbb7-ab33-26bf-9605-e5fa339abdf5@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cd81b523-1241-83fd-e060-1b5694a64ff0@amsat.org>
Date: Wed, 18 Oct 2017 09:18:33 -0300
MIME-Version: 1.0
In-Reply-To: <2466fbb7-ab33-26bf-9605-e5fa339abdf5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 16/42] i386/hax: remove duplicated
 include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Yu Ning <yu.ning@linux.intel.com>, Vincent Palatin <vpalatin@chromium.org>, Corey Minyard <cminyard@mvista.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 10/18/2017 09:12 AM, Thomas Huth wrote:
> On 17.10.2017 18:44, Philippe Mathieu-Daudé wrote:
>> this file in include in "target/i386/hax-i386.h":
>>
>>     #ifdef CONFIG_WIN32
>>     #include "target/i386/hax-windows.h"
>>     #endif
>>
>> which guaranty than sysemu/os-win32.h is previously included (CONFIG_WIN32)
> 
> which guaranties that ... ?

Oh :(
Michael if you take the whole series, do you mind changing this
description or do you want me to respin it? (if there is no further
functional change asked).

Regards,

Phil.
