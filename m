Received: from eggs.gnu.org ([2001:4830:134:3::10]:46242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dOOuE-0003M3-K0
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:45:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dOOuA-0006ES-FV
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:45:50 -0400
Received: from mail-qk0-x230.google.com ([2607:f8b0:400d:c09::230]:36473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dOOuA-0006EI-Ae
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:45:46 -0400
Received: by mail-qk0-x230.google.com with SMTP id p21so35752909qke.3
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 06:45:46 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170622033231.19344-1-f4bug@amsat.org>
	<20170622033231.19344-15-f4bug@amsat.org> <8760fotj64.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <12d23441-f007-b6bb-7f0f-d9de880860b0@amsat.org>
Date: Fri, 23 Jun 2017 10:45:41 -0300
MIME-Version: 1.0
In-Reply-To: <8760fotj64.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 14/21] travis: dump config.log if
 ./configure script fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 06/22/2017 07:23 AM, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
[...]
>> -  - ./configure ${CONFIG}
>> +  - ./configure ${CONFIG} || cat config.log
> 
> Won't the explicit || mean the job will keep trying even if config is
> broken? Should it be || cat config.log && false?

Yes, you right. I actually copied it from the "Trusty build with latest 
stable clang" job from commit ae1a772c :p

I'll see to fix other occurrences.
