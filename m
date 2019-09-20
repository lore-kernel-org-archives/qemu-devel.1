Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A886DC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 09:31:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 720BE2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 09:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfenEHgr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720BE2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBFGI-00082K-3C
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 05:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iBFA8-0008Lo-O9
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 05:25:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iBFA7-0006lY-6Z
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 05:25:12 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:44576)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iBFA6-0006kk-Sf
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 05:25:11 -0400
Received: by mail-wr1-x431.google.com with SMTP id i18so5960129wru.11
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 02:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=oBFEI71HD7mdwqT7Kc4qkUVg/evrwV9SmGS8veW5fF8=;
 b=lfenEHgrFtVMKc3VM5N0InySG+SidbUz7wJEbEaXtR8XCJIqzEWYvNaIxd20ryagx4
 gog3Dx6yyH1HdvRvuspqlnOM8aoFtSuRG2zaT1g8rpfcoGiC3oEvj34OZJGK28jzFNzI
 jyBtG/ApfXV8VsNbjyr3lD3QdWZhcrqqjkvzQLag4sDLWZJXW9PafamCaFl1c+kKSxlT
 EkfJXU9akLs0V0+/rxgybwz8QisUb7stZU5R+fREgTjAAxX3xzooLlD1ToG6GoYV6R2j
 KVzwEgsr6NWFS/y36siTpL2mtgTBI1Oq9wTX9ZTwtIaChqO9uH/Pm5/aMtD3M6G3PHnk
 p99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=oBFEI71HD7mdwqT7Kc4qkUVg/evrwV9SmGS8veW5fF8=;
 b=I5TdF6+1Hmq4p5pNVmAkbbk+fzUo9emV0D3zHJvRrmp8ZryTY1BnckxHj87+Ck7Pko
 RxMGAY/jO1QfNUt4vrY6DQAnou8bmvASZWY20AVRyqVr4GtVF11gDiW+wA7m89mbLS62
 z6ZMLenVkaZj1zJ5CFXP1UHktWrjMI+EvfZirZWHD7FjgZt3MI3DURISC2jGtpq3vwdN
 2/1uUX7bEZjjK9z0LVOt6KExhHXv52n3CoEA4e6QHK99WWZz+o2HM8J4boIjC5iRl4MF
 tSDaJxJeN+6/NlC/yyhvSQ2nS5oXzQzJBbl41x3CmKKmE+Rih0pawHq1/qqvUX8pUkwj
 zy6g==
X-Gm-Message-State: APjAAAUjv60cJBrAyhQqAU7Z8muzcKEI4dfk10HYrb20zVlFBf3cfudh
 fPVa+7DVXUUnPBYG57+Pww0=
X-Google-Smtp-Source: APXvYqxxIYRyrFfQIUe7ikd9ws9XY7gnpdGspntQeIKgBpmJPlrq6PwIy5IuNch0+OWYy5EbfLEnaw==
X-Received: by 2002:adf:f1c3:: with SMTP id z3mr11776495wro.147.1568971509148; 
 Fri, 20 Sep 2019 02:25:09 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id 13sm1117380wmj.29.2019.09.20.02.25.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2019 02:25:08 -0700 (PDT)
Date: Fri, 20 Sep 2019 10:25:06 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Tony Asleson <tasleson@redhat.com>
Subject: Re: [RFC 0/4] POC: Generating realistic block errors
Message-ID: <20190920092506.GI14365@stefanha-x1.localdomain>
References: <20190919194847.18518-1-tasleson@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tctmm6wHVGT/P6vA"
Content-Disposition: inline
In-Reply-To: <20190919194847.18518-1-tasleson@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--tctmm6wHVGT/P6vA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 19, 2019 at 02:48:43PM -0500, Tony Asleson wrote:
> I've recently been informed that blkdebug exists.

By the way, if error injection only needs to report media errors, then
the existing blkdebug feature should be sufficient to do this.

I think adding storage controller-specific error injection is only
really necessary for injection SCSI-, AHCI-, or NVMe-specific errors
that the QEMU block layer has no concept of.

So the question is: can blkdebug already do what you need? :)

Stefan

--tctmm6wHVGT/P6vA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2EmvIACgkQnKSrs4Gr
c8iTFQf/YAgMcILC5ofSBGLZF3iet03soIQr38gNkjD94C8wQyijgQkScxQoNR4J
MzqwsigJJhFqU9LiKXW0ZrAtyREY9wUzI84GEZ6oXVFWmDEKz2cE9sq3HvyhLEOg
lsZnCy6J4qDGjQSGX3gV6Z9OOvXk75mvb5yzTGsH04su0GMZDNIyB400zmVCfTKq
J++t54qybx5FzmU3Gu/3jExw2uZAXIN5kvwbILsPnafSlksi08zxwaWjilHeaCmf
KPDLenbOs3H2bVf71rlglWdHMb0ZPcfeb4Kqk6lRT0u2C6/o7x44V98sOPKL2OoP
DKaYKcoie/JikbWuVvo4Y6wr17+4Ww==
=TVze
-----END PGP SIGNATURE-----

--tctmm6wHVGT/P6vA--

