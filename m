Received: from eggs.gnu.org ([2001:4830:134:3::10]:45224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zir_blazer@hotmail.com>) id 1e1TNC-0000Ac-2q
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 04:25:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zir_blazer@hotmail.com>) id 1e1TN7-0007CG-Au
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 04:25:14 -0400
Received: from mail-oln040092007050.outbound.protection.outlook.com
	([40.92.7.50]:8096
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zir_blazer@hotmail.com>)
	id 1e1TN6-00079x-SX
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 04:25:09 -0400
From: Zir Blazer <zir_blazer@hotmail.com>
Date: Mon, 9 Oct 2017 08:25:06 +0000
Message-ID: <CY4PR15MB14645F1B82057940D068F009F3740@CY4PR15MB1464.namprd15.prod.outlook.com>
References: <CY4PR15MB1464F1EE43FD8CA97C728FD3F3760@CY4PR15MB1464.namprd15.prod.outlook.com>
	<87376suayp.fsf@dusky.pond.sub.org>,
	<1507534390.32088.5.camel@redhat.com>
In-Reply-To: <1507534390.32088.5.camel@redhat.com>
Content-Language: es-AR
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] What is the status of the QEMU sound rework?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> > Fundamental issue is that right now there is not really someone paying

> > attention to audio in qemu.
> >
> > I'm currently the maintainer, but due to also being busy with other
> > stuff I hardly find time to do anything beyond picking up fixes from
> > the mailing list, maybe do some basic testing (depending on the kind of
> > patches) and do a audio pull request now and then.
> >
> >
> >
> > I suspect the problems are more in the qemu audio backends.  The issues
> > seem to be different depending on which backend you use.  So creating a
> > paravirtual sound card may not be the solution for that problem ...


Thanks for your reply.

The guy from reddit whose Thread I linked in the previous mail has done a b=
it more work, and his current status is this:
https://www.reddit.com/r/VFIO/comments/74vokw/improved_pulse_audio_driver_f=
or_qemu/

He identified some issues with the QEMU audio backend, and according to the=
 testers, his fixes seems to be working.

As it is probable that he eventually upstreams something, you may want to b=
e interesed in checking his work. I know that you just said that you don't =
have time, but since audio improvements for QEMU seems to have been stuck f=
or some years, it may be important to be proactive now that there is people=
 interesed and working in the issue, as to not lose this rare momentum.
