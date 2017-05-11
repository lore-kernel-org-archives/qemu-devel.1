Received: from eggs.gnu.org ([2001:4830:134:3::10]:53071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d8jjd-0007mR-1S
	for qemu-devel@nongnu.org; Thu, 11 May 2017 04:46:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d8jjZ-0005lw-64
	for qemu-devel@nongnu.org; Thu, 11 May 2017 04:46:09 -0400
References: <20170510200535.13268-1-f4bug@amsat.org>
	<20170510200535.13268-8-f4bug@amsat.org>
	<20170511004159.GD14408@umbus.fritz.box>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <5386fd20-8d13-408a-5b12-ba9468541e50@redhat.com>
Date: Thu, 11 May 2017 10:46:01 +0200
MIME-Version: 1.0
In-Reply-To: <20170511004159.GD14408@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 7/8] target/ppc: optimize
 various functions using extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On 11/05/2017 02:41, David Gibson wrote:
> On Wed, May 10, 2017 at 05:05:34PM -0300, Philippe Mathieu-Daud=C3=A9 w=
rote:
>> Applied using Coccinelle script.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

David, look at Nikunj's comments: only the two first changes are correct.

'andi" uses a mask, but extract uses a 'width'. Philippe's changes work
only when mask =3D 1.

Thanks,
Laurent
