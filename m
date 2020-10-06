Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B38C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 10:20:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA0E920674
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 10:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNBeOlqN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0E920674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPk4h-0007MY-VH
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 06:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kPk3h-0006YW-Gy
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 06:19:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32318)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kPk3X-0006fV-RE
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 06:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601979529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X4hppTnJl5Oaw5UxYpaFawKnr+u9UGByshtvgJsDeBI=;
 b=VNBeOlqNut/0S0Ed8yeRe0SuqQq5RGCHsYhjhyLh5Vjpbr3qlC5kgHH3b5HcbxjxPzW8Lr
 kWfcBnHMFTQX572uQkV1eJf2+fedWpqvZ4Xulvfy4US68feYiKyCqbxPKxlg+aCycqA5lJ
 1xGAHnbePFQ+8kAxlfAl4DDqiAdXMI8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-kYW0c8HkPZqkoWzeVezpTQ-1; Tue, 06 Oct 2020 06:18:47 -0400
X-MC-Unique: kYW0c8HkPZqkoWzeVezpTQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B4C718A8220;
 Tue,  6 Oct 2020 10:18:46 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-147.ams2.redhat.com [10.36.113.147])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 502B87AEC4;
 Tue,  6 Oct 2020 10:18:41 +0000 (UTC)
Date: Tue, 6 Oct 2020 12:18:39 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 2/3] docs: add qemu-storage-daemon(1) man page
Message-ID: <20201006101839.GB4202@linux.fritz.box>
References: <20200910144400.69615-1-stefanha@redhat.com>
 <20200910144400.69615-3-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200910144400.69615-3-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Kashyap Chamarthy <kchamart@redhat.com>,
 afrosi@redhat.com, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 10.09.2020 um 16:43 hat Stefan Hajnoczi geschrieben:
> Document the qemu-storage-daemon tool. Most of the command-line options
> are identical to their QEMU counterparts. Perhaps Sphinx hxtool
> integration could be extended to extract documentation for individual
> command-line options so they can be shared. For now the
> qemu-storage-daemon simply refers to the qemu(1) man page where the
> command-line options are identical.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  docs/tools/conf.py                 |   2 +
>  docs/tools/index.rst               |   1 +
>  docs/tools/qemu-storage-daemon.rst | 121 +++++++++++++++++++++++++++++
>  3 files changed, 124 insertions(+)
>  create mode 100644 docs/tools/qemu-storage-daemon.rst
> 
> diff --git a/docs/tools/conf.py b/docs/tools/conf.py
> index 9052d17d6d..c16290e716 100644
> --- a/docs/tools/conf.py
> +++ b/docs/tools/conf.py
> @@ -20,6 +20,8 @@ html_theme_options['description'] = \
>  man_pages = [
>      ('qemu-img', 'qemu-img', u'QEMU disk image utility',
>       ['Fabrice Bellard'], 1),
> +    ('qemu-storage-daemon', 'qemu-storage-daemon', u'QEMU storage daemon',
> +     [], 1),
>      ('qemu-nbd', 'qemu-nbd', u'QEMU Disk Network Block Device Server',
>       ['Anthony Liguori <anthony@codemonkey.ws>'], 8),

> diff --git a/docs/tools/index.rst b/docs/tools/index.rst
> index 232ce9f3e4..9b076adb62 100644
> --- a/docs/tools/index.rst
> +++ b/docs/tools/index.rst
> @@ -11,6 +11,7 @@ Contents:
>     :maxdepth: 2
>  
>     qemu-img
> +   qemu-storage-daemon
>     qemu-nbd
>     qemu-trace-stap
>     virtfs-proxy-helper
> diff --git a/docs/tools/qemu-storage-daemon.rst b/docs/tools/qemu-storage-daemon.rst
> new file mode 100644
> index 0000000000..a0b8b1a2bf
> --- /dev/null
> +++ b/docs/tools/qemu-storage-daemon.rst
> @@ -0,0 +1,121 @@
> +QEMU Storage Daemon
> +===================
> +
> +Synopsis
> +--------
> +
> +**qemu-storage-daemon** [options]
> +
> +Description
> +-----------
> +
> +qemu-storage-daemon provides disk image functionality from QEMU, qemu-img, and
> +qemu-nbd in a long-running process controlled via QMP commands without running
> +a virtual machine. It can export disk images over NBD, run block job

While this is true today, I think we should phrase it in a more generic
way so that we don't have to modify it each time we add something.

Specifically, I wouldn't mention NBD here, but just say "can export disk
images". If you want, you can add something like "(e.g. over NBD)" to
make clear that this won't be the only option.

> +operations, and perform other disk-related operations. The daemon is controlled
> +via a QMP monitor socket and initial configuration from the command-line.

Likewise I would s/socket// because you can have the QMP monitor on any
chardev. It could be a socket, it could be stdio, maybe there is even a
third option that makes sense.

> +The daemon offers the following subset of QEMU features:
> +
> +* Blockdev nodes

I think we call this "Block nodes" usually in documentation.

> +* Block jobs
> +* NBD server

Let's make this "Block exports"

> +* Character devices
> +* Crypto and secrets
> +* QMP

If we mention crypto/secrets, should we also mention iothreads
explicitly? Or throttle groups?

Or again more generically something like "User-creatable QOM objects
such as crypto secrets and iothread"?

> +Commands can be sent over a QEMU Monitor Protocol (QMP) connection. See the
> +:manpage:`qemu-storage-daemon-qmp-ref(7)` manual page for a description of the
> +commands.
> +
> +The daemon runs until it is stopped using the ``quit`` QMP command or
> +SIGINT/SIGHUP/SIGTERM.
> +
> +**Warning:** Never modify images in use by a running virtual machine or any
> +other process; this may destroy the image. Also, be aware that querying an
> +image that is being modified by another process may encounter inconsistent
> +state.
> +
> +Options
> +-------
> +
> +.. program:: qemu-storage-daemon
> +
> +Standard options:
> +
> +.. option:: -h, --help
> +
> +  Display this help and exit

It's not "this" help in the man page.

> +.. option:: -V, --version
> +
> +  Display version information and exit
> +
> +.. option:: -T, --trace [[enable=]PATTERN][,events=FILE][,file=FILE]
> +
> +  .. include:: ../qemu-option-trace.rst.inc
> +
> +.. option:: --blockdev BLOCKDEVDEF
> +
> +  is a blockdev node definition. See the :manpage:`qemu(1)` manual page for a
> +  description of blockdev node properties and the
> +  :manpage:`qemu-block-drivers(7)` manual page for a description of
> +  driver-specific parameters.

s/blockdev/block/g

qemu-block-drivers(7) was originally a list of options for 'qemu-img
create'. I see that it now describes runtime options for some drivers (in
particular the network drivers), but not the image format drivers.

I guess this needs some cleanup so that create options and runtime
options are clearly separated, and that runtime options for format
drivers are documented.

It doesn't have to stop this patch, though the reference could be
confusing when the other man page starts with create options.

> +.. option:: --chardev CHARDEVDEF
> +
> +  is a character device definition. See the :manpage:`qemu(1)` manual page for
> +  a description of character device properties. A common character device
> +  definition configures a UNIX domain socket::
> +
> +  --chardev socket,id=char1,path=/tmp/qmp.sock,server,nowait
> +
> +.. option:: --monitor MONITORDEF
> +
> +  is a QMP monitor definition. See the :manpage:`qemu(1)` manual page for
> +  a description of QMP monitor properties. A common QMP monitor definition
> +  configures a monitor on character device ``char1``::
> +
> +  --monitor chardev=char1
> +
> +.. option:: --nbd-server addr.type=inet,addr.host=<host>,addr.port=<port>[,tls-creds=<id>][,tls-authz=<id>]
> +  --nbd-server addr.type=unix,addr.path=<path>[,tls-creds=<id>][,tls-authz=<id>]
> +
> +  is a NBD server definition. Both TCP and UNIX domain sockets are supported.
> +  TLS encryption can be configured using ``--object`` tls-creds-* and authz-*
> +  secrets (see below).
> +
> +  To configure an NBD server on UNIX domain socket path ``/tmp/nbd.sock``::
> +
> +  --nbd-server addr.type=unix,addr.path=/tmp/nbd.sock
> +
> +.. option:: --object help
> +  --object <type>,help
> +  --object <type>[,<property>=<value>...]
> +
> +  is a QEMU user creatable object definition. List object types with ``help``.
> +  List object properties with ``<type>,help``. See the :manpage:`qemu(1)`
> +  manual page for a description of the object properties. The most common
> +  object type is a ``secret``, which is used to supply passwords and/or
> +  encryption keys.

Isn't iothread more common actually?

> +Examples
> +--------
> +Launch the daemon with QMP monitor socket ``qmp.sock`` so clients can execute
> +QMP commands::
> +
> +  $ qemu-storage-daemon \
> +      --chardev socket,path=qmp.sock,server,nowait,id=char1 \
> +      --monitor chardev=char1
> +
> +Export raw image file ``disk.img`` over NBD UNIX domain socket ``nbd.sock``::
> +
> +  $ qemu-storage-daemon \
> +      --blockdev driver=file,node-name=disk,filename=disk.img \
> +      --nbd-server addr.type=unix,addr.path=nbd.sock \
> +      --export type=nbd,device=disk,writable=on

The --export syntax for NBD has changed with the block export series.
I think that you need s/device/node-name/ and that it requires an id=...
option now, too.

> +See also
> +--------
> +
> +:manpage:`qemu(1)`, :manpage:`qemu-block-drivers(7)`, :manpage:`qemu-storage-daemon-qmp-ref(7)`
> -- 
> 2.26.2

Kevin


