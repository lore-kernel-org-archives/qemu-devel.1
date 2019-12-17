Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334DCC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:34:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED5472072D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HrsVec81"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5472072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihHgG-0000uV-UO
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 13:34:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihHf6-0008CK-5F
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:33:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihHf5-0000V0-43
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:33:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43671
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihHf5-0000UP-0P
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:33:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576607614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RdNyP5ZCK4YxBwAtJTpGq70INeBjJs9JXqOWZZ8QAe0=;
 b=HrsVec81S1Cj97+g3HAi0PTv7miyG2Fd5Fiod+d8Uq0zF/IQV0D3iXcUviytMpknPfjKNe
 ykW8j48bftuO4TSfS78DMoZXQdTANcD10D6kuoayKcUgY1pL4l9swZ9J9QKTirELKXoN/Q
 2wRwuOYiB5ArToRg30vDha2jfhsI7sc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-KYHPR-ZDMKOfA_x6n2BZOw-1; Tue, 17 Dec 2019 13:33:33 -0500
Received: by mail-wr1-f69.google.com with SMTP id u18so5684649wrn.11
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 10:33:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nn+JC0JwddgpZrY/NISVxlPVRHxvldmoValdTFDhkWM=;
 b=JCtOTnSM5A3cqj7QH71Rkepb7vPqBDoDvZMXmulNG1CTMSJF0KubPMQAIHfYc57OTa
 ZZPur1AlbmZ/SN1421c1piICfgt27CyB1vhCysx6INQq4DK7CLT3iq9Sme5Wm30p8jab
 fLIIWuQ57c/5wj+giPCEgKEWeMFlmP71F/u2EWcvXt/86GohKQnYYmFAg8cJbh/91y8c
 s0chaL7l1+Y8tI//oWtXya2BuF/DigZZJhxDt2qKIjFg3xTMFzlFGl97p+wHfJ3AYtl+
 DtLM8hRan2+CSmWRFbD7VYDu01HzF+IeL8W1SUTRPx0dKO6RlSfRDQDcp80mjSOUExoo
 G02Q==
X-Gm-Message-State: APjAAAVTnj0FeQgVokrEGXTrPiJb5pSoPc6ezbkoEBCpdBwwjmXKIdZl
 RJR/3TB87qrlwMnifp0xMmjxnjv5/AiepqRKOPllrkwfX/ZWRCquyozEklnBI+qg2pug2iUGAYa
 PTNV4aPJTQgUj8Ko=
X-Received: by 2002:adf:b193:: with SMTP id q19mr38644005wra.78.1576607612107; 
 Tue, 17 Dec 2019 10:33:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqyRdKDOjmCWqeNwI5uOb726/Alg0knq/Ldaq2wvDt2t25vdfRs61MvvSmlDL8ODDJ5i5n8xDg==
X-Received: by 2002:adf:b193:: with SMTP id q19mr38643991wra.78.1576607611827; 
 Tue, 17 Dec 2019 10:33:31 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:503f:4ffc:fc4a:f29a?
 ([2001:b07:6468:f312:503f:4ffc:fc4a:f29a])
 by smtp.gmail.com with ESMTPSA id u8sm3843863wmm.15.2019.12.17.10.33.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2019 10:33:31 -0800 (PST)
Subject: Re: [PULL v2 00/62] Misc patches for 2019-12-16
To: Peter Maydell <peter.maydell@linaro.org>
References: <1576605445-28158-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA96uWaOD0wN5g6Q7+eMH-RbkiCYo-aE-d_KvkSFVmUP3Q@mail.gmail.com>
 <bd58ac3a-0430-a3ae-a438-2473ef5d80ea@redhat.com>
 <CAFEAcA_G2O-GRTUzcHcE4e7=Mdrjeju33utbr=gfB-Y5_vcfGA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <501cfe37-ed87-b441-9e45-44bfacda2d0f@redhat.com>
Date: Tue, 17 Dec 2019 19:33:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_G2O-GRTUzcHcE4e7=Mdrjeju33utbr=gfB-Y5_vcfGA@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: KYHPR-ZDMKOfA_x6n2BZOw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/12/19 19:21, Peter Maydell wrote:
> On Tue, 17 Dec 2019 at 18:21, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 17/12/19 19:13, Peter Maydell wrote:
>>> On Tue, 17 Dec 2019 at 17:59, Paolo Bonzini <pbonzini@redhat.com> wrote=
:
>>>>
>>>> The following changes since commit 084a398bf8aa7634738e6c6c0103236ee1b=
3b72f:
>>>>
>>>>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-reque=
st' into staging (2019-12-13 18:14:07 +0000)
>>>>
>>>> are available in the git repository at:
>>>>
>>>>
>>>>   git://github.com/bonzini/qemu.git tags/for-upstream
>>>>
>>>> for you to fetch changes up to 74c14076700436f9d340652042c81f46eaf0cf9=
f:
>>>>
>>>>   colo: fix return without releasing RCU (2019-12-17 14:03:44 +0100)
>>>>
>>>> ----------------------------------------------------------------
>>>> * More uses of RCU_READ_LOCK_GUARD (Dave, myself)
>>>> * QOM doc improvments (Greg)
>>>> * Cleanups from the Meson conversion (Marc-Andr=C3=A9)
>>>> * Support for multiple -accel options (myself)
>>>> * Many x86 machine cleanup (Philippe, myself)
>>>> * tests/migration-test cleanup (Juan)
>=20
>>> I could probably figure out the resolution but I'm about 5 minutes
>>> from having to leave the office; sorry.
>>
>> I pushed a merge commit to the same place.
>=20
> A what? I can't merge a merge commit. Just fix the series
> and resend, please.

You have done so in the past, I'll rebase and send v3 even though this
is invalidating the testing that was done on individual patches.

Paolo


