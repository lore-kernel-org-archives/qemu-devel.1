Received: from eggs.gnu.org ([209.51.188.92]:49287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jirislaby@gmail.com>) id 1ggkeX-0002u0-BX
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 01:14:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jirislaby@gmail.com>) id 1ggkeW-0001E6-KX
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 01:14:17 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jirislaby@gmail.com>) id 1ggkeW-0001A0-Dg
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 01:14:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so2816363wrw.5
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 22:14:15 -0800 (PST)
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-10-fli@suse.com>
	<87a7kcml5i.fsf@dusky.pond.sub.org>
From: Jiri Slaby <jslaby@suse.cz>
Message-ID: <36097839-654b-6d1f-b79e-f9bc174ec126@suse.cz>
Date: Tue, 8 Jan 2019 07:14:11 +0100
MIME-Version: 1.0
In-Reply-To: <87a7kcml5i.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 v9 09/16] qemu_thread: supplement
 error handling for pci_edu_realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Fei Li <fli@suse.com>
Cc: qemu-devel@nongnu.org, shirley17fei@gmail.com, lifei1214@126.com, peterx@redhat.com

On 07. 01. 19, 18:29, Markus Armbruster wrote:
>    static void pci_edu_uninit(PCIDevice *pdev)
>    {
>        EduState *edu = EDU(pdev);
> 
>        qemu_mutex_lock(&edu->thr_mutex);
>        edu->stopping = true;
>        qemu_mutex_unlock(&edu->thr_mutex);
>        qemu_cond_signal(&edu->thr_cond);
>        qemu_thread_join(&edu->thread);
> 
>        qemu_cond_destroy(&edu->thr_cond);
>        qemu_mutex_destroy(&edu->thr_mutex);
> 
>        timer_del(&edu->dma_timer);
>    }
> 
> Preexisting: pci_edu_uninit() neglects to call msi_uninit().  Jiri?\

I don't know, the MSI support was added in:
commit eabb5782f70b4a10975b24ccd7129929a05ac932
Author: Peter Xu <peterx@redhat.com>
Date:   Wed Sep 28 21:03:39 2016 +0800

    hw/misc/edu: support MSI interrupt

Hence CCing Peter.

thanks,
-- 
js
suse labs
