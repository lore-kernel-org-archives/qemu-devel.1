Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7734DC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 16:11:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 422082080D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 16:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nl/d6//f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422082080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyeJj-0007B9-Gk
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 11:11:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42327)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iyeJ6-0006Z4-G9
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:10:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iyeJ5-0007hU-8Y
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:10:40 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40183)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iyeJ5-0007Ys-1Z
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:10:39 -0500
Received: by mail-wr1-x444.google.com with SMTP id j104so18947590wrj.7
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 08:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=uhSBnxvR34+LnrY6ui2IlNorZHurJTBtkIke997n9iw=;
 b=Nl/d6//fl6SYwIV1uBGK8zMQFLMk5LZ6Htyc3Vqb7QwbhCnPIxKY/h2BC61xpNNuAy
 rwi3K1ccXFIWt++JuO+PLuW2+FBCJtkoLwdQ3TWo8OB/hYl8i2WUnkS6ISZlHYd/oKkR
 7pzkGZgQCC7jzMy/aQpaWfGgP9mAOuR79qdyqSIcIlURuITKFyIUyczxRu2YpdHD+HTP
 YaFcQW8uUulx315SPeH8q0i9E+MUwImytjB7HHE0YhiqxQJr7GsaTCbNFcpT+wra+7q6
 6+2yj7HzDalFCAgtqSHbJOSt72btk0caNlL32QP1cHY+d7AB7BOgcxM1cT9cnO9a6PKZ
 4jSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=uhSBnxvR34+LnrY6ui2IlNorZHurJTBtkIke997n9iw=;
 b=fgnlDeUSKiaGweTqu0rmHRIxAnhPdiMdCYCwNCS9xFTp04mVmhgM5x5pcUoqRfUNY7
 5GH1mWFhlUsELW3sCoJWz3N6mwamyViE6nEpIRCw74rWLRbPzF/nIUGQk23XV8ptFWUS
 CT+2UHnPlQrRwjwB/sVbQpUHm1rxrqzVVRK9x5dsEAVEd2izRWw8GShgyMmKXexDK0iO
 MwSuI0Z/t1f9hqSsAW+KtzXY/WUEXeob3YNTUbDHO8EeKpZ83wOxGX8oMfQeNtXTgdVz
 m5t8yVYAwNAXPoP4pnW00AdS2C8vczZ6UjorTQVhFr9nH/X6I9RIKABVK5i20TVNJzln
 aDgQ==
X-Gm-Message-State: APjAAAXrD6DVasHj4rR3nI5NIHt+hLYQcI5+gjvGnlVDR33/snK8cnkk
 qU607lxBBulvhonw32ROcxwdoTVOs/3Z55rOZMCel3KsihM=
X-Google-Smtp-Source: APXvYqzN/go24Al9jIPNClD1IQB7RPycpUxSE7EHfeL8/sl1b+kzyH07aekjoye2HMStuqsekw2T5hY89j/sWY3h1bQ=
X-Received: by 2002:a5d:550f:: with SMTP id b15mr16196961wrv.196.1580746236898; 
 Mon, 03 Feb 2020 08:10:36 -0800 (PST)
MIME-Version: 1.0
References: <20200203155412.7706-1-felipe@nutanix.com>
 <22DFA157-0F41-4657-A165-D625210B87A7@nutanix.com>
In-Reply-To: <22DFA157-0F41-4657-A165-D625210B87A7@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 3 Feb 2020 17:10:25 +0100
Message-ID: <CAJ+F1CL2kTSKTHW5VB=590mh+EJS=iu_at21HtvbbnuvYCBpSw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Improve default object property_add uint helpers
To: Felipe Franciosi <felipe@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Phillipe Mathieu-Daude <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, Feb 3, 2020 at 5:08 PM Felipe Franciosi <felipe@nutanix.com> wrote:
>
> Oops, I completely forgot to add a "v5" on the subject line.
>
> (The changelog is there.)
>
> Let me know if I should resend.
>
> F.
>
> > On Feb 3, 2020, at 3:54 PM, Felipe Franciosi <felipe@nutanix.com> wrote=
:
> >
> > This improves the family of object_property_add_uintXX_ptr helpers by e=
nabling
> > a default getter/setter only when desired. To prevent an API behavioura=
l change
> > (from clients that already used these helpers and did not want a setter=
), we
> > add a OBJ_PROP_FLAG_READ flag that allow clients to only have a getter.=
 Patch 1
> > enhances the API and modify current users.
> >
> > While modifying the clients of the API, a couple of improvement opportu=
nities
> > were observed in ich9. These were added in separate patches (2 and 3).
> >
> > Patch 4 cleans up a lot of existing code by moving various objects to t=
he
> > enhanced API. Previously, those objects had their own getters/setters t=
hat only
> > updated the values without further checks. Some of them actually lacked=
 a check
> > for setting overflows, which could have resulted in undesired values be=
ing set.
> > The new default setters include a check for that, not updating the valu=
es in
> > case of errors (and propagating them). If they did not provide an error
> > pointer, then that behaviour was maintained.
> >
> > Felipe Franciosi (4):
> >  qom/object: enable setter for uint types
> >  ich9: fix getter type for sci_int property
> >  ich9: Simplify ich9_lpc_initfn
> >  qom/object: Use common get/set uint helpers
> >
> > hw/acpi/ich9.c       |  99 ++------------------
> > hw/acpi/pcihp.c      |   7 +-
> > hw/acpi/piix4.c      |  12 +--
> > hw/isa/lpc_ich9.c    |  27 ++----
> > hw/misc/edu.c        |  13 +--
> > hw/pci-host/q35.c    |  14 +--
> > hw/ppc/spapr.c       |  18 +---
> > hw/ppc/spapr_drc.c   |   3 +-
> > include/qom/object.h |  48 ++++++++--
> > memory.c             |  15 +--
> > qom/object.c         | 214 ++++++++++++++++++++++++++++++++++++++-----
> > target/arm/cpu.c     |  22 +----
> > target/i386/sev.c    | 106 ++-------------------
> > ui/console.c         |   4 +-
> > 14 files changed, 283 insertions(+), 319 deletions(-)
> >
> > --
> > 2.20.1
> >
> > Changelog:
> > v1->v2:
> > - Update sci_int directly instead of using stack variable
> > - Defining an enhanced ObjectPropertyFlags instead of just 'readonly'
> > - Erroring out directly (instead of using gotos) on default setters
> > - Retaining lack of errp passing when it wasn't there
> > v2->v3:
> > - Rename flags _RD to _READ and _WR to _WRITE
> > - Add a convenience _READWRITE flag
> > - Drop the usage of UL in the bit flag definitions
> > v3->v4:
> > - Drop changes to hw/vfio/pci-quirks.c
> > v4->v5:
> > - Rebase on latest master
> > - Available here: https://github.com/franciozzy/qemu/tree/autosetters

Thanks for the rebase, it looks good overall, but:

qom/object.c:2707:1: error: control reaches end of non-void function
[-Werror=3Dreturn-type]


--=20
Marc-Andr=C3=A9 Lureau

