Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1BECA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 11:31:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B6820863
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 11:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B6820863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOKI5-00005M-1R
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 07:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iOKGf-0006QL-MV
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 07:30:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iOKGc-0002nJ-Nm
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 07:30:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55528)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iOKGa-0002ka-U8
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 07:29:58 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 64DB0C057EC6
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 11:29:55 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id v8so2759227wrt.16
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 04:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gtLWNrkI2ITrFK0S3d9bDv7G8vlWR0E4B52JLQe7wmk=;
 b=G0uQy1dkLazhetHjjIGKUUVyCP/10u1we4DMGrntkuR71+gPGJXnWMhxpLmP8myH8G
 ngGJGM6+MXaj2sV291A7t7Zlsl6mSWet54cfoAYK9N3K1j7o4k3kVaHbf8pmXsz+vwuA
 a9vQsILC4Vp+xnb/c857J2hP8HQxVI6gAqYu3saQ3OOYF4oHCjd3LrHPRXZF+OZTayK6
 Iiik3Et0kSlS7+clWFPxgH8QYFGZocvVMWxvuTUpe5cS335ziKhlM650+fNJRCLcFe3c
 DpZqHFYiKb3CwUFmVhQmrYIW2pOZN6z7HXsLu5sW/toH4gy5SRW899i2Exkkx6cNWwJa
 loBA==
X-Gm-Message-State: APjAAAU0DBX0YjKV2XqeelZCJ0HprHRS5uTkWw5rnynTT0nVDlR2IwnF
 4mMyc+G670WaQT192VInlXpNzW+Mo40xgWAm4ODIlqyYa0iRrBw9rGgDWqA5a1iz9qHMNmVMajQ
 BgjTFrHeGM+gHneQ=
X-Received: by 2002:a1c:f401:: with SMTP id z1mr7325810wma.66.1572089394192;
 Sat, 26 Oct 2019 04:29:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx5elOi0yXy/dqyqjv3xpy0iZef+hwiLVebAlVMgGn2mJ6e32SJl//f0zw8bdqZ88mhP5K/mQ==
X-Received: by 2002:a1c:f401:: with SMTP id z1mr7325788wma.66.1572089393862;
 Sat, 26 Oct 2019 04:29:53 -0700 (PDT)
Received: from [192.168.1.33] (62.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.62])
 by smtp.gmail.com with ESMTPSA id w22sm4797719wmi.7.2019.10.26.04.29.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Oct 2019 04:29:53 -0700 (PDT)
Subject: Re: [PATCH] qemu-iotests/iotests.py: improve assert_qmp message
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191026101221.5506-1-vsementsov@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8938c24a-4f3d-4df2-4c30-f1922242789b@redhat.com>
Date: Sat, 26 Oct 2019 13:29:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191026101221.5506-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/26/19 12:12 PM, Vladimir Sementsov-Ogievskiy wrote:
> Make it obvious, from the two values which is found at path and which
> is expected.

Maybe:

"From the two values compared, make it obvious which is found at path,=20
and which is expected."

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>=20
> It's a pain, I can never remember it, and checking each time in source
> code who is who is boring.
>=20
>   tests/qemu-iotests/iotests.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests=
.py
> index 709def4d5d..e805b9ab14 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -729,8 +729,8 @@ class QMPTestCase(unittest.TestCase):
>               self.fail('no match for "%s" in %s' % (str(result), str(v=
alue)))
>           else:
>               self.assertEqual(result, value,
> -                             'values not equal "%s" and "%s"'
> -                                 % (str(result), str(value)))
> +                             '"%s" is "%s", expected "%s"'
> +                                 % (path, str(result), str(value)))
>  =20
>       def assert_no_active_block_jobs(self):
>           result =3D self.vm.qmp('query-block-jobs')
>=20

