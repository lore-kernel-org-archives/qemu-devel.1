Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AE3CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:20:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EF832084C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="id9mtq/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF832084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNJNB-00049b-8H
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 12:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iNIvc-0002QZ-4c
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:52:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iNIvY-0002g4-Sq
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:52:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42573
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iNIvX-0002f0-R8
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571845917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=4Ob/xIXJBCG5tLfXBADlNo4bUEXD7og5u1mBYUb4qkg=;
 b=id9mtq/WE2YpMPU6VNkJqS7VQs/QafuOV8rT9eNwu1q3Fn2TXLXCSmFsuM6JL1ONzaKk7B
 9lJNjmNQeQJRA2WbcW4WvDI23bPwKFYK4HO+ZaLpgforoz4CiOJltlA1LHxSXiAgbWjLkk
 /3/dEITJTlinTEeYY79nI0xoBMAfPXU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-CM0aH45zP6yoL3ilOfMRcw-1; Wed, 23 Oct 2019 11:51:54 -0400
Received: by mail-wr1-f69.google.com with SMTP id e14so11167590wrm.21
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 08:51:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fSMvcQIAJ52sZ3CkOU3CAdCDlsgkHSLmi6Doq0FBN/M=;
 b=b+eXYWCDhYXb2/tBu7BWH4+g3dANFe9j2rmMUKo7tSFTQy6YjQ7JDWfji1b4XNeetK
 ucElcAtYFWYTJnWbuRPrAIg8pP2ud8UjUQrVr3YGRZju4nHRD1faaCJ1XoRgnndioi/h
 tptbi7NgWK9BqD/kxH5na3Yu86KBKM653p35x9kFYl4iZhFuJRJ4kLgxpXBx0EUD9f8h
 oy9+Awl8cPfVd5I1naDD4I3s4KdIm9y9fyQkUd+9pGLawXkXyto1h93hIreLDKo8D254
 jakMH7u8fPeuQCkYLKXzYwUNIg/c3/BmvwNM6V5Wkbi8CXaebjNwCW/0wndsF9I8cWB2
 bG2Q==
X-Gm-Message-State: APjAAAWByxhDp3waFRU+224VrNpEyfFtp4o2L//u74AdjKU0jJE0mSPw
 vG+psdm/noqdCZfSy7oNv+CpwFB+ehVTkiT5ABd+joZYyjq25FPtTpK6m4fqg+vE1cvf9p3PP7p
 YsrvXvOP1a6pqTeM=
X-Received: by 2002:a7b:ce12:: with SMTP id m18mr514891wmc.35.1571845913061;
 Wed, 23 Oct 2019 08:51:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxyNhEWQAyzBbMkWVamw6iJCFvC+AEiowawMGUa9sW5LRxV9gshKVHadZKSKEXSBNrHjdNyKg==
X-Received: by 2002:a7b:ce12:: with SMTP id m18mr514869wmc.35.1571845912711;
 Wed, 23 Oct 2019 08:51:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:51de:b137:4c45:7cea?
 ([2001:b07:6468:f312:51de:b137:4c45:7cea])
 by smtp.gmail.com with ESMTPSA id q22sm19215987wmj.5.2019.10.23.08.51.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2019 08:51:52 -0700 (PDT)
Subject: Re: [PATCH] Semihost SYS_READC implementation
To: Keith Packard <keithp@keithp.com>, qemu-devel@nongnu.org
References: <20191022031335.9880-1-keithp@keithp.com>
 <d7470bfa-ba4e-3287-326f-ee63c5d76407@redhat.com> <87sgnk3b0k.fsf@keithp.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5e8913f8-558d-6a2e-c7d0-787ec533e4a9@redhat.com>
Date: Wed, 23 Oct 2019 17:51:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87sgnk3b0k.fsf@keithp.com>
Content-Language: en-US
X-MC-Unique: CM0aH45zP6yoL3ilOfMRcw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/10/19 20:12, Keith Packard wrote:
> $ qemu-system-arm -chardev stdio,mux=3Don,id=3Dstdio0 -serial chardev:std=
io0 -semihosting-config enable=3Don,chardev=3Dstdio0 -mon chardev=3Dstdio0,=
mode=3Dreadline=20
>=20
> It might be nice if this could be shortened, but it certainly provides
> the necessary options to make it all work.

Yeah, it's not easy to cram all of the possibilities in the command
line, so in general you need two options, one for the backend ("stdio")
and one for the front-end ("semihosting").  In some cases there are
shortcuts that refer the front-end name in the option name ("-serial"),
but semihosting isn't one of those.

There is no particular reason for this, except for the fact that the
older option "-semihosting" was added without an argument many many
years ago.

> I'll post an updated version of the patch in a while, after waiting to
> see if there are any additional comments.

Indeed I have a couple comments, mostly on coding style and duplication:

>=20
> +typedef struct SemihostingFifo {
> +    unsigned int     insert, remove;
> +
> +    uint8_t fifo[FIFO_SIZE];
> +} SemihostingFifo;
> +

Please take a look at include/qemu/fifo8.h instead of rolling your own
ring buffer.  Note that it is not thread-safe so you'll have to keep
that part.

>=20
> +target_ulong qemu_semihosting_console_inc(CPUArchState *env)
> +{
> +    (void) env;

No need for this, and also...

> +    SemihostingConsole *c =3D &console;
> +    qemu_mutex_unlock_iothread();
> +    pthread_mutex_lock(&c->mutex);
> +    while (fifo_empty(&c->fifo)) {
> +        pthread_cond_wait(&c->cond, &c->mutex);
> +    }
> +    uint8_t ch;

... we tend not to mix declarations and statements.

> +    fifo_remove(&c->fifo, ch);
> +    pthread_mutex_unlock(&c->mutex);
> +    qemu_mutex_lock_iothread();
> +    return (target_ulong) ch;
> +}
> +

Kudos for the unlock/lock_iothread; I am not really familiar with the
semihosting code and I would have naively assumed that it runs without
that lock taken.  It is indeed better to have your own mutex, because we
do want to pull the unlock/lock up into do_arm_semihosting or even its
callers.

Thanks,

Paolo


