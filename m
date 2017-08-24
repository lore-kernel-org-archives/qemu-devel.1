Received: from eggs.gnu.org ([2001:4830:134:3::10]:45421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkiFQ-0004qu-Jm
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 22:51:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkiFN-0004kF-Io
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 22:51:56 -0400
Received: from mail-qk0-x230.google.com ([2607:f8b0:400d:c09::230]:33444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkiFN-0004kB-Eo
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 22:51:53 -0400
Received: by mail-qk0-x230.google.com with SMTP id a77so10357149qkb.0
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 19:51:53 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1503050939-227939-1-git-send-email-imammedo@redhat.com>
	<1503050939-227939-9-git-send-email-imammedo@redhat.com>
	<7a176771-d903-9b64-a503-c81c409bcda1@amsat.org>
	<20170821131159.532e9a8c@nial.brq.redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <40d348e3-a71e-2c5a-5ccf-bdefaedb1e57@amsat.org>
Date: Wed, 23 Aug 2017 23:51:48 -0300
MIME-Version: 1.0
In-Reply-To: <20170821131159.532e9a8c@nial.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.11 08/27] sparc: replace
 cpu_sparc_init() with cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Fabien Chouteau <chouteau@adacore.com>

On 08/21/2017 08:11 AM, Igor Mammedov wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
> 
>> I succeed booting a SPARC image once applying 1 to 8 (this commit),
>> so not being able to boot the image previously is probably due to patch
>> order, which mean current order is not bisect-able.
> 
> I repeated patch by patch (1-8) build/test steps and it works for me
> (i.e. compiles and both sparc/sparc64 target machines start as expected)
> 
> Could you re-check with clean build and if failure still persist
> pin-point exact cause?

Sorry Igor, I guess it was some issue on my side (dirty working space 
probably).

Regards,

Phil.
