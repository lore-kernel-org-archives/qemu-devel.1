Received: from eggs.gnu.org ([2001:4830:134:3::10]:49759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cr866-0002ES-Nv
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 15:08:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cr865-0001oj-Ve
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 15:08:34 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:38444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cr865-0001oa-Os
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 15:08:33 -0400
Received: by mail-wm0-x22e.google.com with SMTP id t189so4428531wmt.1
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 12:08:33 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Mar 2017 19:08:11 +0000
Message-ID: <CAFEAcA-ej2CMRBHoOG4gO34wgP01Q==O8jtEDMnNjOJZrs6ncg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] compile failure if I enable guest_mem_before trace
 event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>

Hi; I thought I'd have a look at the guest_mem_before trace event,
but if I enable it (by deleting "disable" from the line in trace-events)
QEMU doesn't compile:

  CC      arm-softmmu/tcg/tcg-op.o
In file included from
/home/petmay01/linaro/qemu-from-laptop/qemu/include/trace-tcg.h:4:0,
                 from
/home/petmay01/linaro/qemu-from-laptop/qemu/tcg/tcg-op.c:31:
../trace/generated-tcg-tracers.h: In function =E2=80=98trace_guest_mem_befo=
re_tcg=E2=80=99:
../trace/generated-tcg-tracers.h:11:5: error: implicit declaration of
function =E2=80=98trace_guest_mem_before_trans=E2=80=99
[-Werror=3Dimplicit-function-declaration]
     trace_guest_mem_before_trans(__cpu, info);
     ^
../trace/generated-tcg-tracers.h:11:5: error: nested extern
declaration of =E2=80=98trace_guest_mem_before_trans=E2=80=99 [-Werror=3Dne=
sted-externs]

Am I doing something wrong, or is this a bug?

thanks
-- PMM
