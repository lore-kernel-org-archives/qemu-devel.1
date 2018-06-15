Received: from eggs.gnu.org ([2001:4830:134:3::10]:43784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tamiko@43-1.org>) id 1fToeh-0006RV-Ap
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 09:20:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tamiko@43-1.org>) id 1fToeg-0005Zl-CB
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 09:20:43 -0400
Received: from tsukuyomi.43-1.org ([2a01:4f8:173:743::1:50]:54655)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tamiko@43-1.org>) id 1fToeg-0005Y4-4I
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 09:20:42 -0400
From: Matthias Maier <tamiko@43-1.org>
In-Reply-To: <20180615094207.GK31552@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
	=?utf-8?Q?rang=C3=A9=22's?=
	message of "Fri, 15 Jun 2018 10:42:07 +0100")
References: <20180615044042.7928-1-tamiko@43-1.org>
	<20180615044042.7928-2-tamiko@43-1.org>
	<20180615094207.GK31552@redhat.com>
Date: Fri, 15 Jun 2018 08:20:36 -0500
Message-ID: <8736xorxsr.fsf@43-1.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] Partially revert commit d4e5ec877ca
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Arfrever Frehtes Taifersar Arahesis <arfrever.fta@gmail.com>


On Fri, Jun 15, 2018, at 04:42 CDT, Daniel P. Berrang=C3=A9 <berrange@red=
hat.com> wrote:

> On Thu, Jun 14, 2018 at 11:40:41PM -0500, Matthias Maier wrote:
>> This commit removes the PYTHON_UTF8 workaround. The problem with setti=
ng
>>=20
>>   LC_ALL=3D LANG=3DC LC_CTYPE=3Den_US.UTF-8
>>=20
>> is that the en_US.UTF-8 locale might not be available. In this case
>
> What platform are you using where  UTF8 locale is not available ?

For example, neither Debian (and for that matter Ubuntu) nor Gentoo
guarantee that the en_US.UTF-8 locale is available.

We in particular encounter build problems on Gentoo when users have only
set very specific, non en_US locales, for example de_DE.UTF-8 (or
similar).

> Indeed I would ideally like to make the entire of QEMU build with an
> explicit en_US.UTF-8 or C.UTF-8 locale, to ensure that we get reliably
> reproducible builds, as locale differences have been known to impact
> output of many tools not just python.

We face the same problem in Gentoo and usually advice users to set
LC_ALL=3DC when submitting bug reports. (It is frustrating that glibc
upstream doesn't get their act together fixing and merging the current
C.UTF-8 proposal.)

So what about making the build system more robust (by merging the
patches, or a variant) and either setting C.UTF-8, or C globally
(depending on availability)?

Best,
Matthias
