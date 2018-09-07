Received: from eggs.gnu.org ([2001:4830:134:3::10]:35373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fyC1t-0001OG-E6
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 04:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fyC1o-0003CX-EE
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 04:22:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45762 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fyC1o-00038x-7n
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 04:22:08 -0400
References: <20180907075948.26917-1-marcandre.lureau@redhat.com>
	<20180907075948.26917-2-marcandre.lureau@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0b0ef581-6cc4-d036-28f1-dfdbd4c36939@redhat.com>
Date: Fri, 7 Sep 2018 10:22:03 +0200
MIME-Version: 1.0
In-Reply-To: <20180907075948.26917-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/12] qdev-monitor: print help to stdout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

On 2018-09-07 09:59, Marc-Andr=C3=A9 Lureau wrote:
> qdev_device_help() is used from command line "-device help", or from
> HMP "device_add". If used from command line, print help to stdout
> (it is only printed on explicit demand).

Good idea, it always bugged me that "-device help" behaves differently
than "-help"!

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/monitor/monitor.h |  2 ++
>  monitor.c                 | 16 +++++++++++++---
>  qdev-monitor.c            | 32 +++++++++++++++++++-------------
>  3 files changed, 34 insertions(+), 16 deletions(-)
>=20
> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> index 2ef5e04b37..e7667fda35 100644
> --- a/include/monitor/monitor.h
> +++ b/include/monitor/monitor.h
> @@ -47,4 +47,6 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int du=
p_fd);
>  void monitor_fdset_dup_fd_remove(int dup_fd);
>  int monitor_fdset_dup_fd_find(int dup_fd);
> =20
> +void out_vprintf(FILE *stream, const char *fmt, va_list ap) GCC_FMT_AT=
TR(2, 0);

The name is a little bit too generic for my taste ... but I also fail to
come up with really good suggestions... maybe "mon_file_vprintf()" or
something similar?

 Thomas
