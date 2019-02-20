Received: from eggs.gnu.org ([209.51.188.92]:50576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1gwNKE-0000TO-G3
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 03:33:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1gwNK3-0004nz-RP
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 03:33:48 -0500
Received: from isrv.corpit.ru ([86.62.121.231]:33399)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mjt@tls.msk.ru>) id 1gwNK2-0004k2-PD
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 03:33:43 -0500
References: <155049381165.1196.17842630458734820476.reportbug@cerebro.laendle>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <eb69a590-ed69-dbe1-edfd-365dbc559d84@msgid.tls.msk.ru>
Date: Wed, 20 Feb 2019 11:33:40 +0300
MIME-Version: 1.0
In-Reply-To: <155049381165.1196.17842630458734820476.reportbug@cerebro.laendle>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Bug#922612: qemu-system: black screen when guest
 goes to powersave, does not come back
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 922612@bugs.debian.org, qemu-devel qemu-devel <qemu-devel@nongnu.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>

Forwarding from Debian bugreport http://bugs.debian.org/922612

18.02.2019 15:43, Marc Lehmann wrote:
> Package: qemu-system
> Version: 1:3.1+dfsg-4
> Severity: normal
> 
> Dear Maintainer,
> 
> after upgrading to qemu 3.1 from stretch [from qemu 2.8 -- mjt], I found
> that both linux and windows guests, when using the qxl device, do not
> come back from deep power save.
> 
> That is, when I run either a standard ubuntu 17.10 or windows 10 (with
> qxl-dod driver), then by default they switch off the screen after a while,
> which results in black screen in qemu, as expected.
> 
> If one moves the mouse or presses a key shortly after this, the screen comes back.
> 
> If I let the systems idle for longer (say, half an hour), then they seem
> to go into a deeper powersave, and pressing a key or moving the mouse does
> NOT restore the screen - it stays black.
> 
> When the vm is in this state, I have not found a way to get the display
> back, the only way that works is to quit qemu and start it again (meaning
> boot the guest again in a new qemu instance, I have not tried to
> suspend/resume a vm).
> 
> I have verified that mouse inputs and keypresses are registered correctly
> by the guest in this state, so I assume it does try to switch on the
> virtual monitor.
> 
> Since this happens with both linux and windows guests, this looks like a
> bug in qemu's display code to me.

Thanks,

/mjt
