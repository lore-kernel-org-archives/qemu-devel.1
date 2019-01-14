Received: from eggs.gnu.org ([209.51.188.92]:59973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gj1jN-0007OH-0y
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:52:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gj1jL-0000JW-SV
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:52:40 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:38450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gj1jL-0000Ed-DJ
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:52:39 -0500
Received: by mail-ot1-x32b.google.com with SMTP id e12so19180041otl.5
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 04:52:26 -0800 (PST)
MIME-Version: 1.0
References: <1547460140-1473-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1547460140-1473-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Jan 2019 12:52:13 +0000
Message-ID: <CAFEAcA_8P1=jyzMks=bAA-dhEf3JHAVT+5+ZECW_gBpfWZ4YaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/25] ivshmem deprecation, qtests,
 typedefs and gnu99
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Li Qiang <liq3ea@163.com>

On Mon, 14 Jan 2019 at 10:02, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter,
>
> the following changes since commit 27df21ca3886fff4dd3d70e515517667963a52=
f1:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/misc-20190111-pull-re=
quest' into staging (2019-01-11 16:45:59 +0000)
>
> are available in the git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2019-01-14
>
> for you to fetch changes up to 62c36a5f7cad3048bfc41ac24c0593f466b408f4:
>
>   tests/hexloader-test: Don't pass -nographic to the QEMU under test (201=
9-01-14 10:50:40 +0100)
>
> ----------------------------------------------------------------
> - Remove deprecated "ivshmem" legacy device
> - Bug fix for vhost-user-test
> - Use more CONFIG Makefile switches for qtests
> - Get rid of global_qtests in some more qtests
> - typedef cleanups
> - Fixes for compiling with Clang
> - Force C standard to gnu99
> ----------------------------------------------------------------

Compile failure, ppc64 host:

In file included from /home/pm215/qemu/block/iscsi.c:52:0:
/usr/include/iscsi/scsi-lowlevel.h:810:13: error: inline function
=E2=80=98scsi_set_uint16=E2=80=99 declared but never defined [-Werror]
 inline void scsi_set_uint16(unsigned char *c, uint16_t val);
             ^
/usr/include/iscsi/scsi-lowlevel.h:809:13: error: inline function
=E2=80=98scsi_set_uint32=E2=80=99 declared but never defined [-Werror]
 inline void scsi_set_uint32(unsigned char *c, uint32_t val);
             ^
/usr/include/iscsi/scsi-lowlevel.h:808:17: error: inline function
=E2=80=98scsi_get_uint16=E2=80=99 declared but never defined [-Werror]
 inline uint16_t scsi_get_uint16(const unsigned char *c);
                 ^
/usr/include/iscsi/scsi-lowlevel.h:807:17: error: inline function
=E2=80=98scsi_get_uint32=E2=80=99 declared but never defined [-Werror]
 inline uint32_t scsi_get_uint32(const unsigned char *c);
                 ^
/usr/include/iscsi/scsi-lowlevel.h:810:13: error: inline function
=E2=80=98scsi_set_uint16=E2=80=99 declared but never defined [-Werror]
 inline void scsi_set_uint16(unsigned char *c, uint16_t val);
             ^
/usr/include/iscsi/scsi-lowlevel.h:809:13: error: inline function
=E2=80=98scsi_set_uint32=E2=80=99 declared but never defined [-Werror]
 inline void scsi_set_uint32(unsigned char *c, uint32_t val);
             ^
/usr/include/iscsi/scsi-lowlevel.h:808:17: error: inline function
=E2=80=98scsi_get_uint16=E2=80=99 declared but never defined [-Werror]
 inline uint16_t scsi_get_uint16(const unsigned char *c);
                 ^
/usr/include/iscsi/scsi-lowlevel.h:807:17: error: inline function
=E2=80=98scsi_get_uint32=E2=80=99 declared but never defined [-Werror]
 inline uint32_t scsi_get_uint32(const unsigned char *c);
                 ^

thanks
-- PMM
