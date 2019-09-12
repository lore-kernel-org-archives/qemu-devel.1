Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204ECC49ED9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 10:37:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E041A206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 10:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cp7DUYoF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E041A206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8MTj-0006Si-35
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 06:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i8MS2-0004fV-00
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:35:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i8MS0-00073h-L8
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:35:45 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:51288)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i8MS0-000732-DK
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:35:44 -0400
Received: by mail-wm1-x331.google.com with SMTP id 7so6862176wme.1
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 03:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=/SkksgrPvAb1ByvqgXsmFP5Ei1m/IESprO90XwrXPxY=;
 b=Cp7DUYoFoU94UDFfXEho46BXg2q8C0MiU8zWYCxsscR5Z8w9Ci7P8FhxGuZOddfEgG
 bk0YkJzLNAHtP4dA3JQSpmSacPCRUo5NsFafXK4o9YajBzpBJghXlvO635f2EO7Rqayl
 xP4lDxSGW2yOJyEGzs6Re+dqYebU/wSp6nRCzqkFd5WSKF1uzJ7d3wcQCJJrkxGwkhXD
 V6ELk/kbPpx04GcxIxCdBOKNA6UnkFhRnTd+YMRmR+Jwhy+Fj7TpwaJtMkWYsytMOowt
 SvmGrw+xW6GDfQ38K+8ix86Ce6lrBFL8gWBL1O2dKS+MDvl62QgfoKoB9tgxK8jcSwYI
 rVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=/SkksgrPvAb1ByvqgXsmFP5Ei1m/IESprO90XwrXPxY=;
 b=LJLPTCIIuhmUCSyeFlMtYkn/2tOyMjCqVZTQE2g6TzneJhfAj90GFpyXhv/B9dtD6o
 1MSdewYGa/PpbIdK7QZ8jex6UDQUhNCBW0Gi/5TGDp2+U0MyFZaE47aYlxwD8qxU1o4E
 YHjiewjb+ZDH6NWcybAcA9QjJ6jis8XNf6QOzOo4jNrWCCbKaeZ0PwMI1VYyv9do5PJj
 7DqJSRMjq2/Bto1Pas/l8ONCR6FxAILbXKWf3hXp1TfLGaN3YO2X9HRw4BT3sFZ0aE5s
 tCVrBbJZu4mqws/+FZgfULnyLY1ahDd+6VOXsJ/np801iNfQ9+H57msnlga4AHSmOhKw
 hd/w==
X-Gm-Message-State: APjAAAU8XnjZDkIoRxpBu42GwoAY6dQIpunKQhWNDTZv/MBL3Yy2w4gZ
 8IEsOhMO29nnNEOOXy20QocpjQ==
X-Google-Smtp-Source: APXvYqwfV+eIDSjRrFpTZ5xI1058grtpXBcR87zIWTvFszvjdffp1lzTooOzJmoid+QpD4pI7VP7rg==
X-Received: by 2002:a1c:7f4f:: with SMTP id a76mr7815065wmd.117.1568284542771; 
 Thu, 12 Sep 2019 03:35:42 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d9sm30168975wrf.62.2019.09.12.03.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2019 03:35:42 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 60C901FF87;
 Thu, 12 Sep 2019 11:35:41 +0100 (BST)
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <87a7cty0tv.fsf@dusky.pond.sub.org> <875zm5yzgq.fsf@linaro.org>
 <87d0g6dnbc.fsf_-_@dusky.pond.sub.org> <87y2ytzy17.fsf@linaro.org>
 <CAFEAcA9Db2ENw7e_1-XOTbHeV=sp_zFxqoq4se+63OK+mQaeew@mail.gmail.com>
 <87v9txzv3o.fsf@linaro.org>
 <CAFEAcA_dQ4txzn7HzBO8PMwh2K2WpJ+_8LOEMtXxqg5Hmwfzdg@mail.gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
In-reply-to: <CAFEAcA_dQ4txzn7HzBO8PMwh2K2WpJ+_8LOEMtXxqg5Hmwfzdg@mail.gmail.com>
Date: Thu, 12 Sep 2019 11:35:41 +0100
Message-ID: <87tv9hzts2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
Subject: Re: [Qemu-devel] TCG plugins and the GPL (was: [PATCH v4 00/54]
 plugins for TCG)
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
Cc: Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Pranith Kumar <bobby.prani@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 12 Sep 2019 at 11:07, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>> > Wait, what? From my perspective the whole point of the plugin
>> > interface is that it should be stable, in that at least there's
>> > a good chance that a plugin you built will work against multiple
>> > versions of QEMU, and if it doesn't then it should fail with
>> > a reasonable error message telling you to update. I'm not
>> > sure we should be landing the plugins infrastructure if we
>> > don't have that much stability.
>>
>> There is a big fat blurry line between "set in stone" and "not requiring
>> you to re-engineer the plugin every QEMU release". I'm saying we should
>> reserve the right to extend and change the plugin API as required but
>> the expectation would be the plugins will continue to work the same way
>> but maybe with tweaks to the API hooks to support additional features.
>>
>> It's also a pretty young interface so I would expect some evolution once
>> it is released into the field.
>
> Sure. But I think we should document that we at least intend to
> have some approximation to a compatability/deprecation policy
> here, and some mechanisms for versioning so you get a helpful
> error rather than weird misbehaviour if your plugin is too old.
>
>> One problem with the anti-license circumvention measures being suggested
>> is it will mean having to recompile plugins for any given release.
>
> Why should we do this? I think this is making life hard for our
> users for no good reason. We *do* have this check for modules,
> because a module is just a random .so that can do anything in
> QEMU. I thought we had the TCG-plugin interface much more locked
> down than that?

It is, there are only a few set calls the plugin can make into QEMU,
mostly to register callbacks to events. Currently it can examine the
state of the system (again through the API) but can't change it's
behaviour (although a register access interface has been requested
although I'd initially intended to make it read only).

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e

