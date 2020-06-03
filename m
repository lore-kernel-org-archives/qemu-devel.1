Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26105C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:09:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7204205CB
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4paOWko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7204205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgVxU-0005Ix-0r
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 12:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chmeeedalf@gmail.com>)
 id 1jgVwq-0004ke-RA; Wed, 03 Jun 2020 12:09:00 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:45551)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chmeeedalf@gmail.com>)
 id 1jgVwp-0002NS-VF; Wed, 03 Jun 2020 12:09:00 -0400
Received: by mail-io1-xd42.google.com with SMTP id y5so2836099iob.12;
 Wed, 03 Jun 2020 09:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/NXu/ihROj2eWZnXpU7QuqhGoESBH43VRMVMSBP30V0=;
 b=U4paOWkosy/2heC0Fv8LKiJlpTp3QlMQQ2rNT49e7cwWOs/jyGeoWR67/5aIvW/9Wd
 KN0CpLNy9zwYB3R72678rnMSBo4D6FjDX8csPn4DBrHWjlBAAT+9KoV8XGL1WtKlKf0n
 3or8bwvRVVWy27Ish28jCoDGC3etPQtv+2JNGJP631zrWxAEXQ0B63BfV3QwQYmYngKR
 jdL/D1Wu24qiDXDm+kGs06bowVTOsHfFWuQg+DOCB0YD5X2rnL/+1UY2Ja6ZXIMbFPGL
 HV9AcQ8dBmb4Vatlp2gmYZOmP951mHMgqeTTKJuju3nzLJQdwWqU7AjVqMR8g5zh8zX+
 tSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/NXu/ihROj2eWZnXpU7QuqhGoESBH43VRMVMSBP30V0=;
 b=mlMMTYpwLG5fEHPKF5LLfNYb0T9U3I948Ae+FMRWzwIRHLvnu3717xSx49Aq1mGpfV
 bDyJcVJmmUH5nkw1G2wkHydtwTkStb0P03JVk0q0F2VVYm6I/TmIy0NSFlE+sSq5zK6v
 8sZ1iwDGg+rYIy3EYJqwVZY7aZn0qTQwaOuoxToa/yo+Mixd9o77ADej4b0EiP3udK8/
 fOcv51uxPceiYmeBmLh/VcWphQnv4yewJol9l45A3SqmAhOGMlIBNdeam3twFDcI9A+M
 HWGYmV/kM+vs8LocPqPsu2WBf1LQgke/dEb9susZEfhoxiu0N0Mhb7L1DlE4MWvJ4hkt
 xl0w==
X-Gm-Message-State: AOAM531ujUmZE7cajG27g0nz4FKgWRYXZ7vkHpQkWVip6vnM6t1TEtAK
 kGJf0CLt7U9ZovueE4thuh4=
X-Google-Smtp-Source: ABdhPJxE1zjSF4PXOj8ieiwIjTt2w2cXL6y42wyiWQpjr//zojANjiWc9CAjYPkt1EunemGx71S/pg==
X-Received: by 2002:a05:6602:224a:: with SMTP id
 o10mr431309ioo.90.1591200538419; 
 Wed, 03 Jun 2020 09:08:58 -0700 (PDT)
Received: from titan.knownspace (173-19-125-130.client.mchsi.com.
 [173.19.125.130])
 by smtp.gmail.com with ESMTPSA id h14sm3173ilo.10.2020.06.03.09.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2020 09:08:58 -0700 (PDT)
Date: Wed, 3 Jun 2020 11:08:54 -0500
From: Justin Hibbits <chmeeedalf@gmail.com>
To: Philippe =?UTF-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] util/oslib-posix : qemu_init_exec_dir implementation
 for MacOS
Message-ID: <20200603110854.76776717@titan.knownspace>
In-Reply-To: <4e3b6904-5dfe-0608-88e9-2e051265fcd2@redhat.com>
References: <CA+XhMqwH6btbKFD0Ei47e+QHN2eBPG5H2PTS92MAje2Tij4Y=A@mail.gmail.com>
 <76587685-fa03-6dd6-5ca3-caeaf3c7504b@redhat.com>
 <20200603090921.64351a28@titan.knownspace>
 <4e3b6904-5dfe-0608-88e9-2e051265fcd2@redhat.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; powerpc64-portbld-freebsd13.0)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=chmeeedalf@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: qemu-trivial@nongnu.org, Roman Bolshakov <r.bolshakov@yadro.com>,
 qemu-devel@nongnu.org, John Arbuckle <programmingkidx@gmail.com>,
 David CARLIER <devnexen@gmail.com>, Izik Eidus <izik@veertu.com>,
 pbonzini@redhat.com, Mikhail Gusarov <dottedmag@dottedmag.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jun 2020 16:36:27 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 6/3/20 4:09 PM, Justin Hibbits wrote:
> > On Wed, 3 Jun 2020 08:08:42 +0200
> > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> >  =20
> >> Cc'ing more developers.
> >>
> >> On 5/26/20 10:40 PM, David CARLIER wrote: =20
> >>> From b24a6702beb2a4e2a9c1c03b69c6d1dd07d4cf08 Mon Sep 17 00:00:00
> >>> 2001 From: David Carlier <devnexen@gmail.com>
> >>> Date: Tue, 26 May 2020 21:35:27 +0100
> >>> Subject: [PATCH] util/oslib: current process full path resolution
> >>> on MacOS
> >>>
> >>> Using existing libproc to fill the path.
> >>>
> >>> Signed-off-by: David Carlier <devnexen@gmail.com>
> >>> ---
> >>>  util/oslib-posix.c | 13 +++++++++++++
> >>>  1 file changed, 13 insertions(+)
> >>>
> >>> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> >>> index 062236a1ab..96f0405ee6 100644
> >>> --- a/util/oslib-posix.c
> >>> +++ b/util/oslib-posix.c
> >>> @@ -55,6 +55,10 @@
> >>>  #include <sys/sysctl.h>
> >>>  #endif
> >>>
> >>> +#ifdef __APPLE__
> >>> +#include <libproc.h>
> >>> +#endif
> >>> +
> >>>  #include "qemu/mmap-alloc.h"
> >>>
> >>>  #ifdef CONFIG_DEBUG_STACK_USAGE
> >>> @@ -366,6 +370,15 @@ void qemu_init_exec_dir(const char *argv0)
> >>>              p =3D buf;
> >>>          }
> >>>      }
> >>> +#elif defined(__APPLE__)
> >>> +    {
> >>> +        uint32_t len;
> >>> +        len =3D proc_pidpath(getpid(), buf, sizeof(buf) - 1);
> >>> +        if (len > 0) {
> >>> +            buf[len] =3D 0;
> >>> +            p =3D buf;
> >>> +        }
> >>> +    }
> >>>  #endif
> >>>      /* If we don't have any way of figuring out the actual
> >>> executable location then try argv[0].  */
> >>>    =20
> >> =20
> >=20
> > Apologies, I don't have context for this.  Why was I CC'd on this? =20
>=20
> I did after finding this patch of yours:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg639033.html

Ah, okay, thanks.  I haven't contributed much to qemu, so was curious.

- Justin

