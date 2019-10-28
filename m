Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF53CA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 09:08:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE91D214E0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 09:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lwIE6DrJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE91D214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP10S-0004Wx-5R
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 05:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56671)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iP0zS-0003hH-91
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 05:07:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iP0zR-00028p-0P
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 05:07:06 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:34758)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iP0zQ-00028R-ON
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 05:07:04 -0400
Received: by mail-wr1-x436.google.com with SMTP id t16so8979957wrr.1
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 02:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=XoDIoR0TngnAzD1nasyFGteeNTtHgJGNXI5tJ+0a9do=;
 b=lwIE6DrJjkyFk7fL3mNXjGK/3NVOxpObZkhOn2SgVxU7MFXpBip76QSEYHC6I9/d1T
 43tYxBY5etPE/If1DzMdYvFlvQZYRhXM0GRlNT5gDYYtrbdX4HhQGCliJ4S0H++i697J
 fwYjpCe93y0PiJLnNbL9MJxVYcBeDCsOurcgtDHg2rbCG1jhffzWRRyhdFSeQ3LVdbZL
 yWANgdiej/RwsppKLeYr/FEAqRwo+yXSvO/JSBiORJ1a5smoREXS6LK6HZ7b01YJpfNr
 qRh0TkQFuXwWAji279iEPE0ZkphewEHAX9gEV99WoUWUJzTbeS1gUXbj7vhz6ZQpW7Kh
 KQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=XoDIoR0TngnAzD1nasyFGteeNTtHgJGNXI5tJ+0a9do=;
 b=M1+vMBEM8gyCHNHSQiX+cJl4GaU80LOKLFH1o5lRzjSs5H3Jw50ZauWwGioMoyL6dJ
 3qR4pebSJNPFBH90iIUHS3xhh4u4ypoi9/uowskUcOPRVTzPBiRG4PsLg2eyE+w+L023
 b/lCZxec8nxgABv8MFzDPK5CJc3nNGFjVDz/IZnfPuGtvTYfVUou4y6nPQ+86Ve+nKbM
 5c9UcisdgFRzxi+svPwp0QpW53JWaFlsbmBXU/PHlzGdtPJMIa00+/7oHFEmsSjmeob4
 tQ6BQcZb5giv8zX0zB4Jfz0ru42757XKxJEZ9mTQY2Rs7b5dCdD7GqBR/Xgm45xbDM3S
 uEfg==
X-Gm-Message-State: APjAAAW3eHAdMNF4A6VsrgJDnzbTvVvP242T5l7NccvEGYS5GOr0OApg
 U2rPH74jtR+mU4D/y4lYq57xxQ==
X-Google-Smtp-Source: APXvYqxNJpoEdyhX3L9TSR51oyAKY9itbMZ3HXVYa2E9qKrjpPFp37a7NTTyyhileBzn55yV7oQDdQ==
X-Received: by 2002:adf:e38a:: with SMTP id e10mr14685369wrm.348.1572253623196; 
 Mon, 28 Oct 2019 02:07:03 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u21sm13367947wmu.27.2019.10.28.02.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 02:07:02 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EB0691FF87;
 Mon, 28 Oct 2019 09:07:01 +0000 (GMT)
References: <20191025063713.23374-1-alex.bennee@linaro.org>
 <87lft9rnfs.fsf@dusky.pond.sub.org> <87lft8lvdh.fsf@linaro.org>
 <874kzw60bp.fsf@dusky.pond.sub.org>
 <CAFEAcA88xPAcDYmD=dDZeBh12eYZLHfK0qA5_WfTuDQPpx7mNQ@mail.gmail.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL v2 00/73] tcg plugins and testing updates
In-reply-to: <CAFEAcA88xPAcDYmD=dDZeBh12eYZLHfK0qA5_WfTuDQPpx7mNQ@mail.gmail.com>
Date: Mon, 28 Oct 2019 09:07:01 +0000
Message-ID: <878sp5w85m.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 25 Oct 2019 at 21:24, Markus Armbruster <armbru@redhat.com> wrote:
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>> > I'd rather not unless we can make an exception for late merging of the
>> > PR. I've worked quite hard to make sure everything is ready for the 4.2
>> > window and I'd rather not miss a whole release cycle on a
>> > misunderstanding of what these plugins allow.
>>
>> I think there are multiple ways to avoid the nuclear outcome.
>>
>> Coming to a conclusion before the soft freeze is the nicest one.
>>
>> Making an exception for late merging is another one, but Peter may
>> prefer not to.
>>
>> Yet another one is merging the pull request before the soft freeze with
>> the understanding that it'll be reverted unless we come to a positive
>> conclusion before say -rc0 (Nov 5).  I'm confident we can work it out in
>> Lyon.
>
> I'm happy with any of these (and we have a longstanding rule
> that as long as a version of the pullreq was on list before soft
> freeze it's ok to apply before hardfreeze, even if it needed to
> go through a few versions or was otherwise a bit delayed).
>
> In practice, since I'm on holiday Mon/Tues and this hotel wifi is
> awful it's quite likely that I wouldn't get round to actually processing
> a pullreq with the TCG plugins in it before we all get a chance
> to talk face-to-face on Wednesday anyhow :-)

I do actually have a little bit in my talk about the history of plugins
and the worries about GPL circumnavigation in my talk on Friday but that
doesn't stop us previewing it on Wednesday ;-)

>
> Alex: I suggest you send out a pullreq with the plugins stuff
> (I've just applied your testing pullreq), and then we can
> make sure it gets over the "passes merge build/tests" hurdle.

I'll spin a new PR. I split the testing changes (and reverted the netbsd
autoinstall patch again) and sent that on Friday. Would it be OK still
to base the plugins PR on top of the new testing PR to avoid the
conflicts in Travis?

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e

