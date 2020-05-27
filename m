Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EEFC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 11:13:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 492142075A
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 11:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p4a9HFFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 492142075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdtzX-0001XJ-Eq
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 07:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jdtys-0000xL-SN
 for qemu-devel@nongnu.org; Wed, 27 May 2020 07:12:18 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44962)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jdtyr-0001NV-Lr
 for qemu-devel@nongnu.org; Wed, 27 May 2020 07:12:18 -0400
Received: by mail-wr1-x444.google.com with SMTP id y17so15194799wrn.11
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 04:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=U8fYY23aqSoQnqTyuftHB5suQ2ehXR8OQgKg0RN0/BE=;
 b=p4a9HFFRYH4ua6HMH15aaX9hi248cJ5jknW73Dw+Mx9pjdwFNG/pjCGqoahCZG/rQw
 Vj6RRS9HW6UUm/M/vqxccM+DjBmWgUK0iqRI14VVz4NfYmWY14x3emsZdCEnPSZB42XK
 /09W2HiG6NTk6LWTfjF0wkl6Rb5XW27Fy9+T1v5POVQa+GbruVnnrzJMkgtDY4rKBomV
 F1L+e+g/d3hZKNbriBOQiEkDXMFKL204CfDlS9m18lViBQWuDKw2otGyDhANVEq5k63N
 OjzTxWnpcPyAVOYHRAlfMpEU00LySatO5JDryEwGRDQhG7K+g9mhr9UJwCP6RDfZ1fFq
 Y/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=U8fYY23aqSoQnqTyuftHB5suQ2ehXR8OQgKg0RN0/BE=;
 b=RVg5LfBPt4J1fIQcng4izdXRLpgc1Lr4Xv14VjOxtnPAOiDpr5BJ6QheoQKrPkWDKK
 Acr9xtNlVpv+eNIwAA/hLeSweiLdpI1f6f5XivPhx3WapbmVElGPQAmrk1hsUnxcCf+W
 AZAma0zeBw7KY/ZiDdzn5YIsEpXBrzHIo3SALbSpxoAg4Vy1ltfsgld3XL9B14KVlKfB
 20OSzSMFoGCpIBue/o+WoeM7JFTDp8ktC81IoBRZjlUP3VINW0SkEqJiPwwLgz6apXVN
 xEEn47aq0/hZOuhl+/LpVvSXHEZ+Gr3py9apLHHPo6GVPAYtWtVn9evCckMYWWcJMttL
 Nb4g==
X-Gm-Message-State: AOAM531K1E+QIMV8rCmO+4OpJ4nfRib40gP2mJDzYpbYtcs9zSErKTex
 d8/HkNitW3hu2AWz4dAeljA=
X-Google-Smtp-Source: ABdhPJyXxiwq48SPedV2a4ZVakDJMJMNB1bS2JzE4ZFYL2ZKIVGy559Alwjiavhr9nzHmRVmtV+IMQ==
X-Received: by 2002:a05:6000:ce:: with SMTP id
 q14mr26557033wrx.105.1590577935988; 
 Wed, 27 May 2020 04:12:15 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id p1sm2602675wrx.44.2020.05.27.04.12.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 04:12:14 -0700 (PDT)
Date: Wed, 27 May 2020 12:12:12 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Daniele Buono <dbuono@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/4] configure: add flag to enable SafeStack
Message-ID: <20200527111212.GC29137@stefanha-x1.localdomain>
References: <20200429194420.21147-1-dbuono@linux.vnet.ibm.com>
 <20200429194420.21147-4-dbuono@linux.vnet.ibm.com>
 <20200521095237.GC251811@stefanha-x1.localdomain>
 <02f318af-609a-ee9d-4857-abe297773dda@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9Ek0hoCL9XbhcSqy"
Content-Disposition: inline
In-Reply-To: <02f318af-609a-ee9d-4857-abe297773dda@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Tobin Feldman-Fitzthum <tobin@ibm.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--9Ek0hoCL9XbhcSqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 22, 2020 at 11:24:46AM -0400, Daniele Buono wrote:
> I would feel more confident by adding another check in configure to make
> sure that the user didn't enable SafeStack manually through other means,
> like manually setting the option through extra_cflags.
> What do you think?

Sure, a compile_prog call could check if SafeStack is enable when it
shouldn't be.

This can be done together with a --disable option.

Stefan

--9Ek0hoCL9XbhcSqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7OSwwACgkQnKSrs4Gr
c8jCtgf/doRbfcVk6t8KjJ2v/VW9UD9NegRp9TCfRdz3ulmjg+qkUw9F0wnaxx+6
kl8aXISNpwMbfIjwD+LLOeB+PGxpQ8j+fKGJoL5hjg/bMo9urs0nen/l0/P0mAZ1
aoPjQEvtiVRe71SebCoX9v7dfdPlioK1N0yyhUw0A79kqn4FgMr5B9YRSoy13SRL
9qFCvd0IfJJrG20ifJZONqlMfMXYXo9FpaViGNTwpqDf5NYCL5Jl7KtuTxA1Mzxf
Un4Can3zH5DZXXCv5Gksq3F1QiTzZrV6tKk/U2klzFYgnKvJ6HQPgMcNs4iy5KLz
qCrNbQAnQj6Px1csey8hS2J6U/PTlQ==
=xj/b
-----END PGP SIGNATURE-----

--9Ek0hoCL9XbhcSqy--

