Received: from eggs.gnu.org ([2001:4830:134:3::10]:40159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fzhDo-0006h7-5x
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 07:52:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fzhDi-0004Z4-Gr
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 07:52:42 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:38845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fzhDi-0004VA-8q
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 07:52:38 -0400
Received: by mail-wm0-x242.google.com with SMTP id t25-v6so648608wmi.3
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 04:52:32 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180909013444.18936-1-f4bug@amsat.org>
	<20180909013444.18936-2-f4bug@amsat.org>
	<BN7PR08MB4868831CF81522919CC4EEC3C6040@BN7PR08MB4868.namprd08.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6cdb730b-266e-5a43-7058-f24a4d8e3798@amsat.org>
Date: Tue, 11 Sep 2018 08:52:28 -0300
MIME-Version: 1.0
In-Reply-To: <BN7PR08MB4868831CF81522919CC4EEC3C6040@BN7PR08MB4868.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] target/mips: Increase the 'supported
 instructions' flags holder size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: Fredrik Noring <noring@nocrew.org>, Richard Henderson <rth@twiddle.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 9/11/18 6:33 AM, Aleksandar Markovic wrote:
>> From: Philippe Mathieu-Daudé <philippe.mathieu.daude@gmail.com> on behalf of Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Sent: Sunday, September 9, 2018 3:34 AM
>>
>> Subject: [PATCH 1/2] target/mips: Increase the 'supported instructions' flags holder size
>>
>> Currently this holder is limited to at most 32 flags on
>> a 32-bit architecture, which lets an unique bit available
>> for another 'chip specific instructions' flag.
>>
>> Relax this limit using a 64-bit integer.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> target/mips/cpu.h       | 2 +-
>> target/mips/internal.h  | 2 +-
>> target/mips/translate.c | 4 ++--
>> 3 files changed, 4 insertions(+), 4 deletions(-)
> 
> "int insn_flags;" in DisasContext definition in target/mips/translate.c needs to be updated as well.

Oops I missed this one, good catch :)
