Received: from eggs.gnu.org ([209.51.188.92]:50351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghuOY-0001Pl-EH
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:50:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghuOU-0003WL-DX
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:50:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ghuOK-0003RT-PI
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:50:22 -0500
Date: Fri, 11 Jan 2019 11:50:13 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190111105013.mhcdfkrjjtogaddf@sirius.home.kraxel.org>
References: <20190103133113.49599-1-liq3ea@163.com>
	<20190107102218.wzzcisnfqpasqjiq@sirius.home.kraxel.org>
	<CAFEAcA_9jO1DEWvUNYdEvXbEWoDi+NR+ay6H21zaApoDdXKO4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_9jO1DEWvUNYdEvXbEWoDi+NR+ay6H21zaApoDdXKO4g@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] usb: dev-mtp: close fd in
 usb_mtp_object_readdir()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Li Qiang <liq3ea@163.com>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, Jan 07, 2019 at 10:35:30AM +0000, Peter Maydell wrote:
> On Mon, 7 Jan 2019 at 10:22, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > On Thu, Jan 03, 2019 at 05:31:13AM -0800, Li Qiang wrote:
> > > Spotted by Coverity: CID 1397070
> 
> > >  #ifdef CONFIG_INOTIFY1
> > > @@ -682,6 +683,7 @@ static void usb_mtp_object_readdir(MTPState *s, MTPObject *o)
> > >          usb_mtp_add_child(s, o, entry->d_name);
> > >      }
> > >      closedir(dir);
> > > +    close(fd);
> >
> > Not fully sure this is correct.
> >
> > The fdopendir manpage says the app should not use fd any more after
> > successfully calling fdopendir(), and I assumed that includes calling
> > close().
> 
> Yes. The POSIX spec is clearer:
> http://pubs.opengroup.org/onlinepubs/9699919799/functions/fdopendir.html
> "Upon successful return from fdopendir(), the file descriptor is under
>  the control of the system, and if any attempt is made to close the file
>  descriptor, or to modify the state of the associated description, other
>  than by means of closedir(), readdir(), readdir_r(), rewinddir(), or
>  seekdir(), the behavior is undefined. Upon calling closedir() the file
>  descriptor shall be closed."

Thanks for looking it up.

Patch added to usb queue, with the second chunk dropped.

cheers,
  Gerd
