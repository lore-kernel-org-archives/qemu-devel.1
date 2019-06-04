Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8604FC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 09:45:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D6324A67
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 09:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R1kTrD/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D6324A67
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49476 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY60T-0004DR-CS
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 05:45:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hY5zC-0003Sk-8E
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 05:44:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hY5zA-0003SD-B8
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 05:44:06 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hY5z9-0003Qk-2T
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 05:44:04 -0400
Received: by mail-wr1-x443.google.com with SMTP id e16so6816547wrn.1
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 02:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=aylZ20QvLWPu2u6KQFXYM67CTXflwloeZ8LOqhgOpKE=;
	b=R1kTrD/tNWnuXIyylMqJujeA3jzqyrp/Im+13iH6AjbH++seNB/7OyQFdYOQmKwR31
	bac94Takg/6c++Ali+lcDN9kogjOdUvIPhQZ26KDR12HfXaenoRl/GxKjiBNIsQoJlaW
	itPULU66vHuwO306fbmJ+Gxu0lEs5Daaa/Vj+pf05HK/GHjaYzzkiaPEsJwJcmaz/n6v
	Pfp+/WZJxazF7eHtr91nFx4ZPnkbakPnbkmxdCHTh22Z+HzHsUgCw+RsRK5aCVA870+b
	1eBOxYZviVoaMphQ1P9yZuG7H1GbQPTCfTi7GwBY48284p1/d95bWDVeoH1WG7se69DV
	TuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=aylZ20QvLWPu2u6KQFXYM67CTXflwloeZ8LOqhgOpKE=;
	b=Eo0rFx+9u/7pu9VhD05ZYVRjsh0peRtCuJmu8LijGQBKBhlCb03NRQf7cAN8O5B/Ry
	esRkycFAn2Be5suMnhGfFOsiEFVj/aikme+7EskRxSsRtQT11VKADKZVC/frKOlFw2b5
	B8L6e2PJL3bpmIlnht0ZKqOow7S+PwNgto2plNy9fWjbmBhVbWeW0jYOfEKDjaJYAi+b
	GMbcDIkn9RsMdUoNDzX2ifkfSMMLQY65Pfgu76MNDvPpgJdtqKsIEi6mWohigCRNs8ec
	a4+j3ucIsb2ab2HJnsSYHsbWVnZcB8e85AtZBD74HrdY3PgFq9Ha0iC1Gh5z/7PcZJc6
	Gpaw==
X-Gm-Message-State: APjAAAWfVOaUM7L4Twzv8AEWDQCpLtVE9UD6+RSbAbagAuOYhG6BB4A9
	2DrVTttMjWROgn5s+t7D0LSzHw==
X-Google-Smtp-Source: APXvYqzLHY/g2nUh+xLC7pwZZIjl37kYihmLx//qjxVBpSiAbA0QfDJbvQQsf2oJOb1JGUZZH8opDQ==
X-Received: by 2002:a5d:6a90:: with SMTP id s16mr19991225wru.288.1559641441031;
	Tue, 04 Jun 2019 02:44:01 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	b8sm13159786wrr.88.2019.06.04.02.43.59
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 04 Jun 2019 02:43:59 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 9D83C1FF87;
	Tue,  4 Jun 2019 10:43:59 +0100 (BST)
References: <20190603150120.29255-1-alex.bennee@linaro.org>
	<201906031835.13420.randrianasulu@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Andrew Randrianasulu <randrianasulu@gmail.com>
In-reply-to: <201906031835.13420.randrianasulu@gmail.com>
Date: Tue, 04 Jun 2019 10:43:59 +0100
Message-ID: <87zhmxsn1c.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [RFC PATCH] cputlb: use uint64_t for interim
 values for unaligned load
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: 1830872@bugs.launchpad.net, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Andrew Randrianasulu <randrianasulu@gmail.com> writes:

> =D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=
=82 Monday 03 June 2019 18:01:20 Alex Benn=C3=A9e =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=BB(=D0=B0):
>> When running on 32 bit TCG backends a wide unaligned load ends up
>> truncating data before returning to the guest. We specifically have
>> the return type as uint64_t to avoid any premature truncation so we
>> should use the same for the interim types.
>>
>> Hopefully fixes #1830872
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  accel/tcg/cputlb.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
>> index cdcc3771020..b796ab1cbea 100644
>> --- a/accel/tcg/cputlb.c
>> +++ b/accel/tcg/cputlb.c
>> @@ -1303,7 +1303,7 @@ load_helper(CPUArchState *env, target_ulong addr, =
TCGMemOpIdx oi,
>>          && unlikely((addr & ~TARGET_PAGE_MASK) + size - 1
>>                      >=3D TARGET_PAGE_SIZE)) {
>>          target_ulong addr1, addr2;
>> -        tcg_target_ulong r1, r2;
>> +        uint64_t r1, r2;
>>          unsigned shift;
>>      do_unaligned_access:
>>          addr1 =3D addr & ~(size - 1);
>
> Unfortunatly, this doesn't fix 32-bit qemu-system-x86_64 .... so, my
> bug is separate from #1830872 ?

I think you've hit two - one of which we have just fixed. With my
expanded memory test on i386 I'm seeing a hang but it's ok @
pull-demacro-softmmu-100519-1. Unfortunately bisecting through the slirp
move and other i386 Werror stuff is proving painful.

>
> I also was unable to convince qemu to use my kernel-only x86_64 gcc 6.5.0=
 cross-compiler ..
> probably x86-64 testing on i686 requires either docker (I don't have this
> ) or 'real' cross-compiler (build with glibc support).


--
Alex Benn=C3=A9e

