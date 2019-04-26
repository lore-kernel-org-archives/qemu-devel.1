Received: from eggs.gnu.org ([209.51.188.92]:48633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hJwZd-0005ux-De
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 04:51:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hJwNP-0003hy-4L
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 04:38:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hJwNO-0003hF-Rm
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 04:38:35 -0400
Date: Fri, 26 Apr 2019 10:38:30 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190426083830.kj7currufo637loa@sirius.home.kraxel.org>
References: <4ec13220-0c12-3b87-6a79-49a42a38db01@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <4ec13220-0c12-3b87-6a79-49a42a38db01@suse.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] About pt-br keyboard layout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lin Ma <lma@suse.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com

On Fri, Apr 26, 2019 at 04:09:12PM +0800, Lin Ma wrote:
> Hi all,
>=20
> While I launch qemu with vnc + pt-br keyboard layout on my pc, If I typ=
e
> shift + 6 in iPXE shell or grub shell via my usual 105-key keyboard,
> shift + 6 would be mapped to "(apostrophe), But IIUC the correct charac=
ter
> should be =A8(diaeresis) in pt-br layout.
>=20
> I'm wondering that is it the expected behavior? In other words, Does it=
 make
> sense if I want to type multi-character characters(say =C7 or =A8) with=
out guest
> os's help?

No.  -k is for translating keysyms back into the correct scancodes,
because this is what the (virtual) keyboard passes to the guest.
So -k must match the *hosts* keyboard layout.

Translating the scancodes into keysyms again is the job of the guest,
so that requires the keymapping you want to use being active in the
guest os.  Typically that would be the same you have on the host, but
that isn't required.  The guest can work with -- for example -- us
layout (like it is often the case in boot loaders).  Behavior should be
identical to physical hardware here.

HTH,
  Gerd
