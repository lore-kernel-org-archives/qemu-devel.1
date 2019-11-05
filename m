Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F21EC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 23:46:46 +0000 (UTC)
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BDE120717
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 23:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M7z4SbWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDE120717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS8X6-0001b9-GR
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 18:46:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40623)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iS8Vc-0000ad-Vo
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 18:45:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iS8VZ-000873-Hw
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 18:45:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58205
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iS8VX-0007zX-Gb
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 18:45:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572997504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=agciNXz8BilTTPSJiv7Wi1QXajF5FCYfFiuPUYwXBW8=;
 b=M7z4SbWqJh8LZO+NBWL7Yadwcf83t60+AiGa5Gjkvw0+GerW4PpHzzziLCB6WprIj4aRHC
 WWCymmaKAR0yOIXh7865CBm74LYPqUdESVprsrVLDkaJkI4WZk9/n9uMRau6gWgr+YI4OE
 1tLpwCp5LONLlaENscGJFDEniGQOksg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-DuEQXcHLMRCQger5HqNLmw-1; Tue, 05 Nov 2019 18:45:03 -0500
Received: by mail-wr1-f69.google.com with SMTP id c6so13169261wrp.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 15:45:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4tXfx/n0RE7SkzG19ybfXdmpTsKSRCOKoc0i+fY+85E=;
 b=NmYRXFTTbEZnA/+XTlHjF2UnhuJQsX+OBk4Bg+5nkiVU1ZRjVvzI7lWquHoJpjBOR6
 F3UzJs/olVc6t6P029TxImsweS7xWNJQWMKGHetDCiatIFuu9cde2EkG+PztG2+SqVHW
 hMAKQR0eAucaIBBNClK693iTu2t7uFFHnVHFa7NGDHjRHIACGKV71cariHJCNPnccyXU
 wjmQvqVSmdU/keytdD1ye2o8syeTGIsQCFwLq8s0e9hgS6H8PJ3R4QoXteCbzuldT8/N
 fEtQnWnYm/KsrpZN92qBgmpHDZD3gXOzAXEApEbFl52+CH7JcLN6WT6cSqBcFVUnEzLZ
 r3DQ==
X-Gm-Message-State: APjAAAU3lMwGt2m2XPh9DBaI/Ra/cNcLXJRFOAXPvIRZwptQMQJ1GpBG
 OC4bPlDAtT74OcB4pfaEDZszjFf2s/jctD+ALZuqgVyD9qbayoVflfVwDq+LjwMGHMwjBrvjCRh
 mFXYPpD4GKjYps+Q=
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr31595443wrn.334.1572997501819; 
 Tue, 05 Nov 2019 15:45:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqyw4TXKU3CEdW6/z1xIvAjnC0yW/DGFiP6VysRoHLc2dY5Od1lmDUj5vXTYbEL0UitNGsMrdw==
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr31595431wrn.334.1572997501576; 
 Tue, 05 Nov 2019 15:45:01 -0800 (PST)
Received: from [192.168.1.24] (lfbn-1-7864-228.w92-167.abo.wanadoo.fr.
 [92.167.33.228])
 by smtp.gmail.com with ESMTPSA id j63sm1063258wmj.46.2019.11.05.15.45.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2019 15:45:01 -0800 (PST)
Subject: Re: [EXTERNAL] Re: Adding New, Unsupported ISA to Qemu
To: Peter Maydell <peter.maydell@linaro.org>,
 "Hanson, Seth" <shanson@sandia.gov>
References: <1572911399018.17766@sandia.gov>
 <20191105164253.GJ166646@stefanha-x1.localdomain>
 <CAFEAcA_5ZS=4gHW8yph_o7Z4XrO5r2YMbGTB0oNtQKriv-qS=A@mail.gmail.com>
 <1572988990478.74192@sandia.gov>
 <CAFEAcA-EvgXF+fch2ss-NpFt8qLXA844Fay-=be1uQH91Sa05g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a1f5dd48-84a4-7385-3ce6-6d6018fd2b82@redhat.com>
Date: Wed, 6 Nov 2019 00:45:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-EvgXF+fch2ss-NpFt8qLXA844Fay-=be1uQH91Sa05g@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: DuEQXcHLMRCQger5HqNLmw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/5/19 10:39 PM, Peter Maydell wrote:
> On Tue, 5 Nov 2019 at 21:23, Hanson, Seth <shanson@sandia.gov> wrote:
>> I completely understand your concern. Rest assured, this project is enti=
rely internal and requires no code contribution, unit testing, etc. from QE=
MU devs. We simply want to garner as much documentation as possible to ensu=
re optimal conversion/compatibility. My team and I have already completed a=
 majority of our instruction set
> mapping into TCG. Lately however, we've encountered issues with
> floating point operations.
>=20
> Yeah, for internal forks you have none of the upstreaming
> issues (you're merely more on-your-own for figuring out
> bugs :-))
>=20
>> I noticed in the TCG Readme that floating point operations are no longer=
 officially supported but were previously (per the last paragraph in 4.1).
>=20
> Git blame will tell you that that claim about floating point
> has been in there since the readme was first added to
> the project in 2008. It would be more accurate to say
> simply that TCG does not natively implement fp operations.
>=20
> TCG's approach to fp is to just (at the TCG opcode level)
> treat fp registers the same way as integer ones -- they're
> 32 bit or 64 bit binary values. Mostly fp operations are
> implemented by having the TCG code call out to a helper
> function, the same way you'd implement any moderately
> complex operation that's not easy to do with inline TCG ops.
>  From the helper function, you can call the various emulation
> functions provided by our generic fpu emulation layer
> ('softfloat') whose headers are in include/fpu. The FPU
> emulation provides IEEE-compliant implementations of
> various basic operations; you have to tell it how your target
> handles things that IEEE 754 doesn't nail down (eg whether
> you detect tininess before or after rounding, what your NaN
> format is, that kind of thing), through
> a mix of calling the functions that initialize the 'float_status'
> and also adding to the target-specific ifdeffery in
> fpu/softfloat-specialize.inc.c. When your target needs things
> that aren't IEEE-specified you just have to implement
> emulation of those in your per-target code (arm does this
> for the 'recpe' reciprocal-estimate instruction, for instance).
>=20
> IEEE cumulative exception flags (inexact, denormal, etc)
> are tracked in the float_status and need to be made visible
> to the guest in whatever fp status register it uses to show
> those. The default assumption is that IEEE exceptions
> don't generate guest CPU exceptions, but you can implement
> the latter if you need it -- see ppc for an example of that.
>=20
>> Can you please provide documentation for implementing the latter?
>=20
> As usual for QEMU internals there are no documentation.
> You can look at the headers in include/fpu which have some
> comments describing the APIs, and at the existing CPUs
> which use them to implement their FPU support.

You can also read the git history (of a particular file/directory), you=20
will learn a lot about API changes and why the design is this way today.

Also, looking at other similar contributions in the mailing list=20
archives might give you useful hints. In particular when patches were=20
not accepted, what was the reasons.

Regards,

Phil.


