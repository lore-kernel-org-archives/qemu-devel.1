Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B88C47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 10:09:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DD582084D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 10:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD582084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHPxV-0004QZ-48
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 06:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59763)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iHPwX-0003UM-FU
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 06:08:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iHPwV-0000HF-Tk
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 06:08:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38074)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iHPwV-0000Gt-ON
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 06:08:39 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 82777C04FFE0
 for <qemu-devel@nongnu.org>; Mon,  7 Oct 2019 10:08:38 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id w8so7314621wrm.3
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 03:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YxSwWRKpC6ZMZxhY4f57DEJrW0GCR2ANaFJ+FdL5xLQ=;
 b=s7wQKraJg5VCUYFVHunT2DYP1M1TavQN17GrdVPhM4xtD5MsfupwO7Smb8BGoN4wlR
 pb/GqKdvUShECCgts/+fP3DVGRmvpxZaVAG0g3NhiR1ECKxvmSUp2pvuNxkrDc0HY/eA
 ktw6ThcHyDkW4C5sR+Wh1Dy/Ntm0Z/x0i6ZRaesEuRN4ptS9gVt6zc3DctmhgFGYZOCp
 e0ylHiArpZAzYuww0FSpmUVRmzXyQnA+b5phEcqTwFTCI+tCxSv+yofzl93GLnacSCUG
 FyFpc8fEr6y07/oP7OV43KqDqa40F4NhQYe40txPZXMqQBRZoi3iLWdvF6y7pt8OzkUf
 /Tuw==
X-Gm-Message-State: APjAAAXEDctxh5EROj14wUbLEaqJj981l12X6Qt1XKbtj4comq3KqiIj
 vjuAOtsYDfMaGi4gtcyXO9yavpn3+utWiiDGewQbA4n74qUznUdm1qEfRfF51BsddUUHBhgSTXw
 tdeOoHAsj6kHqsA0=
X-Received: by 2002:a1c:7d4b:: with SMTP id y72mr15371031wmc.177.1570442916931; 
 Mon, 07 Oct 2019 03:08:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxEZnJK5x5TkQgp3z0uZSJw00lCbvjOMcpaEaRBusdxh0g84EcWQ/OR0GqFim45EUkKFLFQwA==
X-Received: by 2002:a1c:7d4b:: with SMTP id y72mr15371019wmc.177.1570442916728; 
 Mon, 07 Oct 2019 03:08:36 -0700 (PDT)
Received: from [192.168.1.115] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id l6sm16502841wmg.2.2019.10.07.03.08.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2019 03:08:36 -0700 (PDT)
Subject: Re: [PATCH 2/4] migration/postcopy: fix typo in
 mark_postcopy_blocktime_begin's comment
To: Wei Yang <richardw.yang@linux.intel.com>, quintela@redhat.com,
 dgilbert@redhat.com
References: <20191005220517.24029-1-richardw.yang@linux.intel.com>
 <20191005220517.24029-3-richardw.yang@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e46f93a2-6660-f00d-e4e3-19cb17b6b582@redhat.com>
Date: Mon, 7 Oct 2019 12:08:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191005220517.24029-3-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/6/19 12:05 AM, Wei Yang wrote:
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>   migration/postcopy-ram.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index d2bdd21ae3..a394c7c3a6 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -768,9 +768,11 @@ static void mark_postcopy_blocktime_begin(uintptr_=
t addr, uint32_t ptid,
>       atomic_xchg(&dc->page_fault_vcpu_time[cpu], low_time_offset);
>       atomic_xchg(&dc->vcpu_addr[cpu], addr);
>  =20
> -    /* check it here, not at the begining of the function,
> -     * due to, check could accur early than bitmap_set in
> -     * qemu_ufd_copy_ioctl */
> +    /*
> +     * check it here, not at the beginning of the function,
> +     * due to, check could occur early than bitmap_set in
> +     * qemu_ufd_copy_ioctl
> +     */
>       already_received =3D ramblock_recv_bitmap_test(rb, (void *)addr);
>       if (already_received) {
>           atomic_xchg(&dc->vcpu_addr[cpu], 0);
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

