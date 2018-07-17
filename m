Received: from eggs.gnu.org ([2001:4830:134:3::10]:60367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffS7E-0000Wl-No
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffS7A-0006q8-Qr
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:42:16 -0400
Received: from mail-ua0-x243.google.com ([2607:f8b0:400c:c08::243]:35764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffS7A-0006py-LK
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:42:12 -0400
Received: by mail-ua0-x243.google.com with SMTP id q12-v6so965795ual.2
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 08:42:12 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180510204148.11687-1-babu.moger@amd.com>
	<20180510204148.11687-2-babu.moger@amd.com>
	<42cdb351-425b-edd2-a4b2-c8e5ffeeec76@amsat.org>
	<20180716195214.GN31657@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <77fe71ac-0690-6277-39c4-09ea23cc9b01@amsat.org>
Date: Tue, 17 Jul 2018 12:42:06 -0300
MIME-Version: 1.0
In-Reply-To: <20180716195214.GN31657@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v8 1/8] i386: Helpers to encode cache
 information consistently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, mst@redhat.com, rth@twiddle.net
Cc: Babu Moger <babu.moger@amd.com>, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, mtosatti@redhat.com, geoff@hostfission.com, kash@tripleback.net, qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, aurelien@aurel32.net

Hi Eduardo,

On 07/16/2018 04:52 PM, Eduardo Habkost wrote:
> On Mon, Jul 16, 2018 at 10:20:09AM -0300, Philippe Mathieu-Daudé wrote:
> [...]
>>> +enum CacheType {
>>> +    DCACHE,
>>
>> I just noticed this clashes on mips host:
> [...]
>> In file included from /usr/include/mips-linux-gnu/sys/cachectl.h:26:0,
>>                  from /tmp/qemu-test/src/tcg/mips/tcg-target.h:202,
>>                  from /tmp/qemu-test/src/include/exec/cpu-defs.h:29,
>>                  from /tmp/qemu-test/src/target/i386/cpu.h:34,
>>                  from /tmp/qemu-test/src/exec.c:23:
>> /tmp/qemu-test/src/target/i386/cpu.h:1053:5: error: expected identifier
>> before '(' token
>>      DCACHE,
>>      ^
> 
> Oops.  I will take a look and submit a fix.  Thanks for the
> report!

While a quick fix is to simply rename the CacheType enums, I think this
is an #include problem.
