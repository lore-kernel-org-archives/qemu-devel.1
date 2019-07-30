Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4DBC0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 07:42:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B465B206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 07:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcXfoXQo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B465B206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsMm0-0007Fj-0L
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 03:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43967)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hsMlY-0006lv-Hm
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 03:41:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hsMlX-0008BF-Mh
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 03:41:48 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35241)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1hsMlX-00087h-E5; Tue, 30 Jul 2019 03:41:47 -0400
Received: by mail-wm1-x342.google.com with SMTP id l2so55644622wmg.0;
 Tue, 30 Jul 2019 00:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=US0CBPgazd1Ke0PMKoO07sr+MbkK+EZDEhYOuEHgEIA=;
 b=XcXfoXQoiMw1rifJkOGZU2LqIpzAg/2DeoGGjWK2Su9kghbGH48VtijXkkYy3Z/Yly
 e35ujyq4PNJzvq62nSD4l6aLvc7w0J7paQV6q83NgAkVhrlCEN0RNnWZNjWTHjAL02qa
 frNTtiEd9WD2n0n9rBZPbfdrp33dksS9/MpnJEZedE7iE9/6BlhID5hAbsO3a4rAi6+Z
 p/MbOLrRRRWUsEVJUiDkJfv8U02gtTmhPULpaazD6vPmSmr0VjiHg0+1gqyH5LdZHRk5
 n27Cl24nfSFNStYXLJqkI/VQ9h3Mz/rclRFyZncz9Z1TwjhtQCpixsftWiKNdtbDWYqB
 x+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=US0CBPgazd1Ke0PMKoO07sr+MbkK+EZDEhYOuEHgEIA=;
 b=o9CX/SDnz+AqlY1QdNZShzMa2tnY1bOUPx0sKLk81AswN3PvJcHEXfzBQ7Vv6aVSBK
 tnhEurJJ/nvxgZ9913UeQb6pJE1hSp+zOL7/vh1RGsZaEnNjiIFiX8LPGMyGUAcgSkHt
 yIE7lBsihykSnH6vctZdPYB+qhzjDLhw6LJkvYEsPP50EfyfYB31k6g0heHHHT0ZO0H/
 ANvHTT7ZHHm0zvR+1C5yskHfQke4kMvI0+saBmTvI6yuRFK+UeQ5mMlVsnR5DDQqxbX+
 dl9+wEHCthvWHMwf4P7fj65s3jWL5E9AlX81gZv4jxagSpptMFV25XibajMd0rew3iwc
 eTTg==
X-Gm-Message-State: APjAAAXYrQOocId1eWqgzdUA4p+PCx73zipg0LSRxmFo7loYbcGqBsSh
 WloM6HFaSKOtXpR+XIjYYz0=
X-Google-Smtp-Source: APXvYqysBP/CTjIwmvI+SYliZWH/ARAIMhaelzytQ1TBqTQYfiB8gVHplMzse93woSE3eC0w2+scyw==
X-Received: by 2002:a1c:7015:: with SMTP id l21mr100081458wmc.82.1564472506325; 
 Tue, 30 Jul 2019 00:41:46 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id f7sm62649872wrv.38.2019.07.30.00.41.45
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 30 Jul 2019 00:41:45 -0700 (PDT)
Date: Tue, 30 Jul 2019 08:41:44 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <20190730074144.GF30213@stefanha-x1.localdomain>
References: <20190729151651.21306-1-mehta.aaru20@gmail.com>
 <20190729151651.21306-15-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="p8PhoBjPxaQXD0vg"
Content-Disposition: inline
In-Reply-To: <20190729151651.21306-15-mehta.aaru20@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v7 14/15] tests/qemu-iotests:
 enable testing with aio options
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
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--p8PhoBjPxaQXD0vg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 29, 2019 at 08:46:50PM +0530, Aarushi Mehta wrote:
> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> ---
>  tests/qemu-iotests/check      | 15 ++++++++++++++-
>  tests/qemu-iotests/common.rc  | 14 ++++++++++++++
>  tests/qemu-iotests/iotests.py |  9 ++++++++-
>  3 files changed, 36 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--p8PhoBjPxaQXD0vg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0/9LgACgkQnKSrs4Gr
c8gvKAgAumbA2HclhklYcKxyxlHBxShfCzbbKIjfZRupBwLOFmxK3zDL29QB8KhR
RGp8AKLvw8iedp3BDS+UkmTHdditG5EeQXjtYdmcv3h569ku2qbLeHXYARNk6smY
P4gPiHkkitI5V5C+MP9B0UKl27ao2garmuUqriTYy5t7T6zxEOsLNO9bT4e1ybpF
InAVOSuge5jJzm28i8YxXxqsFDQk5U9zrjTztvxlTHTfBLlct74fo0K5sz9mdxDf
YfDrX2QTAu+OWv8/lP1G26zqZ+sV4OwvZRV2adzVc8f9p4S13bNc1JIwE3wJg4r/
PzM3Mx4N1/R7TflltofqA2exNjUC6A==
=3QWJ
-----END PGP SIGNATURE-----

--p8PhoBjPxaQXD0vg--

