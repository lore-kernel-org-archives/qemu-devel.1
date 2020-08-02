Return-Path: <SRS0=xk1j=BM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA7EC433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2020 16:06:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C21662065C
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2020 16:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X52HDmqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C21662065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2GUx-0004mM-Vx
	for qemu-devel@archiver.kernel.org; Sun, 02 Aug 2020 12:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k2GU4-0004FO-1u
 for qemu-devel@nongnu.org; Sun, 02 Aug 2020 12:05:12 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35510)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k2GU2-00021D-2I
 for qemu-devel@nongnu.org; Sun, 02 Aug 2020 12:05:11 -0400
Received: by mail-wm1-x341.google.com with SMTP id 184so13332801wmb.0
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2020 09:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ws1fxAGMHnVRWZ31kfad9UqKQ6mX3MoGhBZpWn9MADg=;
 b=X52HDmqC2f6ezVrtiC4LjSXki2R5NyyHnVhHVm5PMY47eTaBC8KXo3jw0tixbP8Zdm
 LiZfsrxd9NOwbrgbImYSR7MM51l8OsRlJ6DB37u8KmVMbDT2yv214oWfjgaTwuOv/FBp
 teHLtIA+I3JKvSTCH1p3JUTLAJxEIG3nrB6Dmi9pB8a/mxNKrj0pVVE3dyhld4d0pFgT
 FZB/Z250HxF9ty9TPK26enFvVKKEUAYt7f5VHi7FkaaqOKv4namOwpT7Ma2TG4nRBEgc
 yHWdDOu8qMk4KTUZcBqYXj0Di9AP6oz3Mw58iuXOsMD3tNlaXNBT2ArVqkLYwrPa9Bck
 NOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ws1fxAGMHnVRWZ31kfad9UqKQ6mX3MoGhBZpWn9MADg=;
 b=dlR5R9oaUjX0vbelTmvhQrUU2gkZWEzB2cxzy8guz69RCpZUnGCa6JuOLj8AHFqLIT
 c7EiDT/mDCLCu+0FGx1i+Nupxs99aWyhUOV4YOQ21+fkOWcZ4Zp5zqfDYAPuC8NtB/8A
 BB7Z2fo5l7pJwDif/fefWeJmxS7rp1dgjRttlFkIY1r9F5WSEyjIPYsdWnq9YSy2u0b8
 NKMvvqsb+AelXOYGKcXl34Yw0omCyKYw8OE4bOYxAqyBeuKVbJA5MgG3uyqu5HrcJA94
 2cNLBRd4vUmsIkuHWxf6kJep4a1HMenqT8ijMWY9dl30g8IJXZILgM99X1kC/89Jwlps
 QVCA==
X-Gm-Message-State: AOAM532mrHb1ckdRa0OwMRQ9jJPha/TFcS8VfBc4yuwf1dZM6OBj33/1
 mr7ZUwaVLl8Ep/2oFBbX24CktQ==
X-Google-Smtp-Source: ABdhPJzRdjf4mpdyajAOlzOSP1cqicZ/+xTJlqbltHVRtD7rQg5QeIBx/4LFzbrTIfGI66K3w6rcIw==
X-Received: by 2002:a1c:1f85:: with SMTP id
 f127mr13019077wmf.154.1596384307067; 
 Sun, 02 Aug 2020 09:05:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a10sm19845002wrx.15.2020.08.02.09.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2020 09:05:05 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AB1E71FF7E;
 Sun,  2 Aug 2020 17:05:04 +0100 (BST)
References: <20200731125127.30866-1-robert.foley@linaro.org>
 <20200731125127.30866-2-robert.foley@linaro.org>
 <20200731174353.GF225270@habkost.net>
 <CAEyhzFuBiqpAijLMw-SZmiDyGQnc2c6yk6g+E0HN9eSYRVaWMA@mail.gmail.com>
 <20200731192404.GH225270@habkost.net>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 1/2] hw/core: Add bql_interrupt flag to CPUClass
In-reply-to: <20200731192404.GH225270@habkost.net>
Date: Sun, 02 Aug 2020 17:05:04 +0100
Message-ID: <87ime1yqxb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Robert Foley <robert.foley@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Puhov <peter.puhov@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Eduardo Habkost <ehabkost@redhat.com> writes:

> On Fri, Jul 31, 2020 at 03:14:02PM -0400, Robert Foley wrote:
>> On Fri, 31 Jul 2020 at 13:44, Eduardo Habkost <ehabkost@redhat.com> wrot=
e:
>> > >
>> > > +static inline void cpu_class_disable_bql_interrupt(CPUClass *cc)
>> > > +{
>> > > +    cc->bql_interrupt =3D false;
>> > > +}
>> >
>> > Class data is not supposed to change outside class_init.  Why do
>> > you need this function?  I don't see it being used anywhere in
>> > this series.
>>=20
>> This function was to be called from changes in a later patch series
>> that depend on these changes.  BTW,  I added a correction above,
>> it should be disable, not enable.  The idea is that it is initialized to=
 true,
>> but then the per arch changes would use this call at init time to set
>> it to false
>> as needed.
>
> If you plan to call it from class_init, I don't think you need a
> wrapper.  You can simply set cc->bql_interrupt=3Dfalse directly
> inside arch-specific class_init functions.

We just need to be careful of the ordering so the base class init goes
first. Is that always the case?

>
> If you plan to call it from somewhere else, then maybe the field
> doesn't belong to CPUClass.
>
>>=20
>> We can remove this function from this series and add it in later when
>> it gets used,
>> it might make things more clear.
>
> Makes sense to me.


--=20
Alex Benn=C3=A9e

