Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E14CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:06:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88AD52084B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88AD52084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMxc9-00089y-6N
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 13:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iMxMl-0005ib-DB
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:50:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iMxMj-0002ad-GW
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:50:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48520)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iMxMj-0002aH-8E
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:50:37 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 59B91C049E17
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 16:50:36 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id o8so7755898wmc.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 09:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ilUdqbrYy8ySaTQ6ZcthNEde+QTyn7VVTo6FG7DI6ho=;
 b=N+u3I5m4WxWizTYKq3U+OeJ5eYNJgkFtboXjFMtWfVnAjBbZvXXEfM+bnoBGWxVPvV
 89TjRIq19/pvlSB9NMtUf/mG3LTBunSwjIkEZNJiLHtnzg8b9NEcg73/3mOKx9gpfHg4
 GcQr3UpCNKfX5ezy/JT7kNSZyfR+MXjKjH3+l5gaH4l3PVhd6rU321PdvHacWsb6FELP
 AMRo8dvcksMuCiPolEW4wyQAdcyHBxVAMv+vqbvJvexmc6cuYH34jtjCQJ2RlHHEYh12
 jWT9UuG9uuwxztJaRpBDDx+v4JLvNh9cjPLKIA6ahQPLIDn3eaPe2TSmsno6WoqMP6GK
 LZRA==
X-Gm-Message-State: APjAAAWobPKVC7NTbsuSNSeWP+4izInisRRtVpnQsWpYZ061cwIa6tRw
 GztQeTSR4vsJxGQCPUYt/YiujAFPk3z+PMV8NiPlLBQ+qzqv8YGxrpa0x8ghA7MTnsMvEDSRGt/
 DTvK5BPH8Ed103ro=
X-Received: by 2002:a5d:638c:: with SMTP id p12mr3966510wru.136.1571763035004; 
 Tue, 22 Oct 2019 09:50:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx4hJVmjBEEIjlMnRd/woKAUXyjdR00JU3x721XYw4PDBHU0IVP/HgLbhGW9Zh+iu6O8gJCcQ==
X-Received: by 2002:a5d:638c:: with SMTP id p12mr3966487wru.136.1571763034703; 
 Tue, 22 Oct 2019 09:50:34 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c0e4:dcf4:b543:ce19?
 ([2001:b07:6468:f312:c0e4:dcf4:b543:ce19])
 by smtp.gmail.com with ESMTPSA id w18sm1678274wrl.75.2019.10.22.09.50.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2019 09:50:34 -0700 (PDT)
Subject: Re: [PATCH RESEND v6 0/2] x86: Enable user wait instructions
To: Tao Xu <tao3.xu@intel.com>, rth@twiddle.net, ehabkost@redhat.com,
 mtosatti@redhat.com
References: <20191011074103.30393-1-tao3.xu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <393ea49d-1da3-9454-eae3-f8393a6ce72b@redhat.com>
Date: Tue, 22 Oct 2019 18:50:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191011074103.30393-1-tao3.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: jingqi.liu@intel.com, qemu-devel@nongnu.org, kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/10/19 09:41, Tao Xu wrote:
> UMONITOR, UMWAIT and TPAUSE are a set of user wait instructions.
>=20
> UMONITOR arms address monitoring hardware using an address. A store
> to an address within the specified address range triggers the
> monitoring hardware to wake up the processor waiting in umwait.
>=20
> UMWAIT instructs the processor to enter an implementation-dependent
> optimized state while monitoring a range of addresses. The optimized
> state may be either a light-weight power/performance optimized state
> (c0.1 state) or an improved power/performance optimized state
> (c0.2 state).
>=20
> TPAUSE instructs the processor to enter an implementation-dependent
> optimized state c0.1 or c0.2 state and wake up when time-stamp counter
> reaches specified timeout.
>=20
> Availability of the user wait instructions is indicated by the presence
> of the CPUID feature flag WAITPKG CPUID.0x07.0x0:ECX[5].
>=20
> The patches enable the umonitor, umwait and tpause features in KVM.
> Because umwait and tpause can put a (psysical) CPU into a power saving
> state, by default we dont't expose it in kvm and provide a capability t=
o
> enable it. Use kvm capability to enable UMONITOR, UMWAIT and TPAUSE whe=
n
> QEMU use "-overcommit cpu-pm=3Don, a VM can use UMONITOR, UMWAIT and TP=
AUSE
> instructions. If the instruction causes a delay, the amount of time
> delayed is called here the physical delay. The physical delay is first
> computed by determining the virtual delay (the time to delay relative t=
o
> the VM=E2=80=99s timestamp counter). Otherwise, UMONITOR, UMWAIT and TP=
AUSE cause
> an invalid-opcode exception(#UD).
>=20
> The release document ref below link:
> https://software.intel.com/sites/default/files/\
> managed/39/c5/325462-sdm-vol-1-2abcd-3abcd.pdf
>=20
> Changelog:
> v6:
> 	Remove CPUID_7_0_ECX_WAITPKG if enable_cpu_pm is not set.
>         (Paolo)
>=20
> Tao Xu (2):
>   x86/cpu: Add support for UMONITOR/UMWAIT/TPAUSE
>   target/i386: Add support for save/load IA32_UMWAIT_CONTROL MSR
>=20
>  target/i386/cpu.c     |  2 +-
>  target/i386/cpu.h     |  3 +++
>  target/i386/kvm.c     | 19 +++++++++++++++++++
>  target/i386/machine.c | 20 ++++++++++++++++++++
>  4 files changed, 43 insertions(+), 1 deletion(-)
>=20

Queued, thanks.

Paolo

