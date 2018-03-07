Received: from eggs.gnu.org ([2001:4830:134:3::10]:48865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1etY4b-0004QA-CG
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:21:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1etY4X-0005yv-JD
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:21:33 -0500
References: <20180306040154.3669-1-david@gibson.dropbear.id.au>
	<fd62ebf7-3abc-79a2-f269-825b4f8d6598@redhat.com>
	<DB7P194MB0378C28B4B253292D3248BC2C8D80@DB7P194MB0378.EURP194.PROD.OUTLOOK.COM>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fdc1c0b9-9d50-5777-8855-606537b7f9e1@redhat.com>
Date: Wed, 7 Mar 2018 13:21:18 +0100
MIME-Version: 1.0
In-Reply-To: <DB7P194MB0378C28B4B253292D3248BC2C8D80@DB7P194MB0378.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 00/30] ppc-for-2.12 queue 20180306
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: luigi burdo <intermediadc@hotmail.com>, David Gibson <david@gibson.dropbear.id.au>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 07.03.2018 13:16, luigi burdo wrote:
> HI,
> 
> i had test last git with Zoltan sam emultation but at start i recive this
> 
> ./qemu-system-ppc -M sam460ex
> qemu-system-ppc:
> /home/gigi/src/tags/ppc-for-2.12-20180306/include/qemu/rcu.h:89:
> rcu_read_unlock: asserzione "p_rcu_reader->depth != 0" non riuscita.
> Annullato (core dump creato)

I think that's a regression introduced with one of the latest commits.
Could you please try whether "git checkout 58e2e17dba49b43f4ac9de19468"
works better for you?

 Thomas
