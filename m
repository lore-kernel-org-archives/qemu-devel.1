Received: from eggs.gnu.org ([209.51.188.92]:48924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <casasfernando@outlook.com>) id 1gxa31-0004rB-5I
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 11:21:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <casasfernando@outlook.com>) id 1gxa30-00060J-9v
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 11:21:07 -0500
Received: from mail-oln040092066042.outbound.protection.outlook.com
	([40.92.66.42]:35489
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <casasfernando@outlook.com>)
	id 1gxa2z-0005z7-Q6
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 11:21:06 -0500
From: =?iso-8859-1?Q?Fernando_Casas_Sch=F6ssow?= <casasfernando@outlook.com>
Date: Sat, 23 Feb 2019 16:21:02 +0000
Message-ID: <VI1PR0602MB3245F92EC705E3553C2EE478A4780@VI1PR0602MB3245.eurprd06.prod.outlook.com>
References: <VI1PR0602MB32452A8FD128F63FFAC0CEADA4920@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<VI1PR0602MB32453A8B5CBC0308C7D18F1DA47E0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
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
	<20190223165523.1d674224@ncopa-desktop.copa.dup.pw>
In-Reply-To: <20190223165523.1d674224@ncopa-desktop.copa.dup.pw>
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
To: Natanael Copa <ncopa@alpinelinux.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel <qemu-devel@nongnu.org>

Hi Natanael,

The package information is the following:

https://pkgs.alpinelinux.org/package/v3.9/main/x86_64/qemu-system-x86_64

The binary is for x86_64 architecture and dynamically linked:

fernando@vmsvr01:~$ file /usr/bin/qemu-system-x86_64
/usr/bin/qemu-system-x86_64: ELF 64-bit LSB shared object, x86-64, version =
1 (SYSV), dynamically linked, interpreter /lib/ld-musl-x86_64.so.1, strippe=
d

Thanks.

On s=E1b, feb 23, 2019 at 4:55 PM, Natanael Copa <ncopa@alpinelinux.org> wr=
ote:
On Fri, 22 Feb 2019 14:04:20 +0000 Stefan Hajnoczi <stefanha@gmail.com<mail=
to:stefanha@gmail.com>> wrote:
On Fri, Feb 22, 2019 at 12:57 PM Fernando Casas Sch=F6ssow <casasfernando@o=
utlook.com<mailto:casasfernando@outlook.com>> wrote: I have CCed Natanael C=
opa, qemu package maintainer in Alpine Linux. Fernando: Can you confirm tha=
t the bug occurs with an unmodified Alpine Linux qemu binary?
I wonder exactly which binary it is. What arcitecture (x86 or x86_64) and w=
hat binary. Is it ddynamic or statically linked qemu-system-x86_64?
