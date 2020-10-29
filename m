Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235B8C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:09:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ED19207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WB+PYEkW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED19207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY8cG-0004Pr-CE
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 10:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kY8bh-0003zV-V2
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:08:49 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:38295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kY8be-0003gK-ES
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:08:49 -0400
Received: by mail-pg1-x529.google.com with SMTP id i26so2428535pgl.5
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 07:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=q2MNfLLOvGSiR27wC1b0zTVnWPoUAVs/SfFA+W3Ts88=;
 b=WB+PYEkWXdG48wwSIoaGnPWkAZX1/9OvBGvLL9m+v032LC+qK5ztkJvqgfguuxQ+58
 fxZT3StD9B17ssBNtKl1SkOCA6ysqWw75Kq6rovewTqQksXm2U/gzhupo1PngcxEafWT
 eFPCUhuw1aN56fhQhkGORdsMpIlg7Qodhkj4+61gTH3GOLT7Fo7b44WV7KtIZ3XAe84n
 t0cR4Md0Xo7xHM6t0FHHqFFUY7gQBn8L3yJQreC+XN7nDdRPKbY5BXV8mEh5XhorUaK7
 HENuKdk8FfIxI8irEWtha3SaWkOmSVIA6jGn75KB1gKrCk+CFgTRazzeMblIbZrW/5Cw
 bNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=q2MNfLLOvGSiR27wC1b0zTVnWPoUAVs/SfFA+W3Ts88=;
 b=ed6OBXCVkRZwhna8422kP5Eb2euxbuzN/rRegJ9b5jarLYKt/v+bEpxKHFieqnBigz
 qksrQt+RauvneIN/b3tItAPEWUDAs92VZGgjAV0q3DatKnyrhtI5WgHdhIFfkQVbUcYA
 Xp5JCvSuXPt4BdaHwDCYNWzd0X0Dslp7cmU6XD0p4aaxtG1GPl9gQR24R/gy3hdJnc/f
 WBqqp17c7TQc4wUOsYY71uSLpIXGeUb17vV165i0Ph2bj6wNDNDT8niFlKHsgA9QJBFM
 Zy4lanfhFbA5RNfWVrW0RplMdv6EmXAfMUfava6j4n38eioOFK+27zxPIRKNvMSp+w2N
 gthA==
X-Gm-Message-State: AOAM530WA6UdSvD0KigOs2d6D1E9duhxgjyqg4da0TfgWcexNotwMpql
 irfMmCV9VCl/x42o/OUGXJuQg3pN7tu2aPNMfDs=
X-Google-Smtp-Source: ABdhPJxegpViI8oS2x00XeUCUE019B/VUpLWTzl/IAHAodQznnWdVmCqQOjYzTkkE2YGFV2mrbwS+ILtwkiPTCeAwVo=
X-Received: by 2002:a63:3604:: with SMTP id d4mr4248061pga.121.1603980524560; 
 Thu, 29 Oct 2020 07:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20201027151400.GA138065@stefanha-x1.localdomain>
 <CAJSP0QWrmNN1Ci-M-4WDFZBOGHyeZvF71utg0w2ajCbOLtynJw@mail.gmail.com>
 <c4e5b631-1607-a0ec-ee88-6c5a9493e3de@redhat.com>
In-Reply-To: <c4e5b631-1607-a0ec-ee88-6c5a9493e3de@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 29 Oct 2020 14:08:32 +0000
Message-ID: <CAJSP0QUm_T-tq3zCJauoDLwcNiiTkysqoVGcAddv+3Fe-G9hHQ@mail.gmail.com>
Subject: Re: Out-of-Process Device Emulation session at KVM Forum 2020
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=stefanha@gmail.com; helo=mail-pg1-x529.google.com
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
 John G Johnson <john.g.johnson@oracle.com>,
 "mst@redhat.com" <mtsirkin@redhat.com>,
 Janosch Frank <frankja@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>,
 Kirti Wankhede <kwankhede@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Yan Vugenfirer <yan@daynix.com>, Jag Raman <jag.raman@oracle.com>,
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
 Darren Kenny <darren.kenny@oracle.com>, Liran Alon <liran.alon@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
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

On Thu, Oct 29, 2020 at 1:03 PM Jason Wang <jasowang@redhat.com> wrote:
> On 2020/10/29 =E4=B8=8B=E5=8D=888:08, Stefan Hajnoczi wrote:
> > Here are notes from the session:
> >
> > protocol stability:
> >      * vhost-user already exists for existing third-party applications
> >      * vfio-user is more general but will take more time to develop
> >      * libvfio-user can be provided to allow device implementations
> >
> > management:
> >      * Should QEMU launch device emulation processes?
> >          * Nicer user experience
> >          * Technical blockers: forking, hotplug, security is hard once
> > QEMU has started running
> >          * Probably requires a new process model with a long-running
> > QEMU management process proxying QMP requests to the emulator process
> >
> > migration:
> >      * dbus-vmstate
> >      * VFIO live migration ioctls
> >          * Source device can continue if migration fails
> >          * Opaque blobs are transferred to destination, destination can
> > fail migration if it decides the blobs are incompatible
>
>
> I'm not sure this can work:
>
> 1) Reading something that is opaque to userspace is probably a hint of
> bad uAPI design
> 2) Did qemu even try to migrate opaque blobs before? It's probably a bad
> design of migration protocol as well.
>
> It looks to me have a migration driver in qemu that can clearly define
> each byte in the migration stream is a better approach.

Here is the kernel patch series if you want to review it:
https://lore.kernel.org/kvm/20191203110412.055c38df@x1.home/t/

There is also a QEMU patch series:
https://patchwork.kernel.org/project/qemu-devel/cover/1566845753-18993-1-gi=
t-send-email-kwankhede@nvidia.com/

Kirti is also on the CC list if you want to discuss specific questions.

Stefan

