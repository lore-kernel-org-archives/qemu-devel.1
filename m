Received: from eggs.gnu.org ([209.51.188.92]:53178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hHdIL-00063k-FR
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:51:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hHdFF-0002R3-L1
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:48:38 -0400
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144]:36500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1hHdFC-0002Nq-NQ
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:48:36 -0400
Received: by mail-it1-x144.google.com with SMTP id y10so10476112itc.1
	for <qemu-devel@nongnu.org>; Fri, 19 Apr 2019 16:48:32 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <58c00451-f216-610d-4c9c-7437fc07c5bc@twiddle.net>
Date: Fri, 19 Apr 2019 19:48:29 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <CD8629E0-5E3A-45AB-9C07-4405B658E3A5@gmail.com>
References: <20190418224706.14014-1-programmingkidx@gmail.com>
	<723372ae-a37a-d7cd-098f-452c7513ce8a@redhat.com>
	<4B73E5E6-2129-43B8-A35E-0CF7DCAE163B@gmail.com>
	<58c00451-f216-610d-4c9c-7437fc07c5bc@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH] configure: Change capstone's default state
 to disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org


> On Apr 19, 2019, at 2:22 PM, Richard Henderson <rth@twiddle.net> =
wrote:
>=20
> On 4/19/19 3:44 AM, G 3 wrote:
>>=20
>> Here is the error message I see when compiling QEMU:
>>=20
>> CHK version_gen.h
>> make[1]: *** No rule to make target
>> `/Users/John/qemu-git/capstone/libcapstone.a'.  Stop.
>> make: *** [subdir-capstone] Error 2
>=20
> You are configuring with --static?
>=20
> I've seen this before myself -- IMO it's broken distro packaging, in =
that the
> shipped pkgconfig/capstone.pc claims static library support, but the =
static
> library itself wasn't shipped.
>=20
> We should probably work around this in configure, and report the =
packaging bug.

I do not use --static. This is what I use: ./configure =
--target-list=3Dppc-softmmu.

I think this is a bug with configure, or with the capstone repo.=
