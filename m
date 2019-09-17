Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142B0C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:35:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D39F520862
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q1v5AIFO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D39F520862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iA9tR-0007Xt-Ma
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 05:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36577)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iA9rI-0005us-GJ
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:33:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iA9rG-0003rT-Fl
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:33:16 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39544)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iA9rG-0003o4-69
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:33:14 -0400
Received: by mail-wr1-x443.google.com with SMTP id r3so2346710wrj.6
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 02:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=O8oXlM6GvcG/mX2kgsuSuvwP8nZM1T8zmf3fDM+UlO4=;
 b=Q1v5AIFOin31SGW1WS6girffLC0z4Dsdk9c15R5VvDeTRmvaZHoOIDueaqUFvWhbsw
 PV0OpVzL05k6kmDKafN22PzqBG048YJXZ/PPIq8PsXSDAeeB0RTpt0ri7zNMAWU/59i3
 eBPh/b4yizfmSP3AL3j07HzSz0oaP7G2fpVIcVTNIUEIpYk7ftYnDvL7TXuNBgfp4cCQ
 MQdMLoowfJqqqWCyLxLOj/x0bPMHUUMOp2Nhn/CWBJpZ6EFEWt+4Ne4IMF/ftLqH7FtY
 36vexTeP2vsdgUPKnlK/0AEap9/TTG17ge8KicGGoZYrDbsuPuSnmDSc0Upgk3T8eM9I
 8O1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=O8oXlM6GvcG/mX2kgsuSuvwP8nZM1T8zmf3fDM+UlO4=;
 b=GGHp0iNzazy6SXsq1HOjlHmWEBtFextQb68c/Tmq8R3/Yd09mYcRG3xoJXDsrqE+kC
 FtTyuL0FdJZM37KjM2iIcUQKrHqJOtT2JHkBDJJGkM3VZLNH9l1l1g30w/96rShkyn5N
 5HDzcrAeXhFcYtJlBlC+j1UvHs+GzuE8+tw/jFwuy/bjl9aiNoY/jqE1nHiYtc0jQb3P
 MtvwTK46pKiosBhze2TToTpdGjhHrLIKSutow+YGmlBjHMLaOAqPnaFWm846pZzYcYKU
 LPNgYzgGPxZfEx6M8Az/mS2T8wBXzTZh+sK5n5twThLcZy8JYHnQIPA3aEjuagV0LFEn
 V64w==
X-Gm-Message-State: APjAAAXckqjj/ws+abse1BFwkRCe1+08JtTP8S2emsBKjJ9tWrlomA4i
 Z/jwvIOASD938piAJ8RuC8Jo6Q==
X-Google-Smtp-Source: APXvYqyC4+4O/scOGHrSy9YDlpha11wiCR9IHBP/um9Da+JJ0wPJGrXWNstING+NEtHmGYkJSd86XQ==
X-Received: by 2002:adf:f112:: with SMTP id r18mr2294278wro.88.1568712792677; 
 Tue, 17 Sep 2019 02:33:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c132sm2554756wme.27.2019.09.17.02.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2019 02:33:11 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 10E051FF87;
 Tue, 17 Sep 2019 10:33:11 +0100 (BST)
References: <20190915211940.30427-1-f4bug@amsat.org>
 <20190915211940.30427-3-f4bug@amsat.org>
 <20190916175914.GA7550@dhcp-17-173.bos.redhat.com>
 <20190916185513.GA13659@dhcp-17-173.bos.redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Cleber Rosa <crosa@redhat.com>
In-reply-to: <20190916185513.GA13659@dhcp-17-173.bos.redhat.com>
Date: Tue, 17 Sep 2019 10:33:11 +0100
Message-ID: <87h85b1d48.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>,
 =?utf-8?Q?Herv=C3=A9?= Poussineau <hpoussin@reactos.org>, qemu-ppc@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Cleber Rosa <crosa@redhat.com> writes:

> On Mon, Sep 16, 2019 at 01:59:22PM -0400, Cleber Rosa wrote:
>> On Sun, Sep 15, 2019 at 11:19:36PM +0200, Philippe Mathieu-Daud=C3=A9 wr=
ote:
>> > User case from:
>> > https://tyom.blogspot.com/2019/04/aixprep-under-qemu-how-to.html
>> >
>> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> > ---
>> >  tests/acceptance/ppc_prep_40p.py | 21 +++++++++++++++++++++
>> >  1 file changed, 21 insertions(+)
>> >
>> > diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_p=
rep_40p.py
>> > index 53f2d2ecf0..a0eac40d9f 100644
>> > --- a/tests/acceptance/ppc_prep_40p.py
>> > +++ b/tests/acceptance/ppc_prep_40p.py
>> > @@ -61,3 +61,24 @@ class IbmPrep40pMachine(Test):
>> >          os_banner =3D 'NetBSD 4.0 (GENERIC) #0: Sun Dec 16 00:49:40 P=
ST 2007'
>> >          self.wait_for_console_pattern(os_banner)
>> >          self.wait_for_console_pattern('Model: IBM PPS Model 6015')
>> > +
>> > +    def test_openfirmware(self):
>> > +        """
>> > +        :avocado: tags=3Darch:ppc
>> > +        :avocado: tags=3Dmachine:40p
>> > +        """
>> > +        bios_url =3D ('https://github.com/artyom-tarasenko/openfirmwa=
re/'
>> > +                    'releases/download/40p-20190413/q40pofw-serial.ro=
m')
>> > +        bios_hash =3D '880c80172ea5b2247c0ac2a8bf36bbe385192c72'
>> > +        bios_path =3D self.fetch_asset(bios_url, asset_hash=3Dbios_ha=
sh)
>> > +
>> > +        self.vm.set_machine('40p')
>> > +        self.vm.set_console()
>> > +        self.vm.add_args('-bios', bios_path)
>> > +
>> > +        self.vm.launch()
>> > +        self.wait_for_console_pattern('QEMU PReP/40p')
>> > +        fw_banner =3D 'Open Firmware, built  April 13, 2019 09:29:23'
>> > +        self.wait_for_console_pattern(fw_banner)
>> > +        prompt_msg =3D 'Type any key to interrupt automatic startup'
>> > +        self.wait_for_console_pattern(prompt_msg)
>> > --
>> > 2.20.1
>> >
>>
>> Tested-by: Cleber Rosa <crosa@redhat.com>
>> Reviewed-by: Cleber Rosa <crosa@redhat.com>
>
> Actually, I'm seeing random but consistent failures.  I've tracked
> it down to the 'Open Firmware, built  April 13, 2019 09:29:23'.  Out
> of 100 executions I got 27 failures, with that line logged as:
>
>   2019-09-16 14:44:54,540 ppc_prep_40p     L0033 DEBUG| Firmware, built  =
April 13, 2019 09:29:23
>   2019-09-16 14:45:00,762 ppc_prep_40p     L0033 DEBUG| n Firmware, built=
  April 13, 2019 09:29:23
>   2019-09-16 14:45:06,575 ppc_prep_40p     L0033 DEBUG| Firmware, built  =
April 13, 2019 09:29:23
>   2019-09-16 14:45:12,859 ppc_prep_40p     L0033 DEBUG| n Firmware, built=
  April 13, 2019 09:29:23
>   2019-09-16 14:45:18,707 ppc_prep_40p     L0033 DEBUG| Firmware, built  =
April 13, 2019 09:29:23
>   2019-09-16 14:45:21,876 ppc_prep_40p     L0033 DEBUG| en Firmware, buil=
t  April 13, 2019 09:29:23
>   2019-09-16 14:45:28,054 ppc_prep_40p     L0033 DEBUG| Firmware, built  =
April 13, 2019 09:29:23
>   2019-09-16 14:45:31,163 ppc_prep_40p     L0033 DEBUG| Firmware, built  =
April 13, 2019 09:29:23
>   2019-09-16 14:45:34,291 ppc_prep_40p     L0033 DEBUG| en Firmware, buil=
t  April 13, 2019 09:29:23
>   2019-09-16 14:45:57,719 ppc_prep_40p     L0033 DEBUG| Firmware, built  =
April 13, 2019 09:29:23
>   2019-09-16 14:46:03,610 ppc_prep_40p     L0033 DEBUG| Firmware, built  =
April 13, 2019 09:29:23
>   2019-09-16 14:46:06,795 ppc_prep_40p     L0033 DEBUG| n Firmware, built=
  April 13, 2019 09:29:23
>   2019-09-16 14:46:17,087 ppc_prep_40p     L0033 DEBUG| n Firmware, built=
  April 13, 2019 09:29:23
>   2019-09-16 14:46:21,534 ppc_prep_40p     L0033 DEBUG| Firmware, built  =
April 13, 2019 09:29:23
>   2019-09-16 14:46:24,694 ppc_prep_40p     L0033 DEBUG| Firmware, built  =
April 13, 2019 09:29:23
>   2019-09-16 14:46:38,076 ppc_prep_40p     L0033 DEBUG| Firmware, built  =
April 13, 2019 09:29:23
>   2019-09-16 14:46:49,863 ppc_prep_40p     L0033 DEBUG| n Firmware, built=
  April 13, 2019 09:29:23
>   2019-09-16 14:46:54,435 ppc_prep_40p     L0033 DEBUG| Firmware, built  =
April 13, 2019 09:29:23
>   2019-09-16 14:47:00,672 ppc_prep_40p     L0033 DEBUG| Firmware, built  =
April 13, 2019 09:29:23
>   2019-09-16 14:47:03,834 ppc_prep_40p     L0033 DEBUG| n Firmware, built=
  April 13, 2019 09:29:23
>   2019-09-16 14:47:06,852 ppc_prep_40p     L0033 DEBUG| Firmware, built  =
April 13, 2019 09:29:23
>   2019-09-16 14:47:14,276 ppc_prep_40p     L0033 DEBUG| n Firmware, built=
  April 13, 2019 09:29:23
>   2019-09-16 14:47:17,380 ppc_prep_40p     L0033 DEBUG| Firmware, built  =
April 13, 2019 09:29:23
>   2019-09-16 14:47:34,749 ppc_prep_40p     L0033 DEBUG| n Firmware, built=
  April 13, 2019 09:29:23
>   2019-09-16 14:47:39,217 ppc_prep_40p     L0033 DEBUG| n Firmware, built=
  April 13, 2019 09:29:23
>   2019-09-16 14:47:43,750 ppc_prep_40p     L0033 DEBUG| Firmware, built  =
April 13, 2019 09:29:23
>   2019-09-16 14:48:04,003 ppc_prep_40p     L0033 DEBUG| Firmware, built  =
April 13, 2019 09:29:23
>
> Given that we're not seeing this behavior in other target/marchine
> tests, my first impression is that this is what's being produced
> by QEMU, and not what's being badly captured by the Avocado and/or
> the test code.

Is the DEBUG line meant to show everything that avocado saw? I guess we
could have a bug in the serial port emulation causing characters to be
dropped?

>
> Any ideas?
>
> - Cleber.


--
Alex Benn=C3=A9e

