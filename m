Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75DDC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 12:34:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81A9320850
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 12:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4WAyd85"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A9320850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47590 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQWdy-0007y4-Hl
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 08:34:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hQWd2-0007er-1H
	for qemu-devel@nongnu.org; Tue, 14 May 2019 08:33:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hQWd1-0004JP-2e
	for qemu-devel@nongnu.org; Tue, 14 May 2019 08:33:55 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hQWd0-0004Im-Sg
	for qemu-devel@nongnu.org; Tue, 14 May 2019 08:33:55 -0400
Received: by mail-wr1-x441.google.com with SMTP id r4so19000070wro.10
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 05:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=V7jyaX2CdOaM3NAMtEjekUMY8KEYZ+D8UxmOhh54DzY=;
	b=J4WAyd85odjuhVcxlQmct3hGN2/eWYnsOo8FTG0FHCfoh4WIHb5Oteu2a0iTwyQxyb
	uKgO57NWnvSw39VE/Gmkzk/UTCEZtcIvXTftyGE3rjTz8tdHTgbjywFikIEWA9RvRkaQ
	2a/YTFhadihLYaCbNpHO2Q2vuVr3Rh1vRAD3lPkBemm2y9o5OJQXXdS0SgpsS6Ag+6QV
	M/USRWlj4zJH9GSdlo1ij7MmAJSwy2mitkQalyQRaO7wcVz4wphHVeui7s0LUyK65bOH
	Lv/W7ygZemftGtdawxvZJPn3H90nWNorf0YyGMiptJZlrSRZQ8ls565e9IV6VrrESvhV
	KMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=V7jyaX2CdOaM3NAMtEjekUMY8KEYZ+D8UxmOhh54DzY=;
	b=W0A1hHkZ1YNNbPCN7doh7TJC4nIKokKVyo5fViRQuP9JenJG0qpP/uT9OcBxUEgO2X
	flXoJHsiuggSCa3j/uMQo+ClbRfmE/m+Qrteg8SPL5hED/4xH0DTU9OocJYdqfQ1LV1V
	+sB3EJzhLQplJDkq2TRiyxhAKlan6So+M0W3aJABqot2yn4NGTmFxODhsYMQwC7UfRYQ
	raBem8xD9tQ8MZ9WFKr7sbeH+T4X0ipOvCFsmiDvszshAQuGn3SQuUuXkbVkRQzm6BWB
	l4YkNyfxwRN7U/+HVacfQ3hhaFNWNNPm10501ME5py5WwSD9lbZqPSv3z/s4KoGa3B8S
	p21g==
X-Gm-Message-State: APjAAAW9ZOYYpP9F9xA6avhn0LeK4C1GtXWLSwUukuehvJk68YVaSey8
	D8ev3pxG9ljJVWFu8VVn+YaEBHG0GQ9Cx2E1rG8=
X-Google-Smtp-Source: APXvYqzPE/JMLxjhsf0rq8v3/8X4F3wglEyzvocUlHU/U1Jh0nCpkgqnq6gO3NoRDNH9Wl17SvRuZbdBIjat4pJKIBs=
X-Received: by 2002:adf:ecc2:: with SMTP id s2mr15715999wro.258.1557837233466; 
	Tue, 14 May 2019 05:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190514104126.6294-1-marcandre.lureau@redhat.com>
	<20190514104126.6294-3-marcandre.lureau@redhat.com>
	<36d35842-d872-427b-accf-2d206a6c6b61@redhat.com>
In-Reply-To: <36d35842-d872-427b-accf-2d206a6c6b61@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 14 May 2019 14:33:41 +0200
Message-ID: <CAJ+F1CL3KJpE_+XCXUMyffuCPwUOaqZCzHpxqv2q_BKdQVF_4w@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v4 2/3] libvhost-user: fix -Werror=format=
 on ppc64
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Tue, May 14, 2019 at 2:10 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Hi Marc-Andr=C3=A9,
>
> On 5/14/19 12:41 PM, Marc-Andr=C3=A9 Lureau wrote:
> > That should fix the following warning:
> >
> > /home/pm215/qemu/contrib/libvhost-user/libvhost-user.c: In function
> > =E2=80=98vu_set_mem_table_exec_postcopy=E2=80=99:
> > /home/pm215/qemu/contrib/libvhost-user/libvhost-user.c:666:9: error:
> > format =E2=80=98%llx=E2=80=99 expects argument of type =E2=80=98long lo=
ng unsigned int=E2=80=99, but
> > argument 5 has type =E2=80=98__u64=E2=80=99 [-Werror=3Dformat=3D]
> >          DPRINT("%s: region %d: Registered userfault for %llx + %llx\n"=
,
> >          ^
> > /home/pm215/qemu/contrib/libvhost-user/libvhost-user.c:666:9: error:
> > format =E2=80=98%llx=E2=80=99 expects argument of type =E2=80=98long lo=
ng unsigned int=E2=80=99, but
> > argument 6 has type =E2=80=98__u64=E2=80=99 [-Werror=3Dformat=3D]
> > cc1: all warnings being treated as errors
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  contrib/libvhost-user/libvhost-user.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-u=
ser/libvhost-user.c
> > index 40443a3daa..ab85166b15 100644
> > --- a/contrib/libvhost-user/libvhost-user.c
> > +++ b/contrib/libvhost-user/libvhost-user.c
> > @@ -663,8 +663,10 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUs=
erMsg *vmsg)
> >                       __func__, i);
> >              return false;
> >          }
> > -        DPRINT("%s: region %d: Registered userfault for %llx + %llx\n"=
,
> > -                __func__, i, reg_struct.range.start, reg_struct.range.=
len);
> > +        DPRINT("%s: region %d: Registered userfault for %"
> > +               PRIu64 " + %" PRIu64 "\n", __func__, i,
>
> I guess you want PRIx64 in both places here.
>
> I'd put the '%' on the next line:
>
>            DPRINT("%s: region %d: Registered userfault for "
>                   "%" PRIx64 " + %" PRIx64 "\n", __func__, i,
>
> Using PRIx64:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

indeed, thanks
Gerd, can you change it on commit?

--=20
Marc-Andr=C3=A9 Lureau

