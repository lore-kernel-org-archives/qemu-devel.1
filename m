Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11FCC432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 07:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CEDC206B7
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 07:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6aJbJkP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CEDC206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDOdS-0004hQ-Jv
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 03:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1iDObh-0002Pe-K6
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 03:54:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1iDObf-0000Oh-GM
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 03:54:32 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:40856)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1iDObc-0000Na-BO
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 03:54:31 -0400
Received: by mail-ot1-f50.google.com with SMTP id y39so1178440ota.7
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 00:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=Iggeq//X0jv7dmcGtymgccOrzRD6DKDwHyhDLoujCdM=;
 b=c6aJbJkPyZqIdCMRvjwz1D2SHTqNgKBQux9Q8pesXWBiXcw3ryZFlnDXQkEeosiTtj
 np/EtDnp4zLJcEfL5zC0A/Q1UaLu1ONiU3qmqL0Du6DGU6TB6re5u4qa/6RxwnfPx24z
 fcH6/8GEFODFe9crIpPlLJg1KAOnZOkVPzx41n7z4j8wB+snCoTiGUNb8FgI8ESwBtHu
 gBlEujAEIm4wb0W5xKhoDcNrUtUaWaxoCEOpodrcFz3LDyNfAb4nDpuq4G6NJDyrBI+3
 R03a86Hosl39eYuMEyhGZY/RtPNW5GQdfx9Rodmhqa+GePWttrpVDgVfAmV8DSzobMal
 AyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=Iggeq//X0jv7dmcGtymgccOrzRD6DKDwHyhDLoujCdM=;
 b=M0BBIGX/gO8oxtkK861VoNa4NU+9n4pvLD9L7njhalB6MY3+zl1BOSh0RwhXSb3Evf
 Wo2a8xgEKP9lKuuDsx4xdAXiAtAAr11DSwzDnboQhfp5sthI6XI3ZypfmTHlI/Yv+agz
 UxfPYsqq0VP22zWMzYbgTJQPk4OOyo86gghX7LZ5lxoy8hpCc3CD9qn2oezB5/OVv8Fu
 XDzET4fwFKYX07kuCLe/ckEC2a15cFmL8/aXYBtP/VOr90926dTMzQHezPxge6AF5//D
 49eG7YRTV/l9G/Q+jKiLm8x6PHTf1gydJ76/YFlTVLVYfltAy2L7YLS7BR+Q+7aamUNk
 kzxg==
X-Gm-Message-State: APjAAAXMLPlOv9li2OmvpmeS+Z4yP/3kXCvI7f6r8rdgZgkh27RrLW0Z
 C9sKzrtyRXxS3jw9nKCmFo7bS6mfE0vAIgr29xs=
X-Google-Smtp-Source: APXvYqxTJjooUWua44mCxW2MWfeYERPuTfCGDY6DGKQ7WjVhZZuuAFx+R51g6nmd0TnWl/RVjXr3tsnU7BF1vEPWZLo=
X-Received: by 2002:a9d:821:: with SMTP id 30mr123244oty.194.1569484406498;
 Thu, 26 Sep 2019 00:53:26 -0700 (PDT)
MIME-Version: 1.0
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 26 Sep 2019 15:52:50 +0800
Message-ID: <CAKXe6SJfZt8WcA43Vsh0=GT=jBedcAOUx9DNGZ4Bsvi10oCkog@mail.gmail.com>
Subject: Questions about the real mode in kvm/qemu
To: Paolo Bonzini <pbonzini@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000087a9f905937010c3"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.50
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

--00000000000087a9f905937010c3
Content-Type: text/plain; charset="UTF-8"

Hi Paolo and all,

There are some question about the emulation for real mode in kvm/qemu. For
all the
question I suppose the 'unstrict guest' is not enabled.

1. how the protected mode CPU emulate the real mode? It seems it uses vm86,
however, vm86 is not available in x86_64 CPU? So what's the
'to_vmx(vcpu)->rmode.vm86_active' here vm86 means?

2. Does the guest's real mode code run directly in native CPU? It seems
'vmx->emulation_required' is also be false, it the vmx_vcpu_run will do a
switch to guest.

3. How the EPT work in guest real mode? The EPT is for GVA->GPA->HPA,
however there is no GVA, seems the identity mapping does something. But
there also some confusion for me. For example the real mode uses CS*4 + IP
to address the code.  Who does this calculation? In the kernel emulator?

Thanks,
Li Qiang

--00000000000087a9f905937010c3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Paolo and all,<div><br></div><div>There are some questi=
on about the emulation for real mode in kvm/qemu. For all the=C2=A0</div><d=
iv>question I suppose the &#39;unstrict guest&#39; is not enabled.=C2=A0</d=
iv><div><br></div><div>1. how the protected mode CPU emulate the real mode?=
 It seems it uses vm86, however, vm86 is not available in x86_64 CPU? So wh=
at&#39;s the &#39;to_vmx(vcpu)-&gt;rmode.vm86_active&#39; here vm86 means?<=
/div><div><br></div><div>2. Does the guest&#39;s real mode code run directl=
y in native CPU? It seems &#39;vmx-&gt;emulation_required&#39; is also be f=
alse, it the vmx_vcpu_run will do a switch to guest.</div><div><br></div><d=
iv>3. How the EPT work in guest real mode? The EPT is for GVA-&gt;GPA-&gt;H=
PA, however there is no GVA, seems the identity mapping does something. But=
 there also some confusion for me. For example the real mode uses CS*4=C2=
=A0+ IP to address the code.=C2=A0 Who does this calculation? In the kernel=
 emulator?=C2=A0</div><div><br></div><div>Thanks,</div><div>Li Qiang</div><=
/div>

--00000000000087a9f905937010c3--

