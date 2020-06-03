Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD12C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 15:43:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54F0A20679
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 15:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j01rI7Vh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F0A20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgVXm-0001JF-Hs
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 11:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jgVXC-0000rg-2M
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 11:42:30 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:40064)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jgVXA-0004bC-Uk
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 11:42:29 -0400
Received: by mail-lj1-x244.google.com with SMTP id n23so3329191ljh.7
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 08:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=DkT3AaXUuc1u07VC2gaxuZ34kHgEMtozq6SRb0M5yCM=;
 b=j01rI7VhsPXD5cub0WHfKRU0DzBSBQXcCZetqcWRSu7ybS2EYcDyKWt2WRfOpd+7Ft
 fZ3/MhBG8mMr63ImQOoiok/pygEeRICgRaowUpCTtbRGg9rl0laD+HpfJlYz7BYd6ZKY
 1AhrbPDnZkh8N46+DcMKGkle32+z/cR+OgPDNLZ8YPLFWNh5JBXhWcd40RfjMZRJr5DH
 UDWPB2unazCY2uKCov36HLUQ5J3Hco7kX/LHowLWIcTkITrCrhODxypTVRBboG6i3Ep+
 gcbNS9Y13fDMD8JXVu7BstdzTeX+jg8fAQlMND3mUJNCAjDZTXlWXT8TqxkXSJQXm3P0
 nbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=DkT3AaXUuc1u07VC2gaxuZ34kHgEMtozq6SRb0M5yCM=;
 b=Vm4cA0wMHD3hYSRq6lDCuj2T+dUdk1baOWLX1bOTrs/MVhuzHPhf6TSZeLmkkjVlrV
 wJLAKk/OwtHDKq4+6XvNO5sSX5dXw201Ad09fodD5pyCCMYWrRmHDWAbnxo0tWnHR1ca
 2uBLZBgQ6ntxi4RyyT11+wI1tzsvGXtnVtFL5MPQ50YZU8qUjOz1NV8KcJUJWWd2iqrn
 0TsjE/Kf8YYqaQotb0vR575aGgGZ76WtN/XnmpYPQ2/0reemPZTfUatsbX2qT15n6SVC
 h38R9vqGtVsKsBxCfp434yatL5wLDYz6yaafqaCCZDbD/7ADn0Neu4UDd+oIAqXdjygi
 a91g==
X-Gm-Message-State: AOAM530aEn9dPBAGfMrwbLWVOGdfSoVf5WKT7rOQ+Nk3el1/T+WrfqBl
 HlG/FNgjK9Vt4ixrZaBLniG19qaNoVqG57AcUAeErA==
X-Google-Smtp-Source: ABdhPJyUzkOe3TlsOce0kThUOERqRha/IR15ZbtVPRXlzwymXGOuFOPbRROtppY9sqcNet0yIwElNxkRPmjVjvz2Pg0=
X-Received: by 2002:a05:651c:1103:: with SMTP id
 d3mr2513046ljo.110.1591198947198; 
 Wed, 03 Jun 2020 08:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200602154624.4460-1-alex.bennee@linaro.org>
 <20200602154624.4460-9-alex.bennee@linaro.org>
 <CAEyhzFvTF7Sh1ugq_O9CwADf3LmkWjdCHqmafQC0wkDMKQH1=A@mail.gmail.com>
 <87sgfc5q9d.fsf@linaro.org>
In-Reply-To: <87sgfc5q9d.fsf@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Wed, 3 Jun 2020 11:42:26 -0400
Message-ID: <CAEyhzFvyzy3Y6v--PiOizTPYJQ1RnStHChNBYgpuP=7PGu=VnQ@mail.gmail.com>
Subject: Re: [PATCH v1 8/9] plugins: new hwprofile plugin
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=robert.foley@linaro.org; helo=mail-lj1-x244.google.com
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

On Wed, 3 Jun 2020 at 07:43, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
>
> Robert Foley <robert.foley@linaro.org> writes:
>
<snip>
> >
> > When testing out the options, I noticed that
> > if we supply arguments of "read", and "write", then we will only get
> > the last one set, "write", since rw gets overwritten.
> > One option would be to error out if more than one of these read/write
> > args is supplied.
>
> Yeah the option parsing is a little clunky although given the way you
> pass them from the QEMU command line perhaps not too worth finessing.
> The default is rw so you make a conscious decision to only care about one
> or the other.
>
> All you can really do is fail to initialise the plugin. Hopefully the
> output should be enough clue.
>
> >
> > Reviewed-by: Robert Foley <robert.foley@linaro.org>
> > Tested-by: Robert Foley <robert.foley@linaro.org>
>
> Thanks.
>
> Out of interest what did you measure? Are there any useful use cases you =
can
> think of?

We did some testing where we booted an aarch64 VM and an i386 VM a few time=
s
with differentcore counts (up to 64), and viewed the counters.  We
also did a test where
we inserted another device (a virtfs mount), booted up and checked
that there was another
device listed (for virtio-9p).

There are a few useful use cases we are thinking of, in general for debug/p=
erf
 testing of PCI devices/drivers.
For example, debug and performance test of a case where we use a queue pair=
,
(maybe for something like DPDK/SPDK), this plugin would be interesting for
checking that the quantity and locations of accesses are expected.

Thanks & Regards,
-Rob
>
> >
> >> +            detail =3D true;
> >> +        } else {
> >> +            fprintf(stderr, "option parsing failed: %s\n", opt);
> >> +            return -1;
> >> +        }
> >> +    }
> >> +
> >> +    plugin_init();
> >> +
> >> +    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
> >> +    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
> >> +    return 0;
> >> +}
> >> diff --git a/tests/plugin/Makefile b/tests/plugin/Makefile
> >> index b3250e2504c..d87b8d40699 100644
> >> --- a/tests/plugin/Makefile
> >> +++ b/tests/plugin/Makefile
> >> @@ -14,6 +14,7 @@ NAMES +=3D hotblocks
> >>  NAMES +=3D howvec
> >>  NAMES +=3D hotpages
> >>  NAMES +=3D lockstep
> >> +NAMES +=3D hwprofile
> >>
> >>  SONAMES :=3D $(addsuffix .so,$(addprefix lib,$(NAMES)))
> >>
> >> --
> >> 2.20.1
> >>
>
>
> --
> Alex Benn=C3=A9e

