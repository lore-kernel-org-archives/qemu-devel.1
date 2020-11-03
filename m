Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F8CC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:33:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 881E722370
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQ9JJN/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 881E722370
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZxMv-0001j4-Iq
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 09:33:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kZxGk-0004SN-V2
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:26:47 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:33709)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kZxGf-0003iU-36
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:26:42 -0500
Received: by mail-pg1-x52f.google.com with SMTP id r186so13831649pgr.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 06:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=F5vKb7R8/PLIsbx4F3ty1MXrw6/ffMG3Auf3zGxdajo=;
 b=EQ9JJN/GqjUEFzrAse9pPIAkILAP2eLA9wPXR8uNUDOS6Txyap/ZJVymv1MpUp34PH
 MAxY9NE+Ok+yMpEnskMb3AjeCdM8K+fcUrFhAv3LFGqKZ1j4pphBBid7YCKC5ij7LwcH
 7JGwd7wyIRBD2PbOk4MxALc/63LnPKUbr9iHtXcAc+RnNUmArWx1I5HjEckC7ZDmDbv8
 CRV1GS9fMSp+Zw7Wdd1gKbtOoJ5KbyGwbKwVW+z6+vVP47Q5iAgUfvH12qo3waoby5X3
 gSH8Pq0FL8VsjkBAIDGxXBEBR1tvhNEwrGA81SkdzH6LHyKMaCQDPZ1VTvakis+eTDsc
 xi7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=F5vKb7R8/PLIsbx4F3ty1MXrw6/ffMG3Auf3zGxdajo=;
 b=Y1PzN5v/YHC0r8U5zDd6cd0sPlgGdf+/zX9gWRWThGMEqian2beLHf4waZVowH1k7j
 2YRvwO6SlEfYuCpXCV4xN4hQRFzvuzrRPFnVpC/O1kSQtMJoKNq1vD2rpBbFBMTReOdg
 w9JM84ispXcC/jgs77+uOJ9qHqxqoehHn0szbqfvCRvnnrzegqRO6Bn1//ex5pSE7hN4
 aqwrv2LaT1UAr1td8FgeOqflUbv6bNmR3iFBZUnC9ne+Ex4Ira59oU3KCPhvoyayBqxN
 DykuTqZnJwlb+cUGq8OHiMPGwHDhdqvx2x3dJ9fP2B2jMCgQSDpa5T2jCFOlFnFCjsbN
 EhpQ==
X-Gm-Message-State: AOAM532UbhAbMFcLE6UYh2aeeY1K1dulYCJLvgEbteXM669f5wCGVhuS
 d9P4BWlrs3BLfsE9isgpGEVCuPPntiR9KiZ5uHs=
X-Google-Smtp-Source: ABdhPJx2Zs8WdBi2q6BGRif1mYqeYmbJJ/V7U5wEzCpD8kK02oTZ1E3N8+IvXYInA90Pvueo/ZTKOI7rLH4ZgjVwaJI=
X-Received: by 2002:a62:1a4c:0:b029:152:706d:dabb with SMTP id
 a73-20020a621a4c0000b0290152706ddabbmr25481155pfa.40.1604413594887; Tue, 03
 Nov 2020 06:26:34 -0800 (PST)
MIME-Version: 1.0
References: <b85405de-d525-bf59-826c-737fa7bbdfef@redhat.com>
 <20201029094603.15382476@w520.home>
 <d4f7df42-7b02-6505-c2c7-245bf813b513@redhat.com>
 <20201029210407.33d6f008@x1.home>
 <CAJSP0QVto+xFEnWv-aj=-0mZ72SzfeAvg4q0RCoLGK-N7C-WEw@mail.gmail.com>
 <04179584-3324-994e-d793-04be18d2dab2@redhat.com>
 <CAJSP0QXQmFgtSsJL1B3eMUr8teQc3cvvEFvr7LvnFkJPcE3ZpA@mail.gmail.com>
 <95432b0c-919f-3868-b3f5-fc45a1eef721@redhat.com>
 <CAJSP0QX_=dbDB2k7H-6D19ns1_HuM2P5ZMtUrFN9H7WU8aDXCg@mail.gmail.com>
 <1cf6b664-63cc-7b57-0a2c-4d4f979d4950@redhat.com>
 <20201102101308.GA42093@stefanha-x1.localdomain>
 <c007455d-b9fc-32d5-a58c-fd8d17794996@redhat.com>
In-Reply-To: <c007455d-b9fc-32d5-a58c-fd8d17794996@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 3 Nov 2020 14:26:23 +0000
Message-ID: <CAJSP0QXJd-BK60t+efhAt2d6mj9+kgieiyfKm=DSC1z+fDCesA@mail.gmail.com>
Subject: Re: Out-of-Process Device Emulation session at KVM Forum 2020
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=stefanha@gmail.com; helo=mail-pg1-x52f.google.com
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

On Tue, Nov 3, 2020 at 7:53 AM Jason Wang <jasowang@redhat.com> wrote:
> On 2020/11/2 =E4=B8=8B=E5=8D=886:13, Stefan Hajnoczi wrote:
> > On Mon, Nov 02, 2020 at 10:51:18AM +0800, Jason Wang wrote:
> >> On 2020/10/30 =E4=B8=8B=E5=8D=889:15, Stefan Hajnoczi wrote:
> >>> On Fri, Oct 30, 2020 at 12:08 PM Jason Wang <jasowang@redhat.com> wro=
te:
> >>>> On 2020/10/30 =E4=B8=8B=E5=8D=887:13, Stefan Hajnoczi wrote:
> >>>>> On Fri, Oct 30, 2020 at 9:46 AM Jason Wang <jasowang@redhat.com> wr=
ote:
> >>>>>> On 2020/10/30 =E4=B8=8B=E5=8D=882:21, Stefan Hajnoczi wrote:
> >>>>>>> On Fri, Oct 30, 2020 at 3:04 AM Alex Williamson
> >>>>>>> <alex.williamson@redhat.com> wrote:
> >>>>>>>> It's great to revisit ideas, but proclaiming a uAPI is bad solel=
y
> >>>>>>>> because the data transfer is opaque, without defining why that's=
 bad,
> >>>>>>>> evaluating the feasibility and implementation of defining a well
> >>>>>>>> specified data format rather than protocol, including cross-vend=
or
> >>>>>>>> support, or proposing any sort of alternative is not so helpful =
imo.
> >>>>>>> The migration approaches in VFIO and vDPA/vhost were designed for
> >>>>>>> different requirements and I think this is why there are differen=
t
> >>>>>>> perspectives on this. Here is a comparison and how VFIO could be
> >>>>>>> extended in the future. I see 3 levels of device state compatibil=
ity:
> >>>>>>>
> >>>>>>> 1. The device cannot save/load state blobs, instead userspace fet=
ches
> >>>>>>> and restores specific values of the device's runtime state (e.g. =
last
> >>>>>>> processed ring index). This is the vhost approach.
> >>>>>>>
> >>>>>>> 2. The device can save/load state in a standard format. This is
> >>>>>>> similar to #1 except that there is a single read/write blob inter=
face
> >>>>>>> instead of fine-grained get_FOO()/set_FOO() interfaces. This appr=
oach
> >>>>>>> pushes the migration state parsing into the device so that usersp=
ace
> >>>>>>> doesn't need knowledge of every device type. With this approach i=
t is
> >>>>>>> possible for a device from vendor A to migrate to a device from v=
endor
> >>>>>>> B, as long as they both implement the same standard migration for=
mat.
> >>>>>>> The limitation of this approach is that vendor-specific state can=
not
> >>>>>>> be transferred.
> >>>>>>>
> >>>>>>> 3. The device can save/load opaque blobs. This is the initial VFI=
O
> >>>>>>> approach.
> >>>>>> I still don't get why it must be opaque.
> >>>>> If the device state format needs to be in the VMM then each device
> >>>>> needs explicit enablement in each VMM (QEMU, cloud-hypervisor, etc)=
.
> >>>>>
> >>>>> Let's invert the question: why does the VMM need to understand the
> >>>>> device state of a _passthrough_ device?
> >>>> For better manageability, compatibility and debug-ability. If we dep=
ends
> >>>> on a opaque structure, do we encourage device to implement its own
> >>>> migration protocol? It would be very challenge.
> >>>>
> >>>> For VFIO in the kernel, I suspect a uAPI that may result a opaque da=
ta
> >>>> to be read or wrote from guest violates the Linux uAPI principle. It
> >>>> will be very hard to maintain uABI or even impossible. It looks to m=
e
> >>>> VFIO is the first subsystem that is trying to do this.
> >>> I think our concepts of uAPI are different. The uAPI of read(2) and
> >>> write(2) does not define the structure of the data buffers. VFIO
> >>> device regions are exactly the same, the structure of the data is not
> >>> defined by the kernel uAPI.
> >>
> >> I think we're talking about different things. It's not about the data
> >> structure, it's about whether to data that reads from kernel can be
> >> understood by userspace.
> >>
> >>
> >>> Maybe microcode and firmware loading is an example we agree on?
> >>
> >> I think not. They are bytecodes that have
> >>
> >> 1) strict ABI definitions
> >> 2) understood by userspace
> > No, they can be proprietary formats that neither the Linux kernel nor
> > userspace can parse. For example, look at linux-firmware
> > (https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmwar=
e.git/about/)
> > it's just a collection of binary blobs. The format is not necessarily
> > public. The only restriction on that repo is that the binary blob must
> > be redistributable and users must be allowed to run them (i.e.
> > proprietary licenses can be used).
>
>
> I think not. Obviously each firmware should have its own ABI no matter
> whether its public or proprietary. For proprietary firmware, it should
> be understood by the proprietary userspace counterpart.

Userspace does not necessarily need to interpret the contents. The
vendor can ship a binary blob and the driver loads the file onto the
device without interpreting it.

> > Or look at other passthrough device interfaces like /dev/i2c or libusb.
> > They expose data to userspace without requiring a defined format. It's
> > the same as VFIO.
>
>
> Again, it should have an ABI there (either device or spec) no matter
> whether or not it's a transport layer. And there will be an endpoint in
> the userspace know all the format.

VFIO defines how userspace interacts with migration regions, see the
patch series that I linked at the beginning of this discussion.
Userspace has control over pausing/resuming the device and reading
migration blobs.

> > In addition, look at kernel uAPIs where userspace acts simply as a data
> > transport for opaque data (e.g. where a userspace helper facilitates
> > communication but has no visibility of the data). I imagine that memory
> > encryption relies on this because the host kernel and userspace do not
> > have access to encrypted memory or associated state - but they need to
> > help migrate them to other hosts.
>
>
> Which uAPI do you mean here?

Migration of encrypted guests. The host kernel and userspace do not
have access to all guest state. Userspace acts as a transport - same
as VFIO migration.

I'm not sure how much of it is already upstream since it's being
actively developed right now, but it's another example where userspace
does not need to and cannot interpret data.

> > I hope these examples show that such APIs don't pose a problem for the
> > Linux uAPI and are already in use. VFIO device state isn't doing
> > anything new here.
>
>
> I feel that you tried to explain "why it can be" but not "why it must
> be". Trying to find one or two subsystems that have opaque uAPI without
> ABI (though I suspect there will be one) may not convince here.

As I've said from the beginning of the discussion, there are multiple
approaches and they are suited to different use cases.

For passthrough devices I think it's preferable for the VMM not to be
involved in the device state representation. This keeps the VMM
simple, avoids code duplication across VMMs, and allows migration to
work in non-virtualization use cases.

Stefan

