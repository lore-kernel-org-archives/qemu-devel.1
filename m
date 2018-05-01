Received: from eggs.gnu.org ([2001:4830:134:3::10]:38165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rafaelkioji@gmail.com>) id 1fDSog-0006sr-So
	for qemu-devel@nongnu.org; Tue, 01 May 2018 06:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rafaelkioji@gmail.com>) id 1fDSod-0001fY-Pu
	for qemu-devel@nongnu.org; Tue, 01 May 2018 06:47:26 -0400
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a]:43476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rafaelkioji@gmail.com>)
	id 1fDSod-0001fL-J1
	for qemu-devel@nongnu.org; Tue, 01 May 2018 06:47:23 -0400
Received: by mail-pf0-x22a.google.com with SMTP id j11so8875859pff.10
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 03:47:23 -0700 (PDT)
References: <1fa7369f-9c6d-73c6-77e1-7911a9538d82@gmail.com>
	<87vac7adz2.fsf@linaro.org>
	<8f27190a-3875-2eea-4138-172e590f4eb2@gmail.com>
	<CAFEAcA-XVP-z2==XJk265KG8N-3ECVuZ3ubFuVO7O0_RxssBcA@mail.gmail.com>
From: Rafael Kioji <rafaelkioji@gmail.com>
Message-ID: <ee6f3065-2a80-aad9-e835-5be84f2d0bd5@gmail.com>
Date: Tue, 1 May 2018 18:47:13 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-XVP-z2==XJk265KG8N-3ECVuZ3ubFuVO7O0_RxssBcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] Translation block identification.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

Solved. The reason I was not able to get the symbols is because logging 
has to be enabled, otherwise the symbols are not loaded. In "elfload.c" 
there is the condition:

> if (qemu_log_enabled()) {
>     load_symbols(ehdr, image_fd, load_bias);
> }

Thanks!

Kind regards,
Rafael

On 5/1/2018 6:28 PM, Peter Maydell wrote:
> On 1 May 2018 at 11:20, Rafael Kioji <rafaelkioji@gmail.com> wrote:
>> This logging flag prints what I want. But I really wanted is to get this
>> info inside the QEMU source code. Why am I not able to lookup the symbols in
>> the translator.c file the way I showed?
> The -d in_asm logging is just using lookup_symbol() (eg for arm
> I think it's in arm_tr_disas_log() that that particular logging
> is done), so if it works when it's called by the existing QEMU code
> but not in your modification then it sounds like there's an
> error in your modification somewhere.
>
> thanks
> -- PMM
