Received: from eggs.gnu.org ([2001:4830:134:3::10]:38440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1eYudp-0004Ac-JL
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:12:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1eYudo-0000pP-KR
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:12:37 -0500
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:48932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1eYudo-0000lt-DX
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:12:36 -0500
Date: Tue, 9 Jan 2018 15:12:24 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20180109141224.axcsed4o2fbgmqhc@aurel32.net>
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-3-alex.bennee@linaro.org>
	<034ef359-05f9-41e3-61b6-8b351ac9d452@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <034ef359-05f9-41e3-61b6-8b351ac9d452@vivier.eu>
Sender: Aurelien Jarno <aurelien@aurel32.net>
Subject: Re: [Qemu-devel] [PATCH v2 02/20] include/fpu/softfloat: remove
 USE_SOFTFLOAT_STRUCT_TYPES
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Alex =?iso-8859-15?Q?Benn=E9e?= <alex.bennee@linaro.org>, richard.henderson@linaro.org, peter.maydell@linaro.org, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com, qemu-devel@nongnu.org

On 2018-01-09 13:27, Laurent Vivier wrote:
> Le 09/01/2018 =E0 13:22, Alex Benn=E9e a =E9crit=A0:
> > It's not actively built and when enabled things fail to compile. I'm
> > not sure the type-checking is really helping here. Seeing as we "own"
> > our softfloat now lets remove the cruft.
>=20
> I think it would be better to fix the build break than to remove the
> type-checking tool.
>=20
> but that's only my opinion...

I agree with that. Those checks are useful for targets which call host
floating point functions for some instructions. This is ugly, but that's
what is still done for at least x86 for the trigonometrical functions.
The check prevents assigning a float or double value to a softfloat type
without calling the conversion function.

Now, when we make sure that those ugly things are removed, I think these
type-checking might be removed.

Aurelien

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
