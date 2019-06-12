Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357F1C31E44
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 01:59:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEBA32080A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 01:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="bntcZQl0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEBA32080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56222 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hasXw-0005Kk-R1
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 21:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54098)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <joel.stan@gmail.com>) id 1hasOP-0004YM-Ms
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 21:49:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1hasBK-00013v-I0
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 21:36:11 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:38515)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1hasB5-0000xU-U5; Tue, 11 Jun 2019 21:35:53 -0400
Received: by mail-qk1-x742.google.com with SMTP id a27so8975341qkk.5;
 Tue, 11 Jun 2019 18:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Z46ahEf2KFh0E7NdPCsUTsYjCGCnwUzyNJYVUBUbfh8=;
 b=bntcZQl0QVCamEO1fqUyM7dBp3gDOa0fiFbxabqthMzonHYGGbsnzaOIeH9wPRRvJK
 QhWDHQHwFmt4mJZgzuWK0pHYO9ME/tCGSoFAB3S/0QWeXFMUd//xKdXB67626Ffpga5M
 fcsmGcERyLdGI0uL134qEO+aKYIxT/qKV5KL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Z46ahEf2KFh0E7NdPCsUTsYjCGCnwUzyNJYVUBUbfh8=;
 b=nUiFxL2nzhZWKEZGjns6msdut/wiyUZdrHuFJ/7SZFutBTWpO76lfZJewj3pOKVKs/
 q5LGz6M/VF8m9aPrOJ1XDTRKNcCU+VyO1IGAZmqTDC/YhciCjWD1WgderkE8S2TeauJA
 8w/lSw0n9upFgUQs3x7XiFqbMirT9CV9gNw1cN2vmC/9xH88/sEJkWGQOGD5LssaCPC3
 bvlxZW745VzQ+jZC/rMkcdojPIHquVs5kA/mWdyc//aje4sD2W+mkjIXWZDL5+B9xxeS
 xkuicrVqkcKsnTaVUlfr7N4Xvlx85YlAbiGZl6IQOTUi58RAR3vtF93QqRzIE59GvDtE
 0YzQ==
X-Gm-Message-State: APjAAAVpSinbamOrT2hW342vqIN2D3BkiQfR8xdnZoQFFERGa8dFmm52
 RHZsKh7OYX0fcTiHiFImMIuSC9TV09EXYUQpjU8=
X-Google-Smtp-Source: APXvYqwOoVmcz+SstaowdAhO4AL1rQxbXTKweAzYYfQ+eqfMaS+AzA51KQITJCcjhs/JnPjnAMI8Lb57ey50P1TqeKs=
X-Received: by 2002:a37:4793:: with SMTP id
 u141mr37706987qka.355.1560303329828; 
 Tue, 11 Jun 2019 18:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190525151241.5017-1-clg@kaod.org>
 <20190525151241.5017-15-clg@kaod.org>
In-Reply-To: <20190525151241.5017-15-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 12 Jun 2019 01:35:18 +0000
Message-ID: <CACPK8Xf5Uo6U_95fSQqKANcA3ffjF5Ui-r+tj5T2mgwLdpsArg@mail.gmail.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
Subject: Re: [Qemu-devel] [PATCH 14/19] aspeed: remove the "ram" link
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 25 May 2019 at 15:14, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> It has never been used as far as I can tell from the git history.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

