Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E519C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:11:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 371C7207ED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GwXhLnjR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371C7207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jicAg-0006bK-Dq
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 07:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jic8m-0004DR-QF
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:10:01 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33444)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jic8l-0001ZH-Pf
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:10:00 -0400
Received: by mail-wr1-x443.google.com with SMTP id l11so20831022wru.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 04:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=XJkEtaaLfEOVGgotb4bc0e25yEVnWj9eKM/Dme8rE1I=;
 b=GwXhLnjRwnkR91HSgcflinu+7qUmp1+MDgI8D5szpdqHaKH2In7RD06iuGbjKkoWgB
 VY+/k8dUBEt+mT5ddvrbSq4JzY1dN1aQ1y0tql6mOROReTq0EclwFBmP2yAwNrX5K9cM
 ObH12ybP5XDA6j7UuKQXMk4DEsC33jR9d57I1UgX9vhdZzlVHvTm27M8uJNlDMPuO/m5
 U54R/TYM6liixQGsGuDhjZmUJb4kBiiI+vzqUSDT4b1NjcWw3mdc8wytMo7V1c36L6ox
 QiquOwBDuf5YwtTC4LpPiEmd6Pj3EA6o0SF0M3Sqctu7swDk405/+qX8vgMXuMZ1LtSt
 AWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=XJkEtaaLfEOVGgotb4bc0e25yEVnWj9eKM/Dme8rE1I=;
 b=aeL6fipZ1LCzDQVls96pbGgfTuDvakKnNnX+g0hlj5vdWJ6XwRC5erS6tBs0Fds55F
 n0BDwPVx5wNO0YB6HewA0JiYEjfilBr8dBdVyzUKfPwtVZqwnReHH049xL6e7Ub73BtW
 gedpUvfzNyGgURzifEduU0YHgtIFAE1tXw9pxtf0MVLCwcikm+tPFo/BxRb3IL20h9zZ
 sephJByimQg5k+tj4q16veh7Ymim/O45+YbpRCItZtl2BbPx1Ebbn2QDMcVjdhU5u55Z
 G1SIryw6YeoisW1etaE4i7Y3qz/0TuEmJDUO9n676OklIM/AUzC470l0VQxbkoq/TzX5
 GNAQ==
X-Gm-Message-State: AOAM533dpfvqziqCjyGSjjrh3IlNKvpi/+OoOjZKp50aIRDVZfEJG2um
 p25NLAI3hwg6OGZKBbl45NqoVw==
X-Google-Smtp-Source: ABdhPJxsp6/H0PG8ea9anWbAHxV2Knzcb0ZxBJFjn7nlBd1M3W9S6Ap4H05bYa3gI90AHksZ+qabzw==
X-Received: by 2002:a05:6000:12c2:: with SMTP id
 l2mr3652885wrx.133.1591700996350; 
 Tue, 09 Jun 2020 04:09:56 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b187sm2619092wmd.26.2020.06.09.04.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 04:09:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 394ED1FF7E;
 Tue,  9 Jun 2020 12:09:54 +0100 (BST)
References: <20200602154624.4460-1-alex.bennee@linaro.org>
 <20200602154624.4460-8-alex.bennee@linaro.org>
 <20200608034504.GA3619843@sff> <87zh9e6kxy.fsf@linaro.org>
 <20200609040902.GA3724030@sff>
User-agent: mu4e 1.5.2; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Emilio G. Cota" <cota@braap.org>
Subject: Re: [PATCH v1 7/9] plugins: add API to return a name for a IO device
In-reply-to: <20200609040902.GA3724030@sff>
Date: Tue, 09 Jun 2020 12:09:54 +0100
Message-ID: <87y2ow4hrx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: robert.foley@linaro.org, qemu-devel@nongnu.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, kuhn.chenqun@huawei.com, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Emilio G. Cota <cota@braap.org> writes:

> On Mon, Jun 08, 2020 at 09:06:17 +0100, Alex Benn=C3=A9e wrote:
>> Emilio G. Cota <cota@braap.org> writes:
>> > I'd rather use asprintf(3) and strdup(3) here, so that plugins don't
>> > have to worry about glib, and on the QEMU side we don't have to worry
>> > about plugins calling free() instead of g_free().
>>=20
>> AFAIK you can actually mix free/g_free because g_free is just a NULL
>> checking wrapper around free.
>
> I was just going with the documentation, but you're right:
>
> https://github.com/GNOME/glib/blob/mainline/glib/gmem.c#L196
>> void
>> g_free (gpointer mem)
>> {
>>   free (mem);
>>   TRACE(GLIB_MEM_FREE((void*) mem));
>> }
>
> The NULL-pointer check is done by free(3), though.
>
>> However ideally I'd be passing a
>> non-freeable const char to the plugin but I didn't want to expose
>> pointers deep inside of QEMU's guts although maybe I'm just being
>> paranoid there given you can easily gdb the combined operation anyway.
>>
>> Perhaps there is a need for a separate memory region where we can store
>> copies of strings we have made for the plugins?
>
> I agree with the idea of not exposing internal pointers to plugins
> (e.g. we don't pass a CPUState *, only an opaque handle) so I'm OK
> with returning a dup'ed string here.

How about a g_intern_string() as a non-freeable const char that can also
be treated as canonical?

>
> (snip)
>> That said in another
>> thread Peter was uncomfortable about exposing this piece of information
>> to plugins. Maybe we should only expose something based on the optional
>> -device foo,id=3Dbar parameter?
>
> I have no opinion on whether exposing this is a good idea. If it turns
> out that it is, please have my
>
> Reviewed-by: Emilio G. Cota <cota@braap.org>
>
> Thanks,
>
> 		Emilio


--=20
Alex Benn=C3=A9e

