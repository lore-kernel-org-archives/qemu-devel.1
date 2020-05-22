Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B13FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 19:45:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E728F20723
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 19:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q5iSKve0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E728F20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcDbn-0001RA-3i
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 15:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcDb5-00009R-8s
 for qemu-devel@nongnu.org; Fri, 22 May 2020 15:44:47 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:42015)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcDb4-0003qT-2J
 for qemu-devel@nongnu.org; Fri, 22 May 2020 15:44:46 -0400
Received: by mail-lf1-x143.google.com with SMTP id x27so7162400lfg.9
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 12:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=YwQCbfcoMoCJQKPHHhOEc/8HeG8au22CdYSO7DOc4N4=;
 b=Q5iSKve0u05GwLwDgEUv21sSTHUI4zY1sS3dSwmOHxI0vO+Ojihz7qapxJge0HATJO
 M7hFOs2V987NKp4uk+ClYG89Ww5dxpaO6ZyTAfiFp82QSru2IsOnEpqqhCFdgZRTZQbK
 XeJ6UK/8oLJ72I8tgRCUXUHXZ0NEbA0fF5kKmsPBw7cWWKySOcod5EL460b58yEbFTAQ
 L9jzux4/oGMs9qboSPyebfgk+FmNnm/hu+mhAFO/2NLfUrGIeCZjr/k9YAt4uRT2qNHU
 VcOIQfr6ciX36wwiI7NzTlQ44aKbrNgl6X+gu+xzHTS78AtLcAZjrjrlPnJW0eIOXaUl
 OxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=YwQCbfcoMoCJQKPHHhOEc/8HeG8au22CdYSO7DOc4N4=;
 b=Jq3ha4K7WKj/ZzFV1lu6FNN6f8s6B5Wd8hg6VwNz/zT10cRHjQCFhwe/fWn9B/X5Ob
 /WtzfZJP+F3qiWhKsLeJW8Kd+GoqLmBfJ5MQpCfJxRGauKGvx2N6DcO7dDEAwxJj4e36
 Vh5kuyupNCQZDen1WgtTBNqnIieD3LC0axX+SjUZ7FX0oJ/7ISfuMsOXSA3NdJHl3sjS
 sdhdq9xA8HmvnAJfjxp3MaEevsnkguRx9q+HLY1ZWdcDdGiSZb/Tq5GYWE9RZeJ0cmVe
 OPYYZdv5jaz224wIHZ3XKtBZkP9gNAV0hyR8x3YVfqHO9os1qRkdoQypQPns5dCEDfOr
 a+9Q==
X-Gm-Message-State: AOAM530Y+57uZMCPO3TVsR/8o+gC9aH6HMhlAMyejDIKJSVT1DLhW9Fz
 EbRrmKRjWMasJgbqvUrn+/6QkyDrwuiI4IGgcBdiDA==
X-Google-Smtp-Source: ABdhPJytH6AqQBA+YEPHdmDcVQYsZGXA36H/aokm3KWJ6WEz26IjrT49AvQd4fhmYsKKLeptwrfh4Eb0ET840Np9XNg=
X-Received: by 2002:ac2:5cd1:: with SMTP id f17mr7680786lfq.4.1590176683906;
 Fri, 22 May 2020 12:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200519132259.405-1-robert.foley@linaro.org>
 <20200519132259.405-11-robert.foley@linaro.org>
 <87367sdkoz.fsf@linaro.org>
In-Reply-To: <87367sdkoz.fsf@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Fri, 22 May 2020 15:44:37 -0400
Message-ID: <CAEyhzFvRGOJU94V2+S-GxryqT23DRKVbK_CzTwJ3sOAiEx=kjQ@mail.gmail.com>
Subject: Re: [PATCH v7 10/12] tests/vm: Added a new script for centos.aarch64.
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=robert.foley@linaro.org; helo=mail-lf1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 22 May 2020 at 11:59, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Robert Foley <robert.foley@linaro.org> writes:
>
> > centos.aarch64 creates a CentOS 8 image.
> > Also added a new kickstart script used to build the centos.aarch64 imag=
e.
> >
> > Signed-off-by: Robert Foley <robert.foley@linaro.org>
> > Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
> > ---
> <snip>
> > --- /dev/null
> > +++ b/tests/vm/centos.aarch64
> > @@ -0,0 +1,227 @@
> > +#!/usr/bin/env python3
> > +#
> > +# Centos aarch64 image
> > +#
> > +# Copyright 2020 Linaro
> > +#
> > +# Authors:
> > +#  Robert Foley <robert.foley@linaro.org>
> > +#  Originally based on ubuntu.aarch64
> > +#
> > +# This code is licensed under the GPL version 2 or later.  See
> > +# the COPYING file in the top-level directory.
> > +#
> > +
> > +import os
> > +import sys
> > +import subprocess
> > +import basevm
> > +import time
> > +import traceback
>
> left over debug?

This traceback is getting used as part of a try, except, here in
wait_for_shutdown() to print out the exception info.

Thanks & Regards,
-Rob
>
> <snip>
>
> Otherwise:
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> --
> Alex Benn=C3=A9e

