Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F664C43465
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:29:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 261E8221EC
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZLSdWE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 261E8221EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKMos-0001nT-6R
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 10:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kKMnz-0000xK-7W
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 10:28:35 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:45329)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kKMnx-0003ak-35
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 10:28:34 -0400
Received: by mail-oi1-x242.google.com with SMTP id z26so17114434oih.12
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 07:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fYew7RGsAe6ZuFlSlV/kwWn2ThS+wPno7fxkLoYL1U4=;
 b=EZLSdWE7eeSbGcsfeW/QYPmGwI9Hp7qhOp5bReaXRcpEhsVNCVxWnRngNvGC+zt4Vi
 /PRzkZ+xipD59AFjUKvPTY5kYAf6iT6QKR80tIgdNN6g/viZPKYdzS4ujqhfTSsW4MuX
 vFK6U1DflloNIFgPGmbMtOSej362nKucIB6/FTuyog/rHlsnjl7oyjACJlHMojiQ5wFM
 L4402PIJDDB/Lr1ejcD319/e97hPuHtxRDSbGHUqQ/AyBnZTCAHYwMZCduPtPNNCRM3f
 JBd5YAMHNo7yhLH9ViQ3S5UWL+yKLpqibnrYjcMmXCRHXqlTcJCrBANW1CSrV3vE1fyr
 Sbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fYew7RGsAe6ZuFlSlV/kwWn2ThS+wPno7fxkLoYL1U4=;
 b=B2LSM0mVY6ScLSm8ruiuh5FCBx6I8uq1aQbGmVMnUUIwMb5hc/0AAyjJLRRKIto89K
 OnyyjWFE6siekY/ZLIo4bdfSuVeXWO1xFWMILfoiBwxSKtF+vIFXx/kLgqx8apYBpTNs
 o8Rcv6JtM/MRSsUtmTGMn0ALFjarTUi3EZ2gHX3DWDZTLO6tOxTtDJRSAP+odCxe0GwX
 AaE1aXChw4hXa1e6lhY+Y4vCSv909P49WZ+FBts/rNdm2FRYYZvq5XOof/tthzOaY+rY
 GVQm1o/LzmYCtn2wUMrBYxEClgNmNBAhSEHekF6cRXN0oJwDHeJDuh/THg/TR6X+H/+3
 KbkQ==
X-Gm-Message-State: AOAM531CVZcPsByECXEXIl9XzBbVh/LGIefAab7aw5HXB8jg0eHzRi5/
 f1tXdArmbau1fU6RrVIymTYXH3PkT6J8UP35TE0=
X-Google-Smtp-Source: ABdhPJxvcSsdi3aOB+XmMMetFGDiICYnS7d8JYy/hZpC6cR1CkeoAfl5hQCfSOTQi4uHlN86nm6pOs/t++JfDeMWENg=
X-Received: by 2002:aca:e155:: with SMTP id y82mr123129oig.56.1600698511739;
 Mon, 21 Sep 2020 07:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200921112913.555392-1-mst@redhat.com>
 <CAKXe6SLYL0DDWTbPEwa7y47BOpagg8HkUf+nfgzz_3Or_ebUqQ@mail.gmail.com>
 <20200921083052-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200921083052-mutt-send-email-mst@kernel.org>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 21 Sep 2020 22:27:55 +0800
Message-ID: <CAKXe6SL3siSyWxp+-NPQz0o+KeybHivrDss+HcD9ixWiQfEdAw@mail.gmail.com>
Subject: Re: [PULL v3 00/15] virtio,pc,acpi: fixes, tests
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x242.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Michael S. Tsirkin <mst@redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8821=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=888:31=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Sep 21, 2020 at 07:44:42PM +0800, Li Qiang wrote:
> > Michael S. Tsirkin <mst@redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8821=
=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=887:30=E5=86=99=E9=81=93=EF=BC=
=9A
> > >
> > > The following changes since commit 053a4177817db307ec854356e95b5b3508=
00a216:
> > >
> > >   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/fw_cfg-202=
00918' into staging (2020-09-18 16:34:26 +0100)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstrea=
m
> > >
> > > for you to fetch changes up to acbdbd5db6dab68534702987a487360fd8ae02=
b7:
> > >
> > >   virtio-iommu-pci: force virtio version 1 (2020-09-21 06:14:46 -0400=
)
> > >
> > > ----------------------------------------------------------------
> > > virtio,pc,acpi: fixes, tests
> > >
> > > Fixes and tests all over the place.
> > > Batch iommu updates for vdpa.
> > > Removal of deprecated cpu hotplug commands.
> > >
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > >
> > > ----------------------------------------------------------------
> > > David Hildenbrand (1):
> > >       pc: fix auto_enable_numa_with_memhp/auto_enable_numa_with_memde=
v for the 5.0 machine
> > >
> > > Dima Stepanov (7):
> > >       vhost: recheck dev state in the vhost_migration_log routine
> > >       vhost: check queue state in the vhost_dev_set_log routine
> > >       tests/qtest/vhost-user-test: prepare the tests for adding new d=
ev class
> > >       tests/qtest/libqos/virtio-blk: add support for vhost-user-blk
> > >       tests/qtest/vhost-user-test: add support for the vhost-user-blk=
 device
> > >       tests/qtest/vhost-user-test: add migrate_reconnect test
> > >       tests/qtest/vhost-user-test: enable the reconnect tests
> > >
> > > Eric Auger (2):
> > >       virtio-iommu: Check gtrees are non null before destroying them
> > >       virtio-iommu-pci: force virtio version 1
> > >
> > > Igor Mammedov (1):
> > >       cphp: remove deprecated cpu-add command(s)
> > >
> > > Jason Wang (3):
> > >       linux headers: sync to 5.9-rc4
> > >       vhost: switch to use IOTLB v2 format
> > >       vhost-vdpa: batch updating IOTLB mappings
> > >
> > > Li Qiang (1):
> > >       virtio-mem: detach the element from the virtqueue when error oc=
curs
> >
> > Hello Michael,
> > It seems you lost the virtio-pmem patch.
> >
> > https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg02639.html
>
> That's because I was never copied. Can you repost with all tags and Cc
> me?
> Subject can be PATCH repost.

I have resent it with subject:
[PATCH REPOST] hw: virtio-pmem: detach the element fromt the virtqueue
when error occurs

Thanks,
Li Qiang

>
> > Anyway, it can be queued in the next pr.
> >
> > Thanks,
> > Li Qiang
>

