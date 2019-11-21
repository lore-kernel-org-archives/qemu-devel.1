Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7528EC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:11:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29EA420721
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPtr+cC3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29EA420721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXkN1-0002VN-Ad
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 06:11:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iXkLX-0000rE-Sg
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:10:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iXkLV-0002w9-IF
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:09:59 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35594)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iXkLU-0002vW-Jr
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:09:57 -0500
Received: by mail-wr1-x443.google.com with SMTP id s5so3899323wrw.2
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 03:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ELJUWu3b3HmIOPkntYexOWL829ia19S7Z+zyXzdfAFo=;
 b=OPtr+cC3GDQqmNjQLNPfQVWuAWo/ktyf4TB11th4uIVz6SQUlfA8FVWQHmqJGnyD0w
 z98A2n1UC8LEwMohMXSQaBPtbdEYJt4nyPXD6s9ylL33MqmIGXbO9yAuaMnm3fDRVkGU
 Iz4BNEx0fLtOZMYARlNYVVqVfGKd3WWbgN6c7kH2SDxbq6M+9a165xMTaYkmYVzGMgT6
 wgzBI1+yf6pMrsyaE7S/Bv77Jc1DTV/3ZpB/8xFuZEhVYPC6EZHkWprENrMFYS487DYl
 dwoto+1u3VRoaY+jcI9SlAqUD3tQH1MRg0Q1qXQgOseFP19KQIPT0hzBTPzuZg5CBG9q
 +cgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ELJUWu3b3HmIOPkntYexOWL829ia19S7Z+zyXzdfAFo=;
 b=DWwGI0E3M1teF8rmYzLfQlfmOvzt1AqYtYOwvBGo74bQ7PPFkPjo3oMi7gVHeGiFOG
 XOr558qRZT056PoBcAjI2b399eSyTIiqeFjmk4/JbVcMf9nYBiijpXDSQVROwNOq68eu
 GgSMBcAHUH9x+IzkMrcxaEMegaGU7lSmEGMom+md3G8mu8ORxnKM/TdXutJDW85mqfUt
 E5lmPoMhhPJoM/pQVE3oplm8oDRFM8cBbjZX74CcNMfEQmJt6Qe3pNROXhaXwmAlu5cn
 tCC8PXgVzbAMvLwWNnvynYKEJqTDDab6/j29QU+EcIv+v+SEvLAe62RxCzza4J4zIee2
 P+Cw==
X-Gm-Message-State: APjAAAXrZ9RuA6R6UmYJWM+CT7i/rvMq+2+WGgLsIhjDL1ANPYhaeCri
 Dsaj+1scpUICBkQxVA1kGx0=
X-Google-Smtp-Source: APXvYqx6ITcA0YB3sy1uaS/PViPVPY64R88daShUWPrhMrLUNk4UTzrScAM9E3l6+zvA5FnZRpOo3A==
X-Received: by 2002:adf:81e3:: with SMTP id 90mr8846586wra.23.1574334594839;
 Thu, 21 Nov 2019 03:09:54 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id x8sm2505485wmi.10.2019.11.21.03.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2019 03:09:53 -0800 (PST)
Date: Thu, 21 Nov 2019 11:09:52 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [RFC v4 PATCH 13/49] multi-process: introduce proxy object
Message-ID: <20191121110952.GH439743@stefanha-x1.localdomain>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <64276bb78fce32a6ddf4356bf29632af1ef2c785.1571905346.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SUk9VBj82R8Xhb8H"
Content-Disposition: inline
In-Reply-To: <64276bb78fce32a6ddf4356bf29632af1ef2c785.1571905346.git.jag.raman@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
 qemu-devel@nongnu.org, kraxel@redhat.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--SUk9VBj82R8Xhb8H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2019 at 05:08:54AM -0400, Jagannathan Raman wrote:
> diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
> new file mode 100644
> index 0000000..baba4da
> --- /dev/null
> +++ b/hw/proxy/qemu-proxy.c
> @@ -0,0 +1,247 @@
> +/*
> + * Copyright 2019, Oracle and/or its affiliates.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> + * THE SOFTWARE.
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/types.h>
> +#include <sys/socket.h>
> +#include <unistd.h>
> +#include <assert.h>
> +#include <string.h>
> +#include "qemu/osdep.h"

Most of these includes are not necessary.  Please see "Include
directives" in CODING_STYLE.rst.  "qemu/osdep.h" is always first (even
before system headers) and it already includes the common system
headers.

> +int remote_spawn(PCIProxyDev *pdev, const char *command, Error **errp)
> +{
> +    char *args[3];
> +    pid_t rpid;
> +    int fd[2] =3D {-1, -1};
> +    Error *local_error =3D NULL;
> +
> +    if (pdev->managed) {
> +        /* Child is forked by external program (such as libvirt). */
> +        return -1;
> +    }
> +
> +    if (socketpair(AF_UNIX, SOCK_STREAM, 0, fd)) {
> +        error_setg(errp, "Unable to create unix socket.");
> +        return -1;
> +    }
> +    /* TODO: Restrict the forked process' permissions and capabilities. =
*/
> +    rpid =3D qemu_fork(&local_error);
> +
> +    if (rpid =3D=3D -1) {
> +        error_setg(errp, "Unable to spawn emulation program.");
> +        close(fd[0]);
> +        close(fd[1]);
> +        return -1;
> +    }
> +
> +    if (rpid =3D=3D 0) {
> +        close(fd[0]);
> +
> +        args[0] =3D g_strdup(command);
> +        args[1] =3D g_strdup_printf("%d", fd[1]);
> +        args[2] =3D NULL;
> +        execvp(args[0], (char *const *)args);

execv(3) is safer because it doesn't search PATH.  Unless searching PATH
is really needed I would use that instead just in case this is ever
deployed in an environment where an attacker controls a directory in
PATH or is able to set PATH.

> +static int config_op_send(PCIProxyDev *dev, uint32_t addr, uint32_t *val=
, int l,
> +                          unsigned int op)
> +{
> +    MPQemuMsg msg;
> +    struct conf_data_msg conf_data;
> +    int wait;
> +
> +    memset(&msg, 0, sizeof(MPQemuMsg));
> +    conf_data.addr =3D addr;
> +    conf_data.val =3D (op =3D=3D CONF_WRITE) ? *val : 0;
> +    conf_data.l =3D l;
> +
> +    msg.data2 =3D (uint8_t *)malloc(sizeof(conf_data));
> +    if (!msg.data2) {
> +        return -ENOMEM;
> +    }
> +
> +    memcpy(msg.data2, (const uint8_t *)&conf_data, sizeof(conf_data));
> +    msg.size =3D sizeof(conf_data);

Why malloc msg.data2 instead of simply pointing it at conf_data?

> +    msg.cmd =3D op;
> +    msg.bytestream =3D 1;
> +
> +    if (op =3D=3D CONF_WRITE) {
> +        msg.num_fds =3D 0;
> +    } else {
> +        wait =3D GET_REMOTE_WAIT;

It seems slow to create an fd and pass it for each 32-bit PCI
Configuration Space read operation.  This doesn't need to be changed
right now, but eventually the protocol should handle this more
efficiently.

> +        msg.num_fds =3D 1;
> +        msg.fds[0] =3D wait;
> +    }
> +
> +    mpqemu_msg_send(dev->mpqemu_link, &msg, dev->mpqemu_link->com);
> +
> +    if (op =3D=3D CONF_READ) {
> +        *val =3D (uint32_t)wait_for_remote(wait);
> +        PUT_REMOTE_WAIT(wait);
> +    }

Waiting for the eventfd blocks the event loop.  This means timers and
other fds won't be serviced when the remote is slow to respond.  Please
avoid blocking operations in event loop threads.

> +
> +    free(msg.data2);
> +
> +    return 0;
> +}
> +
> +static uint32_t pci_proxy_read_config(PCIDevice *d, uint32_t addr, int l=
en)
> +{
> +    uint32_t val;
> +
> +    (void)pci_default_read_config(d, addr, len);

What is the purpose of this call?

> +static const TypeInfo pci_proxy_dev_type_info =3D {
> +    .name          =3D TYPE_PCI_PROXY_DEV,
> +    .parent        =3D TYPE_PCI_DEVICE,
> +    .instance_size =3D sizeof(PCIProxyDev),
> +    .abstract      =3D true,
> +    .class_size    =3D sizeof(PCIProxyDevClass),
> +    .class_init    =3D pci_proxy_dev_class_init,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +        { },
> +    },
> +};

It would be nice for -device pci-proxy-dev to work as a placeholder for
*any* PCI bus device without the need to define concrete subclasses.
Could the protocol exchange the PCI device configuration (similar to
VFIO and muser ioctls) so that this single object can act as any remote
PCI device?

> diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
> new file mode 100644
> index 0000000..3648a77
> --- /dev/null
> +++ b/include/hw/proxy/qemu-proxy.h
> @@ -0,0 +1,81 @@
> +/*
> + * Copyright 2019, Oracle and/or its affiliates.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef QEMU_PROXY_H
> +#define QEMU_PROXY_H
> +
> +#include "io/mpqemu-link.h"
> +
> +#define TYPE_PCI_PROXY_DEV "pci-proxy-dev"
> +
> +#define PCI_PROXY_DEV(obj) \
> +            OBJECT_CHECK(PCIProxyDev, (obj), TYPE_PCI_PROXY_DEV)
> +
> +#define PCI_PROXY_DEV_CLASS(klass) \
> +            OBJECT_CLASS_CHECK(PCIProxyDevClass, (klass), TYPE_PCI_PROXY=
_DEV)
> +
> +#define PCI_PROXY_DEV_GET_CLASS(obj) \
> +            OBJECT_GET_CLASS(PCIProxyDevClass, (obj), TYPE_PCI_PROXY_DEV)
> +
> +typedef struct PCIProxyDev {
> +    PCIDevice parent_dev;
> +
> +    int n_mr_sections;
> +    MemoryRegionSection *mr_sections;

Unused.

> +
> +    MPQemuLinkState *mpqemu_link;
> +
> +    EventNotifier intr;
> +    EventNotifier resample;

Unused.

> +
> +    pid_t remote_pid;
> +    int rsocket;
> +    int socket;

What is the difference between rsocket and socket?  Why is socket only
read in this patch and never written?

> +
> +    char *rid;

Can remote_pid and rid be unified.  They store the same value in
different representations.

> +
> +    bool managed;
> +    char *dev_id;

dev_id is unused.

> +
> +    QLIST_ENTRY(PCIProxyDev) next;

Unused.

> +
> +    void (*set_proxy_sock) (PCIDevice *dev, int socket);
> +    int (*get_proxy_sock) (PCIDevice *dev);
> +
> +    void (*set_remote_opts) (PCIDevice *dev, QDict *qdict, unsigned int =
cmd);
> +    void (*proxy_ready) (PCIDevice *dev);

Unused.

> +    void (*init_proxy) (PCIDevice *pdev, char *command, Error **errp);

Why are these function pointers not in PCIProxyDevClass?

> +
> +} PCIProxyDev;
> +
> +typedef struct PCIProxyDevClass {
> +    PCIDeviceClass parent_class;
> +
> +    void (*realize)(PCIProxyDev *dev, Error **errp);
> +
> +    char *command;
> +} PCIProxyDevClass;
> +
> +int remote_spawn(PCIProxyDev *pdev, const char *command, Error **errp);

Does this function need to be publicly visible?

> diff --git a/remote/remote-main.c b/remote/remote-main.c
> index 7689b57..6c2eb91 100644
> --- a/remote/remote-main.c
> +++ b/remote/remote-main.c
> @@ -50,6 +50,32 @@
>  static MPQemuLinkState *mpqemu_link;
>  PCIDevice *remote_pci_dev;
> =20
> +static void process_config_write(MPQemuMsg *msg)
> +{
> +    struct conf_data_msg *conf =3D (struct conf_data_msg *)msg->data2;
> +
> +    qemu_mutex_lock_iothread();
> +    pci_default_write_config(remote_pci_dev, conf->addr, conf->val, conf=
->l);
> +    qemu_mutex_unlock_iothread();
> +}
> +
> +static void process_config_read(MPQemuMsg *msg)
> +{
> +    struct conf_data_msg *conf =3D (struct conf_data_msg *)msg->data2;
> +    uint32_t val;
> +    int wait;
> +
> +    wait =3D msg->fds[0];
> +
> +    qemu_mutex_lock_iothread();
> +    val =3D pci_default_read_config(remote_pci_dev, conf->addr, conf->l);
> +    qemu_mutex_unlock_iothread();
> +
> +    notify_proxy(wait, val);
> +
> +    PUT_REMOTE_WAIT(wait);
> +}

Input validation is missing in these message handler functions.  I won't
look out for this in patches that follow anymore.  All message handler
functions need to be audited.  They must check the message size before
accessing fields, that fds[0] was indeed passed, etc.

--SUk9VBj82R8Xhb8H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3WcIAACgkQnKSrs4Gr
c8hD3wgAySX7vwB5OtCQEcvoIg8PL0GSek8AOFr7q7YWmP/fpqshI19BATEfxl5d
sc3jtHBmNiluKlvYb1AZHuH87x+oE3C4Ted+jZV8Qh/GUMyF3VqtI+QtxkvoTXk+
twHSXMz2ZZn4JoBWPrQKStr/4kQfpz8O3b99RxQ759UhHjO/+t8DYkyEXU38Mf7a
YlyNxEwY47VccXmgixyLNndmnD74/Uu77MvUKU54zgPPvmXrapzfkwS3EhJD8Lag
nFFKApQwjtWAR4kCnPCG1OF+A/rGTRfH0Bsuw7nAl+5vZ5Rr9WEXbU5DrWTSKbvU
JhlnB1Cc/vJDR6mf0Zc93G6W47aQlQ==
=P0Ts
-----END PGP SIGNATURE-----

--SUk9VBj82R8Xhb8H--

