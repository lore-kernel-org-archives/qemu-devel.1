Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16ADBC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 17:27:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D580C205CB
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 17:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OLl6WgLI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D580C205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgXAc-00047D-3s
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 13:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgX9w-0003Gq-7l
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 13:26:36 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51544)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgX9u-0001Z9-Cl
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 13:26:35 -0400
Received: by mail-wm1-x341.google.com with SMTP id u13so2697777wml.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 10:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Qpnaerqa+GN8XLj0KI816bESh6uGtmDu75i7HfmLSYM=;
 b=OLl6WgLI2HxthbhbpVWjgsLTf2ENzsDHhlg7tXsSTI69Cwf7yZf5CXZn0ch3teEU4l
 DT0rTA/Tp7VZquyu13MxR2VqTTw5czyaNO3p43kbOWtaHQuWf/6W/eTTiDUjpYsvPc2M
 9bwZFOr44bY8zW2alxDMoAeLoP0PMbN6Xcif/dE02JgucNpEOD0eAZft4RWE9BqUVQgT
 D7u+ikgx82hxIrXcGL/L52rOQKUUqBvPejNbekWEqUQ1RrXJFncT0pYemSifuR1MQnmN
 W9Q9u8VToTIqobTRf5fkW3ZEQETijQHewNuHjFjp/xoWcJsxH4G0tu+LOnJhX7moDMqb
 HhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Qpnaerqa+GN8XLj0KI816bESh6uGtmDu75i7HfmLSYM=;
 b=QwZtjuzWienN4OaId32YfwWis4lRvdJNjhX/eX6GibeWhpF5lzQD0OasDJ5TFI+0tP
 Mxp1wNfkJOSpM7NjRdUU1mP47iC+wAmDLPjq2ukKIA7JjIe9FsgJfzB6z3os0BUtSuhu
 lJ/vaR5RZOt07TKqz7tcv7iha84wGtdZ6h+oZPqg0t0cai35/yN5R5s6v8xjntb9vEat
 VgB41ROjkKmGbTvHGTC9VuC3hrI9JuJ6Iu6+K9btINtHgLe4Ftv7tykb56yVtGY+NqBn
 tFwTq7phP+CshatTXFHVDifeicl4bEfZUnWhSCv3e+PTdSAVJS2VNhseWYyhcLf/Pid2
 q8zA==
X-Gm-Message-State: AOAM532ZQkWUDAJ/O4nRSu3IgJswUmxS77bnnj4Qf4sVnLK+TH6nWNqi
 R5Dk2+gHx74n05Tbuad272G7dw==
X-Google-Smtp-Source: ABdhPJwbrJHA0GB/0iGLL2Jdpigl6PN39IAxtioCdi0MF+j5RoRj1TEzI8+dB8Vb3bhuDveFxCehpA==
X-Received: by 2002:a1c:bc0a:: with SMTP id m10mr188984wmf.173.1591205192899; 
 Wed, 03 Jun 2020 10:26:32 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 37sm4485254wrk.61.2020.06.03.10.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2020 10:26:31 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1890E1FF7E;
 Wed,  3 Jun 2020 18:26:31 +0100 (BST)
References: <20200602154624.4460-1-alex.bennee@linaro.org>
 <20200602154624.4460-9-alex.bennee@linaro.org>
 <CAEyhzFvTF7Sh1ugq_O9CwADf3LmkWjdCHqmafQC0wkDMKQH1=A@mail.gmail.com>
 <87sgfc5q9d.fsf@linaro.org>
 <CAEyhzFvyzy3Y6v--PiOizTPYJQ1RnStHChNBYgpuP=7PGu=VnQ@mail.gmail.com>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v1 8/9] plugins: new hwprofile plugin
In-reply-to: <CAEyhzFvyzy3Y6v--PiOizTPYJQ1RnStHChNBYgpuP=7PGu=VnQ@mail.gmail.com>
Date: Wed, 03 Jun 2020 18:26:31 +0100
Message-ID: <87img85ad4.fsf@linaro.org>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, "Emilio G. Cota" <cota@braap.org>,
 kuhn.chenqun@huawei.com, Peter Puhov <peter.puhov@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> On Wed, 3 Jun 2020 at 07:43, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>>
>> Robert Foley <robert.foley@linaro.org> writes:
>>
> <snip>
>> >
>> > When testing out the options, I noticed that
>> > if we supply arguments of "read", and "write", then we will only get
>> > the last one set, "write", since rw gets overwritten.
>> > One option would be to error out if more than one of these read/write
>> > args is supplied.
>>
>> Yeah the option parsing is a little clunky although given the way you
>> pass them from the QEMU command line perhaps not too worth finessing.
>> The default is rw so you make a conscious decision to only care about one
>> or the other.
>>
>> All you can really do is fail to initialise the plugin. Hopefully the
>> output should be enough clue.
>>
>> >
>> > Reviewed-by: Robert Foley <robert.foley@linaro.org>
>> > Tested-by: Robert Foley <robert.foley@linaro.org>
>>
>> Thanks.
>>
>> Out of interest what did you measure? Are there any useful use cases you=
 can
>> think of?
>
> We did some testing where we booted an aarch64 VM and an i386 VM a few ti=
mes
> with differentcore counts (up to 64), and viewed the counters.  We
> also did a test where
> we inserted another device (a virtfs mount), booted up and checked
> that there was another
> device listed (for virtio-9p).
>
> There are a few useful use cases we are thinking of, in general for debug=
/perf
>  testing of PCI devices/drivers.
> For example, debug and performance test of a case where we use a queue pa=
ir,
> (maybe for something like DPDK/SPDK), this plugin would be interesting for
> checking that the quantity and locations of accesses are expected.

So one thing that has come up in the VIRT-366 discussion is the
potential efficiencies of the various kick models for MMIO based
hypervisors. Each interaction with a trapped region of memory triggers a
vmexit and one thing I wanted to understand for example was the
difference between "normal" IRQs and MSIs.

--=20
Alex Benn=C3=A9e

