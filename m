Received: from eggs.gnu.org ([2001:4830:134:3::10]:37943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dcANg-0001vr-49
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:05:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dcANc-0008TU-1u
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:05:08 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:38132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dcANb-0008Rm-SN
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:05:03 -0400
Received: by mail-pg0-x242.google.com with SMTP id 125so17223382pgi.5
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 06:05:02 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <CAOMFOmXXRN02BT+8M+iKnrGmaTSR8uWoTYCu5A5gv+KTe9xAqg@mail.gmail.com>
	<CAFEAcA8N_JyMVtLPdSFEUUgmJ0OG6AbHuD=5KhO8kv3fJDLwGw@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <19ee3dfd-dd1c-191d-14fb-a44058c8ccb6@twiddle.net>
Date: Mon, 31 Jul 2017 06:04:59 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8N_JyMVtLPdSFEUUgmJ0OG6AbHuD=5KhO8kv3fJDLwGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] How to make ELF headers/symbol sections available
 for multiboot?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

On 07/31/2017 01:50 AM, Peter Maydell wrote:
> On 28 July 2017 at 22:28, Anatol Pomozov <anatol.pomozov@gmail.com> wrote:
>> So I need to perform 2 things:
>>
>>   - Load ELF section headers into target's memory. I did by appending
>> additional space to mbs.mb_buf and copying header data. Is it the best
>> way to do?
>>
>>   - Next I need to load other ELF sections such as symbols (e.g.
>> .shstrtab) that store section names. What is the best way to do in
>> multiboo.c code? Would it make sense to load all ELF sections?
> 
> This seems a bit odd, because in general an ELF loader should
> not care at all about sections and the section header. It
> should only need to look at the program header, which defines
> which segments to load. If the guest binary needs some things
> to be loaded then I would expect that it is the job of the linker
> that produces the guest binary to make sure those things are in
> segments which are marked as LOAD.

Agreed.  If you're touching ELF sections, then I think you're missing the point 
of the ELF program header entirely.  If you write your own linker script, you 
have complete control of the ELF PHDR, and can arrange for anything you like to 
be loaded.


r~
