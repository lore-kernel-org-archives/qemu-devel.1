Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A504C3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 18:48:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01C292186A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 18:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C292186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3lwI-0001go-5L
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 14:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36351)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1i3lul-0000gQ-Gw
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 14:46:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1i3luj-00010u-IT
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 14:46:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37908)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1i3luh-0000zw-LP
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 14:46:25 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F10813001839;
 Fri, 30 Aug 2019 18:46:20 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-53.ams2.redhat.com
 [10.36.116.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86DE660F80;
 Fri, 30 Aug 2019 18:46:15 +0000 (UTC)
To: Igor Mammedov <imammedo@redhat.com>
References: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
 <D2A45071-A097-4642-A34C-6B7C5D7D2466@intel.com>
 <E92EE9817A31E24EB0585FDF735412F5B9D9C671@ORSMSX113.amr.corp.intel.com>
 <a76014e2-2f0a-afce-6d15-1c45c5c1e467@redhat.com>
 <b3907432-b149-3f96-6d93-f443f215e0f8@redhat.com>
 <2b4ba607-f0e3-efee-6712-6dcef129b310@redhat.com>
 <E92EE9817A31E24EB0585FDF735412F5B9DA209B@ORSMSX113.amr.corp.intel.com>
 <7f2d2f1e-2dd8-6914-c55e-61067e06b142@redhat.com>
 <E92EE9817A31E24EB0585FDF735412F5B9DA218F@ORSMSX113.amr.corp.intel.com>
 <3661c0c5-3da4-1453-a66a-3e4d4022e876@redhat.com>
 <E92EE9817A31E24EB0585FDF735412F5B9DA2346@ORSMSX113.amr.corp.intel.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F76FDAF@shsmsx102.ccr.corp.intel.com>
 <E92EE9817A31E24EB0585FDF735412F5B9DA25CC@ORSMSX113.amr.corp.intel.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F7728AB@shsmsx102.ccr.corp.intel.com>
 <20190827203102.56d0d048@redhat.com>
 <033ced1a-1399-968e-cce6-6b15a20b0baf@redhat.com>
 <20190830164802.1b17ff26@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a43d47e0-6e99-ad42-77d4-638421e8768c@redhat.com>
Date: Fri, 30 Aug 2019 20:46:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190830164802.1b17ff26@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 30 Aug 2019 18:46:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [edk2-rfc] [edk2-devel] CPU hotplug using SMM with
 QEMU+OVMF
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
Cc: "Chen, Yingwen" <yingwen.chen@intel.com>,
 "devel@edk2.groups.io" <devel@edk2.groups.io>,
 Phillip Goerl <phillip.goerl@oracle.com>,
 qemu devel list <qemu-devel@nongnu.org>,
 Alex Williamson <alex.williamson@redhat.com>, "Yao,
 Jiewen" <jiewen.yao@intel.com>, "Nakajima, Jun" <jun.nakajima@intel.com>,
 "Kinney, Michael D" <michael.d.kinney@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 "rfc@edk2.groups.io" <rfc@edk2.groups.io>,
 Joao Marcal Lemos Martins <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/30/19 16:48, Igor Mammedov wrote:

> (01) On boot firmware maps and initializes SMI handler at default SMBASE (30000)
>      (using dedicated SMRAM at 30000 would allow us to avoid save/restore
>       steps and make SMM handler pointer not vulnerable to DMA attacks)
> 
> (02) QEMU hotplugs a new CPU in reset-ed state and sends SCI
> 
> (03) on receiving SCI, host CPU calls GPE cpu hotplug handler
>       which writes to IO port 0xB2 (broadcast SMI)
> 
> (04) firmware waits for all existing CPUs rendezvous in SMM mode,
>      new CPU(s) have SMI pending but does nothing yet
> 
> (05) host CPU wakes up one new CPU (INIT-INIT-SIPI)
>      SIPI vector points to RO flash HLT loop.
>      (how host CPU will know which new CPUs to relocate?
>       possibly reuse QEMU CPU hotplug MMIO interface???)
> 
> (06) new CPU does relocation.
>      (in case of attacker sends SIPI to several new CPUs,
>       open question how to detect collision of several CPUs at the same default SMBASE)
> 
> (07) once new CPU relocated host CPU completes initialization, returns
>      from IO port write and executes the rest of GPE handler, telling OS
>      to online new CPU.

In step (03), it is the OS that handles the SCI; it transfers control to
ACPI. The AML can write to IO port 0xB2 only because the OS allows it.

If the OS decides to omit that step, and sends an INIT-SIPI-SIPI
directly to the new CPU, can it steal the CPU?

Thanks!
Laszlo

