Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	TRACKER_ID autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41075C282DD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 18:16:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BF9720848
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 18:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DkzNjB+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF9720848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iotPC-0008BH-1z
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 13:16:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vkuznets@redhat.com>) id 1iotOP-0007k7-To
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:15:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vkuznets@redhat.com>) id 1iotOL-0002VS-Fs
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:15:49 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57654
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1iotOL-0002Uf-C6
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:15:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578420944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3/Znpe6CzbNLFCN/lvf+0gBCG2gOvlIIa1pJ8bjqQJY=;
 b=DkzNjB+ePN24c1mHFKZDPVzta/tkS8PcD91+3Y9rGEDO5vReTtvDjpU44ei/BdWKQD/gQh
 QhlkbrqLg4tF5Ed2otyCT5bEoKyNq/O6ACogHBXAAzJ2gH1CfToQxSopVimxFOs6vz97nE
 YZQQJz2QL+AgnrkPo8g5xMaJhyO9yok=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-rSsPqbX-MSC0g5u-rakPhQ-1; Tue, 07 Jan 2020 13:15:43 -0500
Received: by mail-wm1-f69.google.com with SMTP id l11so3403544wmi.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 10:15:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=ayJsf+Q7KB2XY9tednZraZBpIFaH2O9T5yjkmR8mFT0=;
 b=uiUgLXIcr6uxQMv6LyGqUb/3EZ8JE6NBEjtH5BGZW5bV+0ul8HJ1abbzbghd8CUE4f
 6De3l4FkZdCBliU7x4/3G1XQzRKgpIIpw7gtPCcRdqDmmflGHLI8MR4699rve6Wrxgeo
 szO38mzskbPucyzATGb/1+ixwY/LanC0QA3wXO9YYHzcpz0DsdZ7h5oREnynR3d+beiv
 GTkhdy4Swia7TE9x4uO1V9btQP1S2hXSUU4eSGwbyASv8Rq3ZiaRdE52nrYIgjkTajRt
 KCr29Jfo2iqYdKcc0E1W60kUzTKH5bLHIoTQph2rDQ6e/+OXWCgSvH/nwXoYfytoT+z8
 UfpQ==
X-Gm-Message-State: APjAAAUJot9JHdjUnZE80WlovLZwKYFwiFFDiNiCDvZ9S7zNb2dvh9Br
 ih0rLqwWJ46cEj2UTpaYWaGFMymqfjCYsu046IXzTIRcaIzx6eCm+TKE547MxC1XkaGUefDn3jd
 iZyf0ZWBmSBq21D4=
X-Received: by 2002:a1c:6588:: with SMTP id z130mr381649wmb.0.1578420942288;
 Tue, 07 Jan 2020 10:15:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqxpqNvkbAFyfjBkHu3zxvyAVAz3eKtTSgRi+0UBuSx1/OB+0wSi8+hujDPcMcAluggD3dJUAw==
X-Received: by 2002:a1c:6588:: with SMTP id z130mr381630wmb.0.1578420942111;
 Tue, 07 Jan 2020 10:15:42 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id f1sm806716wru.6.2020.01.07.10.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 10:15:41 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH RFC] i386/kvm: fix enlightened VMCS with fine-grained VMX
 feature enablement
In-Reply-To: <7c4dcca1-a1e6-a00c-56fd-bcc6c8bcc474@redhat.com>
References: <20200102203926.1179743-1-vkuznets@redhat.com>
 <21556857-3d6a-ad66-5cf5-060b1ab67381@redhat.com>
 <87zhezsc30.fsf@vitty.brq.redhat.com>
 <7c4dcca1-a1e6-a00c-56fd-bcc6c8bcc474@redhat.com>
Date: Tue, 07 Jan 2020 19:15:40 +0100
Message-ID: <87imlnrv3n.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: rSsPqbX-MSC0g5u-rakPhQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
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
Cc: Roman Kagan <rkagan@virtuozzo.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Liran Alon <liran.alon@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 07/01/20 13:08, Vitaly Kuznetsov wrote:
>> Honestly I forgot the story why we filtered out these features upon
>> eVMCS enablement in KVM. As there are no corresponding eVMCS fields,
>> there's no way a guest can actually use them.
>
> Well, mostly because we mimicked what Hyper-V was doing I guess.
>

An update from reverse-engineering trenches.

I ran some tests to see if we can just drop the filtering and there is
only one problematic control which Hyper-V enables:

SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES

the problem with it is that we don't have 'apic_access_addr' field in
eVMCS ('virtual_apic_page_addr' is there). By running the same setup
with eVMCS disabled I figured out which address can be hardcoded to make
it boot. My guess was that the fields is present but not documented
properly, I tried scanning eVMCS for the value but with no luck so far.

I'll try to fish some information out of Microsoft.

--=20
Vitaly


