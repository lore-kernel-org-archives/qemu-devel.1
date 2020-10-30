Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F957C5517A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 07:35:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95E74221E2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 07:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ujrjISZg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E74221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYOwB-0003i4-Ie
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 03:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYOvZ-0003DE-Hp; Fri, 30 Oct 2020 03:34:25 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:39804)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYOvX-0005Ps-Vz; Fri, 30 Oct 2020 03:34:25 -0400
Received: by mail-ed1-x543.google.com with SMTP id g25so4776797edm.6;
 Fri, 30 Oct 2020 00:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QecOoWQ/HZb8eLncR1EKgGqUdTzbd3QYBazcsejlCn8=;
 b=ujrjISZg77YgswczqnGmqLCmD8a6h4MPRyt1NHmMmnkpJXhbeT0O+rgJX3GZi8Si+G
 rDQQy2PQOnNsF3XnHMVYDOXCJuPB6/0XoU81UkR6yMofcbFZcrJX5FvkALRY0hrLJkDh
 248wTeLxRhp6GMHvTgkum4wjs1iTw4rKjQ8zRRIsL07x7XxJF5bZomRWcCdRhSyzh4Eh
 OUGvXipVheIUlmdsYhB8w29X+83G04YAkrQuHd7PpDPMbls4tSr6AF4Eb8Uvebwf1Rtu
 xcFq8d7jGjV/OA7eeY0MnLVz/t3jEs42qWSICjUZYIAK8btREG2Qj3lmlqizcKYz4yDb
 fdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QecOoWQ/HZb8eLncR1EKgGqUdTzbd3QYBazcsejlCn8=;
 b=Py9C4mw5ugJTWMuyMJJtb/pKoWjnQX1l5F1tRFMD/jFUgVu5mg1XeqFbZXwbF2Okyh
 nB9jHwFL5YO09CJ2hQA89/bbItF5fZTNfq1AW5PmVHtPdx2g+Iar6lPN8W/D73SzDmFn
 6dr3evk2nDaR03rDqqiDcdpIfSalGbdJmlegWUvYrzWX8B9jXGWh9fK/pxFQAkZn7W72
 wvqmPEaLhx6NqTIYfx8EyOu+fUtqpTzhaDFUmGwKrFwT+mLsVXdd9o3gZOcvftZl+9vu
 EB4riSdzTlXCvEhd8JhRr/1YanFOUlhxntaOcFp0KAVGgOZe+9jDMfRJHZDnNmP64Ez3
 QjDg==
X-Gm-Message-State: AOAM533XWGlPSH3aLTd+FnXwprPZhKsIrCaeOBpiJBY51HymCOE/MSsP
 isYjwKLfFzufZaimCHx/PXWdUzwyNxVUwvwkyAA=
X-Google-Smtp-Source: ABdhPJwHdlUXIcvql7BaxkEQ5qq2IjRF1QtV14hIqZo+aMFSkt+speVDDuk/H/QhE4pezbuAlNycJUmN/TXFmcdeYIA=
X-Received: by 2002:a05:6402:6ca:: with SMTP id
 n10mr927720edy.314.1604043261375; 
 Fri, 30 Oct 2020 00:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-10-ehabkost@redhat.com>
 <CAJ+F1CKqo3D20=qSAovVKWCGz4otctaWnGC0O5p-Z1ZG9Pj_Mw@mail.gmail.com>
In-Reply-To: <CAJ+F1CKqo3D20=qSAovVKWCGz4otctaWnGC0O5p-Z1ZG9Pj_Mw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 30 Oct 2020 11:34:09 +0400
Message-ID: <CAJ+F1CKLtKeoP43OV5dpbHLFNO8OnMdsjD=atDo=pjqvFkX2fg@mail.gmail.com>
Subject: Re: [PATCH 09/36] qdev: Make qdev_get_prop_ptr() get Object* arg
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000cc7dc705b2de6c6f"
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Paul Durrant <paul@xen.org>,
 QEMU <qemu-devel@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Qemu-s390x list <qemu-s390x@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000cc7dc705b2de6c6f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 11:29 AM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@gmail.com> wrote:

>
>
> On Fri, Oct 30, 2020 at 2:07 AM Eduardo Habkost <ehabkost@redhat.com>
> wrote:
>
>> Make the code more generic and not specific to TYPE_DEVICE.
>>
>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>>
>
> Nice cleanup!, but fails to build atm
>
> ../hw/block/xen-block.c:403:9: error: =E2=80=98dev=E2=80=99 undeclared (f=
irst use in this
> function); did you mean =E2=80=98vdev=E2=80=99?
>   403 |     if (dev->realized) {
>
>
That seems to be the only issue though, so with that fixed:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000cc7dc705b2de6c6f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 30, 2020 at 11:29 AM Marc=
-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@gmail.com">marcan=
dre.lureau@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 30, 2=
020 at 2:07 AM Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" t=
arget=3D"_blank">ehabkost@redhat.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">Make the code more generic and not spec=
ific to TYPE_DEVICE.<br>
<br>
Signed-off-by: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" t=
arget=3D"_blank">ehabkost@redhat.com</a>&gt;<br></blockquote><div><br></div=
><div>Nice cleanup!, but fails to build atm</div><div><br></div><div>../hw/=
block/xen-block.c:403:9: error: =E2=80=98dev=E2=80=99 undeclared (first use=
 in this function); did you mean =E2=80=98vdev=E2=80=99?<br>=C2=A0 403 | =
=C2=A0 =C2=A0 if (dev-&gt;realized) {</div><br></div></div></blockquote></d=
iv><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">That see=
ms to be the only issue though, so with that fixed:</div><div class=3D"gmai=
l_quote">Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandr=
e.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div class=3D=
"gmail_quote"><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature">M=
arc-Andr=C3=A9 Lureau<br></div></div>

--000000000000cc7dc705b2de6c6f--

