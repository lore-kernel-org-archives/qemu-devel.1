Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B546C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:46:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4196D20737
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7vatNUr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4196D20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOfZD-0003Qk-By
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 06:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jOfWD-00052V-BI
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:43:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jOfWC-0003h3-5a
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:43:45 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35739)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jOfWB-0003gb-Tk
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:43:44 -0400
Received: by mail-wr1-x441.google.com with SMTP id x18so14242959wrq.2
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 03:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=C7XyshhH77DcyRsRX8x461xZTbNXor+kTArWay9Peb0=;
 b=d7vatNUr7bF6dnX+Fn93XYnc5YhanVB2jN+KC8E4gWoA2VZrMdHmEBXJPFiXy37oxg
 hQf7TdvHW3J1G+vRXrbrwbyC6HYLifOK7P8gDttHlgDq7UlunPcYg6f6KTJLjnSuC1Oj
 r5E2gAIy0d/FI7tXs1wN4WdrqcbapAJOS8/iohAbTzSsscRMscnj7IWhuiOwC71uvWsS
 PcIitMjU+bAZUgc33/EscLJDDt1dz3oYFz9xTAtry4hSohZbyRD4B17XpnZID91UOMoy
 kWcqqBYpbZbcsCl1DusdSJaL70qE19BzOGcujQnvDzxAX2oFqobksN79oJg9sUPV3NzZ
 at4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=C7XyshhH77DcyRsRX8x461xZTbNXor+kTArWay9Peb0=;
 b=a4mAiV0rC4v6hLsmj/1D+wu8ykan09IVLzKSKzicugLDI7JVuc/poNrDE8uWTyOwad
 Od820BKnzzdsTVxqq+iqFxuBfG8Cgo6+IezgKSdN8ygpZW+W5kR/15OL4TRTQtGXSCX7
 cRwng8M14zIDOCcPFTQv6yjhP8Ycsb7Mraq7HzMQCSFG4qtfGkMJvitZ1tTb99WmWDvB
 5zv1Rz0hbbURozyvwdLPzGpDV/Cb7+fxIlURlynvjQfGJXCNb8QkSRPH7pqDAE1vGD8A
 TA42vHwyXBN8C2yqZa/OhGbTLd51/jyCyld7sAUODyKZp4pr6ULWIy/nei41cQyWtCF/
 qdEA==
X-Gm-Message-State: AGi0PuZFqk1Yg+sOJ4StZuwSZBLIULw7QTCFHLrrEdfFkSQNLBvm50oH
 tcAdVKBSwj5Qr/WGZ6WxODbab3PZBy16ZYv1YVZKLCKnGig=
X-Google-Smtp-Source: APiQypK0lDqxSutNLmevkJ7A/WD9Hnuv5H9Lt3d/xuHy4YXOMxE2U+F6Rwz9Vw7e9S7x6WmKJxSzp5zEEGQVEfsuAnQ=
X-Received: by 2002:adf:ff82:: with SMTP id j2mr17022524wrr.96.1586947422777; 
 Wed, 15 Apr 2020 03:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200415005938.23895-1-alazar@bitdefender.com>
 <20200415005938.23895-3-alazar@bitdefender.com>
In-Reply-To: <20200415005938.23895-3-alazar@bitdefender.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 15 Apr 2020 12:43:31 +0200
Message-ID: <CAJ+F1CKKi8L9x3S5HRZEVqAmtLgafb6rmKO3h7tGbnxKkJVzZA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 02/26] char-socket: allow vsock parameters (cid,
 port)
To: =?UTF-8?Q?Adalbert_Laz=C4=83r?= <alazar@bitdefender.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Apr 15, 2020 at 3:00 AM Adalbert Laz=C4=83r <alazar@bitdefender.com=
> wrote:
>
> The introspection tool can run in a separate VM and the introspected
> VM will establish a connection using a virtual socket.
>
> CC: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Adalbert Laz=C4=83r <alazar@bitdefender.com>

We should also add QMP support.

Please add some tests in tests/test-char.c.

> ---
>  chardev/char-socket.c | 27 ++++++++++++++++++++++++---
>  chardev/char.c        |  3 +++
>  2 files changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index bd966aace1..9b2deb0125 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -23,6 +23,11 @@
>   */
>
>  #include "qemu/osdep.h"
> +
> +#ifdef CONFIG_AF_VSOCK
> +#include <linux/vm_sockets.h>
> +#endif /* CONFIG_AF_VSOCK */
> +
>  #include "chardev/char.h"
>  #include "io/channel-socket.h"
>  #include "io/channel-tls.h"
> @@ -590,6 +595,14 @@ static char *qemu_chr_compute_filename(SocketChardev=
 *s)
>                                 s->is_listen ? ",server" : "",
>                                 left, phost, right, pserv);
>
> +#ifdef CONFIG_AF_VSOCK
> +    case AF_VSOCK:
> +        return g_strdup_printf("vsock:%d:%d%s",
> +                               ((struct sockaddr_vm *)(ss))->svm_cid,
> +                               ((struct sockaddr_vm *)(ss))->svm_port,
> +                               s->is_listen ? ",server" : "");
> +#endif
> +
>      default:
>          return g_strdup_printf("unknown");
>      }
> @@ -1378,18 +1391,19 @@ static void qemu_chr_parse_socket(QemuOpts *opts,=
 ChardevBackend *backend,
>  {
>      const char *path =3D qemu_opt_get(opts, "path");
>      const char *host =3D qemu_opt_get(opts, "host");
> +    const char *cid  =3D qemu_opt_get(opts, "cid");
>      const char *port =3D qemu_opt_get(opts, "port");
>      const char *fd =3D qemu_opt_get(opts, "fd");
>      SocketAddressLegacy *addr;
>      ChardevSocket *sock;
>
> -    if ((!!path + !!fd + !!host) !=3D 1) {
> +    if ((!!path + !!fd + !!host + !!cid) !=3D 1) {
>          error_setg(errp,
> -                   "Exactly one of 'path', 'fd' or 'host' required");
> +                   "Exactly one of 'path', 'fd', 'cid' or 'host' require=
d");
>          return;
>      }
>
> -    if (host && !port) {
> +    if ((host || cid) && !port) {
>          error_setg(errp, "chardev: socket: no port given");
>          return;
>      }
> @@ -1444,6 +1458,13 @@ static void qemu_chr_parse_socket(QemuOpts *opts, =
ChardevBackend *backend,
>              .has_ipv6 =3D qemu_opt_get(opts, "ipv6"),
>              .ipv6 =3D qemu_opt_get_bool(opts, "ipv6", 0),
>          };
> +    } else if (cid) {
> +        addr->type =3D SOCKET_ADDRESS_LEGACY_KIND_VSOCK;
> +        addr->u.vsock.data =3D g_new0(VsockSocketAddress, 1);
> +        *addr->u.vsock.data =3D (VsockSocketAddress) {
> +            .cid  =3D g_strdup(cid),
> +            .port =3D g_strdup(port),
> +        };
>      } else if (fd) {
>          addr->type =3D SOCKET_ADDRESS_LEGACY_KIND_FD;
>          addr->u.fd.data =3D g_new(String, 1);
> diff --git a/chardev/char.c b/chardev/char.c
> index e77564060d..39e36ceb97 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -852,6 +852,9 @@ QemuOptsList qemu_chardev_opts =3D {
>          },{
>              .name =3D "host",
>              .type =3D QEMU_OPT_STRING,
> +        },{
> +            .name =3D "cid",
> +            .type =3D QEMU_OPT_STRING,
>          },{
>              .name =3D "port",
>              .type =3D QEMU_OPT_STRING,
>


--=20
Marc-Andr=C3=A9 Lureau

