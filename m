Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544ACFA372A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 14:57:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F85F2168B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 14:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QccqydRA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F85F2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKkju-00025r-7i
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 10:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sameid@google.com>) id 1iKkie-00017Q-JV
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 10:56:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sameid@google.com>) id 1iKkid-0001dy-5w
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 10:56:08 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:36946)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sameid@google.com>) id 1iKkic-0001dP-Vj
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 10:56:07 -0400
Received: by mail-qk1-x742.google.com with SMTP id u184so23037642qkd.4
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 07:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=dfp8L3nouDYieNJVQrEwYO4HfGZQ1AqGijWA3X7v9BE=;
 b=QccqydRAfzyTca/0TzK//H1g578NI3aHdtnkySVqm4Mn3YouZEiKxpF/5al9XTeiy7
 2tuMEXvxrj0MVZQGh3T2DfKm50rekd2tEuNTdgStW/lh7GOJsFf2qzQEHmK9FvWmyKby
 71oEb774iuli5GLL3b0bsm55fMXPJNhd7xk0CqEOe5cWZR06wlzpcSz0BpVM2FfTl+8T
 6iUKP70aw89GLimn1TU5D6N52GmF4KJV0zf20mMqsZQBbKK0vTIzfvZrdegTfjmvrfsv
 QC+sw7cOUhxnVD5yqdh/gP5mtzRtzcw+A3pO0jV5d8o6g7Gzi6J3darW7viGRBrQdylw
 Dqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dfp8L3nouDYieNJVQrEwYO4HfGZQ1AqGijWA3X7v9BE=;
 b=RpVxeFq+aaOWGBDmZO2ksmE+DtUqLToYrcUmjKIAgfxcNsWmJ2Dd98yOPDa7GViFfY
 /sp71S0WB1cGoVpoMbOOFWjWziqAvn2xI21DITKFtDtpA+PbTEGEqfGJfRFmXqTX94fO
 DqWER4aqslCOGOhntwX4NeaS+tRMIZo3bgHiVhk8ZejOHNwHENxFtkfiLBR14iYbN5I9
 3oAHOdxE6rmRQbubaFAdME1MN4T8ExvvWgp5+OLOt2R5GqUsCix4eQHMzWPYgcc4mUe9
 UR43xE5ZOav77J/IcQpj78cSKcaxFdJay58bq8ozk6qEBOQmSSxpUilLFZYwbdyZGj63
 oAJg==
X-Gm-Message-State: APjAAAVoHwvOMLVbFrSv0hpep3s89RTO40H5OzxGe2wqSnu5FAl3bMeo
 fc5nHTc3CYK1ecPEtQXqAk+WoBcD7otycHudzJDL8Q==
X-Google-Smtp-Source: APXvYqzHMPRrxSaeWKEh9/Cem2c40WwsGCYVyBdTjiFzkExPw/7asuAkKOBbfyktrhYAVUIdyAR8bTVvh/pLhrv45p8=
X-Received: by 2002:a37:93c4:: with SMTP id
 v187mr19634871qkd.490.1571237765718; 
 Wed, 16 Oct 2019 07:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190925110639.100699-1-sameid@google.com>
 <20190925110639.100699-8-sameid@google.com>
 <ffff9a59-3cbf-8b04-f4e5-8a01dad8d381@redhat.com>
 <7dc7b14c-8e89-4851-6d05-d69b1bf36e3e@redhat.com>
 <92b719a7-3838-b019-cd51-5f5b2120a431@redhat.com>
 <1d863ce2-0e45-63e4-ceb2-d2eb2d9aa03a@redhat.com>
 <CAFr6bU=2B9JcmfJZ25BTYkhnw2V+YAghyAyK9YHto18KRptPAg@mail.gmail.com>
 <1dc0c7cd-cf9f-0c33-04f5-ed8d89119c9f@redhat.com>
 <CAFr6bUnsxhqBqHgRdw3dtv0rEvfCVn0oM4XD8Vb1xv_UGKvepg@mail.gmail.com>
 <CAFr6bUm53A+gBVBRr00XKDkt=GiJ5QSOEEXPFfuUJ2PcLeG04w@mail.gmail.com>
 <bf6ff260-f8ca-a593-dd3e-e78fa0551101@redhat.com>
 <eb3cc776-b8d9-f8da-269a-2fc0f8c21662@redhat.com>
In-Reply-To: <eb3cc776-b8d9-f8da-269a-2fc0f8c21662@redhat.com>
From: Sam Eiderman <sameid@google.com>
Date: Wed, 16 Oct 2019 17:55:54 +0300
Message-ID: <CAFr6bUkQZP7ks4odRBpKGOSrzwe2VWSD47JGBUx-DuwBVNOmiA@mail.gmail.com>
Subject: Re: [SeaBIOS] Re: [PATCH v7 7/8] bootdevice: FW_CFG interface for
 LCHS values
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, 
 kwolf@redhat.com, qemu-block@nongnu.org, arbel.moshe@oracle.com, 
 seabios@seabios.org, kraxel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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

Thanks for the detailed comment Laszlo,

Indeed my e-mail has changed and I only received replies to the
commits where I added this new mail in the S-o-b section, should of
added in all of them.

So as you said it, the problem was actually in using qfw_cfg_get_u32
which assumes the value is encoded LE and has an additional
le32_to_cpu, should have used qfw_cfg_get directly like
qfw_cfg_get_file does.

Regarding qfw_cfg_get_file - I wrote this code when this function did
not exist yet, I think it was added 6 months ago. In any case, I will
use it instead.

Thanks for this.

I will resubmit this entire commit series:
* I will only change code in the last commit (tests)
* I will remove a comment which is now not true anymore
* I will add my new email in S-o-b

Sam


On Wed, Oct 16, 2019 at 3:29 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 10/16/19 2:14 PM, Laszlo Ersek wrote:
> > Hi Sam,
> >
> > On 10/16/19 13:02, Sam Eiderman wrote:
> >> Gentle Ping,
> >>
> >> Philippe, John?
> >>
> >> Just wondering if the series is okay, as Gerd pointed out this series
> >> is a blocker for the corresponding changes in SeaBIOS for v 1.13
> >
> > The QEMU series is still not merged, due to a bug in the last patch
> > (namely, the test case, "hd-geo-test: Add tests for lchs override").
> >
> > To my knowledge, SeaBIOS prefers to merge patches with the underlying
> > QEMU patches merged first, so you'll likely have to fix that QEMU issue
> > first.
> >
> > I explained the bug in the QEMU test case here:
> >
> >    http://mid.mail-archive.com/6b00dc74-7267-8ce8-3271-5db269edb1b7@red=
hat.com
> >    http://mid.mail-archive.com/700cd594-1446-e478-fb03-d2e6b862dc6c@red=
hat.com
>
> Yes, I was expecting a respin with find_fw_cfg_file() fixed per Laszlo
> detailed review.
>
> > (Alternative links to the same:
> >
> >    https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg01790.html
> >    https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg01793.html
> > )
> >
> > I've never received feedback to those messages, and I think you must
> > have missed them.
> >
> > FWIW, when I hit "Reply All" in that thread, you were on the "To:" list
> > with:
> >
> >    Sam Eiderman <shmuel.eiderman@oracle.com>
> >
> > but here you are present with
> >
> >    Sam Eiderman <sameid@google.com>
> >
> > In addition, when I posted those messages, I got the following
> > auto-response ("Undelivered Mail Returned to Sender"):
> >
> >> This is the mail system at host mx1.redhat.com.
> >>
> >> I'm sorry to have to inform you that your message could not
> >> be delivered to one or more recipients. It's attached below.
> >>
> >> For further assistance, please send mail to postmaster.
> >>
> >> If you do so, please include this problem report. You can
> >> delete your own text from the attached returned message.
> >>
> >>                     The mail system
> >>
> >> <shmuel.eiderman@oracle.com>: host
> >> aserp2030.oracle.com[141.146.126.74] said:
> >>      550 5.1.1 Unknown recipient address. (in reply to RCPT TO command=
)
>
> That explains it :)
>
> >
> > I didn't know your new address, so I could only hope you'd find my
> > feedback on qemu-devel.
> >
> > Thanks
> > Laszlo
> >

