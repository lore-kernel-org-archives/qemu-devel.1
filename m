Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECAEC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 06:50:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88E88206FA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 06:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FxlwyNu5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E88206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joLi9-0000Nq-Ru
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 02:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joLhP-0008LA-N0
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 02:49:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22832
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joLhO-0004c9-18
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 02:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593067765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DBRx8nKGtqkPfGO9Xu367XTw0d50xrdqwJlmq+Ewni4=;
 b=FxlwyNu5LKiupyAziVU0gJz0RgARhrRnlvbKWjtKzQSdz/GBwu3oG7skF1uwzkeMqBt3kl
 ZIaaIDJVngect2E21yb3k2GgZXHo6xUtJOu2yomiKgBPyEM0qO6FJtJNHv2eHL8rrm1MXp
 4YIlkcwHyEhsnsiemkSzcV+srPMUqLI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-Fb9E0By1NzmKmxH38tX4bw-1; Thu, 25 Jun 2020 02:49:20 -0400
X-MC-Unique: Fb9E0By1NzmKmxH38tX4bw-1
Received: by mail-wr1-f71.google.com with SMTP id i10so6099787wrn.21
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 23:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DBRx8nKGtqkPfGO9Xu367XTw0d50xrdqwJlmq+Ewni4=;
 b=KyAvE4fb3BxLawjYcK62vVUa3xfLU7+Uw7MH+QZncy4IRrxnmnL6Cf3pZpPZV8HjJS
 lNcwhbqTm8aoBzlA2uxSaYx2H1s0STvSvUQxVFn929Fjf+RyjJ87xj1WDYSAgha95Ruj
 Loswk85UN+TvPXxC5tuf5p/ClB+YCb2HF2k0JxU8eNkfKxoNBmC5mlvyuhoZ24vh7JG0
 pFjVTTAmFB+5B53InXWosIPEHS42L9SWWKZs7f+DQ11f4vSDo5RVx1zg+phSUAPOrLcZ
 XvApvQCgrjtwcE6JHyVqd2xa81apjbXY02VR1syl3qKVEgzOftgxifsuCCYyBCzwwHrc
 UpnQ==
X-Gm-Message-State: AOAM533GokBymCQOYegn3vevdcyNv3Po/MBBmnnDUgS+7UC8wAMHlH5n
 4BR9ySOcRvMcP1Ic+YL7phDj1//g9ibwvr/cQx78FWWq3bdlmlPkGG0+xF7bD1sIvmoZ1qxqsiO
 VW+kRQujfs0bmADo=
X-Received: by 2002:a7b:c186:: with SMTP id y6mr1806862wmi.82.1593067759440;
 Wed, 24 Jun 2020 23:49:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydMxH5tpwrTKaXYN/BCPWQ/a2C4UeVJ9ZhmgB814zZ9j4D/jbFWF022zQ01WZNekKFNJZlHA==
X-Received: by 2002:a7b:c186:: with SMTP id y6mr1806843wmi.82.1593067759176;
 Wed, 24 Jun 2020 23:49:19 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 l18sm1797602wrm.52.2020.06.24.23.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 23:49:18 -0700 (PDT)
Date: Thu, 25 Jun 2020 02:49:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PULL 00/19] virtio,acpi,pci: fixes, cleanups, tools.
Message-ID: <20200625024751-mutt-send-email-mst@kernel.org>
References: <20200624230609.703104-1-mst@redhat.com>
 <041fe41e-e9b5-77dd-d69c-0afdcbfd638c@redhat.com>
MIME-Version: 1.0
In-Reply-To: <041fe41e-e9b5-77dd-d69c-0afdcbfd638c@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 02:30:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 25, 2020 at 07:47:41AM +0200, Thomas Huth wrote:
> On 25/06/2020 01.06, Michael S. Tsirkin wrote:
> > The following changes since commit d4b78317b7cf8c0c635b70086503813f79ff21ec:
> > 
> >    Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200623' into staging (2020-06-23 18:57:05 +0100)
> > 
> > are available in the Git repository at:
> > 
> >    git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> > 
> > for you to fetch changes up to f6f746db6bae1ba74967fd7bea2bb5e169502948:
> > 
> >    tests: disassemble-asm.sh: generate AML in readable format (2020-06-24 19:03:57 -0400)
> > 
> > ----------------------------------------------------------------
> > virtio,acpi,pci: fixes, cleanups, tools.
> > 
> > Fixes, cleanups in ACPI, PCI, virtio.
> > A handy script for testing ACPI.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > ----------------------------------------------------------------
> > Ani Sinha (1):
> >        Rename use_acpi_pci_hotplug to more appropriate use_acpi_hotplug_bridge
> > 
> > Eric Auger (3):
> >        acpi: Some build_tpm2() code reshape
> >        arm/acpi: Add the TPM2.0 device under the DSDT
> >        docs/specs/tpm: ACPI boot now supported for TPM/ARM
> > 
> > Gerd Hoffmann (12):
> >        qtest: allow DSDT acpi table changes
> >        acpi: bios-tables-test: show more context on asl diffs
> >        acpi: move aml builder code for floppy device
> >        floppy: make isa_fdc_get_drive_max_chs static
> >        floppy: move cmos_get_fd_drive_type() from pc
> >        acpi: move aml builder code for i8042 (kbd+mouse) device
> >        acpi: factor out fw_cfg_add_acpi_dsdt()
> >        acpi: simplify build_isa_devices_aml()
> >        acpi: drop serial/parallel enable bits from dsdt
> >        acpi: drop build_piix4_pm()
> >        acpi: q35: drop _SB.PCI0.ISA.LPCD opregion.
> >        tests/acpi: update expected data files
> > 
> > Michael S. Tsirkin (1):
> >        tests: disassemble-asm.sh: generate AML in readable format
> > 
> > Raphael Norwitz (1):
> >        Stop vhost-user sending uninitialized mmap_offsets
> > 
> > Thomas Huth (1):
> >        tests/qtest/bios-tables: Only run the TPM test with CONFIG_TPM enabled
> 
>  Hi Michael!
> 
> Please drop my patch from your pull request - the issue has already been
> solved by Eric's patch that already got merged:
> 
> https://git.qemu.org/?p=qemu.git;a=commitdiff;h=55b9757c7e58092
> 
>  Thanks,
>   Thomas


OK done. Peter I pushed a new tag dropping a couple of patches
accordingly. Same name.


