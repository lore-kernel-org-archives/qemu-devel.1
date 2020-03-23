Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A7DC4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:26:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55FFA2070A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BF5YBBFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55FFA2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGN6R-0001kv-HE
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 09:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jGN5d-00012f-Hl
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 09:26:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jGN5c-00026D-FO
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 09:26:01 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:47063)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1jGN5c-000264-91
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 09:26:00 -0400
Received: by mail-wr1-x443.google.com with SMTP id j17so13651957wru.13
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 06:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=+U3k//tRnKAvz6cyP6MqawOsw/SfHGOeBaKQbLPZeCg=;
 b=BF5YBBFA/Wkqm60F4OQYBbkdImJCEE0IFiYqOYdVWvmOSJqL9wsiakgB9kaNR4Z1eb
 yDS96W7yMpiS1AI62Bd9guEUZglaQGwtluqSiG9ioKGRxcbjdSIo6izcr3Gggi5xTYzl
 shqW8Tj6u5UE5CpM1wCn++0PHr0Xf7J2X3x6H97sOcpi2QT6JXQXk+/ojEGGI/LSTuQR
 6Ug2lTLeD5zzmyJC1pFj4M7OdO/6g0v3xaek+cadfEp0jZCHuCGEvfM0rFcTyYm9dR5r
 wfHRVFGH30U3QBt+eazwDdyjJGP+6H5HsPRGIM/TELl91evoE+WE4pmCrLrz4uMB+iv9
 kV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+U3k//tRnKAvz6cyP6MqawOsw/SfHGOeBaKQbLPZeCg=;
 b=HPk3U/uN8y7GV/DanuhPKNJHNd6LxAJbYnmCe6BTtPTRaTWAdobAEQtwiW2YoZ/6g4
 72xdVZw8k/tUOkpNkexXzFMSk83KR4UIe25f2OqP6xTtkcxhqJP2H351C6rrKfJ5tiMb
 oq4X6Twn3MQv2DHrnLbQFFqfHLxsph1PN7AOohXg46LEP09gto0HSIC0WAei6T+P4itu
 NLXSZ49oQgJvMMMw1Diju8AAgXC5vWbehZaGHfPNLGe21l4ee0WJECacz83ct5Q43yPW
 kuQXKcvh4NqgEg+TrVtzEVAOd2L20SwiK2s/tto0QkEVFA6DGx2dA/H/X8BKTHsp71gi
 AFFQ==
X-Gm-Message-State: ANhLgQ1VCMRivwHuI7Jf6XCNWkJhsGQi4OJHV0JbK8NcNHw3NvM2YJth
 aU7xtaiK3Wb3Uzjs8EiJugRpPSRCESA=
X-Google-Smtp-Source: ADFU+vvOa3wPM7saT1L3TFBa/zJpZHh+HppyJwufkG8fF3VRSQHQrtPAI5rSqsI94pvb7//ZDwjKvw==
X-Received: by 2002:a05:6000:114f:: with SMTP id
 d15mr30886553wrx.143.1584969958578; 
 Mon, 23 Mar 2020 06:25:58 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id t12sm7210107wrm.0.2020.03.23.06.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 06:25:57 -0700 (PDT)
Date: Mon, 23 Mar 2020 13:25:56 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v4 0/2] Replaced locks with lock guard macros
Message-ID: <20200323132556.GG261260@stefanha-x1.localdomain>
References: <20200320123137.1937091-1-dnbrdsky@gmail.com>
 <158471180295.15515.1369533827289907154@39012742ff91>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EDJsL2R9iCFAt7IV"
Content-Disposition: inline
In-Reply-To: <158471180295.15515.1369533827289907154@39012742ff91>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: dnbrdsky@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--EDJsL2R9iCFAt7IV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 20, 2020 at 06:43:23AM -0700, no-reply@patchew.org wrote:
> /tmp/qemu-test/src/util/thread-pool.c:213:5: error: unused variable 'qemu_lockable_auto1' [-Werror,-Wunused-variable]
>     QEMU_LOCK_GUARD(&pool->lock);
>     ^
> /tmp/qemu-test/src/include/qemu/lockable.h:173:29: note: expanded from macro 'QEMU_LOCK_GUARD'

Apparently gcc suppresses "unused variable" warnings with g_autoptr() so
we didn't see this warning before.

clang does report them so let's silence the warning manually.  Please
add G_GNUC_UNUSED onto the g_autoptr variable definition in the
QEMU_LOCK_GUARD() macro:

  #define QEMU_LOCK_GUARD(x) \
      g_autoptr(QemuLockable) qemu_lockable_auto##__COUNTER__ G_GNUC_UNUSED = \
              qemu_lockable_auto_lock(QEMU_MAKE_LOCKABLE((x)))

The WITH_*_LOCK_GUARD() macros should not require changes because the
variable is both read and written.

You can test locally by building with clang (llvm) instead of gcc:

  ./configure --cc=clang

--EDJsL2R9iCFAt7IV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl54uOQACgkQnKSrs4Gr
c8gVpgf9E/kkDZp9Dw8MEwUhKoVRpJV5y4QsZ8cb9aSjfzUEBcwLNf/IEUBUBXTX
7epsRxB8Go3Q2TTyntWWNbyA2a9528k/SKAylLAlwIS/8jwLgYWJXu55atMhAUrJ
TPZi/H4yG9kuT8jReqAuLK9iAEnqK4qzAxbEHbL2YcfsienOXX+aTaeaXrSPakNf
9POMbdS6VikX0YZMVPw1tKmq1RqgW2rcWbzpqE3iz2MjEAtq2XvI3FOTJI0IEOn/
pySWtFLmALBgTeji3WB9wAX7y+y8jxU2uFu1YrXb+GsDgKaUvjraT+jcTDIzF24L
6iMxv1Sb4qjhQAT8Ar/PDJfrCFbPpg==
=lsut
-----END PGP SIGNATURE-----

--EDJsL2R9iCFAt7IV--

