Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C72C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 12:55:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9C522137B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 12:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ow2+oJAe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C522137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL4Ib-0001kH-Ki
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 08:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL4HZ-0000f6-OI
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 08:54:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58304)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL4HV-0008L4-2C
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 08:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600865635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yhs9csTo3QaUfUkv26MKTEjT+HcUPOdj8b5zJUkY+1U=;
 b=Ow2+oJAeRLffJzBdxJ3rQKz37ayzTiP53B32XmMyez1RookBY2ipyIpnEsG68MstErb8aZ
 EXJ1KlnagzghNeRD0+cDAbk4vCC7SAuk0ZQHXJUMYEbt1weUE19AlmGz+REt6A3NMgqmBb
 szGGL3yZK+5gzpuWQDsO20gCZS75u4A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-b3WhbB1wOX2Xha9qsT95Rw-1; Wed, 23 Sep 2020 08:53:51 -0400
X-MC-Unique: b3WhbB1wOX2Xha9qsT95Rw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF80B8ECE68;
 Wed, 23 Sep 2020 12:53:49 +0000 (UTC)
Received: from localhost (ovpn-113-77.ams2.redhat.com [10.36.113.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8990B55768;
 Wed, 23 Sep 2020 12:53:49 +0000 (UTC)
Date: Wed, 23 Sep 2020 13:53:48 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/3] docs: add qemu-storage-daemon documentation
Message-ID: <20200923125348.GJ51019@stefanha-x1.localdomain>
References: <20200910144400.69615-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200910144400.69615-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="QxN5xOWGsmh5a4wb"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Kashyap Chamarthy <kchamart@redhat.com>,
 afrosi@redhat.com, Laszlo Ersek <lersek@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--QxN5xOWGsmh5a4wb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2020 at 03:43:57PM +0100, Stefan Hajnoczi wrote:
> v2:
>  * Drop block-core.json h2 header removal, add an h1 header to
>    storage-daemon/qapi/qapi-schema.json instead [Kevin]
>  * Add Examples section to man page [Kevin]

Ping

> Add documentation for the qemu-storage-daemon program and its QMP command=
s.
>=20
> The man page looks like this:
>=20
> QEMU-STORAGE-DAEMON(1)              QEMU                QEMU-STORAGE-DAEM=
ON(1)
>=20
> NAME
>        qemu-storage-daemon - QEMU storage daemon
>=20
> SYNOPSIS
>        qemu-storage-daemon [options]
>=20
> DESCRIPTION
>        qemu-storage-daemon  provides  disk image functionality from QEMU,
>        qemu-img, and qemu-nbd in a long-running process controlled via QM=
P
>        commands without running a virtual machine. It can export disk ima=
ges
>        over NBD, run block job operations, and perform other disk-related
>        operations. The daemon is controlled via a QMP monitor socket and
>        initial  configuration from the command-line.
>=20
>        The daemon offers the following subset of QEMU features:
>        =B7 Blockdev nodes
>        =B7 Block jobs
>        =B7 NBD server
>        =B7 Character devices
>        =B7 Crypto and secrets
>        =B7 QMP
>=20
>        Commands can be sent over a QEMU Monitor Protocol (QMP) connection=
. See
>        the qemu-storage-daemon-qmp-ref(7) manual page for a description o=
f the
>        commands.
>=20
>        The daemon runs until it is stopped using the quit QMP command or
>        SIGINT/SIGHUP/SIGTERM.
>=20
>        Warning: Never modify images in use by a running virtual machine o=
r any
>        other process; this may destroy the image. Also, be aware that que=
rying
>        an image that is being modified by another process may encounter
>        inconsistent state.
>=20
> OPTIONS
>        Standard options:
>=20
>        -h, --help
>               Display this help and exit
>=20
>        -V, --version
>               Display version information and exit
>=20
>        -T, --trace [[enable=3D]PATTERN][,events=3DFILE][,file=3DFILE]
>               Specify tracing options.
>=20
>               [enable=3D]PATTERN
>                      Immediately enable events matching PATTERN (either e=
vent name or a globbing pattern).  This option is only available if QEMU ha=
s been compiled with the simple,  log
>                      or ftrace tracing backend.  To specify multiple even=
ts or patterns, specify the -trace option multiple times.
>=20
>                      Use -trace help to print a list of names of trace po=
ints.
>=20
>               events=3DFILE
>                      Immediately  enable  events  listed in FILE.  The fi=
le must contain one event name (as listed in the trace-events-all file) per=
 line; globbing patterns are accepted
>                      too.  This option is only available if QEMU has been=
 compiled with the simple, log or ftrace tracing backend.
>=20
>               file=3DFILE
>                      Log output traces to FILE.  This option is only avai=
lable if QEMU has been compiled with the simple tracing backend.
>=20
>        --blockdev BLOCKDEVDEF
>               is a blockdev node definition. See the qemu(1) manual page =
for a description of blockdev node properties and the qemu-block-drivers(7)=
 manual page  for  a  description  of
>               driver-specific parameters.
>=20
>        --chardev CHARDEVDEF
>               is  a  character  device  definition.  See the qemu(1) manu=
al page for a description of character device properties. A common characte=
r device definition configures a UNIX
>               domain socket:
>=20
>                  --chardev socket,id=3Dchar1,path=3D/tmp/qmp.sock,server,=
nowait
>=20
>        --monitor MONITORDEF
>               is a QMP monitor definition. See the qemu(1) manual page fo=
r a description of QMP monitor properties. A common QMP monitor definition =
configures  a  monitor  on  character
>               device char1:
>=20
>                  --monitor chardev=3Dchar1
>=20
>        --nbd-server addr.type=3Dinet,addr.host=3D<host>,addr.port=3D<port=
>[,tls-creds=3D<id>][,tls-authz=3D<id>]
>=20
>        --nbd-server addr.type=3Dunix,addr.path=3D<path>[,tls-creds=3D<id>=
][,tls-authz=3D<id>]
>               is a NBD server definition. Both TCP and UNIX domain socket=
s are supported.  TLS encryption can be configured using --object tls-creds=
-* and authz-* secrets (see below).
>=20
>               To configure an NBD server on UNIX domain socket path /tmp/=
nbd.sock:
>=20
>                  --nbd-server addr.type=3Dunix,addr.path=3D/tmp/nbd.sock
>=20
>        --object help
>=20
>        --object <type>,help
>=20
>        --object <type>[,<property>=3D<value>...]
>               is  a  QEMU  user  creatable object definition. List object=
 types with help.  List object properties with <type>,help. See the qemu(1)=
 manual page for a description of the
>               object properties. The most common object type is a secret,=
 which is used to supply passwords and/or encryption keys.
>=20
> EXAMPLES
>        Launch the daemon with QMP monitor socket qmp.sock so clients can
>        execute QMP commands:
>=20
>           $ qemu-storage-daemon \
>               --chardev socket,path=3Dqmp.sock,server,nowait,id=3Dchar1 \
>               --monitor chardev=3Dchar1
>=20
>        Export raw image file disk.img over NBD UNIX domain socket nbd.soc=
k:
>=20
>           $ qemu-storage-daemon \
>               --blockdev driver=3Dfile,node-name=3Ddisk,filename=3Ddisk.i=
mg \
>               --nbd-server addr.type=3Dunix,addr.path=3Dnbd.sock \
>               --export type=3Dnbd,device=3Ddisk,writable=3Don
>=20
> SEE ALSO
>        qemu(1), qemu-block-drivers(7), qemu-storage-daemon-qmp-ref(7)
>=20
> COPYRIGHT
>        2020, The QEMU Project Developers
>=20
> 5.1.50                     Sep 10, 2020              QEMU-STORAGE-DAEMON(=
1)
>=20
> Stefan Hajnoczi (3):
>   docs: generate qemu-storage-daemon-qmp-ref(7) man page
>   docs: add qemu-storage-daemon(1) man page
>   MAINTAINERS: add Kevin Wolf as storage daemon maintainer
>=20
>  MAINTAINERS                                   |   9 ++
>  storage-daemon/qapi/qapi-schema.json          |   4 +
>  docs/interop/qemu-storage-daemon-qmp-ref.texi |  80 ++++++++++++
>  docs/tools/conf.py                            |   2 +
>  docs/tools/index.rst                          |   1 +
>  docs/tools/qemu-storage-daemon.rst            | 121 ++++++++++++++++++
>  meson.build                                   |   9 ++
>  storage-daemon/qapi/meson.build               |   2 +
>  8 files changed, 228 insertions(+)
>  create mode 100644 docs/interop/qemu-storage-daemon-qmp-ref.texi
>  create mode 100644 docs/tools/qemu-storage-daemon.rst
>=20
> --=20
> 2.26.2
>=20

--QxN5xOWGsmh5a4wb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9rRVwACgkQnKSrs4Gr
c8iy0wf9HIwdbgE1Ns+mf6IDBg5oY3mbBKdeMH+mWsOeb1dyrODL8Q0qhMPqF6Pe
uhhqMyQNgsDlZwXTmbcFTa7gkZhJnQbKAY5cZWEudVt/mw3WWAQ0HkDzmPKGzfDe
iObc63KS2UP6OucLr3rkMeQ/HYAuRBiyExXENU+hoAiNBekjwdN39YQ4PZrrIL5f
IKdXS/0PHKTherCpidWYYCRmLpa5WH3IX0TbjaC37Udw/zMRe7vLuBtRGVRoP9kd
ZzOC2xJtIY/jmqjH5Zuk7MZT3cuNbqPuN8u8fAu04nro2g62xJpGuK8MgLW3Ngvu
VySdbxKI2o51n8xh3pQ76/YgoFUc7g==
=PGFi
-----END PGP SIGNATURE-----

--QxN5xOWGsmh5a4wb--


