Received: from eggs.gnu.org ([2001:4830:134:3::10]:35376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1fzjeC-0003Jo-TW
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 10:28:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1fzje8-0007Ih-Qj
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 10:28:08 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:52435)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marex@denx.de>) id 1fzje8-0007G5-Jr
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 10:28:04 -0400
References: <20180911140631.18481-1-alex.bennee@linaro.org>
	<20180911140631.18481-4-alex.bennee@linaro.org>
	<8346c1bb-9cb6-4c08-66a2-b5e5a31903d4@vivier.eu>
From: Marek Vasut <marex@denx.de>
Message-ID: <f28e18ac-b883-e97e-1c0a-599dd154cf60@denx.de>
Date: Tue, 11 Sep 2018 16:27:58 +0200
MIME-Version: 1.0
In-Reply-To: <8346c1bb-9cb6-4c08-66a2-b5e5a31903d4@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 3/4] linux-user/nios2: bump min uname
 to 4.16.0 [!HACK]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: 1791796@bugs.launchpad.net, thuth@redhat.com, Riku Voipio <riku.voipio@iki.fi>, Chris Wulff <crwulff@gmail.com>

On 09/11/2018 04:14 PM, Laurent Vivier wrote:
> Le 11/09/2018 =C3=A0 16:06, Alex Benn=C3=A9e a =C3=A9crit=C2=A0:
>> This is to work around the limitations of the buildroot
>> qemu_nios2_10m50_defconfig which sets the base kernel version for
>> glibc.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  linux-user/nios2/target_syscall.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/linux-user/nios2/target_syscall.h b/linux-user/nios2/targ=
et_syscall.h
>> index ca6b7e69f6..905b80d112 100644
>> --- a/linux-user/nios2/target_syscall.h
>> +++ b/linux-user/nios2/target_syscall.h
>> @@ -2,7 +2,7 @@
>>  #define TARGET_SYSCALL_H
>> =20
>>  #define UNAME_MACHINE "nios2"
>> -#define UNAME_MINIMUM_RELEASE "3.19.0"
>> +#define UNAME_MINIMUM_RELEASE "4.16.0"
>> =20
>>  struct target_pt_regs {
>>      unsigned long  r8;    /* r8-r15 Caller-saved GP registers */
>>
>=20
> I have no objection. Perhaps you could ask NiosII Maintainers (cc).

If that's needed, so be it. The Linux 3.19 was required because some
obscure ABI change happened at that point.

--=20
Best regards,
Marek Vasut
