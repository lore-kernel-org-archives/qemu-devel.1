Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C07AC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 14:11:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4D9020645
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 14:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7SaIOXY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4D9020645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54431 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIw9F-0003tu-8s
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 10:11:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hIw2k-00074I-F7
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:05:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hIvqM-0005Rr-Tb
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:52:19 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:54938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hIvqM-0005QB-J3
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:52:18 -0400
Received: by mail-wm1-x336.google.com with SMTP id c1so156044wml.4
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 06:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=SXOksfNiI9BWxeWInCn0H30hmueA9KpVG9XiDX5ExXQ=;
	b=I7SaIOXYfTZcmLcgbYR7Wa/y5EmorlgRTHY6vrZ63tak9/aL37ljkpYspmtnyA6FzG
	uXU0ixxhMXoUH8vaVViGJl856N3mMedYjBgVi9jhaW2ZH9EVkzaJz9iPMQcjFmkOEhS3
	G3Z3H82weKrFJ+RZ5oBuqJkQRqD7cEIlOU6AsHqEiVaPzxP2tHjda5hOAZCBoWngcRSj
	JQKeA4k2+iA1+Seqr73RDiINbyQ4edSn4mde8E5at+ifglAcZX+ePz2XuhmRI3IKBAp5
	eBWf4OxIKRQFEFSi0LhYoM05V42s6GBtzbisx7GqyRdmTxFJ0MeWwHvL5Jr4mdlARrcX
	yIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=SXOksfNiI9BWxeWInCn0H30hmueA9KpVG9XiDX5ExXQ=;
	b=JWm3OyGsS6ZP3Go0E3iNdkt+biluk7uyHHDgeUwrmFZO0MDjYuroR0V7Z2MiFLAPJG
	Fe3T1dmUhj+oYuyZEvllFrobP0AmwImEUu23ArXWZ1Ej0FEcIbpKb+5cv9FOqaZp+hrw
	eDh0aR5zW8hy9aIi3PCIRKMJaixf+IQwPzoDeUaKQjo5NeaAuLfHOmkiJ3de9JE2ztjT
	hCsItdeDuUJ8wFmulE76frFtG0tN+U5kImsm3arM4i/NAC0qF2w5L7B3WzWr+5fIAlrI
	sdWL7uCMh1AnXpBuJ1/yqWfTP1gw9Z8jkW6j+5oGBi0y2pE9DqRRSq4NPoofwp8LpXCV
	YZ8g==
X-Gm-Message-State: APjAAAU3BboLLGgspjm257N+q6d6gMRPh/PfZCHPhM7YKheQSJSlaUlz
	LavlAEk/PNLWrxuMM76ceUU=
X-Google-Smtp-Source: APXvYqzJvU6yDu3Hte/nK9Ynd4vlVe6AHq8UYxR3OhJ7d5K5m+PytegJdHgq8gjPD2+rWoih0JJGGw==
X-Received: by 2002:a1c:7e55:: with SMTP id z82mr2456993wmc.11.1556027536760; 
	Tue, 23 Apr 2019 06:52:16 -0700 (PDT)
Received: from localhost ([51.15.41.238]) by smtp.gmail.com with ESMTPSA id
	e1sm16305969wrw.66.2019.04.23.06.52.15
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 23 Apr 2019 06:52:15 -0700 (PDT)
Date: Tue, 23 Apr 2019 14:52:15 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: amit kumar rathore <amitkumarrathore07@gmail.com>
Message-ID: <20190423135215.GK32465@stefanha-x1.localdomain>
References: <5cbe25f0.1c69fb81.e0425.9c3b@mx.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IA03tywDYuoVKXrw"
Content-Disposition: inline
In-Reply-To: <5cbe25f0.1c69fb81.e0425.9c3b@mx.google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::336
Subject: Re: [Qemu-devel] Review my proposal
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423135215.UCWuQ6m8610-W183PjyNtDcTwfHZrTIuV5xfvyQXDL4@z>


--IA03tywDYuoVKXrw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 23, 2019 at 02:07:03AM +0530, amit kumar rathore wrote:
> Sir,
> My proposal is still not review by my mentor. My mentor is JAN KISZKA .I already mail him but he not responding me. What I do now? How can I know my proposal is view or not.

Hi Amit,
I am the organization administrator for QEMU.  I can confirm that your
Google Summer of Code application was submitted.

Google will announce results on May 6th.

Stefan

--IA03tywDYuoVKXrw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcvxiOAAoJEJykq7OBq3PIHVgH/0cJty+dcKuzvClYzTVuIJE3
HIrV6lY061jQ23Rw9LC8M1LsZZWf4vDCPrnS6IgOKRkrV31MDlZyT/8q4KHnW6q2
f6URVW20n7AdeEuaNrHuYz4hRBhD37Im4BoT42/VMQ8EfCqJI4zgqHaZc4aFdtPO
4mEXi2pO6Yq5x4NYVHYDp1HmHHGjDASE+Bq20hnL2vdcjaTv24DCPi4qtu+Bbckj
dCu4YPuhzuKoZeh2K2OgRiuWnMApu/uKM8ZrIg201K/xSCOSccilsllb4uLUKzO9
+BeJWx5i4DAG01+okQSeSxJzLhWxfhEdhP6z6Uk94YYmOedJhB/ACetL7gcLIlA=
=CXcv
-----END PGP SIGNATURE-----

--IA03tywDYuoVKXrw--

