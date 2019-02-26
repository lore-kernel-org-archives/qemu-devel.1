Received: from eggs.gnu.org ([209.51.188.92]:38101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1gyaGx-0002zb-Ay
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 05:47:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1gyaGw-0002OS-5o
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 05:47:39 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <randrianasulu@gmail.com>)
	id 1gyaGv-0002MN-Ua
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 05:47:38 -0500
Received: by mail-pg1-x542.google.com with SMTP id 196so6020504pgf.13
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 02:47:30 -0800 (PST)
From: Andrew Randrianasulu <randrianasulu@gmail.com>
Date: Tue, 26 Feb 2019 13:44:20 +0300
References: <201902230335.59138.randrianasulu@gmail.com>
	<201902261246.41653.randrianasulu@gmail.com>
	<bf084052-f1d5-457a-d640-016ab3661217@redhat.com>
In-Reply-To: <bf084052-f1d5-457a-d640-016ab3661217@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <201902261344.20699.randrianasulu@gmail.com>
Subject: Re: [Qemu-devel] Build error with git commit
 8eb29f1bf5a974dc4c11d2d1f5e7c7f7a62be116 on x86_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=82 =
Tuesday 26 February 2019 12:58:11 =D0=B2=D1=8B =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BB=D0=B8:
> On 26/02/2019 10.46, Andrew Randrianasulu wrote:
> [...]
>
> > also, -g 1186x864x32 resulted in funnuy diagonal corruption even at
> > firmware screen level, and probably same happening with x86-64/kvm guest
> > if I select some less comon, but exposed via xrandr mode. (this bit for
> > -vga std, default)
>
> 1186 is not dividable by 16 ... you likely meant 1184 instead?
>
>  Thomas

yeah, just forgot exact number ..
not sure if it really bug or feature. Should qemu check (and enforce? or ju=
st=20
warn about?) those parameters, if specific video driver can't cope with=20
specific resolutions?=20

I also looked at offb sources:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/video/fbdev/offb.c?h=3Dv5.0-rc8

hm, because by default stdvga initialized by openfrmware to truecolor mode =
(32=20
bpp), then I assume cmap hacks not really applicable in this case? I'll try=
 to=20
play with switch at line 446 and specifically 'case 32' at line 480 ...
