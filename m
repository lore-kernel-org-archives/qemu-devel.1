Received: from eggs.gnu.org ([2001:4830:134:3::10]:52525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ez1tZ-0000Vh-QZ
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 11:12:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ez1tW-00012T-Km
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 11:12:49 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:33335)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ez1tW-000120-AB
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 11:12:46 -0400
References: <1521663109-32262-1-git-send-email-cota@braap.org>
	<1521663109-32262-9-git-send-email-cota@braap.org>
	<67b8c0f8-3fd9-ba7c-a666-d0715b5a3329@linaro.org>
	<20180322055710.GA22376@flamenco>
	<959d13eb-498e-0bd6-2553-1b621a87f1bd@linaro.org>
	<20180322150821.GA10288@flamenco>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <3274eb47-4f72-5939-6382-04816cc7f572@vivier.eu>
Date: Thu, 22 Mar 2018 16:12:21 +0100
MIME-Version: 1.0
In-Reply-To: <20180322150821.GA10288@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 08/14] hostfloat: support float32/64
 addition and subtraction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Le 22/03/2018 à 16:08, Emilio G. Cota a écrit :
> On Thu, Mar 22, 2018 at 14:41:05 +0800, Richard Henderson wrote:
>> On 03/22/2018 01:57 PM, Emilio G. Cota wrote:
>>>> Is there any especially good reason you want to not put this code into the
>>>> normal softfloat function?  Does it really many any measurable difference at
>>>> all to force this code to be inlined into a helper?
> (snip)
>> Well, not quite.  I meant putting all of the new code into softfloat.c,
> 
> I put all this in a separate file because I didn't want to spend time
> trying to understand the licensing of softfloat. It isn't clear to
> me whether what goes into softfloat.[ch] is only GPL'ed or also BSD'ed.

It's in the header of sofltloat.c:

...
 * so some portions are provided under:
 *  the SoftFloat-2a license
 *  the BSD license
 *  GPL-v2-or-later
 *
 * Any future contributions to this file after December 1st 2014 will be
 * taken to be licensed under the Softfloat-2a license unless specifically
 * indicated otherwise.
 */

and

/* Portions of this work are licensed under the terms of the GNU GPL,
 * version 2 or later. See the COPYING file in the top-level directory.
 */

So you can choose your license, just say what you want.

Thanks,
Laurent
