Received: from eggs.gnu.org ([209.51.188.92]:44648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggojC-0007em-8S
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 05:35:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggojB-0005mB-GB
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 05:35:22 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:33151)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggoj8-0005VK-HS
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 05:35:20 -0500
Received: by mail-ot1-x32b.google.com with SMTP id i20so3089702otl.0
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 02:35:15 -0800 (PST)
MIME-Version: 1.0
References: <20190107223147.14269-1-pbonzini@redhat.com>
In-Reply-To: <20190107223147.14269-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Jan 2019 10:35:03 +0000
Message-ID: <CAFEAcA-kd=zuASx3k1QW5qveU9sLNSaaL45gj-EvDJwqtOVQMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v4 00/35] Misc patches for 2018-12-18
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

On Mon, 7 Jan 2019 at 22:35, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 9b2e891ec5ccdb4a7d583b77988848282606fd=
ea:
>
>   Merge remote-tracking branch 'remotes/marcel/tags/rdma-pull-request' in=
to staging (2018-12-22 11:25:31 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to a486bd29567a23a454e248aed1d8c28b90a6ea3e:
>
>   avoid TABs in files that only contain a few (2019-01-04 20:59:49 +0100)
>
> ----------------------------------------------------------------
> * HAX support for Linux hosts (Alejandro)
> * esp bugfixes (Guenter)
> * Windows build cleanup (Marc-Andr=C3=A9)
> * checkpatch logic improvements (Paolo)
> * coalesced range bugfix (Paolo)
> * switch testsuite to TAP (Paolo, with Peter's fix to hexloader-test)
> * QTAILQ rewrite (Paolo)
> * block/iscsi.c cancellation fixes (Stefan)
> * improve selection of the default accelerator (Thomas)
>

Hi. I fixed up a couple of textual conflicts but there
seems to be a semantic conflict with the TCG pull:

/var/tmp/qemu-test.PYf8dT/tcg/tcg.c:2322:65: error: too many arguments
provided to function-like macro i
nvocation
                    TCGOp *op_prev =3D QTAILQ_PREV(op, TCGOpHead, link);
                                                                ^
/var/tmp/qemu-test.PYf8dT/include/qemu/queue.h:457:9: note: macro
'QTAILQ_PREV' defined here
#define QTAILQ_PREV(elm, field)                                         \
        ^
/var/tmp/qemu-test.PYf8dT/tcg/tcg.c:2322:38: error: use of undeclared
identifier 'QTAILQ_PREV'
                    TCGOp *op_prev =3D QTAILQ_PREV(op, TCGOpHead, link);
                                     ^
2 errors generated.

Can you fix up and resend, please?

thanks
-- PMM
