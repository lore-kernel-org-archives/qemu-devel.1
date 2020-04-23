Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C7BC54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 14:14:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4F112076C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 14:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DZJ+eGS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F112076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRccO-0005D5-0a
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 10:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRcbM-0004EK-9R
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 10:13:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRcbJ-0006tQ-8Q
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 10:13:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59673
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRcbI-0006oc-Jb
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 10:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587651191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S2xWGEd5dUjYIm/YzJJAAxyJbSG4iTLB4cH6pSdI+Bg=;
 b=DZJ+eGS86MxkRF+YZryBfAoJnxvCngh/U0wGhkZ68haLUVb3t4YpCJ3W6u1mv7qZkcdNv4
 Z1jN2XYCQW4iqxFm8tVkSo6aXnahyr2q9Y6yn7o+a7MboGRqMPL0zslbDPgqEl/CvbAprd
 Y/Vgo7uq5eUTWSQg0RnAbsbv4yCWfGw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-3MSE1vpZOVSj3TP-IFsVMQ-1; Thu, 23 Apr 2020 10:13:09 -0400
X-MC-Unique: 3MSE1vpZOVSj3TP-IFsVMQ-1
Received: by mail-wr1-f72.google.com with SMTP id t8so2891995wrq.22
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 07:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0VXBFKh1CefO4rnbj+zOp5PF2utpkelTT4FPzBVH5FE=;
 b=tWFC4KizlCvMIHXII25/pnYeWsChzvkylvkpqQo0uEVo/N2ZYdNrr0Qe32REMRLfsW
 zTRuL2nMfK51Xoeh0gw5eV65RZZZXVr9LlvfS//RSTD3YgNTtor1xixPQ6qBRRyswktj
 2L8sj5ks9ruErxwSERaZf1h4q4+Ql7qBus7eKvTARgSyqZCgbqc3CWtAUmk8DxwUlaK3
 JujnDArD3N7+x1f9yPRPDtvIbAFTHoXOq7Qm9lj+89JOEvbdWNQKtRTNQKJBwVdku8L7
 0fEtUDX6zVyAzpFw1krfSSRYD3xAp55FEwe9zQAKIgYEVzpXlf0luMGwpiy3rovRew9h
 +BrQ==
X-Gm-Message-State: AGi0Pua3iTtiNuNgay7EucuCaHcfR8R+c1BCTFpb1If33tKNG3QGPp+h
 ris0dPd/01ZOzFWs9/c/vEwreqeLRzHytOvWwOfx5RomLbL5Il5uI+/d86V3fwQeaTGLBC6vGtG
 rpIgdfXrKp0o5Zck=
X-Received: by 2002:a05:6000:8b:: with SMTP id
 m11mr5268771wrx.168.1587651188409; 
 Thu, 23 Apr 2020 07:13:08 -0700 (PDT)
X-Google-Smtp-Source: APiQypIHpqf0If4dHA4Qy4GWSR4ukxcJ3SLKbtjFcDv+lRXkhp//nhi1SRw16fYBhuT5pCc+fIxcug==
X-Received: by 2002:a05:6000:8b:: with SMTP id
 m11mr5268714wrx.168.1587651188090; 
 Thu, 23 Apr 2020 07:13:08 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id f23sm3753506wml.4.2020.04.23.07.13.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2020 07:13:07 -0700 (PDT)
Subject: Re: [PATCH RESEND v6 02/36] multi-process: Refactor machine_init and
 exit notifiers
To: elena.ufimtseva@oracle.com, qemu-devel@nongnu.org,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <acd4af5297d0bdec6126a5ebfebc519fca3a3875.1587614626.git.elena.ufimtseva@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <529970ef-042b-5a90-a16f-e56249a2dcef@redhat.com>
Date: Thu, 23 Apr 2020 16:13:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <acd4af5297d0bdec6126a5ebfebc519fca3a3875.1587614626.git.elena.ufimtseva@oracle.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 02:14:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, kraxel@redhat.com, jag.raman@oracle.com, quintela@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, felipe@nutanix.com,
 thuth@redhat.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 dgilbert@redhat.com, liran.alon@oracle.com, stefanha@redhat.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/23/20 6:13 AM, elena.ufimtseva@oracle.com wrote:
> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>=20
> Relocate machine_int and exit notifiers into common code
>=20
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> ---
>   MAINTAINERS                 |  1 +
>   Makefile.objs               |  1 +
>   include/sysemu/sysemu.h     |  2 ++
>   softmmu/vl.c                | 42 ----------------------
>   stubs/Makefile.objs         |  2 ++
>   stubs/machine-init-add.c    |  7 ++++
>   stubs/machine-init-done.c   |  5 ++-
>   stubs/machine-init-remove.c |  8 +++++
>   util/machine-notify.c       | 69 +++++++++++++++++++++++++++++++++++++
>   9 files changed, 92 insertions(+), 45 deletions(-)
>   create mode 100644 stubs/machine-init-add.c
>   create mode 100644 stubs/machine-init-remove.c
>   create mode 100644 util/machine-notify.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8cbc1fac2b..04b19ac56c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2133,6 +2133,7 @@ F: util/qemu-timer.c
>   F: softmmu/vl.c
>   F: softmmu/main.c
>   F: qapi/run-state.json
> +F: util/machine-notify.c
>  =20
>   Human Monitor (HMP)
>   M: Dr. David Alan Gilbert <dgilbert@redhat.com>
> diff --git a/Makefile.objs b/Makefile.objs
> index a7c967633a..bfb9271862 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -79,6 +79,7 @@ qemu-seccomp.o-libs :=3D $(SECCOMP_LIBS)
>   common-obj-$(CONFIG_FDT) +=3D device_tree.o
>  =20
>   common-obj-y +=3D qapi/
> +common-obj-y +=3D util/machine-notify.o
>  =20
>   endif # CONFIG_SOFTMMU
>  =20
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index ef81302e1a..2438dd7bea 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -17,11 +17,13 @@ extern bool qemu_uuid_set;
>  =20
>   void qemu_add_exit_notifier(Notifier *notify);
>   void qemu_remove_exit_notifier(Notifier *notify);
> +void qemu_run_exit_notifiers(void);
>  =20
>   extern bool machine_init_done;
>  =20
>   void qemu_add_machine_init_done_notifier(Notifier *notify);
>   void qemu_remove_machine_init_done_notifier(Notifier *notify);
> +void qemu_run_machine_init_done_notifiers(void);
>  =20
>   extern int autostart;
>  =20
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 32c0047889..39cbb6b50d 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -172,12 +172,6 @@ int icount_align_option;
>   QemuUUID qemu_uuid;
>   bool qemu_uuid_set;
>  =20
> -static NotifierList exit_notifiers =3D
> -    NOTIFIER_LIST_INITIALIZER(exit_notifiers);
> -
> -static NotifierList machine_init_done_notifiers =3D
> -    NOTIFIER_LIST_INITIALIZER(machine_init_done_notifiers);
> -
>   bool xen_allowed;
>   uint32_t xen_domid;
>   enum xen_mode xen_mode =3D XEN_EMULATE;
> @@ -2325,21 +2319,6 @@ static MachineClass *machine_parse(const char *nam=
e, GSList *machines)
>       return mc;
>   }
>  =20
> -void qemu_add_exit_notifier(Notifier *notify)
> -{
> -    notifier_list_add(&exit_notifiers, notify);
> -}
> -
> -void qemu_remove_exit_notifier(Notifier *notify)
> -{
> -    notifier_remove(notify);
> -}
> -
> -static void qemu_run_exit_notifiers(void)
> -{
> -    notifier_list_notify(&exit_notifiers, NULL);
> -}
> -
>   static const char *pid_file;
>   static Notifier qemu_unlink_pidfile_notifier;
>  =20
> @@ -2350,27 +2329,6 @@ static void qemu_unlink_pidfile(Notifier *n, void =
*data)
>       }
>   }
>  =20
> -bool machine_init_done;
> -
> -void qemu_add_machine_init_done_notifier(Notifier *notify)
> -{
> -    notifier_list_add(&machine_init_done_notifiers, notify);
> -    if (machine_init_done) {
> -        notify->notify(notify, NULL);
> -    }
> -}
> -
> -void qemu_remove_machine_init_done_notifier(Notifier *notify)
> -{
> -    notifier_remove(notify);
> -}
> -
> -static void qemu_run_machine_init_done_notifiers(void)
> -{
> -    machine_init_done =3D true;
> -    notifier_list_notify(&machine_init_done_notifiers, NULL);
> -}
> -
>   static const QEMUOption *lookup_opt(int argc, char **argv,
>                                       const char **poptarg, int *poptind)
>   {
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index 45be5dc0ed..f884bb6180 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -43,4 +43,6 @@ stub-obj-y +=3D pci-host-piix.o
>   stub-obj-y +=3D ram-block.o
>   stub-obj-y +=3D ramfb.o
>   stub-obj-y +=3D fw_cfg.o
> +stub-obj-y +=3D machine-init-add.o
> +stub-obj-y +=3D machine-init-remove.o

Trying to understand why we have this stub here...

So per commit 07a32d6b962 it is required by the chardev driver.

Marc-Andr=C3=A9, what do you think about extracting chardev_machine_*() to=
=20
chardev/char-sysemu.c and simply add to chardev/Makefile:

chardev-obj-$(CONFIG_SOFTMMU) +=3D char-sysemu.o


>   stub-obj-$(CONFIG_SOFTMMU) +=3D semihost.o
> diff --git a/stubs/machine-init-add.c b/stubs/machine-init-add.c
> new file mode 100644
> index 0000000000..520dcb9801
> --- /dev/null
> +++ b/stubs/machine-init-add.c
> @@ -0,0 +1,7 @@
> +#include "qemu/osdep.h"
> +#include "sysemu/sysemu.h"
> +
> +void qemu_add_machine_init_done_notifier(Notifier *notify)
> +{
> +}
> +
> diff --git a/stubs/machine-init-done.c b/stubs/machine-init-done.c
> index cd8e81392d..a34d838f7a 100644
> --- a/stubs/machine-init-done.c
> +++ b/stubs/machine-init-done.c
> @@ -3,6 +3,5 @@
>  =20
>   bool machine_init_done =3D true;
>  =20
> -void qemu_add_machine_init_done_notifier(Notifier *notify)
> -{
> -}
> +NotifierList machine_init_done_notifiers =3D
> +    NOTIFIER_LIST_INITIALIZER(machine_init_done_notifiers);
> diff --git a/stubs/machine-init-remove.c b/stubs/machine-init-remove.c
> new file mode 100644
> index 0000000000..30aee27c2d
> --- /dev/null
> +++ b/stubs/machine-init-remove.c
> @@ -0,0 +1,8 @@
> +#include "qemu/osdep.h"
> +#include "sysemu/sysemu.h"
> +
> +void qemu_remove_machine_init_done_notifier(Notifier *notify)
> +{
> +}
> +
> +
> diff --git a/util/machine-notify.c b/util/machine-notify.c
> new file mode 100644
> index 0000000000..718af79335
> --- /dev/null
> +++ b/util/machine-notify.c
> @@ -0,0 +1,69 @@
> +/*
> + * Machine notifiers.
> + *
> + * Copyright (c) 2003-2008 Fabrice Bellard
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
> +#include "qemu/osdep.h"
> +#include "qemu/notify.h"
> +#include "sysemu/sysemu.h"
> +
> +static NotifierList machine_init_done_notifiers =3D
> +    NOTIFIER_LIST_INITIALIZER(machine_init_done_notifiers);
> +
> +static NotifierList exit_notifiers =3D
> +    NOTIFIER_LIST_INITIALIZER(exit_notifiers);
> +
> +bool machine_init_done;
> +
> +void qemu_add_machine_init_done_notifier(Notifier *notify)
> +{
> +    notifier_list_add(&machine_init_done_notifiers, notify);
> +    if (machine_init_done) {
> +        notify->notify(notify, NULL);
> +    }
> +}
> +
> +void qemu_remove_machine_init_done_notifier(Notifier *notify)
> +{
> +    notifier_remove(notify);
> +}
> +
> +void qemu_run_machine_init_done_notifiers(void)
> +{
> +    machine_init_done =3D true;
> +    notifier_list_notify(&machine_init_done_notifiers, NULL);
> +}
> +
> +void qemu_add_exit_notifier(Notifier *notify)
> +{
> +    notifier_list_add(&exit_notifiers, notify);
> +}
> +
> +void qemu_remove_exit_notifier(Notifier *notify)
> +{
> +    notifier_remove(notify);
> +}
> +
> +void qemu_run_exit_notifiers(void)
> +{
> +    notifier_list_notify(&exit_notifiers, NULL);
> +}
>=20


