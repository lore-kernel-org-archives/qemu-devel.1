Received: from eggs.gnu.org ([209.51.188.92]:60999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <casasfernando@outlook.com>) id 1gxD3a-0001rC-58
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:48:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <casasfernando@outlook.com>) id 1gxD3W-00082i-BT
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:48:08 -0500
Received: from mail-oln040092071068.outbound.protection.outlook.com
	([40.92.71.68]:6360
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <casasfernando@outlook.com>)
	id 1gxD3U-0007xJ-HW
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:48:04 -0500
From: =?iso-8859-1?Q?Fernando_Casas_Sch=F6ssow?= <casasfernando@outlook.com>
Date: Fri, 22 Feb 2019 15:48:02 +0000
Message-ID: <VI1PR0602MB3245568F3DD5C7C5784AAB0FA47F0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
References: <VI1PR0602MB32452A8FD128F63FFAC0CEADA4920@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<CAJSP0QVxaW3tezjBN9owJHsxzE9h8_qcaeRr5zHHKxKJOeFnkQ@mail.gmail.com>
	<CAJSP0QVXoZJ9MJ0qp4RM_m2fGJ8iFSyJMAU_X7mdiQvpOK59KA@mail.gmail.com>
	<VI1PR0602MB324516419266A934FE7759C6A47E0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<VI1PR0602MB324516419266A934FE7759C6A47E0@VI1PR0602MB3245.eurprd06.prod.outlo>
	<VI1PR0602MB32454C17192EFA863E29CC49A47E0@VI1PR0602MB3245.eurprd06.prod.outlo>
	<VI1PR0602MB324547F72DA9EDEB1613C888A47E0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<CAJSP0QUg=cq3tCSLidQ9BR2hxAo3K6gA6LKtpx5Rjb=_6XgJ6Q@mail.gmail.com>
	<28e6b4ed-9afd-3a79-6267-86c7385c23ce@redhat.com>
	<VI1PR0602MB324578F91F1AF9390D03022FA47F0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<CAJSP0QWouR43wVi0guTuASP9gc24_CPucbBvtfE5_htkDkmsrQ@mail.gmail.com>
	<VI1PR0602MB32457D7D0D6C05E83F14FE75A47F0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<ed1ffe8b-305b-9ae7-aa42-127f657622d7@redhat.com>
In-Reply-To: <ed1ffe8b-305b-9ae7-aa42-127f657622d7@redhat.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] Guest unresponsive after Virtqueue
 size exceeded error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Natanael Copa <ncopa@alpinelinux.org>, Richard Henderson <rth@twiddle.net>, qemu-devel <qemu-devel@nongnu.org>

You can find the the information here: https://wiki.alpinelinux.org/wiki/Cr=
eating_an_Alpine_package

For your convenience, I can setup an Alpine VM and give you SSH access with=
 the build environment and the aports tree already setup.
Then summary steps in case you want to try on your own container/VM would b=
e:

1- Setup the build environment as described in the wiki.
2- Clone aports tree: git clone https://github.com/alpinelinux/aports
3- Go into the qemu package directory directory in aports tree: cd aports/m=
ain/qemu
4- Run: abuild clean checksum unpack prepare deps build

This would get you the binary built.
If you need to add a patch. Create the patch file add it to the APKBUILD fi=
le and then run "abuild checksum" to compute it's checksum and add it to th=
e APKBUILD file.

abuild quick ref:

abuild clean: Remove temp build and install dirs
abuild unpack: Unpack sources to \$srcdir
abuild checksum: Generate checksum to be included in APKBUILD
abuild prepare: Apply patches
abuild deps: Install packages listed in makedepends and depends
abuild build: Compile and install package into $pkgdir

Once finished to clean up everything run: abuild undeps clean

Thanks.

Fernando


On vie, feb 22, 2019 at 3:55 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
On 22/02/19 15:43, Fernando Casas Sch=F6ssow wrote:
Hi all, Indeed I can confirm this issue occurs with the stock, unmodified Q=
EMU binary provided with Alpine since at least Alpine 3.6 up to 3.9. Is the=
re any compiler flag I can tweak, add or remove to rebuild qemu and try to =
repro to confirm a possible workaround?
Nope, not yet. However, I can try some experiments if you can provide some =
information on how to rebuild an apk. Paolo
