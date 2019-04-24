Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66638C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:16:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DD5721773
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgEUkEqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DD5721773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42369 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJIhj-0003xD-3O
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 10:16:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hJIfQ-0002XI-3l
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:14:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hJIae-0000Db-PP
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:09:38 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40967)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hJIae-0000Bp-JE
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:09:36 -0400
Received: by mail-ot1-x342.google.com with SMTP id g8so2277559otk.8
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 07:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=8v3p45lRJSCzNAEgD3C3YA3auMNuh58OuyBB6RW9DgI=;
	b=fgEUkEqrzzUGOJvLHpnsgvwtAN/72xIqaQaZZZUK/Um674y9CpV9sikyTH+j8vqjLl
	iZBZ365qO1nGcZgt8lTG0GjTGOEzSw6yvU4VdHeZZ3QZCztto6lht0Q2EXnmN4AkJ1xq
	vG9FdtqHnWh4iaWQkbD/6FCI6vtcMUaEQrpEdKnAicMXMPkP3k+Y2sejSfRCzwVhZPjf
	Mm5dkw3vNDnxI9hpFaoYY/ciuCrqBVc4MlsnaWG872cN5FPpu0+A6v3cpvGIKARlu5nl
	28Ql2T/zEBkRPFr0M3K+R0+2JkpzMshFFwN+Kdo1a0fxVYeoe3xQcwrVFGhnCK/AM89h
	lDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=8v3p45lRJSCzNAEgD3C3YA3auMNuh58OuyBB6RW9DgI=;
	b=So7fmh6cW0tEnXab96hbOmQ+FmhJ832KJVmQPY+qzWLEWuk/CWomiR8wGJ9o8Koc6w
	8oYpSzkp/1Pa72mqVyr7oNAeagD5qEXmC2faidZXwDbbNL7WOWJVYzmF3TEhH+WsNlOq
	qbr3SYqi65af+wr89aP3L7AVKml11JMFVvh7reH75BMBGUIWrqgsgIXF75uYMCvt3bGS
	yYnZYN3dhazSonqI7okYEF8+1SgJjvrpb1duoA4ZDH4dLhXRk/mMTUCa4xHHYEXIbOg/
	dP4RG77fjc/gOhdx0bFDpPxKkamzuUmCl7AAgagLuWiUnTFSmzofkfBD3RT7aUCR93nI
	H5qA==
X-Gm-Message-State: APjAAAXLuuFw8hgDMZxEbn+nWbXZ7e1YxqnD8z2Ewa5IsoBpIgfuDZ8i
	+ao7B01jbvZCu+9TMjjC6h3om0ZMJ0G97gqHHuA=
X-Google-Smtp-Source: APXvYqyP18S9wYx3nm3FvokhDTVznJUZJYP8TuBOtPmUtWUAypFEUT9OX0VV2S1uLySDKrAtMEIjLkuS/hKX7s1YHW4=
X-Received: by 2002:a9d:7b50:: with SMTP id f16mr19183704oto.221.1556114975523;
	Wed, 24 Apr 2019 07:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190420100056.116305-1-liq3ea@163.com>
	<20190420100056.116305-4-liq3ea@163.com>
	<a27cd912-4f58-55ac-1aae-e4999fa3d84d@redhat.com>
	<CAKXe6SJZWs7HtXutX6W3saDhaNDtVPMQEh2+s+9XiM3TtZqLdQ@mail.gmail.com>
	<6dd699b1-f24d-743b-343e-f1df6c8672b9@redhat.com>
In-Reply-To: <6dd699b1-f24d-743b-343e-f1df6c8672b9@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 24 Apr 2019 22:08:59 +0800
Message-ID:
 <CAKXe6SJ5iqXTMZMKQG4X0r1dDKNCBq06hcDPVzzUupCD=nH4zw@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 3/4] tests: fw_cfg: add reboot_timeout test
 case
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
Cc: lvivier@redhat.com,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	Li Qiang <liq3ea@163.com>, Qemu Developers <qemu-devel@nongnu.org>,
	Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424140859.s9ty7KCwFr9ZC_qv6NGMBDH8DXoHWyaWCTgpxLFsPl8@z>

Thomas Huth <thuth@redhat.com> =E4=BA=8E2019=E5=B9=B44=E6=9C=8824=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=883:31=E5=86=99=E9=81=93=EF=BC=9A

> On 24/04/2019 03.16, Li Qiang wrote:
> >
> > Thomas Huth <thuth@redhat.com <mailto:thuth@redhat.com>> =E4=BA=8E2019=
=E5=B9=B44=E6=9C=8824=E6=97=A5
> > =E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8812:29=E5=86=99=E9=81=93=EF=BC=9A
> >
> >     On 20/04/2019 12.00, Li Qiang wrote:
> >     > Signed-off-by: Li Qiang <liq3ea@163.com <mailto:liq3ea@163.com>>
> >     > ---
> >     >  tests/fw_cfg-test.c | 19 +++++++++++++++++++
> >     >  1 file changed, 19 insertions(+)
> >     >
> >     > diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
> >     > index c22503619f..9f75dbb5f4 100644
> >     > --- a/tests/fw_cfg-test.c
> >     > +++ b/tests/fw_cfg-test.c
> >     > @@ -174,6 +174,24 @@ static void test_fw_cfg_boot_menu(void)
> >     >      qtest_quit(s);
> >     >  }
> >     >
> >     > +static void test_fw_cfg_reboot_timeout(void)
> >     > +{
> >     > +    QFWCFG *fw_cfg;
> >     > +    QTestState *s;
> >     > +    uint32_t reboot_timeout =3D 0;
> >     > +    size_t filesize;
> >     > +
> >     > +    s =3D qtest_init("-boot reboot-timeout=3D15");
> >     > +    fw_cfg =3D pc_fw_cfg_init(s);
> >     > +
> >     > +    filesize =3D qfw_cfg_get_file(fw_cfg, "etc/boot-fail-wait",
> >     > +                     &reboot_timeout, sizeof(reboot_timeout));
> >     > +    g_assert_cmpint(filesize, =3D=3D, sizeof(reboot_timeout));
> >     > +    g_assert_cmpint(reboot_timeout, =3D=3D, 15);
> >
> >     Is this endianess-safe? Or do you need to byteswap reboot_timeout i=
f
> the
> >     host and guest endianess does not match?
> >
> > Good question!
> >
> > IIUC, the qemu fw_cfg store the 'file' entry data just in byte stream.
> > So there is no need
> > to consider the file's endianess. If when the file entry is stored
> > without considering endianess,
> > it will be ok to ignore the endianess. So for this patch, the
> > 'reboot_timeout' is ok as when we stored
> > it we don't consider endianess. But for 'splash-time', when we stored
> > it  we convert it to little endian
> > so when we fetches it, we should also convert it from little endian to
> > cpu-endian.
>
> I just gave these patches a try on a big endian host, and the test fails
> indeed:
>
>
Hi Thomas,

I have sent out a revision patchset, could you please also try the new in
the big endian host.

Thanks,
Li Qiang




> $ QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 tests/fw_cfg-test
> /x86_64/fw_cfg/signature: OK
> /x86_64/fw_cfg/id: OK
> /x86_64/fw_cfg/uuid: OK
> /x86_64/fw_cfg/ram_size: OK
> /x86_64/fw_cfg/nographic: OK
> /x86_64/fw_cfg/nb_cpus: OK
> /x86_64/fw_cfg/max_cpus: OK
> /x86_64/fw_cfg/numa: OK
> /x86_64/fw_cfg/boot_menu: OK
> /x86_64/fw_cfg/reboot_timeout: **
> ERROR:tests/fw_cfg-test.c:190:test_fw_cfg_reboot_timeout: assertion
> failed (reboot_timeout =3D=3D 15): (0 =3D=3D 15)
> Aborted
>
> =3D> it also fails for reboot_timeout already, not only for splash_time.
>
> > So I think we can have following choose:
> >
> > 1. Don't consider the endianess, this is ok when emaulated target and
> > host target has the same endianess.
>
> Sorry, but that's not a real choice. qtests must also work when you e.g.
> run qemu-system-x86_64 on a big endian host.
>
>  Thomas
>
