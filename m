Received: from eggs.gnu.org ([2001:4830:134:3::10]:54657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etYZC-0004Iq-Gk
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:53:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etYZ8-0000Ru-LV
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:53:10 -0500
Date: Wed, 7 Mar 2018 13:52:55 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180307135255.47cb0e8b.cohuck@redhat.com>
In-Reply-To: <fdc1c0b9-9d50-5777-8855-606537b7f9e1@redhat.com>
References: <20180306040154.3669-1-david@gibson.dropbear.id.au>
	<fd62ebf7-3abc-79a2-f269-825b4f8d6598@redhat.com>
	<DB7P194MB0378C28B4B253292D3248BC2C8D80@DB7P194MB0378.EURP194.PROD.OUTLOOK.COM>
	<fdc1c0b9-9d50-5777-8855-606537b7f9e1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Thomas Huth <thuth@redhat.com>
Cc: luigi burdo <intermediadc@hotmail.com>, David Gibson <david@gibson.dropbear.id.au>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Paolo Bonzini <pbonzini@redhat.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

On Wed, 7 Mar 2018 13:21:18 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 07.03.2018 13:16, luigi burdo wrote:
> > HI,
> > 
> > i had test last git with Zoltan sam emultation but at start i recive this
> > 
> > ./qemu-system-ppc -M sam460ex
> > qemu-system-ppc:
> > /home/gigi/src/tags/ppc-for-2.12-20180306/include/qemu/rcu.h:89:
> > rcu_read_unlock: asserzione "p_rcu_reader->depth != 0" non riuscita.
> > Annullato (core dump creato)  
> 
> I think that's a regression introduced with one of the latest commits.
> Could you please try whether "git checkout 58e2e17dba49b43f4ac9de19468"
> works better for you?

Yep, it's a regession; I hit this with s390x/tcg as well (bisected to
commit 11e732a5ed46903f997985bed4c3767ca28a7eb6 in my case).
