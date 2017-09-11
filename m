Received: from eggs.gnu.org ([2001:4830:134:3::10]:40249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1drQJB-00055W-Ea
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:07:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1drQJ8-0001ZR-AB
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:07:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1drQJ8-0001ZA-4Q
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:07:30 -0400
Date: Mon, 11 Sep 2017 17:07:26 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170911170726.71c3fcba@nial.brq.redhat.com>
In-Reply-To: <2d12d972-ae16-49e5-1c39-ca43cb0a4bb9@redhat.com>
References: <1504533662-198084-1-git-send-email-imammedo@redhat.com>
	<1504533662-198084-4-git-send-email-imammedo@redhat.com>
	<ee6dfcaa-c2fd-a3f3-a2ea-8fe9cce69099@amsat.org>
	<20170904210649.1266364c@Igors-MacBook-Pro.local>
	<2d12d972-ae16-49e5-1c39-ca43cb0a4bb9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/6] cpu: rename cpu_parse_features() to
 cpu_parse_cpu_model()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, Andrew Jones <drjones@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

On Tue, 5 Sep 2017 07:38:13 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 04.09.2017 21:06, Igor Mammedov wrote:
> > On Mon, 4 Sep 2017 12:03:09 -0300
> > Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
> >  =20
> >> Hi Igor,
> >>
> >> On 09/04/2017 11:00 AM, Igor Mammedov wrote: =20
> >>> function not just parses features but also converts CPU model
> >>> name to CPU type, rename it to reflect what it actualy does. =20
> >>
> >> Why not squash this with your 1st patch "split cpu_generic_init()"? =20
> > there I went with current/exiting way to call that part of code,
> > and here I'm renaming it to show what it does exactly.
> >=20
> > But I don't have any preference here, so I can squash this patch
> > into 1/6 on respin, if you prefer. =20
>=20
> +1 for squashing
ok, will do on respin

>=20
>  Thomas
>=20
>=20
