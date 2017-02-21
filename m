Received: from eggs.gnu.org ([2001:4830:134:3::10]:60992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cg6qk-0007nx-3C
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:35:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cg6qj-0005VO-5z
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:35:10 -0500
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:34182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cg6qj-0005TY-05
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:35:09 -0500
Received: by mail-wr0-x229.google.com with SMTP id z61so78153403wrc.1
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 01:35:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487622662-62984-1-git-send-email-yongbok.kim@imgtec.com>
References: <1487622662-62984-1-git-send-email-yongbok.kim@imgtec.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Feb 2017 09:34:47 +0000
Message-ID: <CAFEAcA_3TOxU4r3Pg38LR3FnpAGXHKxF_UZQFCGxU7T5+1GwHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/8] target-mips queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20 February 2017 at 20:30, Yongbok Kim <yongbok.kim@imgtec.com> wrote:
> Hi,
>
> This is pull-req for target-mips.
>
> Regards,
> Yongbok
>
> The following changes since commit 56f9e46b841c7be478ca038d8d4085d776ab4b=
0d:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-02-20'=
 into staging (2017-02-20 17:42:47 +0000)
>
> are available in the git repository at:
>
>   git://github.com/yongbok/upstream-qemu.git tags/mips-20170220
>
> for you to fetch changes up to 0a1fdcc94338ea12f7deba71e795c01989152752:
>
>   hw/mips: MIPS Boston board support (2017-02-20 19:37:28 +0000)
>
> ----------------------------------------------------------------
> MIPS patches 2017-02-20
>
> Changes:
> * Add MIPS Boston board support

Hi. This fails to build (all platforms):

/home/petmay01/linaro/qemu-for-merges/hw/core/loader-fit.c: In
function =E2=80=98load_fit=E2=80=99:
/home/petmay01/linaro/qemu-for-merges/hw/core/loader-fit.c:215:8:
error: =E2=80=98load_data=E2=80=99 may be used uninitialized in this functi=
on
[-Werror=3Dmaybe-uninitialized]
     if (data !=3D load_data) {
        ^
/home/petmay01/linaro/qemu-for-merges/hw/core/loader-fit.c:179:17:
note: =E2=80=98load_data=E2=80=99 was declared here
     const void *load_data;
                 ^
/home/petmay01/linaro/qemu-for-merges/hw/core/loader-fit.c:168:9:
error: =E2=80=98load_data=E2=80=99 may be used uninitialized in this functi=
on
[-Werror=3Dmaybe-uninitialized]
         g_free((void *) load_data);
         ^
/home/petmay01/linaro/qemu-for-merges/hw/core/loader-fit.c:121:17:
note: =E2=80=98load_data=E2=80=99 was declared here
     const void *load_data;
                 ^
cc1: all warnings being treated as errors

thanks
-- PMM
