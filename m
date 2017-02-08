Received: from eggs.gnu.org ([2001:4830:134:3::10]:35869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cbTpa-0005Bi-33
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 10:06:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cbTpW-00019r-VN
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 10:06:50 -0500
Received: from greensocs.com ([193.104.36.180]:41091)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cbTpW-00019l-Kv
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 10:06:46 -0500
References: <1876928241.4705653.1486475589080.ref@mail.yahoo.com>
	<1876928241.4705653.1486475589080@mail.yahoo.com>
From: Frederic Konrad <fred.konrad@greensocs.com>
Message-ID: <900df216-b5ca-3997-7c6b-7047af0da003@greensocs.com>
Date: Wed, 8 Feb 2017 16:06:41 +0100
MIME-Version: 1.0
In-Reply-To: <1876928241.4705653.1486475589080@mail.yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] question about binary translation on qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: oussema ben khedher <oussemakeder@yahoo.fr>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 02/07/2017 02:53 PM, oussema ben khedher wrote:
> hi=20
> in my academic project i needed to know how qemu exactly translate an a=
rm instruction to the host assembly (in my case x86) so if you can help m=
e to know the function in the source code of qemu that tdo this work=20
> thank you
>=20

Hi,

There is a lot of code involved in the whole translation:
The guest instructions are not directly translated to the host
assembly but they are first translated in some intermediate OPs
(named TCG).

This translation takes place here:
void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
In target/arm/translate.c

Fred
