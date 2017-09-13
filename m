Received: from eggs.gnu.org ([2001:4830:134:3::10]:41323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ds2Ol-0001d7-8Z
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:47:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ds2Oh-00041E-Bz
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:47:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ds2Oh-0003z0-6b
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:47:47 -0400
Date: Wed, 13 Sep 2017 09:47:40 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170913094740.64c6ffe1.cohuck@redhat.com>
In-Reply-To: <20170911110623.24981-50-marcandre.lureau@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-50-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 49/50] qapi: make
 query-cpu-model-expansion depend on s390 or x86
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, armbru@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, 11 Sep 2017 13:06:22 +0200
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qapi-schema.json                       | 38 ----------------------------=
-----
>  qapi/target.json                       | 39 ++++++++++++++++++++++++++++=
++++++
>  include/sysemu/arch_init.h             |  3 ---
>  monitor.c                              |  3 ---
>  qmp.c                                  |  7 ------
>  stubs/arch-query-cpu-model-expansion.c | 12 -----------
>  target/i386/cpu.c                      |  3 ++-
>  target/s390x/cpu_models.c              |  2 +-
>  stubs/Makefile.objs                    |  1 -
>  9 files changed, 42 insertions(+), 66 deletions(-)
>  delete mode 100644 stubs/arch-query-cpu-model-expansion.c

Acked-by: Cornelia Huck <cohuck@redhat.com>
