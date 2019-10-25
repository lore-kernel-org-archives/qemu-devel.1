Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B806CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 15:07:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24F4420684
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 15:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w8YDv/BC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24F4420684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO1B0-0002PJ-G8
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 11:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iO18T-0007x3-17
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 11:04:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iO18R-0005fa-7M
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 11:04:16 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:35885)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iO18Q-0005ey-W7
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 11:04:15 -0400
Received: by mail-wm1-x32d.google.com with SMTP id c22so2341640wmd.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 08:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=6MZfbOS8iibHkVsu9PIru5FMqyFskAz7vkYTM0pgOC4=;
 b=w8YDv/BCrZ0rnRAKGvDGLbOqKn5auq6I59LBQcr71EK+z6DKKvzoDpT/K4lXJtFg/1
 zPHqTQB8+RrBhmUAk1DzwIzyr2P7BEynErqLZTBkG3iOMoGvhGkqBMhTrmWbiZ+c0tbX
 NsNsSpWHpH0A1lwqYYAjODi72QaOe63QRqi7iZl+9+z/qOdfh2YV2Dx3QMnkqZP1Ncvp
 mcOuCd0lZEzmcQq/g1AgupfTn3P9nkoE5RY/ttJkV10cg6FzbcnvS29EuygWN4pVcu1O
 Oxpb2BZUm8DMoQDFWC0yoyjQftP+9etcef7x1O7mK9xo60GR/PI8ka/OXAJ2LGFkTKpn
 krfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=6MZfbOS8iibHkVsu9PIru5FMqyFskAz7vkYTM0pgOC4=;
 b=WVPrWvNNddUlczpRxddsmfKyrW2/Ls4zWZWV3IRgvP0PcEknmMuT4ZjeJlWlFqFtdT
 Xnp8o5rVI6LhPEcCNlyhieyWuHWoTNaKRzJJ7I+gFRpFXz5clzL4fTNY79OVwAvgDT/n
 dN7J6FJ2KDQDiUE3+CWMYfEIhe3E6+NV9XWbp/jcu+KL5bf6KUZXrJgZNjAVWa+oWn+5
 60Rvks2XllpBQcRNIvkBlH/0jtvLWjF0A8LfseohQiElxkAUBIlGYiHUs8H/G7EcaoZp
 ntma/BDSS2ESuwHYvHcQNH4I8wyNG/ufqeSxDybdOa90SeKmq+lDsxXNz3QXWQNTebY3
 zeeA==
X-Gm-Message-State: APjAAAW2xN0ol9n+dZIcMlPjwbCZUC4KpJErgIwGa79P8Ba6xoPrH0Ai
 Rt3Y/zEIm6PimMLWlVfU6t122g==
X-Google-Smtp-Source: APXvYqy9fJvnrAsQRJZsJ+6i4Yum4OAowWqJB7z4mal/e6a1MnCuYkcnMZUIDrrxj4yt/1KDS3Gz/Q==
X-Received: by 2002:a1c:8055:: with SMTP id b82mr4100657wmd.176.1572015852577; 
 Fri, 25 Oct 2019 08:04:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 126sm2345617wma.48.2019.10.25.08.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 08:04:11 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 80BD51FF87;
 Fri, 25 Oct 2019 16:04:10 +0100 (BST)
References: <20191025063713.23374-1-alex.bennee@linaro.org>
 <87lft9rnfs.fsf@dusky.pond.sub.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PULL v2 00/73] tcg plugins and testing updates
In-reply-to: <87lft9rnfs.fsf@dusky.pond.sub.org>
Date: Fri, 25 Oct 2019 16:04:10 +0100
Message-ID: <87lft8lvdh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Markus Armbruster <armbru@redhat.com> writes:

> I hate to interfere with the merging of working code for non-technical
> reasons....
>
> This is a plugin interface.  As I wrote in reply to v4, I'd like to see
> a pragmatic argument why abuse of the plugin interface to circumvent the
> GPL is not practical.  This might include "not a stable interface", "you
> have to link with a truckload of gpl code", "the set of things you can
> do is deliberately extremely limited".

I included a link to the description in lead patch of the following two
revisions posted after v4 for this purpose. To repeat myself:

  QEMU TCG plugins provide a way for users to run experiments taking
  advantage of the total system control emulation can have over a guest.
  It provides a mechanism for plugins to subscribe to events during
  translation and execution and optionally callback into the plugin
  during these events. TCG plugins are unable to change the system state
  only monitor it passively. However they can do this down to an
  individual instruction granularity including potentially subscribing
  to all load and store operations.

So to summarise it is a deliberately limited set of passive observations
that can be made by the plugins. You cannot implement a new device using
this interface.

> Perhaps such an argument is made somewhere in these 73 patches already.
> I admit to not having read them all :)  In the TCG plugin design document
> perhaps?  Assuming it exists...

Indeed there is - docs/devel/plugins.rst

A high level tour of the design decisions and approaches is the subject
of my talk on Friday morning.

> I proposed discussing the project's requirements for external interfaces
> on GPL circumvention deterrence at the QEMU Summit next week.

That should certainly be an agenda item for the summit. I don't think
this provides a mechanism for GPL circumnavigation though.

> If merging this could be delayed until the licensing ramifications have
> become a bit more clear, I'd be obliged.

I'd rather not unless we can make an exception for late merging of the
PR. I've worked quite hard to make sure everything is ready for the 4.2
window and I'd rather not miss a whole release cycle on a
misunderstanding of what these plugins allow.

--
Alex Benn=C3=A9e

