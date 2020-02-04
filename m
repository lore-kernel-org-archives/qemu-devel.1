Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BA4C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:33:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 112A22082E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wq4armG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112A22082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz24d-0007JS-7P
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 12:33:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60001)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iz1sE-0006H2-5x
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:20:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iz1sD-0002Oh-0n
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:20:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32349
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iz1sC-0002Lm-SS
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:20:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580836828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uay9vOc45R64OG+s9E9RNNcWolH4KZJ+MaCE0Bf6LpQ=;
 b=Wq4armG5qlJnY1IdNB1ylZP3Id78lsJpLfokpoFV9TzchJwXJ2Qf2W59G4kkvXg2O1bxPb
 smNZjCJGVEpp0ThfY4BG4K6uuC0va0aYDi6gGM5aX5/BAs9k+/lW8lIpa5XMiYtgZanohi
 7VvE0ZbSMlnbmFQk04sjB2WOQmKnmPc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-gszQtiHoOni6UNNu615zGA-1; Tue, 04 Feb 2020 12:20:11 -0500
Received: by mail-wm1-f69.google.com with SMTP id u11so1607458wmb.4
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 09:20:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hw6+Wu4uyD789kyPxb+U85AivhJLuap+29+WsIGmLOk=;
 b=TABpTfA0a1Ll6iLESL9WEXN9OxNxhpP6Xsdfp1DQK+poIJU2eGNSJkb4Cn8OdzW4hU
 +0jwcqzsq9TuNobps3r+wvz1st6o47zf1a8hvDJXWtVjpi/FyvEJuOnv1b9zunn/b5c6
 EMsbOGqOpXx0ETYIsY+y/N3xbvBk+FCFxzk6VUiNMvg8C+jyRcl9oNADp05bifZGWicy
 CJWkIT9xzGMjUg4kEA9UcP/YfzbVj+jgkzfob2kbif1SWveRi3CD6wwAVT7L8a3H+/Y0
 1oAe8cR71UYYJdfrgsRGkj00EREiI0GcziuhIiZoCYWvKHnt0uTa03D7d03dr1aaEJ1m
 2tNg==
X-Gm-Message-State: APjAAAUC7j0Oj2UV07OPNOKyDKnoSyyoe7WPeCWhZyd0QwG3H5qmaLrq
 b4wB9suL8+CXPamVnl3YQfhTL7DH1bByPu5dq9ft8HzTlbx9Kk7R2L/7FQxN10zlDpbSPAOri9Z
 dUBhu8N58jxGQAKE=
X-Received: by 2002:a7b:c4c3:: with SMTP id g3mr28205wmk.131.1580836810502;
 Tue, 04 Feb 2020 09:20:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqxbro2tqGgYpNhs3142offvNXpPRxeBmpIjZwerMVMvgRuzLuB19WVpuA2rEayfC7paM+nNVQ==
X-Received: by 2002:a7b:c4c3:: with SMTP id g3mr28168wmk.131.1580836810223;
 Tue, 04 Feb 2020 09:20:10 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id h13sm19865065wrw.54.2020.02.04.09.20.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2020 09:20:09 -0800 (PST)
Subject: Re: [PATCH v2 00/12] python: Explicit usage of Python 3
To: qemu-devel@nongnu.org
References: <20200130163232.10446-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <36f9ee1f-03e1-beb5-6f2f-80b17a30ef79@redhat.com>
Date: Tue, 4 Feb 2020 18:20:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200130163232.10446-1-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: gszQtiHoOni6UNNu615zGA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, kvm@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/30/20 5:32 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hello,
>=20
> These are mechanical sed patches used to convert the
> code base to Python 3, as suggested on this thread:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg675024.html
>=20
> Since v1:
> - new checkpatch.pl patch
> - addressed Kevin and Vladimir review comments
> - added R-b/A-b tags
>=20
> Regards,
>=20
> Phil.
>=20
> Philippe Mathieu-Daud=C3=A9 (12):
>    scripts/checkpatch.pl: Only allow Python 3 interpreter
>    tests/qemu-iotests/check: Allow use of python3 interpreter
>    tests/qemu-iotests: Explicit usage of Python 3 (scripts with __main__)
>    tests: Explicit usage of Python 3
>    scripts: Explicit usage of Python 3 (scripts with __main__)
>    scripts/minikconf: Explicit usage of Python 3
>    tests/acceptance: Remove shebang header
>    scripts/tracetool: Remove shebang header
>    tests/vm: Remove shebang header
>    tests/qemu-iotests: Explicit usage of Python3 (scripts without
>      __main__)
>    scripts: Explicit usage of Python 3 (scripts without __main__)
>    tests/qemu-iotests/check: Only check for Python 3 interpreter

Series applied to my python-next tree:
https://gitlab.com/philmd/qemu/commits/python-next


