Received: from eggs.gnu.org ([209.51.188.92]:41413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gwBBS-00073N-7W
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 14:36:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gwBBK-0003j9-V5
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 14:35:57 -0500
Received: from mail-dm3nam03on0725.outbound.protection.outlook.com
	([2a01:111:f400:fe49::725]:47760
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gwBBF-0003bk-Ng
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 14:35:51 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 19 Feb 2019 19:35:44 +0000
Message-ID: <BN6PR2201MB1251EBFAF8B62C02D7FB734DC67C0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1550600059-5789-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1550600059-5789-3-git-send-email-aleksandar.markovic@rt-rk.com>,
	<CAMo8BfJxnZE=c6Co5UEi=W+ey=JQt4N70KEimr5YEbSQxQb9yg@mail.gmail.com>
In-Reply-To: <CAMo8BfJxnZE=c6Co5UEi=W+ey=JQt4N70KEimr5YEbSQxQb9yg@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 2/9] tests/tcg: target/mips: Correct
 path to headers in some test source files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Aleksandar Rikalo <arikalo@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

Hello, Max!

> From: Max Filippov <jcmvbkbc@gmail.com>
> Subject: Re: [Qemu-devel] [PATCH v2 2/9] tests/tcg: target/mips: Correct =
path to headers in some test source files

> > -#include "../../../include/wrappers_msa.h"
> > -#include "../../../include/test_inputs.h"
> > -#include "../../../include/test_utils.h"
> > +#include "../../../../include/wrappers_msa.h"
> > +#include "../../../../include/test_inputs.h"
> > +#include "../../../../include/test_utils.h"

> Wouldn't it be better to have path to include directory
> somewhere in the CPPFLAGS, outside the test source code?

Eventually these paths will be covered by CPPFLAGS, or similar.
However, the whole directory tests/tcg/mips is undergoing a serious
reorganization, and I have a strong impression that build/makefile
infrastructure would be better off added at the end of that process.
The additional challenge is that all these tests (like any other ones
in tests/tcg) are supposed to be cross-compiled.

That said, all added files are tested via manual build and execution
both on hardware and within QEMU (but the mistake that this patch
fixes slipped thorough the cracks). Large number of tests cases (in
the range of thousands so far) are executed in fairly short amount
of time (matter of seconds).

In any case, thanks!

Aleksandar=
