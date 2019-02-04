Received: from eggs.gnu.org ([209.51.188.92]:51668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqcPh-0005LF-G9
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:27:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqcJf-0002nd-J0
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:21:32 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44487)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gqcJf-0002mn-8X
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:21:31 -0500
Received: by mail-wr1-x444.google.com with SMTP id z5so13899251wrt.11
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 03:21:31 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20190203220744.11734-1-philmd@redhat.com>
	<20190203220744.11734-2-philmd@redhat.com>
	<162915fe-ef7f-c977-2fd2-985406b465d1@redhat.com>
	<54a0c271-c499-eeea-7344-68f68c010f7b@redhat.com>
	<aaee9b37-72b7-7c9b-9b79-e1cc1590b07a@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <89768aca-717b-dfbf-e10b-8390671d5f44@redhat.com>
Date: Mon, 4 Feb 2019 12:21:27 +0100
MIME-Version: 1.0
In-Reply-To: <aaee9b37-72b7-7c9b-9b79-e1cc1590b07a@redhat.com>
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Yang Zhong <yang.zhong@intel.com>, Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, James Hogan <jhogan@kernel.org>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

On 04/02/19 12:05, Philippe Mathieu-Daudé wrote:
>> Scratch that. I think you have to keep CONFIG_MIPSSIM=y enabled in the
>> default-configs, don't you?
> I guess I misunderstood --without-default-devices with --no-defaults,
> where you'd manually select the machines you want.

Note that machines have to be included in default-configs/ even for
--with-default-devices (which is the default).

Paolo
