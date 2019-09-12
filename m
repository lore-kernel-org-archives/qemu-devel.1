Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A75BC4CEC5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 15:46:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D5D32081B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 15:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D5D32081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8RIi-0005G3-F5
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 11:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i8RHn-0004o2-1L
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 11:45:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i8RHl-0000jy-Sg
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 11:45:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52546)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1i8RHl-0000j6-LC
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 11:45:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2CD298A1C84;
 Thu, 12 Sep 2019 15:45:28 +0000 (UTC)
Received: from localhost (ovpn-116-134.ams2.redhat.com [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D7FF85C22C;
 Thu, 12 Sep 2019 15:45:20 +0000 (UTC)
Date: Thu, 12 Sep 2019 17:45:19 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Message-ID: <20190912154519.GN23174@stefanha-x1.localdomain>
References: <cover.1567534653.git.jag.raman@oracle.com>
 <0f0117061fabf398c5d16811ef8787c0ba7d4b0e.1567534653.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BtmVPk+Smchi6n7w"
Content-Disposition: inline
In-Reply-To: <0f0117061fabf398c5d16811ef8787c0ba7d4b0e.1567534653.git.jag.raman@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Thu, 12 Sep 2019 15:45:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC v3 PATCH 08/45] multi-process: add functions
 to synchronize proxy and remote endpoints
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, quintela@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com,
 mreitz@redhat.com, ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--BtmVPk+Smchi6n7w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 03, 2019 at 04:37:34PM -0400, Jagannathan Raman wrote:
> In some cases, for example MMIO read, QEMU has to wait for the remote to
> complete a command before proceeding. An eventfd based mechanism is
> added to synchronize QEMU & remote process.
>=20
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> ---
>  v1 -> v2:
>    - Added timeout to synchronization functions
>=20
>  include/io/proxy-link.h |  8 ++++++++
>  io/proxy-link.c         | 42 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
>=20
> diff --git a/include/io/proxy-link.h b/include/io/proxy-link.h
> index ee78cdd..b76c574 100644
> --- a/include/io/proxy-link.h
> +++ b/include/io/proxy-link.h
> @@ -28,7 +28,9 @@
>  #include <stddef.h>
>  #include <stdint.h>
>  #include <glib.h>
> +#include <unistd.h>
>  #include <pthread.h>
> +#include <sys/eventfd.h>
> =20
>  #include "qemu/osdep.h"
>  #include "qom/object.h"
> @@ -133,11 +135,17 @@ struct ProxyLinkState {
>      proxy_link_callback callback;
>  };
> =20
> +#define GET_REMOTE_WAIT eventfd(0, 0)
> +#define PUT_REMOTE_WAIT(wait) close(wait)

Can you use functions instead of macros?  eventfd() is Linux-specific so
this code is not portable.  QEMU has an EventNotifier abstraction but
I'm not sure if it can be used since this patch doesn't include any code
that calls GET_REMOTE_WAIT/PUT_REMOTE_WAIT and there are no comments.  I
don't know what the expected semantics are.

> +#define PROXY_LINK_WAIT_DONE 1
> +
>  ProxyLinkState *proxy_link_create(void);
>  void proxy_link_finalize(ProxyLinkState *s);
> =20
>  void proxy_proc_send(ProxyLinkState *s, ProcMsg *msg, ProcChannel *chan);
>  int proxy_proc_recv(ProxyLinkState *s, ProcMsg *msg, ProcChannel *chan);
> +uint64_t wait_for_remote(int efd);
> +void notify_proxy(int fd, uint64_t val);
> =20
>  void proxy_link_init_channel(ProxyLinkState *s, ProcChannel **chan, int =
fd);
>  void proxy_link_destroy_channel(ProcChannel *chan);
> diff --git a/io/proxy-link.c b/io/proxy-link.c
> index 5eb9718..381a38e 100644
> --- a/io/proxy-link.c
> +++ b/io/proxy-link.c
> @@ -31,6 +31,8 @@
>  #include <sys/socket.h>
>  #include <sys/un.h>
>  #include <unistd.h>
> +#include <limits.h>
> +#include <poll.h>
> =20
>  #include "qemu/module.h"
>  #include "io/proxy-link.h"
> @@ -216,6 +218,46 @@ int proxy_proc_recv(ProxyLinkState *s, ProcMsg *msg,=
 ProcChannel *chan)
>      return rc;
>  }
> =20
> +uint64_t wait_for_remote(int efd)

Hard to tell if this makes sense without any context.  I notice that
EFD_CLOEXEC and EFD_NONBLOCK were not used.  It's likely that
EFD_CLOEXEC should be used.  Since the eventfd is used with poll(2)
EFD_NONBLOCK should probably also be used so it's certain that read()
will not block (which could exceed the timeout).

--BtmVPk+Smchi6n7w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl16aA8ACgkQnKSrs4Gr
c8jyeAf/XTZee2nByjlaQNXMncefjcpr4rQjhisi3bcG42QbIjdu5iBj5u0RtEg4
mXq6AVHRN5J7iPUl3+kClCcqkJrPulo7SVONl4d7nrmJ/quoeqEXMecWsLBVj11A
lvKN5CDC3XlLQuE0bho4vfD079NmJQYH/Gn14GNJr9vDCfTYCHJvceS2wsdvdNdc
RcY88kEtWdUtvNxBed107IbdGQiLIutmSImwPLbAerclr6T7c7/MyIY6sWKRayvP
Ch79o8Yrgh68GwqqSJ+AeaoATg/52x+lSulrKIpIUCnh+97DBZAZOFwhB2RMNyt1
nnDBKpjtgmcXRjyd50aY0m15VhQCzw==
=WU2J
-----END PGP SIGNATURE-----

--BtmVPk+Smchi6n7w--

