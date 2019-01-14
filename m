Received: from eggs.gnu.org ([209.51.188.92]:33297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gj1p5-0001UW-LF
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:58:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gj1p1-0003CH-Gh
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:58:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gj1oz-0003AZ-GT
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:58:30 -0500
References: <1547460140-1473-1-git-send-email-thuth@redhat.com>
	<CAFEAcA_8P1=jyzMks=bAA-dhEf3JHAVT+5+ZECW_gBpfWZ4YaA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3a3aaedc-c1f7-6fd4-7998-cf65e76f115e@redhat.com>
Date: Mon, 14 Jan 2019 13:58:23 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_8P1=jyzMks=bAA-dhEf3JHAVT+5+ZECW_gBpfWZ4YaA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Li Qiang <liq3ea@163.com>

On 2019-01-14 13:52, Peter Maydell wrote:
> On Mon, 14 Jan 2019 at 10:02, Thomas Huth <thuth@redhat.com> wrote:
>>
>>  Hi Peter,
>>
>> the following changes since commit 27df21ca3886fff4dd3d70e515517667963=
a52f1:
>>
>>   Merge remote-tracking branch 'remotes/kraxel/tags/misc-20190111-pull=
-request' into staging (2019-01-11 16:45:59 +0000)
>>
>> are available in the git repository at:
>>
>>   https://gitlab.com/huth/qemu.git tags/pull-request-2019-01-14
>>
>> for you to fetch changes up to 62c36a5f7cad3048bfc41ac24c0593f466b408f=
4:
>>
>>   tests/hexloader-test: Don't pass -nographic to the QEMU under test (=
2019-01-14 10:50:40 +0100)
>>
>> ----------------------------------------------------------------
>> - Remove deprecated "ivshmem" legacy device
>> - Bug fix for vhost-user-test
>> - Use more CONFIG Makefile switches for qtests
>> - Get rid of global_qtests in some more qtests
>> - typedef cleanups
>> - Fixes for compiling with Clang
>> - Force C standard to gnu99
>> ----------------------------------------------------------------
>=20
> Compile failure, ppc64 host:
>=20
> In file included from /home/pm215/qemu/block/iscsi.c:52:0:
> /usr/include/iscsi/scsi-lowlevel.h:810:13: error: inline function
> =E2=80=98scsi_set_uint16=E2=80=99 declared but never defined [-Werror]
>  inline void scsi_set_uint16(unsigned char *c, uint16_t val);
>              ^

What the .... in a system header?? That's not fair... sigh, let me think
of a work-around...

 Thomas
