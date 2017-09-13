Received: from eggs.gnu.org ([2001:4830:134:3::10]:42247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ds2Q5-0002qk-Gg
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:49:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ds2Q4-0005hC-MU
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:49:13 -0400
Date: Wed, 13 Sep 2017 09:48:59 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170913094859.55905d00.cohuck@redhat.com>
In-Reply-To: <20170911110623.24981-51-marcandre.lureau@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-51-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 50/50] qapi: make query-cpu-definitions
 depend on specific targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, armbru@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Alexander Graf <agraf@suse.de>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Mon, 11 Sep 2017 13:06:23 +0200
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> It depends on TARGET_PPC || TARGET_ARM || TARGET_I386 || TARGET_S390X.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qapi-schema.json            | 11 -----------
>  qapi/target.json            | 12 ++++++++++++
>  include/sysemu/arch_init.h  |  1 -
>  monitor.c                   | 22 ----------------------
>  qmp.c                       |  5 -----
>  stubs/arch-query-cpu-def.c  | 10 ----------
>  target/arm/helper.c         |  3 ++-
>  target/i386/cpu.c           |  2 +-
>  target/ppc/translate_init.c |  3 ++-
>  target/s390x/cpu_models.c   |  2 +-
>  stubs/Makefile.objs         |  1 -
>  11 files changed, 18 insertions(+), 54 deletions(-)
>  delete mode 100644 stubs/arch-query-cpu-def.c

Acked-by: Cornelia Huck <cohuck@redhat.com>
