Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96043C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 15:03:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F80D206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 15:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="CBw77/Hj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F80D206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyzEP-0000Vv-K6
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 11:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jyzDA-0007q2-Eo
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 11:02:12 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:37571)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jyzD7-0001BD-R9
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 11:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Content-Transfer-Encoding:Content-ID:
 Content-Description; bh=31cmAYKdATjWXDDPPjryBJpz/tKY8AQ1GEVtTsWtv5g=; b=CBw77
 /HjDb5/mNA16LLRmOtuQvAN+QSIil+b3QamRFyma0KrzsWuafTPR+k5Oe8qPpMDpdea5/CUVgfUD+
 u/zWZ0EKSTxHgW8/8zxOMhhT3ph4LiOku66dbiXB44q8fGwLn1YSRp/DtpI0k/ukDu6rkz/lLoDRR
 bX5fSbiXjJKGsieAYNOhvUa6QcPgZMHwXx6Ips+cGTRBXs8i6TsYF6vvHPkB2dmH3x7AmW5jLV9Jd
 uk4z73ItbOak2d1FE1PzjpVYVPI517bvIHQIwl/LfVMnu++Dtfy1Dal6ytmuyPKA92MQ2dGWn8im+
 09ymiYmPjz2DyRsxfIEziR5BgbfyA==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Ed Maste <emaste@freebsd.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Richard Henderson <rth@twiddle.net>
Subject: Re: [PATCH 1/3] configure: Fix atomic64 test for --enable-werror on
 macOS
Date: Fri, 24 Jul 2020 17:01:59 +0200
Message-ID: <6594742.2WtYCQuXUD@silver>
In-Reply-To: <20200724143220.32751-2-thuth@redhat.com>
References: <20200724143220.32751-1-thuth@redhat.com>
 <20200724143220.32751-2-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4421294.T87a3rL90d";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 11:02:06
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--nextPart4421294.T87a3rL90d
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 24. Juli 2020 16:32:18 CEST Thomas Huth wrote:
> When using --enable-werror for the macOS builders in the Cirrus-CI,
> the atomic64 test is currently failing, and config.log shows a bunch
> of error messages like this:
> 
>  config-temp/qemu-conf.c:6:7: error: implicit declaration of function
>  '__atomic_load_8' is invalid in C99
> [-Werror,-Wimplicit-function-declaration] y = __atomic_load_8(&x, 0);
>       ^
>  config-temp/qemu-conf.c:6:7: error: this function declaration is not a
>  prototype [-Werror,-Wstrict-prototypes]
> 
> Seems like these __atomic_*_8 functions are available in one of the
> libraries there, so that the test links and passes there when not
> using --enable-werror. But there does not seem to be a valid prototype
> for them in any of the header files, so that the test fails when using
> --enable-werror.
> 
> Fix it by using the "official" built-in functions instead (see e.g.
> https://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html).
> We are not using the *_8 variants in QEMU anyway.
> 
> Suggested-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  configure | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/configure b/configure
> index 4bd80ed507..9eaf501f50 100755
> --- a/configure
> +++ b/configure
> @@ -5919,11 +5919,11 @@ int main(void)
>  {
>    uint64_t x = 0, y = 0;
>  #ifdef __ATOMIC_RELAXED
> -  y = __atomic_load_8(&x, 0);
> -  __atomic_store_8(&x, y, 0);
> -  __atomic_compare_exchange_8(&x, &y, x, 0, 0, 0);
> -  __atomic_exchange_8(&x, y, 0);
> -  __atomic_fetch_add_8(&x, y, 0);
> +  y = __atomic_load_n(&x, __ATOMIC_RELAXED);
> +  __atomic_store_n(&x, y, __ATOMIC_RELAXED);
> +  __atomic_compare_exchange_n(&x, &y, x, 0, __ATOMIC_RELAXED,
> __ATOMIC_RELAXED); +  __atomic_exchange_n(&x, y, __ATOMIC_RELAXED);

Ah right, there is also the __atomic_*_n() variant of these functions. I 
actually had the more generic variants in mind.

But LGTM and yes, it resolves the warnings on macOS, so ...

Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

> +  __atomic_fetch_add(&x, y, __ATOMIC_RELAXED);
>  #else
>    typedef char is_host64[sizeof(void *) >= sizeof(uint64_t) ? 1 : -1];
>    __sync_lock_test_and_set(&x, y);

Best regards,
Christian Schoenebeck
--nextPart4421294.T87a3rL90d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEltjREM96+AhPiFkBNMK1h2Wkc5UFAl8a9+cACgkQNMK1h2Wk
c5UsaRAAtJDL7c3Vh31o82+JzNvRH9KcsM4MyPgfZA/jhFdbDtbfuo+cHz9p3UVE
88F9GINO+EbHGQJMzHLGRh6twKJkTQpCjoekyLIrOdoW2mAxsT/lhhKaKFPQ/cUl
HUwIp1SQGqgVzq23Pm80DbIpSptbxdUHIeAY8Q8hYzwNBdrfVJhiFnHpd9lUu9JW
vJwfzQGDJNMqxzQS3p6n1EkrNMSyIDwJNb0Dl8/k1+08+qVniUYX+OobxtrDg4Q9
1NUH7t+RWwysxhYUQpwF5UPz5yvwGN1FMNhjXNG43gfL0s8yy0RPCad9/dwi62fV
0N7oJ73UKxPUXbhfx00b2Tb91VWs2RV0tGep051faYIiCZqwTwaVnngv2zH4iMIW
l3d63lTFkcCi9lXZo+KKxLG5ew3nqalt+FFoKzJixcP7NVrLWRXSEL+fW3M+gELY
G6cGsqBysS730FWwmHrYm1hXjlBDBGLiEKh81wJN0P9CfspBps7QKbgDi0XvmECS
agmQcaoTtNmghj1AMmQ4baFWHErROZFjCAprSwuqbm2knmDTbXYuYPWqX/NjvDXX
Mxu4zXGiS3fWwbtqXqlQKqe28mlP0l7zMYPlUyrkeKVs+neMM0MCFWWqkrhdJZdV
7G8vnqE1YrbW/EwkzYkOti8MlOhy3VspClEr3Dy1qbmZrT5Bv6g=
=AFDc
-----END PGP SIGNATURE-----

--nextPart4421294.T87a3rL90d--




