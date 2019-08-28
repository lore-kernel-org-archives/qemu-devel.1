Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3167C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 16:06:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC14B208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 16:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MeNqjNPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC14B208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i30TJ-0007LS-Fa
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 12:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i30Qu-0005iY-VA
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:04:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i30Qt-0001CS-DN
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:04:28 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45571)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i30Qt-0001Bu-5u
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:04:27 -0400
Received: by mail-wr1-x443.google.com with SMTP id q12so312446wrj.12
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 09:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=QZH6XAoRIYz9ndFtUy8j6/R8kQqT2PFqaWXQp2s1f2s=;
 b=MeNqjNPSwR04vDjQb1604vas51cyszIUtURkpVrofi2yMXLzKh5C1ahsCbbI+qB/lG
 NuLJ+SOgHg7/tT22zIvWKHsuLppmUm5ZFGpDlnGwF50B/uK8S9hu+wIXL7BiVs3i/9IW
 GrLTCOMlCeMLhPnT2Ok/CjZxNXTeMR/xjMOyUspHUPzCqM+KhBBT4CJWWwMCuPU3kTmz
 IkOJFCfYVx6Gu42VAEGrXUuOICFXBzhcXpmRQGnlPjQmR9M+A3dq992vy/SsoM4CYA+7
 aNffDUAKe7s3zWgWvj7O2zdVe9U6A6/Gr/jneiOAVD/T0rcVNmJ4cr3cc805dxscaHfc
 5gNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=QZH6XAoRIYz9ndFtUy8j6/R8kQqT2PFqaWXQp2s1f2s=;
 b=YbTRDtQoXSKalZ2izc5/y7/bFew4Xj69Bqqq36Avwk43aYTJu7BNp5ej1VaRwJbLlM
 ZfBLwN35I6C5QPwc+63ZdvVvgElpyBiflMt/3NreJP0R5gEiZJHN3D0UwVksuzxL1rQa
 gleknsKR8V8kwbVUeVcV/Fm54+juacqeCnDREKEu5Ie6R3CGyncBA0QBt4MTtSzs/t4c
 eAKNbgaEhn4JUf84Y2xbiN9ncWyX8PiW6GgSsQ5ruEELvtmmFukJVuy7710Ty20joEud
 9xyPzzesjg6PGg7rBwEtEcfAc1TOwRUzMVCpcGdn8J/iTBC+xtDprUomjQ+xqRJMYutJ
 ELJA==
X-Gm-Message-State: APjAAAVm8iB8Johv1y2MYBe7pNyZOMyUnlzX1RxF/nz5sSz3kh8QrGFS
 My+uZdz9cL+UcLN0DauV68xz899/KEo=
X-Google-Smtp-Source: APXvYqxQEU5m43WYQE3Xi/35mepJVw0jDxJyNQ4Al1ZEx5aWhbyjTSIxfyhJxpxp4vBIZOuf+DIR9w==
X-Received: by 2002:adf:dc81:: with SMTP id r1mr5628193wrj.52.1567008265506;
 Wed, 28 Aug 2019 09:04:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s64sm7621319wmf.16.2019.08.28.09.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 09:04:24 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CC0291FF87;
 Wed, 28 Aug 2019 17:04:23 +0100 (BST)
References: <20190823163931.7442-1-berrange@redhat.com>
 <20190823163931.7442-4-berrange@redhat.com> <878srd5nlz.fsf@linaro.org>
 <20190828152028.GM2991@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
In-reply-to: <20190828152028.GM2991@redhat.com>
Date: Wed, 28 Aug 2019 17:04:23 +0100
Message-ID: <874l215la0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 3/4] docs: document use of automatic
 cleanup functions in glib
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


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Aug 28, 2019 at 04:14:00PM +0100, Alex Benn=C3=A9e wrote:
>> > +The cleanup functions are not restricted to simply free'ing memory. T=
he
>> > +GMutexLocker class is a variant of GMutex that has automatic locking =
and
>> > +unlocking at start and end of the enclosing scope
>> > +
>> > +In the following example, the `lock` in `MyObj` will be held for the
>> > +precise duration of the `somefunc` function
>> > +
>> > +    typedef struct {
>> > +        GMutex lock;
>> > +    } MyObj;
>> > +
>> > +    char *somefunc(MyObj *obj) {
>> > +        g_autofree GMutexLocker *locker =3D g_mutex_locker_new(&obj->=
lock)
>> > +        g_autofree char *foo =3D g_strdup_printf("foo%", "wibble");
>> > +        g_autoptr (GList) bar =3D .....
>> > +
>> > +        if (eek) {
>> > +           return NULL;
>> > +        }
>> > +
>> > +        return g_steal_pointer(&foo);
>> > +    }
>>
>> I would personally prefer we get some RFC patches for auto-unlocking und=
er our
>> belt before we codify it's usage in our developer docs. Locking is a
>> fickle beast at the best of times and I'd like to see where it benefits
>> us before there is a rush to covert to the new style.
>>
>> For one thing the only uses I see of g_mutex_lock is in our tests, the
>> main code base uses qemu_mutex_lock. How would we go about registering
>> the clean-up functions for those in the code base?
>
> Ideally we could just relpace qemu_mutex with g_mutex, but if that's
> not possible we would have to create a clone of GMutexLocker as
> QemuMutexLocker doing exactly the same thing. It is a shame to reinvent
> the wheel with our threading code though.
>
> /me tries to remember what it was that we can do with QEMU's threads
> that we can't do with GLib's threads.

Apart from having separate POSIX and Win32 implementations we have also
extended the mutex handling to add trace points and also support
profiling of lock latency.

>
> Regards,
> Daniel


--
Alex Benn=C3=A9e

