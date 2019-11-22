Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90710C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 16:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AEF92068E
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 16:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kFsspc1y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AEF92068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYBsz-0002qy-Vj
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 11:34:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51163)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iYBna-0000uN-UU
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:28:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iYBnU-0002zM-WD
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:28:43 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52953)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iYBnU-0002xv-Pl
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:28:40 -0500
Received: by mail-wm1-x342.google.com with SMTP id l1so8080535wme.2
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 08:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=rqPEwD0tEdw6Fwkn4ef5sr7PUhtAUyz9jwyqhQRhSCA=;
 b=kFsspc1y3TQSgraCfEGU/s2N+Mh1JuULy5n2WGgok0dZMCGtfeozFpXqa4CD1S8HbH
 Th92j+xU/4f2r0Xjz4OK3BgKYrGiCUyisA4MtE9ZzFS51IoW1bhbSkUlMLUcnfupGiRr
 OtJb7lS7PwnThe6SR5RHqRvmF+XXhbLwhUWDvLW6tVIA/lj1nm0edu3Xcg61W5LukE1n
 pShYg74JjDYxnuseP9Y9xA5tVUFGEueThLvOvUbRVZlWR3obr/1cjPO3BwqIpHIf5PYJ
 Xo6kU0s/vegji34GENXb33KI5Zk3643ghHfSWwZoXmITRBcoJ32WtxMu/Mt6eB7F3FcQ
 D2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=rqPEwD0tEdw6Fwkn4ef5sr7PUhtAUyz9jwyqhQRhSCA=;
 b=B9aBCxzW/VrinbZYS66iczBCnQ8KRby/DcnU8o0Iuvh8IyVn3LrAd2T4zkT5mo59Wy
 U+beboSkck+xNhhQMeUeefNI7KFznxgG0Z6yp/UZW580HDRHMLiXHRGaaCsZ3BbIPykc
 EwBRGEpMCFau8L9fWCDsm0j7y1/vESWWAT/AJG0vLJxYhBxWOpwHT+cHJfd9xs8O4nSc
 MwiEH4+G/9yi9M273lh/7u/ZqiXpl8s1x7RFnH/HrDvTLSlkrvhFGpH4nxXjHdYyNStq
 10dRyaYxj7KYMp/yxgI3rPQSdVEune2nE34BhlWw/mB/TAPwvz8vVzfTTeuPwEatgRcE
 13sw==
X-Gm-Message-State: APjAAAVKfFRVGVwxnlBJC+zfYwk4M9TlFcMOrjVw6FtQ61XLnyUhYsHl
 WkVP/pUzMV0Z+ZRCRIT4ZLYM+w==
X-Google-Smtp-Source: APXvYqzYVym+kMEVGV645dHrQH69oNCnhMItvmeCxp92ufMrIli5KuvSvryLSjakZKfRdmHo09iFfg==
X-Received: by 2002:a7b:c4c6:: with SMTP id g6mr17583469wmk.165.1574440115933; 
 Fri, 22 Nov 2019 08:28:35 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b63sm2194266wmb.40.2019.11.22.08.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2019 08:28:34 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B7DBA1FF87;
 Fri, 22 Nov 2019 16:28:33 +0000 (GMT)
References: <20191119170822.45649-1-thuth@redhat.com>
 <20191119170822.45649-4-thuth@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 3/6] tests/hd-geo-test: Skip test when images can not be
 created
In-reply-to: <20191119170822.45649-4-thuth@redhat.com>
Date: Fri, 22 Nov 2019 16:28:33 +0000
Message-ID: <878so798pa.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

> In certain environments like restricted containers, we can not create
> huge test images. To be able to use "make check" in such container
> environments, too, let's skip the hd-geo-test instead of failing when
> the test images could not be created.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/hd-geo-test.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/tests/hd-geo-test.c b/tests/hd-geo-test.c
> index 7e86c5416c..a249800544 100644
> --- a/tests/hd-geo-test.c
> +++ b/tests/hd-geo-test.c
> @@ -34,8 +34,13 @@ static char *create_test_img(int secs)
>      fd =3D mkstemp(template);
>      g_assert(fd >=3D 0);
>      ret =3D ftruncate(fd, (off_t)secs * 512);
> -    g_assert(ret =3D=3D 0);
>      close(fd);
> +
> +    if (ret) {
> +        free(template);
> +        template =3D NULL;
> +    }
> +
>      return template;
>  }
>=20=20
> @@ -934,6 +939,10 @@ int main(int argc, char **argv)
>      for (i =3D 0; i < backend_last; i++) {
>          if (img_secs[i] >=3D 0) {
>              img_file_name[i] =3D create_test_img(img_secs[i]);
> +            if (!img_file_name[i]) {
> +                g_test_message("Could not create test images.");
> +                goto test_add_done;
> +            }
>          } else {
>              img_file_name[i] =3D NULL;
>          }
> @@ -965,6 +974,7 @@ int main(int argc, char **argv)
>                         "skipping hd-geo/override/* tests");
>      }
>=20=20
> +test_add_done:
>      ret =3D g_test_run();

It does seem a bit odd to call g_test_run if we have explicitly not set
any up. Personally I'd hoist all the test creation into a new function
so you could do:

  if (setup_images()) {
     setup_tests();
     ret =3D run_tests();
  } else {
     ret =3D 0; /* pass if we have no images */
  }

  cleanup_images();

but that's just me going above and beyond to avoid goto's ;-)

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>=20=20
>      for (i =3D 0; i < backend_last; i++) {


--=20
Alex Benn=C3=A9e

