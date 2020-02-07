Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA5DC35250
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:31:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E71020720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vJGxYFEo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E71020720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j06Xq-0004Ie-9U
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 11:31:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j06WS-0002CV-O3
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:30:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j06WR-0008ID-Jt
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:30:28 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34784)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1j06WR-0008C4-CL
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:30:27 -0500
Received: by mail-wm1-x341.google.com with SMTP id s144so3517799wme.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 08:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=/eHVGR3SWbxK3XVMzHJ1LrfMrHeVqQ2pPmDKWXKV4Q0=;
 b=vJGxYFEohyK6C99bf/1JjucugcYubrjFCv4hWcjy8rcy+sJI3jcmMAX5+xWw/sHodI
 edEZungdgotUOyEbejllkh7VMq5dA+HnPJprI8sZ89ku+8e1lzKWpeeBQJz41Y9yXGs+
 YUuOYCcM6AyTBT8feWt8sryX2kjzVThVQ3HJtSW5ioPtxQaq9ApEq7wA5Mdh70zJYEGU
 JRzAZQ/2y7UQCUEeqY24NtbwrEkUKAlFi9YVkh0M1Zx76c64LqiOtPnOrJycdjQU+Wqx
 xBgiF7p/JxPfLQqH2uCmBWFM2W818B08xHGknkJFbqboI4Xb4/2DbUnpUkZnw4Lua98O
 WbDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/eHVGR3SWbxK3XVMzHJ1LrfMrHeVqQ2pPmDKWXKV4Q0=;
 b=GmZNmIk2TNz1kr7kB4SkdfvnwXuApmFDfYjKLM52vskSdVgf5q/CtjuxsaTXKxFNJx
 1Ercv0Vpy8njurpbyOCHg5GvzDSNqxODJxXfyPUjRfhmZRNYEEJekZwqRb5f06Np+ue6
 bRAHgLhDkbb0lXw9eJBGszVI/LdU0X5e/AM5d2GLjqr3GzUQhl2bNuQ1jCIs09XURooe
 dq1uOFRHI/SX1Wr7TuVL1dmVHKyQh0SCDv2E2u9xmapqVrgpOxfuB4I8mEdjeUyXaST2
 wBqlnvhwDANvEnXZlxOza3YyH8ocLHYnnqkYRWrSW7EcXU5KzJMb6UBXrVEpXGBkWvL0
 LTZQ==
X-Gm-Message-State: APjAAAUSSQ7CvGFocq12j3Z0e39BMqJPtA7uZnG4m0ZMvRALJ07+BSuU
 ySN5MTuNEHHXm4vwf7KBnZI=
X-Google-Smtp-Source: APXvYqy39JtqPT1oAUbj3qrYoyn1rmFdQGNlusvEvA9O6XRkyUGevoNkT19eWcmP14ZxwNNi8HURKQ==
X-Received: by 2002:a1c:1b4d:: with SMTP id b74mr5281857wmb.33.1581093023843; 
 Fri, 07 Feb 2020 08:30:23 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id y20sm3659169wmi.25.2020.02.07.08.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 08:30:23 -0800 (PST)
Date: Fri, 7 Feb 2020 16:30:21 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v2] docs: add virtiofsd(1) man page
Message-ID: <20200207163021.GH168381@stefanha-x1.localdomain>
References: <20200129151112.156335-1-stefanha@redhat.com>
 <20200206113943.GD3655@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cW+P/jduATWpL925"
Content-Disposition: inline
In-Reply-To: <20200206113943.GD3655@work-vm>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--cW+P/jduATWpL925
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2020 at 11:39:43AM +0000, Dr. David Alan Gilbert wrote:
> > +  * vhost_user_socket=3DPATH -
> > +    Listen on vhost-user UNIX domain socket at PATH.
>=20
> Isn't that the old one?

Thanks, will fix in v3.

Stefan

--cW+P/jduATWpL925
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl49kJ0ACgkQnKSrs4Gr
c8jJjgf/bCqtFipY+no3me8X8kqxdrjqa3TdQws94pyu57ZLEOFS7SvE3ZH+p7YN
S9YCL289bFcOY3h6oQX8tHUnz/2XAd2GxpnpMIOnTS8s8HLsMfBH9q1vdLdrVkxG
sjUr60MFlS/ZD6oIhtDRVulboXAz60sFmdz8aDw+DPrYGNV6si33pb27f5m/4Xk3
b8vJRRqTurp11OfmpWGbJySEcHVKDFEJUB659DFW+6pmQN2Xcqu7HheZv3HCpE4V
IpgJXeTx9+hh4GkkaNeUKzuVslJqq5PIkBR0pW2hCyUkPj4ZE0YMgAa2rvXdCw6S
qYfTVUjt6ev0kXLMlWK7k35CtCo2IQ==
=Lxm5
-----END PGP SIGNATURE-----

--cW+P/jduATWpL925--

