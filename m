Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67671C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 23:42:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CC1321721
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 23:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sTf5xvEd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC1321721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36160 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbCsR-0002U8-Va
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 19:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38786)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liq3ea@gmail.com>) id 1hbCrM-0001w1-H0
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 19:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1hbCrH-00013C-OM
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 19:40:52 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45764)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hbCrF-00011z-NF
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 19:40:46 -0400
Received: by mail-ot1-x344.google.com with SMTP id x21so6271910otq.12
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 16:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ng23KiNsQCR/NYmRDgR/2eAepNRevSs1OdYZayUTHRA=;
 b=sTf5xvEdSOm9Tugr2B3a5IgVnH8xEcigAQ6mJdtmAeKBk1BNbecDwAeVcrWKlgUEE8
 bEzUb6qqe82cjbz6s4/CaxEvHx9KSxv4Lp0BebiQHTgAHE9f7wvOyzeyMSCaRAd/Ds91
 MuV61OYeweLKlVmZdS+xUfU1WD9a8ubF7bL1jWgkG8QFbULzUHNabB5PFdKnPSCisrRS
 VY1lTW7a0Qd2SUsDWwEcNTb+tiUn8DEq0SmgMzmFmtgLmd7FKDVj9ctTTEyqL8Z8vSWK
 NFChGo5LTuAK5W2hdgMnU28ynsanRBSDmRFqxvIQ1euF3/UNaOXw59rMuBioyc53CxhG
 lHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ng23KiNsQCR/NYmRDgR/2eAepNRevSs1OdYZayUTHRA=;
 b=AqfOUxkiHBZ7wUdX5+5QAP/EEfCZQQJkWScdD7IVZhZ5UiAJsBzjJeqsErsu9hjJls
 p0h5Y0hswt6yWz7cZvwo1EyEly2MndwcL+lCW+9j4da6PVdPIqpQ6gE8XPh13H5SjpNx
 7rx4yPEERlVxCXIDfkgsopIwlGBGpvblnQ+4sMy/euIkg/d7eD0YtnAY7fi6HuFjY90P
 vy8wxzhniUY3fd9pQF7rgHg7HJmlTj2KsZsc2dwuH7CXi3r4mSw0hQEASxeDJTQplQ9b
 8mldVBduipuNGZtDCTL1RF4TtCV9cCFoxBqkvVG8XDGz+W97g9mPKuPX28c1s/U7srFK
 zsCw==
X-Gm-Message-State: APjAAAX3M3a3Pz/c2yYK5RHGkG88PE2ZD3xW1cppOkKj1LYAChRbV1Ga
 xewZZq7HVXuDlOmTAtq2Du/kCIt3KUczaCbAg64=
X-Google-Smtp-Source: APXvYqwJQBhyYkr+CD5r2CLSzV43QHYHas5cAfBQ3PSEKIisNdT2Eda5d+nMt48RD2MrP6VsV4CExRzEB3FKm6Qksmc=
X-Received: by 2002:a05:6830:1141:: with SMTP id
 x1mr15400873otq.333.1560382844267; 
 Wed, 12 Jun 2019 16:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190612124004.27336-1-eric.auger@redhat.com>
In-Reply-To: <20190612124004.27336-1-eric.auger@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 13 Jun 2019 07:40:07 +0800
Message-ID: <CAKXe6SLO5G1kuurxYVQNnYDnqZJC1=nDfWTrK4LNMjMZO=_mdA@mail.gmail.com>
To: Eric Auger <eric.auger@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v5] vfio/common: Introduce
 vfio_set_irq_signaling helper
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
Cc: Alex Williamson <alex.williamson@redhat.com>, cohuck@redhat.com,
 Qemu Developers <qemu-devel@nongnu.org>, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Auger <eric.auger@redhat.com> =E4=BA=8E2019=E5=B9=B46=E6=9C=8812=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=888:40=E5=86=99=E9=81=93=EF=BC=9A

> The code used to assign an interrupt index/subindex to an
> eventfd is duplicated many times. Let's introduce an helper that
> allows to set/unset the signaling for an ACTION_TRIGGER,
> ACTION_MASK or ACTION_UNMASK action.
>
> In the error message, we now use errno in case of any
> VFIO_DEVICE_SET_IRQS ioctl failure.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
>

Reviewed-by: Li Qiang <liq3ea@gmail.com>



> ---
>
> v4 -> v5:
> - output errno instead of ioctl returned value. Issue
>   reported by Li
> - vfio_set_irq_signaling now returns -errno in case
>   of failure
> - update the commit message
>
> v3 -> v4:
> - renamed irq_to_str into index_to_str
> - avoid usage of g_strdup_printf
> - print both the index and subindex in generic case
>
> v2 -> v3:
> - irq_to_str() simply outputs the IRQ index if the VFIO device is
>   not of PCI type
> - removed "vfio: failed to start eventfd signaling ../.." in vfio_platfor=
m
>
> v1 -> v2:
> - don't call GET_IRQ_INFO in vfio_set_irq_signaling()
>   and restore quiet check in vfio_register_req_notifier.
>   Nicer display of the IRQ name.
>
> This is a follow-up to
> [PATCH v2 0/2] vfio-pci: Introduce vfio_set_event_handler().
> It looks to me that introducing vfio_set_irq_signaling() has more
> benefits in term of code reduction and the helper abstraction
> looks cleaner.
> ---
>  hw/vfio/common.c              |  78 ++++++++++++
>  hw/vfio/pci.c                 | 217 ++++++++--------------------------
>  hw/vfio/platform.c            |  62 ++++------
>  include/hw/vfio/vfio-common.h |   2 +
>  4 files changed, 151 insertions(+), 208 deletions(-)
>
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 4374cc6176..a859298fda 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -95,6 +95,84 @@ void vfio_mask_single_irqindex(VFIODevice *vbasedev,
> int index)
>      ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
>  }
>
> +static inline const char *action_to_str(int action)
> +{
> +    switch (action) {
> +    case VFIO_IRQ_SET_ACTION_MASK:
> +        return "MASK";
> +    case VFIO_IRQ_SET_ACTION_UNMASK:
> +        return "UNMASK";
> +    case VFIO_IRQ_SET_ACTION_TRIGGER:
> +        return "TRIGGER";
> +    default:
> +        return "UNKNOWN ACTION";
> +    }
> +}
> +
> +static const char *index_to_str(VFIODevice *vbasedev, int index)
> +{
> +    if (vbasedev->type !=3D VFIO_DEVICE_TYPE_PCI) {
> +        return NULL;
> +    }
> +
> +    switch (index) {
> +    case VFIO_PCI_INTX_IRQ_INDEX:
> +        return "INTX";
> +    case VFIO_PCI_MSI_IRQ_INDEX:
> +        return "MSI";
> +    case VFIO_PCI_MSIX_IRQ_INDEX:
> +        return "MSIX";
> +    case VFIO_PCI_ERR_IRQ_INDEX:
> +        return "ERR";
> +    case VFIO_PCI_REQ_IRQ_INDEX:
> +        return "REQ";
> +    default:
> +        return NULL;
> +    }
> +}
> +
> +int vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex=
,
> +                           int action, int fd, Error **errp)
> +{
> +    struct vfio_irq_set *irq_set;
> +    int argsz, ret =3D 0;
> +    const char *name;
> +    int32_t *pfd;
> +
> +    argsz =3D sizeof(*irq_set) + sizeof(*pfd);
> +
> +    irq_set =3D g_malloc0(argsz);
> +    irq_set->argsz =3D argsz;
> +    irq_set->flags =3D VFIO_IRQ_SET_DATA_EVENTFD | action;
> +    irq_set->index =3D index;
> +    irq_set->start =3D subindex;
> +    irq_set->count =3D 1;
> +    pfd =3D (int32_t *)&irq_set->data;
> +    *pfd =3D fd;
> +
> +    if (ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
> +        ret =3D -errno;
> +    }
> +    g_free(irq_set);
> +
> +    if (!ret) {
> +        return 0;
> +    }
> +
> +    error_setg_errno(errp, -ret, "VFIO_DEVICE_SET_IRQS failure");
> +
> +    name =3D index_to_str(vbasedev, index);
> +    if (name) {
> +        error_prepend(errp, "%s-%d: ", name, subindex);
> +    } else {
> +        error_prepend(errp, "index %d-%d: ", index, subindex);
> +    }
> +    error_prepend(errp,
> +                  "Failed to %s %s eventfd signaling for interrupt ",
> +                  fd < 0 ? "tear down" : "set up", action_to_str(action)=
);
> +    return ret;
> +}
> +
>  /*
>   * IO Port/MMIO - Beware of the endians, VFIO is always little endian
>   */
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 2a4091d216..65c2e17028 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -113,9 +113,7 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev,
> Error **errp)
>          .gsi =3D vdev->intx.route.irq,
>          .flags =3D KVM_IRQFD_FLAG_RESAMPLE,
>      };
> -    struct vfio_irq_set *irq_set;
> -    int ret, argsz;
> -    int32_t *pfd;
> +    Error *err =3D NULL;
>
>      if (vdev->no_kvm_intx || !kvm_irqfds_enabled() ||
>          vdev->intx.route.mode !=3D PCI_INTX_ENABLED ||
> @@ -143,22 +141,10 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice
> *vdev, Error **errp)
>          goto fail_irqfd;
>      }
>
> -    argsz =3D sizeof(*irq_set) + sizeof(*pfd);
> -
> -    irq_set =3D g_malloc0(argsz);
> -    irq_set->argsz =3D argsz;
> -    irq_set->flags =3D VFIO_IRQ_SET_DATA_EVENTFD |
> VFIO_IRQ_SET_ACTION_UNMASK;
> -    irq_set->index =3D VFIO_PCI_INTX_IRQ_INDEX;
> -    irq_set->start =3D 0;
> -    irq_set->count =3D 1;
> -    pfd =3D (int32_t *)&irq_set->data;
> -
> -    *pfd =3D irqfd.resamplefd;
> -
> -    ret =3D ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
> -    g_free(irq_set);
> -    if (ret) {
> -        error_setg_errno(errp, -ret, "failed to setup INTx unmask fd");
> +    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX,
> 0,
> +                               VFIO_IRQ_SET_ACTION_UNMASK,
> +                               irqfd.resamplefd, &err)) {
> +        error_propagate(errp, err);
>          goto fail_vfio;
>      }
>
> @@ -262,10 +248,10 @@ static void vfio_intx_update(PCIDevice *pdev)
>  static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>  {
>      uint8_t pin =3D vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN,=
 1);
> -    int ret, argsz, retval =3D 0;
> -    struct vfio_irq_set *irq_set;
> -    int32_t *pfd;
>      Error *err =3D NULL;
> +    int32_t fd;
> +    int ret;
> +
>
>      if (!pin) {
>          return 0;
> @@ -292,27 +278,15 @@ static int vfio_intx_enable(VFIOPCIDevice *vdev,
> Error **errp)
>          error_setg_errno(errp, -ret, "event_notifier_init failed");
>          return ret;
>      }
> +    fd =3D event_notifier_get_fd(&vdev->intx.interrupt);
> +    qemu_set_fd_handler(fd, vfio_intx_interrupt, NULL, vdev);
>
> -    argsz =3D sizeof(*irq_set) + sizeof(*pfd);
> -
> -    irq_set =3D g_malloc0(argsz);
> -    irq_set->argsz =3D argsz;
> -    irq_set->flags =3D VFIO_IRQ_SET_DATA_EVENTFD |
> VFIO_IRQ_SET_ACTION_TRIGGER;
> -    irq_set->index =3D VFIO_PCI_INTX_IRQ_INDEX;
> -    irq_set->start =3D 0;
> -    irq_set->count =3D 1;
> -    pfd =3D (int32_t *)&irq_set->data;
> -
> -    *pfd =3D event_notifier_get_fd(&vdev->intx.interrupt);
> -    qemu_set_fd_handler(*pfd, vfio_intx_interrupt, NULL, vdev);
> -
> -    ret =3D ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
> -    if (ret) {
> -        error_setg_errno(errp, -ret, "failed to setup INTx fd");
> -        qemu_set_fd_handler(*pfd, NULL, NULL, vdev);
> +    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX,
> 0,
> +                               VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
> +        error_propagate(errp, err);
> +        qemu_set_fd_handler(fd, NULL, NULL, vdev);
>          event_notifier_cleanup(&vdev->intx.interrupt);
> -        retval =3D -errno;
> -        goto cleanup;
> +        return -errno;
>      }
>
>      vfio_intx_enable_kvm(vdev, &err);
> @@ -323,11 +297,7 @@ static int vfio_intx_enable(VFIOPCIDevice *vdev,
> Error **errp)
>      vdev->interrupt =3D VFIO_INT_INTx;
>
>      trace_vfio_intx_enable(vdev->vbasedev.name);
> -
> -cleanup:
> -    g_free(irq_set);
> -
> -    return retval;
> +    return 0;
>  }
>
>  static void vfio_intx_disable(VFIOPCIDevice *vdev)
> @@ -530,31 +500,19 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev,
> unsigned int nr,
>              error_report("vfio: failed to enable vectors, %d", ret);
>          }
>      } else {
> -        int argsz;
> -        struct vfio_irq_set *irq_set;
> -        int32_t *pfd;
> -
> -        argsz =3D sizeof(*irq_set) + sizeof(*pfd);
> -
> -        irq_set =3D g_malloc0(argsz);
> -        irq_set->argsz =3D argsz;
> -        irq_set->flags =3D VFIO_IRQ_SET_DATA_EVENTFD |
> -                         VFIO_IRQ_SET_ACTION_TRIGGER;
> -        irq_set->index =3D VFIO_PCI_MSIX_IRQ_INDEX;
> -        irq_set->start =3D nr;
> -        irq_set->count =3D 1;
> -        pfd =3D (int32_t *)&irq_set->data;
> +        Error *err =3D NULL;
> +        int32_t fd;
>
>          if (vector->virq >=3D 0) {
> -            *pfd =3D event_notifier_get_fd(&vector->kvm_interrupt);
> +            fd =3D event_notifier_get_fd(&vector->kvm_interrupt);
>          } else {
> -            *pfd =3D event_notifier_get_fd(&vector->interrupt);
> +            fd =3D event_notifier_get_fd(&vector->interrupt);
>          }
>
> -        ret =3D ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
> -        g_free(irq_set);
> -        if (ret) {
> -            error_report("vfio: failed to modify vector, %d", ret);
> +        if (vfio_set_irq_signaling(&vdev->vbasedev,
> +                                     VFIO_PCI_MSIX_IRQ_INDEX, nr,
> +                                     VFIO_IRQ_SET_ACTION_TRIGGER, fd,
> &err)) {
> +            error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name)=
;
>          }
>      }
>
> @@ -591,26 +549,10 @@ static void vfio_msix_vector_release(PCIDevice
> *pdev, unsigned int nr)
>       * be re-asserted on unmask.  Nothing to do if already using QEMU
> mode.
>       */
>      if (vector->virq >=3D 0) {
> -        int argsz;
> -        struct vfio_irq_set *irq_set;
> -        int32_t *pfd;
> +        int32_t fd =3D event_notifier_get_fd(&vector->interrupt);
>
> -        argsz =3D sizeof(*irq_set) + sizeof(*pfd);
> -
> -        irq_set =3D g_malloc0(argsz);
> -        irq_set->argsz =3D argsz;
> -        irq_set->flags =3D VFIO_IRQ_SET_DATA_EVENTFD |
> -                         VFIO_IRQ_SET_ACTION_TRIGGER;
> -        irq_set->index =3D VFIO_PCI_MSIX_IRQ_INDEX;
> -        irq_set->start =3D nr;
> -        irq_set->count =3D 1;
> -        pfd =3D (int32_t *)&irq_set->data;
> -
> -        *pfd =3D event_notifier_get_fd(&vector->interrupt);
> -
> -        ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
> -
> -        g_free(irq_set);
> +        vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX,
> nr,
> +                               VFIO_IRQ_SET_ACTION_TRIGGER, fd, NULL);
>      }
>  }
>
> @@ -2636,10 +2578,8 @@ static void vfio_err_notifier_handler(void *opaque=
)
>   */
>  static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
>  {
> -    int ret;
> -    int argsz;
> -    struct vfio_irq_set *irq_set;
> -    int32_t *pfd;
> +    Error *err =3D NULL;
> +    int32_t fd;
>
>      if (!vdev->pci_aer) {
>          return;
> @@ -2651,58 +2591,30 @@ static void
> vfio_register_err_notifier(VFIOPCIDevice *vdev)
>          return;
>      }
>
> -    argsz =3D sizeof(*irq_set) + sizeof(*pfd);
> +    fd =3D event_notifier_get_fd(&vdev->err_notifier);
> +    qemu_set_fd_handler(fd, vfio_err_notifier_handler, NULL, vdev);
>
> -    irq_set =3D g_malloc0(argsz);
> -    irq_set->argsz =3D argsz;
> -    irq_set->flags =3D VFIO_IRQ_SET_DATA_EVENTFD |
> -                     VFIO_IRQ_SET_ACTION_TRIGGER;
> -    irq_set->index =3D VFIO_PCI_ERR_IRQ_INDEX;
> -    irq_set->start =3D 0;
> -    irq_set->count =3D 1;
> -    pfd =3D (int32_t *)&irq_set->data;
> -
> -    *pfd =3D event_notifier_get_fd(&vdev->err_notifier);
> -    qemu_set_fd_handler(*pfd, vfio_err_notifier_handler, NULL, vdev);
> -
> -    ret =3D ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
> -    if (ret) {
> -        error_report("vfio: Failed to set up error notification");
> -        qemu_set_fd_handler(*pfd, NULL, NULL, vdev);
> +    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, =
0,
> +                               VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
> +        error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> +        qemu_set_fd_handler(fd, NULL, NULL, vdev);
>          event_notifier_cleanup(&vdev->err_notifier);
>          vdev->pci_aer =3D false;
>      }
> -    g_free(irq_set);
>  }
>
>  static void vfio_unregister_err_notifier(VFIOPCIDevice *vdev)
>  {
> -    int argsz;
> -    struct vfio_irq_set *irq_set;
> -    int32_t *pfd;
> -    int ret;
> +    Error *err =3D NULL;
>
>      if (!vdev->pci_aer) {
>          return;
>      }
>
> -    argsz =3D sizeof(*irq_set) + sizeof(*pfd);
> -
> -    irq_set =3D g_malloc0(argsz);
> -    irq_set->argsz =3D argsz;
> -    irq_set->flags =3D VFIO_IRQ_SET_DATA_EVENTFD |
> -                     VFIO_IRQ_SET_ACTION_TRIGGER;
> -    irq_set->index =3D VFIO_PCI_ERR_IRQ_INDEX;
> -    irq_set->start =3D 0;
> -    irq_set->count =3D 1;
> -    pfd =3D (int32_t *)&irq_set->data;
> -    *pfd =3D -1;
> -
> -    ret =3D ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
> -    if (ret) {
> -        error_report("vfio: Failed to de-assign error fd: %m");
> +    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, =
0,
> +                               VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
> +        error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>      }
> -    g_free(irq_set);
>      qemu_set_fd_handler(event_notifier_get_fd(&vdev->err_notifier),
>                          NULL, NULL, vdev);
>      event_notifier_cleanup(&vdev->err_notifier);
> @@ -2727,9 +2639,8 @@ static void vfio_register_req_notifier(VFIOPCIDevic=
e
> *vdev)
>  {
>      struct vfio_irq_info irq_info =3D { .argsz =3D sizeof(irq_info),
>                                        .index =3D VFIO_PCI_REQ_IRQ_INDEX =
};
> -    int argsz;
> -    struct vfio_irq_set *irq_set;
> -    int32_t *pfd;
> +    Error *err =3D NULL;
> +    int32_t fd;
>
>      if (!(vdev->features & VFIO_FEATURE_ENABLE_REQ)) {
>          return;
> @@ -2745,57 +2656,31 @@ static void
> vfio_register_req_notifier(VFIOPCIDevice *vdev)
>          return;
>      }
>
> -    argsz =3D sizeof(*irq_set) + sizeof(*pfd);
> +    fd =3D event_notifier_get_fd(&vdev->req_notifier);
> +    qemu_set_fd_handler(fd, vfio_req_notifier_handler, NULL, vdev);
>
> -    irq_set =3D g_malloc0(argsz);
> -    irq_set->argsz =3D argsz;
> -    irq_set->flags =3D VFIO_IRQ_SET_DATA_EVENTFD |
> -                     VFIO_IRQ_SET_ACTION_TRIGGER;
> -    irq_set->index =3D VFIO_PCI_REQ_IRQ_INDEX;
> -    irq_set->start =3D 0;
> -    irq_set->count =3D 1;
> -    pfd =3D (int32_t *)&irq_set->data;
> -
> -    *pfd =3D event_notifier_get_fd(&vdev->req_notifier);
> -    qemu_set_fd_handler(*pfd, vfio_req_notifier_handler, NULL, vdev);
> -
> -    if (ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
> -        error_report("vfio: Failed to set up device request
> notification");
> -        qemu_set_fd_handler(*pfd, NULL, NULL, vdev);
> +    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, =
0,
> +                           VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
> +        error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> +        qemu_set_fd_handler(fd, NULL, NULL, vdev);
>          event_notifier_cleanup(&vdev->req_notifier);
>      } else {
>          vdev->req_enabled =3D true;
>      }
> -
> -    g_free(irq_set);
>  }
>
>  static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
>  {
> -    int argsz;
> -    struct vfio_irq_set *irq_set;
> -    int32_t *pfd;
> +    Error *err =3D NULL;
>
>      if (!vdev->req_enabled) {
>          return;
>      }
>
> -    argsz =3D sizeof(*irq_set) + sizeof(*pfd);
> -
> -    irq_set =3D g_malloc0(argsz);
> -    irq_set->argsz =3D argsz;
> -    irq_set->flags =3D VFIO_IRQ_SET_DATA_EVENTFD |
> -                     VFIO_IRQ_SET_ACTION_TRIGGER;
> -    irq_set->index =3D VFIO_PCI_REQ_IRQ_INDEX;
> -    irq_set->start =3D 0;
> -    irq_set->count =3D 1;
> -    pfd =3D (int32_t *)&irq_set->data;
> -    *pfd =3D -1;
> -
> -    if (ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
> -        error_report("vfio: Failed to de-assign device request fd: %m");
> +    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, =
0,
> +                               VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
> +        error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>      }
> -    g_free(irq_set);
>      qemu_set_fd_handler(event_notifier_get_fd(&vdev->req_notifier),
>                          NULL, NULL, vdev);
>      event_notifier_cleanup(&vdev->req_notifier);
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index d52d6552e0..8d6012857e 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -106,26 +106,19 @@ static int vfio_set_trigger_eventfd(VFIOINTp *intp,
>                                      eventfd_user_side_handler_t handler)
>  {
>      VFIODevice *vbasedev =3D &intp->vdev->vbasedev;
> -    struct vfio_irq_set *irq_set;
> -    int argsz, ret;
> -    int32_t *pfd;
> +    int32_t fd =3D event_notifier_get_fd(intp->interrupt);
> +    Error *err =3D NULL;
> +    int ret;
>
> -    argsz =3D sizeof(*irq_set) + sizeof(*pfd);
> -    irq_set =3D g_malloc0(argsz);
> -    irq_set->argsz =3D argsz;
> -    irq_set->flags =3D VFIO_IRQ_SET_DATA_EVENTFD |
> VFIO_IRQ_SET_ACTION_TRIGGER;
> -    irq_set->index =3D intp->pin;
> -    irq_set->start =3D 0;
> -    irq_set->count =3D 1;
> -    pfd =3D (int32_t *)&irq_set->data;
> -    *pfd =3D event_notifier_get_fd(intp->interrupt);
> -    qemu_set_fd_handler(*pfd, (IOHandler *)handler, NULL, intp);
> -    ret =3D ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set);
> -    if (ret < 0) {
> -        error_report("vfio: Failed to set trigger eventfd: %m");
> -        qemu_set_fd_handler(*pfd, NULL, NULL, NULL);
> +    qemu_set_fd_handler(fd, (IOHandler *)handler, NULL, intp);
> +
> +    ret =3D vfio_set_irq_signaling(vbasedev, intp->pin, 0,
> +                                 VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err);
> +    if (ret) {
> +        error_reportf_err(err, VFIO_MSG_PREFIX, vbasedev->name);
> +        qemu_set_fd_handler(fd, NULL, NULL, NULL);
>      }
> -    g_free(irq_set);
> +
>      return ret;
>  }
>
> @@ -330,7 +323,6 @@ static void vfio_platform_eoi(VFIODevice *vbasedev)
>
>  static void vfio_start_eventfd_injection(SysBusDevice *sbdev, qemu_irq
> irq)
>  {
> -    int ret;
>      VFIOPlatformDevice *vdev =3D VFIO_PLATFORM_DEVICE(sbdev);
>      VFIOINTp *intp;
>
> @@ -341,10 +333,7 @@ static void vfio_start_eventfd_injection(SysBusDevic=
e
> *sbdev, qemu_irq irq)
>      }
>      assert(intp);
>
> -    ret =3D vfio_set_trigger_eventfd(intp, vfio_intp_interrupt);
> -    if (ret) {
> -        error_report("vfio: failed to start eventfd signaling for IRQ %d=
:
> %m",
> -                     intp->pin);
> +    if (vfio_set_trigger_eventfd(intp, vfio_intp_interrupt)) {
>          abort();
>      }
>  }
> @@ -361,25 +350,16 @@ static void
> vfio_start_eventfd_injection(SysBusDevice *sbdev, qemu_irq irq)
>   */
>  static int vfio_set_resample_eventfd(VFIOINTp *intp)
>  {
> +    int32_t fd =3D event_notifier_get_fd(intp->unmask);
>      VFIODevice *vbasedev =3D &intp->vdev->vbasedev;
> -    struct vfio_irq_set *irq_set;
> -    int argsz, ret;
> -    int32_t *pfd;
> +    Error *err =3D NULL;
> +    int ret;
>
> -    argsz =3D sizeof(*irq_set) + sizeof(*pfd);
> -    irq_set =3D g_malloc0(argsz);
> -    irq_set->argsz =3D argsz;
> -    irq_set->flags =3D VFIO_IRQ_SET_DATA_EVENTFD |
> VFIO_IRQ_SET_ACTION_UNMASK;
> -    irq_set->index =3D intp->pin;
> -    irq_set->start =3D 0;
> -    irq_set->count =3D 1;
> -    pfd =3D (int32_t *)&irq_set->data;
> -    *pfd =3D event_notifier_get_fd(intp->unmask);
> -    qemu_set_fd_handler(*pfd, NULL, NULL, NULL);
> -    ret =3D ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set);
> -    g_free(irq_set);
> -    if (ret < 0) {
> -        error_report("vfio: Failed to set resample eventfd: %m");
> +    qemu_set_fd_handler(fd, NULL, NULL, NULL);
> +    ret =3D vfio_set_irq_signaling(vbasedev, intp->pin, 0,
> +                                 VFIO_IRQ_SET_ACTION_UNMASK, fd, &err);
> +    if (ret) {
> +        error_reportf_err(err, VFIO_MSG_PREFIX, vbasedev->name);
>      }
>      return ret;
>  }
> @@ -435,8 +415,6 @@ static void vfio_start_irqfd_injection(SysBusDevice
> *sbdev, qemu_irq irq)
>      return;
>  fail_vfio:
>      kvm_irqchip_remove_irqfd_notifier(kvm_state, intp->interrupt, irq);
> -    error_report("vfio: failed to start eventfd signaling for IRQ %d: %m=
",
> -                 intp->pin);
>      abort();
>  fail_irqfd:
>      vfio_start_eventfd_injection(sbdev, irq);
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.=
h
> index 1155b79678..686d99ff8c 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -167,6 +167,8 @@ void vfio_put_base_device(VFIODevice *vbasedev);
>  void vfio_disable_irqindex(VFIODevice *vbasedev, int index);
>  void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index);
>  void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index);
> +int vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex=
,
> +                           int action, int fd, Error **errp);
>  void vfio_region_write(void *opaque, hwaddr addr,
>                             uint64_t data, unsigned size);
>  uint64_t vfio_region_read(void *opaque,
> --
> 2.20.1
>
>
