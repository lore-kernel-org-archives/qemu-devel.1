Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218C3C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:42:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E121020CC7
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hxFUF7OV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E121020CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlaCb-0000CV-7u
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 11:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlaBb-0007x0-6t
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 11:41:11 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44757)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlaBY-00041a-BZ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 11:41:10 -0400
Received: by mail-wr1-x444.google.com with SMTP id b6so2819926wrs.11
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 08:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=F7NF3Qz7EcZtMdOkJZ/CPrOuBVQUVt9qN+hm3bnLr24=;
 b=hxFUF7OVg9dP+i9a6ECrBJ1MagdKt0XN9jxCUcpdJpD0ySnvoXWYHTtoNAOEg7FjLp
 Xmkmp6KiEcuhBomPzWBEJCSm6uWlYR1G50vTRTjML68uB1XTuRDOZFxgZ2Se43DyUM9k
 WFODEELwaT6Cer40jZxSNU+iY2gUG8yJ8ebYhTdqX6ZqGUEqDo9yPRs7oD2HvazM9u5g
 Ywm1P6V8gb9AGJGZccMMjyzX+K6W+aTfP2ZE+b3MpfdjvwfbuQM7YelGqR23DzqgI/Ga
 WYhv5ImlW+oehpey8v4ONBynt5uJS9tCvTgvW0M4gdX874cGmimBGAErBXu13jL7ORJJ
 /g0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=F7NF3Qz7EcZtMdOkJZ/CPrOuBVQUVt9qN+hm3bnLr24=;
 b=nDfCBgyNQoALiOdJl7g3xRAH1SlRbcqe+uED1ryJ5apjmv58F5+7egz2K5WHTyxT8E
 Tx6JTJbZP9ZQxAFPaCu5GuPfZQaO5qG42N0e0ADjUvnUU2y0DafHeSvVVhANbGitsNAq
 6+r3J9AKcnN3cRHviVUsTgFz3Ujo+0Cmowx24r9cHJMbdHIvqD5AFWrrqpVNF1U5vsmB
 f+lAJP2BSESr/+PmuPf12P0M5as9Xbzu/7lZmPNCJIp9vIzxF9UJXSjhlq1yfoPiKzv/
 Vw09aI5vKFAf4yOINEeCLXcbl2cJqRIn+JuN84Y3knwWZe6/FlC6EzvoYNaY9c3xNYec
 pMmw==
X-Gm-Message-State: AOAM532F3d8STnwxX1FR1T2MgoT3BZHVjtdjDVmnWFFkxYC6yp9GcT55
 4J7wDYQ29YYX1Re5t4zLuUJMjA==
X-Google-Smtp-Source: ABdhPJx58+3Gmar3NaDTpVb3em+JTLgLWDpFj4o8maHhHKZWDkfqxEdsN5KaPYu2nZLf42FNbZDGgg==
X-Received: by 2002:adf:fb92:: with SMTP id a18mr9259485wrr.263.1592408466569; 
 Wed, 17 Jun 2020 08:41:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v20sm2306611wrb.51.2020.06.17.08.41.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 08:41:05 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9B1A11FF7E;
 Wed, 17 Jun 2020 16:41:04 +0100 (BST)
References: <20200617134505.9D06E7482D3@zero.eik.bme.hu>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH 2/2] scripts/tracetool: Add plainlog backend
In-reply-to: <20200617134505.9D06E7482D3@zero.eik.bme.hu>
Date: Wed, 17 Jun 2020 16:41:04 +0100
Message-ID: <87k105wvhr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


BALATON Zoltan <balaton@eik.bme.hu> writes:

Did this patch get separated from a larger series (2/2)?

> Add a backend that is the same as the log backend but omits the
> process id and timestamp so logs are easier to read and diff-able.

I'd argue for this to be the behaviour of plain log (given it's mixing
with other log output). If not then maybe plainlog would be the default
log type if nothing is passed to configure?

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  scripts/tracetool/backend/plainlog.py | 48 +++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 scripts/tracetool/backend/plainlog.py
>
> diff --git a/scripts/tracetool/backend/plainlog.py b/scripts/tracetool/ba=
ckend/plainlog.py
> new file mode 100644
> index 0000000000..40bbfa6d76
> --- /dev/null
> +++ b/scripts/tracetool/backend/plainlog.py
> @@ -0,0 +1,48 @@
> +# -*- coding: utf-8 -*-
> +
> +"""
> +Stderr built-in backend, plain log without proc ID and time.
> +"""
> +
> +__author__     =3D "Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>"
> +__copyright__  =3D "Copyright 2012-2017, Llu=C3=ADs Vilanova <vilanova@a=
c.upc.edu>"
> +__license__    =3D "GPL version 2 or (at your option) any later version"
> +
> +__maintainer__ =3D "Stefan Hajnoczi"
> +__email__      =3D "stefanha@linux.vnet.ibm.com"
> +
> +
> +from tracetool import out
> +
> +
> +PUBLIC =3D True
> +
> +
> +def generate_h_begin(events, group):
> +    out('#include "qemu/log-for-trace.h"',
> +        '')
> +
> +
> +def generate_h(event, group):
> +    argnames =3D ", ".join(event.args.names())
> +    if len(event.args) > 0:
> +        argnames =3D ", " + argnames
> +
> +    if "vcpu" in event.properties:
> +        # already checked on the generic format code
> +        cond =3D "true"
> +    else:
> +        cond =3D "trace_event_get_state(%s)" % ("TRACE_" + event.name.up=
per())
> +
> +    out('    if (%(cond)s && qemu_loglevel_mask(LOG_TRACE)) {',
> +        '        qemu_log("%(name)s " %(fmt)s "\\n" %(argnames)s);',
> +        '    }',
> +        cond=3Dcond,
> +        name=3Devent.name,
> +        fmt=3Devent.fmt.rstrip("\n"),
> +        argnames=3Dargnames)
> +
> +
> +def generate_h_backend_dstate(event, group):
> +    out('    trace_event_get_state_dynamic_by_id(%(event_id)s) || \\',
> +        event_id=3D"TRACE_" + event.name.upper())


--=20
Alex Benn=C3=A9e

