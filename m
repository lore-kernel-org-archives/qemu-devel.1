Received: from eggs.gnu.org ([2001:4830:134:3::10]:36181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fGP53-0003ra-1Q
	for qemu-devel@nongnu.org; Wed, 09 May 2018 09:24:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fGP4z-0007V1-AI
	for qemu-devel@nongnu.org; Wed, 09 May 2018 09:24:29 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:46306)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fGP4z-0007SS-3V
	for qemu-devel@nongnu.org; Wed, 09 May 2018 09:24:25 -0400
Received: by mail-wr0-x22c.google.com with SMTP id a12-v6so4748077wrn.13
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 06:24:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4af4c034.10f40.16339ed38a1.Coremail.suhang16@mails.ucas.ac.cn>
References: <1524750698-16322-1-git-send-email-suhang16@mails.ucas.ac.cn>
	<1524750698-16322-2-git-send-email-suhang16@mails.ucas.ac.cn>
	<20180430142340.GD10576@stefanha-x1.localdomain>
	<4af4c034.10f40.16339ed38a1.Coremail.suhang16@mails.ucas.ac.cn>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 9 May 2018 14:24:23 +0100
Message-ID: <CAJSP0QUrtMb7bcv00Q124UkbcuHat=Ljwm82tsXp41PxyVoVxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 1/2] Implement .hex file loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Su Hang <suhang16@mails.ucas.ac.cn>
Cc: Jim Mussared <jim@groklearning.com>, Joel Stanley <joel@jms.id.au>, qemu-devel <qemu-devel@nongnu.org>

On Mon, May 7, 2018 at 10:27 AM, Su Hang <suhang16@mails.ucas.ac.cn> wrote:
>> > +    size_t total_size = 0;
>>
>> Please use int instead of size_t (see above for reasons).
> I have question here:
> Since `EXT_LINEAR_ADDR_RECORD` supports 32 bit addressing (up to 4GiB), is `int`
> big enough for this type?
> The same question will happen to other similar cases.
> Or should I use `long long` instead of `int`?

There is no way of fixing that without modifying hw/arm/boot.c to use
a different type for kernel_size.  It looks like the actual size is
never used in that file.  A bool would be enough to indicate whether
loading the kernel succeeded.

Then the Intel .hex file parser code could be adjusted to either just
return bool or to use an appropriate type as you suggested.

Stefan
