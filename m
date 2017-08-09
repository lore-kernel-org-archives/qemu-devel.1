Received: from eggs.gnu.org ([2001:4830:134:3::10]:38757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfQUh-0003qi-5s
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 08:53:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfQUe-0001fP-21
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 08:53:51 -0400
Received: from mail-pg0-x22d.google.com ([2607:f8b0:400e:c05::22d]:33895)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfQUd-0001eh-RE
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 08:53:47 -0400
Received: by mail-pg0-x22d.google.com with SMTP id u185so27777291pgb.1
	for <qemu-devel@nongnu.org>; Wed, 09 Aug 2017 05:53:47 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <CAJSP0QVrCm6TfgU0dsXbudaW3gmGo0YQTTWbNypx6st6mKcSKA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d9c93599-1d2c-333e-dae0-7da8cc87b133@amsat.org>
Date: Wed, 9 Aug 2017 09:53:43 -0300
MIME-Version: 1.0
In-Reply-To: <CAJSP0QVrCm6TfgU0dsXbudaW3gmGo0YQTTWbNypx6st6mKcSKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Making QEMU build with Python 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: ross@burtonini.com

Hi Stefan,

On 08/09/2017 07:16 AM, Stefan Hajnoczi wrote:
[...]> Python scripts needed to build QEMU are the highest priority.  They
> are invoked by ./configure or make.  I've identified the following:
> 
> scripts/signrom.py
> scripts/qapi*.py
> scripts/modules/module_block.py
> scripts/tracetool*
> 
[...]
> The fundamentals of adding Python 3 support are:
> 
> 1. The script must work correctly under both Python 2.6+ and Python 3.
[...]
> 3. Avoid third-party package dependencies - QEMU currently has none!

This seems true for the "invoked by ./configure or make" set. However:

scripts/qemu-gdb.py:20:import gdb
scripts/qemugdb/aio.py:13:import gdb
scripts/qemugdb/coroutine.py:16:import gdb
scripts/qemugdb/mtree.py:18:import gdb

I just checked gdb8 and can't confirm python3 build works.

Also another 3rd party (python3 compliant):

scripts/analyze-migration.py:20:import numpy as np

Off-topic but we might document how to install dependencies for those 
scripts?

> That means do not use 'six' or 'python-future'.  Our use of Python
> isn't that fancy, but if you feel a third party package is essential
> the please justify it.
[...]

Regards,

Phil.
