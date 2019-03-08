Received: from eggs.gnu.org ([209.51.188.92]:42518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2E1L-0004jr-40
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:50:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2E1I-0001ED-Dc
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:50:34 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:43622)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h2E1I-0000q3-2H
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:50:32 -0500
Received: by mail-wr1-x429.google.com with SMTP id d17so21037512wre.10
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 03:50:29 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <87va0vgad2.fsf@zen.linaroharston>
	<67ec0d63-69e2-6f2e-aa76-6950bca69e90@oracle.com>
	<87bm2lfxz1.fsf@zen.linaroharston>
From: Paolo Bonzini <bonzini@gnu.org>
Message-ID: <c55ef7d8-1ef5-c6ce-7876-9f7ce2371f26@gnu.org>
Date: Fri, 8 Mar 2019 12:48:09 +0100
MIME-Version: 1.0
In-Reply-To: <87bm2lfxz1.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Booting kernels with PVHVM documentation?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Liam Merwick <liam.merwick@oracle.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 08/03/19 11:43, Alex Bennée wrote:
>>
>> sudo $QEMU \
>>       -name testvm01 \
>>       -machine
>> q35,accel=kvm,kernel_irqchip,nvdimm,nosmm,nosmbus,nosata,nopit \
> 
> Hmm if I use the q35 machine type I might have to rethink the approach
> for getting output and results as I'm currently using the isa debugcon
> and debug exit devices.

q35 supports ISA, but it shouldn't be needed.  pc should work.

Paolo
