Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E59C433FF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 11:57:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC72B206C2
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 11:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LZloRwVh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC72B206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyENr-0006Ij-Qp
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 07:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35049)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hyENC-0005fH-Eh
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 07:56:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hyENB-0000s9-47
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 07:56:54 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41543)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hyENA-0000r1-Re
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 07:56:53 -0400
Received: by mail-wr1-x443.google.com with SMTP id j16so1979484wrr.8
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 04:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:user-agent:in-reply-to:references:mime-version
 :content-transfer-encoding:subject:to:cc:from:message-id;
 bh=J6Tl5qEzr4pz5FhhA8LUi0f7TGWDfUA4Or4PSk6e47c=;
 b=LZloRwVhKJ/PEgwn3v6U44mZxCj3RSYWPKnQzJkt5PjHsvN3tznaaG22MfZ97yCzSQ
 icKUYx1yQgmCvULEkUkw7Q9nOkpLhYUgJy7i65G+LuHT1J7ipL/XS09LrHK8mr3q+SXu
 0Pn+SXFH8hHO37/Ae6a0Y+dY0bZuSz9reUbtaekVqwDx/dsBTxS/6sUWDwiQhDwLSvmt
 GWb49QxxCTrPvD8Osz5kzj6cZVLY3i6zFPSlHPJFxRlDqi47yfiz94H2XWUiHkkNkZve
 KToVAMjtdtbdMf+8WXkyTCEvVBzLY4s4YgR1sAfibuNQtttNdf9Zzm/gFYbjISc7oPcx
 /5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:user-agent:in-reply-to:references
 :mime-version:content-transfer-encoding:subject:to:cc:from
 :message-id;
 bh=J6Tl5qEzr4pz5FhhA8LUi0f7TGWDfUA4Or4PSk6e47c=;
 b=MAs6tSMUg2fatmqzUc7y6AtvNP6J4NZMmVbQEPn8bA49Azd4UR2Jto0xPxCeBkfYYP
 IxR6HX52BlbkI6BUA8/teNbc/dq0Sq9ou60sBPFae1yR4zB+Kz+wlwLNNFyhdj1NLvTW
 nqTQpKlxWGjHGQ+8/UbvC4AqSOsARsxIIJYzbOkzXHfodL8bpFRkS9x5S/jb4VSwZh7O
 FNn7MZ4jFm3Vm1H77iaTCvVuwRKGE53KiH3vfi/zuLQbx3SWUGIlgPz1a1iTutComcT2
 uGysvujmk7QqVpolERdwVHPVJ7iw3f0fw1/WgMW8kpLJfHEdtYLJMW5nfj1SC6UulqE5
 OC2A==
X-Gm-Message-State: APjAAAVjoJ4bhK65eUWi1zI6x6iYVEBY+6EXHYBZkr6oTV1qWukmfDDL
 7TTEYf/dtUyhM2gHxbQ+n/K+Hw==
X-Google-Smtp-Source: APXvYqxZZKLXqySVYOgSXAthFNcLbHrUISvLrCvpvIv6BobxpJkkJx6kB4v4ujl27VJiCYQrONk8cg==
X-Received: by 2002:a05:6000:152:: with SMTP id
 r18mr5352965wrx.41.1565870211465; 
 Thu, 15 Aug 2019 04:56:51 -0700 (PDT)
Received: from [10.254.112.49] ([94.119.64.7])
 by smtp.gmail.com with ESMTPSA id q18sm3462926wrw.36.2019.08.15.04.56.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 15 Aug 2019 04:56:50 -0700 (PDT)
Date: Thu, 15 Aug 2019 12:56:45 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFEAcA8exvd3khkNhw2JnJWHdkFH5O=ut7LvN9Tz5H0ZTg95Sw@mail.gmail.com>
References: <20190808202616.13782-1-richard.henderson@linaro.org>
 <20190808202616.13782-8-richard.henderson@linaro.org>
 <CAFEAcA8exvd3khkNhw2JnJWHdkFH5O=ut7LvN9Tz5H0ZTg95Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Peter Maydell <peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0F6CB102-2C02-4A7B-84FF-52CC3E6593FE@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 7/7] target/arm: Use tcg_gen_extrh_i64_i32
 to extract the high word
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>




>
>This patch is fine, but I noticed while reviewing it that tcg/README
>labels both the extrl_i64_i32 and extrh_i64_i32 operations as
>"for 64-bit hosts only"=2E Presumably that's a documentation error,
>since we're not guarding the existing uses of the extrl_i64_i32
>here with any kind of ifdeffery to restrict them to 64-bit hosts ?
>


A documentation unclarity in that the opcodes are for 64-bit hosts=2E The =
tcg_gen_* functions are always available, and expand to INDEX_op_mov_i32 on=
 32-bit hosts=2E


r~

