Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7A1C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 10:33:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE20321655
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 10:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uJY2pXbw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE20321655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46655 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSJ8P-0007jR-NA
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 06:33:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hSJ7f-0007Qg-QY
	for qemu-devel@nongnu.org; Sun, 19 May 2019 06:32:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hSJ7e-0000Xl-Pe
	for qemu-devel@nongnu.org; Sun, 19 May 2019 06:32:55 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:45895)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hSJ7e-0000X9-J6
	for qemu-devel@nongnu.org; Sun, 19 May 2019 06:32:54 -0400
Received: by mail-ed1-x543.google.com with SMTP id g57so18645315edc.12
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 03:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=ldvGV5dt3U5CH5tHgGE32f41mHDfeQEl0LUxd4CFfks=;
	b=uJY2pXbwsEAa7YxZxX/1aFh7hQPRnsBSFsAVkO26VTuzizclIfwrU95V/9LiDRmwUB
	7czp2oj9VVPSD4T0X/NsLAclZGTRlloZ5lQRrG/MokJg1HbOI8fDEcrz0R2Rn4nrjTzz
	Na58QMSSZrVOzJhL9DHMBNkoPBuqLRUgIpuYEyN1RbznDzV0TMgB8vSPmGd747B1hegR
	I49eiDkOvk2WUvTOp+GU/etI3yw1sODL4+3kXHvf+brwcJxhX3QELO+DGCYMZKQtTTyy
	gUBk9UvpVq7bEdMzGYfAWznMlbRkx4ku8kiEO8Q4mmQgx6PpO/SQfDZ2KOd7ZSwCT06S
	5MeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=ldvGV5dt3U5CH5tHgGE32f41mHDfeQEl0LUxd4CFfks=;
	b=l3YnSYn3W89KDXR3Vy8QfkRdaiib8ymusH0TyHiwhHWEZEYtzyRE6C53nP00SzEDrN
	aIuvo9Iz7u2YRwcrP3Dswwt4UWjBaGnk59XTrZqhOkla2VdS5T6dofAcgvu0sesMUjH8
	F6MjNsjBMBcqJb6IBbiu4nBnoukr5oCCXw07x8bwVayMDounlIMpuWEGM5g70x1wjrgQ
	YQ6aPnWj9jcuTo585qCibWnN+s79FJINYMrbloXmSVCrSqFBOZ9ezDc2+rQrdEMKakjF
	1m94pNt8PZclUElAXwZgGGHP8PCX/fknMStDmQi+F41O1LUZ24YtA9j9vxEwGjNow27i
	CAJw==
X-Gm-Message-State: APjAAAViph+8+PHCfNK6qO/YyzELOiMDtBpUGj28Nb6puvcfc1hOv8uP
	TzubtH7Hm+eYN+fi7LTVEryZAGcgeNA4h4v789ZF/w==
X-Google-Smtp-Source: APXvYqzVj+6UuaXkVoeHMQVTzwIrluSU5V6FKmfLAZeTHxtf7wseZMOG1ngCqEMGTIaCBAhZChVJId/eUmtAjn3XnEU=
X-Received: by 2002:a17:906:c355:: with SMTP id
	ci21mr27897345ejb.202.1558261972525; 
	Sun, 19 May 2019 03:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190502081554.5521-1-arilou@gmail.com>
	<20190502081554.5521-10-arilou@gmail.com>
	<87v9ybncdp.fsf@zen.linaroharston>
In-Reply-To: <87v9ybncdp.fsf@zen.linaroharston>
From: Jon Doron <arilou@gmail.com>
Date: Sun, 19 May 2019 13:32:41 +0300
Message-ID: <CAP7QCogCF-aQNt2ChpoXExCJydQB9ZhnrP6CdF9RJiFy5hA=SA@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::543
Subject: Re: [Qemu-devel] [PATCH v9 09/27] gdbstub: Implement set register
 (P pkt) with new infra
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

You are right but I was under the impression you want the patches to
have the exact same logic of the original code, that why i kept
adding those null packets and the parameter checks to be < N rather than !=
=3D

Now that I understand you prefer to fix the implementation ill review
all the patches and add error replays accordingly

-- Jon.

On Wed, May 15, 2019 at 3:14 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
>
> Jon Doron <arilou@gmail.com> writes:
>
> > Signed-off-by: Jon Doron <arilou@gmail.com>
> > ---
> >  gdbstub.c | 39 ++++++++++++++++++++++++++++++---------
> >  1 file changed, 30 insertions(+), 9 deletions(-)
> >
> > diff --git a/gdbstub.c b/gdbstub.c
> > index b42425b24c..10e3f12a68 100644
> > --- a/gdbstub.c
> > +++ b/gdbstub.c
> > @@ -1634,6 +1634,27 @@ static void handle_remove_bp(GdbCmdContext *gdb_=
ctx, void *user_ctx)
> >      put_packet(gdb_ctx->s, "E22");
> >  }
> >
> > +static void handle_set_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
> > +{
> > +    int reg_size;
> > +
> > +    if (!gdb_has_xml) {
> > +        put_packet(gdb_ctx->s, "");
> > +        return;
> > +    }
> > +
> > +    if (gdb_ctx->num_params < 2) {
>
> !=3D 2?
>
> > +        put_packet(gdb_ctx->s, "");
> > +        return;
> > +    }
>
> I don't understand what these null put_packets have been added for.
> Should we not report an E code on failure?
>
> > +
> > +    reg_size =3D strlen(gdb_ctx->params[1].data) / 2;
> > +    hextomem(gdb_ctx->mem_buf, gdb_ctx->params[1].data, reg_size);
> > +    gdb_write_register(gdb_ctx->s->g_cpu, gdb_ctx->mem_buf,
> > +                       gdb_ctx->params[0].val_ull);
> > +    put_packet(gdb_ctx->s, "OK");
> > +}
> > +
> >  static int gdb_handle_packet(GDBState *s, const char *line_buf)
> >  {
> >      CPUState *cpu;
> > @@ -1878,15 +1899,15 @@ static int gdb_handle_packet(GDBState *s, const=
 char *line_buf)
> >          }
> >          break;
> >      case 'P':
> > -        if (!gdb_has_xml)
> > -            goto unknown_command;
> > -        addr =3D strtoull(p, (char **)&p, 16);
> > -        if (*p =3D=3D '=3D')
> > -            p++;
> > -        reg_size =3D strlen(p) / 2;
> > -        hextomem(mem_buf, p, reg_size);
> > -        gdb_write_register(s->g_cpu, mem_buf, addr);
> > -        put_packet(s, "OK");
> > +        {
> > +            static const GdbCmdParseEntry set_reg_cmd_desc =3D {
> > +                .handler =3D handle_set_reg,
> > +                .cmd =3D "P",
> > +                .cmd_startswith =3D 1,
> > +                .schema =3D "L?s0"
> > +            };
> > +            cmd_parser =3D &set_reg_cmd_desc;
> > +        }
> >          break;
> >      case 'Z':
> >          {
>
>
> --
> Alex Benn=C3=A9e

