Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61126C34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 06:20:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32B5D21D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 06:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B5D21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3wEu-0003Fg-Th
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 01:20:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47324)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3wEN-0002pd-04
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:19:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3wEM-00005L-0K
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:19:38 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:32860)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3wEL-000058-Sk
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:19:37 -0500
Received: by mail-yb1-f196.google.com with SMTP id b6so9973305ybr.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 22:19:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ewJc3Z9E7ZIcjnbRZFiJP5MQ1ELWtu52wnrklTe0zcE=;
 b=V7y/aUTWV/Hm4giPm4zf7XE0Z0mvkGS4RC2/M8bagQjic/gKyKPAjUrPlzuf3n3Jtg
 onrYbJFHluDOsuvk0uo/ChOzHMLNwarMtIz5i6yuafDo0D97vLO7f04e95GhAaGCPIYP
 DyaW7EE17FwXT7KyUv0GzfHGSStishrsGx7wrKosf/uZBaozoV0mj86NFN8A2/R0ZkYk
 yfKCqbfYD9/LU5uAk++OzUPMwiT4uWa/Jj2C9bAS2Uhcp/7vZXeB+z2P+rwbvCJ4wHli
 Hlee/wHiql/qfB771Bz/M5BFwDHwhEXl0eoiJYkp6u4dWE5elDEZyTdpHKOyoRkPOSYV
 aIxA==
X-Gm-Message-State: APjAAAUyG9BMBvwUNQhO/RXzCjbXUGjTVTknS1NgDnoag1H0SJWexiuw
 9jDop5V4GicKOhcd+ywnPEC3v5lr3C3c1M3AMhE=
X-Google-Smtp-Source: APXvYqyqRvyK7rTL+pfCN0PEazTj/regMCrfl9Zu0mD00ST3RjHHSqIhIrBhcyrDN2ZOUp3FGSXSw5bxXYAx5qoptXI=
X-Received: by 2002:a25:5c07:: with SMTP id q7mr19107907ybb.376.1582006777131; 
 Mon, 17 Feb 2020 22:19:37 -0800 (PST)
MIME-Version: 1.0
References: <20200213234148.8434-1-f4bug@amsat.org>
 <20200213234148.8434-3-f4bug@amsat.org>
 <CAFEAcA_4=ZoBwV+X-k4ZSfNqrvDqt=hi0aetG4GFBUxXEeZBBQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_4=ZoBwV+X-k4ZSfNqrvDqt=hi0aetG4GFBUxXEeZBBQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 18 Feb 2020 07:19:25 +0100
Message-ID: <CAAdtpL6SLwxRqij30PHZ=mZuhbPcT7uTvSM+nm1ihcjhGbnRsw@mail.gmail.com>
Subject: Re: [PATCH 2/4] hw/hppa/dino: Fix reg800_keep_bits[] overrun (CID
 1419393 & 1419394)
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.219.196
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
Cc: Helge Deller <deller@gmx.de>, Sven Schnelle <svens@stackframe.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 17, 2020 at 6:37 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> On Thu, 13 Feb 2020 at 23:44, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
>
> > Fixes: Covertiy CID 1419393 and 1419394 (commit 18092598a5)
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> I think this also fixes CID 1419387 ?

Ah I missed this one, indeed it does.

> thanks
> -- PMM

