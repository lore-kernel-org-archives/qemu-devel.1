Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10809C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 19:25:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D03962068F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 19:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a83/ebG3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03962068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXs5C-0002xz-0F
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 14:25:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iXs46-0000YH-47
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 14:24:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iXs44-0007mG-Mc
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 14:24:29 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43669)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iXs44-0007lG-I6
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 14:24:28 -0500
Received: by mail-ot1-x344.google.com with SMTP id l14so3966458oti.10
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 11:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=J2kzxGLp/1FxxdzbLEhjibieFyFLnQTNg6gLOCmTn2E=;
 b=a83/ebG37rfW4VDrgC+teobHEXsVE2m+bnRxh+HboPwdyNv7zvAFWykCYbw79REYZb
 fGEIJuFMWhrmdLcUSDP0W/LGroxhKu9epFQ4TaufA1bZ6hoYbeC1/9p+MniheFiOblWq
 DVffhG14hbfgRimwwNicfRLBmNkeoAa/BsKtrT4u3Yt2EddeFHZa7dKZqnicNpl9swU2
 76WeZkRSCJxhja1EHxMg0fHdASdkcjSF0VWQ16kikWSEWoXb/kNhBH5HXTgaQ43aJt8j
 COESBiKzWUFEIiVBdAaZT5jCqM/SSu8nivn6cUmulDVOzgC20KZPVXac462zcX5Jh8UY
 oPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=J2kzxGLp/1FxxdzbLEhjibieFyFLnQTNg6gLOCmTn2E=;
 b=nk5swELbX+zvRrVKafSK2pyHbXeF1Q5pTHAc698e1c5xmp11AsZlYQHZe/blGwj7KK
 EDTj527VljV+JUcL4OHOSVR4R1UmqgtZFzDxnyHO729obZChToL9FkK8YNAr89Bvf8XS
 JJXVKkFw1+5gESyeVMDChbL9xl10v6iWtlhZaVUkVB1lLVx2pegDkSigIXRZZGj3YfvZ
 5myzzwljBXfGdm1R/8Nq8arG2HygvkNVvlZ0goSXbOzj4/J+yVRh2xphX4hc9LN/Z3H4
 ff9wYPoChu0JsUavswWtVdo8a7RRBSMuaJczLuYC/FEy1/PX2LQFW5qmLKBjXzubT5q1
 HQKA==
X-Gm-Message-State: APjAAAVy8b+gpBn7Kh+BlBeZXJSIUsjlJOUaqBQrRNkGVv0dElR59n4E
 5jwmbkWhbVsIg9qJWHI6TSqviLTDFOoM4whfR3Y=
X-Google-Smtp-Source: APXvYqxUL6HdbjhUqb/3oR0MQM404GJo6XOM7mqUOaHrZC2Yl7Y4qAmDPCiltKasDtsTCL9pszfkRHAOLz/JZYTIDlY=
X-Received: by 2002:a9d:3d05:: with SMTP id a5mr8358454otc.295.1574364266491; 
 Thu, 21 Nov 2019 11:24:26 -0800 (PST)
MIME-Version: 1.0
References: <20191120145724.GA15677@ls3530.fritz.box>
 <CAL1e-=jqoV0v0NdpeL3NUTOfURNJ9qmD6FcCjV30pXsdBeCD=Q@mail.gmail.com>
 <CAL1e-=gOHZOTnyB0=HOAqzqS4gBF1YkB7x3yQYGJvi5qWg20Kg@mail.gmail.com>
 <015ab947-57ba-6d73-d99d-2e3263226c02@gmx.de>
 <f7f4ff93-fad0-3d72-a224-c19302dff9e0@redhat.com>
 <CAL1e-=hHFfkJ3bmOLhk5bBCExvnazA4NgmoCJtN+X3KQ8=9Pjw@mail.gmail.com>
 <32d6aa36-3240-7a80-89c1-5cba13bbc022@redhat.com>
 <CAL1e-=hDgLB-n2aOdB_ZOnVC0f3x3SGvQDUCcBWSobme7JSV4Q@mail.gmail.com>
 <e0a8faac-b02a-2787-20a3-97f451c9d798@redhat.com>
 <68fbd118-a456-ee41-5c19-9d9112f32ddd@gmx.de>
In-Reply-To: <68fbd118-a456-ee41-5c19-9d9112f32ddd@gmx.de>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 21 Nov 2019 20:24:15 +0100
Message-ID: <CAL1e-=hg=Dh32VuGb1Qge757mZBvcEMoZogZscMzEQBTAm3rwQ@mail.gmail.com>
Subject: Re: [PATCH v2] linux-user/strace: Improve output of various syscalls
To: Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 21, 2019 at 8:12 PM Helge Deller <deller@gmx.de> wrote:
>
> On 21.11.19 19:23, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 11/21/19 6:35 PM, Aleksandar Markovic wrote:
> >> On Thursday, November 21, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@re=
dhat.com <mailto:philmd@redhat.com>> wrote:
> >>
> >>     On 11/21/19 6:00 PM, Aleksandar Markovic wrote:
> >>
> >>         On Thursday, November 21, 2019, Philippe Mathieu-Daud=C3=A9
> >>         <philmd@redhat.com <mailto:philmd@redhat.com>
> >>         <mailto:philmd@redhat.com <mailto:philmd@redhat.com>>> wrote:
> >>
> >>              On 11/21/19 9:19 AM, Helge Deller wrote:
> >>
> >>                  On 20.11.19 23:20, Aleksandar Markovic wrote:
> >>
> >>                      On Wed, Nov 20, 2019 at 10:13 PM Aleksandar Marko=
vic
> >>                      <aleksandar.m.mail@gmail.com
> >>         <mailto:aleksandar.m.mail@gmail.com>
> >>                      <mailto:aleksandar.m.mail@gmail.com
> >>         <mailto:aleksandar.m.mail@gmail.com>>> wrote:
> >>
> >>
> >>                          On Wed, Nov 20, 2019 at 3:58 PM Helge Deller
> >>                          <deller@gmx.de <mailto:deller@gmx.de>
> >>         <mailto:deller@gmx.de <mailto:deller@gmx.de>>> wrote:
> >>
> >>
> >>                              Improve strace output of various syscalls=
 which
> >>                              either have none
> >>                              or only int-type parameters.
> >>
> >>
> >>                          It would be nice if you included a history of
> >>         the patch
> >>                          (after the line
> >>                          "---", as it is customary for single patch
> >>         submission).
> >>                          You changed
> >>                          only ioctl() in v2, right?
> >>
> >>
> >>                  Yes. Will add history in next round.
> >>
> >>                          I missed your v2, but responded with several
> >>         hints to v1.
> >>
> >>
> >>                  Yes, I saw all your mails.
> >>                  Thanks for your feedback!
> >>
> >>                      userfaultfd(), membarrier(), mlock2()... - all co=
uld be
> >>                      included into
> >>                      your patch.
> >>
> >>
> >>                  I think there are quite some more which I didn't incl=
uded.
> >>                  That's why I wrote "*various*" and not "*all*" in my
> >>         changelog.
> >>                  I'm debugging other code, and the ones I fixed are th=
e
> >>         ones I
> >>                  actually tested with my code.
> >>
> >>
> >>              If you don't have handy way to test the other syscalls,
> >>         I'll rather
> >>              restrict your patch to the one you tested, at least you a=
re
> >>         certain
> >>              you didn't introduced regressions. Unless their
> >>         implementation is
> >>              trivial, of course.
> >>
> >>
> >>         What can be handier than writing a program that contains a
> >>         single system call?
> >>
> >>
> >>     Ahah very easy indeed :) Not noticing it shows how busy I am with
> >>     firmware world than I forgot linux-user can be a simpler/powerful
> >>     way to easily test stuff, as the Hexagon recent port also demonstr=
ated.
> >>
> >>
> >> Hexagon port doesn't have anything to do with this patch and didn't de=
monstrate anything new wrt linux-user. I have no idea what you meant to say=
.
> >
> > I simply meant to say, if your port can run linux-user binaries, it sim=
plifies a lot the testing/coverage.
> >
> > Hexagon is simpler to test than AVR.
> >
> >> But, OK, Helge is the submitter, and he decides on the scope of his
> >> patch. I am fine if he wants to limit it only to handful of
> >> syscalls. I just hinted he could increase the vslue of the patch
> >> significantly in an easy way.
> Aleksandar, I really appreciate your feedback, but for now I'd like
> to limit my patch to the currently implemented functions.
> If you look in the file history you will find other submissions of
> this type from me, so I'm sure I will follow up with further patches.
> But right now I'm missing the time.
> So, if it could be applied as is, it's a step forward for now.
> I'll send a v3 patch shortly.
>

Sure, I already said that I would certainly agree with that.

However, I can't agree in a similar fashion with your another patch on
signal names. This is since that patch in its present state puts MIPS
in an inferior position.

Yours,
Aleksandar

> Helge

