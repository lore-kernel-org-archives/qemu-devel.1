Received: from eggs.gnu.org ([209.51.188.92]:54461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2Cjw-0004W7-Um
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:28:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2Cjw-0008Se-9J
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:28:32 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:46475)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h2Cjw-00088p-1C
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:28:32 -0500
Received: by mail-oi1-x231.google.com with SMTP id j10so15448810oij.13
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 02:28:14 -0800 (PST)
MIME-Version: 1.0
References: <20190307152450.20340-1-peter.maydell@linaro.org>
	<CAFEAcA-M7vo-rF=njSjdKiA85-2d4y=8B+otTdzDnuX=1h4Cnw@mail.gmail.com>
	<e655f84b-f033-539f-4c63-87b5e6260ebc@redhat.com>
In-Reply-To: <e655f84b-f033-539f-4c63-87b5e6260ebc@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Mar 2019 10:28:02 +0000
Message-ID: <CAFEAcA8W+q-fCUbi6xp3p-DhSUh1_5sb0RzyYR2tV+sxpDapuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/12] sphinx queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, 8 Mar 2019 at 00:42, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
> I'm getting:
>
> ./configure --enable-tools --enable-doc
> [...]
>   GEN     qga/qapi-generated/qapi-gen
>   GEN     docs/qemu-block-drivers.7
>   GEN     docs/qemu-cpu-models.7
>   SPHINX  docs/devel
>   SPHINX  docs/interop
>   CC      qapi/qapi-visit-core.o
> Error: source directory and destination directory are same.
> Error: source directory and destination directory are same.
> Makefile:880: recipe for target 'docs/interop/index.html' failed
> make: *** [docs/interop/index.html] Error 1
> make: *** Waiting for unfinished jobs....
> Makefile:877: recipe for target 'docs/devel/index.html' failed
> make: *** [docs/devel/index.html] Error 1
> The command "make -j3 && ${TEST_CMD}" exited with 2.

It's probably due to your doing an in-source-tree build
rather than an out-of-tree one :-(

thanks
-- PMM
