Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B25AC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 16:15:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86B7F20673
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 16:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhbbIkQi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B7F20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60133 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL8w9-0004i9-O4
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 12:15:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hL8sJ-0001Z4-2n
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:11:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hL8sI-0004VQ-6V
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:11:27 -0400
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143]:37567)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hL8sI-0004Un-1d
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:11:26 -0400
Received: by mail-it1-x143.google.com with SMTP id r85so8493596itc.2
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 09:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=qfVDCsu8q5X01ghIvQbPmo5XumATtaSnQ0L+C0TQ9d4=;
	b=FhbbIkQiJhfQVqOO/R4Ipy1yczIJRP3uI2FlLGlWHw+C0ZTfrAFhmHCTRpfqljTOB+
	N5BBdju9kjVawpnKtr+v2tvxfhaFozjkNn/S/stjq47O8tdaJTlFj0vcoVR9tODmHxXe
	ZGFmBdAph5Uj4MxqCcLG3l4I4OFVdMVbiBa9zeYRwSfusvG4pqNmR8nyjebS764CG2st
	4RLLm7WJL6OxkAOHudMqRUPC/jx3BMujvVTSzxMx3TFZjZLeUE5E/LOA4IUhyCJZjzBX
	XxsXnQz1C9VmWJiRSASj2j2dFBOpIFNfFAKyAutLUIrKBxvgVLKUZEQ8IBXyn4yDIU5n
	/4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=qfVDCsu8q5X01ghIvQbPmo5XumATtaSnQ0L+C0TQ9d4=;
	b=LaKrjy3ZqCzRT7tzyI9O9BAx730SvyKHV/5H8saw/belI3vlDXJmTfjuxerX5cVr5C
	WQ6/tFFzBto7VMGqZ9pYXHV2K1eo4FdB8Sbx6kEnCwGNJaBcjjq7yzFZGy573ujMVGx9
	1PbaYgAATsiIcDy4hUuCtbNpT/vlhvfVnLRadAg6L/5FkqAyH226IKeY4WiUWn7/mGIx
	Rc136wkcsTJVnTAHhQ48pE3sTMChzlewpptceFaDX5kcnHdI9XnBiT25Bunwkmpklh6z
	5rZjdGzMsqWJVNUahYrAuuajmfxGb8cwqcX50wgL3q9aiy9/QYUpvogl1lMLh1ZPHiIB
	xzOA==
X-Gm-Message-State: APjAAAVIUwAbI+SRTTi/wtTYXl5N+wRZTpUUqxxZ6is9BfzTrWMnXelc
	Pp4i90tYdcATCfz+VxNL5wdyIYjPklQ=
X-Google-Smtp-Source: APXvYqxhq5u1Y9H/Lc7FAwixaBiMcE24Oir+8PAwlZfOwB23jBc4dEgjYI1x84nto7oBLSDVKDus1w==
X-Received: by 2002:a24:6e01:: with SMTP id w1mr20523170itc.15.1556554285318; 
	Mon, 29 Apr 2019 09:11:25 -0700 (PDT)
Received: from localhost
	(CPE64777d5479c3-CM64777d5479c0.cpe.net.cable.rogers.com.
	[99.228.64.175]) by smtp.gmail.com with ESMTPSA id
	b72sm15493135itc.30.2019.04.29.09.11.21
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 29 Apr 2019 09:11:24 -0700 (PDT)
Date: Mon, 29 Apr 2019 12:11:20 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Message-ID: <20190429161120.GB13640@stefanha-x1.localdomain>
References: <20190426102115.30002-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline
In-Reply-To: <20190426102115.30002-1-yury-kotov@yandex-team.ru>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::143
Subject: Re: [Qemu-devel] [PATCH] trace: fix runstate tracing
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429161120.EvbzrUxlw01I3TnLI-poSg5ySJDgr4EwO7BbesrCsHQ@z>


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 26, 2019 at 01:21:15PM +0300, Yury Kotov wrote:
> Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
> ---
>  vl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcxyIoAAoJEJykq7OBq3PIg3YIAMLlT+gFEqniDXEKkxbgx/TW
6xHsK4UAjWJoArZNOU5O2OTeQnePER5H7OaxamBANxEcfUpNruQ/kYpB+42ckv8i
f4zCIOkDawvR7fAAEERtHoyzjTvFrLD89MLFfPulPXJXTSe7Td/d2idwrnVWWXZZ
qojQmNtftU3txc0+m5jZjHeLwnUeXSsEr9qAFziEHvd9Sr0x8/EOmM4sM1NUzSMu
BucSVueEi91kkiHPGk0YXWr1Z1F3VCDhFUCemr+4jT2DpZ8coO4+IhlOMWBYgKfZ
vwWI3Yb6OyZVaKukmAxW/avxa9pczL7V+enV2Lo/Gq6LWjXVrk53+ZSjW1YEBng=
=V70O
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--

