Received: from eggs.gnu.org ([2001:4830:134:3::10]:50649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8Ogr-00021x-8b
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 07:54:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8OXs-0005qx-Pf
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 07:45:27 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:38828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g8OXi-0005U5-2c
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 07:45:19 -0400
Received: by mail-ot1-x329.google.com with SMTP id h15-v6so12389517otj.5
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 04:45:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181003141833.21493-1-marcandre.lureau@redhat.com>
References: <20181003141833.21493-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Oct 2018 12:44:50 +0100
Message-ID: <CAFEAcA-KwDYpybZWsQstxR0i1SD5L=nn=khyRJ_cXLMHEWR_MA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/12] Option patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 3 October 2018 at 15:18, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> The following changes since commit dafd95053611aa14dda40266857608d12ddce6=
58:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2018-10-02 18:27:18 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/elmarco/qemu.git tags/option-pull-request
>
> for you to fetch changes up to 9066f2c2b6494206839835c9d37482425e1983d9:
>
>   vl: list user creatable properties when 'help' is argument (2018-10-03 =
18:03:17 +0400)
>
> ----------------------------------------------------------------
> CLI help improvements
>
> ----------------------------------------------------------------

Hi. This seems to fail "make check" on all platforms:


MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
gtester -k --verbose -m=3Dquick t
ests/check-qom-proplist
TEST: tests/check-qom-proplist... (pid=3D21624)
  /qom/proplist/createlist:                                            OK
  /qom/proplist/createv:                                               OK
  /qom/proplist/createcmdline:                                         OK
  /qom/proplist/badenum:                                               OK
  /qom/proplist/getenum:                                               OK
Found prop 'type'
  /qom/proplist/iterator:                                              **
ERROR:/home/petmay01/linaro/qemu-for-merges/tests/check-qom-proplist.c:540:=
test_dummy_prop_itera
tor: code should not be reached
FAIL
GTester: last random seed: R02S55ffa6110c89eb6405f845acf4ca5558
(pid=3D21627)
  /qom/proplist/class_iterator:
Found prop 'type'
**
ERROR:/home/petmay01/linaro/qemu-for-merges/tests/check-qom-proplist.c:540:=
test_dummy_prop_itera
tor: code should not be reached
FAIL
GTester: last random seed: R02Scdce3ab505045deea3b5df4d6b7e75c8
(pid=3D21629)
  /qom/proplist/delchild:                                              OK
  /qom/resolve/partial:                                                OK
FAIL: tests/check-qom-proplist
/home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:925:
recipe for target 'check-tests
/check-qom-proplist' failed


thanks
-- PMM
