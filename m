Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD843C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 16:13:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F54020801
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 16:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TkP0DaHO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F54020801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjmJM-00049q-Ac
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 12:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjmI2-000295-1T
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 12:12:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46516
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjmI0-0002CO-8S
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 12:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591978338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/zajgHfeGGUTjGNPtfTDYhnjhMRAXOh06gflXef/o0s=;
 b=TkP0DaHOBqfQ1bFePi0x9XQQArv/twT03ZaEZoFxyuje50KHvvtR06uOVZVv8tu8ms5Qcv
 rWL34ituEjw0vS9x8WD8NnIFUZyXN2UyYbbA8E856nDi0eMNa9cPfq1r4GHpj373aa/wJG
 z3VTmMO0D9szDp3FlIEvK79plp14Y7M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-EcB6zIlcM8K4la79_T-Azg-1; Fri, 12 Jun 2020 12:12:12 -0400
X-MC-Unique: EcB6zIlcM8K4la79_T-Azg-1
Received: by mail-wr1-f71.google.com with SMTP id o1so4035115wrm.17
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 09:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/zajgHfeGGUTjGNPtfTDYhnjhMRAXOh06gflXef/o0s=;
 b=crGsUJAUhTeV4uXOTCF2hMrRfyVf4urxSRICl9tEgOTYC9+U/aRrZZ1wE/GF+LulnX
 7Zbo2yCTV/Xl7CjLHFxqIxsRF0MFfTmPXBHa9vo6HeCJHEMGjNUg8Rty6CEXyqGMr6Pg
 UQc0bs/jKMYkveMBGORsJUlkSk9yCx6P7/0aqhygs2udHJNUadY7r0C+V4d5YfX6+ycL
 60roqMkNIxI6Dt5Sux4kTcgQYaESQjZtwaMivlfZJksSseXSUCf83CRBSuCHMVWL8QHf
 QgaToA7bblf3LTSehDwiYeaCv7ADmHbxCL1msNurJKN574brkCZm0si2JsWl5yp8HRGf
 bq4A==
X-Gm-Message-State: AOAM530Bg1Euw1B2jVcYtsdliFAlczjX1rQ4cANcE05xNmkW8//LB4Ye
 so5ljUq7T+uECZt3i6WWEQdrUpHTdz7HeUaQu1LLyTxG9IRb5jzC7RRY8qg5ql1jyzC3nNRv2n9
 RIEdplDKHkVN2pzY=
X-Received: by 2002:a05:600c:218b:: with SMTP id
 e11mr14115475wme.162.1591978330865; 
 Fri, 12 Jun 2020 09:12:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwicCHffeicuyWsGuQO4n16sKx0up0C2BbdwUQFFOs0wcxHJVhVawsoZY/UyQoVrIhiUUvvPQ==
X-Received: by 2002:a05:600c:218b:: with SMTP id
 e11mr14115458wme.162.1591978330599; 
 Fri, 12 Jun 2020 09:12:10 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id v28sm12209311wra.77.2020.06.12.09.12.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 09:12:10 -0700 (PDT)
Date: Fri, 12 Jun 2020 12:12:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/56] virtio,acpi,pci: features, fixes, cleanups, tests
Message-ID: <20200612121155-mutt-send-email-mst@kernel.org>
References: <20200610042613.1459309-1-mst@redhat.com>
 <CAFEAcA-5yy9Gs57Cc7A8QJ=oSuUDaja+sBWt2miM5QiX65pOtA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-5yy9Gs57Cc7A8QJ=oSuUDaja+sBWt2miM5QiX65pOtA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 08:00:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 11, 2020 at 07:13:35PM +0100, Peter Maydell wrote:
> On Wed, 10 Jun 2020 at 05:26, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > The following changes since commit 49ee11555262a256afec592dfed7c5902d5eefd2:
> >/tmp/par8snSu.par
> 
> >   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.1-pull-request' into staging (2020-06-08 11:04:57 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to 23fe04b63b412276c7c2f67c550961af9d0b4e1e:
> >
> >   Fix parameter type in vhost migration log path (2020-06-09 14:18:04 -0400)
> >
> > ----------------------------------------------------------------
> > virtio,acpi,pci: features, fixes, cleanups, tests
> >
> > Max slots negotiation for vhost-user.
> > Free page reporting for balloon.
> > Partial TPM2 ACPI support for ARM.
> > Support for NVDIMMs having their own proximity domains.
> > New vhost-user-vsock device.
> >
> > Fixes, cleanups in ACPI, PCI, virtio.
> > New tests for TPM ACPI.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Hi; I'm afraid this has format string issues:
> 
> /Users/pm215/src/qemu-for-merges/hw/virtio/vhost-user.c:759:51: error:
> format specifies type 'unsigned long' but the argument has type
> 'uint64_t' (aka 'unsigned long long') [-Werror,-Wformat]
>                                  "%lX", __func__, reply_gpa,
>                                                   ^~~~~~~~~
> /Users/pm215/src/qemu-for-merges/hw/virtio/vhost-user.c:760:34: error:
> format specifies type 'unsigned long' but the argument has type
> 'uint64_t' (aka 'unsigned long long') [-Werror,-Wformat]
>                                  dev->mem->regions[reg_idx].guest_phys_addr);
>                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /Users/pm215/src/qemu-for-merges/hw/virtio/vhost-user.c:1876:67:
> error: format specifies type 'unsigned long' but the argument has type
> 'uint64_t' (aka 'unsigned long long') [-Werror,-Wformat]
>                              "This limit should never decrease.", ram_slots,
>                                                                   ^~~~~~~~~
> 
> (repros on OSX, OpenBSD, and 32-bit hosts)
> 
> thanks
> -- PMM

Fixed and sent v2, thanks!

-- 
MST


