Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45F0C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 17:38:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85AE42082C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 17:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CBZczEid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85AE42082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7k6C-00005d-57
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 13:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7k58-0007sR-88
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 13:37:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7k56-0003XU-Ra
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 13:37:33 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39540)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7k56-0003Wg-JV
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 13:37:32 -0400
Received: by mail-wm1-x342.google.com with SMTP id q12so506312wmj.4
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 10:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=k9vWIOraXnJtvi8xFULrqLEONafCzIq+vP4LZAe9i9A=;
 b=CBZczEidwbBcoQrxCdT6XgrWFvebrW2/PVlIMoCggcZXZckPuxWnNO6sBjryWIXMBT
 pRwHXiOh1h3CpmZBZIJY7Gmko2RUwD96pb0lkmQAEQZkKtfIO7CxjRuJNxrSX29Ot/cH
 yuWs/N2+cVuf6TME9sVpbMFEqYOPWIOBuUNLxKqJ7Nx3QHYNfgwtlTaRGQ6qJkkzZz9y
 rLGoqLAVrm+KO7s304wZFftZfBh1x3ZB+0pM0dUWDPZwwwLJNe4skO/+YDlYPVO4/Iqt
 wMdMN5bdqY5JTt6jsYiy822rFA7PkAYgNHYV7+6oz2LhASTLqA738GBSY4qioQij+r9D
 qu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=k9vWIOraXnJtvi8xFULrqLEONafCzIq+vP4LZAe9i9A=;
 b=k6xZwBDQyTOtpzYkt8zHrhG02qXKDBq+pwpxbDguzgz/0eYJYHQ73HEXl3MIILA8KA
 QV0XHmeFkNHJ2EicfYRt0fTVKaUw6gT3bZisT8GVZTbhAmX7s10nnlR/5zEnX09r4bhT
 uJlce36YPg1M7HJG6oKScrU7WYIaxpbrKIkVXJvYE8bV1APkKjDF/mKK//vLTUA8VhwG
 kq8Tu4X4D05hFERoXRBfjfHzm3yj6MIsRjR8LQHEy/IeafNZT2l3xViGqIGKnctYEiqC
 emqnFqc8bXSkRAXH8U7xKkbv8EXpdIwsFq4vcv4ckKDA5852HV0MgqHeexeKb6HJYlla
 BNaw==
X-Gm-Message-State: APjAAAViZu3y4reNGs1TziPHidiaL16yjDsYpzKZvO4mMhp5iswX7G5x
 GR10wnld3YX0zj1FmrX2f+vT3w==
X-Google-Smtp-Source: APXvYqzAiojAPoj4hRzSYWCwM3RXPmTKVrJrXygmjMnUYZacVnV3FTiBNI6LSAu745WPgMd0Ti4+Rw==
X-Received: by 2002:a1c:4b14:: with SMTP id y20mr531983wma.10.1568137051069;
 Tue, 10 Sep 2019 10:37:31 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n7sm17962361wrx.42.2019.09.10.10.37.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 10:37:30 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 280C41FF87;
 Tue, 10 Sep 2019 18:37:29 +0100 (BST)
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <87a7cty0tv.fsf@dusky.pond.sub.org> <875zm5yzgq.fsf@linaro.org>
 <20190910161615.GA20976@quinoa.localdomain>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Aaron Lindsay OS <aaron@os.amperecomputing.com>
In-reply-to: <20190910161615.GA20976@quinoa.localdomain>
Date: Tue, 10 Sep 2019 18:37:29 +0100
Message-ID: <87h85k1292.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH  v4 00/54] plugins for TCG
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
Cc: "bobby.prani@gmail.com" <bobby.prani@gmail.com>,
 "cota@braap.org" <cota@braap.org>, Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Aaron Lindsay OS <aaron@os.amperecomputing.com> writes:

> On Sep 06 20:52, Alex Benn=C3=A9e wrote:
>>
>> Markus Armbruster <armbru@redhat.com> writes:
>> > Please advise why TCG plugins don't undermine the GPL.  Any proposal to
>> > add a plugin interface needs to do that.
>>
>> I'm not sure what we can say about this apart from "ask your lawyer".
>> I'm certainly not proposing we add any sort of language about what
>> should and shouldn't be allowed to use the plugin interface. I find it
>> hard to see how anyone could argue code written to interface with the
>> plugin API couldn't be considered a derived work.
>
> I am not a lawyer, but I would not have expected software merely using a
> well-defined API to be considered a derivative work of the software
> defining it. Unless, of course, it is a derivative work of another
> plugin using the same interface in a way that is not necessitated by the
> structure of the API.
>
> What's your reasoning for why it would be a derivative work? Is your
> belief that the plugin API is complex enough that anything using it has
> to be a derivative work, or something else?

Well it's derivative if the code couldn't have been written on it's own
- so is "derived" from a design in GPL code. The endless arguments about
derivation w.r.t the nvidia kernel drivers hinge on the fact the drivers
are multi-OS and shimmed to into the kernel - not explicitly written for
Linux. However no one really knows where the line is because it's the
courts that will ultimately decide.

OTOH the kernel has explicit language about the syscall layer:

   NOTE! This copyright does *not* cover user programs that use kernel
 services by normal system calls - this is merely considered normal use
 of the kernel, and does *not* fall under the heading of "derived work".

Anyway I don't really care either way and don't intend to become an arm
chair lawyer as the arguments can become rather circular and tedious. We
might want to make an explicit statement in the QEMU tree about
reserving the right to change the API in the future and the best way to
keep plugins in sync is to have them in the upstream source tree.

> That said, I'm not sure I understand in what way adding a plugin
> interface would undermine the GPL, so maybe I'm missing the point.

I suspect there is a similar concern as GCC had when they were asked to
expose their IR to tools. They were explicitly concerned that people
would ship proprietary compilers consisting of a GPL GCC shell with all
the clever optimisations in proprietary plugins that glued the front and
backends together. I don't think this is a problem for QEMU because at
the moment plugins can't be used to improve code generation - just
observe it. You could theoretically implement device models this way but
there are definitely easier more efficient ways of doing it - as shown
by other 3rd party forks of QEMU.

As I mentioned in the other message I'm sure there will be proprietary
- or rather secret behind closed doors plugins but I don't view them any
differently to all the various secret and external forks of the main
QEMU source.

>
> -Aaron


--
Alex Benn=C3=A9e

