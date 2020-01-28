Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0E1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 15:55:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BAD421739
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 15:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkoPrYsU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BAD421739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwTDH-0007Jc-P8
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 10:55:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41411)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iwTCd-0006mD-Ic
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 10:55:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iwTCc-0005MA-9s
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 10:54:59 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50913)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iwTCc-00052P-2s
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 10:54:58 -0500
Received: by mail-wm1-x344.google.com with SMTP id a5so3092062wmb.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 07:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=HB7SeHHUSQXQG4v7+wOM1mxRcavZ7ji8aB1K9EBg+O0=;
 b=NkoPrYsUzFcushWd72ijYcW4u3SqxwaAUlYc+/iv0aBMSljewg+m5qKvqJiHvK9OAj
 H/IzlThErDc7faJ0CsJruzZY9F/VZ/oeAdp2GHufgOTMHJlBnKmGqIyQ4Yn6WFke1tjU
 WLqWrWP6rS+oOkas2WBbges4TWmVnKQPb518xHrFltNbErzPCwPpwnJ1LaNBCS+3kN9R
 ZogLliFoXJlAd0coW0yVi6/o9/DKKLlTtNCne6d4gg5fs1kC0O5RDY1hpFxp41SI7A3o
 l39QL8doBYdSjcbXKdF4acU3xSnk8tMxILsHlbU/O8mr7mIFqVUNwfgOESWg/mI0E0KD
 oInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HB7SeHHUSQXQG4v7+wOM1mxRcavZ7ji8aB1K9EBg+O0=;
 b=EvJy46Z5nmSmfW+uM9wD18cen636htraDVOowTFhS3IRDS2/4b8G46godUlzrHBqxo
 HAhNPaeW3PZ2QqTdkkARh/JOeaP2zp1z3RzlL0vCr/GrJklz/Ctuhdjjgl/jrMt0rbgz
 am2IFCNlGbP9Hc4IHjxnrkz0/TYfbECj+nFu/Xj2pB94r8+PDukk3UaEV1v/XJsatJ+E
 xsKbtxhoKkQR4czJL8qdMMC6r5au4IaCw6P82PkmZVG3+rooaTjnlrQq3pBQTTA9NdLp
 hGzbBmZZik0BlubiZcZc36RNa1ipXYX89WqY7ye4lpG7HJXN42KK2rnuBLPgmAn3gkuG
 2RVA==
X-Gm-Message-State: APjAAAXO3pLAyDCUzbVJiki2gQgQYqDxBtwHq97zTFNChnd4zRY4YmAG
 GkJFRJbU1s7BJ61UPdZ8lBb7q0Y4ps/1bmL5bME=
X-Google-Smtp-Source: APXvYqw9AuOqIeCZTblvdb+5cJpQ7rh4PM9s82jewjXCfzfGdQG0WdRfyWEN4NxdysMg9sJwSVRh+j5uiPbmdOfz8Lw=
X-Received: by 2002:a1c:9c87:: with SMTP id f129mr6089368wme.26.1580226896410; 
 Tue, 28 Jan 2020 07:54:56 -0800 (PST)
MIME-Version: 1.0
References: <20191219180205.25191-1-felipe@nutanix.com>
 <CAJ+F1C+YmQFnMmWrJOZpKrqp9pEzUqLF7yP-yB2hwsz6h3L3cA@mail.gmail.com>
 <A7FBEA28-7FDD-46BA-87DD-3EDB5B101571@nutanix.com>
In-Reply-To: <A7FBEA28-7FDD-46BA-87DD-3EDB5B101571@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 28 Jan 2020 16:54:44 +0100
Message-ID: <CAJ+F1CKPnCBkyA5Ep98+ug0NG5wgfZFkt7vDe-FN_25S0hQm3w@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Improve default object property_add uint helpers
To: Felipe Franciosi <felipe@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Phillipe Mathieu-Daude <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Felipe,

On Fri, Jan 24, 2020 at 11:49 AM Felipe Franciosi <felipe@nutanix.com> wrot=
e:
>
> Hi Marc-Andre and Paolo,
>
> > On Dec 20, 2019, at 3:15 PM, Marc-Andr=C3=A9 Lureau <marcandre.lureau@g=
mail.com> wrote:
> >
> > Hi
> >
> > On Thu, Dec 19, 2019 at 10:02 PM Felipe Franciosi <felipe@nutanix.com> =
wrote:
> >>
> >> This improves the family of object_property_add_uintXX_ptr helpers by =
enabling
> >> a default getter/setter only when desired. To prevent an API behaviour=
al change
> >> (from clients that already used these helpers and did not want a sette=
r), we
> >> add a OBJ_PROP_FLAG_READ flag that allow clients to only have a getter=
. Patch 1
> >> enhances the API and modify current users.
> >>
> >> While modifying the clients of the API, a couple of improvement opport=
unities
> >> were observed in ich9. These were added in separate patches (2 and 3).
> >>
> >> Patch 3 cleans up a lot of existing code by moving various objects to =
the
> >> enhanced API. Previously, those objects had their own getters/setters =
that only
> >> updated the values without further checks. Some of them actually lacke=
d a check
> >> for setting overflows, which could have resulted in undesired values b=
eing set.
> >> The new default setters include a check for that, not updating the val=
ues in
> >> case of errors (and propagating them). If they did not provide an erro=
r
> >> pointer, then that behaviour was maintained.
> >>
> >> Felipe Franciosi (4):
> >>  qom/object: enable setter for uint types
> >>  ich9: fix getter type for sci_int property
> >>  ich9: Simplify ich9_lpc_initfn
> >>  qom/object: Use common get/set uint helpers
> >>
> >> hw/acpi/ich9.c       |  99 ++------------------
> >> hw/acpi/pcihp.c      |   7 +-
> >> hw/acpi/piix4.c      |  12 +--
> >> hw/isa/lpc_ich9.c    |  27 ++----
> >> hw/misc/edu.c        |  13 +--
> >> hw/pci-host/q35.c    |  14 +--
> >> hw/ppc/spapr.c       |  18 +---
> >> hw/ppc/spapr_drc.c   |   3 +-
> >> include/qom/object.h |  44 +++++++--
> >> memory.c             |  15 +--
> >> qom/object.c         | 216 ++++++++++++++++++++++++++++++++++++++-----
> >> target/arm/cpu.c     |  22 +----
> >> target/i386/sev.c    | 106 ++-------------------
> >> ui/console.c         |   4 +-
> >> 14 files changed, 282 insertions(+), 318 deletions(-)
> >
> > It conflicts with some recent changes, so you'll need to send a new
> > version, but that one looks good to me:
> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Paolo, is it going through your queue?
>
> I didn't see any response after this. Did the series get lost?

Can you send a rebased version?

thanks



--=20
Marc-Andr=C3=A9 Lureau

