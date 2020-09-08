Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C562EC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:00:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E92082098B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OElpKPGT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92082098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFhvC-0001rB-E2
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 14:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kFhuN-0001Q6-J8
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 13:59:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30719
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kFhuL-0004FR-7f
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 13:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599587991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9CW6GTTByHXIDweFDq5CSJHeo7NzoqrcX1WaKn85ggc=;
 b=OElpKPGTrCqxigMF0zLIjo15DoOrru9MgrYOlRSeu2wd8wUW80svJpf71/N0I/b+RFCdze
 a89C0rKsmz4pdcnrktRdbHlOcrXCT40cjN9F5sU455aXd/PDyf1DKJWlzzUFR032xRnaFq
 s4RRbWluyao6dVSF0/Oj9WN7qCzrBq8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-hYJjeqfuPzWd8JzkL8yyvg-1; Tue, 08 Sep 2020 13:59:49 -0400
X-MC-Unique: hYJjeqfuPzWd8JzkL8yyvg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2546710BBEC1;
 Tue,  8 Sep 2020 17:59:48 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 532B93A40;
 Tue,  8 Sep 2020 17:59:47 +0000 (UTC)
Date: Tue, 8 Sep 2020 13:59:46 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH V2 for-5.2] hw/null-machine: Add the kvm_type() hook for
 MIPS
Message-ID: <20200908175946.GF1618070@habkost.net>
References: <1598256668-12131-1-git-send-email-chenhc@lemote.com>
 <caa3c014-ba68-0875-4dd5-faed9282ca95@redhat.com>
MIME-Version: 1.0
In-Reply-To: <caa3c014-ba68-0875-4dd5-faed9282ca95@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 01:08:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Peter Maydell <peter.maydell@linaro.org>, Huacai Chen <chenhuacai@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 David Gibson <dgibson@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 08, 2020 at 07:25:47PM +0200, Thomas Huth wrote:
> On 24/08/2020 10.11, Huacai Chen wrote:
> > MIPS has two types of KVM: TE & VZ, and TE is the default type. Now,
> > libvirt uses a null-machine to detect the kvm capability. In the MIPS
> > case, it will return "KVM not supported" on a VZ platform by default.
> > So, add the kvm_type() hook to the null-machine.
> > 
> > This seems not a very good solution, but I cannot do it better now.
> 
> This is still ugly. Why do the other architectures do not have the
> same problem? Let's see... in kvm-all.c, we have:
> 
>     int type = 0;
>     [...]
>     kvm_type = qemu_opt_get(qemu_get_machine_opts(), "kvm-type");
>     if (mc->kvm_type) {
>         type = mc->kvm_type(ms, kvm_type);
>     } else if (kvm_type) {
>         ret = -EINVAL;
>         fprintf(stderr, "Invalid argument kvm-type=%s\n", kvm_type);
>         goto err;
>     }
> 
>     do {
>         ret = kvm_ioctl(s, KVM_CREATE_VM, type);
>     } while (ret == -EINTR);
> 
> Thus the KVM_CREATE_VM ioctl is likely called with type = 0 in this
> case (i.e. when libvirt probes with the "null"-machine).
> 
> Now let's have a look at the kernel. The "type" parameter is passed
> there to the architecture specific function kvm_arch_init_vm().
> For powerpc, this looks like:
> 
> 	if (type == 0) {
> 		if (kvmppc_hv_ops)
> 			kvm_ops = kvmppc_hv_ops;
> 		else
> 			kvm_ops = kvmppc_pr_ops;
> 		if (!kvm_ops)
> 			goto err_out;
> 	} else	if (type == KVM_VM_PPC_HV) {
> 		if (!kvmppc_hv_ops)
> 			goto err_out;
> 		kvm_ops = kvmppc_hv_ops;
> 	} else if (type == KVM_VM_PPC_PR) {
> 		if (!kvmppc_pr_ops)
> 			goto err_out;
> 		kvm_ops = kvmppc_pr_ops;
> 	} else
> 		goto err_out;
> 
> That means for type == 0, it automatically detects the best
> kvm-type.
> 
> For mips, this function looks like this:
> 
> 	switch (type) {
> #ifdef CONFIG_KVM_MIPS_VZ
> 	case KVM_VM_MIPS_VZ:
> #else
> 	case KVM_VM_MIPS_TE:
> #endif
> 		break;
> 	default:
> 		/* Unsupported KVM type */
> 		return -EINVAL;
> 	};
> 
> That means, for type == 0, it returns -EINVAL here!
> 
> Looking at the API docu in Documentation/virt/kvm/api.rst
> the description of the type parameter is quite sparse, but it
> says:
> 
>  "You probably want to use 0 as machine type."
> 
> So I think this is a bug in the implementation of KVM in the
> mips kernel code. The kvm_arch_init_vm() in the mips code should
> do the same as on powerpc, and use the best available KVM type
> there instead of returning EINVAL. Once that is fixed there,
> you don't need this patch here for QEMU anymore.

If there's a way to make it work with older kernels, I assume we
would still want to do it.

However, this kind of kvm-specific + arch-specific knowledge
doesn't belong to machine core code.  If we are going to add a
#ifdef TARGET_MIPS to the code, we can simply do it inside
kvm-all.c:kvm_init().

-- 
Eduardo


