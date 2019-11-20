Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A74C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:58:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 767D420878
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jEHQEfMD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767D420878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXUFS-0000bc-KS
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 12:58:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60585)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iXUEN-00085t-3M
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:57:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iXUEK-0004lg-6O
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:57:30 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44890
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iXUEI-0004ks-FI
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:57:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574272644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=dVw7FIuwWuu5Lv16m2dUbd1e10+dUzgzRSWIrKXWEE4=;
 b=jEHQEfMDAzIjYuOXwsip8yKxEdNpMf31moYfP/9XsLLwbS+40HYkbQlT0kpTfqMWUqvLnk
 KX/rt8cPcfHne4SHncDvf4Xy7rjkZb/q14XQJHaLx1A+ZhW5nlZnNySzk56x5tV1Q/ZTWn
 EtepaW+PfMTyF19rO85nwh/9FsGh1fU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-FrqS5s0GOh2BSrMYQ2oYkA-1; Wed, 20 Nov 2019 12:57:22 -0500
Received: by mail-wr1-f72.google.com with SMTP id u14so170175wrq.19
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 09:57:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Er4o4nLlj40R13NAP6NYkJvne9nq+eiHa2N172eW2n0=;
 b=WhTXV1mrg5tLKC5Yv2+3ZKS/CSaqtVxvhw+oF1wfT+jpig19hW2sR6N26zbUUvNPhw
 7HF/dgMAUSs/HMHzaDwmg72m9NqhYnhxubQcyZNhuq3NFxFG/Ls0Nl3aI6huacLGhnWX
 7/i7nh4UEnBa+LgwOfHGEwuQz5xSD5feyQlIn0JWDo6WGfeZY/XgWT7L1vhCPGYPp4VV
 6ALplTnGbcDm6VWqNBiLAGr71CaW2zMbr4I1MF7tWiJrR08IMHbv/GGT3Rn6ZUhMhEJo
 6uf9o0vwl1Dptt+3VGF2Ig+OksyM8IqOfr6fsobhnxe0bSGi6daKA9VuC7X/QPn1vA1l
 QQjw==
X-Gm-Message-State: APjAAAWHaLI8448lo2XfWir34njVzr/E2rQ06telHa21J5gpc0Ih8SBA
 veekRtrw/rs3DjavP4jgLJkO2iym+i0jJG5EZjGVr+KVvM70pVrhAE719OdcdWuCCBfJwcMo6ai
 8m7IMhXY10atkxSs=
X-Received: by 2002:a5d:4c4e:: with SMTP id n14mr5451833wrt.260.1574272641687; 
 Wed, 20 Nov 2019 09:57:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqypjAOWgTT7J8IW3FjHWVVQR/QNLscRZHzG/BrakdJ4QQuWhkcnbGanawopIW+ZBmS3TxAWUQ==
X-Received: by 2002:a5d:4c4e:: with SMTP id n14mr5451784wrt.260.1574272641397; 
 Wed, 20 Nov 2019 09:57:21 -0800 (PST)
Received: from [192.168.178.40] ([151.48.115.61])
 by smtp.gmail.com with ESMTPSA id y6sm53316wrr.19.2019.11.20.09.57.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2019 09:57:20 -0800 (PST)
Subject: Re: [PATCH] target/i386: add VMX features to named CPU models
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20191120173753.8894-1-pbonzini@redhat.com>
 <20191120175002.GP2785116@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <7e1b3701-8c5a-409c-8c8f-29cb673da3ac@redhat.com>
Date: Wed, 20 Nov 2019 18:57:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191120175002.GP2785116@redhat.com>
Content-Language: en-US
X-MC-Unique: FrqS5s0GOh2BSrMYQ2oYkA-1
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
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/11/19 18:50, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Nov 20, 2019 at 06:37:53PM +0100, Paolo Bonzini wrote:
>> This allows using "-cpu Haswell,+vmx", which we did not really want to
>> support in QEMU but was produced by Libvirt when using the "host-model"
>> CPU model.
> Can you say what is currently broken ?  If I launch my current QEMU (I ha=
ve
> 4.1.1 on Fedora 31):
>=20
>  qemu-system-x86_64 -cpu Haswell,+vmx
>=20
> ... I don't get any reported errors.
>=20

KVM does not load in the guest, though?

Paolo


