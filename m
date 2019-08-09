Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B34DC31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 14:06:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64A13214C6
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 14:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AA7NbbDn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A13214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw5X6-0000uD-Kl
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 10:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36912)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hw5Wg-0000T5-Fk
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 10:05:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hw5We-0003gf-RW
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 10:05:50 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38801)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hw5We-0003fp-ER
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 10:05:48 -0400
Received: by mail-ot1-x344.google.com with SMTP id d17so133117818oth.5
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 07:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PK07rtoRd29iBm3MDbBdD8LwU4USbY876PkGkfX4+lY=;
 b=AA7NbbDnl8Xek31fcJhgAsi2YsgIBs/ENdrJHL9ENRERqS0HdGHr+owh7/Q8v5+vnt
 vZG6IaocfHO3et95gRzCrNNrMJOr1mh5nYG2PMAZJ1JNjn171KFQ0JYI59y4cCGz3XjZ
 B5iTLC3SSsQXOMcx8oCKmtvQ/xoamTLJOg00/xGdTDBk6g/Le2tPsdrfJg0eHqUNdb/R
 rDDFXMVW1rG98297f+V9JEsyfYQwlrFq2f9Hn/2OVNZ0ndiPJjas9Cu9WTv0sWRiFCF/
 SWqvilqIHpvc7sdCOlllGQE/u3n/VS8KQ3OFG2VejyacXaZZO6aRrR+g9a2E3/StgSnE
 QRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PK07rtoRd29iBm3MDbBdD8LwU4USbY876PkGkfX4+lY=;
 b=sZtzVahLhWgrn8unkDnAVxP0lrhbn+f0VYRq4Io1hRUYPbsJM1PgUrXt3UtA+fTFBk
 f+5zFzeTJ8eYI2LHmaPqf6BDLDUBmzORArxpV/YmLWcXeFeJ/ibtgcqVuwvojGNEwYAK
 k3Tcwvr7I62Q/mBBkul4rLgOeXvsLhwk08TNa0oVWm16QhYHvtwYfl3ouVXOurqhDgwb
 ex1k6DZGqgX8p/N05s67FT3PydBNOdDFP29IWl/fqZPZ5Ok5XUbyFwX43Ec9johXvT4F
 rrQg8uA2X10Zb1ReXn/K7RbAw4OOkLM3PZLu+DWXW84eEH7BtWa2h7370x0yeRCu3pfM
 5Wcw==
X-Gm-Message-State: APjAAAXwC26tLeWAUQ8cmWmE0faIRDLhFiEYZHmq1YTD3JA8o7tiw573
 YJ4+K5A74td3q5L9rDTbTINZzYRL12BYCgrhUvo=
X-Google-Smtp-Source: APXvYqyx19/dAKIrQvtaqYDyZs8u/tALAL2APcaXoeghH0GJtdQAu9a+/3epYTx6hJktKE1zK1iC0NdWv6y1I4Q/e2Y=
X-Received: by 2002:aca:b254:: with SMTP id b81mr6805877oif.53.1565359547609; 
 Fri, 09 Aug 2019 07:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <87r25vd5y1.fsf@dusky.pond.sub.org>
 <CAFEAcA-3X0s-mxaD27HWQa7ysiEb6Uo-BD+Yxo0QhBV_yb9WLA@mail.gmail.com>
 <CAFEAcA-e2aW33GeuganVSnu9epuqt57rnZ_KgEHwDNqrWrTHuA@mail.gmail.com>
 <20190809133514.GF13660@redhat.com>
In-Reply-To: <20190809133514.GF13660@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 9 Aug 2019 16:05:36 +0200
Message-ID: <CAL1e-=g6LPH318p2ocUtrt+0P32nnyg8q1+Ko-KYHmrxuEVsxg@mail.gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] Does i386-linux-user build on an i686 host?
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <Laurent@vivier.eu>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 9, 2019 at 3:35 PM Daniel P. Berrang=C3=A9 <berrange@redhat.com=
>
wrote:

> On Fri, Aug 09, 2019 at 01:49:07PM +0100, Peter Maydell wrote:
> > On Fri, 9 Aug 2019 at 13:22, Peter Maydell <peter.maydell@linaro.org>
> wrote:
> > >
> > > On Thu, 8 Aug 2019 at 16:37, Markus Armbruster <armbru@redhat.com>
> wrote:
> > > >
> > > > Fails for me, but perhaps I'm doing it wrong:
> > >
> > >
> > > > NOTE: cross-compilers enabled:  'cc'
> > > > $ make
> > > >   CC      i386-linux-user/linux-user/syscall.o
> > > > /home/armbru/qemu/linux-user/ioctls.h:306:9: error:
> =E2=80=98SNDCTL_DSP_MAPINBUF=E2=80=99 undeclared here (not in a function)
> > > >    IOCTL(SNDCTL_DSP_MAPINBUF, IOC_R,
> MK_PTR(MK_STRUCT(STRUCT_buffmem_desc)))
> > > >          ^
> > > > /home/armbru/qemu/linux-user/syscall.c:5023:23: note: in definition
> of macro =E2=80=98IOCTL=E2=80=99
> > > >      { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
> > > >                        ^
> > > > /home/armbru/qemu/linux-user/ioctls.h:307:9: error:
> =E2=80=98SNDCTL_DSP_MAPOUTBUF=E2=80=99 undeclared here (not in a function=
)
> > > >    IOCTL(SNDCTL_DSP_MAPOUTBUF, IOC_R,
> MK_PTR(MK_STRUCT(STRUCT_buffmem_desc)))
> > > >          ^
> > > > /home/armbru/qemu/linux-user/syscall.c:5023:23: note: in definition
> of macro =E2=80=98IOCTL=E2=80=99
> > > >      { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
> > > >                        ^
> > > > /home/armbru/qemu/linux-user/ioctls.h:362:9: error:
> =E2=80=98SOUND_MIXER_ACCESS=E2=80=99 undeclared here (not in a function)
> > > >    IOCTL(SOUND_MIXER_ACCESS, 0, TYPE_PTRVOID)
> > > >          ^
> > > > /home/armbru/qemu/linux-user/syscall.c:5023:23: note: in definition
> of macro =E2=80=98IOCTL=E2=80=99
> > > >      { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
> > > >                        ^
> > >
> > > We expect these to be provided by the system's "linux/soundcard.h".
> > > For my Debian system that's provided by the linux-libc-dev package,
> > > but I imagine you have that installed or you wouldn't have got
> > > this far in the configure/compile process...
> >
> > Further investigation shows that this is because the system has
> > the 'oss4-dev' package installed, which diverts
> /usr/include/linux/soundcard.h
> > and installs its own version which doesn't provide all the symbols
> > that the kernel one does.
> >
> > Easy fix: uninstall oss4-dev.
>
> Perhaps also make 'configure' exit with an error if it detects the
> broken soundcard.h ?
>
>
Daniel, it looks to me that this is too drastic. Only applicable ioctl
support
could be removed for such case, QEMU is otherwise fine.

Yours,
Aleksandar



> > Better fix: patch QEMU to provide its own versions of these constants
> > if the system headers don't.
> >
> > Utopian fix: I've wondered occasionally whether for cases like this
> > where the constant is known to be the same for the host and the guest
> > we should have some sort of approach which lets us use the QEMU
> > copies of the linux kernel headers rather than having to rely on
> > the host system, which might have an older version that restricts
> > us unnecessarily on what we could support...
> >
> > Issue previously reported in 2016:
> > https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg01421.html
> >
> > thanks
> > -- PMM
> >
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>
