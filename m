Received: from eggs.gnu.org ([2001:4830:134:3::10]:41869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gRHLY-0001sx-3n
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 08:54:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gRHLV-00019x-EK
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 08:54:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gRHLV-00019e-7A
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 08:54:41 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87mw8rumhb.fsf@blackfin.pond.sub.org>
	<87y4s8h5rh.fsf@blackfin.pond.sub.org>
	<876132olyi.fsf@blackfin.pond.sub.org>
	<87a8fucx33.fsf@dusky.pond.sub.org>
	<87muq2fgbw.fsf@dusky.pond.sub.org>
	<a7902403-7572-9b64-235e-cb6f9e0efbae@redhat.com>
Date: Mon, 26 Nov 2018 14:54:32 +0100
In-Reply-To: <a7902403-7572-9b64-235e-cb6f9e0efbae@redhat.com> (Thomas Huth's
	message of "Thu, 22 Nov 2018 13:22:11 +0100")
Message-ID: <87mupwlzaf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] MAINTAINERS leaves too many files uncovered
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Peter Crosthwaite <crosthwaitepeter@gmail.com>, Igor Mammedov <imammedo@redhat.com>, =?utf-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>

Thomas Huth <thuth@redhat.com> writes:

> On 2018-11-21 19:14, Markus Armbruster wrote:
>> Time for another update.  My HEAD is at v3.1.0-rc2.
>
> Thanks a lot for this, Markus, very appreciated!
>
> [...]
>> Unmaintained files sorted by number of commits in the past year
>> (v2.11.0-rc2):
>>=20
>> $ for i in `cat unmaintained-files`; do echo -n "$i "; git-rev-list v2.1=
1.0-rc2.. $i | wc -l; done | awk '{ printf "%7d %s\n", $2, $1 }' | sort -rn=
 | head -n 100
>>     139 MAINTAINERS
>>     138 configure
>>     108 tests/Makefile.include
>>      87 qemu-options.hx
>
> I still think we'd need someone to look after qemu-options.hx, since
> these are public interfaces...

QAPIfication to the rescue...

[...]
>> qdev needs a maintainer.  It has needed one since forever.
>
> Definitely. But who could do that job?

I'm afraid most (all?) candidates that have the experience lack the
bandwidth.  I certainly do.  Let's ask git:

    $ scripts/get_maintainer.pl -f hw/core/qdev.c
    get_maintainer.pl: No maintainers found, printing recent contributors.
    get_maintainer.pl: Do not blindly cc: them on patches!  Use common sens=
e.

    Markus Armbruster <armbru@redhat.com> (commit_signer:8/14=3D57%)
    "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org> (commit_signer:6/14=3D4=
3%)
    Paolo Bonzini <pbonzini@redhat.com> (commit_signer:5/14=3D36%)
    Eric Blake <eblake@redhat.com> (commit_signer:4/14=3D29%)
    Laurent Vivier <laurent@vivier.eu> (commit_signer:2/14=3D14%)
    qemu-devel@nongnu.org (open list:All patches CC here)
    $ scripts/get_maintainer.pl -f --git-blame hw/core/qdev.c
    Anthony Liguori <anthony@codemonkey.ws> (authored lines:170/1114=3D15%,=
commits:49/158=3D31%)
    Peter Crosthwaite <peter.crosthwaite@xilinx.com> (authored lines:149/11=
14=3D13%)
    Paolo Bonzini <pbonzini@redhat.com> (authored lines:112/1114=3D10%,comm=
its:49/158=3D31%)
    Igor Mammedov <imammedo@redhat.com> (authored lines:72/1114=3D6%)
    Paul Brook <paul@codesourcery.com> (authored lines:65/1114=3D6%)
    "Andreas F=C3=A4rber" <afaerber@suse.de> (commits:50/158=3D32%)
    Markus Armbruster <armbru@redhat.com> (commits:27/158=3D17%)
    "Michael S. Tsirkin" <mst@redhat.com> (commits:27/158=3D17%)
    qemu-devel@nongnu.org (open list:All patches CC here)

Any takers?
