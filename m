Received: from eggs.gnu.org ([2001:4830:134:3::10]:50538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fpAGb-000523-Cd
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:40:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fpAGW-0005o0-GW
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:40:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51264 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fpAGW-0005mn-Ar
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:40:00 -0400
Date: Mon, 13 Aug 2018 12:39:56 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180813103956.xlqlffx5evamg2h7@sirius.home.kraxel.org>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
	<1533815202-11967-27-git-send-email-liran.alon@oracle.com>
	<20180810095654.drs4fwswdakktqbw@sirius.home.kraxel.org>
	<BC900BE8-12EB-4004-9AA4-A43A3A635C23@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BC900BE8-12EB-4004-9AA4-A43A3A635C23@oracle.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 26/29] vmsvga: Add basic support for
 display topology
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liran Alon <liran.alon@oracle.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net, habkost@redhat.com, Leonid Shatz <leonid.shatz@oracle.com>

  Hi,

> These registers are suppose to indicate to guest the display monitor
> size (width & height).

> Thus, wiring up GraphicsHwOps->ui_info callback to return new info on
> SVGA_REG_DISPLAY_{WIDTH, HEIGHT} registers may be useful only for case
> that we want guest to respond to the fact that the host display have
> been resized.

Yes, that is the purpose of the ui_info callback.  virtio-vga is the
easiest way to play with this:  Resize the gtk window, and gnome should
adapt the guest desktop to the new size, so you don't have a scaled
guest desktop.

> However, I am not sure there is a mechanism to notify guest from
> vmware-svga device that this even has occurred for guest to reread
> these registers.  Both in Linux vmware-svga driver code and VMware
> SVGA development kit, the SVGA_IRQFLAG_* flags don=E2=80=99t indicate s=
uch an
> interrupt source. In addition, it seems that Linux vmware-svga driver
> code only reads these registers at vmw_kms_save_vga() which weirdly
> enough, seems to be unreachable code (not called from anywhere=E2=80=A6=
).

Hmm, that is strange ...

> Therefore, I=E2=80=99m not sure it is important to do this change at th=
is
> patch series.

It isn't important for the series anyway.  Was just meant as hint where
the vmware-svga emulation could possibly improved even more, now that
you are at it.  It can certainly go either later as separate series or
not at all if it turns out it doesn't work anyway because the guests
drivers don't check the registers.

cheers,
  Gerd
