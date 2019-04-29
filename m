Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66252C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:47:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF64D20656
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cg+DiCZx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF64D20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58656 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL7Yl-00026v-Vg
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 10:47:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hL7Xv-0001mT-T6
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:46:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hL7Xu-0002Th-Lb
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:46:19 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39545)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hL7Xu-0002T0-DA
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:46:18 -0400
Received: by mail-wr1-x441.google.com with SMTP id a9so16473204wrp.6
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=cB54/XjHfPP4yFfz1rwYio6aGGO+PXzLBAQgNP26Vs8=;
	b=cg+DiCZxSzLKTC3XHGlAu8Plvr/Yp16Xxis1bV3x2Xm02ZltPfpVoq8M6JBalV4OCk
	2eVSWNG0ru5DXnOKo983SyzczqCbb0BlMFzy8yXHx28HtGjt9JymkS840pGkrChrTHuN
	YfE21IXH7w1xY7GnxbRUMep2TinLevszo8va3tdaI+HLK1CqyGtjlNIdzownHiUP04rh
	x7RmGQRqfF8gMHWNsLh7Fo3n5Hz3NakMX01vIl5h7tPIYx0E3KjLWE4G+b3I9As0peH9
	C3TO3m+rRvZz+lQOMUgTDBr5Bl4qS4X4XoobVZL4tSO7dVxrzzE0cQVoAUGTjws2DGQR
	CZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=cB54/XjHfPP4yFfz1rwYio6aGGO+PXzLBAQgNP26Vs8=;
	b=pDS6o/HTL80khN/veDOUNcA+2hF1DAk1bLUMdYhPE+GtruVTneGLsB8Lv3hxmIAXdW
	dDP/4flph6pPtaz0pUYlGBAYD5K5JtW6FA172W8eqyJv1KpIMKYFrVhsHNT10+SugZZr
	znPhU9Soyf33H8vwwYPGiTfhOB1wxXuMYbAGJtzD1pcddvVsBRTWFbiD460uByDahmng
	UaWsUN/n0p1AAqYAeI159PMnewtX+hZ3rCR0ly3T0Av9XzQFPLYkKzCoUDdWWRcp508R
	VluOQVqBqM5fPmtxJz5o42Eqvys35EmxKzW9ExvYdLRe+zr3wlDc5UXWep7dsXvP0UdW
	Xgbw==
X-Gm-Message-State: APjAAAVObcOShwuv6LPbvqMQzIOZ9NhN8meug1vAmbjRNLJPzOC66LSR
	LESV+6dkAc8m3xiaQWlT+nsL+UZbn1p9EerBS7o=
X-Google-Smtp-Source: APXvYqyf75vlJa/kxIYAq0kLUR2197KD0RNOgCPDPOkEzsgdUacp5jRls2OBNbbyyH+AOFqYm+qced2J8+bRiYb7qBw=
X-Received: by 2002:adf:9042:: with SMTP id h60mr5972493wrh.248.1556549175383; 
	Mon, 29 Apr 2019 07:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190429134757.13570-1-marcandre.lureau@redhat.com>
	<6f4b8998-341a-9169-b368-db4a6b00b65d@redhat.com>
In-Reply-To: <6f4b8998-341a-9169-b368-db4a6b00b65d@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 29 Apr 2019 16:46:03 +0200
Message-ID:
 <CAJ+F1C+aXyC8UAaCKU7sD9LTZPDEaYhSufp9auxipxavDj3F+A@mail.gmail.com>
To: Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH] vl: fix -sandbox parsing crash when
 seccomp support is disabled
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Otubo <otubo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	QEMU <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429144603.gcT2tMEumIrQjTa0QZh-BfibjR1Rs7yxEvyae9hvfl0@z>

Hi

On Mon, Apr 29, 2019 at 4:26 PM Laurent Vivier <lvivier@redhat.com> wrote:
>
> On 29/04/2019 15:47, Marc-Andr=C3=A9 Lureau wrote:
> > $ ./x86_64-softmmu/qemu-system-x86_64 -sandbox off
> > qemu-system-x86_64: -sandbox off: There is no option group 'sandbox'
> > Segmentation fault
> >
> > Commit 5780760f5e ("seccomp: check TSYNC host capability") wrapped one
> > use of the sandbox option group to produce a sensible error, it didn't
> > do the same for another call to qemu_opts_parse_noisily():
> >
> > (gdb) bt
> >     at util/qemu-option.c:829
> >  #0  0x00000000105b36d8 in opts_parse (list=3D0x0, params=3D0x3ffffffff=
ab5 "off", permit_abbrev=3Dtrue, defaults=3Dfalse, errp=3D0x3ffffffff080)
> >      at util/qemu-option.c:829
> >  #1  0x00000000105b3b74 in qemu_opts_parse_noisily (list=3D<optimized o=
ut>, params=3D<optimized out>, permit_abbrev=3D<optimized out>) at util/qem=
u-option.c:890
> >  #2  0x0000000010024964 in main (argc=3D<optimized out>, argv=3D<optimi=
zed out>, envp=3D<optimized out>) at vl.c:3589
> >
> > Fixes: 5780760f5ea6163939a5dabe7427318b4f07d1a2
> > Cc: david@gibson.dropbear.id.au
> > Cc: otubo@redhat.com
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  vl.c | 18 ++++++++++--------
> >  1 file changed, 10 insertions(+), 8 deletions(-)
> >
> > diff --git a/vl.c b/vl.c
> > index 4019a4387d..5fc4994d3c 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -3866,17 +3866,19 @@ int main(int argc, char **argv, char **envp)
> >                  qtest_log =3D optarg;
> >                  break;
> >              case QEMU_OPTION_sandbox:
> > -#ifdef CONFIG_SECCOMP
> > -                opts =3D qemu_opts_parse_noisily(qemu_find_opts("sandb=
ox"),
> > -                                               optarg, true);
> > +                olist =3D qemu_find_opts("sandbox");
> > +                if (!olist) {
> > +#ifndef CONFIG_SECCOMP
>
> Why do you move the #ifdef? We have two separate error cases here.
> And it seems better no to check for "-sandbox" when seccomp is disabled.

I tried to remove the #ifdef altogether to simplify the code, then
realized the error message could be useful.

I don't think it's a problem to lookup "-sandbox" when seccomp is disabled.

--=20
Marc-Andr=C3=A9 Lureau

