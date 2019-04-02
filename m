Received: from eggs.gnu.org ([209.51.188.92]:41981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hBJTB-0005Y5-04
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hBJT9-0004jr-KP
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:28:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hBJT9-0004jT-An
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:28:51 -0400
Date: Tue, 2 Apr 2019 14:28:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190402132846.GG413@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190402144725.fc998797b28431d714cbacfc@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190402144725.fc998797b28431d714cbacfc@wanadoo.fr>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Unknown X11 keycode mapping  report
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jean-Louis SOLATGES <jean-louis.solatges@wanadoo.fr>
Cc: qemu-devel@nongnu.org

On Tue, Apr 02, 2019 at 02:47:25PM +0200, Jean-Louis SOLATGES wrote:
> Bonjour, par tightvnc server sur clipper depuis un linux connect=C3=A9 =
en vncviewer,

Google translate doesn't do a good job here.

Is this saying that you are running QEMU from inside a TightVNC server
session running on Linux ?  IOW the X11 server would be Xvnc, not your
regular desktop Xorg server ?

>=20
> je lance :
> qemu-system-x86_64 -m 16G -cpu kvm64 -accel kvm,thread=3Dmulti -smp 6,m=
axcpus=3D12 -net nic -net tap -net socket,listen=3D127.0.0.1:1234 -vga ci=
rrus -boot c -hda uis1.img


Can you say what version of QEMU you are using too ?


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
