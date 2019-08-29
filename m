Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D31EC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:10:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA58B2173E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA58B2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Nvz-0006V6-Kw
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 13:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1i3Nnq-0004Jn-8U
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:01:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1i3Nno-0004Nd-Et
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:01:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54161)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1i3Nno-0004NF-5t
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:01:40 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5142B2D6A23;
 Thu, 29 Aug 2019 17:01:39 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-174.ams2.redhat.com
 [10.36.117.174])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 652F860C05;
 Thu, 29 Aug 2019 17:01:36 +0000 (UTC)
To: Igor Mammedov <imammedo@redhat.com>, "Yao, Jiewen" <jiewen.yao@intel.com>
References: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
 <35396800-32d2-c25f-b0d0-2d7cd8438687@redhat.com>
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
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <033ced1a-1399-968e-cce6-6b15a20b0baf@redhat.com>
Date: Thu, 29 Aug 2019 19:01:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190827203102.56d0d048@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 29 Aug 2019 17:01:39 +0000 (UTC)
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
 Alex Williamson <alex.williamson@redhat.com>, "Nakajima,
 Jun" <jun.nakajima@intel.com>, "Kinney,
 Michael D" <michael.d.kinney@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 "rfc@edk2.groups.io" <rfc@edk2.groups.io>,
 Joao Marcal Lemos Martins <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/27/19 20:31, Igor Mammedov wrote:
> On Sat, 24 Aug 2019 01:48:09 +0000
> "Yao, Jiewen" <jiewen.yao@intel.com> wrote:

>> (05) Host CPU: (OS) Port 0xB2 write, all CPUs enter SMM (NOTE: New CPU
>>      will not enter CPU because SMI is disabled)
> I think only CPU that does the write will enter SMM

That used to be the case (and it is still the default QEMU behavior, if
broadcast SMI is not negotiated). However, OVMF does negotiate broadcast
SMI whenever QEMU offers the feature. Broadcast SMI is important for the
stability of the edk2 SMM infrastructure on QEMU/KVM, we've found.

https://bugzilla.redhat.com/show_bug.cgi?id=1412313
https://bugzilla.redhat.com/show_bug.cgi?id=1412327

> and we might not need to pull in all already initialized CPUs into SMM.

That, on the other hand, could be a valid idea. But then the CPU should
use a different method for raising a synchronous SMI for itself (not a
write to IO port 0xB2). Is a "directed SMI for self" possible?

> [...]

I've tried to read through the procedure with your suggested changes,
but I'm failing at composing a coherent mental image, in this email
response format.

If you have the time, can you write up the suggested list of steps in a
"flat" format? (I believe you are suggesting to eliminate some steps
completely.)

... jumping to another point:

>> 2) Let trusted software (SMM and init code) guarantee SMREBASE one by one (include any code runs before SMREBASE)
> that would mean pulling all present CPUs into SMM mode so no attack
> code could be executing before doing hotplug. With a lot of present CPUs
> it could be quite expensive and unlike physical hardware, guest's CPUs
> could be preempted arbitrarily long causing long delays.

I agree with your analysis, but I slightly disagree about the impact:

- CPU hotplug is not a frequent administrative action, so the CPU load
should be temporary (it should be a spike). I don't worry that it would
trip up OS kernel code. (SMI handling is known to take long on physical
platforms oo.) In practice, all "normal" SMIs are broadcast already (for
example when calling the runtime UEFI variable services from the OS kernel).

- The fact that QEMU/KVM introduces some jitter into the execution of
multi-core code (including SMM code) has proved useful in the past, for
catching edk2 regressions.

Again, this is not a strong disagreement from my side. I'm open to
better ways for synching CPUs during muti-CPU-hotplug.

(Digression:

I expect someone could be curious why (a) I find it acceptable (even
beneficial) that "some jitter" injected by the QEMU/KVM scheduling
exposes multi-core regressions in edk2, but at the same time (b) I found
it really important to add broadcast SMI to QEMU and OVMF. After all,
both "jitter" and "unicast SMIs" are QEMU/KVM platform specifics, so why
the different treatment?

The reason is that the "jitter" does not interfere with normal
operation, and it has been good for catching *regressions*. IOW, there
is a working edk2 state, someone posts a patch, works on physical
hardware, but breaks on QEMU/KVM --> then we can still reject or rework
or revert the patch. And we're back to a working state again (in the
best case, with a fixed feature patch).

With the unicast SMIs however, it was impossible to enable the SMM stack
reliably in the first place. There was no functional state to return to.

Digression ends.)

> lets first see if if we can ignore race

Makes me uncomfortable, but if this is the consensus, I'll go along.

> and if it's not then
> we probably end up with implementing some form of #1

OK.

Thanks!
Laszlo

