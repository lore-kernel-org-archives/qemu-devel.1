Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4DAC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 14:35:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 490C524A38
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 14:35:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 490C524A38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53488 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYAXS-000702-W5
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 10:35:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hYAWc-0006cf-0l
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 10:34:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hYAWa-0008S7-SB
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 10:34:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1hYAWa-0008RJ-Mo
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 10:34:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CAA80C05D275;
	Tue,  4 Jun 2019 14:34:36 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EE82860FD5;
	Tue,  4 Jun 2019 14:34:32 +0000 (UTC)
Date: Tue, 4 Jun 2019 16:34:30 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Message-ID: <20190604163430.0375fe01.cohuck@redhat.com>
In-Reply-To: <20190524081839.6228-2-tao3.xu@intel.com>
References: <20190524081839.6228-1-tao3.xu@intel.com>
	<20190524081839.6228-2-tao3.xu@intel.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Tue, 04 Jun 2019 14:34:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/2] x86/cpu: Add support for
 UMONITOR/UMWAIT/TPAUSE
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
	jingqi.liu@intel.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
	pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 May 2019 16:18:38 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> UMONITOR, UMWAIT and TPAUSE are a set of user wait instructions.
> Availability of the user wait instructions is indicated by the presence
> of the CPUID feature flag WAITPKG CPUID.0x07.0x0:ECX[5].
>=20
> The patch enable the umonitor, umwait and tpause features in KVM.
> Because umwait and tpause can put a (psysical) CPU into a power saving
> state, by default we dont't expose it in kvm and provide a capability to
> enable it. Use kvm capability to enable UMONITOR, UMWAIT and TPAUSE when
> QEMU use "-overcommit cpu-pm=3Don, a VM can use UMONITOR, UMWAIT and TPAU=
SE
> instructions. If the instruction causes a delay, the amount of time
> delayed is called here the physical delay. The physical delay is first
> computed by determining the virtual delay (the time to delay relative to
> the VM=E2=80=99s timestamp counter). Otherwise, UMONITOR, UMWAIT and TPAU=
SE cause
> an invalid-opcode exception(#UD).
>=20
> The release document ref below link:
> https://software.intel.com/sites/default/files/\
> managed/39/c5/325462-sdm-vol-1-2abcd-3abcd.pdf
>=20
> Co-developed-by: Jingqi Liu <jingqi.liu@intel.com>
> Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
>  linux-headers/linux/kvm.h |  1 +
>  target/i386/cpu.c         |  3 ++-
>  target/i386/cpu.h         |  1 +
>  target/i386/kvm.c         | 13 +++++++++++++
>  4 files changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index c8423e760c..86cc2dbdd0 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -993,6 +993,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_ARM_SVE 170
>  #define KVM_CAP_ARM_PTRAUTH_ADDRESS 171
>  #define KVM_CAP_ARM_PTRAUTH_GENERIC 172
> +#define KVM_CAP_ENABLE_USR_WAIT_PAUSE 173
> =20
>  #ifdef KVM_CAP_IRQ_ROUTING
> =20

No comment on the actual change, but please split out any linux-header
changes so they can be replaced with a proper headers update when the
code is merged.

