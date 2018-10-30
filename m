Received: from eggs.gnu.org ([2001:4830:134:3::10]:54435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gHRzF-0001ob-EL
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:15:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gHRzE-0000z1-Ew
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:15:05 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40725)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gHRzE-0000xk-7k
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:15:04 -0400
Received: by mail-wr1-x442.google.com with SMTP id i17-v6so12066974wre.7
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 04:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20181029151956.2164336-1-stefanb@linux.ibm.com>
	<CAFEAcA8OOWbfC-ZpL7GuP81WYC6gGk2XC05DhGeXnceUUfv2mA@mail.gmail.com>
In-Reply-To: <CAFEAcA8OOWbfC-ZpL7GuP81WYC6gGk2XC05DhGeXnceUUfv2mA@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 30 Oct 2018 15:14:50 +0400
Message-ID: <CAJ+F1CLkm7Y6_XsqoQ=UOsAarqTDKGyBnAYUeZpQOH1dginbiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v1 0/5] Merge tpm 2018/10/29 v1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: stefanb@linux.ibm.com, QEMU <qemu-devel@nongnu.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>

Hi Peter

On Tue, Oct 30, 2018 at 2:45 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> On 29 October 2018 at 15:19, Stefan Berger <stefanb@linux.ibm.com> wrote:
> > From: Stefan Berger <stefanb@linux.vnet.ibm.com>
> >
> > This pull request fixes a couple of TPM support related issues,
> > such as full initialization of a variable to quiet down valgrind,
> > a possible race in the TPM related test cases and marking test
> > cases as skipped if swtpm was not found in PATH.
> >
> >    Stefan
> >
> > The following changes since commit a4d710251fa5aa9ec26de4626f11c7850019=
5d12:
> >
> >   Merge remote-tracking branch 'remotes/berrange/tags/qcrypto-next-pull=
-request' into staging (2018-10-24 22:08:42 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2018-10-29-1
> >
> > for you to fetch changes up to f9da599490730cf0c3016f15225d7f1ee15bec75=
:
> >
> >   tpm: Zero-init structure to avoid uninitialized variables in valgrind=
 log (2018-10-27 10:33:18 -0400)
> >
> > ----------------------------------------------------------------
> > Marc-Andr=C3=A9 Lureau (2):
> >       tests/tpm: fix tpm_util_swtpm_has_tpm2()
> >       tests/tpm: mark swtpm test as skipped instead of successful
> >
> > Stefan Berger (3):
> >       docs: tpm: Mention implemented TPM CRB interface emulation and sp=
ecs
> >       MAINTAINERS: Change my email address to the new domain
> >       tpm: Zero-init structure to avoid uninitialized variables in valg=
rind log
>
> Hi; this gives some test failures (all hosts):
>
> TEST: tests/tpm-crb-swtpm-test... (pid=3D305)
>   /i386/tpm/crb-swtpm/test:                                            FA=
IL
> GTester: last random seed: R02Sf628ca48da88252a6b95465fef3b855f
>   /i386/tpm/crb-swtpm-migration/test:                                  FA=
IL
> GTester: last random seed: R02Sf628ca48da88252a6b95465fef3b855f
> FAIL: tests/tpm-crb-swtpm-test
> TEST: tests/tpm-crb-test... (pid=3D311)
>   /i386/tpm-crb/test:                                                  OK
> PASS: tests/tpm-crb-test
> TEST: tests/tpm-tis-swtpm-test... (pid=3D324)
>   /i386/tpm/tis-swtpm/test:                                            FA=
IL
> GTester: last random seed: R02Sca4f303959770d4ca9f8f12b784dba0d
>   /i386/tpm/tis-swtpm-migration/test:                                  FA=
IL
> GTester: last random seed: R02Sca4f303959770d4ca9f8f12b784dba0d
> FAIL: tests/tpm-tis-swtpm-test
> TEST: tests/tpm-tis-test... (pid=3D331)
>   /i386/tpm-tis/test_check_localities:                                 OK
>   /i386/tpm-tis/test_check_access_reg:                                 OK
>   /i386/tpm-tis/test_check_access_reg_seize:                           OK
>   /i386/tpm-tis/test_check_access_reg_release:                         OK
>   /i386/tpm-tis/test_check_transmit:                                   OK
> PASS: tests/tpm-tis-test
>

What version of swtpm & libtpms is installed?

thanks

> and a compile failure on OSX:
> /Users/pm215/src/qemu-for-merges/hw/tpm/tpm_emulator.c:161:21: error:
> suggest braces around initialization of subobject
> [-Werror,-Wmissing-braces]
>     ptm_loc loc =3D { 0 };
>                     ^
>                     {}
>
> (what you want here is just "ptm_loc loc =3D {};" -- the "{ 0 }" syntax
> is the C standard one but not all compilers can handle it without warning=
s
> if the first member in the struct happens to be a substruct.)
>
> thanks
> -- PMM
>


--=20
Marc-Andr=C3=A9 Lureau
