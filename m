Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C93CC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 07:32:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 491CD20882
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 07:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZyQA2f1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491CD20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBDOs-0005JT-DZ
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 03:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56839)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iBDN6-0003yx-Dr
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 03:30:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iBDN3-0005pC-Re
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 03:30:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56962
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iBDN1-0005mw-Cp
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 03:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1568964622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=QdMpuhfnhvGDAY1ngD1ZThRUofqEuMy20b6v+loucvI=;
 b=ZyQA2f1rNS4zfxX2OluPodLXOl1abMXh2/jvGYJavahZeRhT88xeDUzlnmvZboFZXA3yDs
 889s5W+6c/pH3yXTNirjO28jkzmDMzTm17s/UauK7LvxdXjIpwHhSogyUtODsIFnsdTaQL
 cQ+mJCY0YEoiro6WnL/jVBlmoH5DLMw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-N5gSh-r9NoiAOlewXZcKWw-1; Fri, 20 Sep 2019 03:30:20 -0400
Received: by mail-wm1-f71.google.com with SMTP id r187so3879197wme.0
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 00:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WApZbEletp035CnG3Dv+nWC4XD3r5mBZ5wh2KeB6j+4=;
 b=T9SylEWfBfcMX/KvJOqRNG7LwYEt13towHlevzCUcOJFddUJFp4LgDRhO57df/uFNP
 ewE/kOkE/UM9Ie5ot9Aplfs7OmkzPr19QriSAFw6XMf7W0vfh+kdMCmO6Buu9JUFXfkn
 chM6rEmFvaw5FyOsRXf+LjQ1EbWEpwpDK4rGGZAm0q61gWGNaKWIv3jNjB2/RnarD2qI
 BbXahGMlKUyoiWOwJv9UCVaci6rI6Op4vg331bM4RJwzKOi8FvYABgVQegZNqz0LALGu
 SeGZlJ5aOYJy6eSSXXINnUNuPyLKOPKj/p9EMDBHyn7hbsgnl6HpBEspQdogmFXBwBYC
 oe/w==
X-Gm-Message-State: APjAAAVsLyJnGum36ALBhgpRTrzIx3Q3/J87muxueavTJ6H85YbKJS1b
 BE9mdAs0QVTlFBViBN/IDNgT5BRwcu1Fpf017WV+z+xRlyOV+Qd/y4OMnecT9x2Sy1kkTNhaYEg
 L1VxKonguBhcX+n0=
X-Received: by 2002:a1c:a697:: with SMTP id p145mr2015890wme.24.1568964619328; 
 Fri, 20 Sep 2019 00:30:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwxY8rbkP9Hr93/pj/YSwuCTYOL1js/m4QS/ODNwZO+napow0w0sEeKeINPr08PC2kswmvEZA==
X-Received: by 2002:a1c:a697:: with SMTP id p145mr2015868wme.24.1568964619047; 
 Fri, 20 Sep 2019 00:30:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c46c:2acb:d8d2:21d8?
 ([2001:b07:6468:f312:c46c:2acb:d8d2:21d8])
 by smtp.gmail.com with ESMTPSA id e20sm2443580wrc.34.2019.09.20.00.30.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Sep 2019 00:30:18 -0700 (PDT)
Subject: Re: [PATCH 0/7] exec: Improve code for TARGET_PAGE_BITS_VARY
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190919232952.6382-1-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6e6c8fce-3805-8fe2-5505-92c385e7103b@redhat.com>
Date: Fri, 20 Sep 2019 09:30:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919232952.6382-1-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: N5gSh-r9NoiAOlewXZcKWw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/09/19 01:29, Richard Henderson wrote:
> There's currently a fair amount of overhead in the way we currently
> treat TARGET_PAGE_{BITS,SIZE,MASK} with TARGET_PAGE_BITS_VARY.
>=20
> We have assertions that TARGET_PAGE_BITS has been finalized.  Which
> is fine, but the variable that controls the assertion may be assumed
> to be modified by any function call, which means that we have lots
> of duplicate assertions.
>=20
> This re-arranges things using a const symbol, which allows the compiler
> to assume that the variable is not modified across calls.  In order to
> allow initialization of the variable during startup, use an alias that
> is non-const and controls the allocation into a read-write section.
>=20
> Remove the assertion for release builds.
>=20
> Precompute TARGET_PAGE_MASK.  This removes a runtime shift and allows
> the variable to be used as a direct memory operand on x86.
>=20
> Size reductions vs master for qemu-system-aarch64 for various hosts:
>=20
> PPC64LE:
>   debug-tcg:  -32264
>   release:    -44360
> AARCH64:
>   debug-tcg:  -33304
>   relase:     -77080
> X86_64:
>   debug-tcg:   -6685
>   relase:     -15597
>=20
>=20
> r~
>=20
>=20
> Richard Henderson (7):
>   exec: Use TARGET_PAGE_BITS_MIN for TLB flags
>   exec: Split out variable page size support to exec-vary.c
>   exec: Use const alias for TARGET_PAGE_BITS_VARY
>   exec: Restrict TARGET_PAGE_BITS_VARY assert to CONFIG_DEBUG_TCG
>   exec: Promote TARGET_PAGE_MASK to target_long
>   exec: Tidy TARGET_PAGE_ALIGN
>   exec: Cache TARGET_PAGE_MASK for TARGET_PAGE_BITS_VARY
>=20
>  Makefile.target        |  2 +-
>  include/exec/cpu-all.h | 41 +++++++++++++-------
>  include/qemu-common.h  |  6 +++
>  exec-vary.c            | 88 ++++++++++++++++++++++++++++++++++++++++++
>  exec.c                 | 34 ----------------
>  5 files changed, 123 insertions(+), 48 deletions(-)
>  create mode 100644 exec-vary.c
>=20

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>


