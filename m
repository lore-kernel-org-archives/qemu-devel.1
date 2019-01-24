Received: from eggs.gnu.org ([209.51.188.92]:45577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmhnn-0003Fd-H1
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 11:24:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmhaQ-0005Uh-QZ
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 11:10:40 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gmhaK-0004Fk-J3
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 11:10:35 -0500
Received: by mail-wr1-f68.google.com with SMTP id t6so7044572wrr.12
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 08:10:23 -0800 (PST)
References: <20170816072104.24420-1-famz@redhat.com>
	<20170816072104.24420-9-famz@redhat.com>
	<ed7262b4-f84e-1405-dbe6-1ea5f11e73f1@redhat.com>
	<f4ede6c1-ba9e-777d-8b82-5776cd897943@gmx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4bf0c77e-ea8f-1813-a6a4-6ab6eb857cd0@redhat.com>
Date: Thu, 24 Jan 2019 17:10:19 +0100
MIME-Version: 1.0
In-Reply-To: <f4ede6c1-ba9e-777d-8b82-5776cd897943@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iWA0QwkJbsRQIUiDZZw6qsd134W0q6pa5"
Subject: Re: [Qemu-devel] [PATCH RFC 8/9] tests: Add OpenBSD image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>, Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Brad Smith <brad@comstyle.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: pbonzini@redhat.com, Kamil Rytarowski <kamil@netbsd.org>, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iWA0QwkJbsRQIUiDZZw6qsd134W0q6pa5
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Kamil Rytarowski <n54@gmx.com>, Fam Zheng <fam@euphon.net>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Brad Smith <brad@comstyle.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: pbonzini@redhat.com, Kamil Rytarowski <kamil@netbsd.org>,
 stefanha@redhat.com
Message-ID: <4bf0c77e-ea8f-1813-a6a4-6ab6eb857cd0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 8/9] tests: Add OpenBSD image
References: <20170816072104.24420-1-famz@redhat.com>
 <20170816072104.24420-9-famz@redhat.com>
 <ed7262b4-f84e-1405-dbe6-1ea5f11e73f1@redhat.com>
 <f4ede6c1-ba9e-777d-8b82-5776cd897943@gmx.com>
In-Reply-To: <f4ede6c1-ba9e-777d-8b82-5776cd897943@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/24/19 4:56 PM, Kamil Rytarowski wrote:
> On 24.01.2019 16:52, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 8/16/17 9:21 AM, Fam Zheng wrote:
>>> The image is prepared following instructions as in:
>>>
>>> https://wiki.qemu.org/Hosts/BSD
>>>
>>> Signed-off-by: Fam Zheng <famz@redhat.com>
>>> ---
>>>  tests/vm/openbsd | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 45 insertions(+)
>>>  create mode 100755 tests/vm/openbsd
>>>
>>> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
>>> new file mode 100755
>>> index 0000000000..d37ff83a59
>>> --- /dev/null
>>> +++ b/tests/vm/openbsd
>>> @@ -0,0 +1,45 @@
>>> +#!/usr/bin/env python
>>> +#
>>> +# OpenBSD VM image
>>> +#
>>> +# Copyright (C) 2017 Red Hat Inc.
>>> +#
>>> +# Authors:
>>> +#  Fam Zheng <famz@redhat.com>
>>> +#
>>> +# This work is licensed under the terms of the GNU GPL, version 2.  =
See
>>> +# the COPYING file in the top-level directory.
>>> +#
>>> +
>>> +import os
>>> +import sys
>>> +import logging
>>> +import subprocess
>>> +import tempfile
>>> +import time
>>> +import basevm
>>> +
>>> +class OpenBSDVM(basevm.BaseVM):
>>> +    name =3D "openbsd"
>>> +    BUILD_SCRIPT =3D """
>>> +        set -e;
>>> +        cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
>>> +        tar -xf /dev/rsd1c;
>>> +        ./configure --cc=3Dx86_64-unknown-openbsd6.1-gcc-4.9.4 --pyt=
hon=3Dpython2.7 {configure_opts};
>>> +        gmake -j{jobs};
>>> +        # XXX: "gmake check" seems to always hang or fail
>>> +        #gmake check;
>>
>> OK, Now it makes more sense...
>>
>> After spending various hours trying to fix various issues on OpenBSD, =
I
>> notice that we never ran tests on this OS.
>> The only binary I can run is qemu-img, the rest seems useless.
>> I'll summarize in a different thread.
>>
>=20
> Is this W^X related?

Part of it could be but I'm not sure.

The 6.1 VM provided by Fam has /usr/local mounted with wxallowed, I
tried building/running there and nothing changed, mmap() still returns
ENOTSUP:

(gdb) bt
#0  0x000017e3c156c50a in _thread_sys___syscall () at {standard input}:5
#1  0x000017e3c15e5d7a in *_libc_mmap (addr=3DVariable "addr" is not
available.
) at /usr/local/lib/libc/sys/mmap.c:47
#2  0x000017e17d9abc8b in alloc_code_gen_buffer () at
/usr/local/qemu/accel/tcg/translate-all.c:1064
#3  0x000017e17d9abd04 in code_gen_alloc (tb_size=3D0) at
/usr/local/qemu/accel/tcg/translate-all.c:1112
#4  0x000017e17d9abe81 in tcg_exec_init (tb_size=3D0) at
/usr/local/qemu/accel/tcg/translate-all.c:1149
#5  0x000017e17d9897e9 in tcg_init (ms=3D0x17e45e456800) at
/usr/local/qemu/accel/tcg/tcg-all.c:66
#6  0x000017e17d9891b8 in accel_init_machine (acc=3D0x17e3c3f50800,
ms=3D0x17e45e456800) at /usr/local/qemu/accel/accel.c:63
#7  0x000017e17d989312 in configure_accelerator (ms=3D0x17e45e456800,
progname=3D0x7f7fffff07b0 "lm32-softmmu/qemu-system-lm32") at
/usr/local/qemu/accel/accel.c:111
#8  0x000017e17d9d8616 in main (argc=3D1, argv=3D0x7f7fffff06b8,
envp=3D0x7f7fffff06c8) at vl.c:4325

Since the current script build into /var/tmp (which is symlinked to
/tmp) I also mounted /tmp wxallowed using the following patch:

-- >8 --
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -39,6 +39,12 @@ class OpenBSDVM(basevm.BaseVM):
         if os.path.exists(img):
             os.rename(img_tmp, img)
+        self.boot(img)
+        self.wait_ssh()
+        self.ssh_root_check("sed -E -i 's_(/tmp\ ffs)\ ([^\ ]*)_\\1
\\2,wxallowed_' /etc/fstab")
+        self.ssh_root_check("cat /etc/fstab")
+        self.ssh_root("halt -p")
+        self.wait()
---

$ mount
/dev/sd0a on / type ffs (local)
/dev/sd0k on /home type ffs (local, nodev, nosuid)
/dev/sd0d on /tmp type ffs (local, nodev, nosuid, wxallowed)
/dev/sd0f on /usr type ffs (local, nodev)
/dev/sd0g on /usr/X11R6 type ffs (local, nodev)
/dev/sd0h on /usr/local type ffs (local, nodev, wxallowed)
/dev/sd0j on /usr/obj type ffs (local, nodev, nosuid)
/dev/sd0i on /usr/src type ffs (local, nodev, nosuid)
/dev/sd0e on /var type ffs (local, nodev, nosuid)

Still no progress.

>=20
>>> +    """
>>> +
>>> +    def build_image(self, img, rebuild=3DFalse):
>>> +        if os.path.exists(img) and not rebuild:
>>> +            return
>>> +        cimg =3D self._download_with_cache("http://download.patchew.=
org/openbsd.img.xz")
>>> +        img_tmp_xz =3D img + ".tmp.xz"
>>> +        img_tmp =3D img + ".tmp"
>>> +        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
>>> +        subprocess.check_call(["xz", "-df", img_tmp_xz])
>>> +        subprocess.check_call(["mv", img_tmp, img])
>>> +
>>> +if __name__ =3D=3D "__main__":
>>> +    sys.exit(basevm.main(OpenBSDVM))
>>>
>>
>=20
>=20


--iWA0QwkJbsRQIUiDZZw6qsd134W0q6pa5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEicHnj2Ae6GyGdJXLoqP9bt6twN4FAlxJ42sACgkQoqP9bt6t
wN6hxBAAnsIQty95NIX6Jj3WlorD+S1xaXUYEKWdwNvXYFNlHfK3GXIqGzQJ6Jtq
jDQMp7Tp/qEYqR6d6N6CUkXDuEQgJHgrzRZ3q7p91wVYBHR7B2GoGr7jg5xdO04G
CbDY8Pi4vWUuPgPbxKbZbR9OgQf5F/iuXYPe7jPSdJ3h37j1Lmz7uMIRWCowm8x8
wIzKx28JF21p87+cg8w5AwGh8PxleUVLKet2YwGma+QTChshgB3Vljv7pNefXAWx
SpMt/X00MW7YsV6R+q+yr2T4HZtDP+/9Knz6efYHLLd46keeD9BFasNySyoUhhak
TF3pZAaqDFF1qPH+YQGimYzM7idnDNLAeEBc/UYwwvgqCdnzvs82LWRWLZzp7jfN
GdbBqDMIbPDHVnCBW6zsEC3N4ZsJgW8p47QZ0+37V/270UO9oN+w4sfHyYrVb+58
gxJWCLpfkapvVP/14jrZW168sQN/QrTcuQgavSmvt0P2Iiq24xMosiNf5zpArUQe
h6QDHjiHQaRuM7Izt4KkXaD/8yXRzuQvVyzfHAJwKKwWoKqOJUZiN8+Y1QhbxHpk
O2XvQ9aBPMH/ui8l4Cmb3fOimHgxKC7rMcE9ZBzsBK8tGSexFEwodgVWLbCc6it4
TdCvD5vE6D9PXKg4u1Z1HsKb7sqtoIPsCb3Eux4TsLYEUA4Tf9w=
=0Svt
-----END PGP SIGNATURE-----

--iWA0QwkJbsRQIUiDZZw6qsd134W0q6pa5--
