Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDECC04AA7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 03:20:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04D4B20818
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 03:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B12kg9zi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D4B20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38341 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQNzS-0003mg-Q1
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 23:20:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hQNyX-0003Th-Oj
	for qemu-devel@nongnu.org; Mon, 13 May 2019 23:19:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hQK7p-0001Fh-Tj
	for qemu-devel@nongnu.org; Mon, 13 May 2019 19:13:17 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:36980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hQK7j-0000we-LU
	for qemu-devel@nongnu.org; Mon, 13 May 2019 19:12:49 -0400
Received: by mail-lf1-x144.google.com with SMTP id h126so10321379lfh.4
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 16:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=4eFUZYyr8KNeadgMclSKpUtShszfc8t2iXqXurCvJ9M=;
	b=B12kg9ziYNc0NrUvp4J3AmT7j5EpFzjd/0wN2HFiGDzgeC/o6+5+lkMuSe+WjoeZaw
	ss9S+DZ65t5RQSIJVsVvmJEKrDOeAA918mBDKykj8ASOkl9F7QADatRgk8eo98IQc6Sj
	pXgumCXeAUS1LkIvkPMNTfsDMjVxpryPR/5ErfhtZZ+Ot5bsu8loTMOZ/OoRq/OGa6qf
	M/0BYEDwV2rNHDCWM3LNXSNgK7zMweBH+VyQ0ZatPzcf+XCk0h4OGUySgsAsHVspPDdn
	4LuMWTfnAugDqMCNzmMGlrDIUx7u99PZFcdaPiw4tn7d7zoJkeIZuUhKpJujUjIE8nST
	BgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=4eFUZYyr8KNeadgMclSKpUtShszfc8t2iXqXurCvJ9M=;
	b=A401GTGS4Q+mGP15CQL8UYIuj/4xLdSKa6SZGGTu2laUVne9sj8p6rvhvt0WRkEu1f
	oIfOs+5CKg9skQP98o1odN93VY3dxKuLRUD9zwlZLonwJQGxKC5O65HxD7Gj5Qvh5Ham
	Nn1hF7x5M2Qnto/6QgMrSZEkAFCavgVQbhgeaLRu+N0ucNlnvy/hcJDH+15mnjtgT+oJ
	TDdB3ZYimwXVWo45bNJuilZrioFDGAz9sNaj0+etb9gegtWK34eIlgJ698BOq2bbc3ou
	v7iw9eTHtpbr1tRYWHAuH3nZc9lHvu1IQDV/SQ1OHNfn30POmlCi1e6h/yfx+F4M99Vf
	IWzA==
X-Gm-Message-State: APjAAAVqxf1geLKdFimiwB0ByYepg7YY2RjMHhLC6BZOwYNkHW1Qtvoi
	0QYMj8eT7rd2fGCMwh+4/usW+IRbkUZ9KKHZSwk=
X-Google-Smtp-Source: APXvYqwK/Qgzo8ERbwy6oJtzWSuC6mL8AkQ/nV3rw6CHFrpMCJXNsCg1dBrS87+Y3NoddwKsmVF0WiXMPegI+AitclI=
X-Received: by 2002:a05:6512:309:: with SMTP id
	t9mr14627369lfp.103.1557789154860; 
	Mon, 13 May 2019 16:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190508000641.19090-1-richard.henderson@linaro.org>
	<20190508000641.19090-39-richard.henderson@linaro.org>
	<CAKmqyKN5BmdUwv92UzCVZzNQsykeFSq_TwTvb7h5Ld9UWBuyyw@mail.gmail.com>
	<9e60945f-5d27-c90b-79af-8e57a9dce78b@linaro.org>
In-Reply-To: <9e60945f-5d27-c90b-79af-8e57a9dce78b@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 May 2019 16:10:22 -0700
Message-ID: <CAKmqyKMyUHucSTTN+MJ9YBpKQqFvPgL38vLXrdoQ732qmwFQ+g@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::144
Subject: Re: [Qemu-devel] [PATCH v3 38/39] tcg/arm: Use LDRD to load tlb
 mask+table
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, May 11, 2019 at 12:13 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/10/19 2:08 PM, Alistair Francis wrote:
> >> +        if (use_armv6_instructions && TARGET_LONG_BITS == 64) {
> >> +            tcg_out_ldrd_8(s, COND_AL, TCG_REG_R2, TCG_REG_R1, cmp_off);
> ...
> >
> > This is complex and I'm probably misunderstanding something but isn't
> > it possible for TCG_REG_R3 to not be set if use_armv6_instructions is
> > true and TARGET_LONG_BITS is 64?
>
> No, the LDRD instruction loads data into both R2 and R2+1 = R3.

Ah ok. This looks fine to me then but I don't think I fully grasp it
enough to Ack it.

Alistair

>
>
> r~

