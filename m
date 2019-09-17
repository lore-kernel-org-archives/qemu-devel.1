Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E90C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:44:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D184920862
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTFh54DS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D184920862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAA1t-00039V-Vf
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 05:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <atar4qemu@gmail.com>) id 1iAA0q-0002aE-GW
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:43:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <atar4qemu@gmail.com>) id 1iAA0o-0001Z7-JI
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:43:08 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:46326)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <atar4qemu@gmail.com>)
 id 1iAA0j-0001TL-0k; Tue, 17 Sep 2019 05:43:01 -0400
Received: by mail-io1-xd43.google.com with SMTP id d17so5900686ios.13;
 Tue, 17 Sep 2019 02:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Ydty44ijVhCwlwUr5LIc3DzJp9U3SWgXRELeO1eutsw=;
 b=mTFh54DS2VUMwsXh1HKBS02VxYjyVhVGvulGK93nIIpw6cSnZyWXF7w/mPs9WjHSlk
 sp4rxHukEBYtFcRHK3gISPtgXOeTDzA2iQ0THF2FysLpgpBMiu0FITgtAnK40yPHMlGn
 /V9Kniop0DjP/FoTD/VZrK5N8VRYa4UPXLOCQK39l++JMbfiCh2d2bNDdSR6Ct4U3JxN
 AOQ6IHdWOCtZ6MSQ17V8+8hxd/kZVsUKL/fOErpBwf4QV+T+AQfR2DiWRpLoyiX3yaIr
 8S4ZYvNHLCf8McTWMDJirpoOUEukorGmaudDEmN2dI6w5j705jrdpGZ1dZ9/hmV91x/2
 cl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Ydty44ijVhCwlwUr5LIc3DzJp9U3SWgXRELeO1eutsw=;
 b=RisHi43FpH4lXoNjhabx/uJR9Nqnvg2TatfAd0H+fQow3YSZPR4jeIH1IQSs5v7Hkp
 nH+bdh+h3e08xtOV5PNL26Gg2eTo4DXwmf3RTSaxGlxWvTED1FIH1STg8/gQMFO5eyue
 kX+TtYDF0Y5KNhzeTpJ3kPL8D8P5R1qM6/+3gqtS8VNFtI3DHrx2Fg4uN0S6lM2iFeYC
 LscnBtNgP9UJjIoH52riQUvUqWguzePkZkvahBWy85TSAiJOmLbZVwRoe8swKVIX1vPG
 R7/GmzqPw05p2uAV4+UcrmP/IGGpCoSs7zu32Qx0sI7/JCThuh6czX39o5Gf0buYoYtV
 emag==
X-Gm-Message-State: APjAAAW83SDmmHFDFU0uNWfeC/XBNbw+5vRvU0vNVXKYFDxRp/o7eMu4
 e9RPssZIVYI0J5GMudjat6qrJDmzOtwtTGJaBKc=
X-Google-Smtp-Source: APXvYqy/vMC6oKCoh9g5d7Fn/6AcWuP+b8mlPHC5/uyfWcF3Qvqt20YiJsE26av+Xpok41yxaQp4+eWnWhXoVfHEkxI=
X-Received: by 2002:a6b:c7c2:: with SMTP id x185mr2812667iof.224.1568713378228; 
 Tue, 17 Sep 2019 02:42:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190915211940.30427-1-f4bug@amsat.org>
 <20190915211940.30427-3-f4bug@amsat.org>
 <20190916175914.GA7550@dhcp-17-173.bos.redhat.com>
 <20190916185513.GA13659@dhcp-17-173.bos.redhat.com>
 <87h85b1d48.fsf@linaro.org>
In-Reply-To: <87h85b1d48.fsf@linaro.org>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Tue, 17 Sep 2019 11:42:46 +0200
Message-ID: <CACXAS8BgxaeXt3dDxw6=JxSRWVvi90Kr8+BZyhgCdYxcONbQaQ@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
Subject: Re: [Qemu-devel] [PATCH v2 2/6] tests/acceptance: Test Open
 Firmware on the PReP/40p
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>, "open list:PReP" <qemu-ppc@nongnu.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 17, 2019 at 11:33 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>
>
> Cleber Rosa <crosa@redhat.com> writes:
>
> > On Mon, Sep 16, 2019 at 01:59:22PM -0400, Cleber Rosa wrote:
> >> On Sun, Sep 15, 2019 at 11:19:36PM +0200, Philippe Mathieu-Daud=C3=A9 =
wrote:
> >> > User case from:
> >> > https://tyom.blogspot.com/2019/04/aixprep-under-qemu-how-to.html
> >> >
> >> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >> > ---
> >> >  tests/acceptance/ppc_prep_40p.py | 21 +++++++++++++++++++++
> >> >  1 file changed, 21 insertions(+)
> >> >
> >> > diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc=
_prep_40p.py
> >> > index 53f2d2ecf0..a0eac40d9f 100644
> >> > --- a/tests/acceptance/ppc_prep_40p.py
> >> > +++ b/tests/acceptance/ppc_prep_40p.py
> >> > @@ -61,3 +61,24 @@ class IbmPrep40pMachine(Test):
> >> >          os_banner =3D 'NetBSD 4.0 (GENERIC) #0: Sun Dec 16 00:49:40=
 PST 2007'
> >> >          self.wait_for_console_pattern(os_banner)
> >> >          self.wait_for_console_pattern('Model: IBM PPS Model 6015')
> >> > +
> >> > +    def test_openfirmware(self):
> >> > +        """
> >> > +        :avocado: tags=3Darch:ppc
> >> > +        :avocado: tags=3Dmachine:40p
> >> > +        """
> >> > +        bios_url =3D ('https://github.com/artyom-tarasenko/openfirm=
ware/'
> >> > +                    'releases/download/40p-20190413/q40pofw-serial.=
rom')
> >> > +        bios_hash =3D '880c80172ea5b2247c0ac2a8bf36bbe385192c72'
> >> > +        bios_path =3D self.fetch_asset(bios_url, asset_hash=3Dbios_=
hash)
> >> > +
> >> > +        self.vm.set_machine('40p')
> >> > +        self.vm.set_console()
> >> > +        self.vm.add_args('-bios', bios_path)
> >> > +
> >> > +        self.vm.launch()
> >> > +        self.wait_for_console_pattern('QEMU PReP/40p')
> >> > +        fw_banner =3D 'Open Firmware, built  April 13, 2019 09:29:2=
3'
> >> > +        self.wait_for_console_pattern(fw_banner)
> >> > +        prompt_msg =3D 'Type any key to interrupt automatic startup=
'
> >> > +        self.wait_for_console_pattern(prompt_msg)
> >> > --
> >> > 2.20.1
> >> >
> >>
> >> Tested-by: Cleber Rosa <crosa@redhat.com>
> >> Reviewed-by: Cleber Rosa <crosa@redhat.com>
> >
> > Actually, I'm seeing random but consistent failures.  I've tracked
> > it down to the 'Open Firmware, built  April 13, 2019 09:29:23'.  Out
> > of 100 executions I got 27 failures, with that line logged as:
> >
> >   2019-09-16 14:44:54,540 ppc_prep_40p     L0033 DEBUG| Firmware, built=
  April 13, 2019 09:29:23
> >   2019-09-16 14:45:00,762 ppc_prep_40p     L0033 DEBUG| n Firmware, bui=
lt  April 13, 2019 09:29:23
> >   2019-09-16 14:45:06,575 ppc_prep_40p     L0033 DEBUG| Firmware, built=
  April 13, 2019 09:29:23
> >   2019-09-16 14:45:12,859 ppc_prep_40p     L0033 DEBUG| n Firmware, bui=
lt  April 13, 2019 09:29:23
> >   2019-09-16 14:45:18,707 ppc_prep_40p     L0033 DEBUG| Firmware, built=
  April 13, 2019 09:29:23
> >   2019-09-16 14:45:21,876 ppc_prep_40p     L0033 DEBUG| en Firmware, bu=
ilt  April 13, 2019 09:29:23
> >   2019-09-16 14:45:28,054 ppc_prep_40p     L0033 DEBUG| Firmware, built=
  April 13, 2019 09:29:23
> >   2019-09-16 14:45:31,163 ppc_prep_40p     L0033 DEBUG| Firmware, built=
  April 13, 2019 09:29:23
> >   2019-09-16 14:45:34,291 ppc_prep_40p     L0033 DEBUG| en Firmware, bu=
ilt  April 13, 2019 09:29:23
> >   2019-09-16 14:45:57,719 ppc_prep_40p     L0033 DEBUG| Firmware, built=
  April 13, 2019 09:29:23
> >   2019-09-16 14:46:03,610 ppc_prep_40p     L0033 DEBUG| Firmware, built=
  April 13, 2019 09:29:23
> >   2019-09-16 14:46:06,795 ppc_prep_40p     L0033 DEBUG| n Firmware, bui=
lt  April 13, 2019 09:29:23
> >   2019-09-16 14:46:17,087 ppc_prep_40p     L0033 DEBUG| n Firmware, bui=
lt  April 13, 2019 09:29:23
> >   2019-09-16 14:46:21,534 ppc_prep_40p     L0033 DEBUG| Firmware, built=
  April 13, 2019 09:29:23
> >   2019-09-16 14:46:24,694 ppc_prep_40p     L0033 DEBUG| Firmware, built=
  April 13, 2019 09:29:23
> >   2019-09-16 14:46:38,076 ppc_prep_40p     L0033 DEBUG| Firmware, built=
  April 13, 2019 09:29:23
> >   2019-09-16 14:46:49,863 ppc_prep_40p     L0033 DEBUG| n Firmware, bui=
lt  April 13, 2019 09:29:23
> >   2019-09-16 14:46:54,435 ppc_prep_40p     L0033 DEBUG| Firmware, built=
  April 13, 2019 09:29:23
> >   2019-09-16 14:47:00,672 ppc_prep_40p     L0033 DEBUG| Firmware, built=
  April 13, 2019 09:29:23
> >   2019-09-16 14:47:03,834 ppc_prep_40p     L0033 DEBUG| n Firmware, bui=
lt  April 13, 2019 09:29:23
> >   2019-09-16 14:47:06,852 ppc_prep_40p     L0033 DEBUG| Firmware, built=
  April 13, 2019 09:29:23
> >   2019-09-16 14:47:14,276 ppc_prep_40p     L0033 DEBUG| n Firmware, bui=
lt  April 13, 2019 09:29:23
> >   2019-09-16 14:47:17,380 ppc_prep_40p     L0033 DEBUG| Firmware, built=
  April 13, 2019 09:29:23
> >   2019-09-16 14:47:34,749 ppc_prep_40p     L0033 DEBUG| n Firmware, bui=
lt  April 13, 2019 09:29:23
> >   2019-09-16 14:47:39,217 ppc_prep_40p     L0033 DEBUG| n Firmware, bui=
lt  April 13, 2019 09:29:23
> >   2019-09-16 14:47:43,750 ppc_prep_40p     L0033 DEBUG| Firmware, built=
  April 13, 2019 09:29:23
> >   2019-09-16 14:48:04,003 ppc_prep_40p     L0033 DEBUG| Firmware, built=
  April 13, 2019 09:29:23
> >
> > Given that we're not seeing this behavior in other target/marchine
> > tests, my first impression is that this is what's being produced
> > by QEMU, and not what's being badly captured by the Avocado and/or
> > the test code.
>
> Is the DEBUG line meant to show everything that avocado saw? I guess we
> could have a bug in the serial port emulation causing characters to be
> dropped?
>

FWIW back in April I launched QEMU really a lot and never saw a broken bann=
er.
Either it's Avocado, or a regression. Is it possible to see the
complete serial log?

--=20
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu

