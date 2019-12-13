Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21E3C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 09:44:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB1D224656
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 09:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VK5bsBRk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB1D224656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifhV2-00010B-V6
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 04:44:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ifhUA-0000ah-Pt
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 04:43:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ifhU9-0005sc-Qb
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 04:43:46 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50469
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ifhU9-0005qa-MX
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 04:43:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576230224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+gnJS/zAIWAvYiEmzfp45fnudbWkm3nMQ9RunX37eiM=;
 b=VK5bsBRk3JOIfZWwgPPiM68SN6NDeJ7XbP0dVQuWaUscJsan0gbM+ImsFQzEJyUNr1xplf
 yvrdhuVmonFUqnNHGRqs2iGZe8vn8m2ojbZIDX7SXFOqZ6ITga2I55mldTDWFLZ5+dgb1Q
 gpJdk6btzciOD0Q6LOr1ZmC0IPlqyok=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-6Z1ey49jNHepjFwsrRsnpg-1; Fri, 13 Dec 2019 04:43:39 -0500
Received: by mail-wr1-f71.google.com with SMTP id k18so2376590wrw.9
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 01:43:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LoAKfZFWR+sXboI8zPjxU9tKEgCTzR4uAuyNbITPy1U=;
 b=rElsy30EZlyBlhbsQ1SbF7RLUvgo7XPw20xH0oMZHooONOrJU/JsC9iPLkE38g2ccc
 KcvCZlOUZ9wFpAssEypxsqUgv2wViylJfL4DBvYsDLCyvEFFZGHQenDeNgZ11bQ/5t2E
 Eo1QhT4JLdWJZiu4YKu7snj2daeLLwf/wkJSBDFUkLfe8LxWqKqiPoSMD8EaAfmGpnZg
 4X2QKIY9kAabitfPLVcvrE1xxyy3lnitik4kNCDhGdvxYi13OsvB3AFkaOk+175+L4qB
 mF9jbzbdKfRwq9KBc4ON2VBADe+xmJ2KScVrk8ooOC/D35+TpDjkcmM8cP0Rg6LJ+1PH
 tTIw==
X-Gm-Message-State: APjAAAWvDz60FyWGSWLVJhV1EYIKnrVLHJiR0Xvn4mzMQVQlyFzD9SH0
 UinwQjiBlCJ8ofdcqx7PI8xoBYiDS+QV3eLRk59oAP4qp93UvzLlAsKo7yZehXQCrrAYwqcOoU7
 Xz7W+552EDpTlpZk=
X-Received: by 2002:adf:f606:: with SMTP id t6mr11173311wrp.85.1576230217512; 
 Fri, 13 Dec 2019 01:43:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqzpQxZiZIBBgxdP9OOxZxihelPKa9YW1fgs3HiHOOsmg+/iWd8sHyPTf+oyJdfeWqy3qL040A==
X-Received: by 2002:adf:f606:: with SMTP id t6mr11173286wrp.85.1576230217244; 
 Fri, 13 Dec 2019 01:43:37 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id o185sm9354696wmb.40.2019.12.13.01.43.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2019 01:43:36 -0800 (PST)
Subject: Re: [PATCH v2 3/8] hw: replace hw/i386/pc.h with a header just for
 the i8259
To: Paolo Bonzini <pbonzini@redhat.com>
References: <1576171754-45138-1-git-send-email-pbonzini@redhat.com>
 <1576171754-45138-4-git-send-email-pbonzini@redhat.com>
 <d58b507e-9d68-d112-0f6c-6f9dfb153a93@redhat.com>
 <CABgObfY_19XxcbYUMm=V7pUF-gbkyYViV7Sp4ieNiGSH+VoH3Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <448c88fa-fb82-e62a-6219-0a1038db10fb@redhat.com>
Date: Fri, 13 Dec 2019 10:43:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CABgObfY_19XxcbYUMm=V7pUF-gbkyYViV7Sp4ieNiGSH+VoH3Q@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: 6Z1ey49jNHepjFwsrRsnpg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Sergio Lopez <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/12/19 9:05 PM, Paolo Bonzini wrote:
> Il gio 12 dic 2019, 20:04 Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
=20
> <mailto:philmd@redhat.com>> ha scritto:
>=20
>     On 12/12/19 6:29 PM, Paolo Bonzini wrote:
>      > Remove the need to include i386/pc.h to get to the i8259 functions=
.
>      > This is enough to remove the inclusion of hw/i386/pc.h from all
>     non-x86
>      > files.
>=20
>     Eh this is very similar to the patch I'v staged for 5.0, now than the
>     Malta/PC split got merged.
>=20
>=20
> Ok, these patches are not urgent so I will just wait for yours to go in=
=20
> and rebase.

Oh, I don't want to delay your series, this was more of a "comment to=20
self" while reviewing your.

The MicroVM series introduced changes that outdated my work, and since=20
having MicroVM was more important that global cleanup, I didn't insist a=20
that time. Now GSI and IOAPIC are more exposed so my previous work=20
doesn't apply at all. Well, current code diverged.
I'll need some time to figure out if it is worthwhile salvaging, so=20
don't wait for that.


