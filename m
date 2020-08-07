Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E718C433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:18:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57B1220748
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITJ98ouN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B1220748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3zRn-0000j9-DG
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 06:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3zQv-0008JS-40
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:17:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59232
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3zQt-0008G6-A1
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596795422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pALab47WHEqclF8NkYZHJ7c018KEauRTJHp74mXWRtQ=;
 b=ITJ98ouN5n/sG2kng3mWNH3yUElpUQubBNubx1AdB+qtRQIpIVKRLZ4Whb3xc2AXxVFjah
 o6Aeay0a0lSTPlf1uJKJicwbxJ89b5wxbn44HH9CPaOs7ZfnaLsHLmYo6QD59Wd0+3Muet
 7/6FO9WGSyT/K1LsNu+QH4uRKYc16kQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-cObUcfffN8a3BExo1y73Fg-1; Fri, 07 Aug 2020 06:17:00 -0400
X-MC-Unique: cObUcfffN8a3BExo1y73Fg-1
Received: by mail-wm1-f69.google.com with SMTP id g72so474092wme.4
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 03:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=bvk77YIxH4yTMLJFLH5PIDZ0nUbjLLqS6nHq13lC0Mw=;
 b=kwP6bjd3g93uQCtPk2wJVqOMYkE6Q8SZeC09BEzTCzTRG/ZephkAl1dlFv1xp5QQYJ
 lA3brDN9AL82lidVm33PfOFKUebAohQZ1Zj8frpm6WgapHDPirKCUib78Ms8kQn/79yN
 yNRjzrP2CfUqAH0s57UxB20nZIl5IwiaP1MrOn3XQmBdgOtV7u+wRzasLUnBXNRH0miN
 B9T6EUJmRDLqYVhRXOW8WuFqbSfizP11KKFjFsfLamOjCupqD8VwfsoeqRbwjvEgew1W
 5wjy4hJRjeFz9eFbtTMbgCRthRvl5Rp6ZItaiBP59uEEpQfvRgigLx/tjdsu3jjV0JOy
 v2VQ==
X-Gm-Message-State: AOAM530dDZswdKigDyHdZF+MpMzLzQAoevVU0/TjDuyj9sUnUJiwIKfo
 gvodAEtYvP0QrHMDlJ3tb1hWM4bFm3iqgILx9k0zPTWfhP+UKTx3urA5y8HfCyEBp/genCNzEos
 o9vYrGoNQVrVnxIs=
X-Received: by 2002:adf:e60a:: with SMTP id p10mr11170311wrm.312.1596795419306; 
 Fri, 07 Aug 2020 03:16:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoMFVfLSc5m9POvHkg6GJshu/9LxnYzg6HOlg9Ty4ihgCFFZVlAorikTtSo+P1l0z6AEy7YA==
X-Received: by 2002:adf:e60a:: with SMTP id p10mr11170294wrm.312.1596795419086; 
 Fri, 07 Aug 2020 03:16:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20?
 ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
 by smtp.gmail.com with ESMTPSA id e5sm10185761wrc.37.2020.08.07.03.16.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 03:16:58 -0700 (PDT)
Subject: Re: [PATCH-for-5.2] exec: Remove MemoryRegion::global_locking field
To: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200806150726.962-1-philmd@redhat.com>
 <20200807100256.GC600298@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <451a50f0-d0ce-5d3b-a38d-e1ca6c0f882f@redhat.com>
Date: Fri, 7 Aug 2020 12:16:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200807100256.GC600298@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="c09pYgPseRbVog1b8cvWfLb2hKM0tIC7F"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 02:21:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--c09pYgPseRbVog1b8cvWfLb2hKM0tIC7F
Content-Type: multipart/mixed; boundary="qTN1Am9Rs32O02DvwWCm3EtNIrochM9BA"

--qTN1Am9Rs32O02DvwWCm3EtNIrochM9BA
Content-Type: text/plain; charset=WINDOWS-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07/08/20 12:02, Stefan Hajnoczi wrote:
> On Thu, Aug 06, 2020 at 05:07:26PM +0200, Philippe Mathieu-Daud=E9 wrote:
>> Last uses of memory_region_clear_global_locking() have been
>> removed in commit 7070e085d4 ("acpi: mark PMTIMER as unlocked")
>> and commit 08565552f7 ("cputlb: Move NOTDIRTY handling from I/O
>> path to TLB path").
>> Remove memory_region_clear_global_locking() and the now unused
>> 'global_locking' field in MemoryRegion.
>>
>> Reported-by: Alexander Bulekov <alxndr@bu.edu>
>> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>> ---
>>  include/exec/memory.h | 14 --------------
>>  accel/tcg/cputlb.c    |  4 ++--
>>  exec.c                |  2 +-
>>  softmmu/memory.c      |  6 ------
>>  4 files changed, 3 insertions(+), 23 deletions(-)
>=20
> It can be added back in later, if necessary. For now let's drop the dead
> code.
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20

I expect it will come back since Linaro is working on BQL-free interrupt
handling for TCG, but no objections.

Paolo


--qTN1Am9Rs32O02DvwWCm3EtNIrochM9BA--

--c09pYgPseRbVog1b8cvWfLb2hKM0tIC7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl8tKhgACgkQv/vSX3jH
roPTuggApfTh4ypZpHLPXuqUL0PbadtDrQfj5MA4P/qSheYhyOFIKdrFYJc8MPub
aCYYDSthVyarCDkOlnqcxcDuXZntpzjZ9jCxONULsG36AUj21Dp57mgaE0mzhK1P
kpa0XlGa7LewXS04JFEw/WmyHyUwSUkIp1tSdyRMl+dMkTLO3N80e5hXicMjqCES
RqEQjbfDK93NJkzU2AVjB0YJq7SDmmyQQW1BwXG+2guPNfnie0q6nPqqK/LOYKMS
ks9WsHTP3LpowbA5xhOm/+zMNTf8hOQ0rTzDtNjG7PHAGR+SphrWJVx282PTo16i
gudWfm7SgO7SV4LYh7NbNtzEgj9ppQ==
=d0yE
-----END PGP SIGNATURE-----

--c09pYgPseRbVog1b8cvWfLb2hKM0tIC7F--


