Received: from eggs.gnu.org ([209.51.188.92]:58655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqcr1-0006JA-8d
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:56:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqcqz-0003e3-9N
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:55:59 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gqcqz-0003KF-2V
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:55:57 -0500
Received: by mail-wr1-f66.google.com with SMTP id r17so8125662wrp.2
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 03:55:46 -0800 (PST)
References: <20190203220744.11734-1-philmd@redhat.com>
	<20190203220744.11734-2-philmd@redhat.com>
	<162915fe-ef7f-c977-2fd2-985406b465d1@redhat.com>
	<54a0c271-c499-eeea-7344-68f68c010f7b@redhat.com>
	<aaee9b37-72b7-7c9b-9b79-e1cc1590b07a@redhat.com>
	<89768aca-717b-dfbf-e10b-8390671d5f44@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7a956e02-779b-4b47-a396-98543a7be51d@redhat.com>
Date: Mon, 4 Feb 2019 12:55:43 +0100
MIME-Version: 1.0
In-Reply-To: <89768aca-717b-dfbf-e10b-8390671d5f44@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/6] mips: Express dependencies of the
 MIPSsim machine with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Yang Zhong <yang.zhong@intel.com>, Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, James Hogan <jhogan@kernel.org>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

On 2/4/19 12:21 PM, Paolo Bonzini wrote:
> On 04/02/19 12:05, Philippe Mathieu-Daudé wrote:
>>> Scratch that. I think you have to keep CONFIG_MIPSSIM=y enabled in the
>>> default-configs, don't you?
>> I guess I misunderstood --without-default-devices with --no-defaults,
>> where you'd manually select the machines you want.
> 
> Note that machines have to be included in default-configs/ even for
> --with-default-devices (which is the default).

OK, I'll respin.

Thanks,

Phil.
