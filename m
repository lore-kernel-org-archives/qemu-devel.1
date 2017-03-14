Received: from eggs.gnu.org ([2001:4830:134:3::10]:49336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnjS7-00086g-0K
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:13:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnjS5-0001xk-V1
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:13:15 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:37781)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cnjS5-0001xR-NK
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:13:13 -0400
Received: by mail-wm0-x22f.google.com with SMTP id n11so59686759wma.0
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 03:13:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20161228200433.24244-1-cov@codeaurora.org>
References: <20161228145344.30819-1-cov@codeaurora.org>
	<20161228200433.24244-1-cov@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Mar 2017 11:12:51 +0100
Message-ID: <CAFEAcA_k-iCk_-UguBN1WyfQU+oz70dFKaiXQ4yXonF3Wwamrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] build: include sys/sysmacros.h for
 major() and minor()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christopher Covington <cov@codeaurora.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>

On 28 December 2016 at 21:04, Christopher Covington <cov@codeaurora.org> wr=
ote:
> The definition of the major() and minor() macros are moving within glibc =
to
> <sys/sysmacros.h>. Include this header when it is available to avoid the
> following sorts of build-stopping messages:
>
> qga/commands-posix.c: In function =E2=80=98dev_major_minor=E2=80=99:
> qga/commands-posix.c:656:13: error: In the GNU C Library, "major" is defi=
ned
>  by <sys/sysmacros.h>. For historical compatibility, it is
>  currently defined by <sys/types.h> as well, but we plan to
>  remove this soon. To use "major", include <sys/sysmacros.h>
>  directly. If you did not intend to use a system-defined macro
>  "major", you should undefine it after including <sys/types.h>. [-Werror]
>          *devmajor =3D major(st.st_rdev);
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~
>
> qga/commands-posix.c:657:13: error: In the GNU C Library, "minor" is defi=
ned
>  by <sys/sysmacros.h>. For historical compatibility, it is
>  currently defined by <sys/types.h> as well, but we plan to
>  remove this soon. To use "minor", include <sys/sysmacros.h>
>  directly. If you did not intend to use a system-defined macro
>  "minor", you should undefine it after including <sys/types.h>. [-Werror]
>          *devminor =3D minor(st.st_rdev);
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~
>
> The additional include allows the build to complete on Fedora 26 (Rawhide=
)
> with glibc version 2.24.90.
>
> Signed-off-by: Christopher Covington <cov@codeaurora.org>
> ---

Applied to master, thanks.

-- PMM
