Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8517C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:41:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0E0724691
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IwPKIQyu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E0724691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7d5a-0005yG-OF
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 05:41:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32993)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j7d4g-0004zI-Jx
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:40:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j7d4f-0003FN-M4
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:40:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28550
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j7d4f-0003F2-IJ
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:40:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582886453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ILtFwBgCpSe0iS6137b8cYGHJaH0uF7c/1JpqWTrNM=;
 b=IwPKIQyum03nEOOhiyKhlrNeNCP/w9FnHHhK491fgyY1CHHgp99JqqpY/2OGGDvqxyXD+f
 YhbuK4bHIaxAptUyb0n9MfUuEVnA3hSjSFzgOcnXFZisKD54xcbkPBT+I4KdkjOxxypQLs
 +ozuwhQi4sQX/ujGig1dwHgfmj4QH5I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-SEWLOq8IPFyxVV76I1dPHw-1; Fri, 28 Feb 2020 05:40:49 -0500
X-MC-Unique: SEWLOq8IPFyxVV76I1dPHw-1
Received: by mail-wr1-f71.google.com with SMTP id w6so1149070wrm.16
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 02:40:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OIHrLoMHagkAXvmKSTruSISh6aH6caxkIMMed6iuYPU=;
 b=bR0wKpu7/HQ5B5mOqrOTZ27ZCvgu5EopFkQE3Jxj9KSp+lX8VHI/E5p2IDLBfHSyN3
 ElSIXtqGZ+OaovObXeLjVqG8D4bBSgO5Qkj2sfGuD0EkhkPXgwvIEYkGeSXuO1v4UDyB
 Z7KpCUUA9E+KhjaTuIDZ4NoRoHbciz85WZUnQvL5NOgl/XncZcoN6jQ+m7wcWqhuET1F
 0XE/uPKtyn9cM6NbBYHe7vRwKDRxpKgYEXKqlIyvftODLvRGB6GCC5eTjnkOGjXXzopH
 7rjSbTXnSQKHuuYBK0nFf1d5B1AInzsYmBE5O83eRMU9AsgY4CWtPfb9tNI1uyPjFNll
 GPjg==
X-Gm-Message-State: APjAAAVTQ4nqjjfqB8qGuS1eV7MNMRSiR69BFlRJeWFvkJTpmDwhlFBm
 p+hUKO9rHl+j+Vl7z8xufz+6Z5xbS33YBrSgSaBZ+6mnmjwkgbDZ3AKWzPA+ef384ox0HicMz5s
 UQUF2LpLWk5lPJdY=
X-Received: by 2002:a1c:a70a:: with SMTP id q10mr3146wme.88.1582886448116;
 Fri, 28 Feb 2020 02:40:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqzh2/d8qIFLaBDyIfgJpaW8L8nmOtlIcHzjTuM40e4C3ZvrGSRKakV9PqI0nn0PP2Mm1Ig1Kg==
X-Received: by 2002:a1c:a70a:: with SMTP id q10mr3128wme.88.1582886447892;
 Fri, 28 Feb 2020 02:40:47 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:d0d9:ea10:9775:f33f?
 ([2001:b07:6468:f312:d0d9:ea10:9775:f33f])
 by smtp.gmail.com with ESMTPSA id b197sm1743466wmd.10.2020.02.28.02.40.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2020 02:40:47 -0800 (PST)
Subject: Re: [PULL 000/136] Misc patches for 2020-02-25 (refactoring and
 Coccinelle edition)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
 <CAL1e-=g6Kj3+vOuUArPyxdpZCn12GvQbo=O4PiYnCym5x6u-og@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e16ca187-1d60-864b-91d5-4fe74a877c91@redhat.com>
Date: Fri, 28 Feb 2020 11:40:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=g6Kj3+vOuUArPyxdpZCn12GvQbo=O4PiYnCym5x6u-og@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/02/20 22:07, Aleksandar Markovic wrote:
>=20
>=20
> On Tuesday, February 25, 2020, Paolo Bonzini <pbonzini@redhat.com
> <mailto:pbonzini@redhat.com>> wrote:
>=20
>     The following changes since commit
>     c1e667d2598b9b3ce62b8e89ed22dd38dfe9f57f:
>=20
>     =C2=A0 Merge remote-tracking branch
>     'remotes/stefanha/tags/block-pull-request' into staging (2020-02-24
>     11:38:54 +0000)
>=20
>     are available in the git repository at:
>=20
>=20
>     =C2=A0 git://github.com/bonzini/qemu.git
>     <http://github.com/bonzini/qemu.git> tags/for-upstream
>=20
>     for you to fetch changes up to 4db373bef1544b3b5e02ed376d0788c5b6a754=
8b:
>=20
>     =C2=A0 Merge branch 'exec_rw_const_v4' of https://github.com/philmd/q=
emu
>     into HEAD (2020-02-25 09:37:42 +0100)
>=20
>     ----------------------------------------------------------------
>=20
>=20
> Hmm, Paolo, what happened to this cover letter to contain diffs for a
> couple of files at the end (that never happens for any cover letter)?
> How was that possible? I am just curious.
>=20

I honestly have no idea.

Paolo


