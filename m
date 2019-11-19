Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB0FC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 12:15:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB48B222D1
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 12:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLTnWn2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB48B222D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX2PW-0006Nv-Pq
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 07:15:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54394)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iX2O5-0005GL-SH
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:13:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iX2O4-000757-B7
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:13:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38427
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iX2O4-00074Z-7e
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:13:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574165619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=/l2ulDWsUfr+H3BhB8UQSkGmewtq+gHxIccM3BtWddk=;
 b=VLTnWn2ztPofam6AAcp5JDPY/uk1m1Nn66Fu6UvWBnbAy7cef3RaacFHMbaWvlQ+RnM0pD
 nKGOhI0PWyY1vsCip1hTfKxhiMSTiZGbH+M3uEcD1yititbBivhvS0ZHpmZMaklDdPn9HS
 Io3qeVbrj7KgMOE8e3AgdDrMTlnWcHg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-cSxiRCOiNCqCDvVDiAeLpQ-1; Tue, 19 Nov 2019 07:13:37 -0500
Received: by mail-wr1-f70.google.com with SMTP id q6so18151615wrv.11
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 04:13:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mZE52a9+qY9ucxMDuF/nwDaCKp50zAenTp/sLlyUJk0=;
 b=cHKGp/wAZl6LCZ8k4Sk05WwcfwjXVcZjFvjcuZo/zzBY7UW6jKz004N6KpAmqfxFfs
 TxqYgPr++3ON/CjqktvkIjvCqpR2dhUp7octWK4gALILnX5dQQIwP4/shOMZskjIe+U+
 Xu7l+ETipOPJX6+mbxGxAnrEzBSHAeIDU7umuqWDj4lcMTKZZqYctDLcW2MD5bEw9xEp
 AAh2dfmibNWBVxIUo/qGMm3EIWIKK/40P/qg4oVSFrQku0Q04JvZSZ4ZzFeGsD/TEX+U
 Aud8rYlqW10QJyVPIy8rJIzbYTMTlsvgRsCKxUiiHvgCaecyAFlb+s+d/j0N4OLPuYzW
 58zw==
X-Gm-Message-State: APjAAAUUTkn4stdvdykLoCp7zE2bAHWlGz48n0ujfaL/PiLobsbpkJDT
 gmJJv2AcF0JBhGO9fBIv1wWB4KS+O2vmheOy2pMkykapz2auRngbRgvaxz2UJnpMTVIKbfu2MgH
 rmiZd7ge9yECxNxY=
X-Received: by 2002:adf:e58c:: with SMTP id l12mr15293136wrm.156.1574165615952; 
 Tue, 19 Nov 2019 04:13:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqwssofNexqs5JsAuqgoB8gaqrQHhkpx6ko2GvQ3hMIfXV2DGaHLQLmGPIxUNWC0gyCZYZBmWA==
X-Received: by 2002:adf:e58c:: with SMTP id l12mr15293108wrm.156.1574165615620; 
 Tue, 19 Nov 2019 04:13:35 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:29dd:9d78:9734:7b0c?
 ([2001:b07:6468:f312:29dd:9d78:9734:7b0c])
 by smtp.gmail.com with ESMTPSA id y78sm2956759wmd.32.2019.11.19.04.13.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2019 04:13:34 -0800 (PST)
Subject: Re: [PATCH 15/16] kvm: introduce kvm_kernel_irqchip_* functions
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
 <1573655945-14912-16-git-send-email-pbonzini@redhat.com>
 <cfa98de2-3bb6-8eef-1edc-6c396e9af121@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5414fe36-e8dc-a9bc-9a4c-08fd96a5852f@redhat.com>
Date: Tue, 19 Nov 2019 13:13:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cfa98de2-3bb6-8eef-1edc-6c396e9af121@redhat.com>
Content-Language: en-US
X-MC-Unique: cSxiRCOiNCqCDvVDiAeLpQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

On 19/11/19 12:56, Thomas Huth wrote:
>> -    if (machine_kernel_irqchip_split(machine)) {
>> +    if (kvm_enabled() && kvm_kernel_irqchip_split()) {
>>          error_setg(errp, "kernel_irqchip split mode not supported on ps=
eries");
>>          return;
>>      }
> Any reason for the additional kvm_enabled() here? I think it should also
> be ok without that?
>=20
> Apart from that question, patch looks fine to me.

It won't compile without that, kvm_kernel_irqchip_split() is defined in
accel/kvm/kvm-all.c.

Paolo


