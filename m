Received: from eggs.gnu.org ([2001:4830:134:3::10]:50934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dvSP1-0000nC-Ft
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 14:10:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dvSP0-0003eM-Cb
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 14:10:15 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:50951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dvSP0-0003e0-5b
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 14:10:14 -0400
Received: by mail-wr0-x229.google.com with SMTP id w12so1497889wrc.7
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 11:10:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170922150410.20689-1-pbonzini@redhat.com>
References: <20170922150410.20689-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Sep 2017 19:09:52 +0100
Message-ID: <CAFEAcA9NBEwdTRk2XD3CZ9+V6O-RqMMSJMGzDQwHbzgd46UU4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/32] Misc patches for 2017-09-22 (v2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 22 September 2017 at 16:04, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit b62b7ed0fc9c58e373b8946c9bd2e193be98da=
e6:
>
>   Merge remote-tracking branch 'remotes/gkurz/tags/for-upstream' into sta=
ging (2017-09-20 20:33:48 +0100)
>
> are available in the git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 8acf7b48e0098198057db048340606c7fbfc6518:
>
>   chardev: remove context in chr_update_read_handler (2017-09-22 14:03:27=
 +0200)
>
> v2 fixes some issues with the new qemu-pr-helper.  make install and syste=
md
> socket activation were broken.  I have now backported it to the Fedora QE=
MU
> packages to shake out any distro-level issues.
>
> ----------------------------------------------------------------
> * Speed up AddressSpaceDispatch creation (Alexey)
> * Fix kvm.c assert (David)
> * Memory fixes and further speedup (me)
> * Persistent reservation manager infrastructure (me)
> * virtio-serial: add enable_backend callback (Pavel)
> * chardev GMainContext fixes (Peter)

In today's episode of "compiler whinges" we have

/home/pm215/qemu/scsi/qemu-pr-helper.c: In function =E2=80=98main=E2=80=99:
/home/pm215/qemu/scsi/qemu-pr-helper.c:912:5: error: comparison is
always true due to limited range of data type [-Werror=3Dtype-limits]
     while ((ch =3D getopt_long(argc, argv, sopt, lopt, &opt_ind)) !=3D -1)=
 {
     ^

(reported by the gcc on my ppc64, s390x, aarch64, aarch32 setups).

This one's a genuine bug, I think: ch is a char, which is unsigned on
these systems, and so the loop would never terminate.

thanks
-- PMM
