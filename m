Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF6DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 07:01:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60830206F1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 07:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60830206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZULW-0000i6-Hj
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 03:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jZUKe-00080q-GF; Fri, 15 May 2020 03:00:32 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:37063)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jZUKc-0003IQ-E8; Fri, 15 May 2020 03:00:31 -0400
Received: by mail-ej1-f66.google.com with SMTP id l21so1367169eji.4;
 Fri, 15 May 2020 00:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=paM8N59x/1u1Pc1lakMLHVTYb3X1cVpISIuyc1pkY5E=;
 b=blQ7VbfmfUKdbQ/RStMbTjL1RB88ANf/kVUaAVsdrIzRf/UByI9Vp7K+LsqW5cJiEa
 ZgJ4edbduygVGGYb/2id5//eJsA7vHmxMeXlknV7ic8rkWSUz/fyiH70GBIXRp/OREFJ
 hAiBRjMI8Oex/cvE2lxB3/PX0jSFAvAlgnJS2qahLDSH+hJSO8yuufzUlNIHNBUc/U1m
 hV8FCSdurfjf/JRX3wXzHEwqJ2Q5hTzFZ7UoU9kVe8GAyF/oHOQa5V7EO+SnRJBLJ+y/
 t+g/xFA9E5rd3yyAj+Igj++On+V43JCsTBvAICdqzFiNCeVfjoF/jVHSALX+atzTJBcU
 lHZw==
X-Gm-Message-State: AOAM531+KnJS9T2EEeOHOGptqn50qRS/Bq72eg5xESES/vpYJBP4arCA
 25UoSPRspB/QtTrYhq8SD/qoWb3AN1lNvSq6G0A=
X-Google-Smtp-Source: ABdhPJw0Mx3A+BG3xC5h0Lfmuuu8NPGmLj7QFQ0Afgw3FGp/vwDzLxD8DQr73eenJB/Bi9NKbQK0XgXvF2yNODsadXM=
X-Received: by 2002:a17:906:5e50:: with SMTP id
 b16mr1459147eju.331.1589526028556; 
 Fri, 15 May 2020 00:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200504115656.6045-1-f4bug@amsat.org>
 <20200504115656.6045-2-f4bug@amsat.org>
 <87wo5drasi.fsf@dusky.pond.sub.org>
In-Reply-To: <87wo5drasi.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 15 May 2020 09:00:17 +0200
Message-ID: <CAAdtpL4wpqv8vMOFgRubghr53fJyoXJ+DcGwi84wp0PiczyUpg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] qom/object: Move Object typedef to
 'qemu/typedefs.h'
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.218.66;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-f66.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 03:00:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 Michael Tokarev <mjt@tls.msk.ru>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 15, 2020 at 8:07 AM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>
> > We use the Object type all over the place.
> > Forward declare it in "qemu/typedefs.h".
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> >  include/qemu/typedefs.h   | 1 +
> >  include/qom/object.h      | 2 --
> >  include/qom/qom-qobject.h | 2 --
> >  include/sysemu/sysemu.h   | 1 -
> >  4 files changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> > index 375770a80f..b03ec9f40a 100644
> > --- a/include/qemu/typedefs.h
> > +++ b/include/qemu/typedefs.h
> > @@ -75,6 +75,7 @@ typedef struct NetFilterState NetFilterState;
> >  typedef struct NICInfo NICInfo;
> >  typedef struct NodeInfo NodeInfo;
> >  typedef struct NumaNodeMem NumaNodeMem;
> > +typedef struct Object Object;
> >  typedef struct ObjectClass ObjectClass;
> >  typedef struct PCIBridge PCIBridge;
> >  typedef struct PCIBus PCIBus;
> > diff --git a/include/qom/object.h b/include/qom/object.h
> > index 784c97c0e1..1edc12e64c 100644
> > --- a/include/qom/object.h
> > +++ b/include/qom/object.h
> > @@ -20,8 +20,6 @@
> >  struct TypeImpl;
> >  typedef struct TypeImpl *Type;
> >
> > -typedef struct Object Object;
> > -
> >  typedef struct TypeInfo TypeInfo;
> >
> >  typedef struct InterfaceClass InterfaceClass;
> > diff --git a/include/qom/qom-qobject.h b/include/qom/qom-qobject.h
> > index 77cd717e3f..82136e6e80 100644
> > --- a/include/qom/qom-qobject.h
> > +++ b/include/qom/qom-qobject.h
> > @@ -13,8 +13,6 @@
> >  #ifndef QEMU_QOM_QOBJECT_H
> >  #define QEMU_QOM_QOBJECT_H
> >
> > -#include "qom/object.h"
> > -
> >  /*
> >   * object_property_get_qobject:
> >   * @obj: the object
> > diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> > index ef81302e1a..ca4458e451 100644
> > --- a/include/sysemu/sysemu.h
> > +++ b/include/sysemu/sysemu.h
> > @@ -5,7 +5,6 @@
> >  #include "qemu/timer.h"
> >  #include "qemu/notify.h"
> >  #include "qemu/uuid.h"
> > -#include "qom/object.h"
> >
> >  /* vl.c */
>
> How did you identify the inclusions to drop?

Nothing very strict I'm afraid. I suppose I had the files opened in my edit=
or.

The output of
$ git grep -L -E '(OBJECT_|INTERFACE_)' $(git grep -l qom/object include)
suggests I missed those:

-- >8 --
diff --git a/include/hw/display/edid.h b/include/hw/display/edid.h
index ff99dc0a05..5b1de57f24 100644
--- a/include/hw/display/edid.h
+++ b/include/hw/display/edid.h
@@ -1,8 +1,6 @@
 #ifndef EDID_H
 #define EDID_H

-#include "qom/object.h"
-
 typedef struct qemu_edid_info {
     const char *vendor; /* http://www.uefi.org/pnp_id_list */
     const char *name;
diff --git a/include/io/task.h b/include/io/task.h
index 1abbfb8b65..6818dfedd0 100644
--- a/include/io/task.h
+++ b/include/io/task.h
@@ -21,8 +21,6 @@
 #ifndef QIO_TASK_H
 #define QIO_TASK_H

-#include "qom/object.h"
-
 typedef struct QIOTask QIOTask;

 typedef void (*QIOTaskFunc)(QIOTask *task,
---

