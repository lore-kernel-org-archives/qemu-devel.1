Received: from eggs.gnu.org ([2001:4830:134:3::10]:36426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e1ZZr-00053R-2Y
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:02:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e1ZZn-00054q-VI
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:02:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e1ZZn-00054e-Os
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:02:39 -0400
Date: Mon, 9 Oct 2017 16:02:31 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171009150231.GN2954@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171009145542.GA1771@perard.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171009145542.GA1771@perard.uk.xensource.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel]
 =?utf-8?b?4oCYdnRlX3Rlcm1pbmFsX2NvcHlfY2xpcGJvYXJk?=
 =?utf-8?q?=E2=80=99_is_deprecated?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

On Mon, Oct 09, 2017 at 03:55:42PM +0100, Anthony PERARD wrote:
> Hi,
>=20
> Looks like vte_terminal_copy_clipboard() is been deprecated:
>=20
>   CC      ui/gtk.o
> ui/gtk.c: In function =E2=80=98gd_menu_copy=E2=80=99
> ui/gtk.c:1705:5: error: =E2=80=98vte_terminal_copy_clipboard=E2=80=99 i=
s deprecated [-Werror=3Ddeprecated-declarations]
>      vte_terminal_copy_clipboard(VTE_TERMINAL(vc->vte.terminal));
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from /usr/include/vte-2.91/vte/vte.h:35:0,
>                  from ui/gtk.c:47:
> /usr/include/vte-2.91/vte/vtedeprecated.h:94:6: note: declared here
>  void vte_terminal_copy_clipboard(VteTerminal *terminal) _VTE_GNUC_NONN=
ULL(1);
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make: *** [/local/home/sheep/work/qemu/rules.mak:66: ui/gtk.o] Error 1

The docs say it should be simply replaced with a call to
vte_terminal_copy_clipboard_format, using VTE_FORMAT_TEXT
as the format.

So we just need to make either the old or new method call
conditional on VTE version >=3D 0.50.0

Since you've got the new vte installed to test with, do you
want to write a patch for that :-)

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
