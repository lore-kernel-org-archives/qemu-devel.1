Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20710C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 11:10:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC58A21670
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 11:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gsAGLkRi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC58A21670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54682 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLn81-0004XP-A6
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 07:10:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLn6L-0003UA-7s
	for qemu-devel@nongnu.org; Wed, 01 May 2019 07:08:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLn6I-0006NH-6q
	for qemu-devel@nongnu.org; Wed, 01 May 2019 07:08:37 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLn6H-0006Mt-UG
	for qemu-devel@nongnu.org; Wed, 01 May 2019 07:08:34 -0400
Received: by mail-wr1-x444.google.com with SMTP id v16so21822308wrp.1
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 04:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=0yhS6aGm+cJz2ZPriGgIY9nmlOM6gHoENs97+Y6IMMA=;
	b=gsAGLkRigudTFsIMIVOEQtIrrWBXlj0cvfqXyCLmiWksxw+bSvizlalHST+FpFqJ+s
	eEOgzgsB+qnAruHXS9qA9yE4742bzQI1vC+L8HnA1Zc3AJZZpliBhUgeC096KDmxxMGB
	dskQ0WYJItX+SLaHYUdWCXGJOx6XuQSwUgJYyixF4q3xjh2oaCUYuidEm+rdiFvJVrvr
	BBYbLSVy9kUp/+hkR2dV80i6UlrVTd6xdxvfGC//ooRRobGDIdNrRzoprt5X+sKCNN4S
	BbvE15GB6yhg/TwAn6FBvpEFRbiBTIC7jWJy4iG611tWtLkDG0u86biF+htg8GyrdNmE
	m0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=0yhS6aGm+cJz2ZPriGgIY9nmlOM6gHoENs97+Y6IMMA=;
	b=OQYUK5R5BBSxASfAtqUSLcIhruNJe2twB4bVONhQcZgDTZsX2KaiCBXlSs6XZpyQu7
	94xJiHglOYLDlCRukkbLbYlN1jr1zxsESHMZ6TyqCm3PmFz6QVHRgHJWLTe1thn6tdUe
	sJJjUO3v1m0PXO23NXTrL6ickGizfXP/0fm8ypWWfakzj/P7aLlkhtGhzNS8ovhvwchm
	rWyOBeIbvgQQwDwDLQsRkMYkX2zAg1tchWlQsAODiRXlqollF5/y1s5ST4qtnXKr7cuY
	7AF12LJeOU0RFJrTA81CW+vIPy5oIwO2nW7kYwEZ+lMJle0APip8BdB+ca8Lfk9e1uZO
	2T+Q==
X-Gm-Message-State: APjAAAURjOIjIaEEpJPdJO+fm+OP/yxxn29iF567quP0Wf4v7C/Zce5M
	YAAZB+AQirw9u+Drgk4JnpeXnQ==
X-Google-Smtp-Source: APXvYqzbsz5mg4rW9UOfSBx+3T/08CWm8/niacWLL0Gd6pqt2l7szdLdZLWHzSiqM6xWiC8+fLpW2w==
X-Received: by 2002:a05:6000:10cc:: with SMTP id
	b12mr24176469wrx.182.1556708912430; 
	Wed, 01 May 2019 04:08:32 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	n17sm32445474wrw.77.2019.05.01.04.08.31
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 01 May 2019 04:08:31 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 76A511FF87;
	Wed,  1 May 2019 12:08:31 +0100 (BST)
References: <20190428155451.15653-1-thuth@redhat.com>
	<20190428155451.15653-3-thuth@redhat.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
In-reply-to: <20190428155451.15653-3-thuth@redhat.com>
Date: Wed, 01 May 2019 12:08:31 +0100
Message-ID: <877eba77ps.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v2 2/8] tests/qemu-iotests/005: Add a
 sanity check for large sparse file support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, Christophe Fergeau <cfergeau@redhat.com>,
	Max Reitz <mreitz@redhat.com>,
	Wainer dos Santos Moschetta <wainersm@redhat.com>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501110831.W45QExUAJjSfqY4grnsMFNK40fhrrO8eYKSdfrcQRMs@z>


Thomas Huth <thuth@redhat.com> writes:

> "check -raw 005" fails when running on ext4 filesystems - these do not
> support such large sparse files. Use the same check as in test 220 to
> skip the test in this case.
>
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qemu-iotests/005 | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/tests/qemu-iotests/005 b/tests/qemu-iotests/005
> index 2fef63af88..6136ced5c8 100755
> --- a/tests/qemu-iotests/005
> +++ b/tests/qemu-iotests/005
> @@ -55,6 +55,15 @@ if [ "$IMGPROTO" =3D "sheepdog" ]; then
>      _notrun "image protocol $IMGPROTO does not support large image sizes"
>  fi
>
> +# Sanity check: For raw, we require a file system that permits the creat=
ion
> +# of a HUGE (but very sparse) file.  tmpfs works, ext4 does not.

Is this comment correct? Running on my ext4 home partition this test
seems to be running fine and not skipping. Indeed:

  12:06:29 [alex@idun:~/l/q/b/k/t/qemu-iotests] review/iotests-fixup-v2 + p=
wd
  /home/alex/lsrc/qemu.git/builds/kvm/tests/qemu-iotests
  12:07:12 [alex@idun:~/l/q/b/k/t/qemu-iotests] review/iotests-fixup-v2 + s=
tat -f -c %T .
  ext2/ext3
  12:07:40 [alex@idun:~/l/q/b/k/t/qemu-iotests] review/iotests-fixup-v2 + t=
ouch scratch/t.img
  12:07:45 [alex@idun:~/l/q/b/k/t/qemu-iotests] review/iotests-fixup-v2 + t=
runcate --size=3D5T scratch/t.img
  12:07:47 [alex@idun:~/l/q/b/k/t/qemu-iotests] review/iotests-fixup-v2 + l=
s -lh scratch/t.img
  -rw-r--r-- 1 alex alex 5.0T May  1 12:07 scratch/t.img
  12:07:51 [alex@idun:~/l/q/b/k/t/qemu-iotests] review/iotests-fixup-v2 + s=
tat -f -c %T scratch/t.img
  ext2/ext3
  12:07:58 [alex@idun:~/l/q/b/k/t/qemu-iotests] review/iotests-fixup-v2 + d=
u -sh scratch/
  4.0K    scratch/


> +if [ "$IMGFMT" =3D "raw" ]; then
> +    if ! truncate --size=3D5T "$TEST_IMG"; then
> +        _notrun "file system on $TEST_DIR does not support large enough =
files"
> +    fi
> +    rm "$TEST_IMG"
> +fi
> +
>  echo
>  echo "creating large image"
>  _make_test_img 5000G

--
Alex Benn=C3=A9e

