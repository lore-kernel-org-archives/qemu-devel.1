Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2E1C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:18:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62C5F20771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BGzB+jWC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62C5F20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyDhX-0001ns-MX
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 08:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyDfj-0008BG-TV
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 08:16:31 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:50286)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyDfi-0007mu-0Q
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 08:16:31 -0400
Received: by mail-wm1-x332.google.com with SMTP id c80so1740901wme.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 05:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=SHNuuFUaqJOJ6GUIQRzb1wT4TZjwWxuIbxVipbbyLF4=;
 b=BGzB+jWCwthoXX7HZzcKlJgmO2qXTnsVfg76gPRMEncdXrbLT5kMVHXHJ0zLMCcleE
 BQILP1xMmwQbkTktrVi7hox2w6rWrjeqlInNKwuhPCoGoFFzMd6FAS6CfIjY3dWrccY0
 cBgknB6RXjKH6tYJtGZFWoe7xdLlF37Kg828RD0bqFCFlxwtP+Ju4IKCkk8DuLA4bxva
 7g2Ln78KkQNjATg0FbTdv2+qxgg35qbD5fOTI7l1YdQCQ7w5x/MAI8CWNVsq76DVq2WV
 pfmSB3npTaM1oOXqP95FpaduiKGdyH1YVr8f+M5RMpnW2bVjGWpIicGFxncE21FwLDxL
 5JhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=SHNuuFUaqJOJ6GUIQRzb1wT4TZjwWxuIbxVipbbyLF4=;
 b=Leyu9Y/9pAgpqAiFMGAAF7jasS/B9QB6W9Y4w4ob39uyp5SntXfC7bAEPZKabn1xOQ
 sYfK/G67unXVrJM/XUj4LovJBUyRWz9XC69XtNB4BCSh/36uo2wUv0wO7kzsUcp6X5a2
 uFw8EV8hk59bVnkNhqYVcAf+JVAWBF9KNPTv4CUi50+K16uxfiOrh4TKOLDxLthDuYpV
 qtC/67czinewzDfezWS/IQtiHG603A62EG38RbVHugBUBAfSYU3WmKOA/irBT8W8fPyt
 ccy1zZXY1X/N5yPvM3pm0i1GOiQLvepI0lrxER45qY5gmfrpk5BMwg8b7gfNY9pybRgi
 OnvA==
X-Gm-Message-State: AOAM533KraEQHReOplYSRnjWHdTGWD6wFDPTB4ip5hMSAB10sHSwFiRn
 KSa5Kzvx4uaHhbXbEr0eHBEQjA==
X-Google-Smtp-Source: ABdhPJyoEPAeV1AVB8eFgsWI3utakwKCuEbRt3IX6ddgE+jvJETaLaVJbWpEsTz03VqEbwWp9qvcQg==
X-Received: by 2002:a1c:5f41:: with SMTP id t62mr8237486wmb.53.1595420188058; 
 Wed, 22 Jul 2020 05:16:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n16sm6872160wmc.40.2020.07.22.05.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 05:16:26 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 69E0D1FF7E;
 Wed, 22 Jul 2020 13:16:25 +0100 (BST)
References: <CAFEAcA9+9ZQY2CxZ9V4bZrkAGR5eUapbwSk6sNyFGyyd39Y=1Q@mail.gmail.com>
 <20200722093621.GA4838@linux.fritz.box>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: please try to avoid sending pullreqs late on release-candidate day
In-reply-to: <20200722093621.GA4838@linux.fritz.box>
Date: Wed, 22 Jul 2020 13:16:25 +0100
Message-ID: <87r1t3u4me.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Kevin Wolf <kwolf@redhat.com> writes:

> Am 21.07.2020 um 17:56 hat Peter Maydell geschrieben:
>> It is not helpful if everybody sends their pullrequests late
>> on the Tuesday afternoon, as there just isn't enough time in the
>> day to merge test and apply them all before I have to cut the tag.
>> Please, if you can, try to send pullrequests earlier, eg Monday.
>
<snip>
>
> So given that we _will_ have some late patches, what can we do to
> improve the situation?
>
> Maybe I could send the pull request before testing it to save some time.
> Your tests will take a while anyway, so if my own testing fails (e.g.
> for the parts of iotests that you don't test), I would still have time
> to NACK my own pull request. This wouldn't buy us more than an hour at
> most and could lead to wasted testing effort on your side (which is
> exactly the resource we want to save).
>
> Can you test multiple pull requests at once? The Tuesday ones tend to be
> small (between 1 and 3 patches was what I saw yesterday), so they should
> be much less likely to fail than large pull requests. If you test two
> pull requests together and it fails so you have to retest one of them in
> isolation, you still haven't really lost time compared to testing both
> individually. And if it succeeds, you cut the testing time in half.

I've taken to just stacking up patches from my multiple trees to avoid
sending more than one PR a week. Of course sometimes the stack grows a
bit too tall and becomes unwieldy :-/

>
> Kevin


--=20
Alex Benn=C3=A9e

