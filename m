Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD3AC7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 15:52:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C679B20880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 15:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C3OKfcO4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C679B20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnPl0-0001Vb-2M
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 11:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40327)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hnPkn-00012v-L3
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 11:52:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hnPkm-0003Ej-LQ
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 11:52:33 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52578)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hnPkm-0003E9-A3
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 11:52:32 -0400
Received: by mail-wm1-x343.google.com with SMTP id s3so19188299wms.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 08:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=IfBWzciuqJVk/m7x4n08/w2o3T9hLfpNRqSodAQJ2qc=;
 b=C3OKfcO44qZ6CDKUgmgrvmDmuGKTknVYA6TbqP64azbfCEjyGE1hxoITLFvUhkYOvA
 PlcVjlqkkFGTj7e6XJrIm23gWBsvEwP79pI0GgtNifMVGaJmshHmoatnzfxuNa0UDwdF
 BqPDHmLiJDomWwq9fRr6OazUrbheRDVInNMo6oSVjlXSFbUDJyicywCWchyxKPxo02h4
 JNmJRjyx5hSh4FwwgsOUT9m4UL/3VXvcD7l/960J+t2lxzXQQJQzG3hiH/UkNRjGi6Kf
 BELGT8UleolgRtY1te1DFWPAu9Rf+SMghbj3yfdKmRvHC73B646W2+mRep0PtOXsxtfB
 ZX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=IfBWzciuqJVk/m7x4n08/w2o3T9hLfpNRqSodAQJ2qc=;
 b=l/jolr5SVPWEAfn2vQHzVtMrOPyyTk0adjhWYZUuncmV1SaCYRN8zmWq5BdpQyu3s4
 DzBb35E//f78X3jm4wm7j7sf00jL0V/vGr/5Mii71HdeBxnSQLzcDzNUXE4QX19Xcb1x
 4X9Pi8wYB8yF3km+hB6PpzQPnoCO4txlY8j0LbH3BApHVfTRXGEtZgVNthBLNi10/CTl
 0106JClWW2rFj/NC2kQXQOPyjmxyC8rnhLr5T3Xj0Wko3ePnAiK12qqTKFGcLQHestlz
 bn1elL31IEHsrW/WGqeX2bvYZLNYdZXkfsqkJmpWhwtp+SGTC+jm7JGdh0y36yUtC+2J
 3wvQ==
X-Gm-Message-State: APjAAAUsr9q9vVQ5kfh1hWB6xKTjTKmY+5ltiL6ZhunaYmy/u7Q+UWuv
 wLXwRaifr/H0P2lVmLUP3M8wqg==
X-Google-Smtp-Source: APXvYqzz2VFOOecB4mltMm7N8OSpbi62Kb7GVap3Lo36JqRsxOMp/XdCsjsLC9aJBil3yH1hE33XLQ==
X-Received: by 2002:a1c:be19:: with SMTP id o25mr29874132wmf.54.1563292350894; 
 Tue, 16 Jul 2019 08:52:30 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id a6sm15314306wmj.15.2019.07.16.08.52.30
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 16 Jul 2019 08:52:30 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BC5471FF87;
 Tue, 16 Jul 2019 16:52:29 +0100 (BST)
References: <20190716122836.31187-1-thuth@redhat.com>
 <20190716122836.31187-2-thuth@redhat.com>
User-agent: mu4e 1.3.3; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
In-reply-to: <20190716122836.31187-2-thuth@redhat.com>
Date: Tue, 16 Jul 2019 16:52:29 +0100
Message-ID: <87a7deugci.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v2 1/4] tests/qemu-iotests/check: Allow
 tests without groups
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> The regular expressions in the "check" script currently expect that there
> is always a space after the test number in the group file, so you can't
> have a test in there without a group unless the line still ends with a
> space - which is quite error prone since some editors might remove spaces
> at the end of lines automatically.
> Thus let's fix the regular expressions so that it is also possible to
> have lines with one test number only in the group file.
>
> Suggested-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/qemu-iotests/check | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index f925606cc5..c24874ff4a 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -488,7 +488,7 @@ testlist options
>  BEGIN        { for (t=3D'$start'; t<=3D'$end'; t++) printf "%03d\n",t }'=
 \
>          | while read id
>          do
> -            if grep -s "^$id " "$source_iotests/group" >/dev/null
> +            if grep -s "^$id\( \|\$\)" "$source_iotests/group" >/dev/null
>              then
>                  # in group file ... OK
>                  echo $id >>$tmp.list
> @@ -547,7 +547,7 @@ else
>          touch $tmp.list
>      else
>          # no test numbers, do everything from group file
> -        sed -n -e '/^[0-9][0-9][0-9]*/s/[         ].*//p' <"$source_iote=
sts/group" >$tmp.list
> +        sed -n -e '/^[0-9][0-9][0-9]*/s/^\([0-9]*\).*/\1/p' <"$source_io=
tests/group" >$tmp.list
>      fi
>  fi


--
Alex Benn=C3=A9e

