Received: from eggs.gnu.org ([2001:4830:134:3::10]:40191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fbZ7M-00074u-V0
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 18:22:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fbZ7J-0006m8-QQ
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 18:22:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34996 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fbZ7J-0006lQ-Ls
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 18:22:17 -0400
References: <20180702151023.24532-1-shorne@gmail.com>
	<20180702151023.24532-23-shorne@gmail.com>
	<feef2195-8fd8-f9e1-da85-f3286a9e2b1d@amsat.org>
	<CAAfxs77LqYG2gGT3Y0xs=SYMdQ9GoO0hymdwF-UGZcjXyrQUMg@mail.gmail.com>
	<43d6bc18-440a-31e9-f055-8d0b14cbc74e@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b31d8ace-fb05-0748-ba21-9daf97350af6@redhat.com>
Date: Fri, 6 Jul 2018 17:22:15 -0500
MIME-Version: 1.0
In-Reply-To: <43d6bc18-440a-31e9-f055-8d0b14cbc74e@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 22/25] linux-user: Implement signals for
 openrisc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Stafford Horne <shorne@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, qemu-devel qemu-devel <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

On 07/04/2018 03:54 PM, Richard Henderson wrote:
> On 07/03/2018 04:51 PM, Stafford Horne wrote:
>> Richard, how do you usually remove these before your pr?=C2=A0 I suppo=
se you have
>> some kind of script?
>=20
> No, I just edit the things by hand.

I do it by always using 'git am' to suck in patches from the mailing=20
list, including my own patches, and even if I already have the patch=20
locally.  That is, my workflow for PR bypasses my local work tree to=20
ensure I don't leave local artifacts around in the PR.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
