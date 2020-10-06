Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5442DC4727D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:47:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEEB920639
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cLhKZZk8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEEB920639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPjYp-000452-Oj
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 05:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kPjWo-0001pG-W0
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 05:45:03 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35747)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kPjWm-0002aN-Ta
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 05:45:02 -0400
Received: by mail-wm1-x342.google.com with SMTP id q5so1635793wmq.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 02:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=w9EnONwsfY1KaGk5ySXcKILGhZdJZ3hjmO662AB5Fso=;
 b=cLhKZZk8kxvAj7b1hpCMNT5OrUv0yzxBoCd8knGYOEc7lddnWJNzgaoO09Lc1ZsM5B
 SO7BUt5E3akGz5R4uvz0ZOWvxhaLBMzgImjv9fzAYQluktj9qHfi4ASTqWeJc8XBNT3L
 L5wsWQ+tBHZquvC6TM8vE8m/3miFL1pr0Inoe5WEPQxWNf4yQ9JHofqar1DufgQOFydv
 A8pWWRx9LL+tbjjFest8LL6WumSPlk89UMt5vUgpE86EjdzlUj28c0QCq/Ktd39RmUMj
 4ny3vfYdgLAsoN0UXudHW6pgfULjdXwFyB0aKVxzV1U6KhQjQ82yHnKIDUhBLBLrVyTr
 xslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=w9EnONwsfY1KaGk5ySXcKILGhZdJZ3hjmO662AB5Fso=;
 b=hVwz8/TQzeIbIWmy1CBeOZEcwIEfu35IlW4WoJpKULIWRYOBMUyox2PR62eiVtt+wW
 ZMO7IZ4og3JCqjZROLzmdP5nbBfYq1WErFXIkF5bOfkjzJSRsUA6OUq3LOuSxfWBWhP8
 qus1RGCInoP5P/FzHTeOVOBSmH5JZXXc4LhxkfMFeSVShPLTUdVsQTq1yrkHszSmS643
 1UMcuBw/Q8FwHxtQP6Lp31pjYWdTE0nD51lkMHCu9ZTPn5IiqIxQ1HKksZMAoe0UDG/v
 onBQmkVYpwidXPkVNxSpHj5QlOkejCDTuxhfJrtq/HsjioXlkMaoBI+UwX920g7MhBDy
 pwLw==
X-Gm-Message-State: AOAM530I9JuQfWKeINFJLnWtyVqFgFz8CCu5N56lkMT7TLEBFyLDsU5p
 zEiGac9GaW4Gua0ZUj/p4J+kHA==
X-Google-Smtp-Source: ABdhPJzhuYmfJ3czTJHeDZkN57XuXb37pRJ8S+M1cFbhx5urWA3ByC5yEoVwq+5fKP5/p3IN26WWzQ==
X-Received: by 2002:a1c:7302:: with SMTP id d2mr4019002wmb.133.1601977498073; 
 Tue, 06 Oct 2020 02:44:58 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x6sm3398516wmb.17.2020.10.06.02.44.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 02:44:56 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1F1391FF7E;
 Tue,  6 Oct 2020 10:44:56 +0100 (BST)
References: <20201004180443.2035359-1-f4bug@amsat.org>
 <20201004180443.2035359-9-f4bug@amsat.org>
 <alpine.DEB.2.21.2010051327090.312@digraph.polyomino.org.uk>
 <87eemc3b1q.fsf@linaro.org>
 <alpine.DEB.2.21.2010052047250.11145@digraph.polyomino.org.uk>
 <e1818fb3-4c63-6b2a-17cc-f3b7bc7d393b@siemens.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [RFC PATCH 08/21] contrib/gitdm: Add Mentor Graphics to the
 domain map
In-reply-to: <e1818fb3-4c63-6b2a-17cc-f3b7bc7d393b@siemens.com>
Date: Tue, 06 Oct 2020 10:44:56 +0100
Message-ID: <878scj3cyv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kwok Cheung Yeung <kcy@codesourcery.com>,
 Andrew Jenner <andrew@codesourcery.com>,
 Philippe =?utf-8?Q?Mathieu-Dau?= =?utf-8?Q?d=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Julian Brown <julian@codesourcery.com>,
 Sandra Loosemore <sandra@codesourcery.com>,
 Taimoor Mirza <tmirza@codesourcery.com>,
 Thomas Schwinge <thomas@codesourcery.com>,
 Joseph Myers <joseph@codesourcery.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 05.10.20 22:52, Joseph Myers wrote:
>> On Mon, 5 Oct 2020, Alex Benn=C3=A9e wrote:
>>=20
>>> Joseph Myers <joseph@codesourcery.com> writes:
>>>
>>>> On Sun, 4 Oct 2020, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>
>>>>> There is a number of contributors from this domain,
>>>>> add its own entry to the gitdm domain map.
>>>>
>>>> At some point the main branding will be Siemens; not sure how you want=
 to=20
>>>> handle that.
>>>
>>> We've already done something similar with WaveComp who have rolled up
>>> the various mips and imgtec contributions into
>>> contrib/gitdm/group-map-wavecomp.
>>>
>>> It's really up to you and which corporate entity would like internet
>>> bragging points. The only Siemens contributor I could find is Jan Kiszka
>>> but he has contributed a fair amount ;-)
>>=20
>> Given that the Mentor branding is going away (and the "Mentor Graphics"=
=20
>> version largely has gone away, "Mentor, a Siemens Business" is what's=20
>> currently used as a Mentor brand), probably it makes sense to use Siemen=
s=20
>> for both codesourcery.com and mentor.com addresses.
>>=20
>
> I think the key question is what this map is used for: Is it supposed to
> document the historic status, who was who at the time of contribution?
> Or is its purpose to help identifying the copyright holder of a
> contribution today?

I don't know what others use them for but for me it was just an easy way
to get a survey of the companies and individuals involved over the last
year (2y, 3y, 5y... etc) of development. The consolidation of
contributions isn't overly distorting IMO. The biggest user is probably
the end of year state of the nation surveys wanting to see what impact
various organisations are having on a project and consolidation just
helps push you up the table a little more.

The biggest counter example we have at the moment is RedHat/IBM which
AFAICT is because the RedHat guys are treated as a separate business
unit with their own unique identity.

Either way I don't think it's a major issue - hence it is up to the
hackers to make the choice.

--=20
Alex Benn=C3=A9e

