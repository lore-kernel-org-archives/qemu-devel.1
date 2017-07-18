Received: from eggs.gnu.org ([2001:4830:134:3::10]:35384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dXTdR-0001lk-FR
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:38:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dXTdQ-0004Hf-NU
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:38:01 -0400
References: <20170718061005.29518-1-f4bug@amsat.org>
	<20170718061005.29518-17-f4bug@amsat.org>
	<501136f163a5ab92df3d839360483774@walle.cc>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f8dcb381-0935-bf7a-55a7-79d24f51e1dc@redhat.com>
Date: Tue, 18 Jul 2017 16:37:57 +0200
MIME-Version: 1.0
In-Reply-To: <501136f163a5ab92df3d839360483774@walle.cc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 16/29] lm32: use QEMU_IS_ALIGNED macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Walle <michael@walle.cc>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: qemu-trivial@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philippe.mathieu.daude@gmail.com>, qemu-devel@nongnu.org

On 18.07.2017 13:42, Michael Walle wrote:
> Am 2017-07-18 08:09, schrieb Philippe Mathieu-Daud=C3=A9:
>> Applied using the Coccinelle semantic patch
>> scripts/coccinelle/use_osdep.cocci
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
> QEMU_IS_ALIGNED() sounds like it is used to check if a memory access is
> aligned. Although it does the same, the line in question is used for
> formatted output. I'm not sure if this macro should be used here.

+1

I think we should not replace every usage of % blindly. It does really
look wrong in this case here.

 Thomas
