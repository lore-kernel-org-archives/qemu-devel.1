Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EF9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 21:03:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37CC2206C3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 21:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VU/NXzd4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37CC2206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ju0Av-0002by-Ep
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 17:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ju0AH-00025t-He
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 17:02:37 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38809)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ju0AF-0008Ms-Pi
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 17:02:37 -0400
Received: by mail-wm1-x342.google.com with SMTP id f18so7181655wml.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 14:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=O1y9yYA/o/HzSAWykiYrrgEbKdJXgXx74QYZQ1QKLlA=;
 b=VU/NXzd4xCmmiTN3kvbrudogO21tAqdjotL/MtVDhXr8fsJoOOfxm5p94lcj86HLv8
 Qu/SNgsUu0FJXcNUAUTX3f1JiV3HMHfDgFt84FrE0OEaUFYvsOp6MvcD10bs1Bo+cYwQ
 wEFIgIWeiQ8veQKj/9QRlPteHg9sHB/p+MM57bqo1QwUvuYqWt82EZq0R+3soLGjLTxf
 YonOWARalWRZwck23GuIJSsuF8cJE/MJrEisNCzyScwt/gqlXyIfAEjTIWrC6KiL+qB0
 dPwJOu/pgeDjzqAyaxUIJglW1cmpM91Q8h9HbvggyMQq5/CPB63XysFWezfZbtnwDimA
 EB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=O1y9yYA/o/HzSAWykiYrrgEbKdJXgXx74QYZQ1QKLlA=;
 b=MgRAGjhmuXBikGpzYv9ch563534rs+89r4DBgdqY1IXInOIzx0TKCcW2YejePvp0I3
 NvkfftmZHB0ba47uqv4eMHkZ22/50a+jTOACy3S0JGN5pKQ9/+42Py0lLYvfIocjQFpa
 /DJV0cjYuh3NS7Kk6RZ3vzXfIl6EF+Km1ZVjXZrXDtc5DkrO4K/5nGAYSViwTb/NJvyR
 5cs1mNAAQgh2vebC0wqGJHKYwdjMIfT+aaPLtUW9nRTca7oDOzFJb0rP6ytjA8T82xUv
 WpL0v8DHxomwTHEl9RGFwCrnFCXyQU6yYJTzhspc1UuQjKpjOlgXFERGxZqoqZ9w4s9a
 aenw==
X-Gm-Message-State: AOAM533/OzP4MgOKp02SolXc3Y5hscl2ikDFoVAq4KgogWVcuJgVtJeQ
 msWRZ/+OUXqLtRcdWXthCYn9mA==
X-Google-Smtp-Source: ABdhPJxMfUv3wN89PJ/88haEY9ge2mzDfhkRu2wE+JrsmHvwXaqc0iWkVg8t2lMRyIurrZqIJtATVQ==
X-Received: by 2002:a05:600c:258:: with SMTP id
 24mr6873695wmj.70.1594414953455; 
 Fri, 10 Jul 2020 14:02:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u8sm11414270wrt.28.2020.07.10.14.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 14:02:32 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 21C381FF7E;
 Fri, 10 Jul 2020 22:02:31 +0100 (BST)
References: <20200710163253.381630-1-mreitz@redhat.com>
 <20200710163253.381630-2-mreitz@redhat.com>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH 1/2] iotests: Drop readarray from _do_filter_img_create
In-reply-to: <20200710163253.381630-2-mreitz@redhat.com>
Date: Fri, 10 Jul 2020 22:02:30 +0100
Message-ID: <87imevjd7d.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Max Reitz <mreitz@redhat.com> writes:

> Some systems where we run tests on do not have a 4.x bash, so they do
> not have readarray.  While it looked a bit nicer than messing with
> `head` and `tail`, we do not really need it, so we might as well not use
> it.

I've fixed the cirrus build failure by brew installing a more recent
bash. However if we prefer we could do this.

>
> Reported-by: Claudio Fontana <cfontana@suse.de>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/common.filter | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common=
.filter
> index 3833206327..345c3ca03e 100644
> --- a/tests/qemu-iotests/common.filter
> +++ b/tests/qemu-iotests/common.filter
> @@ -138,13 +138,13 @@ _do_filter_img_create()
>      # Split the line into the pre-options part ($filename_part, which
>      # precedes ", fmt=3D") and the options part ($options, which starts
>      # with "fmt=3D")
> -    # (And just echo everything before the first "^Formatting")
> -    readarray formatting_line < <($SED -e 's/, fmt=3D/\n/')
> +    read formatting_line
>=20=20
> -    filename_part=3D${formatting_line[0]}
> -    unset formatting_line[0]
> +    # Split line at the first ", fmt=3D"
> +    formatting_line=3D$(echo "$formatting_line" | $SED -e 's/, fmt=3D/\n=
fmt=3D/')
>=20=20
> -    options=3D"fmt=3D${formatting_line[@]}"
> +    filename_part=3D$(echo "$formatting_line" | head -n 1)
> +    options=3D$(echo "$formatting_line" | tail -n +2)
>=20=20
>      # Set grep_data_file to '\|data_file' to keep it; make it empty
>      # to drop it.


--=20
Alex Benn=C3=A9e

