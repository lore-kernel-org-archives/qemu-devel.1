Received: from eggs.gnu.org ([209.51.188.92]:57764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hIh6t-0001cQ-17
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 18:08:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hIh6s-0001jn-4Z
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 18:08:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hIh6r-0001jH-Ur
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 18:08:22 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DE20F308FE9A
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 22:08:20 +0000 (UTC)
Date: Mon, 22 Apr 2019 19:08:14 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190422220814.GA25134@habkost.net>
References: <20190422210448.2488-1-ehabkost@redhat.com>
	<20190422210448.2488-2-ehabkost@redhat.com>
	<edbaa0c1-d7ae-11a7-2ada-e3c5f4ca7c8a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <edbaa0c1-d7ae-11a7-2ada-e3c5f4ca7c8a@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] qtest: Move accel code to accel/qtest.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

On Mon, Apr 22, 2019 at 11:56:18PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Hi Eduardo,
>=20
> On 4/22/19 11:04 PM, Eduardo Habkost wrote:
> > QTest has two parts: the server (-qtest) and the accelerator
> > (-machine accel=3Dqtest).  The accelerator depends on CONFIG_POSIX
> > due to its usage of sigwait(), but the server doesn't.
> >=20
> > Move the accel code to accel/qtest.c.  Later we will disable
> > compilation of accel/qtest.c on non-POSIX systems.
> >=20
[...]
> > +#include "qemu/module.h"
>=20
> Why include "qemu/module.h"?
> I guess you don't need it.

That's where the type_init() macro is defined.


> > +type_init(qtest_type_init);
[...]


> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Thanks!

--=20
Eduardo
