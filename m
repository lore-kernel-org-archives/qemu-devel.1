Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBF3C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 12:23:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 552CE21850
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 12:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQ5IYR59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 552CE21850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX2XF-00057t-Ap
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 07:23:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55514)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iX2WR-0004hm-KB
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:22:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iX2WQ-0003kT-NU
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:22:19 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45521
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iX2WQ-0003kF-JG
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:22:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574166138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ue1AMAyBYD93neM5yvDdqmgIu/qWt7o77m7cQk1HTDA=;
 b=NQ5IYR595+n7UKls+P3ladLDjm1JvxYWeswlH1kKjIfFIz8vSWxx0X+f7zXIWHaD+rAeHH
 WwpbW9QIYcC/b34qUE58xvX9QZCCUgcuF0MMrTRSieF9hIAiPHWmHtRQtQhAh8OlD9vlVN
 GQWEc3osRt5AC8BMeMEbBUY553tGbsI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-agNljSb_NJGM_dRfz002iA-1; Tue, 19 Nov 2019 07:22:16 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF03F107ACC7
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 12:22:15 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-181.ams2.redhat.com
 [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 401E44D74F;
 Tue, 19 Nov 2019 12:22:15 +0000 (UTC)
Subject: Re: [PATCH 15/16] kvm: introduce kvm_kernel_irqchip_* functions
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
 <1573655945-14912-16-git-send-email-pbonzini@redhat.com>
 <cfa98de2-3bb6-8eef-1edc-6c396e9af121@redhat.com>
 <5414fe36-e8dc-a9bc-9a4c-08fd96a5852f@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d42f5daf-3246-0e4d-966a-c1f1b3546a2f@redhat.com>
Date: Tue, 19 Nov 2019 13:22:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <5414fe36-e8dc-a9bc-9a4c-08fd96a5852f@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: agNljSb_NJGM_dRfz002iA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/11/2019 13.13, Paolo Bonzini wrote:
> On 19/11/19 12:56, Thomas Huth wrote:
>>> -    if (machine_kernel_irqchip_split(machine)) {
>>> +    if (kvm_enabled() && kvm_kernel_irqchip_split()) {
>>>          error_setg(errp, "kernel_irqchip split mode not supported on p=
series");
>>>          return;
>>>      }
>> Any reason for the additional kvm_enabled() here? I think it should also
>> be ok without that?
>>
>> Apart from that question, patch looks fine to me.
>=20
> It won't compile without that, kvm_kernel_irqchip_split() is defined in
> accel/kvm/kvm-all.c.

Oh, I wonder whether you need a stub for certain compilers? ... but if
all our supported compilers are fine with this, I'm fine with it, too.

Reviewed-by: Thomas Huth <thuth@redhat.com>


