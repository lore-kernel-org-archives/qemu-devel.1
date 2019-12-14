Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F0DC2D0C9
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:20:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F4EE20866
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OkJDwmER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4EE20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igEqI-0006D6-Ua
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 16:20:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1igEoe-0004Xm-JT
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:19:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1igEoc-0007xO-0N
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:19:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50821
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1igEob-0007ut-N6
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:19:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576358344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m5w23wgjLipXGOJApBiDuCElbab9paRwQ4431X44oSE=;
 b=OkJDwmER+eq+RTYEyAOThqKPxXJrHb4RYpkC2QT7zdGkopE9Q58u+sSDVHgTXtrpet218v
 CXW7uIqpSp+3cfF6YxCHTNpC6ny/H78VYBXKU3YTquxdYEIUZ5FgHBoka5J8JrtQ7sH4zd
 upSA2teQC19KsjlxQPVUji0Aok4ipzs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-8Nx-jxcEP8qAgZqXHJyYXQ-1; Sat, 14 Dec 2019 13:17:27 -0500
Received: by mail-wr1-f72.google.com with SMTP id t3so1241467wrm.23
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2019 10:17:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Sg5IoKLUjPL3d9d5tWOmLplt+9UU7U7u3KeGeq6Z2Ro=;
 b=DaLrX6SvG1spsYaWuc1n6eLGcnWrgWnFS/02NabVFRL7/dRK2mZ5qcHEmvoGAAWA0V
 clBc0YRbhV4zzOAcyJ3s2L7V11VIXhN7NXSPOSHe/YFa+QwHvrYa9ypCDneKDRiDLaDA
 Lh8G3pj4huXv4aMIOwGP5f3OXu/g73f08Fr0zHz5YrYt5giw0dqNmlibHmLTrAgO0AZ6
 scT7mh0NLSaxkbo6BBJVerazkF6Y6tWQkx12kiicd63k143G0tMg7dx7+ECOm50w/ZDM
 PEhGgot/vmBMF+Sn0LoaAN/yOsdWBZDGjXpsLtdtB/lDSq+LaOLTt/1UQeQq8PYkkssW
 abUw==
X-Gm-Message-State: APjAAAXp1J9flDVd62W1Qzr5nK91gl6Z0mxKA6tyzzdb6Pkzv07RbPVV
 hxohNukeicv0CIKuJhQQHyg7syL3u+Aznwhoess08kt6+zpKHp2pCvX1EnZQqbdLPy2Vt0M6RnX
 sx01W2DHH3UfXebU=
X-Received: by 2002:adf:ea8a:: with SMTP id s10mr19560666wrm.278.1576347446320; 
 Sat, 14 Dec 2019 10:17:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqwa4vn4ff+Qn7Yr7sIor5+nJ8HSxrr0XhsEVlpcFJzSQc5WvO7C89H+O/cXVwaqad6m8td6Hw==
X-Received: by 2002:adf:ea8a:: with SMTP id s10mr19560619wrm.278.1576347445986; 
 Sat, 14 Dec 2019 10:17:25 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id n8sm14941968wrx.42.2019.12.14.10.17.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2019 10:17:25 -0800 (PST)
Subject: Re: [PATCH 0/8] Simplify memory_region_add_subregion_overlap(...,
 priority=0)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191214155614.19004-1-philmd@redhat.com>
 <CAFEAcA_QZtU9X4fxZk2oWAkN-zxXdQZejrSKZbDxPKLMwdFWgw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <31acb07b-a61b-1bc4-ee6e-faa511745a61@redhat.com>
Date: Sat, 14 Dec 2019 19:17:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_QZtU9X4fxZk2oWAkN-zxXdQZejrSKZbDxPKLMwdFWgw@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: 8Nx-jxcEP8qAgZqXHJyYXQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Alistair Francis <alistair@alistair23.me>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Joel Stanley <joel@jms.id.au>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/14/19 5:28 PM, Peter Maydell wrote:
> On Sat, 14 Dec 2019 at 15:56, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
>>
>> Hi,
>>
>> In this series we use coccinelle to replace:
>> - memory_region_add_subregion_overlap(..., priority=3D0)
>> + memory_region_add_subregion(...)
>>
>> Rationale is the code is easier to read, and reviewers don't
>> have to worry about overlapping because it isn't used.
>=20
> So our implementation of these two functions makes them
> have the same behaviour, but the documentation comments
> in memory.h describe them as different: a subregion added
> with memory_region_add_subregion() is not supposed to
> overlap any other subregion unless that other subregion
> was explicitly marked as overlapping. My intention with the
> API design here was that using the _overlap() version is
> a statement of intent -- this region is *expected* to be
> overlapping with some other regions, which hopefully
> have a priority set so they go at the right order wrt this one.

I didn't notice the documentation differences, now it is clear.

> Use of the non-overlap function says "I don't expect this
> to overlap". (It doesn't actually assert that it doesn't
> overlap because we have some legacy uses, notably
> in the x86 PC machines, which do overlap without using
> the right function, which we've never tried to tidy up.)
>=20
> We used to have some #if-ed out code in memory.c which
> was able to detect incorrect overlap, but it got removed
> in commit b613597819587. I thought then and still do
> that rather than removing code and API distinctions that
> allow us to tell if the board code has done something
> wrong (unintentional overlap, especially unintentional
> overlap at the same priority value) it would be better to
> fix the board bugs so we could enable the warnings/asserts...

Maybe we can a warning if priority=3D0, to force board designers to use=20
explicit priority (explicit overlap).


