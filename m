Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F936C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:13:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE6DF20706
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l351va/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE6DF20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jluLu-0004Se-73
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 09:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jluLL-000422-CZ
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:12:35 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:32781)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jluLJ-0003Xk-BF
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:12:34 -0400
Received: by mail-wr1-x441.google.com with SMTP id l11so6031035wru.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 06:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Rx+Zz89+U5dQcNnr8WKQFtigGuHfef4A4dQcJoI2M+4=;
 b=l351va/G106tfOeYuMHIm4vdR87Bmy9bzJbohc9vYnYQjHi0tjwG4hoE3bUojj6ruq
 QZEvvwKkPQS1IQgHu5CxN6Ph0kelvR+0iUpnx67NEFcN/Lg/x51rQZ5p01z/8jgyGzCu
 aJL2foXimiRhqkNatIEHBzVK2tzzi98RvaQx5QQQkQMo5Tz6LQmkYkbJWGo8ZUvs3Jiy
 FaJTyhnZph/SHPRQWEzO1Ki+qwB99r80bJG/xc3IM15U6bp5dq/fAC6uE6bBT5JRzaTs
 HWMx13EH2y7VYBgaAqEjDCdpdMwLPm2dupDSog2KQVKgWzfQ5U9nPHjLmDCBykROuGbq
 DDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Rx+Zz89+U5dQcNnr8WKQFtigGuHfef4A4dQcJoI2M+4=;
 b=Nfl7idpzBpNET7GjBeEN5KGneDji/WfefHoQGRUX8tFkLu62RmhjRGQRxrrUWotiO8
 8MT+Wb5AcAaU5kpRAXILc0V11YsPnb66+3kQ/BDcSkOfufDSp6kkK44pmF0dYBPCLkW2
 6+xHwce1EusKNtRMq4Y75bdZBGvgurJ+847N3qVufWwUueTu9dCzpWl6uVyNEWAIhy0i
 hx9Q2ikXcMjSeh+D0FVw7oFWZchuvyXvcwp6KQX8oXAkrsbgizTg5Bfh9x7ipyEgsIx0
 /9rouUcI39EV75VTvI2xIpU148p2UgEuvWhyfG4Dsy6egQP9G1IhwyY6BTIRbQCgqAvZ
 PbOg==
X-Gm-Message-State: AOAM532JxuJeiSgxzVYICHfFNm87LA/V0R7eNSu2YcTXs6e1gWMQEAuv
 4BsJ5XWSE0/j1UIHJ/2HEQEv4A==
X-Google-Smtp-Source: ABdhPJyXzDVMLPpAmpjRGblJorL48sgw5Un1vKTZttmKLBxdl7tlOprgb/EGv04jppcbGZn1oCN0hQ==
X-Received: by 2002:adf:9c12:: with SMTP id f18mr4937877wrc.105.1592485951894; 
 Thu, 18 Jun 2020 06:12:31 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x18sm3468139wmi.35.2020.06.18.06.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 06:12:30 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B244B1FF7E;
 Thu, 18 Jun 2020 14:12:29 +0100 (BST)
References: <20200618121218.215808-1-ppandit@redhat.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH v1] memory: assert MemoryRegionOps callbacks are defined
In-reply-to: <20200618121218.215808-1-ppandit@redhat.com>
Date: Thu, 18 Jun 2020 14:12:29 +0100
Message-ID: <87r1ucv7pe.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>, Li Qiang <liq3ea@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Lei Sun <slei.casper@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


P J P <ppandit@redhat.com> writes:

> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> When registering a MemoryRegionOps object, assert that its
> read/write callback methods are defined. This avoids potential
> guest crash via a NULL pointer dereference.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  memory.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> Update v1: add assert while registering MemoryRegionOps
>   -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg05187.html
>
> diff --git a/memory.c b/memory.c
> index 91ceaf9fcf..6e94fd5958 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1495,6 +1495,9 @@ void memory_region_init_io(MemoryRegion *mr,
>                             const char *name,
>                             uint64_t size)
>  {
> +    assert(ops);
> +    assert(ops->read);
> +    assert(ops->write);

If you look at memory_region_dispatch_write you can see that
mr->ops->write being empty is acceptable because it implies
mr->ops->write_with_attrs is set instead. I think the same is true for
read so I think you need something more like:

     assert(ops->read || ops->read_with_attrs);
     assert(ops->write || ops->write_with_attrs);
=20=20=20=20=20

>      memory_region_init(mr, owner, name, size);
>      mr->ops =3D ops ? ops : &unassigned_mem_ops;
>      mr->opaque =3D opaque;
> @@ -1674,6 +1677,8 @@ void memory_region_init_rom_device_nomigrate(Memory=
Region *mr,
>  {
>      Error *err =3D NULL;
>      assert(ops);
> +    assert(ops->read);
> +    assert(ops->write);

Do ROM devices need a ->write function?

Also doesn't this break a load of running stuff without fixes for all
the various missing bits? How far does make check-acceptance get?

>      memory_region_init(mr, owner, name, size);
>      mr->ops =3D ops;
>      mr->opaque =3D opaque;


--=20
Alex Benn=C3=A9e

