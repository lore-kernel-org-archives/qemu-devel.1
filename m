Received: from eggs.gnu.org ([2001:4830:134:3::10]:52002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dZshv-0002sB-Dk
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 01:48:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dZshs-0007Sz-9n
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 01:48:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6217)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dZshs-0007Sm-41
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 01:48:32 -0400
References: <504798a0-0ac3-bfab-a451-2eb0cfca43ff@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <66ff3f38-b62b-ca59-e155-d9e4f67693aa@redhat.com>
Date: Tue, 25 Jul 2017 07:48:26 +0200
MIME-Version: 1.0
In-Reply-To: <504798a0-0ac3-bfab-a451-2eb0cfca43ff@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] MAINTAINERS: surprising get_maintainer.pl output
 for ./configure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: Kamil Rytarowski <kamil@netbsd.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On 25.07.2017 00:40, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi perl gurus :)
>=20
> after changing the ./configure I wanted to figure to whom email and got
> this:
>=20
> $ ./scripts/get_maintainer.pl -f configure
> Kamil Rytarowski <kamil@netbsd.org> (maintainer:NETBSD)
> qemu-devel@nongnu.org (open list:All patches CC here)
>=20
> $ fgrep -A5 NETBSD MAINTAINERS
> NETBSD
> L: qemu-devel@nongnu.org
> M: Kamil Rytarowski <kamil@netbsd.org>
> S: Maintained
> K: (?i)NetBSD
>=20
> Descriptions of section entries:
>=20
>   K: Keyword perl extended regex pattern to match
>      content in a patch or file.
>=20
> $ fgrep -inA1 NetBSD configure
> 547:elif check_define __NetBSD__; then
> 548:  targetos=3D'NetBSD'
> --=20
> 709:NetBSD)
> 710-  bsd=3D"yes"
> --=20
> 715:  HOST_VARIANT_DIR=3D"netbsd"
> 716-  supported_os=3D"yes"
>=20
> since ./configure check for NetBSD host/target, the string appears in
> the ./configure and the K regex is matched...
>=20
> I tried to add a 'F: configure' in NETBSD entry but it doesn't change.
> The easier is to kill the K entry :)

But without the K: entry there is no more pattern for this entry at all
anymore - since there are also no F: entries here.

I'd suggest to do it the same way as the "Trivial patches" entry:

K: ^Subject:.*(?i)NetBSD

... then it should hopefully only trigger on patch titles.

Philippe, Kamil, if one of you has got some spare minutes, could you
please send a patch?

 Thomas
