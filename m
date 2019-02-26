Received: from eggs.gnu.org ([209.51.188.92]:36727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amagdy.afifi@gmail.com>) id 1gyXpz-0005lM-Oz
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 03:11:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amagdy.afifi@gmail.com>) id 1gyXpx-0000Tk-PW
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 03:11:39 -0500
MIME-Version: 1.0
References: <20190222162555.13764-1-amagdy.afifi@gmail.com>
	<20190222162555.13764-2-amagdy.afifi@gmail.com>
	<f782bdde-2a42-c612-5769-1cde42e7c2a4@linaro.org>
	<CAKV=O7mWBKQzVJRJT-bGW0Ojvb7eFraGniqG1-qPidZWHtp8Ew@mail.gmail.com>
	<bf134899-fa0b-2a27-dffd-92369805fd50@linaro.org>
	<CAKV=O7n02WMfgmfFqtC9OBgHppPYVO4RXPnKyfU8y872Lnr=zQ@mail.gmail.com>
In-Reply-To: <CAKV=O7n02WMfgmfFqtC9OBgHppPYVO4RXPnKyfU8y872Lnr=zQ@mail.gmail.com>
From: Amed Magdy <amagdy.afifi@gmail.com>
Date: Tue, 26 Feb 2019 10:11:23 +0200
Message-ID: <CAKV=O7nO_7XUt7PEr55BMWxn4SDFGgqjStHsYH9UPDLXu4MpUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] riscv: Add proper alignment check and
 pending 'C' extension upon misa writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de, palmer@sifive.com, mjc@sifive.com, Alistair.Francis@wdc.com

>
>
>> > It seems to me that the C extension can be enabled at any point, since
>> if C is
>> > off, you know that the next insn is aligned modulo 4.
>> >
>>
>
>  > Ok, This is mostly right. When C extension is enabled 32-bit base
> instructions can be aligned on 2 bytes boundaries instead of 4 bytes only.
> > So multiple enables and disables of C bit at different code areas
> theoretically may require this check on C extension enable. I'm not really
> >sure, may be this is might not  be a practical use scenario.
>

 This paragraph considers the current implementation of csr write for misa
register.
