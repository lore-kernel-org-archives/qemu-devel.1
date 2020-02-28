Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65757C3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:31:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26802222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDEAUYWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26802222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7cvg-0005rW-Dm
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 05:31:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j7cus-0005Rq-09
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:30:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j7cuq-0006da-Jg
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:30:45 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:41128)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j7cuq-0006bD-EF
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:30:44 -0500
Received: by mail-ot1-x32d.google.com with SMTP id v19so2099153ote.8
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 02:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=ljcQ88lxoyLCBUmiDl1ogokuzC5lHincmdIaLlvt0I0=;
 b=FDEAUYWqaZiVOf+d3r6UpE0df6h7rYxN4HLyBPSlPxNdfjBYksVTt/8x6+5QSAx8uX
 sALur/C+UFOiKQbD8NJD8aA+S9H4NcFkIDanzlz8SqYtqKOK4lrgyMikizQG7/aLt2y1
 vm4c9dGeP8Lj2G4R+27vqTiIWbQXuoztIUJIo1tLln8ltCxkY5BVgszEWF3FfCFqqqAB
 wJAgXnPHDY4uO9Y7ldfrhMQHPyos0YC9UDbNG/DwnA0ExDHuUMsq636044nII77sDep6
 S2/VTQJf1AAbkSFRpq2iqDIxKlqxavI2wf4eQjM3h2PKKm5oSpnfemX9sncq0gyVSP2q
 Qv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=ljcQ88lxoyLCBUmiDl1ogokuzC5lHincmdIaLlvt0I0=;
 b=jgNTDbF8BGl8jjfWq0Z48SeD3lvtz/I1G9rbDJMLyL6gw2C3UUXXDEdx1slAfFjsBI
 fN7fOMauiZpK0/ShubNzRMg537beV4eAj6HdyYuzhOlXhvO74zGvNTV0z5Lp5dgDX8j0
 SXkf+GKPNBtU9pvhitTjr2VgmaCMSnwp8jSOZho/1v/U5XBIwmH8Hrler0dYI9NX1kjR
 P2xW7NVCocPPNprcyqLAuiHIokzSuljin4rtjT8mpTbNnQfysHXucazpgZAxYFkmLW9n
 nU3NWD79i4CEmsspFrw6DQC3/d8nmS5HZSrkqDVzi39E7l+vsb7GI/d2pBFteV60686Y
 6smQ==
X-Gm-Message-State: APjAAAUi1j+4B0qaBjatFNmNEbR/0073Yhdz08Z8p+PHRaqCiJmOjCNF
 AX2cbn1qg5lhsAvIL5x9H03U08DzGvcRS6kVvOePqg==
X-Google-Smtp-Source: APXvYqwEfqblaoUfwWUCxvf0SUdTiKoSGGxNbAYJJIR9Ar3DmC9qHoukzHuk2At1U06RXQjFpKnf1Yhc9DPNXW+FAiY=
X-Received: by 2002:a9d:2184:: with SMTP id s4mr2541725otb.121.1582885843547; 
 Fri, 28 Feb 2020 02:30:43 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Fri, 28 Feb 2020 02:30:43 -0800 (PST)
In-Reply-To: <87mu9384e4.fsf@secure.laptop>
References: <20200103074000.1006389-1-marcandre.lureau@redhat.com>
 <20200103074000.1006389-4-marcandre.lureau@redhat.com>
 <8736cqi07g.fsf@secure.laptop>
 <CAJ+F1CLgg6Yz=2V8_eCVtsJ1zPm=1-piz-Nw05KGXkSqWytLgA@mail.gmail.com>
 <87r1yfc1q1.fsf@secure.laptop>
 <CAL1e-=h+SkEPy1VVvdNeo9T1mAT5-dA7orsj0TFtfDsTofwzFg@mail.gmail.com>
 <87mu9384e4.fsf@secure.laptop>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 28 Feb 2020 11:30:43 +0100
Message-ID: <CAL1e-=jacne+SxLqf0fJKTpHzELOMLkhsFaaakxTuOvE_3AW2Q@mail.gmail.com>
Subject: [PATCH v2 3/3] savevm: check RAM is pagesize aligned
To: "quintela@redhat.com" <quintela@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006cbea2059fa0548f"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32d
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006cbea2059fa0548f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

just cc-ing Herve and Philippe, related to Magnum machine support (this is
one of so-called Jazz mips machines)

On Friday, February 28, 2020, Juan Quintela <quintela@redhat.com> wrote:

> Aleksandar Markovic <aleksandar.m.mail@gmail.com> wrote:
> > On Thursday, February 27, 2020, Juan Quintela <quintela@redhat.com>
> wrote:
> >
> >  Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:
> >  > Hi Juan
> >  >
> >  > On Wed, Jan 8, 2020 at 2:08 PM Juan Quintela <quintela@redhat.com>
> wrote:
> >  >>
> >  >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> >  >> n> Check the host pointer is correctly aligned, otherwise we may fa=
il
> >  >> > during migration in ram_block_discard_range().
> >  >> >
> >  >> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.co=
m>
> >  >>
> >  >> Reviewed-by: Juan Quintela <quintela@redhat.com>
> >  >>
> >  >> queued
> >  >>
> >  >
> >  > Did it get lost? thanks
> >
> >  I dropped it in the past, because it made "make check" for mips fail.
> >  (I put it on my ToDo list to investigate and forgot about it)
> >
> > Thank you for caring for mips.
> >
> > Do you perhaps remember what was tgevtest and environment for the
> failing test?
>
>
> And here we are again.
> I only compile on an x86 32bit host when I am going to do a pull
> request.
>
> qemu-system-mips64el: /mnt/code/qemu/full/migration/savevm.c:2923:
> vmstate_register_ram: Assertion `QEMU_PTR_IS_ALIGNED(qemu_ram
> _get_host_addr(rb), qemu_ram_pagesize(rb))' failed.
> Broken pipe
> /mnt/code/qemu/full/tests/qtest/libqtest.c:175: kill_qemu() detected QEMU
> death from signal 6 (Aborted) (core dumped)
>   TEST    check-qtest-aarch64: tests/qtest/qom-test
> ERROR - too few tests run (expected 4, got 0)
> make: *** [/mnt/code/qemu/full/tests/Makefile.include:632:
> check-qtest-mips64el] Error 1
> make: *** Waiting for unfinished jobs....
>
>
> As you can see, this is mips tcg running in a 32bit host.
>
> $ export QTEST_QEMU_BINARY=3D./mips64el-softmmu/qemu-system-mips64el
> $ ./tests/qtest/qom-test
> /mips64el/qom/pica61: OK
> /mips64el/qom/mipssim: OK
> /mips64el/qom/mips: OK
> /mips64el/qom/fulong2e: OK
> /mips64el/qom/malta: OK
> /mips64el/qom/boston: OK
> /mips64el/qom/none: OK
> /mips64el/qom/magnum: qemu-system-mips64el: /mnt/code/qemu/full/migration=
/savevm.c:2923:
> vmstate_register_ram: Assertion `QEMU_PTR_IS_ALIGNED(qemu_ram_get_host_ad=
dr(rb),
> qemu_ram_pagesize(rb))' failed.
> Broken pipe
> /mnt/code/qemu/full/tests/qtest/libqtest.c:175: kill_qemu() detected QEMU
> death from signal 6 (Aborted) (core dumped)
> Aborted (core dumped)
> $
>
> Can you take a look at this?
>
> mips64-softmmu also fails on the same place, mips[el]-softmmu passes,
> but they don't use magnum.
>
> Code is supposed to be right, I will expect that the problem is in the
> magnum board, but this is qemu + mips + migration.  Anything can happen.
>
> Marc, I have to drop it again.
>
> Later, Juan.
>
>

--0000000000006cbea2059fa0548f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

just cc-ing Herve and Philippe, related to Magnum machine support (this is =
one of so-called Jazz mips machines)<br><br>On Friday, February 28, 2020, J=
uan Quintela &lt;<a href=3D"mailto:quintela@redhat.com" target=3D"_blank">q=
uintela@redhat.com</a>&gt; wrote:<br><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Aleksan=
dar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com" target=3D"_=
blank">aleksandar.m.mail@gmail.com</a>&gt; wrote:<br>
&gt; On Thursday, February 27, 2020, Juan Quintela &lt;<a href=3D"mailto:qu=
intela@redhat.com" target=3D"_blank">quintela@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@gm=
ail.com" target=3D"_blank">marcandre.lureau@gmail.com</a>&gt; wrote:<br>
&gt;=C2=A0 &gt; Hi Juan<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; On Wed, Jan 8, 2020 at 2:08 PM Juan Quintela &lt;<a href=3D=
"mailto:quintela@redhat.com" target=3D"_blank">quintela@redhat.com</a>&gt; =
wrote:<br>
&gt;=C2=A0 &gt;&gt;<br>
&gt;=C2=A0 &gt;&gt; Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.=
lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt; wr=
ote:<br>
&gt;=C2=A0 &gt;&gt; n&gt; Check the host pointer is correctly aligned, othe=
rwise we may fail<br>
&gt;=C2=A0 &gt;&gt; &gt; during migration in ram_block_discard_range().<br>
&gt;=C2=A0 &gt;&gt; &gt;<br>
&gt;=C2=A0 &gt;&gt; &gt; Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=
=3D"mailto:marcandre.lureau@redhat.com" target=3D"_blank">marcandre.lureau@=
redhat.com</a>&gt;<br>
&gt;=C2=A0 &gt;&gt;<br>
&gt;=C2=A0 &gt;&gt; Reviewed-by: Juan Quintela &lt;<a href=3D"mailto:quinte=
la@redhat.com" target=3D"_blank">quintela@redhat.com</a>&gt;<br>
&gt;=C2=A0 &gt;&gt;<br>
&gt;=C2=A0 &gt;&gt; queued<br>
&gt;=C2=A0 &gt;&gt;<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; Did it get lost? thanks<br>
&gt;<br>
&gt;=C2=A0 I dropped it in the past, because it made &quot;make check&quot;=
 for mips fail.<br>
&gt;=C2=A0 (I put it on my ToDo list to investigate and forgot about it)<br=
>
&gt;<br>
&gt; Thank you for caring for mips.<br>
&gt;<br>
&gt; Do you perhaps remember what was tgevtest and environment for the fail=
ing test?<br>
<br>
<br>
And here we are again.<br>
I only compile on an x86 32bit host when I am going to do a pull<br>
request.<br>
<br>
qemu-system-mips64el: /mnt/code/qemu/full/migration/<wbr>savevm.c:2923: vms=
tate_register_ram: Assertion `QEMU_PTR_IS_ALIGNED(qemu_ram<br>
_get_host_addr(rb), qemu_ram_pagesize(rb))&#39; failed.<br>
Broken pipe<br>
/mnt/code/qemu/full/tests/qtes<wbr>t/libqtest.c:175: kill_qemu() detected Q=
EMU death from signal 6 (Aborted) (core dumped)<br>
=C2=A0 TEST=C2=A0 =C2=A0 check-qtest-aarch64: tests/qtest/qom-test<br>
ERROR - too few tests run (expected 4, got 0)<br>
make: *** [/mnt/code/qemu/full/tests/Mak<wbr>efile.include:632: check-qtest=
-mips64el] Error 1<br>
make: *** Waiting for unfinished jobs....<br>
<br>
<br>
As you can see, this is mips tcg running in a 32bit host.<br>
<br>
$ export QTEST_QEMU_BINARY=3D./mips64el-s<wbr>oftmmu/qemu-system-mips64el <=
br>
$ ./tests/qtest/qom-test<br>
/mips64el/qom/pica61: OK<br>
/mips64el/qom/mipssim: OK<br>
/mips64el/qom/mips: OK<br>
/mips64el/qom/fulong2e: OK<br>
/mips64el/qom/malta: OK<br>
/mips64el/qom/boston: OK<br>
/mips64el/qom/none: OK<br>
/mips64el/qom/magnum: qemu-system-mips64el: /mnt/code/qemu/full/migration/<=
wbr>savevm.c:2923: vmstate_register_ram: Assertion `QEMU_PTR_IS_ALIGNED(qem=
u_ram_<wbr>get_host_addr(rb), qemu_ram_pagesize(rb))&#39; failed.<br>
Broken pipe<br>
/mnt/code/qemu/full/tests/qtes<wbr>t/libqtest.c:175: kill_qemu() detected Q=
EMU death from signal 6 (Aborted) (core dumped)<br>
Aborted (core dumped)<br>
$ <br>
<br>
Can you take a look at this?<br>
<br>
mips64-softmmu also fails on the same place, mips[el]-softmmu passes,<br>
but they don&#39;t use magnum.<br>
<br>
Code is supposed to be right, I will expect that the problem is in the<br>
magnum board, but this is qemu + mips + migration.=C2=A0 Anything can happe=
n.<br>
<br>
Marc, I have to drop it again.<br>
<br>
Later, Juan.<br>
<br>
</blockquote>

--0000000000006cbea2059fa0548f--

