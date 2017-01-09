Received: from eggs.gnu.org ([2001:4830:134:3::10]:55492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cQbcv-0000Ys-14
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 10:12:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cQbcr-0007yg-SQ
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 10:12:48 -0500
Received: from relay4-d.mail.gandi.net ([2001:4b98:c:538::196]:45902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcd@tribudubois.net>) id 1cQbcr-0007yI-Ne
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 10:12:45 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Mon, 09 Jan 2017 16:12:37 +0100
From: jcd@tribudubois.net
In-Reply-To: <CAFEAcA9fRh=MteBdYAxrgGWADovA4tTa4gNmOsfVbCnYggnRVw@mail.gmail.com>
References: <20170107122047.26300-1-jcd@tribudubois.net>
	<CAFEAcA9fRh=MteBdYAxrgGWADovA4tTa4gNmOsfVbCnYggnRVw@mail.gmail.com>
Message-ID: <0df5dfd1a3475a7a3da7f90aabe4e641@tribudubois.net>
Subject: Re: [Qemu-devel] [PATCH v3] [i.MX] Remove MSGDATA register support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Marcin_Krzemi?= =?UTF-8?Q?=C5=84ski?= <mar.krzeminski@gmail.com>

Le 2017-01-09 12:56, Peter Maydell a écrit :
> On 7 January 2017 at 12:20, Jean-Christophe Dubois 
> <jcd@tribudubois.net> wrote:
>> From the documentation it is not clear what this SPI register is 
>> about.
>> 
>> Moreover, neither linux driver nor xvisor driver are using this SPI 
>> register.
>> 
>> For now we just remove it and issue a log on register write access.
> 
> By the way, could you make sure you use standard commit subject
> line forms like
>  hw/spi/imx_spi.c: Remove ...

OK, I'll do this next time.

> 
> If you put [i.MX] in square brackets like that then patch application
> tools remove it (on the assumption that it's a meta-tag like [PATCH])
> and the commit summary in git ends up just "Remove MSGDATA register 
> support"
> with no indication of what bit of the code it is dealing with.
> 
> (I fixed up these two patches manually when I put them into 
> target-arm.)
> 
> thanks
> -- PMM
