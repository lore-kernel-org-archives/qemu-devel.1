Received: from eggs.gnu.org ([2001:4830:134:3::10]:39912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ds2Ma-0008OD-S1
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ds2MX-0000aQ-Ur
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:45:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ds2MX-0000ZH-PW
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:45:33 -0400
Date: Wed, 13 Sep 2017 09:45:26 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170913094526.5db22522.cohuck@redhat.com>
In-Reply-To: <20170911110623.24981-47-marcandre.lureau@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-47-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 46/50] qapi: make s390 commands depend
 on TARGET_S390X
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 11 Sep 2017 13:06:19 +0200
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qapi-schema.json                        | 101 --------------------------=
-----
>  qapi/target.json                        | 104 ++++++++++++++++++++++++++=
++++++
>  include/sysemu/arch_init.h              |   7 ---
>  hw/s390x/s390-skeys.c                   |   2 +-
>  monitor.c                               |  14 -----
>  qmp.c                                   |  14 -----
>  stubs/arch-query-cpu-model-baseline.c   |  12 ----
>  stubs/arch-query-cpu-model-comparison.c |  12 ----
>  target/s390x/cpu_models.c               |   5 +-
>  stubs/Makefile.objs                     |   2 -
>  10 files changed, 108 insertions(+), 165 deletions(-)
>  delete mode 100644 stubs/arch-query-cpu-model-baseline.c
>  delete mode 100644 stubs/arch-query-cpu-model-comparison.c

Together with the next patch (which makes clear that the cpu model
functions are not s390x-specific, but currently only implemented there):

Acked-by: Cornelia Huck <cohuck@redhat.com>
