Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76885C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 12:58:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F13C82068E
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 12:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BC7WNQ8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F13C82068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY8WS-0006Ag-US
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 07:58:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iY8VS-0005f9-UZ
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:57:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iY8VR-0004aE-Gx
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:57:50 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39463)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iY8VQ-0004Yx-Pq
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:57:49 -0500
Received: by mail-wr1-x444.google.com with SMTP id y11so5400818wrt.6
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 04:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=OXp5D/xVd99IlEauOj8RNIXPW1Jg2zNuCJN9uCSBn38=;
 b=BC7WNQ8fYHmkpKtrxH7JbY4csClLTUbLHt3QhrbJ03yctmmp/UkXGkFavNTpxpu7uS
 GnWqQnIHuqFLaPnzNfs2QGkSUi2Ry578s9KpkqCeDDB5LFpsTJBu69mw6828MvD/URQn
 ygeCbhFY+D40L2kSbgogcoorr783zKZgTjZSzveHcOj1yoxvlToG/cXD5asik6nlJAOu
 Goi202I9uagi8aIu1LPocL0JAdLOUX13aeohJcdsvVNt9OTaWR3q50S6/Q9Iug1B5N1Z
 wkYWhFTrYRDhSBW8Crq5iubFc9wsCFQL7KHp0W2jAbOkSCtFQBiI5V/NcHnfHZ5qrh/2
 MxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=OXp5D/xVd99IlEauOj8RNIXPW1Jg2zNuCJN9uCSBn38=;
 b=bPRMBLyCc2XlzScgwT0fKjQukz944W2cT/J2av4JZRqQQmPb4ObsAxNxGjqYYkLpWK
 PePzC+HxHbf2F5grLrEmI/rUrGTxB3wxl+VrpeNeJjYlwi4rYL5cYeNmEqLU8lmHEaQb
 Lo7u+3LvuDOiry4khJAqR+FA25iewPYWCkuFIYIS3LQAqhcNaLNfLL0GAHrh1JzAW9db
 /8Rj81XTyyU3a0lLqR5ztsMlTab8qlznZuru/Gguf+hKLIW0P9p/TAjqR45XWId/pIdg
 0WAmJ/UjEBSN2dYUyeUrZyST2TB8mUJuP7qUi6skcHF8/Y7C0CTrPLYaNrRtmVs0rxNb
 k7yw==
X-Gm-Message-State: APjAAAU0+w+UimxkK2Gxe/YavIVDIH6AcSXCkgI+Z1DOitgE8ig37TSY
 FTN0PvP7qsjzJFm4o+HZtDNXQg==
X-Google-Smtp-Source: APXvYqxq9QJ1Sx39U0FiaKNlc6tgQ/XWvrWkDe7u1NVAwHUw4sos4fKum0mwPLIUe5eMPE9OgXvmAw==
X-Received: by 2002:adf:f048:: with SMTP id t8mr18440624wro.237.1574427467243; 
 Fri, 22 Nov 2019 04:57:47 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b1sm7164949wrs.74.2019.11.22.04.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2019 04:57:45 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1BE441FF87;
 Fri, 22 Nov 2019 12:57:45 +0000 (GMT)
References: <20191119170822.45649-1-thuth@redhat.com>
 <20191119170822.45649-3-thuth@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 2/6] iotests: Skip test 079 if it is not possible to
 create large files
In-reply-to: <20191119170822.45649-3-thuth@redhat.com>
Date: Fri, 22 Nov 2019 12:57:45 +0000
Message-ID: <87h82w83w6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> Test 079 fails in the arm64, s390x and ppc64le LXD containers, which
> apparently do not allow large files to be created. Test 079 tries to
> create a 4G sparse file, so check first whether we can really create
> such files before executing the test.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qemu-iotests/079 | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tests/qemu-iotests/079 b/tests/qemu-iotests/079
> index 81f0c21f53..e9b81419b7 100755
> --- a/tests/qemu-iotests/079
> +++ b/tests/qemu-iotests/079
> @@ -39,6 +39,12 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  _supported_fmt qcow2
>  _supported_proto file nfs
>=20=20
> +# Some containers (e.g. non-x86 on Travis) do not allow large files
> +if ! truncate --size=3D4G "$TEST_IMG"; then
> +    _notrun "file system on $TEST_DIR does not support large enough file=
s"
> +fi
> +rm "$TEST_IMG"
> +

Hmm we are repeating ourselves here. Maybe the test should be wrapped up
as __supported_filesize and the test can just do:

  __supported_filesize 4G

along with the other tests above.

--=20
Alex Benn=C3=A9e

