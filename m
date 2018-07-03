Received: from eggs.gnu.org ([2001:4830:134:3::10]:35428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1faE1e-0006zo-W2
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:38:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1faE1b-0002X8-Sx
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:38:55 -0400
Received: from mail.ispras.ru ([83.149.199.45]:50358)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1faE1b-0002WH-Kp
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:38:51 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180614193147.29680-15-richard.henderson@linaro.org>
	<000601d40f7a$4be320b0$e3a96210$@ru>
	<20180629184832.GB14726@flamenco>
	<000901d411c8$d3bfc9c0$7b3f5d40$@ru>
	<20180702195234.GB20840@flamenco>
In-Reply-To: <20180702195234.GB20840@flamenco>
Date: Tue, 3 Jul 2018 08:38:52 +0300
Message-ID: <000601d41290$205c56a0$611503e0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PULL,
 14/18] translate-all: discard TB when tb_link_page returns an
 existing matching TB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "'Emilio G. Cota'" <cota@braap.org>
Cc: 'Richard Henderson' <richard.henderson@linaro.org>, qemu-devel@nongnu.org, peter.maydell@linaro.org

> From: Emilio G. Cota [mailto:cota@braap.org]
> On Mon, Jul 02, 2018 at 08:52:14 +0300, Pavel Dovgalyuk wrote:
> > The same failure can be reproduced with linux-0.2.img, which was
> > downloaded from QEMU site.
> > I can't find it now, but I can upload this file if needed.
> 
> Please upload it somewhere and share the full QEMU invocation
> needed to replicate.

https://github.com/Dovgalyuk/qemu-images/blob/master/linux-0.2.img

qemu-system-i386 -drive file=images/linux-0.2.img,if=none,snapshot,id=img -drive
driver=blkreplay,if=none,id=rr,image=img -device ide-hd,drive=rr -net none -icount
shift=5,rr=record,rrfile=linux02.rr

Pavel Dovgalyuk
