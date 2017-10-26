Received: from eggs.gnu.org ([2001:4830:134:3::10]:51212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e7hXp-0007UR-TD
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 08:45:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e7hXm-0005wF-BV
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 08:45:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e7hXm-0005vC-63
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 08:45:54 -0400
Date: Thu, 26 Oct 2017 14:45:48 +0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171026124548.GC26955@localhost.localdomain>
References: <20171025093535.10175-1-richard.henderson@linaro.org>
	<20171025093535.10175-21-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171025093535.10175-21-richard.henderson@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 20/51] qom: Introduce CPUClass.tcg_initialize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On Wed, Oct 25, 2017 at 11:35:04AM +0200, Richard Henderson wrote:
> Move target cpu tcg initialization to common code,
> called from cpu_exec_realizefn.
>=20
> Acked-by: Andreas F=E4rber <afaerber@suse.de>
> Reviewed-by: Emilio G. Cota <cota@braap.org>
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

It looks like this broke --disable-tcg:

https://travis-ci.org/qemu/qemu/jobs/292776092

    LINK    x86_64-softmmu/qemu-system-x86_64
  target/i386/cpu.o: In function `x86_cpu_common_class_init':
  /home/travis/build/qemu/qemu/target/i386/cpu.c:4215: undefined referenc=
e to `tcg_x86_init'
  collect2: error: ld returned 1 exit status
  make[1]: *** [qemu-system-x86_64] Error 1
  make: *** [subdir-x86_64-softmmu] Error 2
  The command "make ${MAKEFLAGS} && ${TEST_CMD}" exited with 2.

--=20
Eduardo
