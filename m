Received: from eggs.gnu.org ([209.51.188.92]:51627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqcPi-0005K1-CY
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:27:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqcI0-00011T-CG
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:19:49 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gqcI0-0000zR-53
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:19:48 -0500
Received: by mail-wr1-x442.google.com with SMTP id l9so13883735wrt.13
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 03:19:47 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20190203220744.11734-1-philmd@redhat.com>
	<CAP+75-Ve9NwAfgmXoXDGuK5ykZWn-9+Y8Wj1+M91noNFtuVNDw@mail.gmail.com>
	<203ecbc6-b82b-9d55-9919-36c4a8023882@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <497c12d9-37e5-7bcf-caf7-d58f0b72d2ad@redhat.com>
Date: Mon, 4 Feb 2019 12:19:43 +0100
MIME-Version: 1.0
In-Reply-To: <203ecbc6-b82b-9d55-9919-36c4a8023882@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/6] Kconfig dependencies for MIPS machines
 (but Malta)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, James Hogan <jhogan@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>, Yang Zhong <yang.zhong@intel.com>, Paul Burton <pburton@wavecomp.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>

On 04/02/19 10:51, Thomas Huth wrote:
> On 2019-02-04 01:06, Philippe Mathieu-Daudé wrote:
>> On Sun, Feb 3, 2019 at 11:07 PM Philippe Mathieu-Daudé
>> <philmd@redhat.com> wrote:
>>>
>>> Express the MIPS machine dependencies with Kconfig.
>>
>> I forgot this serie misses a rule such "depends of MIPS64".
>> Asked here: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg00064.html
> 
> I guess the easiest solution is to simply set a CONFIG_MIPS64=y in the
> default-configs/mips64*softmmu* files.

Or just do not specify the machine in the mips64*softmmu.mak files.  If
you add CONFIG_Q35=y to ARM, Kconfig doesn't complain.

Another possibility is to move those machines to hw/mips64, similar to
hw/sparc64.

Paolo
