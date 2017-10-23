Received: from eggs.gnu.org ([2001:4830:134:3::10]:37477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6kUa-0004Oo-Rn
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 17:42:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6kUX-0004QM-PN
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 17:42:40 -0400
Received: from mail-qk0-x231.google.com ([2607:f8b0:400d:c09::231]:44163)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6kUX-0004QI-L9
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 17:42:37 -0400
Received: by mail-qk0-x231.google.com with SMTP id r64so23897728qkc.1
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 14:42:37 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1508513949-15680-1-git-send-email-gabriel291075@gmail.com>
	<52e67cee-c6e6-4df0-6882-6a39fdef473d@amsat.org>
	<CAG+oHk83yBxw7JB7u15yy6KkhOwvhy=Epe_HOh3c_SdfnQ=5EQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3f1795cf-bcd0-2092-37bc-e0ecb4221e6e@amsat.org>
Date: Mon, 23 Oct 2017 18:42:33 -0300
MIME-Version: 1.0
In-Reply-To: <CAG+oHk83yBxw7JB7u15yy6KkhOwvhy=Epe_HOh3c_SdfnQ=5EQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 04/11] kinetis_k64_sim.h has been added
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gabriel Costa <gabriel291075@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 10/23/2017 05:36 PM, Gabriel Costa wrote:
> The name SIM came from kinetis datasheet, it is the name of the peripheral.
> I believe others families of kinetis microcontrollers uses the same name.

SIM stands for "System Integration Module"; naming it
"kinetis_k64_sim.c" does not sound very helpful.
This is why I suggested "kinetis_k64_system.c" which better matches the
system controller of the other SoCs.

> On Fri, Oct 20, 2017 at 6:17 PM, Philippe Mathieu-Daudé <f4bug@amsat.org>
> wrote:
>> I'd rather name it kinetis_k64_system.h or kinetis_k64_sysctl.h
