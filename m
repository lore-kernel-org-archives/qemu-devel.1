Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33358C43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 12:37:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D57A20756
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 12:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S7Ay4CzE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D57A20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKL4j-0007gM-Jg
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 08:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kKKyu-0001Ug-Tg
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 08:31:44 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36094
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kKKyq-0000pj-T2
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 08:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600691500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0AKhMO9wh5Fh+D60WATXEswIxIiyJs66dsN0HQFJYrg=;
 b=S7Ay4CzEU8pMK72gCyXfb0F/lrdXrCQjlC6n0Xog7/OLJC3ohI9z0yh8L83EJS2/BfGQtV
 LU82OpZ0adfOoH1vJfr9rFJ/3RAvxk16lMPBPvHjlpJDYl4Z7ZWBnmEHYXtKUDR++xfphB
 4K4xWRRDbWnpncH0G1wXOOJHA4tiG8M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-VfPmZ2BAMa6he1i3wwfetw-1; Mon, 21 Sep 2020 08:31:36 -0400
X-MC-Unique: VfPmZ2BAMa6he1i3wwfetw-1
Received: by mail-wm1-f69.google.com with SMTP id w3so3686133wmg.4
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 05:31:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=0AKhMO9wh5Fh+D60WATXEswIxIiyJs66dsN0HQFJYrg=;
 b=cn+1X7GLRpEsJEjuh/QkA2C2m4e8hHEy52Rkxp+PhrIGph3lpte0WyhCBcVYfUWhWF
 2wFzZYhi06T26PPGQJMHZAHIrKtqV3D6mADwNPLgegvhgjiUN0Lm7ncA6bgRhI/56BtT
 sB80kdPIi+7W5uLgIiz5bcJJziFikP3G8fwF9lk5huyzL2iqtVXCwQbx9zMMnSQdPXhi
 g1pACZRugYR2u2tSfkuTr9k3f95xive3m+DtEnqxn7DQuer6Bj+pt2WL9B7BMOlfw7H5
 TswcJJmqOrLRlcSn+u0fU8P0TwxfHAofMHPq/sASakw9YatzF4Hkz//cJGJ1r+xjp2Uk
 gWrg==
X-Gm-Message-State: AOAM532Bnky7Py7ekss6tuiqNVGZPB+7gZOz/g0RqxtuhIO9UbasOCmK
 rmgO0GZK7Arwd4O1NZQk8MKu69SnyQ1q/TuskCX2eczDZq7z8mT+I41rvoI3Htw9ujC/M8gDEfU
 OlPKIXI65nAz35Bo=
X-Received: by 2002:a7b:c24b:: with SMTP id b11mr31514941wmj.134.1600691495689; 
 Mon, 21 Sep 2020 05:31:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0obBAg/4nrERK1bZU2viYoHCx9AAqQBd2KcGrAUQ8toJ7Rd762iGB7H9vp43OuK5WlGsY/Q==
X-Received: by 2002:a7b:c24b:: with SMTP id b11mr31514912wmj.134.1600691495436; 
 Mon, 21 Sep 2020 05:31:35 -0700 (PDT)
Received: from redhat.com (bzq-109-65-116-225.red.bezeqint.net.
 [109.65.116.225])
 by smtp.gmail.com with ESMTPSA id 189sm19658839wmb.3.2020.09.21.05.31.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 05:31:34 -0700 (PDT)
Date: Mon, 21 Sep 2020 08:31:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li Qiang <liq3ea@gmail.com>
Subject: Re: [PULL v3 00/15] virtio,pc,acpi: fixes, tests
Message-ID: <20200921083052-mutt-send-email-mst@kernel.org>
References: <20200921112913.555392-1-mst@redhat.com>
 <CAKXe6SLYL0DDWTbPEwa7y47BOpagg8HkUf+nfgzz_3Or_ebUqQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKXe6SLYL0DDWTbPEwa7y47BOpagg8HkUf+nfgzz_3Or_ebUqQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 03:43:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, Sep 21, 2020 at 07:44:42PM +0800, Li Qiang wrote:
> Michael S. Tsirkin <mst@redhat.com> 于2020年9月21日周一 下午7:30写道：
> >
> > The following changes since commit 053a4177817db307ec854356e95b5b350800a216:
> >
> >   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/fw_cfg-20200918' into staging (2020-09-18 16:34:26 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to acbdbd5db6dab68534702987a487360fd8ae02b7:
> >
> >   virtio-iommu-pci: force virtio version 1 (2020-09-21 06:14:46 -0400)
> >
> > ----------------------------------------------------------------
> > virtio,pc,acpi: fixes, tests
> >
> > Fixes and tests all over the place.
> > Batch iommu updates for vdpa.
> > Removal of deprecated cpu hotplug commands.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > ----------------------------------------------------------------
> > David Hildenbrand (1):
> >       pc: fix auto_enable_numa_with_memhp/auto_enable_numa_with_memdev for the 5.0 machine
> >
> > Dima Stepanov (7):
> >       vhost: recheck dev state in the vhost_migration_log routine
> >       vhost: check queue state in the vhost_dev_set_log routine
> >       tests/qtest/vhost-user-test: prepare the tests for adding new dev class
> >       tests/qtest/libqos/virtio-blk: add support for vhost-user-blk
> >       tests/qtest/vhost-user-test: add support for the vhost-user-blk device
> >       tests/qtest/vhost-user-test: add migrate_reconnect test
> >       tests/qtest/vhost-user-test: enable the reconnect tests
> >
> > Eric Auger (2):
> >       virtio-iommu: Check gtrees are non null before destroying them
> >       virtio-iommu-pci: force virtio version 1
> >
> > Igor Mammedov (1):
> >       cphp: remove deprecated cpu-add command(s)
> >
> > Jason Wang (3):
> >       linux headers: sync to 5.9-rc4
> >       vhost: switch to use IOTLB v2 format
> >       vhost-vdpa: batch updating IOTLB mappings
> >
> > Li Qiang (1):
> >       virtio-mem: detach the element from the virtqueue when error occurs
> 
> Hello Michael,
> It seems you lost the virtio-pmem patch.
> 
> https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg02639.html

That's because I was never copied. Can you repost with all tags and Cc
me?
Subject can be PATCH repost.

> Anyway, it can be queued in the next pr.
> 
> Thanks,
> Li Qiang


