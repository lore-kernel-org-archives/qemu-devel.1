Received: from eggs.gnu.org ([209.51.188.92]:35509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h1WeZ-0005Z5-Sx
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:32:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h1WeZ-00077I-3U
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:32:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1h1WeY-00076k-To
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:32:11 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 39D51307E042
	for <qemu-devel@nongnu.org>; Wed,  6 Mar 2019 13:32:10 +0000 (UTC)
References: <32ad1a44-5398-53de-9adf-9e6ac9f60805@redhat.com>
	<20190306124419.GG20806@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <686b400b-42ed-d877-50c6-f7be43cc7a63@redhat.com>
Date: Wed, 6 Mar 2019 14:31:58 +0100
MIME-Version: 1.0
In-Reply-To: <20190306124419.GG20806@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] recursive submodules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 03/06/19 13:44, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Mar 06, 2019 at 01:30:06PM +0100, Laszlo Ersek wrote:
>> Hi,
>>
>> in order to build any OVMF platform firmware image from the submodule =
at
>> "roms/edk2", the (recursive) OpenSSL submodule at
>> "roms/edk2/CryptoPkg/Library/OpensslLib/openssl" needs to be initializ=
ed
>> as well.
>>
>> Am I right to think this would be the first recursive submodule in QEM=
U?
>> How should I approach this? (I see we have a related script at
>> "scripts/git-submodule.sh".)
>=20
> The scripts/git-submodule.sh file is called automatically by "make"
> in QEMU to activate any submodules that are required during the normal
> build a QEMU developer does.
>=20
> The ROM submodules are special though. AFAIK, these are never built as =
a
> side effect of the QEMU build process, so never need to be initialized =
by
> the git-submodule.sh script.  Developers always just use the pre-built
> ROM files bundled in QEMU. The only people checking out the ROM submodu=
les
> are the maintainers who periodically build a new binary ROM.
>=20
> So in this sense the fact that EDK has submodules shouldn't be a factor=
,
> as we would not expect EDK to be built by regular QEMU developers

Thank you for the explanation. I missed that the "configure" script
manipulated the "git_submodules" variable explicitly. (Which seems to be
the origin for GIT_SUBMODULES.) It covers only a subset of ".gitmodules".

Thanks!
Laszlo
