Received: from eggs.gnu.org ([2001:4830:134:3::10]:53995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e3J0w-0004WJ-Fs
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 05:45:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e3J0t-0002dO-BO
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 05:45:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1e3J0t-0002cp-5F
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 05:45:47 -0400
Date: Sat, 14 Oct 2017 17:45:43 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171014094543.GA32099@lemon>
References: <58f74661-3830-4127-e30b-37baebeba532@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <58f74661-3830-4127-e30b-37baebeba532@suse.de>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qemu-img convert to VMDK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guilherme Moro <gmoro@suse.de>
Cc: qemu-devel@nongnu.org

On Fri, 10/13 15:20, Guilherme Moro wrote:
> Hi,
>=20
> I'm trying to convert some images from raw to vmdk to run in a ESXi6.5
> server but I need to rectify the image before being able to run.
>=20
> The scenario goes like that:
>=20
> qemu-img convert -f raw image.raw -O vmdk -o compat6 image.vmdk
> ESXi complains with "Failed - File system specific implementation of
> LookupAndOpen"[file] failed
> running vmkfstools -x repair on the image make it bootable
>=20
> =A0I checked the changes, vmkfstools is basically removing the second
> descriptor from the end of the file, I'm not familiar enough with the c=
ode
> and the format to know what this means, maybe compat6 should make qemu-=
img
> avoid to put that in the end of the file (again, mostly guessing).
>=20
> Anyway we would need an option to make sure that this second descriptor=
 does
> not end in the final image.

What do you mean by "second descriptor"? The one at offset 0x200? But oth=
er than
this descriptor I don't see a second one. Maybe I'm missing something?

Fam
