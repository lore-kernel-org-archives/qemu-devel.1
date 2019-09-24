Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07792C432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 11:50:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF5442146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 11:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5442146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCjL3-0002Xw-BQ
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 07:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iCjIZ-0001Dd-Gf
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 07:48:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iCjIW-0005T9-T1
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 07:48:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10393)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iCjIW-0005Nx-Kt
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 07:48:00 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4B32681F31
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 11:47:57 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id t185so706489wmg.4
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 04:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZmUP3dVjUP6Ph1ks37nxU36pehuOEitrpcwdPaj7Rqk=;
 b=p+cy6aVbtl6y9QXqtLwjDF96DFDhzs+pywiwtmnjfvDLYGzhPoU4paLG0B7cGRJ/dy
 WY0VvOMiTS0cY+ogCpicuxqdWwRv/cGq1guDU94HHoW6Ah3Qf45Z+i6muJVZUylZ7CdS
 RgS3Ro2qlu0JdvqAl4u5i3f9u57nD0vOt4RwxkqOljkVIzSOpPxqYK5gLzEZBECpB/Mi
 hgRds7uWU1wutpmvPayyca0hM5FQCViS2YrvL1rddRSJ+NWYsRef+dQrjhHMxc3zyYn4
 rJI+cVLJhLpbhyY4jmpcvXl9HQV8gKkTqD+4hv6Ejwc8lyzxX1nz0HC6aFZR+gjE82HT
 k3pw==
X-Gm-Message-State: APjAAAWP8e6QOXh7kPtS1mS5Wgk9P239LV14z1eHGxi29w8g+IU6RFS4
 L3+4QymASxQQt3ruo7lEmQTWFzVIhqRcjLcpy7kaXPrEquVQs/IwuysfUURTW/xpCZ3s6s+h053
 D8+qEjyXMkZFyMdE=
X-Received: by 2002:adf:e48f:: with SMTP id i15mr221727wrm.26.1569325675881;
 Tue, 24 Sep 2019 04:47:55 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwYN5lvbTvdGpga0JogVxl1P6Rka6ib4+wnTWx99krQzs82kmUGoXEcVhEeux3fSgMEAVgYvw==
X-Received: by 2002:adf:e48f:: with SMTP id i15mr221708wrm.26.1569325675548;
 Tue, 24 Sep 2019 04:47:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36?
 ([2001:b07:6468:f312:9520:22e6:6416:5c36])
 by smtp.gmail.com with ESMTPSA id b144sm1252690wmb.3.2019.09.24.04.47.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2019 04:47:55 -0700 (PDT)
Subject: Re: [edk2-devel] [Qemu-devel] [PATCH 1/2] q35: implement 128K SMRAM
 at default SMBASE address
To: Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>
References: <20190917130708.10281-1-imammedo@redhat.com>
 <20190917130708.10281-2-imammedo@redhat.com>
 <561f4440-7c06-10d7-80ce-bbfa810fec59@redhat.com>
 <20190920102855.3fe2b689@redhat.com>
 <a581abbc-ec03-c332-b225-6f7cd3cfadae@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6799e19d-1aa8-ee09-9ef4-2533a7241360@redhat.com>
Date: Tue, 24 Sep 2019 13:47:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a581abbc-ec03-c332-b225-6f7cd3cfadae@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: yingwen.chen@intel.com, Brijesh Singh <brijesh.singh@amd.com>,
 devel@edk2.groups.io, phillip.goerl@oracle.com, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, jiewen.yao@intel.com, jun.nakajima@intel.com,
 michael.d.kinney@intel.com, boris.ostrovsky@oracle.com, rfc@edk2.groups.io,
 joao.m.martins@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/09/19 11:28, Laszlo Ersek wrote:
>> On QEMU side,  we can drop black-hole approach and allocate
>> dedicated SMRAM region, which explicitly gets mapped into
>> RAM address space and after SMI hanlder initialization, gets
>> unmapped (locked). So that SMRAM would be accessible only
>> from SMM context. That way RAM at 0x30000 could be used as
>> normal when SMRAM is unmapped.
>
> I prefer the black-hole approach, introduced in your current patch
> series, if it can work. Way less opportunity for confusion.

Another possibility would be to alias the 0xA0000..0xBFFFF SMRAM to
0x30000..0x4FFFF (only when in SMM).

I'm not super enthusiastic about adding this kind of QEMU-only feature.
 The alternative would be to implement VT-d range locking through the
intel-iommu device's PCI configuration space (which includes _adding_
the configuration space, i.e. making the IOMMU a PCI device in the first
place, and the support to the firmware for configuring the VT-d BAR at
0xfed90000).  This would be the right way to do it, but it would entail
a lot of work throughout the stack. :(  So I guess some variant of this
would be okay, as long as it's peppered with "this is not how real
hardware does it" comments in both QEMU and EDK2.

Thanks,

Paolo

> I've started work on the counterpart OVMF patches; I'll report back.


