Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB829C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 22:14:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68EA9218FF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 22:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwK38P9r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68EA9218FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiR2R-0005ee-4I
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 18:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40298)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chmeeedalf@gmail.com>) id 1hiR0J-0004dH-UG
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 18:12:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chmeeedalf@gmail.com>) id 1hiR0G-0002XM-0M
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 18:11:59 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:42117)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chmeeedalf@gmail.com>)
 id 1hiR0B-0002JB-SW; Tue, 02 Jul 2019 18:11:52 -0400
Received: by mail-io1-xd44.google.com with SMTP id u19so1124ior.9;
 Tue, 02 Jul 2019 15:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6/3+JIM0dJfYGGhXrslEMCOhxScIW9BNjGWdfOLEOhM=;
 b=UwK38P9rHUXXFsgTipfJ0w4KSCtqtddOgdaAkN6n/scds/WeYPpGGvfgtAWhpvqdNY
 phq+OGumMVrr0SNbG8RjDO4hyWnCmw0XjVfZ1C3Svym/kkfaTrry+5Equ697X3QlvXD5
 KbnOOw3BwCQhnzBnQCagdQGnazg4/a6tcy/0MY/10FruRQTEnnjt+1aqWKFDFyGjvZI5
 hQsBGSzVJiY/hgIZEnnoe4XPdlvcfQ6OPzdXeyoWY55XodBp+s627hvZDTzPf1zpXFhJ
 nIAqeHkFRvY+9DIbJWDV5IKGD0Vzz97pTWI3ASlkrpoaSBv/wU2tKLUc+EzRsnTKc/QR
 4a5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6/3+JIM0dJfYGGhXrslEMCOhxScIW9BNjGWdfOLEOhM=;
 b=ZSuZUl1ufBSyw6bdYVPzUXMNE/YEokrnRJgQzGnvJJ9ySvzhiMixjFiQH7/HrVGCFk
 gBd4sSlPBuGoPxfVn1OMOASRstgXFVTsxDIJogeqWCVQLdfDCfLwwdDG4I6ou+3ty15E
 E/Miaw1L2M3yBctNOtai9uTUVEGM74MxhBRolWrNsCdCP7mbswHqq/BeuczfewUCz4KD
 2sPxO8AUL8MN7+aVYmEyga4rD2T8X5ucr+QyMqt6RjkNhfbZgEWoIOXINjMh76xzONs1
 n6NqnTPo4WdejreSz6z1TFS7IRDjt6hDVM++RAfK6BltzBWS0DwpZ3qPmmqqCfjILmX+
 sBsg==
X-Gm-Message-State: APjAAAXuVhSxBj8FrnTFGB9qITiUrkRJ4Jm6Gj9+4zLTsB9PCI7/AvRT
 5B4uo9iS8DFYZTiOFQfD6pUPdSrj
X-Google-Smtp-Source: APXvYqx6YIREpKPI5Ym/qL6XXaD8xltQ9qLFgqDzoi8gwzhYy4Gr+IcsEYytsTK9/TEeTtp/Qaajnw==
X-Received: by 2002:a6b:6012:: with SMTP id r18mr17487801iog.241.1562105508775; 
 Tue, 02 Jul 2019 15:11:48 -0700 (PDT)
Received: from titan.knownspace (173-25-245-129.client.mchsi.com.
 [173.25.245.129])
 by smtp.gmail.com with ESMTPSA id b20sm180895ios.44.2019.07.02.15.11.47
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 02 Jul 2019 15:11:48 -0700 (PDT)
Date: Tue, 2 Jul 2019 17:11:43 -0500
From: Justin Hibbits <chmeeedalf@gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20190702171143.60d7f047@titan.knownspace>
In-Reply-To: <669c6835-20a6-2a60-f130-ff09b19175a8@vivier.eu>
References: <20190607135653.6ece685d@titan.knownspace>
 <8676232e-917d-44e2-1149-b25f26698a73@vivier.eu>
 <92053c9c-e7bf-76cb-9399-987f4ab31bfb@vivier.eu>
 <20190626113742.6bcd8a26@titan.knownspace>
 <d60f142d-27ef-bfe5-1eb6-cefb22640625@vivier.eu>
 <20190626130414.08940342@titan.knownspace>
 <CAHSQbTCxP09J9NtFiN4UpdXHJZHtTw_F66hfdAS2sM4=E5GHyQ@mail.gmail.com>
 <477ebe22-eddb-41ba-5811-4a70e639a89a@vivier.eu>
 <CAHSQbTCUzR5WiykWGZOH1bvBPWx15_ZA-=7b17c6AnRK4kn3yA@mail.gmail.com>
 <cd0a35ce-1f8c-6718-13d9-7a481e1eeb31@vivier.eu>
 <CAHSQbTDMWXX978oWBvYhh1Uz7CeA1KQGz6+11rqwYv+ZOWyVOw@mail.gmail.com>
 <669c6835-20a6-2a60-f130-ff09b19175a8@vivier.eu>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; powerpc64-portbld-freebsd13.0)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
Subject: Re: [Qemu-devel] [Qemu-trivial] Fix cacheline size retrieval on
 FreeBSD/PowerPC(64)
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
Cc: qemu-trivial@nongnu.org, "Emilio G. Cota" <cota@braap.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 1 Jul 2019 15:17:06 +0200
Laurent Vivier <laurent@vivier.eu> wrote:

> Le 01/07/2019 =C3=A0 15:02, Justin Hibbits a =C3=A9crit=C2=A0:
> >=20
> >=20
> > On Mon, Jul 1, 2019, 03:54 Laurent Vivier <laurent@vivier.eu
> > <mailto:laurent@vivier.eu>> wrote:
> >=20
> >     Le 27/06/2019 =C3=A0 02:15, Justin Hibbits a =C3=A9crit=C2=A0: =20
> >     >
> >     >
> >     > On Wed, Jun 26, 2019, 19:08 Laurent Vivier
> >     > <laurent@vivier.eu =20
> >     <mailto:laurent@vivier.eu> =20
> >     > <mailto:laurent@vivier.eu <mailto:laurent@vivier.eu>>> wrote:
> >     >
> >     >=C2=A0 =C2=A0 =C2=A0Le 27/06/2019 =C3=A0 02:02, Justin Hibbits a =
=C3=A9crit=C2=A0:
> >     >=C2=A0 =C2=A0 =C2=A0>
> >     >=C2=A0 =C2=A0 =C2=A0>
> >     >=C2=A0 =C2=A0 =C2=A0> On Wed, Jun 26, 2019, 13:04 Justin Hibbits =
=20
> >     <chmeeedalf@gmail.com <mailto:chmeeedalf@gmail.com> =20
> >     >=C2=A0 =C2=A0 =C2=A0<mailto:chmeeedalf@gmail.com
> >     ><mailto:chmeeedalf@gmail.com>> > <mailto:chmeeedalf@gmail.com
> >     ><mailto:chmeeedalf@gmail.com> =20
> >     <mailto:chmeeedalf@gmail.com <mailto:chmeeedalf@gmail.com>>>>
> > wrote: =20
> >     >=C2=A0 =C2=A0 =C2=A0>
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0On Wed, 26 Jun 2019 18:47=
:42 +0200
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0Laurent Vivier <laurent@v=
ivier.eu =20
> >     <mailto:laurent@vivier.eu> <mailto:laurent@vivier.eu
> >     <mailto:laurent@vivier.eu>> =20
> >     >=C2=A0 =C2=A0 =C2=A0<mailto:laurent@vivier.eu <mailto:laurent@vivi=
er.eu> =20
> >     <mailto:laurent@vivier.eu <mailto:laurent@vivier.eu>>>> wrote: =20
> >     >=C2=A0 =C2=A0 =C2=A0>
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> Le 26/06/2019 =C3=A0 18=
:37, Justin Hibbits a =C3=A9crit=C2=A0:
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> > On Wed, 26 Jun 2019 1=
8:16:36 +0200
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> > Laurent Vivier <laure=
nt@vivier.eu =20
> >     <mailto:laurent@vivier.eu> =20
> >     >=C2=A0 =C2=A0 =C2=A0<mailto:laurent@vivier.eu <mailto:laurent@vivi=
er.eu>> =20
> >     <mailto:laurent@vivier.eu <mailto:laurent@vivier.eu> =20
> >     >=C2=A0 =C2=A0 =C2=A0<mailto:laurent@vivier.eu <mailto:laurent@vivi=
er.eu>>>>
> >     >wrote: >=C2=A0 =C2=A0 =C2=A0> >=C2=A0 =C2=A0
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> >> Le 26/06/2019 =C3=A0=
 18:14, Laurent Vivier a
> >     >=C3=A9crit=C2=A0: >=C2=A0 =C2=A0 =C2=A0> >>> Le 07/06/2019 =C3=A0 =
20:56, Justin Hibbits a
> >     >=C3=A9crit=C2=A0: >=C2=A0 =C2=A0 =C2=A0> >>>> The attached very tr=
ivial patch fixes a
> >     >startup bug that prevents
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> >>>> at least Qemu 3.1 =
and later from working on
> >     >=C2=A0 =C2=A0 =C2=A0FreeBSD/powerpc64.
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> >>>>
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> >>>> - Justin
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> >>>>=C2=A0 =C2=A0
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> >>>
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> >>> Please don't send a=
 patch in attachment but
> >     >inlined in the message
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> >>> (you may use "git s=
end-email" for that).
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> >>>
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> >>> This patch fixes "u=
til: add cacheinfo" that
> >     >has =20
> >     changed =20
> >     >=C2=A0 =C2=A0 =C2=A0the type
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> >>> from unsigned to lo=
ng.
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> >>>
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> >>> You can add the fol=
lowing line in the commit
> >     >message: >=C2=A0 =C2=A0 =C2=A0> >>>
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> >>> Fixes: b255b2c8a548=
 ("util: add cacheinfo")
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> >>>
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> >>> Reviewed-by: Lauren=
t Vivier
> >     ><laurent@vivier.eu =20
> >     <mailto:laurent@vivier.eu> =20
> >     >=C2=A0 =C2=A0 =C2=A0<mailto:laurent@vivier.eu <mailto:laurent@vivi=
er.eu>>
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0<mailto:laurent@vivier.eu
> >     ><mailto:laurent@vivier.eu> =20
> >     <mailto:laurent@vivier.eu <mailto:laurent@vivier.eu>>>> =20
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> >>>=C2=A0 =C2=A0 =C2=A0
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> >>
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> >> CC: author of b255b2=
c8a548 ("util: add
> >     >cacheinfo") >=C2=A0 =C2=A0 =C2=A0> >>
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> >> Thanks,
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> >> Laurent=C2=A0
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> >
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> > Hi Laurent,
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> >
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> > Sorry.=C2=A0 I had ne=
ver used git send-email before,
> >     >so =20
> >     wasn't =20
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> > comfortable with it.=
=C2=A0 I just updated the commit
> >     >message with your
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> > feedback and used git=
 send-email to submit the =20
> >     patch.=C2=A0 I hope =20
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> > everything went well.=
=C2=A0
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> It seems not. I didn't =
receive it.
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> Did you configure the S=
MTP server. See
> >     >git-send-email(1): >=C2=A0 =C2=A0 =C2=A0>
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 Use gmail =
as the smtp server
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 To use git send-email to send your patches
> >     >through the GMail
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> SMTP server, edit ~/.gi=
tconfig to specify your
> >     >account =20
> >     settings: =20
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 [sendemail]
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smtpEncryption =3D tls
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smtpServer =3D smtp.gmail.com=
 =20
> >     <http://smtp.gmail.com> =20
> >     >=C2=A0 =C2=A0 =C2=A0<http://smtp.gmail.com> <http://smtp.gmail.com>
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smtpUser =3D yourname@gmail.c=
om =20
> >     <mailto:yourname@gmail.com> =20
> >     >=C2=A0 =C2=A0 =C2=A0<mailto:yourname@gmail.com <mailto:yourname@gm=
ail.com>>
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0<mailto:yourname@gmail.com
> >     ><mailto:yourname@gmail.com> =20
> >     <mailto:yourname@gmail.com <mailto:yourname@gmail.com>>> =20
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smtpServerPort =3D 587
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 If you have multifactor authentication
> >     >setup on =20
> >     your =20
> >     >=C2=A0 =C2=A0 =C2=A0gmail
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> account, you will need =
to generate an
> >     >app-specific =20
> >     password =20
> >     >=C2=A0 =C2=A0 =C2=A0for use
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> with git send-email. Vi=
sit
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0
> >     >=C2=A0 =C2=A0 =C2=A0https://security.google.com/settings/security/=
apppasswords
> >     >to >=C2=A0 =C2=A0 =C2=A0> create it.
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Once your commits are ready to be sent to
> >     >the =20
> >     mailing =20
> >     >=C2=A0 =C2=A0 =C2=A0list,
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> run the following comma=
nds:
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 $ git format-patch --cover-letter -M =20
> >     origin/master -o =20
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> outgoing/ $ edit outgoi=
ng/0000-*
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 $ git send-email outgoing/*
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 The first time you run it, you will be
> >     >prompted =20
> >     for your =20
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> credentials. Enter the =
app-specific or your
> >     >regular =20
> >     password as =20
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> appropriate. If you hav=
e credential helper
> >     >configured (see >=C2=A0 =C2=A0 =C2=A0> git-credential(1)), the pas=
sword will
> >     >be saved in the =20
> >     credential =20
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> store so you won=E2=80=
=99t have to type it the next time.
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Note: the following perl modules are
> >     >required Net::SMTP::SSL,
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 MIME::Base64 and Authen::SASL
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> Thanks,
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> Laurent
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>=C2=A0
> >     >=C2=A0 =C2=A0 =C2=A0>
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0Hm, you're right.=C2=A0 E=
ven after making the config
> >     >changes and installing
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0the necessary packages, I=
 still have no luck with
> >     >git send-email.=C2=A0 Might
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0take a bit to debug this.
> >     >=C2=A0 =C2=A0 =C2=A0>
> >     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0- Justin
> >     >=C2=A0 =C2=A0 =C2=A0>
> >     >=C2=A0 =C2=A0 =C2=A0>
> >     >=C2=A0 =C2=A0 =C2=A0> Sorry for the multiplicity, looks like Gmail=
 forwarded
> >     >it =20
> >     eventually, =20
> >     >=C2=A0 =C2=A0 =C2=A0> but not until I tried several times debuggin=
g it.
> >     >
> >     >=C2=A0 =C2=A0 =C2=A0Not sure, I didn't receive any of them.
> >     >
> >     >=C2=A0 =C2=A0 =C2=A0Thanks,
> >     >=C2=A0 =C2=A0 =C2=A0Laurent
> >     >
> >     >
> >     > Sigh, 4 copies ended up in my Gmail spam folder, so I thought
> >     > it =20
> >     made it =20
> >     > through.
> >     > =20
> >=20
> >     Any news? Freeze is coming.
> >=20
> >     Thanks,
> >     Laurent
> >=20
> >=20
> > I'll manually do it when I get home tomorrow.=C2=A0 Fixing git send-ema=
il
> > will have to wait. =20
>=20
> Don't bother: if you have problems with "git send-email" I can apply
> the attachment.
>=20
> Thanks,
> Laurent

Thanks.  Sorry for the troubles.  I'll have to spend some time trying
to fix git send-email, for the future.

- Justin

