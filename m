Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FB1C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 23:25:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1EEB2250E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 23:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PsbPMxW3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1EEB2250E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Smh-0006U6-4y
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 19:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scw@google.com>) id 1k3Skv-00057F-KU
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 19:23:33 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:34571)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scw@google.com>) id 1k3Skt-0006Fe-OW
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 19:23:33 -0400
Received: by mail-ed1-x543.google.com with SMTP id bs17so15023246edb.1
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 16:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pe2Ev8s0tRE+AK0/WKW8caxUE3fQ4tFqyS9hzn77XE4=;
 b=PsbPMxW3KcOXZE0POboZSg8aE98HkxBioGbKZ2gih1eXE4wTJGTo5BeJFe1hMWG+bm
 1cloQcMYeCPkvejy4ETk/CpY237Wo+ONzirqX8jRYEVXkntxtTg4pLmFL9/nlOMUN76p
 VESd/RS7NhOBOgO/Q92oDgQbsonM37jSXUrs3ruqZWc9dwCCYWXn9QE6jGmXGnUtHpTi
 JFHzoTklmWlNueCmUAWku64FCuxBvk156EGvgjB7wbLr6l6F/ql91TUGzvDvGmGZhNy2
 va/Bm8tueXCgNR8XRMeEoa5Yd89M7cBbLoxytDBX1371CKDkyiKSRdIDlFgzNFfAwuhY
 M0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pe2Ev8s0tRE+AK0/WKW8caxUE3fQ4tFqyS9hzn77XE4=;
 b=apqUmYFGbCuMCnPYb3S62g9g2SGLB7p1m0kU3ZwQQihQt/TYzFTkyODUUWw/qPUK+e
 mJKZubz8PYNVYVqXEAqx4OxjlnI+1b/KdS+sq8FMn7s4J3zpGo7Jj6q4IkopXiSqxEWi
 FVPxaXFS+SQZxL56vrhv1DF1FNjoGXi90Iv7fDeUCrRBJug3BtX0nkp5MwE+uGLEWFYx
 xnMAvqJMyrX6KMvogvljH2j01pnAi/OOetJKt/3n/w+quUKJZR7citu28BD/3A1Bhclg
 8tBpCec9YnH7i/RcyU0GIl3bQkp2H87Zvp3qNBt4qGp2Pn3/mf6fLuYIYGibLsemZBh8
 12Bg==
X-Gm-Message-State: AOAM530X5mvvUU72wsm/CNcsdhcqjYiIeE2jeFGb11mkghFFZIKQQSMz
 J0kgXd9DtFy1ixddW026JZ0RBqgpdTT46bsdSrvwXrdjtZY=
X-Google-Smtp-Source: ABdhPJxPtE8w60EDpRFzY3L34+cDQwbeXL9ot2F1QN1paOTnEmX+x/6VC9ZEkVOaT2ojxdeJIqzQ9B1e3kEk6jop1hc=
X-Received: by 2002:aa7:c1d4:: with SMTP id d20mr1535273edp.81.1596669809699; 
 Wed, 05 Aug 2020 16:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1595463707.git.scw@google.com>
In-Reply-To: <cover.1595463707.git.scw@google.com>
From: Shu-Chun Weng <scw@google.com>
Date: Wed, 5 Aug 2020 16:23:18 -0700
Message-ID: <CAF3nBxin3tH_0bFGiV+=5pkU=uQdK8UAtWi808TPM9Rewq51OQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Instruction set detection for clang.
To: rth@twiddle.net
Cc: qemu-devel@nongnu.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000dbdeb105ac29a8d9"
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=scw@google.com; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001,
 USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000dbdeb105ac29a8d9
Content-Type: multipart/alternative; boundary="000000000000d532db05ac29a82a"

--000000000000d532db05ac29a82a
Content-Type: text/plain; charset="UTF-8"

Ping: https://patchew.org/QEMU/cover.1595463707.git.scw@google.com/

On Wed, Jul 22, 2020 at 5:27 PM Shu-Chun Weng <scw@google.com> wrote:

> Currently when configuring QEMU with clang, AVX2, AVX512F, ATOMIC64, and
> ATOMIC128 are all disabled because the detection code is GCC-only. With
> these
> two patches, I am able to configure, build, and run tests with clang with
> all of
> the above enabled.
>
> Shu-Chun Weng (2):
>   configure: avx2 and avx512f detection for clang
>   configure: atomic64/128 detection for clang
>
>  configure           | 34 +++++++++++++++++++++++-----------
>  util/bufferiszero.c | 33 +++++++++++++++++++++++----------
>  2 files changed, 46 insertions(+), 21 deletions(-)
>
> --
> 2.28.0.rc0.105.gf9edc3c819-goog
>
>

--000000000000d532db05ac29a82a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ping:=C2=A0<a href=3D"https://patchew.org/QEMU/cover.15954=
63707.git.scw@google.com/" class=3D"cremed">https://patchew.org/QEMU/cover.=
1595463707.git.scw@google.com/</a></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 22, 2020 at 5:27 PM Shu-Chun =
Weng &lt;<a href=3D"mailto:scw@google.com">scw@google.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">Currently when con=
figuring QEMU with clang, AVX2, AVX512F, ATOMIC64, and<br>
ATOMIC128 are all disabled because the detection code is GCC-only. With the=
se<br>
two patches, I am able to configure, build, and run tests with clang with a=
ll of<br>
the above enabled.<br>
<br>
Shu-Chun Weng (2):<br>
=C2=A0 configure: avx2 and avx512f detection for clang<br>
=C2=A0 configure: atomic64/128 detection for clang<br>
<br>
=C2=A0configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 34 ++++++++++++++=
+++++++++-----------<br>
=C2=A0util/bufferiszero.c | 33 +++++++++++++++++++++++----------<br>
=C2=A02 files changed, 46 insertions(+), 21 deletions(-)<br>
<br>
-- <br>
2.28.0.rc0.105.gf9edc3c819-goog<br>
<br>
</blockquote></div>

--000000000000d532db05ac29a82a--

--000000000000dbdeb105ac29a8d9
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPAAYJKoZIhvcNAQcCoIIO8TCCDu0CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggxjMIIEkjCCA3qgAwIBAgINAewckktV4F6Q7sAtGDANBgkqhkiG9w0BAQsFADBMMSAwHgYDVQQL
ExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMK
R2xvYmFsU2lnbjAeFw0xODA2MjAwMDAwMDBaFw0yODA2MjAwMDAwMDBaMEsxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSEwHwYDVQQDExhHbG9iYWxTaWduIFNNSU1FIENB
IDIwMTgwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCUeobu8FdB5oJg6Fz6SFf8YsPI
dNcq4rBSiSDAwqMNYbeTpRrINMBdWuPqVWaBX7WHYMsKQwCOvAF1b7rkD+ROo+CCTJo76EAY25Pp
jt7TYP/PxoLesLQ+Ld088+BeyZg9pQaf0VK4tn23fOCWbFWoM8hdnF86Mqn6xB6nLsxJcz4CUGJG
qAhC3iedFiCfZfsIp2RNyiUhzPAqalkrtD0bZQvCgi5aSNJseNyCysS1yA58OuxEyn2e9itZJE+O
sUeD8VFgz+nAYI5r/dmFEXu5d9npLvTTrSJjrEmw2/ynKn6r6ONueZnCfo6uLmP1SSglhI/SN7dy
L1rKUCU7R1MjAgMBAAGjggFyMIIBbjAOBgNVHQ8BAf8EBAMCAYYwJwYDVR0lBCAwHgYIKwYBBQUH
AwIGCCsGAQUFBwMEBggrBgEFBQcDCTASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdDgQWBBRMtwWJ
1lPNI0Ci6A94GuRtXEzs0jAfBgNVHSMEGDAWgBSP8Et/qC5FJK5NUPpjmove4t0bvDA+BggrBgEF
BQcBAQQyMDAwLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9iYWxzaWduLmNvbS9yb290cjMw
NgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIzLmNybDBn
BgNVHSAEYDBeMAsGCSsGAQQBoDIBKDAMBgorBgEEAaAyASgKMEEGCSsGAQQBoDIBXzA0MDIGCCsG
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
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wUQYIKwYBBQUHAQEERTBDMEEG
CCsGAQUFBzAChjVodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc3NtaW1lY2Ey
MDE4LmNydDAfBgNVHSMEGDAWgBRMtwWJ1lPNI0Ci6A94GuRtXEzs0jA/BgNVHR8EODA2MDSgMqAw
hi5odHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2NhL2dzc21pbWVjYTIwMTguY3JsMA0GCSqGSIb3
DQEBCwUAA4IBAQB0zgx4rAhCKzIVBMrEn4R/8FrisDQWZwJvA4VLbgtBPI1kP/Ys+cw3oYecxHED
MAHXOYclqmcaKudfjsLKZ/jrpdjZMAHDazo86g4BREWWiAxAtnMPhKrL4Ciqs0Yx/fj4VJlJRgES
1wscHQQNh2BgbqP15O5D2CtZVsLIuc9pSY3DZNYUrMQy55hszPnhgeghImVgNLtzUkF8oLKlnrWs
blvMc7fi7e42/rSnhbE6WUWGHvXcQ3+qIptP079GF+p1ZnEVmXIrQeoP1Rh0wS2ThPBorHqMY8OB
+c1AbPa2A/qY7QkFA6Oq7I8gUPNRO1NyuEElN4LJy+SCH0kWzLawMYICYTCCAl0CAQEwXzBLMQsw
CQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEhMB8GA1UEAxMYR2xvYmFsU2ln
biBTTUlNRSBDQSAyMDE4AhAB2NRaeBKJjaSQ9CGctwQsMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqG
SIb3DQEJBDEiBCALjfXoDrRc5HbtAv0OfOQS5a1Ao8DFx6ANOCw42wQPkTAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMDA4MDUyMzIzMzBaMGkGCSqGSIb3DQEJDzFc
MFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJ
KoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAfP+6
wyQk04wBp0a9OUExIhComOMqI05VDERWbarcDLmpdWwcL2QecYyBy8siSgU+HCi+wSx2p70s65dg
IPABoUk9zh+n5dXDhHObETWCFhZZOd7ji5v6XSo/jji+bCC/DhAuo37I8pbtfgkgI4dccF74KhvK
7kUplL68D4eISUuVtKEIkVCxI6CMT+zGbhf4ME7q2GrUdP1zKz8cLkt5zEn3g7/uJvmXXtAQCnbr
0nbhefjZyokDPwqBfnhl79boHFJR+I1EB6N0DIfDP1HVkt2Rka+tgduZ48CnM9ieqyRN2+Np11rQ
aQ7EK7hnGjZd2LPyPRTNKbRlcdhtD925EQ==
--000000000000dbdeb105ac29a8d9--

