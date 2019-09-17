Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1239C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 13:14:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A63E214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 13:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A63E214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iADIy-0005vA-LT
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 09:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41953)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iADD5-0000eH-Rq
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:08:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iADD3-0002ly-3a
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:07:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54696)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iADD2-0002lg-SB
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:07:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3CEBD1DB8
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 13:07:56 +0000 (UTC)
Received: from redhat.com (ovpn-112-41.ams2.redhat.com [10.36.112.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 61B2660468;
 Tue, 17 Sep 2019 13:07:28 +0000 (UTC)
Date: Tue, 17 Sep 2019 14:07:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20190917130726.GR1069@redhat.com>
References: <20190912122514.22504-1-marcandre.lureau@redhat.com>
 <20190912122514.22504-6-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190912122514.22504-6-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Tue, 17 Sep 2019 13:07:56 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 5/6] docs: start a document to describe
 D-Bus usage
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

On Thu, Sep 12, 2019 at 04:25:13PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  docs/interop/dbus.rst  | 73 ++++++++++++++++++++++++++++++++++++++++++
>  docs/interop/index.rst |  1 +
>  2 files changed, 74 insertions(+)
>  create mode 100644 docs/interop/dbus.rst
>=20
> diff --git a/docs/interop/dbus.rst b/docs/interop/dbus.rst
> new file mode 100644
> index 0000000000..c08f026edc
> --- /dev/null
> +++ b/docs/interop/dbus.rst
> @@ -0,0 +1,73 @@
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
> +
> +dbus-daemon can enforce various policies based on the UID/GID of the
> +processes that are connected to it. It is thus a good idea to run
> +helpers as different UID from QEMU and set appropriate policies (so
> +helper processes are only allowed to talk to qemu for example).

We should also recommend that the daemon itself be run as separate
UID from QEMU, otherwise a compromised QEMU can trivially compromise
the dbus daemon too.

I'd say three scenarios are reasonable to document

 - Everything the same UID.
     - Convenient for developers
     - Improved reliability - crash of one part doens't take
       out entire VM
     - No security benefit over traditional QEMU

 - Two UIDs, one for QEMU, one for dbus & helpers
     - Moderately improved security isolation

 - Many UIDs, one for QEMU one for dbus and one for each helpers
     - Best security isolation
     - Complex to manager distinct UIDs needed for each VM


Documenting SELinux scenarios is probably a bit out of scope for
this.

We probably need to mention about the trust semantics associated
with messages sent over the bus.

ie, just because the daemon has controlled who can send/recv
messages to who, doesn't magically make this secure.

The semantics of the actual methods implemented using dbus
are just as critical. Peers need to carefully validate any
information they received from a peer with a different trust
level.

> +For example, this allows only ``qemu`` user to talk to ``qemu-helper``
> +``org.qemu.Helper1`` service:
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

> +Guidelines
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +When implementing new D-Bus interfaces, it is recommended to follow
> +the "D-Bus API Design Guidelines":
> +https://dbus.freedesktop.org/doc/dbus-api-design.html
> +
> +The "org.qemu*" prefix is reserved for the QEMU project.

s/org.qemu*/org.qemu.*/ - we can't claim ownership of every
possible domain name with 'qemu' as a prefix.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

