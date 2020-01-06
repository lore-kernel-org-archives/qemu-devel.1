Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E76C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:37:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E8A42075A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+X3zXNE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E8A42075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioURz-0004YK-HF
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 10:37:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32833)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1ioU9G-0001Ik-0l
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 10:18:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1ioU9E-00013b-1z
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 10:18:29 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59458
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ioU9D-00013I-Ud
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 10:18:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578323907;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J7nilBbIsUZFieXeFgHe8O6C0oQfwQWIAQAZkO/kr6A=;
 b=b+X3zXNETxvCJNZmgaX9YLrrw/lCgxMJnepzXeQcZP2ECIjLf3DkVtbn0dk5jqdXhdIepP
 qWnlCwzrPTX5Vzi/7Uo1TB27HlLBf/sN/uZGfiTnBF/QH8OSFQYNX9mno6InH/OObexw2x
 hPIxjjXzZF8GyF3ioLdW+et77OiMkG4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-cBVytmopNqGdw08JRxR_jQ-1; Mon, 06 Jan 2020 10:18:25 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBA2F8026A9
 for <qemu-devel@nongnu.org>; Mon,  6 Jan 2020 15:18:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B9475C3F8;
 Mon,  6 Jan 2020 15:18:18 +0000 (UTC)
Date: Mon, 6 Jan 2020 15:18:19 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 059/104] virtiofsd: Add ID to the log with FUSE_LOG_DEBUG
 level
Message-ID: <20200106151819.GW2930416@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-60-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191212163904.159893-60-dgilbert@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: cBVytmopNqGdw08JRxR_jQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 12, 2019 at 04:38:19PM +0000, Dr. David Alan Gilbert (git) wrot=
e:
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>=20
> virtiofsd has some threads, so we see a lot of logs with debug option.
> It would be useful for debugging if we can identify the specific thread
> from the log.
>=20
> Add ID, which is got by gettid(), to the log with FUSE_LOG_DEBUG level
> so that we can grep the specific thread.
>=20
> The log is like as:
>=20
>   ]# ./virtiofsd -d -o vhost_user_socket=3D/tmp/vhostqemu0 -o source=3D/t=
mp/share0 -o cache=3Dauto
>   ...
>   [ID: 00000097]    unique: 12696, success, outsize: 120
>   [ID: 00000097] virtio_send_msg: elem 18: with 2 in desc of length 120
>   [ID: 00000003] fv_queue_thread: Got queue event on Queue 1
>   [ID: 00000003] fv_queue_thread: Queue 1 gave evalue: 1 available: in: 6=
5552 out: 80
>   [ID: 00000003] fv_queue_thread: Waiting for Queue 1 event
>   [ID: 00000071] fv_queue_worker: elem 33: with 2 out desc of length 80 b=
ad_in_num=3D0 bad_out_num=3D0
>   [ID: 00000071] unique: 12694, opcode: READ (15), nodeid: 2, insize: 80,=
 pid: 2014
>   [ID: 00000071] lo_read(ino=3D2, size=3D65536, off=3D131072)
>=20
> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> ---
>  tools/virtiofsd/passthrough_ll.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

>=20
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrou=
gh_ll.c
> index 6f398a7ff2..8e00a90e6f 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -42,6 +42,7 @@
>  #include <cap-ng.h>
>  #include <dirent.h>
>  #include <errno.h>
> +#include <glib.h>
>  #include <inttypes.h>
>  #include <limits.h>
>  #include <pthread.h>
> @@ -2248,12 +2249,18 @@ static void setup_nofile_rlimit(void)
>      }
>  }
> =20
> -static void log_func(enum fuse_log_level level, const char *fmt, va_list=
 ap)
> +static void log_func(enum fuse_log_level level, const char *_fmt, va_lis=
t ap)
>  {
> +    char *fmt =3D (char *)_fmt;

Reusing a variable for data that may be const from stack or
non-const from heap is really gross & asking for trouble.

If instead it does:

    g_autofree *localfmt =3D NULL;

> +
>      if (current_log_level < level) {
>          return;
>      }
> =20
> +    if (current_log_level =3D=3D FUSE_LOG_DEBUG) {
> +        fmt =3D g_strdup_printf("[ID: %08ld] %s", syscall(__NR_gettid), =
_fmt);

Then:

           localfmt =3D g_strdup_printf(....)
=09   fmt =3D localfmt;

> +    }
> +
>      if (use_syslog) {
>          int priority =3D LOG_ERR;
>          switch (level) {
> @@ -2286,6 +2293,10 @@ static void log_func(enum fuse_log_level level, co=
nst char *fmt, va_list ap)
>      } else {
>          vfprintf(stderr, fmt, ap);
>      }
> +
> +    if (current_log_level =3D=3D FUSE_LOG_DEBUG) {
> +        g_free(fmt);
> +    }

This can then be deleted.

>  }

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


