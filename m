Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394A2C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 11:37:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05A7420663
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 11:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X373bO2+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A7420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifMms-0000KE-3o
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 06:37:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1ifMm3-0008IQ-Nz
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 06:36:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1ifMlz-0001H8-Ez
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 06:36:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37269
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ifMly-0001C2-U4
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 06:36:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576150604;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cFEbeVYpeJCN3JLg7uhgTDyRZUrpPVp2zyHRrIpuuig=;
 b=X373bO2+kRYTF9pm+CXYjv5IR1DfYcYWo8siVgh6BdagaX29Mo1A/IVLH4uSfH4JaBRUud
 VCoyzZVb7lWzK+GBwD77JExG7l3nnlvLp482IVKF8WGnL3uX13A2YqwKg/scG5H9r6dtsq
 zU9ylzjYeCzWdmOfWdgRZP6ZHi3nRzc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-QB389X19Pmu5jQfwi9T3PA-1; Thu, 12 Dec 2019 06:36:37 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C20CD107ACE6
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 11:36:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 93E4F5C241;
 Thu, 12 Dec 2019 11:36:33 +0000 (UTC)
Date: Thu, 12 Dec 2019 11:36:31 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v6 3/8] docs: start a document to describe D-Bus usage
Message-ID: <20191212113631.GG1829331@redhat.com>
References: <20191211134506.1803403-1-marcandre.lureau@redhat.com>
 <20191211134506.1803403-4-marcandre.lureau@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191211134506.1803403-4-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: QB389X19Pmu5jQfwi9T3PA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: mprivozn@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 11, 2019 at 05:45:01PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  MAINTAINERS            |  5 +++
>  docs/interop/dbus.rst  | 99 ++++++++++++++++++++++++++++++++++++++++++
>  docs/interop/index.rst |  1 +
>  3 files changed, 105 insertions(+)
>  create mode 100644 docs/interop/dbus.rst
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 525b4740e8..19faa0e868 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2199,6 +2199,11 @@ F: tests/migration-test.c
>  F: docs/devel/migration.rst
>  F: qapi/migration.json
> =20
> +D-Bus
> +M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> +S: Maintained
> +F: docs/interop/dbus.rst
> +
>  Seccomp
>  M: Eduardo Otubo <otubo@redhat.com>
>  S: Supported
> diff --git a/docs/interop/dbus.rst b/docs/interop/dbus.rst
> new file mode 100644
> index 0000000000..3d760e4882
> --- /dev/null
> +++ b/docs/interop/dbus.rst
> @@ -0,0 +1,99 @@
> +=3D=3D=3D=3D=3D
> +D-Bus
> +=3D=3D=3D=3D=3D
> +
> +Introduction
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +QEMU may be running with various helper processes involved:
> + - vhost-user* processes (gpu, virtfs, input, etc...)
> + - TPM emulation (or other devices)
> + - user networking (slirp)
> + - network services (DHCP/DNS, samba/ftp etc)
> + - background tasks (compression, streaming etc)
> + - client UI
> + - admin & cli
> +
> +Having several processes allows stricter security rules, as well as
> +greater modularity.
> +
> +While QEMU itself uses QMP as primary IPC (and Spice/VNC for remote
> +display), D-Bus is the de facto IPC of choice on Unix systems. The
> +wire format is machine friendly, good bindings exist for various
> +languages, and there are various tools available.
> +
> +Using a bus, helper processes can discover and communicate with each
> +other easily, without going through QEMU. The bus topology is also
> +easier to apprehend and debug than a mesh. However, it is wise to
> +consider the security aspects of it.
> +
> +Security
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +A QEMU D-Bus bus should be private to a single VM. Thus, only
> +cooperative tasks are running on the same bus to serve the VM.
> +
> +D-Bus, the protocol and standard, doesn't have mechanisms to enforce
> +security between peers once the connection is established. Peers may
> +have additional mechanisms to enforce security rules, based for
> +example on UNIX credentials.


                                 However, because the daemon has
> +controlled who can send/recv messages to who, doesn't magically make
> +this secure.=20

This reads a little awkwardly, instead:

 The daemon can control which peers can send/recv messages using various
 metadata attributes, however, this is alone is not generally sufficient
 to make the deployment secure.

>                The semantics of the actual methods implemented using
> +D-Bus are just as critical. Peers need to carefully validate any
> +information they received from a peer with a different trust level.
> +
> +dbus-daemon policy
> +------------------
> +
> +dbus-daemon can enforce various policies based on the UID/GID of the
> +processes that are connected to it. It is thus a good idea to run
> +helpers as different UID from QEMU and set appropriate policies.
> +
> +Depending on the use case, you may choose different scenarios:
> +
> + - Everything the same UID
> +
> +   - Convenient for developers
> +   - Improved reliability - crash of one part doens't take
> +     out entire VM
> +   - No security benefit over traditional QEMU

In the last point add

    ', unless additional unless additional controls
     such as SELinux or AppArmor are applied'.

> +
> + - Two UIDs, one for QEMU, one for dbus & helpers
> +
> +   - Moderately improved security isolation

s/improved/improved user based/

> +
> + - Many UIDs, one for QEMU one for dbus and one for each helpers
> +
> +   - Best security isolation

s/Best/Best user based/

> +   - Complex to manager distinct UIDs needed for each VM
> +
> +For example, to allow only ``qemu`` user to talk to ``qemu-helper``
> +``org.qemu.Helper1`` service, a dbus-daemon policy may contain:
> +
> +.. code:: xml
> +
> +  <policy user=3D"qemu">
> +     <allow send_destination=3D"org.qemu.Helper1"/>
> +     <allow receive_sender=3D"org.qemu.Helper1"/>
> +  </policy>
> +
> +  <policy user=3D"qemu-helper">
> +     <allow own=3D"org.qemu.Helper1"/>
> +  </policy>
> +
> +
> +dbus-daemon can also perfom SELinux checks based on the security
> +context of the source and the target. For example, ``virtiofs_t``
> +could be allowed to send a message to ``svirt_t``, but ``virtiofs_t``
> +wouldn't be allowed to send a message to ``virtiofs_t``.
> +
> +See dbus-daemon man page for details.
> +
> +Guidelines
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +When implementing new D-Bus interfaces, it is recommended to follow
> +the "D-Bus API Design Guidelines":
> +https://dbus.freedesktop.org/doc/dbus-api-design.html
> +
> +The "org.qemu.*" prefix is reserved for the QEMU project.

Perhaps change the last few words to

  'for services implemented & distributed by the QEMU project'

> diff --git a/docs/interop/index.rst b/docs/interop/index.rst
> index 3e33fb5933..ded134ea75 100644
> --- a/docs/interop/index.rst
> +++ b/docs/interop/index.rst
> @@ -13,6 +13,7 @@ Contents:
>     :maxdepth: 2
> =20
>     bitmaps
> +   dbus
>     live-block-operations
>     pr-helper
>     qemu-ga

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


