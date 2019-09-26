Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D688C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 09:16:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB6B8207FF
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 09:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dLTRxWMl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB6B8207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDPtN-0003E3-WD
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 05:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iDPs8-0002Gf-P1
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iDPs5-0002ur-Gd
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:15:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25172
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iDPs5-0002sM-6p
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1569489330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=1CXSJYMSa0bMX6jVLeBid64jArpSi45Ltz9A9++Mei8=;
 b=dLTRxWMlXzVEOqm9AwjTNZVL4BDaJvmeNEDRBbJmJQcbZR8+UZoFLKj4EjvBvIg8saFao3
 0TciwH8vr/KAm8M5syvSVC0op10D+AIz53mQMHYvCEdBKAxRdBdjAe59bOCb0aIdMYo/SV
 tKOq8aW7XHINl++tpFhsJEvf7nXGHM8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-BOMJT2lbPmSb4MgT3PxPSw-1; Thu, 26 Sep 2019 05:15:28 -0400
Received: by mail-wm1-f71.google.com with SMTP id r187so3886422wme.0
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 02:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LHwbg/V4jRqHoU9llG3h2fkmzHxP3Up5F7xXWYnj2ws=;
 b=dXJHKZTO2xHKYJPsfwmnTI9My1aFQ/Yd4U3Gri21X1w17kkcFunGgxkdKjjsLBovG1
 w6u4nMAyx16P5AO3MYZjbI32HDxJERXlprjA0GSdUkco3DV8GIg5xlZ6gkgAkwYNPBB/
 +ypWpiCfzoyfSrhtDX4hQrDSKhXLzZerRSkKzIMoZVK5ZKRC5DCzyeFfW5NPDwgVzK6/
 7mDicfbnVWeLgkO3A1SOdWzB7RSQro0D0ENTYAaaZ7GoyKsirrZgw9I7MVeTD82CREjN
 JIy/sqdT6w87rApIViylsXjb3ayAXHD1rOZB6OVoi0tBDlwZ/GJTb4h2gqBq4Sy3Nm9N
 LqZw==
X-Gm-Message-State: APjAAAX7zx8xZ68o3dC8PxunzKT67gKoxHBYXStlAiFwy9m0yFM/Us6w
 mDaBYOfFto2YhGldU5HXU9AG4X0BCvPMXqOj0wystgqB2+xdFaFFPf2MuzfsxKMKiKlst2rn3Ec
 KlWfjkTukAo1pFHk=
X-Received: by 2002:a5d:51d2:: with SMTP id n18mr2082142wrv.10.1569489327051; 
 Thu, 26 Sep 2019 02:15:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwnN21VklimipHKP7Ptoa8dyD5lrtQAuxAn4RwUYqTCsizwEODmEDTXZBQv2Dgr9CC3l8ffMg==
X-Received: by 2002:a5d:51d2:: with SMTP id n18mr2082122wrv.10.1569489326752; 
 Thu, 26 Sep 2019 02:15:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36?
 ([2001:b07:6468:f312:9520:22e6:6416:5c36])
 by smtp.gmail.com with ESMTPSA id v6sm2917645wma.24.2019.09.26.02.15.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2019 02:15:26 -0700 (PDT)
Subject: Re: Questions about the real mode in kvm/qemu
To: Li Qiang <liq3ea@gmail.com>, Qemu Developers <qemu-devel@nongnu.org>
References: <CAKXe6SJfZt8WcA43Vsh0=GT=jBedcAOUx9DNGZ4Bsvi10oCkog@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <b24f9938-d0a7-2680-0078-c02e1abebc59@redhat.com>
Date: Thu, 26 Sep 2019 11:15:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKXe6SJfZt8WcA43Vsh0=GT=jBedcAOUx9DNGZ4Bsvi10oCkog@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: BOMJT2lbPmSb4MgT3PxPSw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/09/19 09:52, Li Qiang wrote:
> Hi Paolo and all,
>=20
> There are some question about the emulation for real mode in kvm/qemu.
> For all the=C2=A0
> question I suppose the 'unstrict guest' is not enabled.=C2=A0
>=20
> 1. how the protected mode CPU emulate the real mode? It seems it uses
> vm86, however, vm86 is not available in x86_64 CPU? So what's the
> 'to_vmx(vcpu)->rmode.vm86_active' here vm86 means?

vm86 mode is available in 64-bit CPUs; it is not available in 64-bit
mode (EFER.LMA=3D1).

Once KVM places the processor in VMX non-root mode (VMLAUNCH/VMRESUME),
the processor can leave 64-bit mode and run in vm86 mode.  And that's
exactly what KVM does on processors without unrestricted guest support.

In that mode, KVM will start trapping all exceptions and send them to
handle_rmode_exception.  This in turn will either emulate privileged
instructions (for #GP or #SS) or inject them as realmode exceptions.

However...

> 2. Does the guest's real mode code run directly in native CPU? It seems
> 'vmx->emulation_required' is also be false, it the vmx_vcpu_run will do
> a switch to guest.

... as soon as the guest tries to enter protected mode, it will get into
a situation which is not real mode but doesn't have the segment
registers properly loaded with selectors.  Therefore, it will either
hack things together (enter_pmode) or emulate instructions until the
state is accepted even without unrestricted guest support.

The "hacking things together" part however does not work for big real
mode (where you enter 32-bit mode, load segment registers with a flat 4G
segment, and go back to real mode with the 4G segments).  In big real
mode, therefore, KVM cannot use vm86 and will keep emulating (slowly -
up to 1000x slower than unrestricted guest).

> 3. How the EPT work in guest real mode? The EPT is for GVA->GPA->HPA,
> however there is no GVA, seems the identity mapping does something. But
> there also some confusion for me. For example the real mode uses CS*4=C2=
=A0+
> IP to address the code.=C2=A0 Who does this calculation? In the kernel em=
ulator?=C2=A0

Right, and in fact the CR0.PG and CR0.PE bits must be 1 when running in
VMX non-root mode with unrestricted guest disabled.

Therefore, KVM places a 4 KiB identity map at an address provided by
userspace (with KVM_SET_IDENTITY_MAP_ADDR).  When 1) EPT is enabled 2)
unrestricted guest isn't 3) CR0.PG=3D0, KVM points CR3 to it and runs the
guest with CR0.PG=3D1, CR4.PAE=3D0, CR4.PSE=3D1.  This CR4 setup enables 4 =
MiB
huge pages so that a 4 GiB identity map fits in 4 KiB.  This is the only
case where EPT is enabled but CR3 loads and stores will trap to the
hypervisor.  This way, the guest CR3 value is faked in the vmexit
handler, but the processor always uses the identity GVA->GPA mapping.

Paolo


