Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1571C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:56:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDDF3214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNIiBj86"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDDF3214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAAE9-0002ej-0C
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 05:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <atar4qemu@gmail.com>) id 1iAADM-00025X-1h
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:56:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <atar4qemu@gmail.com>) id 1iAADK-0007mz-Rx
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:56:03 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:41602)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <atar4qemu@gmail.com>)
 id 1iAADI-0007lb-82; Tue, 17 Sep 2019 05:56:00 -0400
Received: by mail-io1-xd41.google.com with SMTP id r26so6054667ioh.8;
 Tue, 17 Sep 2019 02:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lCQwM9sYqiwMdhqxRhmZRuFrI1liAeYK2lVm/v2rqgw=;
 b=ZNIiBj86HvfvyGJAQ5ah7ZuDz6iZcWVjZ59/NFDFCsRM4FT+jCDGIPVG8vNaoRamD9
 eENwjtrzk5eotd4JB0ln10lM48bWWRmrnoCbaPNhf2YbAMnsd/JrPivifIsOAWgxHs9h
 bIwEO8u3DSE+LshpKTRzDWPX3qR+A98egdV5KMuepwws/pzWkXIjT2mqcZnr0r+dWOM5
 rjyq3DIWBfYCnZ3eSpO8ty7QIPdNdjGnxDhWSvrmGpPyX6bUmc+dPL0gRrGzB4EKGmAC
 3Up19sTS5RwRiF0G6RBA8fvcP+vOpUyHGhNu/q7msYASJui0MS62pbBCb7PKCahSchYz
 kDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lCQwM9sYqiwMdhqxRhmZRuFrI1liAeYK2lVm/v2rqgw=;
 b=A30GFyeCbkPdDsGGW8GutUSUgICqxtrUJsH/oQZ2OalKBA1v8Znh8XrjnulUhIbed+
 57l+3MU9qRfQV+Ntrqpr9E3tfjkCrZpTVmdllEcPZZMtKU1rMUGLwD1fIO2LPwO6r/ok
 1uPVBOYJaJvkGXZfvcKkPsUswlyKrFEFLo6Yc+hdQFRD/bwyCYGfT9hbTJx3ZinBX1ja
 ikxHj3erha6RvXx+/p/c+I4tW+++ar4x+rPu+89Ax9vvpTDa98gZvaChmK91woSlcD0E
 VJZJCRTWGUe36Gb7Tev9mFC8eGrXIGIJsp4Z2CSouV1PMN1Sz8245jCzfijg6mUUVciN
 uwRQ==
X-Gm-Message-State: APjAAAX2QkH/4B24yLKD1GKkDhxS0qDmh/YmjjHTgCjAYBLKOH2ElNGw
 Pygp9L0qQbEjou54KtzIgR93wYZocc7d5qJ/9JY=
X-Google-Smtp-Source: APXvYqzyqOzOrAcanXMUxcdkfrjrB11VG3B8tTgszK+kkSAVtfbIJ2BsEfFEyKCVjAjsLBMz24v2r/zxwu5aB7RZ9Rg=
X-Received: by 2002:a02:3446:: with SMTP id z6mr2074969jaz.105.1568714159534; 
 Tue, 17 Sep 2019 02:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190915211940.30427-1-f4bug@amsat.org>
 <20190915211940.30427-4-f4bug@amsat.org>
 <20190916193245.GA15318@dhcp-17-173.bos.redhat.com>
 <87impr1d6e.fsf@linaro.org>
 <94cb3570-e2aa-fb20-6027-7026525e6922@redhat.com>
In-Reply-To: <94cb3570-e2aa-fb20-6027-7026525e6922@redhat.com>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Tue, 17 Sep 2019 11:55:47 +0200
Message-ID: <CACXAS8AzX3F+AxQujXHJ9SRYewQqb2nS8bSH9KV8fTcR0-v+qg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
Subject: Re: [Qemu-devel] [PATCH v2 3/6] tests/acceptance: Test OpenBIOS on
 the PReP/40p
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
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 17, 2019 at 11:44 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 9/17/19 11:31 AM, Alex Benn=C3=A9e wrote:
> > Cleber Rosa <crosa@redhat.com> writes:
> >> On Sun, Sep 15, 2019 at 11:19:37PM +0200, Philippe Mathieu-Daud=C3=A9 =
wrote:
> >>> User case from:
> >>> https://mail.coreboot.org/pipermail/openbios/2018-May/010360.html
> >>>
> >>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >>> ---
> >>>  tests/acceptance/ppc_prep_40p.py | 32 ++++++++++++++++++++++++++++++=
++
> >>>  1 file changed, 32 insertions(+)
> >>>
> >>> diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_=
prep_40p.py
> >>> index a0eac40d9f..87b5311b89 100644
> >>> --- a/tests/acceptance/ppc_prep_40p.py
> >>> +++ b/tests/acceptance/ppc_prep_40p.py
> >>> @@ -82,3 +82,35 @@ class IbmPrep40pMachine(Test):
> >>>          self.wait_for_console_pattern(fw_banner)
> >>>          prompt_msg =3D 'Type any key to interrupt automatic startup'
> >>>          self.wait_for_console_pattern(prompt_msg)
> >>> +
> >>> +    def test_openbios_192m(self):
> >>> +        """
> >>> +        :avocado: tags=3Darch:ppc
> >>> +        :avocado: tags=3Dmachine:40p
> >>> +        """
> >>> +        self.vm.set_machine('40p')
> >>> +        self.vm.set_console()
> >>> +        self.vm.add_args('-m', '192')
> >>
> >> Is 192 a magic number (some kind of limit)?  Or just a value to check
> >> against later?
> >
> > Just the memory configured for the machine, checked bellow. Or are you
> > wondering why 192m and not any other amount?
>
> The machine default is 128MiB. The firmware asks the memory controller
> how many SIMMs of 8MiB are inserted. We can run OpenBIOS with 128MiB,
> but by specifying a different default in this test, we also test the
> memory controller device :)
>
> Since this is not obvious I'll add a comment.

Are you sure OpenBIOS does it? Doesn't it get the info from the qemu fw dev=
ice?
At least when making OFW I haven't found a way to the info from the
memory controller. I think it's not implemented. Or at least wasn't
back then.
And since I wanted to be compatible with the real hw, which doesn't
have a fw device, I just kept the hardcoded value in OFW.
If it's in the MC meanwhile, I can add the check to OFW as well.

> >>> +
> >>> +        self.vm.launch()
> >>> +        self.wait_for_console_pattern('>> OpenBIOS')
> >>> +        self.wait_for_console_pattern('>> Memory: 192M')
> >>> +        self.wait_for_console_pattern('>> CPU type PowerPC,604')
> >>> +
> >>
> >> On my testing, this is a very stable test, I'm only getting PASSes.
> > <snip>
> >
> > --
> > Alex Benn=C3=A9e
> >



--=20
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu

