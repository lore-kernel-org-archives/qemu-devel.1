Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59541C43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 12:36:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3A9A20756
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 12:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PB7j7hat"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A9A20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKL3D-0005uI-La
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 08:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kKL1l-0004Wd-6I
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 08:34:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47612)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kKL1j-00018W-9I
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 08:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600691678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SNFxEx6jaUGXi9NiBt1VwiWOc8wzyIMBnt2bhVPq24I=;
 b=PB7j7hatOCxW60dYXV4kOIUz958ejDIPEFquXZXPY0Bn6Wnu+v/IAvNDtZ9JPkd/CvmEYh
 vs1ldp1BO/h+JIaZiX+BIbrdKXZhOTSP5ADJoQSVuTodCOcfAN3RTOBM4b/gWsM6nGymHp
 u7Qaz57fwm0zRwq24ORm1IqtKYE/JAg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-QVmdKciPNbq_QabH0sLSbw-1; Mon, 21 Sep 2020 08:34:36 -0400
X-MC-Unique: QVmdKciPNbq_QabH0sLSbw-1
Received: by mail-wr1-f69.google.com with SMTP id a12so5807837wrg.13
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 05:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SNFxEx6jaUGXi9NiBt1VwiWOc8wzyIMBnt2bhVPq24I=;
 b=RV5E3RjDz4DynZ7sp/qI/Q2e6+k5/gX0b3jJ1li8NUSq6gVb40lPILZF6r8YliWfg8
 7DNlzbuUnmYQTcsiGQD4urKRyDb0NjKCUNuV7bMrasB1x5A9/0fraWCfuEAZE8QnVkae
 /WJlH+NPK9+6yW66QIjur9ZkXwJ6/CQ8o64UW0FYJ8JiXZuZWCMwgLN+IQDpRVm+nKoR
 r8Oxfsl4K/PKk8xXW0h4NoGhu8U5J1bx87OdZkEtAc9fTSroge4eDaoaiB+4ggSl9Ex4
 5m83PJBl1sTT6VqFRaPk2sQo7Cdn8AhGL1PMDS/VZFrxnf+LL8hArD1NsqsvDUoFrVnr
 cB4A==
X-Gm-Message-State: AOAM533hHn/mWdn6VsJ5azDuN2IhvlPX0Fc2aiWad8s9tg2nGq8NIio8
 DmCxB9m9p0yIo1F+C8UEtiuhgS4FkiUeHzX7DrIX5q8dmJT7wFMsNLEjapAtQN63be9DR+wPLjB
 cxlh/KslNUNh7GGg=
X-Received: by 2002:a7b:c4d3:: with SMTP id g19mr31414394wmk.165.1600691674999; 
 Mon, 21 Sep 2020 05:34:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaeSagfOTNvYMrIfA0hKdr6R+VfLkaKIZggK2jj/KPSdEcUH0gvvUfEldSNWamrYBC1mZd7w==
X-Received: by 2002:a7b:c4d3:: with SMTP id g19mr31414368wmk.165.1600691674737; 
 Mon, 21 Sep 2020 05:34:34 -0700 (PDT)
Received: from redhat.com (bzq-109-65-116-225.red.bezeqint.net.
 [109.65.116.225])
 by smtp.gmail.com with ESMTPSA id v128sm19553694wme.2.2020.09.21.05.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 05:34:34 -0700 (PDT)
Date: Mon, 21 Sep 2020 08:34:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v5 00/10] x86: fix cpu hotplug with secure boot
Message-ID: <20200921083322-mutt-send-email-mst@kernel.org>
References: <20200907112348.530921-1-imammedo@redhat.com>
 <20200921134601.55d12fdc@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200921134601.55d12fdc@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: boris.ostrovsky@oracle.com, lersek@redhat.com, qemu-devel@nongnu.org,
 aaron.young@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 21, 2020 at 01:46:01PM +0200, Igor Mammedov wrote:
> On Mon,  7 Sep 2020 07:23:38 -0400
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > v5:
> >   - fix hotplug on Windows when there is more than 256 possible CPUs
> >     (Windows isn't able to handle VarPackage over 255 elements
> >      so process CPUs in batches)
> >   - fix off-by-one in package length (Laszlo)
> >   - fix not selecting CPU before clearing insert event (Laszlo)
> >   - use aml_lgreater() instead of aml_lnot(aml_equal(num_added_cpus, zero) (Laszlo)
> >   - split 'x68: acpi: trigger SMI before sending hotplug Notify event to OSPM'
> >     in samller chunks (Laszlo)
> >   - fix comment to match spec (Laszlo)
> >   - reorder aml_lor() and aml_land() in header (Laszlo)
> > v4:
> >   - fix 5.2 machine types so they won't apply pc_compat_5_1 (Laszlo)
> > v3:
> >   - rebase on top of "[PATCH v2] hw: add compat machines for 5.2"
> >     so apply that before this patch
> > v2:
> >   - AML: clean is_inserted flag only after SMI callback
> >   - make x-smi-cpu-hotunplug false by default
> >   - massage error hint on not supported unplug
> > v1:
> >   - fix typos and some phrases (Laszlo)
> >   - add unplug check (Laszlo)
> >   - redo AML scan logic to avoid race when adding multiple CPUs
> 
> Michael,
> 
> just saw your pull request which missed this series.
> Is there any plans to queue it for the next pull request?

Oh.
You didn't Cc me on most patches so I assumed this is targeting some other tree.
Sorry.
Will review and queue, thanks.

> 
> 
> > CPU hotplug with Secure Boot was not really supported and firmware wasn't aware
> > of hotplugged CPUs (which might lead to guest crashes). During 4.2 we introduced
> > locked SMI handler RAM arrea to make sure that guest OS wasn't able to inject
> > its own SMI handler and OVMF added initial CPU hotplug support.
> > 
> > This series is QEMU part of that support which lets QMVF tell QEMU that
> > CPU hotplug with SMI broadcast enabled is supported so that QEMU would be able
> > to prevent hotplug in case it's not supported and trigger SMI on hotplug when
> > it's necessary.
> > 
> > Igor Mammedov (10):
> >   x86: lpc9: let firmware negotiate 'CPU hotplug with SMI' features
> >   x86: cpuhp: prevent guest crash on CPU hotplug when broadcast SMI is
> >     in use
> >   x86: cpuhp: refuse cpu hot-unplug request earlier if not supported
> >   acpi: add aml_land() and aml_break() primitives
> >   tests: acpi: mark to be changed tables in
> >     bios-tables-test-allowed-diff
> >   x86: ich9: expose "smi_negotiated_features" as a QOM property
> >   x86: acpi: introduce AcpiPmInfo::smi_on_cpuhp
> >   x86: acpi: introduce the PCI0.SMI0 ACPI device
> >   x68: acpi: trigger SMI before sending hotplug Notify event to OSPM
> >   tests: acpi: update acpi blobs with new AML
> > 
> >  include/hw/acpi/aml-build.h       |   2 +
> >  include/hw/acpi/cpu.h             |   1 +
> >  include/hw/i386/ich9.h            |   4 +
> >  hw/acpi/aml-build.c               |  16 +++
> >  hw/acpi/cpu.c                     | 156 ++++++++++++++++++++++++------
> >  hw/acpi/ich9.c                    |  24 ++++-
> >  hw/i386/acpi-build.c              |  35 ++++++-
> >  hw/i386/pc.c                      |  15 ++-
> >  hw/isa/lpc_ich9.c                 |  16 +++
> >  tests/data/acpi/pc/DSDT           | Bin 4934 -> 5060 bytes
> >  tests/data/acpi/pc/DSDT.acpihmat  | Bin 6258 -> 6385 bytes
> >  tests/data/acpi/pc/DSDT.bridge    | Bin 6793 -> 6919 bytes
> >  tests/data/acpi/pc/DSDT.cphp      | Bin 5397 -> 5524 bytes
> >  tests/data/acpi/pc/DSDT.dimmpxm   | Bin 6587 -> 6714 bytes
> >  tests/data/acpi/pc/DSDT.ipmikcs   | Bin 5006 -> 5132 bytes
> >  tests/data/acpi/pc/DSDT.memhp     | Bin 6293 -> 6419 bytes
> >  tests/data/acpi/pc/DSDT.numamem   | Bin 4940 -> 5066 bytes
> >  tests/data/acpi/q35/DSDT          | Bin 7678 -> 7804 bytes
> >  tests/data/acpi/q35/DSDT.acpihmat | Bin 9002 -> 9129 bytes
> >  tests/data/acpi/q35/DSDT.bridge   | Bin 7695 -> 7821 bytes
> >  tests/data/acpi/q35/DSDT.cphp     | Bin 8141 -> 8268 bytes
> >  tests/data/acpi/q35/DSDT.dimmpxm  | Bin 9331 -> 9458 bytes
> >  tests/data/acpi/q35/DSDT.ipmibt   | Bin 7753 -> 7879 bytes
> >  tests/data/acpi/q35/DSDT.memhp    | Bin 9037 -> 9163 bytes
> >  tests/data/acpi/q35/DSDT.mmio64   | Bin 8808 -> 8934 bytes
> >  tests/data/acpi/q35/DSDT.numamem  | Bin 7684 -> 7810 bytes
> >  tests/data/acpi/q35/DSDT.tis      | Bin 8283 -> 8409 bytes
> >  27 files changed, 239 insertions(+), 30 deletions(-)
> > 


