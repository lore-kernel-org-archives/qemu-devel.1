Received: from eggs.gnu.org ([2001:4830:134:3::10]:33017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e1SYv-0007L2-Dg
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 03:33:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e1SYs-00085H-A6
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 03:33:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e1SYs-000851-3U
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 03:33:14 -0400
Message-ID: <1507534390.32088.5.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 09 Oct 2017 09:33:10 +0200
In-Reply-To: <87376suayp.fsf@dusky.pond.sub.org>
References: <CY4PR15MB1464F1EE43FD8CA97C728FD3F3760@CY4PR15MB1464.namprd15.prod.outlook.com>
	<87376suayp.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] What is the status of the QEMU sound rework?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Zir Blazer <zir_blazer@hotmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

  Hi,

> > GSoC 2015 QEMU rework of the sound environmental variables
> > https://wiki.qemu.org/Google_Summer_of_Code_2015#QEMU_audio_backend

Code is here:
https://www.kraxel.org/cgit/qemu/log/?h=testing/audio.gsoc

Merge was blocked back then due to depending on a QAPI updates.  Those
QAPI updates are merged meanwhile, even though it took quite a while
(merged late 2016 IIRC).

So, this series basically needs a rebase.  I suspect that is a multi-
week project minimum.  May well expand to be multiple months.  Which
leads us to ...

> > GSoC 2017 QEMU rework a patch series that did precisely that
> > https://wiki.qemu.org/Google_Summer_of_Code_2017#QEMU_audio_backend

... this one.  But no student was interested in this project.

Fundamental issue is that right now there is not really someone paying
attention to audio in qemu.

I'm currently the maintainer, but due to also being busy with other
stuff I hardly find time to do anything beyond picking up fixes from
the mailing list, maybe do some basic testing (depending on the kind of
patches) and do a audio pull request now and then.

> > Is anyone tinkering with the idea of making a paravirtualized Sound
> > Card and its associated Drivers for the mainstream OSes to try to
> > fix once and for all the sound issues?

I suspect the problems are more in the qemu audio backends.  The issues
seem to be different depending on which backend you use.  So creating a
paravirtual sound card may not be the solution for that problem ...

cheers,
  Gerd
