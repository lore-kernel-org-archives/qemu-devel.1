Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E84C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 01:59:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FE782468D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 01:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwuwUXeN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE782468D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8aMZ-0007BH-Dh
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 20:59:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcfaracco@gmail.com>) id 1j8aLz-0006j9-Gg
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 20:58:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcfaracco@gmail.com>) id 1j8aLy-0004Bx-Iq
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 20:58:43 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:33190)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcfaracco@gmail.com>) id 1j8aLy-0004Bk-A9
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 20:58:42 -0500
Received: by mail-lj1-x243.google.com with SMTP id f13so1070176ljp.0
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2020 17:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GS8uRJURWtQVkmGAxB6eQljx4MiB+B/tzRfhaUt7SZE=;
 b=FwuwUXeNLJ8COvIa3ZXmiBNTfmOgQ050vyjThpNlV3ieGQHdnlo/aXwBVhFNhB2+8h
 Nzw4guceBoJpenuV4+9mcPH+GMpo/BXOIgdnEqP5ZH18dh7LAdgUuWxoAVHF3H1o7JOw
 JOSo9oDlcbRA+RLtEvAf7+Eac9ydH3G06kbewpd5OjPe25fMXSfC8FysYAsW+AWzQFcz
 CzWuM7cRq4huLu7T5XEXc6U58HQxPRRC0XetbP6Ptu+KBB6PYVhIEUQVIQ35Kt3xWXvk
 wTEuOsKbfnyYYBNpS9AZnFME+ZdiU+kyZ5Zd5cPDbNynChVI3SPA34aErrkMPG4NyiQV
 fsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GS8uRJURWtQVkmGAxB6eQljx4MiB+B/tzRfhaUt7SZE=;
 b=ZIFT9M9uL3JtdAgDGkdFc6OcyUQA/msVdk5MU0l4Lb4VRhkLoFjsmo7OqyTC5hAPFo
 trRD0cAXFNieFpSfXfX9bAkYzUS1FWPUOqo7/p5QcXgYCbl8tTylD0uNF3JFoF+AFVFV
 bvY2mjikRX+LfXDfTTOptVG0LAE0Bbsay+rWTzDjoKBYfMbOwqdHZEh9untFNh3I0bV1
 b5mCvVNdMeYZ2/sprYmX/0jEMR1xV2xPawrSYnm0/ob3sD8EPNoFiJBoNVj7uFuowEY/
 rYsbFRTVC8oZgdr5wgSNLmExkLRcVLawOTzombWHLWreo73pPlz/kECGtwWa+LS+Eomv
 BE6Q==
X-Gm-Message-State: ANhLgQ1MirIOK0wUAE9zxncl+E6zVTn29YBUvsoiicrQferevBO/+l4F
 RkRmgBFxfIpCawJZhyb/vQK7GDTF4ebJzdqxkAc=
X-Google-Smtp-Source: ADFU+vsvkTqbGRWuj7yIje8mlmmF4DL4mLS/sYFEGSV51TM2IAXzk9pE1wa1w/qUsvNoskDs4kumcWLWA8GhsibBbe0=
X-Received: by 2002:a2e:9d11:: with SMTP id t17mr10340598lji.169.1583114320802; 
 Sun, 01 Mar 2020 17:58:40 -0800 (PST)
MIME-Version: 1.0
References: <20200301192156.19357-1-jcfaracco@gmail.com>
 <52fadd00-d59a-0096-52a2-f44f49a85d7b@redhat.com>
In-Reply-To: <52fadd00-d59a-0096-52a2-f44f49a85d7b@redhat.com>
From: Julio Faracco <jcfaracco@gmail.com>
Date: Sun, 1 Mar 2020 22:58:29 -0300
Message-ID: <CAENf94+9qHNvCnG05C70=NwUHwwjo050s8oTt0ZB5Q1jpCU7+g@mail.gmail.com>
Subject: Re: [PATCH v3] i386: Fix GCC warning with snprintf when HAX is enabled
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sorry my ignorance, Paolo.
But why should I remove MAX_{VM,VCPU}_ID?

Did you mean that check?
    if (vm_id > MAX_VM_ID || vcpu_id > MAX_VCPU_ID) {
        fprintf(stderr, "Too big vm id %x or vcpu id %x\n", vm_id, vcpu_id)=
;
        return NULL;
    }

Wouldn't it be dangerous?

--
Julio Cesar Faracco

Em dom., 1 de mar. de 2020 =C3=A0s 21:05, Paolo Bonzini
<pbonzini@redhat.com> escreveu:
>
> On 01/03/20 20:21, Julio Faracco wrote:
> > +    assert(vm_id < 0);
> > +
> > +    if (snprintf(name, sizeof HAX_VM_DEVFS, "/dev/hax_vm/vm%02d",
> > +                 vm_id) < 0)
> > +        return NULL;
> > +
> >      return name;
> >  }
> >
> > @@ -140,8 +145,12 @@ static char *hax_vcpu_devfs_string(int vm_id, int =
vcpu_id)
> >          return NULL;
> >      }
> >
> > -    snprintf(name, sizeof HAX_VCPU_DEVFS, "/dev/hax_vm%02d/vcpu%02d",
> > -             vm_id, vcpu_id);
> > +    assert(vm_id < 0 || vcpu_id < 0);
> > +
> > +    if (snprintf(name, sizeof HAX_VCPU_DEVFS, "/dev/hax_vm%02d/vcpu%02=
d",
> > +                 vm_id, vcpu_id) < 0)
>
>
> Can you just replace snprintf with g_strdup_printf instead?  Then you
> can also remove MAX_VM_ID and MAX_VCPU_ID.
>
> Paolo
>

