Received: from eggs.gnu.org ([2001:4830:134:3::10]:49457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZHyV-0002dZ-8J
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 11:39:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZHyU-0006yJ-Ba
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 11:39:47 -0400
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229]:35258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fZHyU-0006wd-5Q
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 11:39:46 -0400
Received: by mail-oi0-x229.google.com with SMTP id i12-v6so6671239oik.2
	for <qemu-devel@nongnu.org>; Sat, 30 Jun 2018 08:39:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180630061040.6018-1-pbonzini@redhat.com>
References: <20180630061040.6018-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 30 Jun 2018 16:39:24 +0100
Message-ID: <CAFEAcA8Fj+Ym5KdCr4iCUKy+znrhFRxNNCQDH15dHLPcg4hbOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/47] More misc patches for 3.0 soft freeze
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

On 30 June 2018 at 07:09, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 109b25045b3651f9c5d02c3766c0b3ff63e6d1=
93:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2018-06-29 12:30:29 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 633e23f138f04ce776feaef78042901af883eafe:
>
>   serial: Open non-block (2018-06-29 17:31:08 +0200)
>
> ----------------------------------------------------------------
> * IEC units series (Philippe)
> * Hyper-V PV TLB flush (Vitaly)
> * git archive detection (Daniel)
> * host serial passthrough fix (David)
>

Compile failures I'm afraid:

/root/qemu/tests/test-qemu-opts.c:707:66: error: use of undeclared
identifier 'MiB'
    g_assert_cmphex(qemu_opt_get_size(opts, "size3", 0), =3D=3D, 2 * MiB);
                                                                 ^
/root/qemu/tests/test-qemu-opts.c:711:62: error: use of undeclared
identifier 'GiB'
    g_assert_cmphex(qemu_opt_get_size(opts, "size1", 0), =3D=3D, GiB / 10);
                                                             ^
/root/qemu/tests/test-qemu-opts.c:712:74: error: use of undeclared
identifier 'TiB'
    g_assert_cmphex(qemu_opt_get_size(opts, "size2", 0), =3D=3D, 16777215U =
* TiB);
                                                                         ^
/home/petmay01/linaro/qemu-for-merges/tests/test-keyval.c: In function
=E2=80=98test_keyval_visit_size=E2=80=99:
/home/petmay01/linaro/qemu-for-merges/tests/test-keyval.c:460:43:
error: =E2=80=98MiB=E2=80=99 undeclared (first use in this function)
/home/petmay01/linaro/qemu-for-merges/tests/test-keyval.c:460:43:
note: each undeclared identifier is reported only once for each
function it appears in
/home/petmay01/linaro/qemu-for-merges/tests/test-keyval.c:462:39:
error: =E2=80=98GiB=E2=80=99 undeclared (first use in this function)
/home/petmay01/linaro/qemu-for-merges/tests/test-keyval.c:464:50:
error: =E2=80=98TiB=E2=80=99 undeclared (first use in this function)

thanks
-- PMM
