Received: from eggs.gnu.org ([2001:4830:134:3::10]:58816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dkE87-0001EG-R4
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 14:42:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dkE84-0003GA-HA
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 14:42:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dkE84-0003FP-AT
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 14:42:20 -0400
Date: Tue, 22 Aug 2017 15:42:13 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170822184213.GH19998@localhost.localdomain>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-54-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170822132255.23945-54-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 53/54] qapi: make
 query-cpu-model-expansion depend on s390 or x86
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On Tue, Aug 22, 2017 at 03:22:54PM +0200, Marc-Andr=E9 Lureau wrote:
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qapi-schema.json                       |  4 +++-
>  include/sysemu/arch_init.h             |  3 ---
>  monitor.c                              |  3 ---
>  qmp.c                                  |  7 -------
>  stubs/arch-query-cpu-model-expansion.c | 12 ------------
>  target/i386/cpu.c                      |  2 +-
>  target/s390x/cpu_models.c              |  3 ++-
>  stubs/Makefile.objs                    |  1 -
>  8 files changed, 6 insertions(+), 29 deletions(-)
>  delete mode 100644 stubs/arch-query-cpu-model-expansion.c
>=20
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 6c1adb35b5..127a2c71c6 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -4535,7 +4535,9 @@
>  { 'command': 'query-cpu-model-expansion',
>    'data': { 'type': 'CpuModelExpansionType',
>              'model': 'CpuModelInfo' },
> -  'returns': 'CpuModelExpansionInfo' }
> +  'returns': 'CpuModelExpansionInfo',
> +  'if': ['defined(NEED_CPU_H)',
> +         'defined(TARGET_S390X) || defined(TARGET_I386)']}

Maybe this is already documented somewhere in the series (I'm
still going through the other patches), but: why exactly is
'defined(NEED_CPU_H)' in the list, too?

I always assumed that all the QAPI and QMP dispatching code would
be compiled only once, and never be compiled with -DNEED_CPU_H
defined.

--=20
Eduardo
