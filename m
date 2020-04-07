Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72686C2BABC
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:14:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3771520730
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jDU/B+S9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3771520730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLkJl-0002Yv-Dm
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 05:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jLkIy-0001fn-Ob
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:14:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jLkIx-0000zi-H4
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:14:00 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37938
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jLkIx-0000xw-Bb
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586250838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yJM6aeY0t2qqJTEuTfIoTZq5ROP7mudT+3CPQcjRnYA=;
 b=jDU/B+S9tCjIlNzuHVmk0I75vwQNyMGF6m2S4V+++UKhY+GNXwH5nmlTVJA0R2GL9UHHlZ
 b/QPcjnGlWnTgXlA7gtd2wRwyvPWVtKJG53IS5Rm8/ggOiRa8+phUZvQRE2LNuhYHscNw6
 xqJUOh32hbwuuA4mSl8AG0lFttJwWZo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-gAVITeb8PgCw8NO3OCjjBg-1; Tue, 07 Apr 2020 05:13:56 -0400
X-MC-Unique: gAVITeb8PgCw8NO3OCjjBg-1
Received: by mail-wm1-f71.google.com with SMTP id v8so337214wml.8
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 02:13:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=Vb5wc8eHMmQAxgqsM/UOsAhHSjBC4XEM2U/gq5SZZEc=;
 b=GHLA/Lz4SlGS6SZKCxyqrDISAy4M9H/Pvn0h7HmRH6JmmUMJHBPfYbx9hF6QfNjRkB
 oUylqjuot9OoBSJxsjG5XSebOn1pLOLR+K9FZSLQHNwiYLRueONHU80vERykL6PLzj2Q
 8153F3QWPurUV06aUrPxD6qkmZTqAcBYYwwYwhoglMpyfvWNfAYGjxD7q7wANig42Phd
 cMgXkUyDz4kaYN3OgixvONL3VJOQjD+PJ97SfCV0dPhMaJpHdHouPn7vBltTpoFWg9mz
 AVi6K3JvaypQaafIjPwJ5xgfstTVVz/DLe9gA+YWgI/RziZU7ZnuKZsq7+45vLtxhiuc
 +b+g==
X-Gm-Message-State: AGi0PuZx7ZUMfltJ7tVFjs6a5IlyrteKwv2PMfzGCzuM2dEGz11QO4aC
 USTtcWj4PyU6tMVCyXh2rwCpMYL/MeYuLmzKjpHogdEDV1hfgoPlaRLZK2wa2kkao7h5lUmoL6U
 m6Nx4Gzr01bFBLkM=
X-Received: by 2002:a5d:428c:: with SMTP id k12mr1602126wrq.231.1586250834970; 
 Tue, 07 Apr 2020 02:13:54 -0700 (PDT)
X-Google-Smtp-Source: APiQypJtqyl7nwnaYt/mmfRMZO4g5MaCPDaf3H2dx0IRTB33hC9o4+9WqqsPbs/nnUaStkac51z0fA==
X-Received: by 2002:a5d:428c:: with SMTP id k12mr1602107wrq.231.1586250834758; 
 Tue, 07 Apr 2020 02:13:54 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:bd61:914:5c2f:2580?
 ([2001:b07:6468:f312:bd61:914:5c2f:2580])
 by smtp.gmail.com with ESMTPSA id 91sm24809988wrf.79.2020.04.07.02.13.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2020 02:13:54 -0700 (PDT)
Subject: Re: [PATCH 2/4] atomics: update documentation for C11
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200406191320.13371-1-pbonzini@redhat.com>
 <20200406191320.13371-3-pbonzini@redhat.com>
 <20200407090604.GB247777@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <50e6abd4-f487-738e-6fda-df096c242a0a@redhat.com>
Date: Tue, 7 Apr 2020 11:13:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200407090604.GB247777@stefanha-x1.localdomain>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gI7vWIY8JaovXU0v2K8nMUUerUq6fJBug"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Ying Fang <fangying1@huawei.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gI7vWIY8JaovXU0v2K8nMUUerUq6fJBug
Content-Type: multipart/mixed; boundary="Ha4mD63cnHx2YmlxROxLBs3vfkXKxAQ9m"

--Ha4mD63cnHx2YmlxROxLBs3vfkXKxAQ9m
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07/04/20 11:06, Stefan Hajnoczi wrote:
>> -
>> -However, and this is the important difference between
>> -atomic_mb_read/atomic_mb_set and sequential consistency, it is importan=
t
>> -for both threads to access the same volatile variable.  It is not the
>> -case that everything visible to thread A when it writes volatile field =
f
>> -becomes visible to thread B after it reads volatile field g. The store
>> -and load have to "match" (i.e., be performed on the same volatile
>> -field) to achieve the right semantics.
>> -
>> -
>> -These operations operate on any type that is as wide as an int or small=
er.
>> +which however are deprecated.
> Please indicate why they are deprecated and advise which alternative is
> preferred.  This will help readers understand the current best practices
> and make a decision about whether to avoid the deprecated APIs.

True, I will put a link to the "Comparison with Linux" section and clarify.

Paolo


--Ha4mD63cnHx2YmlxROxLBs3vfkXKxAQ9m--

--gI7vWIY8JaovXU0v2K8nMUUerUq6fJBug
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl6MRE8ACgkQv/vSX3jH
roNlMwf+O7ajSgYO01UmMEeRObfxG+tTWRiwukgolOoElMARoCpMrAU0LWF4dHk0
rRI6QT0p37LJpkVF3r+hDaSPlxo5wRFd38CEDiU6MGXIzfo9eN4qcXkwB0V/DhRD
NnkFuOUwqN+clyL0Yim/z18S0U6jEz1cIwN6bOxE85j9ENrcQ4da6phcP4SO3ESP
26gejZzooj1LtPrSJVKqwKNHMe/j3rw8GUCg5s7ra/9Di++4dlmvPIeYV51ISOwD
VlwkfWo4Q0jWdhfe/YKAx/WpybkoPV1BK05MPFN+3CQgRXJiV6GhmlHc0vmub8S9
Ri6GnQ2j3zAIxjOqdF3fefkEOYNaHw==
=tfZQ
-----END PGP SIGNATURE-----

--gI7vWIY8JaovXU0v2K8nMUUerUq6fJBug--


