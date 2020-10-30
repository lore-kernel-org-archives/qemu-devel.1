Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61190C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 11:14:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 668C120731
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 11:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gy5FV1SY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 668C120731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYSMu-0008Tw-5E
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 07:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kYSMK-00083N-MZ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 07:14:16 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:37917)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kYSMI-0001iY-Mh
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 07:14:16 -0400
Received: by mail-pg1-x535.google.com with SMTP id i26so4913354pgl.5
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 04:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=j1d1CoRoZp+YFn6KbhrTA9FkVkiJ2Qh3kKL5TL6xCVo=;
 b=gy5FV1SYBJhWBWpLJduRk8HU1Ikcnb2G8O0BUczW6pkbM+oRZEe9MTKz9VWnFOhrre
 rikF64RyyrWEV5aWtbqwT2NiYZBHX2Br0XdTLgE69n4DO43Lgj9tofAM+TAm+TaDXizl
 mEdHLd6ho1k0rTyeyTEFi8iu36bBppBi+VduMObXBo0ftIs9BUfaMRRzvbb/smVAQ1MZ
 tsmwlr42D8k0S3b5DDBuDaAh10oP9PL1XirGUWdPzakup1hiLzbZPkJjS9Y+e8NHqmd8
 qPdmQEKWv+MHtvjdZ2f94feWKquZ2SHFpasDICpx2I3qKUInc2kRW4yd5D+bt7aBXNDr
 xuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=j1d1CoRoZp+YFn6KbhrTA9FkVkiJ2Qh3kKL5TL6xCVo=;
 b=el/H7Ld/sFNxB8NjgxLXvHmKsaAm+h7KwBhZ6sOl5t34gILFYEFqnfyvT6eXWYI6NT
 9o1oaZzvvt5ija4a2ExGdhqHunLgzJWeuTW6EUhepeCec+CpO17TaADV+6A4RdSSEXyM
 35jMMFzGNXEi4L2hGShwUhCqDiDaAj/L+tD6D3xVtRxxwK6U3vuBWSm7ig2PDK7QYWJB
 X7NdyS2+AjDNPtkjY64XrmTG18L8S3Hb2/q+93nZLDAV3BcWH9dgecg7Ewp9cg/bVJYt
 F2GOisU44nq+A3mY0/GlEN/s29EGNcW3mlRMq4AIKH+JnrqcvpcRY5ICACdi+jPaTsQc
 20dw==
X-Gm-Message-State: AOAM531+iNDp3oxTx6RaFLdF826C0ogcy6xna6nPble4LWxo4XSzp79+
 iM6J/9ZWq7o1u+h+1vSWSvI4PeDvUk9UZNQtpj0=
X-Google-Smtp-Source: ABdhPJx+FeXIo2DRfcD1YXB9PA0jYjvBQL/zOgnctOIIAbfamTYxofq4NlAqern9riD8Ura6lmtW1I7bUcYLnhx/awU=
X-Received: by 2002:a17:90b:1392:: with SMTP id
 hr18mr2084457pjb.116.1604056453005; 
 Fri, 30 Oct 2020 04:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20201027151400.GA138065@stefanha-x1.localdomain>
 <CAJSP0QWrmNN1Ci-M-4WDFZBOGHyeZvF71utg0w2ajCbOLtynJw@mail.gmail.com>
 <c4e5b631-1607-a0ec-ee88-6c5a9493e3de@redhat.com>
 <20201029083130.0617a28f@w520.home>
 <b85405de-d525-bf59-826c-737fa7bbdfef@redhat.com>
 <20201029094603.15382476@w520.home>
 <d4f7df42-7b02-6505-c2c7-245bf813b513@redhat.com>
 <20201029210407.33d6f008@x1.home>
 <CAJSP0QVto+xFEnWv-aj=-0mZ72SzfeAvg4q0RCoLGK-N7C-WEw@mail.gmail.com>
 <04179584-3324-994e-d793-04be18d2dab2@redhat.com>
In-Reply-To: <04179584-3324-994e-d793-04be18d2dab2@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 30 Oct 2020 11:13:59 +0000
Message-ID: <CAJSP0QXQmFgtSsJL1B3eMUr8teQc3cvvEFvr7LvnFkJPcE3ZpA@mail.gmail.com>
Subject: Re: Out-of-Process Device Emulation session at KVM Forum 2020
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=stefanha@gmail.com; helo=mail-pg1-x535.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Janosch Frank <frankja@linux.vnet.ibm.com>,
 "mst@redhat.com" <mtsirkin@redhat.com>,
 John G Johnson <john.g.johnson@oracle.com>, qemu-devel <qemu-devel@nongnu.org>,
 Kirti Wankhede <kwankhede@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Yan Vugenfirer <yan@daynix.com>, Jag Raman <jag.raman@oracle.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Anup Patel <anup@brainfault.org>,
 Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Roman Kagan <rkagan@virtuozzo.com>, Felipe Franciosi <felipe@nutanix.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Jens Freimann <jfreimann@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Liran Alon <liran.alon@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Halil Pasic <pasic@linux.vnet.ibm.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, fam <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 30, 2020 at 9:46 AM Jason Wang <jasowang@redhat.com> wrote:
> On 2020/10/30 =E4=B8=8B=E5=8D=882:21, Stefan Hajnoczi wrote:
> > On Fri, Oct 30, 2020 at 3:04 AM Alex Williamson
> > <alex.williamson@redhat.com> wrote:
> >> It's great to revisit ideas, but proclaiming a uAPI is bad solely
> >> because the data transfer is opaque, without defining why that's bad,
> >> evaluating the feasibility and implementation of defining a well
> >> specified data format rather than protocol, including cross-vendor
> >> support, or proposing any sort of alternative is not so helpful imo.
> > The migration approaches in VFIO and vDPA/vhost were designed for
> > different requirements and I think this is why there are different
> > perspectives on this. Here is a comparison and how VFIO could be
> > extended in the future. I see 3 levels of device state compatibility:
> >
> > 1. The device cannot save/load state blobs, instead userspace fetches
> > and restores specific values of the device's runtime state (e.g. last
> > processed ring index). This is the vhost approach.
> >
> > 2. The device can save/load state in a standard format. This is
> > similar to #1 except that there is a single read/write blob interface
> > instead of fine-grained get_FOO()/set_FOO() interfaces. This approach
> > pushes the migration state parsing into the device so that userspace
> > doesn't need knowledge of every device type. With this approach it is
> > possible for a device from vendor A to migrate to a device from vendor
> > B, as long as they both implement the same standard migration format.
> > The limitation of this approach is that vendor-specific state cannot
> > be transferred.
> >
> > 3. The device can save/load opaque blobs. This is the initial VFIO
> > approach.
>
>
> I still don't get why it must be opaque.

If the device state format needs to be in the VMM then each device
needs explicit enablement in each VMM (QEMU, cloud-hypervisor, etc).

Let's invert the question: why does the VMM need to understand the
device state of a _passthrough_ device?

> >   A device from vendor A cannot migrate to a device from
> > vendor B because the format is incompatible. This approach works well
> > when devices have unique guest-visible hardware interfaces so the
> > guest wouldn't be able to handle migrating a device from vendor A to a
> > device from vendor B anyway.
>
>
> For VFIO I guess cross vendor live migration can't succeed unless we do
> some cheats in device/vendor id.

Yes. I haven't looked into the details of PCI (Sub-)Device/Vendor IDs
and how to best enable migration but I hope that can be solved. The
simplest approach is to override the IDs and make them part of the
guest configuration.

> For at least virtio, they will still go with virtio/vDPA. The advantages
> are:
>
> 1) virtio/vDPA can serve kernel subsystems which VFIO can't, this is
> very important for containers

I'm not sure I understand this. If the kernel wants to use the device
then it doesn't use VFIO, it runs the kernel driver instead.

One part I believe is missing from VFIO/mdev is attaching an mdev
device to the kernel. That seems to be an example of the limitation
you mentioned.

> 2) virtio/vDPA is bus independent, we can present a virtio-mmio device
> which is based on vDPA PCI hardware for e.g microvm

Yes. This is neat although microvm supports PCI now
(https://www.kraxel.org/blog/2020/10/qemu-microvm-acpi/).

> I'm not familiar with NVME but they should go with the same way instead
> of depending on VFIO.

There are pros/cons with both approaches. I'm not even sure all VIRTIO
hardware vendors will use vDPA. Two examples:
1. A tiny VMM with strict security requirements. The VFIO approach is
less complex because the VMM is much less involved with the device.
2. A vendor shipping a hardware VIRTIO PCI device as a PF - no SR-IOV,
no software VFs, just a single instance. A passthrough PCI device is a
much simpler way to deliver this device than vDPA + vhost + VMM
support.

vDPA is very useful but there are situations when the VFIO approach is
attractive too.

Stefan

