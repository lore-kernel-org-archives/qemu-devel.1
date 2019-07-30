Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCFCC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 07:29:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B6492087F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 07:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzkWik18"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B6492087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsMZE-0000eZ-UQ
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 03:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41375)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hsMYj-00008J-AD
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 03:28:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hsMYi-00007J-D3
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 03:28:33 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46803)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1hsMYi-00006d-6K; Tue, 30 Jul 2019 03:28:32 -0400
Received: by mail-wr1-x442.google.com with SMTP id z1so64514365wru.13;
 Tue, 30 Jul 2019 00:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=NvIg+MX9q61LlGzGbqS0cQT+tlDsG4zK8NCUpCjOJGE=;
 b=hzkWik18UlUpHS4Jw2O8aJBlhrGp9+O9c4Gx/KiVMMHE2zSDTO67pQSSK6xGVwrdua
 7MNuH3OFAazYvewvJXq0L06ole9k1MLG6lprc0u/B0Xe+IzYVOU8zSg++veYMP0cnoDT
 7cZfU/AhMpMfcXbqGXw8REd/dTkBvxIU56arYhimRC5TyeM28toMCz/KC/UFpq3Y/Y2W
 +cyFqdD2iClQ3qVjAeD92ZTIaqDGT0koZ8pGGjERWKCWgmwr0vN2sldPOEPhB+qmzTTU
 eJTVLCOkFG0dlrQ17+LA0w+MxxZ6+1dVFiqHHH8J17MkM3ppOHjPVF9JUlMJvQplH3t/
 Azew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=NvIg+MX9q61LlGzGbqS0cQT+tlDsG4zK8NCUpCjOJGE=;
 b=hIvd5exjgV4YMfCbH/wjUmxxMj7Jw0T3y8a6gEx/AzPAqcwMJAQMx/M6hwUm9H+uFS
 orub8YSZSMocT6WSdCTKzRjrPp4aHzV9FD9P3xEn8X9vIGFa8I4ked5F1oYSIVnEjMf/
 hrbfdZ33jFIPOLK6VjZQP+ZLeGZFABBxEKYUW1mRfRgdesVYNC2vf39XG/7VcrbSxfXX
 bz9UWgNIJQpsNOO+MLkSlZZ5BEFelMg/1VG40b1/U0ShEoKEipgxF8Fzz5JZPIu/O9uF
 HZIuSOYZ+6YshWexanZXQ88VLApSMuS7tt3DOBlCU6od3rdk4TofYQxV5/vKAi46NCm1
 FJrQ==
X-Gm-Message-State: APjAAAXcd8iY5diDaIpAD7kws4zmN2t2hAUQTicLJX8O4H6C/kfa1uK4
 dH8YKEif3c7J8me7oQVbxPc=
X-Google-Smtp-Source: APXvYqwe++cny9cSiOGXn6aPO/jaq7RHv5CVP350KdVptC/2jTsOk50baSZf7rwqU3GYR4vKKsioEQ==
X-Received: by 2002:adf:df10:: with SMTP id
 y16mr102877349wrl.302.1564471710766; 
 Tue, 30 Jul 2019 00:28:30 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id n1sm47876625wrx.39.2019.07.30.00.28.29
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 30 Jul 2019 00:28:30 -0700 (PDT)
Date: Tue, 30 Jul 2019 08:28:29 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <20190730072829.GB30213@stefanha-x1.localdomain>
References: <20190729151651.21306-1-mehta.aaru20@gmail.com>
 <20190729151651.21306-5-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline
In-Reply-To: <20190729151651.21306-5-mehta.aaru20@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v7 04/15] block/io_uring: implements
 interfaces for io_uring
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefan@redhat.com>, qemu-block@nongnu.org,
 Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, saket.sinha89@gmail.com,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 29, 2019 at 08:46:40PM +0530, Aarushi Mehta wrote:
> +/**
> + * luring_process_completions:
> + * @s: AIO state
> + *
> + * Fetches completed I/O requests, consumes cqes and invokes their callbacks
> + * The function is somewhat tricky because it supports nested event loops, for
> + * example when a request callback invokes aio_poll().  In order to do this,
> + * indices are kept in LuringState.  Function schedules BH completion so it

The sentence about indices is outdated and can be removed.

Otherwise:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0/8ZwACgkQnKSrs4Gr
c8j0Wwf9FjlQQUZyng9XtntTgYTuU5rNy9aG9Q2KDBUdwWyPAlByQ4dDPz0dzXeD
e2TWCiohDdou1kq41Nu+DctSl2ikrL/+9TLq9xqpKLN1lj8W+JbGSE4S6GFtBOpi
mLOLpUf2l78w62SmGQRkr45W5RcqXoMUucyh+84qzliHF6Ytxy2IAH2ieYXOVt0n
38dcREyB7B6EhWo+OYe4/f1/0dn50oPEzRLSlHLRd+xHCvOlWo/wP9p40ZcGkJbg
zmV6Cfa4kccSVhW5j0VCADhOmVqogn7LuEhMSETfFMt/ezYRLc5fq/678KvqQiLC
6aWO4Ik4n9W01NpGNoqkKUFQ84xZAQ==
=T2ox
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--

