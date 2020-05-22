Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AC9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:02:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10EFC2070A
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dkfuc4hH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10EFC2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcA8O-0003q8-2M
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 12:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jcA5Z-0001aT-LI
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:00:01 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:41529)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jcA5Y-0002cG-FP
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:00:01 -0400
Received: by mail-ed1-x543.google.com with SMTP id g9so9605423edr.8
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 08:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=xLVBusP+1Hr+1soiXbY3KR6hwLEH0cOvVz8buOt/ps8=;
 b=dkfuc4hHhg/LnsQcLntnTBQejbhCCvcQuzUWAOpl7p65sagK9R0JT89qZ5Su4nO4Uu
 3zzmn2n8w6S8DFIr+HrxnV2QUVq5KrKNSG0d5vsYOly3JEO7ttOKpnhpGmqfjj5DuBfS
 tkjSnuKmI1QnGTk+Xb3PyFSiCwJVVBJMSoYspVpttBWkyHgQKGhvka9YN0nK0yiixLOA
 orwEc1AuhvXAtXT1YgdN93SzcZrU7raqlzUyH8rNEvmnovxBfPrnNFJNwT9NxVDBkXxL
 kfmFtFKgwojRjNogD3NKCuFjkC2OL8E+9zssMXL4skaJgy9mhavi5ExRp4up4dIO857G
 qWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=xLVBusP+1Hr+1soiXbY3KR6hwLEH0cOvVz8buOt/ps8=;
 b=NjpM0+0tEoVWIpkCy9SxQ7u6TiQV49vXYAkwaFM6BPX5Hh6e9yTvsXHZPONQU9IFbM
 3o8bxekrtGgmc+5zE7K1I6Y8anCF8+BS9YUZf18SPkzVJGOmxQAXyntDGPocRyqnq5iH
 PwEP+ng6Bx5IAKP0V7cJbQ+oKAR/oCXWGclkMKUHINfGrno85rC1BAQeS/o4S3VpjBwy
 FpL0LQo9vFSfQhE0gdjTE+TGSpDct5qxp803ijwZji9U7BrjrbSvEKSC4K85hJ+5Kzew
 +yNI2YexfhFEwjELl6KHmM7F5HUmuYVEfgmxVzJrmRE1gMzkQBNyHASIKOhJlfGwl25B
 RDwA==
X-Gm-Message-State: AOAM533XjtClBdNRpbRPfMlQ158/353Wrtgj7q8gkqG6a1r/L+gxT/iU
 5x4DvOe+gG2V0rUcM5vS3Msneg==
X-Google-Smtp-Source: ABdhPJxcLFw7jUPnlJiu7bsdlQzNVLQgNGIOPmY4amNLQbd4BHsiq0NnJYqFHMRGYgfF7MUVybG35g==
X-Received: by 2002:a05:6402:2c3:: with SMTP id
 b3mr3670050edx.66.1590163198812; 
 Fri, 22 May 2020 08:59:58 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h12sm8068522ejj.40.2020.05.22.08.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 08:59:57 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CDEF51FF7E;
 Fri, 22 May 2020 16:59:56 +0100 (BST)
References: <20200519132259.405-1-robert.foley@linaro.org>
 <20200519132259.405-11-robert.foley@linaro.org>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v7 10/12] tests/vm: Added a new script for centos.aarch64.
In-reply-to: <20200519132259.405-11-robert.foley@linaro.org>
Date: Fri, 22 May 2020 16:59:56 +0100
Message-ID: <87367sdkoz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x543.google.com
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
Cc: peter.puhov@linaro.org, philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> centos.aarch64 creates a CentOS 8 image.
> Also added a new kickstart script used to build the centos.aarch64 image.
>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
> ---
<snip>
> --- /dev/null
> +++ b/tests/vm/centos.aarch64
> @@ -0,0 +1,227 @@
> +#!/usr/bin/env python3
> +#
> +# Centos aarch64 image
> +#
> +# Copyright 2020 Linaro
> +#
> +# Authors:
> +#  Robert Foley <robert.foley@linaro.org>
> +#  Originally based on ubuntu.aarch64
> +#
> +# This code is licensed under the GPL version 2 or later.  See
> +# the COPYING file in the top-level directory.
> +#
> +
> +import os
> +import sys
> +import subprocess
> +import basevm
> +import time
> +import traceback

left over debug?

<snip>

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

