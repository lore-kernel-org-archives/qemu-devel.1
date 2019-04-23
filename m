Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2918EC10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 16:39:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E436C20645
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 16:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdvlcT6z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E436C20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56585 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIySZ-0002rB-Ph
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 12:39:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hIyRX-0002Hy-0p
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 12:38:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hIyRW-0005QP-1H
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 12:38:50 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:32930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1hIyRV-0005NW-Ri
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 12:38:49 -0400
Received: by mail-pl1-x643.google.com with SMTP id t16so7813579plo.0
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 09:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=DNlB8nXuDLwYBdQ31fNJgCXkUj+N2x+k9hgzmhw+4SA=;
	b=cdvlcT6zmwYSXfV5aOcyA6rMhhgqtrGKFeZP5zTEAejlu0H8mIproSWk4p4jOXXhtH
	9nFtxZWQ1PZYx2DblZFzqxxMBrF0VwVvl2S7PtCIst+vL0REDnArRhxc97jZxW6sKMND
	2YHPSPHPTzVWDXqjWzhKMFwK0ulE5hStF+frTQ06cElUjMqpVyiXPWWKgcGr2Hs/DdsP
	CQMHgm8PlkSi5GOgMKKZekvFVrsoPDfdTs5fllIyG157+ZP2Bz2iffeWcIZgF8BE1Flr
	4ca6Lof0fZ9YqtC/Vr3u2j94Yde4g28Srd0WYVhQ2R5bRPKDcOtEMTdrCw8kdZSJsr7e
	B3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
	:autocrypt:message-id:date:user-agent:mime-version:in-reply-to
	:content-language:content-transfer-encoding;
	bh=DNlB8nXuDLwYBdQ31fNJgCXkUj+N2x+k9hgzmhw+4SA=;
	b=aLdKsQG0a9buDv1R8hTEPI0V5Cap5XFY0E8XZQ6Gj02EQh3ew/J+pisYeLo/mLB0sd
	RLqZnQzoGZNkj0HAlDLloxHQL8mpiD3ExODzVzTUAHdlrRjqnE//0+0/UM+JDD7GGGxu
	OriEhN0z2kihk+fSo44ayUfIF22BTbZvlxf0LnjScp4UKcxIkhk4XnNzxqgun1eYj6Hw
	8Ki3UX3yKOX6IlJ5XpN+a5fTVC6y4hmYL0HDnaVafZQV9MCT/H49iJWruBqSp7CWVkxK
	Kt2JeArep3MKLct2YUa09EJPZPGdIB4vYtUzK7X6/f6zzA43v56Obm7ASHro33wEfl1y
	KilA==
X-Gm-Message-State: APjAAAVs6t6pMP8dQbJrro7Bzcr1YPpxt/dpLLqLrXVGJcTOHVSSlrlu
	c17Gt+SqLrPXOxyvSg/dRIvCACYq
X-Google-Smtp-Source: APXvYqyTdBxBCbob8RFT0GVN9BAU2uquklXy+NvO8pqLEypTxhqhB+pkmS27yL3Q4u6MRpfbLeiwlA==
X-Received: by 2002:a17:902:f094:: with SMTP id
	go20mr27228387plb.159.1556037525080; 
	Tue, 23 Apr 2019 09:38:45 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.googlemail.com with ESMTPSA id
	i20sm420026pgb.90.2019.04.23.09.38.43
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 09:38:44 -0700 (PDT)
To: Nick Hudson <nick.hudson@gmx.co.uk>
References: <20190423063621.8203-1-nick.hudson@gmx.co.uk>
From: Richard Henderson <rth@twiddle.net>
Openpgp: preference=signencrypt
Autocrypt: addr=rth@twiddle.net; prefer-encrypt=mutual; keydata=
	mQENBFGuLC8BCADcAoWcnW9lTsDMzbO3MBU+KbiGaj5JPatEUscRDkQYM2fyNjJp2tIWDK5a
	n4yngeXB3eX61WbYR3QraRK8mlYLGxyAdHMEQfPipbqf3TmN043fssT2bc82ApJcs1zvLYgI
	rhMht7Dck7A0wNC1jo+ZjVVFig5gDTN7gOzaAdBtV8tVNUddwkLzzaGpfihhSD6U46NdqKOG
	Wlnn6TrkMy0QGdQ5NaXHkRlUjnnUTSW/nKfoxD+EI+A9V4sYOd8mc/TL4aJh/i/AiU57eLbo
	n17uQI6/VTWDUWl8USiz4x9c8vmqlywLx00tAFxxoRWqk4KVJlj+Sh0up/D/sJ+vPpgBABEB
	AAG0I1JpY2hhcmQgSGVuZGVyc29uIDxydGhAdHdpZGRsZS5uZXQ+iQFBBBMBAgArAhsDBgsJ
	CAcDAgYVCAIJCgsEFgIDAQIeAQIXgAUJC7UHogUCWaDNVgIZAQAKCRCtEnDMTdAnm9N5CADO
	cB8F/SudJ72IupxQf40hbJdBK176+gb3sHMsixyLtrU59lee+lIM1OZmlNjsnCYmiSnbA5ks
	Q7p0HfO7DgdmfLzcK6xsHZukqSZy5LByw348Y913ZyjOrJZFdPP7kDg1MnqRqH4+3ZdzxV4y
	eYBWFU9GYMIF06JbUubossOOO4ArNVZbnIPu8Vn2tDZVVqsCBqkoCSBMj519xrvyOu5z4mHS
	LkCglXmVDOXMbqLuNAC3rfNXSnyM4hYkLUyfALJlAAy1Ro+jUqYhu7XUFV/MiwRuFMh5GbtY
	Urkx7tqsWQXLT3GeDk/LqvpWJQwk4cHHckYjRih+70CHIenm81PVuQENBFGuLC8BCACyEx3x
	94HIkTX0CHu2sA0w75+h9wuoA8ggJ7+S4ri0y2YsijWad5TTt6z6MMiqxk9kSA5bppaj4HXh
	86hBF/dWCtMpNr3Rb8FNOKyeA/qkYHVD6HiAiw9c6D8Dr9hWmOk3/HSmGrNURxeUFOckDXsv
	I+yGGKBNshj59j7QZr7ZiuIi2rWlBL8dFN/OWa/o3x7HKsE4k6K8ngwvCKP/QbDLwLLBOWH+
	VEUtpyeyxTr3OJ47ECTxdYvXoAV2iJaKr+6doVQiiR5eVFiMYrUPUECJeolOCwqc/JlWE18L
	+PCAFaW1H+/mpPVfSpN4wnkJ5cQiQVB41IaCM4p20iRzx7ZJABEBAAGJASUEGAECAA8CGwwF
	AlmgzYEFCQu1CEoACgkQrRJwzE3QJ5s7rggAwABzDAGrZ6uWsMxg5PeiiAYPy6LBnCBJSpB5
	Tfy5jH8QTmLfXW+u4Ib4sWXG7PYNR7sIrtqUHjRqXLVXrSnBX9ASGcYw/Xil45khW6LsRpO1
	prHv9gkwQfa6fTiWXVfSfm2Nant6u02q+MaYtQpCVTiz/9ki4FfftUwUHFLU0MhIQogjd11y
	/E08RJsqBwaHQdt14PwU1HphDOzSkhOXRXQLSd3ysyeGUXvL+gqQoXl5XYdvk8IId4PoJRo4
	jcyJ4VbnldvXh5gdGhFA/f9JgkLk9tPW+C3wNtNWyRUq8azR9hF2fg2HJUf4IXQlIu8OOgh1
	VcROBqvtH3ecaIL9iw==
Message-ID: <ef95d1db-8fca-db17-2343-565e814905fd@twiddle.net>
Date: Tue, 23 Apr 2019 09:38:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423063621.8203-1-nick.hudson@gmx.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [PATCH v3 0/2] HPPA fixes for NetBSD/hppa emulation
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
Cc: Kamil Rytarowski <kamil@netbsd.org>,
	"open list:NETBSD" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423163842.uMU5sUCRRoXjx8PZbGyXd05RvvwKDJUvz1u42u0Suvw@z>

On 4/22/19 11:36 PM, Nick Hudson wrote:
> v3 changes:
>  - Don't use C99 comments and fix a typo in the comment
> 
> v2 changes:
>  - remove old debug code

Thanks, queued.


r~

