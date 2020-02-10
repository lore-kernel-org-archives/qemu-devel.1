Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA63C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 11:30:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47F5D2082F
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 11:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c4yHuYBY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F5D2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j17HB-0000BZ-Dl
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 06:30:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j17GV-00087F-QQ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:30:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j17GU-0000vU-Ev
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:30:11 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:46606)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j17GU-0000vD-8c
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:30:10 -0500
Received: by mail-oi1-x235.google.com with SMTP id a22so8810857oid.13
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 03:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7eZubyIFK5C7/ohFjd4JLmykUS580I+PSc2YXxS9zVU=;
 b=c4yHuYBYwdEclEt2LEArn7k0gBPhflLo9lEP1O55iwHTH9C9n4tbJUxVWEv4UY7Xwd
 0MN+YyJpPuculFyEXx+fWru0pp/PcabImA25OGDV1Lh5YV1R2JBszp78VKfrW6PvDLLu
 NhVeQi2BN7qL8JzwnqQjzjomHcUWvxFiHi7yLf9QVbAUGSrWTvB3Wd+lZrWbYrCOPGof
 LTVtv7KrYM6qZkm0HJaFGFEFMNLfdiZmqfUQfxBIBi6J6jMKHfQNtZL9g94ThHz91vgQ
 sdvK60YF7wKJ6KdWBftMgQaV7/F7dZKEZP5xwcmVleBMNjE8VoYNStcY07TFSf9/1tDm
 va6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7eZubyIFK5C7/ohFjd4JLmykUS580I+PSc2YXxS9zVU=;
 b=i2ugst04VPMxY2W4mgLzUTjYLA817KYFXrEyEds4iwFKIj8wzUcw0zvqy9LLn/1l6a
 L3gY67X/GNIEeZ2dxowEcet5BsqCoGypOLqKdqhEnSVafyk1krzHYJUDdt9yzTSlIXAK
 lsVkSbpjsG78z83Yo6QN5e0hmvkXcHYTQyAdv2kyIlA44XgVwa/G77q8iybNY+depUpX
 xRylC9Gcr2B0nkM4LlhonTURbdlJ/Kj7lHy5441/bpTlLMSQ9Y1IEmU+gLcGZ7C2ZBdy
 fhtydBQgWQBB7K8COxQVUsUcNNSezdN6QDoRl0VPXcq4ewhB549tQLOZqhsBzqI9F6/v
 XjBA==
X-Gm-Message-State: APjAAAXpP6+jm0V423IgZ7G8I3+IwbXd9uVpUue/3n9/KxYTX8k/ttZn
 pW9cOGLmQa8D4DBfs9f6HoQGOM90NcJRxdoXoo9D/g==
X-Google-Smtp-Source: APXvYqwNyvUF+HK823NskJV9Ks/gCTELZemkiSv3T416lXM6HfhgylpjEwYeFSn39bEf1/skgD5RrisZJPoNK+vAa4s=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr539854oid.98.1581334209250;
 Mon, 10 Feb 2020 03:30:09 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <875zgm2vqv.fsf@dusky.pond.sub.org>
 <CAJSP0QWCn_vv2Vs-UWc9nPHjdBQq9KMkiQ7D91+RwHM_okTzZw@mail.gmail.com>
 <CAFEAcA9NfGivg0C_enAT_8+_mmbQSi6H=7G+4w7RdJwXP7yUtA@mail.gmail.com>
 <20200210110812.GB3269@redhat.com>
In-Reply-To: <20200210110812.GB3269@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Feb 2020 11:29:58 +0000
Message-ID: <CAFEAcA8TtfNsd8v5sWTTBj8KikKen23Op4ttoLM3Ac60vFJiNQ@mail.gmail.com>
Subject: Re: Summary of Re: Making QEMU easier for management tools and
 applications
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::235
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 10 Feb 2020 at 11:08, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Mon, Feb 10, 2020 at 11:01:48AM +0000, Peter Maydell wrote:
> > On Mon, 10 Feb 2020 at 10:57, Stefan Hajnoczi <stefanha@gmail.com> wrot=
e:
> > > I'm in favor of simplifying QEMU at the expense of an incompatible CL=
I
> > > change in QEMU 6.0.
> >
> > If we want to do wholesale incompatible changes to the CLI
> > I think we definitely need some kind of tool where a user
> > can say "here's my old command line, what's the new style
> > equivalent?". Otherwise we're going to have a deluge of
> > user issues where their old working setups broke and
> > QEMU didn't give them any useful hints about why.
>
> There is a risk that if we promise to have a fully automated conversion
> that it will be alot of work, and could force us to introduce hacks into
> the new impl just to satisfy conversion.  IMHO we shouldn't be afraid of
> declaring that some parts of the old syntax can NOT be directly transform=
ed
> into new syntax, simply for the sake of making a new impl more practical
> to move forward with.

Agreed, but we should at least be able to handle the easy
stuff and say "this is the general kind of new option syntax
and set of options you want" for most of the rest.

> An alternative approach to mitigate the disruption is to *not* make any
> incompatible changes to qemu-system-XXXX. Instead introduce new binaries
> with the new syntax and any other architectural  changes we wish to make.
> The old binaries can be deprecated but remain around for an extended
> period of time, to give people and apps time to migrate. We can provide
> rough guidance and perhaps partially automated conversion to help people
> move, but not aim for a 100% automated conversion.

I think our history of failing to actually complete transitions
would predict that we'd end up with both the old and the new
binaries essentially forever.

thanks
-- PMM

