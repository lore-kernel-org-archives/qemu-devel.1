Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7C0C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:12:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9A95218AC
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnVfFGgr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A95218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIHO1-0004xG-K6
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 15:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60351)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iICqN-0000yU-1J
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 10:21:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iICqM-0007HZ-4F
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 10:21:34 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:36977)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iICqL-0007HL-SD
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 10:21:34 -0400
Received: by mail-wm1-x335.google.com with SMTP id f22so2837970wmc.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 07:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ef4PFRZayWm/Zd1hegH93GTG+HjymGK9OAN+/CCzA/M=;
 b=FnVfFGgrjE1gQczGWpsyx/Gj7ifSHDROH6NCaAp7r50nFW2bLK2b5LYZsOkDMyee6t
 2USny7StCJuanVJTriToJo8RXeNk7zYKGgt6m9/FAcNfl3pX3yrzBzVWKNYgiYQ/9LlD
 0Hd5Jh+ZB3grZZJU8TP5CA0i0zhJka/3vJIyZVfkue4okMhYwCeESZeHqGDZTMYijJzX
 iN+a2fE0jDOWTlkOqWic0uUOPABkAv2qdT3kFCo4/ZrwFcmrthfvllCTmYWr5UgLe3E+
 n+M18gn9A/S5qtpGmfaLx67BA5op0Rw9UkoQy4ZHHFhxi5M6nUwpoaRgVYh79ybuf3jw
 faUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ef4PFRZayWm/Zd1hegH93GTG+HjymGK9OAN+/CCzA/M=;
 b=tV/wObKrOCx4AjlsfoVT4dODOMBbmuVcfAffKUNDLoXMWzY/ks2zrT5Ctn7l4O6lrH
 lOhXZ6LymHNeNtxYR3LnqgqqW4YGEvlqRQ2CFNpNvCgvkBWFGDXMNQ+fwJWFG4baHRRD
 OziyGjt520zljgFXLQukpWExJ1c6o2qiDdsZebDkiPQ4K55GKjottbc/+O4KaNszriqb
 pzOXnsIc0uCzK+b1Qrv640pEsDHb8TIKkn5j4gxdRcnOH3f+AnJsZ4f4zQuW7QYonTjo
 cy6Jd884NdLVcNVbvx1dAdHFI9MNS5hM71gwcuA0WhiJTum1QlFsdwIGKPFzUDFcf9q8
 IFIw==
X-Gm-Message-State: APjAAAXqi+Litcj/8JeFwv7VM24ZVtu0o2oqcT3OFGg6GXkHldsauklj
 lAc2q3xSCU9bwfKXUJGCCSc=
X-Google-Smtp-Source: APXvYqwTRMOaNthsBc9rI+Ms5j48RKJWhMli8Gl+x1gruYjBm+bP6Ojhei75YlXAzffwCDTtH4lxfQ==
X-Received: by 2002:a7b:cb0b:: with SMTP id u11mr2821835wmj.125.1570630892330; 
 Wed, 09 Oct 2019 07:21:32 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id r65sm3046159wmr.9.2019.10.09.07.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2019 07:21:31 -0700 (PDT)
Date: Wed, 9 Oct 2019 15:21:30 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Toe Dev <devtoe82@gmail.com>
Subject: Re: header not included but used in vl.c
Message-ID: <20191009142130.GR5747@stefanha-x1.localdomain>
References: <CAN+O=TKeG=K3AdiSEKhzySNKeSWzCwtz7UKq6=re2YYEm5rwAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8Bx+wEju+vH9ym24"
Content-Disposition: inline
In-Reply-To: <CAN+O=TKeG=K3AdiSEKhzySNKeSWzCwtz7UKq6=re2YYEm5rwAg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--8Bx+wEju+vH9ym24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 01, 2019 at 03:06:56PM +0300, Toe Dev wrote:
>  does it have a reason why the file vl.c lacks reference
>  #include "qemu/module.h" ?
>  but still uses the defines include their(for example the enum value:
> MODULE_INIT_OPTS)?
> I'm using eclipse so I was notified by the IDE immediately.

Another header file probably includes it indirectly.

Stefan

--8Bx+wEju+vH9ym24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2d7OoACgkQnKSrs4Gr
c8iuYAf/cvkZOYx4w2o4hXGNs73oBO9qYRbhC40urOLkvflmI4/53u+9QjT8XXZw
mAh1ANpZoYi3e3B7vt4bIOR16ox1IPPaUWZwXgar50WeWFE51PsTXs539g3JOJyR
ZGOZq2n2anfMPns+nhCmvOPnvIb4IidXpNZpsqggrGo8p96GaNszjv0/lTq/yWHg
/M/oowSYeJjDvvontxw57KAT1uFU/A5yK7qLhhTZTng2J/N9UuhQh78dDWoxbu8f
BhUMMm+4j12OtjCRpeAcfTnvQa4IEBEf9Zi4sI/f2qjROcs9pUxTHWxHjI6KlsTl
SEaoeyP34j8fEaUrSNn+J9+o1xpD4Q==
=IAzl
-----END PGP SIGNATURE-----

--8Bx+wEju+vH9ym24--

