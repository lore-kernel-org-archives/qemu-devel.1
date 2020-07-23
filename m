Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAF0C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:57:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65E052080D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QGg8kgtB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E052080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyYuN-0001zp-Ll
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 06:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jyYtY-0001S5-8d
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:56:12 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54581
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jyYtV-0002Gu-RF
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595501768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b6X8qFJx/IqTp02I2ZdrYezF4P3ZtRQwnPIjjdbJG+Y=;
 b=QGg8kgtBFY0zsclNPwtIXiOluYsCmuQTbsro7YxozkeEF93QAWY3WPuKB/jO6qBzFCc5/w
 M2RiwOMmhI6io4YsrhDzptwdDdNLJiUtEAB0zCGKwGyuN9Ujg1UCdx+uXEHC0Y0fUDSSsY
 UEjzTX+/tdAxlbV9htVX+eu4sL+oULI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-VkCUSjLVP7y93x5vWloqMg-1; Thu, 23 Jul 2020 06:56:04 -0400
X-MC-Unique: VkCUSjLVP7y93x5vWloqMg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55A82800460;
 Thu, 23 Jul 2020 10:56:02 +0000 (UTC)
Received: from gondolin (ovpn-112-228.ams2.redhat.com [10.36.112.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C499B8FA23;
 Thu, 23 Jul 2020 10:55:54 +0000 (UTC)
Date: Thu, 23 Jul 2020 12:55:52 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH 1/2] ppc: Rename current DAWR macros
Message-ID: <20200723125552.7668d946.cohuck@redhat.com>
In-Reply-To: <20200723104220.314671-2-ravi.bangoria@linux.ibm.com>
References: <20200723104220.314671-1-ravi.bangoria@linux.ibm.com>
 <20200723104220.314671-2-ravi.bangoria@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:26:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: christophe.leroy@c-s.fr, qemu-ppc@nongnu.org, mikey@neuling.org,
 rogealve@br.ibm.com, kvm@vger.kernel.org, mst@redhat.com, mpe@ellerman.id.au,
 qemu-devel@nongnu.org, npiggin@gmail.com, paulus@samba.org, clg@kaod.org,
 jniethe5@gmail.com, pedromfc@br.ibm.com, pbonzini@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Jul 2020 16:12:19 +0530
Ravi Bangoria <ravi.bangoria@linux.ibm.com> wrote:

> Power10 is introducing second DAWR. Use real register names (with
> suffix 0) from ISA for current macros.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  include/hw/ppc/spapr.h          | 2 +-
>  linux-headers/asm-powerpc/kvm.h | 4 ++--
>  target/ppc/cpu.h                | 4 ++--
>  target/ppc/translate_init.inc.c | 8 ++++----
>  4 files changed, 9 insertions(+), 9 deletions(-)
> 

(...)

> diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/kvm.h
> index 264e266a85..38d61b73f5 100644
> --- a/linux-headers/asm-powerpc/kvm.h
> +++ b/linux-headers/asm-powerpc/kvm.h
> @@ -608,8 +608,8 @@ struct kvm_ppc_cpu_char {
>  #define KVM_REG_PPC_BESCR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xa7)
>  #define KVM_REG_PPC_TAR		(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xa8)
>  #define KVM_REG_PPC_DPDES	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xa9)
> -#define KVM_REG_PPC_DAWR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xaa)
> -#define KVM_REG_PPC_DAWRX	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xab)
> +#define KVM_REG_PPC_DAWR0	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xaa)
> +#define KVM_REG_PPC_DAWRX0	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xab)
>  #define KVM_REG_PPC_CIABR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xac)
>  #define KVM_REG_PPC_IC		(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xad)
>  #define KVM_REG_PPC_VTB		(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xae)

Changes here need to come in via a proper headers sync, so this needs
to be split out into a separate patch (either one doing a headers sync,
or a placeholder if the Linux changes are not upstream yet.)


