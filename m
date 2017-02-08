Received: from eggs.gnu.org ([2001:4830:134:3::10]:35012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cbMDC-0003Wm-AG
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 01:58:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cbMDB-0003Cl-Ck
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 01:58:42 -0500
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:34859)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cbMDB-0003C6-7B
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 01:58:41 -0500
Received: by mail-it0-x244.google.com with SMTP id 203so14657627ith.2
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 22:58:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <193b9259-ea12-2a97-572c-369e88533016@suse.cz>
References: <589a933e.54c0620a.e6952.a4c6@mx.google.com>
	<193b9259-ea12-2a97-572c-369e88533016@suse.cz>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 8 Feb 2017 14:58:40 +0800
Message-ID: <CAKXe6SK64qPtfZ2QwkYfehqnSSaPYsdHjjznS1firjocPafaCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] misc: edu: free dma timer in device unit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jiri Slaby <jslaby@suse.cz>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, Li Qiang <liqiang6-s@360.cn>

2017-02-08 14:53 GMT+08:00 Jiri Slaby <jslaby@suse.cz>:

> On 02/08/2017, 04:40 AM, Li Qiang wrote:
> > From: Li Qiang <liqiang6-s@360.cn>
> >
> > This can avoid a memory leak when hotplug and unplug.
> >
> > Signed-off-by: Li Qiang <liqiang6-s@360.cn>
> > ---
> >  hw/misc/edu.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/hw/misc/edu.c b/hw/misc/edu.c
> > index 401039c..7565552 100644
> > --- a/hw/misc/edu.c
> > +++ b/hw/misc/edu.c
> > @@ -375,6 +375,7 @@ static void pci_edu_uninit(PCIDevice *pdev)
> >      qemu_mutex_destroy(&edu->thr_mutex);
> >
> >      timer_del(&edu->dma_timer);
> > +    timer_free(&edu->dma_timer);
>
> Freeing a static timer does not sound correct to me?
>
>
Sorry, as there is a few example that doesn't free timer, I don't notice
this is a static timer.


> thanks,
> --
> js
> suse labs
>
