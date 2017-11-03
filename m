Received: from eggs.gnu.org ([2001:4830:134:3::10]:54888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eAbkB-0001Mj-81
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 09:10:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eAbk7-0000dx-Uf
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 09:10:43 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:54892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eAbk7-0000dW-Pg
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 09:10:39 -0400
Received: by mail-qk0-x243.google.com with SMTP id n5so3079315qke.11
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 06:10:39 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1509020054-25434-1-git-send-email-nanjekyejoannah@gmail.com>
	<e4b4b545-919f-f043-6a6e-70e563fa75ff@amsat.org>
	<20171103112442.GN5078@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8410eec3-4811-dbb7-58ce-e97f53384025@amsat.org>
Date: Fri, 3 Nov 2017 10:10:36 -0300
MIME-Version: 1.0
In-Reply-To: <20171103112442.GN5078@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH WIP] replace numpy with struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Joannah Nanjekye <nanjekyejoannah@gmail.com>
Cc: stefanha@redhat.com, qemu-devel@nongnu.org

On 11/03/2017 08:24 AM, Stefan Hajnoczi wrote:
> On Thu, Oct 26, 2017 at 10:50:26AM -0300, Philippe Mathieu-Daudé
> wrote:
>> Hi Joannah,
>> 
>> The common subject to use is [RFC PATCH] instead of [PATCH WIP]
>> 
>> On 10/26/2017 09:14 AM, Joannah Nanjekye wrote:
>>> This patch replaces the use of numpy with the standard Library
>>> struct module where possible.
>> 
>> This seems a good idea but why?
> 
> I suggest adding this to the commit description:
> 
> Users tend to hit an ImportError when running analyze-migration.py
> due to the numpy dependency.  numpy functionality isn't actually
> used, just binary serialization that the standard library 'struct'
> module already provides.  Removing the dependency allows the script
> to run out-of-the-box.

Oh now I understand, good idea :)

> 
>> Do you have any performance improvements results to share?
>> 
>>> Signed-off-by: Joannah Nanjekye <nanjekyejoannah@gmail.com> 
>>> ---
>>> 
>>> scripts/analyze-migration.py | 19 ++++++++++++------- 1 file
>>> changed, 12 insertions(+), 7 deletions(-)
> 
> I don't see a removal of "import numpy as np" so this script still 
> depends on numpy.  Did you forget to sent further patches that you
> have to remove the numpy dependency?
> 
