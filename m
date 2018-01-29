Received: from eggs.gnu.org ([2001:4830:134:3::10]:32908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1egE3P-0004CV-8w
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 13:21:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1egE3M-0004S0-3q
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 13:21:15 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:29756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1egE3L-0004Ls-TC
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 13:21:12 -0500
Date: Mon, 29 Jan 2018 19:21:02 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20180129082727.jvh4nc2cquuqylrv@sirius.home.kraxel.org>
Message-ID: <alpine.BSF.2.21.1801291701130.88941@zero.eik.bme.hu>
References: <CAE5jQCeSL5fRXBh5F9L3G5JkkwmS=sU9VS6Bu82Xpq5fMd=K8Q@mail.gmail.com>
	<20180129082727.jvh4nc2cquuqylrv@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: Re: [Qemu-devel] SDL2 UI behavior of switching views
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, 29 Jan 2018, Gerd Hoffmann wrote:
> On Sun, Jan 28, 2018 at 06:43:44PM +0300, Anatoly Trosinenko wrote:
>> When QEMU is run with GTK UI, it changes what is drawn on its single window
>> when I press Ctrl-Alt-{1,2,3,4}. But when I use SDL2 UI, it opens multiple
>> windows: a separate window per each view (display, monitor, serial,
>> parallel). Is it by design or is it a bug?
>
> It's intentional.  With gtk you can have separate windows too (try "View/Detach Tab").

Is there an option also to get back the old SDL1 behaviour with SDL2? 
Could that be made the default to make the transition easier?

Regards,
BALATON Zoltan
