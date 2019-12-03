Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AD9C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 16:15:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E59C62068E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 16:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xvaJG4WN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59C62068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icApH-0003Ny-Ge
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 11:15:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44570)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1icAON-0007cc-1Q
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 10:47:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1icAOG-0001Yi-DV
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 10:47:05 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:51762)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1icAO0-0000UT-VW
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 10:47:04 -0500
Received: by mail-wm1-x32e.google.com with SMTP id g206so3454987wme.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 07:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:subject:in-reply-to:date:message-id
 :mime-version:content-transfer-encoding;
 bh=QOTKx9PIDusdl8qlelapPVMnwrLaphVS6rQ1uM3GoEU=;
 b=xvaJG4WNdSUfDWwhISEITWLtMazigFgYfT/ppmiXs5GA7UrbaqZoLBgKAmmHDtWN+i
 85at7I8kzDtSxJYxWpF9cwzCCfzWjVF0DfvYAATCk3mMkkXGg3v/5GoFVrbllb1CU5Yp
 ZlIGPbnMCCkK1QqoLpbp3WPu8daPkNz23oAk0kPpEh9CZRTHeKcGcNNNpWwvUxuwSbaI
 4yXonUIv/QFNxjVNi2cGxzjFgoBN7b19GtQKv2WEFyZ8kp0E9+R6O0/CVJ013bGWDM2E
 MbvqgJAoYj8d8tTJu03Z1K3Mg6yiVrHaj5AgoYyqC9uFkJqyz2J9mybvY57/1FSO90QR
 JvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=QOTKx9PIDusdl8qlelapPVMnwrLaphVS6rQ1uM3GoEU=;
 b=eVQbgEIh0uZ6p8BzzyDfU/CCgg38hC1+JQMUrvPPtNp9PYGUIt3BU1c4UVJ58YL/jS
 iUCzShRpoaTfRePztQqRZaKfZIwMLuUbUMKwdocFAncibX1bwTNh0CCp0wA0myT+Q4Il
 hCdO3Yw0Il9gcXWUhaXwL+TfRna5z+zk+57Ay+n5BfD5Q92OAjSmGEAe/KGa/yUmLLd9
 iF2zAEpbTwZ8LZ+6YN9V24WZxHBDW/6akU/F2SDrGi/eAwN8BR3h34XL/HEtWu02eZfr
 kGm01f2cS9SaNZtTqPdb0D0pbYcraVAfxW9RPo4xMeWxA0B2e9QHvx+FwMCqY9ruHMur
 BPdg==
X-Gm-Message-State: APjAAAU5X+UrY264ujIv3YHcpqNaq2KNZ/crwGhXANutMcF2NEroNvkO
 OQ0k46RekRECca9oQVLu6LQo+YazBT0=
X-Google-Smtp-Source: APXvYqyoj/K3IUT+H3cy/S4yCCiA22sdMdxNtwb6OurHdf3PsGd7LmeneWoeiABc+uIbOp5zWpFKxA==
X-Received: by 2002:a1c:f702:: with SMTP id v2mr34623456wmh.157.1575387998131; 
 Tue, 03 Dec 2019 07:46:38 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x11sm4277677wre.68.2019.12.03.07.46.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2019 07:46:37 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5D7EF1FF87
 for <qemu-devel@nongnu.org>; Tue,  3 Dec 2019 15:46:36 +0000 (GMT)
References: <CALS5s18QBnPsv3TbtbM7ie__zekvH1T59c-o8FRd+f0EtiwqFg@mail.gmail.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: Custom logic gates on user space emulation
In-reply-to: <CALS5s18QBnPsv3TbtbM7ie__zekvH1T59c-o8FRd+f0EtiwqFg@mail.gmail.com>
Date: Tue, 03 Dec 2019 15:46:36 +0000
Message-ID: <877e3dbeeb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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


burak sarac <burak@linux.com> writes:

> Hello All,
>  Currently I am studying qemu and I want to figure out how I can use
> custom logic gates on user space emulation.  I am searching very basic
> 'hello world' kind of tutorial or some resources to i.e. adding left
> or LOR : 1 | 0 =3D 1 but 0 | 1 =3D 0 to existing x86 arch
> ((https://en.wikibooks.org/wiki/X86_Assembly/Logic) ?).

It's not clear what you want to do. Are you looking to extend an
existing instruction set with additional custom instructions? Can you
explain why you want to do this?

> What I want to
> try is run this extended x86 version with qemu user space emulation.
> Do I need a custom toolchain also for this? I found this book:
> https://subscription.packtpub.com/book/hardware_and_creative/978178328945=
5/1/ch01lvl1sec15/generating-a-custom-toolchain-become-an-expert

For testing you don't need a custom toolchain - you can use inline
assembly with data statements to insert your custom instructions into a
program. Again it depends on what your eventual aim is here.

>
> Sorry for my ignorance in case it is totally irrelevant and I would
> appreciate any guidance! Or pseudo kind of road map for me!
>
> Thank you & have a nice day
> Burak


--=20
Alex Benn=C3=A9e

