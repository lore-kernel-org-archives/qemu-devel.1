Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99823C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 13:15:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60F8220760
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 13:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F/irYla6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F8220760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw3jA-0002c4-NB
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 09:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jw3hc-0001Gm-G5
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 09:13:32 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40234)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jw3ha-0000eN-Bp
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 09:13:32 -0400
Received: by mail-wr1-x444.google.com with SMTP id f2so7004259wrp.7
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 06:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=l2e5OUD/brUS981RMND7W405qdx6JfEdXjj3Brn/t9s=;
 b=F/irYla6//3j8wSU6+xA57WNcs1TCpJPC8C0M97LKFEsK3TK3L6YXwExrkme5Sep+x
 dCt+2Djg4oBejNz8dmQuCAklRb43ix3AXzI7DbeIjnYnBqKilgGMH8IidBTfZIvjd14+
 MCmjwi9PBldYk6O6+fakHsUJS10XpA3yZ03kLizXLq1pi0EmL48tOROsLYDMd8fojW0x
 sYsVRSom1gqX+Yf/NvK7yXwfWDreKROloR65XZI2gK8T2RN1eKMAW0tSSZCVj12g19JF
 iwsk9ivoBXMT0PGOjtVHYCKkhV2C4ms/xDCdmo+v/5xtGjUuICyFUpLGR6eFg0crJ4hv
 viDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=l2e5OUD/brUS981RMND7W405qdx6JfEdXjj3Brn/t9s=;
 b=pJ0rVy8o1WrQ6Y/HGNxRYV4BShZnEsdkVpVKEYY5AglVyNlFCFjxsjtVD44UwmM43Z
 zxFtVBoxkQeh0xPvSxAPmfcA/yWq657hMU6/tbD6OKCZft273EcjtNcHgpqfDKOlcCrP
 jDsLcoyCe8+Cie0230em2Yns1eaB0Rs/HLpGXUYMkxo488osTncuWCz5i+xeHql0pOtA
 p8VkSGd+/q3IMdCw8v6ATSPpPxMqP+Ev6huOuliC2j36fYKbSHhqfwRVTZsSztPJpM/P
 wrIpULnGbfqzYF6f9NW9R0Rsn41QzfxVWqJ1RE1r5gK86faX/QMYS9DQAqIHLRX0PsrP
 QHbg==
X-Gm-Message-State: AOAM531IhFvvBm4ZX6eiA3aiYGnWJROhtq68FljXJg3ZUe5gSiRSX5oa
 1pE113pQVLAkQkWSILMgHD6ojg==
X-Google-Smtp-Source: ABdhPJyWUbDsmiTuJnm7ozrcdl7aGdvtVDg0WXd9KYXNxiFo86Eb0+6+nYoXwB1tv5xE+bigGcf3UQ==
X-Received: by 2002:a5d:664e:: with SMTP id f14mr5096291wrw.6.1594905208587;
 Thu, 16 Jul 2020 06:13:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k11sm9771892wrd.23.2020.07.16.06.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 06:13:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 190E11FF7E;
 Thu, 16 Jul 2020 14:13:26 +0100 (BST)
References: <20200715204814.2630-1-robert.foley@linaro.org>
 <20200715204814.2630-2-robert.foley@linaro.org>
 <87blkfwwe4.fsf@linaro.org>
 <CAEyhzFsu9P4y15uSEZj=VgWE+mZKfsUyb2ov3WxG2NzXkuRqfA@mail.gmail.com>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH 1/2] python/qemu: Cleanup changes to ConsoleSocket
In-reply-to: <CAEyhzFsu9P4y15uSEZj=VgWE+mZKfsUyb2ov3WxG2NzXkuRqfA@mail.gmail.com>
Date: Thu, 16 Jul 2020 14:13:26 +0100
Message-ID: <878sfjwqkp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Puhov <peter.puhov@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> On Thu, 16 Jul 2020 at 07:07, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>>
>> Robert Foley <robert.foley@linaro.org> writes:
>>
>> > The changes to console_socket.py and machine.py are to
>> > cleanup for pylint and flake8.
>> >
>> > Signed-off-by: Robert Foley <robert.foley@linaro.org>
>> > ---
>> >  python/qemu/console_socket.py | 58 +++++++++++++++++------------------
>> >  python/qemu/machine.py        |  7 +++--
>> >  python/qemu/pylintrc          |  2 +-
>> >  3 files changed, 34 insertions(+), 33 deletions(-)
>> >
>> > diff --git a/python/qemu/console_socket.py b/python/qemu/console_socke=
t.py
>> > index 830cb7c628..6a746c1dbf 100644
>> > --- a/python/qemu/console_socket.py
>> > +++ b/python/qemu/console_socket.py
>> > @@ -1,12 +1,9 @@
>> <snip>
>> > @@ -103,7 +104,6 @@ class ConsoleSocket(asyncore.dispatcher):
>> >
>> >      def set_blocking(self):
>> >          """Maintain compatibility with socket API"""
>> > -        pass
>>
>> Hmm shouldn't this be with the change in 2/2 because I thought you
>> needed a "pass" for an empty function in python?
>
> Thanks for the review !
>
> Sure, I can move this change to 2/2.  Probably makes more sense there
> since we're changing this function there too.
>
> This change was one of the suggestions from John Snow.
> He pointed out that the pass is not needed here since the docstring takes
> the role of the function body.

Ahh I did not know you could do that... I'll defer to John's superior
python knowledge.

>
> Thanks & Regards,
> -Rob
>
>>
>> Otherwise:
>>
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>
>> --
>> Alex Benn=C3=A9e


--=20
Alex Benn=C3=A9e

