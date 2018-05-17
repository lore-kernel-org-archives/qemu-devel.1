Received: from eggs.gnu.org ([2001:4830:134:3::10]:46293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJKl2-00067i-GH
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:23:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJKl1-0008EA-Ja
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:23:56 -0400
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:36459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fJKl1-0008E0-Dt
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:23:55 -0400
Received: by mail-ot0-x22a.google.com with SMTP id m11-v6so5491646otf.3
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 08:23:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87y3gkdlab.fsf@linaro.org>
References: <1524153386-3550-1-git-send-email-abdallah.bouassida@lauterbach.com>
	<87lgcrvemu.fsf@linaro.org>
	<CAFEAcA_3Rg-qhLRmg=TtakVtzOffKrdOKU8z=-=cGts4TTC2+A@mail.gmail.com>
	<87y3gkdlab.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 May 2018 16:23:34 +0100
Message-ID: <CAFEAcA8tcspnmGBOOF8zYX22dPRrD_HZ2z+Ot2CSqUo2RdKp1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 0/3] target/arm: Add a dynamic
 XML-description of the cp-registers to GDB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Khaled Jmal <khaled.jmal@lauterbach.com>

On 16 May 2018 at 10:03, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>> CNTVCT_EL0 isn't in the set of registers we expose to gdb (it's
>> marked up as ARM_CP_NO_RAW), so I'm not sure why gdb is
>> giving you any value at all. Does it do that for any
>> random $no_such_thing strings ?
>
> *sigh* yes....

My gdb ("GNU gdb (Ubuntu 7.11.1-0ubuntu1~16.5) 7.11.1") gives
(gdb) p/x $cntvct_el0
$3 =3D Value can't be converted to integer.
or if you don't ask for the hex conversion:
(gdb) print $cntvct_el0
$2 =3D void

so this is either something fixed in a newer gdb than you
have, or alternately it's a regression if you're using a
newer gdb, which you should probably report upstream...

> So finally:
>
> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Thanks for the testing.

Abdallah: I've added this series to my target-arm.next queue,
so it should reach QEMU master some time next week. Thanks for
your efforts in working through QEMU's review process, and
sorry this took us so long to deal with.

-- PMM
