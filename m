Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D870C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:11:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCB07247B2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j8JIcToX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB07247B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXn6o-0002Py-JP
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 11:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXn3W-0006e8-H3
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:08:06 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:44529)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXn3T-0004um-Jq
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:08:06 -0400
Received: by mail-ej1-x643.google.com with SMTP id j24so4075971ejc.11
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 08:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=27xDIr/hXEBB8ouIYgABS1t5+oXCUVMHq9A+Hufvq6M=;
 b=j8JIcToXKvZsVDulj7yeIAXTYlAby0dVhpwdkeHdZVC87ju3Qsu3JzxQGBRTkipY96
 zsBLE29htRkleUwUcxXDckX7hE7Ld8k6lZJn2EVc80zRd7zpVqfHjSF8D1qtR+bqLzj4
 xwd/FBGy4WtPjxd3vhdrb9LASxEcqdEMTlTSlgtXn+Sp/BzRFhOVg9hBN1RCUOLgXE7y
 h7p6tAK3QTuZQcsw4G5XY5T/6Fqh3P+oEDinXQ6SiAQNixr3Z5Ukh8XUw3+R1W8SvAUV
 /JgOzP9WMGFFc4U462B+bH9mQqn2U3SMlnBd7zH7IVVSArSg05d72zG0C+Y5U/CbCryP
 s2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=27xDIr/hXEBB8ouIYgABS1t5+oXCUVMHq9A+Hufvq6M=;
 b=TsHzm1iplBPwYvPQ9TT8vpSF0qrd6ECpps6FF38aG4BTIBARbYQOYgCRVVmQ/5aFiS
 hTMsJ4jA9rod5dQJCV2OtWtBOSvQhS5Ko4QPomIkGgPFLdK0fxgtiWq3vYXFLPIOMYbq
 wLKAYIZLVWrrhK+wSwdntj3dLz1ge+Gc9RiNoT5eWQ5b9YPzWkermS7l2vjpts6i3nVK
 r9Wa7P0TyeVOdYWyo+09PyT4r7kA2HAED1wvIYwjFOT8cv6W3xthq1GdvCl4k2KCcSLE
 qsa/siMOYKoNNYg8OjQTch+5aOQLydoSjAHf6d40l57gGnixOVok8DqQcUQmx33Jqlt9
 0AaA==
X-Gm-Message-State: AOAM533xwBaIUO75+cMVTxuX2R8++1sq4cR0LbuCp4uUQpgr4ubAVJeM
 DEjoEYWupYB3pgabZ0JHoQrvl1AU4arIsl6FDt5rtA==
X-Google-Smtp-Source: ABdhPJwDg/mYze0AVcIAZq2w1TqADjP0irQqDQfsM0JHp1ls+jc1IR/VQHLysFIdIGoXEz8IngViFx3jyecWQ4sxEqU=
X-Received: by 2002:a17:906:af8c:: with SMTP id
 mj12mr3772970ejb.85.1603897681940; 
 Wed, 28 Oct 2020 08:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <160374054442.22414.10832953989449611268.stgit@gimli.home>
In-Reply-To: <160374054442.22414.10832953989449611268.stgit@gimli.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Oct 2020 15:07:50 +0000
Message-ID: <CAFEAcA9pgxKY7Q8bHRR0MXvYkWAWjakJS=uo4V_Bs14zLLc-Jw@mail.gmail.com>
Subject: Re: [PULL 00/32] VFIO updates 2020-10-26 (for QEMU 5.2 soft-freeze)
To: Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Artem Polyakov <artemp@nvidia.com>, Zhengui li <lizhengui@huawei.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Zhi Wang <zhi.wang.linux@gmail.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Neo Jia <cjia@nvidia.com>,
 Amey Narkhede <ameynarkhede03@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 26 Oct 2020 at 19:39, Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> The following changes since commit a5fac424c76d6401ecde4ecb7d846e656d0d6e=
89:
>
>   Merge remote-tracking branch 'remotes/stefanha-gitlab/tags/block-pull-r=
equest' into staging (2020-10-26 10:33:59 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/awilliam/qemu-vfio.git tags/vfio-update-20201026.0
>
> for you to fetch changes up to 5219bf8e0fa86573427aa8812bbfe93d83c3d664:
>
>   vfio: fix incorrect print type (2020-10-26 12:07:46 -0600)
>
> ----------------------------------------------------------------
> VFIO update 2020-10-26
>
>  * Migration support (Kirti Wankhede)
>  * s390 DMA limiting (Matthew Rosato)
>  * zPCI hardware info (Matthew Rosato)
>  * Lock guard (Amey Narkhede)
>  * Print fixes (Zhengui li)
>

I retried the merge of this after the revert from Max, and it
no longer gives merge conflicts, but it has compile errors:

On FreeBSD, OpenBSD, NetBSD, OSX and Windows:

In file included from ../src/hw/arm/sysbus-fdt.c:35:
In file included from
/usr/home/qemu/qemu-test.ffr5Sp/src/include/hw/vfio/vfio-platform.h:20:
/usr/home/qemu/qemu-test.ffr5Sp/src/include/hw/vfio/vfio-common.h:201:37:
warning: declaration of 'struct vfio_iommu_type1_info' will not be
visible outside of this function [-Wvisibility]
bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
                                    ^

On clang x86-64 Linux:

../../hw/vfio/migration.c:737:42: error: equality comparison with
extraneous parentheses [-Werror,-Wparentheses-equality]
    if ((vbasedev->migration->vm_running =3D=3D running)) {
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~
../../hw/vfio/migration.c:737:42: note: remove extraneous parentheses
around the comparison to silence this warning
    if ((vbasedev->migration->vm_running =3D=3D running)) {
        ~                                ^         ~
../../hw/vfio/migration.c:737:42: note: use '=3D' to turn this equality
comparison into an assignment
    if ((vbasedev->migration->vm_running =3D=3D running)) {
                                         ^~
                                         =3D

On AArch32:

../../hw/vfio/migration.c: In function 'vfio_mig_access':
../../hw/vfio/migration.c:58:68: error: format '%lx' expects argument
of type 'long unsigned int', but argument 5 has type 'off_t {aka long
long int}' [-Werror=3Dformat=3D]
         error_report("vfio_mig_%s %d byte %s: failed at offset 0x%lx, err:=
 %s",
                                                                  ~~^
                                                                  %llx
cc1: all warnings being treated as errors


On PPC64:

../../hw/vfio/common.c: In function =E2=80=98vfio_dma_unmap_bitmap=E2=80=99=
:
../../hw/vfio/common.c:400:9: error: format =E2=80=98%llx=E2=80=99 expects =
argument of
type =E2=80=98long long unsigned int=E2=80=99, but argument 2 has type =E2=
=80=98__u64=E2=80=99
[-Werror=3Dformat=3D]
         error_report("UNMAP: Size of bitmap too big 0x%llx", bitmap->size)=
;
         ^
../../hw/vfio/common.c: In function =E2=80=98vfio_get_dirty_bitmap=E2=80=99=
:
../../hw/vfio/common.c:1003:17: error: format =E2=80=98%llx=E2=80=99 expect=
s argument
of type =E2=80=98long long unsigned int=E2=80=99, but argument 2 has type =
=E2=80=98__u64=E2=80=99
[-Werror=3Dformat=3D]
                 range->iova, range->size, errno);
                 ^
../../hw/vfio/common.c:1003:17: error: format =E2=80=98%llx=E2=80=99 expect=
s argument
of type =E2=80=98long long unsigned int=E2=80=99, but argument 3 has type =
=E2=80=98__u64=E2=80=99
[-Werror=3Dformat=3D]

thanks
-- PMM

