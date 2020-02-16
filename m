Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CF1C2BA83
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 16:35:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5343B20659
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 16:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnllPJWy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5343B20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3Mso-0007tS-Hh
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 11:35:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j3Mre-0006LF-KC
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 11:33:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j3Mrd-0006Xg-4Z
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 11:33:50 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46266)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j3Mra-0006Su-41; Sun, 16 Feb 2020 11:33:46 -0500
Received: by mail-ot1-x343.google.com with SMTP id g64so13757401otb.13;
 Sun, 16 Feb 2020 08:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=jjiOrwJRRAMj7gIfQJhT4gzUmxZsbZHIt0MGEMIWTAY=;
 b=QnllPJWyFue6qsWs5dueBN8+AwLweKv/j16ftKkxRiV+fjVgMgKOtk9lT5Aikhwlul
 k3PCNRAgIw52orFA8GuDp6LcAzJdIoMUhJByTdmeIZzrmFY0i2akzcpkSiy/3wCnr9AY
 6Mg3V/siNKNKWxE3qkEzokw7ByUdveTZVXnj0GtQhrwYb/dRKJzF3WFlNYVAu+2VbgTJ
 0OLnDbC053cpaX/HcO4eJUCr+UuUUzy5IeRddU+B2dAeAAMeDYZDDEV5XU9akc/Pr6gR
 SmbQbXL+EpJeLdqnNcsxsVN4Yk5vwLv3zziDoQWja2PO5jZZ3mfzcLIlwq4cWajBVqy3
 eRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=jjiOrwJRRAMj7gIfQJhT4gzUmxZsbZHIt0MGEMIWTAY=;
 b=sKAbYQXAY6HuqyD2dFLWQ1D/E9dSHgt0ZQkogENw+F8eYWBMd5xNQMVjqCwFV+r3Ch
 WfVqOo2esvPmU2lPrqCpvjKKrfD8rjZ5pfHcILr0DvsR6igKjsKVvyJvSaWyxTeHlYUL
 gPVvR3aYJHob3xrQPR2xYcJaAcnwLAid3Dx5095nQgBVDyLwBU1m2N0t33KZNBMPoTzB
 suv5M5SP2EYg62iQ9sIXciSLvFaXlaqAQkrM716SbEsndRjSdwk2kL0xX8lGo5bwDcWv
 3gulSuNik2gcqRzm55H7IVOSxiVf0pg6zgojAGi4mIoYjBZYq2OS9Xj1K7H5svzfI2FO
 uMDQ==
X-Gm-Message-State: APjAAAU0E9pWCGezHtQPr8G1a8C32uJ7kg0nq4wuzq60VoUKBjqvzpW3
 q7PsxGXvYfWsMc+xynNliafzJuFuG0iVtSLgFdw=
X-Google-Smtp-Source: APXvYqyIp5Cqk5i1fM49BBWskn92JhX8OJlDZ1akx4W5lwgl8krMX2FfdJvqeNSeFZ+it/cKeM2ZS2OxuErpUilvaxY=
X-Received: by 2002:a05:6830:1e76:: with SMTP id
 m22mr3938941otr.295.1581870824880; 
 Sun, 16 Feb 2020 08:33:44 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Sun, 16 Feb 2020 08:33:44 -0800 (PST)
In-Reply-To: <ba671393-7960-1234-6c40-9a8ce29e108a@redhat.com>
References: <20191221155306.49221-1-jhogan@kernel.org>
 <CAAdtpL7CrEAZz5GWJoYCegchQ=-hdkcih07icgoFd-ghJ3nMBw@mail.gmail.com>
 <CAL1e-=jdpp2W-B1cERU4srRQUkPTjewM3hVrndoh4nr-vPSRGA@mail.gmail.com>
 <20200216065717.GA145683@jamesdev>
 <ba671393-7960-1234-6c40-9a8ce29e108a@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 16 Feb 2020 17:33:44 +0100
Message-ID: <CAL1e-=hOAs3xmpcyKz2cMQhGaW1J-PntuA9RmHb94vQgc31ttg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Orphan MIPS KVM CPUs
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000990197059eb400de"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>,
 Paul Burton <paulburton@kernel.org>, QEMU Trivial <qemu-trivial@nongnu.org>,
 James Hogan <jhogan@kernel.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000990197059eb400de
Content-Type: text/plain; charset="UTF-8"

On Sunday, February 16, 2020, Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 16/02/20 07:57, James Hogan wrote:
> >> We are in the process of handling this within the company, and this
> >> patch should go via MIPS tree, not trivial tree - will be updated when
> >> the opinions are crystallized, and all consultations with others were
> >> done. There is no rush.
> > Hi Aleksandar,
> >
> > I respectfully disagree. In the mean time I am still listed as
> > maintainer even though this patch has reflected reality for more than 18
> > months since the 2018 closure of the MIPS UK offices.
> >
> > If "the company" wish to eventually crystalize their opinion and assign
> > someone else this role (which they've had at least 6 weeks to do even
> > since I sent the patch) they can always submit a new patch.
> >
> > In the mean time I'd appreciate if somebody could take the patch ASAP.
>
> I agree with James, the situation has already crystallized long before
> the opinions will have.  You have done excellent work on the TCG side,
> but neither the kernel nor the QEMU side of KVM have seen any
> significant activity.  If your employer becomes more interested in KVM
> then the status can be changed.
>
> I think it's okay if we delay the patch a couple weeks more (which is
> more or less when Laurent or I will send the next pull request), but
> certainly not past 5.0 soft freeze.
>
>
OK, I will add the patch in the next MIPS queue, since I think its
significance is more than trivial. It will be sent no later than two weeks
from now. I just wanted the patch to be in the same queue when we will
provide replacement. But, honestly, if the factual state lasted that long,
I don't see the reason for such sudden hurry, do you?

I do not act alone (as an independant person) in this community, I
represent the company I am working for (in this case Wave, the owner of
MIPS), and of course I need from time to time to consult other people,
which takes some tome sometimes. Most of you are, I guess, in the same
situation from time to time.

Of course I respect James' decision, although I am trully sorry about it.
My only slight objection is that James should have sent this patch sooner,
rather than just leave an impression that there is a maintainer, while in
fact there wasn't. What did you wait? But, never mind, I understand your
hesitation. The best outcome would be that James remained in that role (I
do remember him as an excellent, thorough engineer, that is approachable
and very helpful to others), but what can we do now. I wish we work
together in future, who knows? Thanks, James, for taking care of KVM for
MIPS for number of years!

Thanks to all too,
Aleksandar




> Thanks,
>
> Paolo
>
>

--000000000000990197059eb400de
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Sunday, February 16, 2020, Paolo Bonzini &lt;<a href=3D"mailto:p=
bonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">On 16/02/20 07:57, James Hogan wrote:<br>
&gt;&gt; We are in the process of handling this within the company, and thi=
s<br>
&gt;&gt; patch should go via MIPS tree, not trivial tree - will be updated =
when<br>
&gt;&gt; the opinions are crystallized, and all consultations with others w=
ere<br>
&gt;&gt; done. There is no rush.<br>
&gt; Hi Aleksandar,<br>
&gt; <br>
&gt; I respectfully disagree. In the mean time I am still listed as<br>
&gt; maintainer even though this patch has reflected reality for more than =
18<br>
&gt; months since the 2018 closure of the MIPS UK offices.<br>
&gt; <br>
&gt; If &quot;the company&quot; wish to eventually crystalize their opinion=
 and assign<br>
&gt; someone else this role (which they&#39;ve had at least 6 weeks to do e=
ven<br>
&gt; since I sent the patch) they can always submit a new patch.<br>
&gt; <br>
&gt; In the mean time I&#39;d appreciate if somebody could take the patch A=
SAP.<br>
<br>
I agree with James, the situation has already crystallized long before<br>
the opinions will have.=C2=A0 You have done excellent work on the TCG side,=
<br>
but neither the kernel nor the QEMU side of KVM have seen any<br>
significant activity.=C2=A0 If your employer becomes more interested in KVM=
<br>
then the status can be changed.<br>
<br>
I think it&#39;s okay if we delay the patch a couple weeks more (which is<b=
r>
more or less when Laurent or I will send the next pull request), but<br>
certainly not past 5.0 soft freeze.<br>
<br></blockquote><div><br></div><div>OK, I will add the patch in the next M=
IPS queue, since I think its significance is more than trivial. It will be =
sent no later than two weeks from now. I just wanted the patch to be in the=
 same queue when we will provide replacement. But, honestly, if the factual=
 state lasted that long, I don&#39;t see the reason for such sudden hurry, =
do you?</div><div><br></div><div>I do not act alone (as an independant pers=
on) in this community, I represent the company I am working for (in this ca=
se Wave, the owner of MIPS), and of course I need from time to time to cons=
ult other people, which takes some tome sometimes. Most of you are, I guess=
, in the same situation from time to time.</div><div><br></div><div>Of cour=
se I respect James&#39; decision, although I am trully sorry about it. My o=
nly slight objection is that James should have sent this patch sooner, rath=
er than just leave an impression that there is a maintainer, while in fact =
there wasn&#39;t. What did you wait? But, never mind, I understand your hes=
itation. The best outcome would be that James remained in that role (I do r=
emember him as an excellent, thorough engineer, that is approachable and ve=
ry helpful to others), but what can we do now. I wish we work together in f=
uture, who knows? Thanks, James, for taking care of KVM for MIPS for number=
 of years!</div><div><br></div><div>Thanks to all too,</div><div>Aleksandar=
</div><div><br></div><div><br></div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">
Thanks,<br>
<br>
Paolo<br>
<br>
</blockquote>

--000000000000990197059eb400de--

