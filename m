Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C88C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:01:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C6342089D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KB94lkVW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6342089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXm5b-0004zd-Mt
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 08:01:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iXm4G-0004DG-Cj
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:00:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iXm4E-0002vj-Ee
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:00:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54428
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iXm4E-0002uc-82
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:00:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574341213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=02LTBZBXyYH8ohJuddqI7urD7+YXTg229JXtq6n1Rj8=;
 b=KB94lkVW5ORVPsRgmWjROQUb9SwwIfggITcgyXsEkILfeKbvEuMYZTY58alPQLWKIaV5gW
 G/moc9u9DC2drEM+yYI4OC6XFylTYG+FtiGAYoR7B7yIiOOcl3G1pf2TI2UyMqkq79INoN
 dx3pRswM0yiNU8Cwv/TUPJ2zTsfrIRo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-rxQfZnYsMvecTyT7Kbdp5w-1; Thu, 21 Nov 2019 08:00:10 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10EBF801E5B;
 Thu, 21 Nov 2019 13:00:09 +0000 (UTC)
Received: from gondolin (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2965C1081304;
 Thu, 21 Nov 2019 13:00:02 +0000 (UTC)
Date: Thu, 21 Nov 2019 13:59:59 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH 04/15] Header sync protvirt
Message-ID: <20191121135959.3fc8f10b.cohuck@redhat.com>
In-Reply-To: <20191120114334.2287-5-frankja@linux.ibm.com>
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-5-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: rxQfZnYsMvecTyT7Kbdp5w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 Nov 2019 06:43:23 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Let's sync all the protvirt header changes
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  linux-headers/asm-s390/kvm.h |  3 ++-
>  linux-headers/linux/kvm.h    | 42 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+), 1 deletion(-)
>=20

> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index 18892d6541..d031051601 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -995,6 +995,8 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_ARM_SVE 170
>  #define KVM_CAP_ARM_PTRAUTH_ADDRESS 171
>  #define KVM_CAP_ARM_PTRAUTH_GENERIC 172
> +#define KVM_CAP_S390_PROTECTED 180
> +#define KVM_CAP_S390_VCPU_RESETS 181

Hm, where does this cap come from? I did not see it in the kernel
patches.

> =20
>  #ifdef KVM_CAP_IRQ_ROUTING
> =20


