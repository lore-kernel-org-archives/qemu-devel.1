Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07604C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:28:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E4612083B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dgG/gEim"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4612083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIoL0-000142-Kh
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 03:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scw@google.com>) id 1kIoIZ-00071r-Vf
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:25:44 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:39855)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scw@google.com>) id 1kIoIY-0001w1-82
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:25:43 -0400
Received: by mail-ej1-x641.google.com with SMTP id p9so1815425ejf.6
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 00:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bb02cXXhgUnDaA1lDk/W8352Cq/b242vucM6Sv+/yVU=;
 b=dgG/gEim6nPGZKSuCh4yHgA9xwE0LO58BVGvhwF9+u/msO0mfHWObHH6qVV4jT5flQ
 r13LBYdt6LhwSfe/MLw5jEeZni4Laydj09KQkPVSQ3R/uUbyNjrlNUhQ8C1SRpIy//+q
 l4Ot2xAeykXEzw3259yfTgjSQ3Io8ryl1iMIQBRmVLK78Q5BvPbOhlIiLoAXXEvbSH5S
 pUPMZg9m46Z3SOUrTTDsWkwEVAQTM6aPNn1+Zr0gyIXDAR3ihqhfZ0peEBUmhJk6ifF3
 5zBly6iIg5f0L2aKdzRK15KFG2194mtx4UUfEvbifPw5EdVyDgzkeju+oK6chWW/06tg
 rlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bb02cXXhgUnDaA1lDk/W8352Cq/b242vucM6Sv+/yVU=;
 b=Ym+CBygiTCc//Un3Eporv/IehJjISDrINg5gnFRJx9Wa6mml/H/QxeSKl7McwfRiFF
 96VDki0bDwVq1olDd3Z1PO1qW4Q0Rm3xpxFlAl0XAW02+54EMTpt0pOJDNfhTklRzPBh
 GQLyiAzSLPbsU50x5xNbZiUrITyHmPMGVhmuz1Vcbqw/4syuy2/67BcqBDUs6WeEkfCe
 TvdieKQC6zAFgODB301EN0wGqnGUucKL9Q+1Vk7biVNk+N8nB0OjOUIFfLGUxZOfZTBA
 elwhUaNiyLbvvlOvZuZXSIQjI6xlms7W9v0Dni3WA/hpFRjqAAyGBD7v/JMWOlvJxBZJ
 i0Wg==
X-Gm-Message-State: AOAM532NzIpHUcegSRWTpDoEG+l8CK+CWPgPbEeD93DrazDnpKhUxD/G
 GBM+33rQQZjuL5uF+xJsmN57E52EhxMbvu+SzNSvZp8tjZk=
X-Google-Smtp-Source: ABdhPJx6f8lvVS6sNKZUc/eQQzrDK9k7RlSLczqeopF0RME4aTMNRlmNNA6tT7HSc6zkojy7ncHBxoQP0awWH49fWw4=
X-Received: by 2002:a17:906:119b:: with SMTP id
 n27mr29024584eja.124.1600327540416; 
 Thu, 17 Sep 2020 00:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1595463707.git.scw@google.com>
 <CAF3nBxin3tH_0bFGiV+=5pkU=uQdK8UAtWi808TPM9Rewq51OQ@mail.gmail.com>
In-Reply-To: <CAF3nBxin3tH_0bFGiV+=5pkU=uQdK8UAtWi808TPM9Rewq51OQ@mail.gmail.com>
From: Shu-Chun Weng <scw@google.com>
Date: Thu, 17 Sep 2020 00:25:29 -0700
Message-ID: <CAF3nBxjtHbVpQC3vn6BzvxT2NECzmCKyW644UVNADs7hJaRVXA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Instruction set detection for clang.
To: rth@twiddle.net
Cc: qemu-devel@nongnu.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="00000000000098e77005af7d4ac2"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=scw@google.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
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

--00000000000098e77005af7d4ac2
Content-Type: multipart/alternative; boundary="000000000000928fc605af7d4a25"

--000000000000928fc605af7d4a25
Content-Type: text/plain; charset="UTF-8"

Ping.

On Wed, Aug 5, 2020 at 4:23 PM Shu-Chun Weng <scw@google.com> wrote:

> Ping: https://patchew.org/QEMU/cover.1595463707.git.scw@google.com/
>
> On Wed, Jul 22, 2020 at 5:27 PM Shu-Chun Weng <scw@google.com> wrote:
>
>> Currently when configuring QEMU with clang, AVX2, AVX512F, ATOMIC64, and
>> ATOMIC128 are all disabled because the detection code is GCC-only. With
>> these
>> two patches, I am able to configure, build, and run tests with clang with
>> all of
>> the above enabled.
>>
>> Shu-Chun Weng (2):
>>   configure: avx2 and avx512f detection for clang
>>   configure: atomic64/128 detection for clang
>>
>>  configure           | 34 +++++++++++++++++++++++-----------
>>  util/bufferiszero.c | 33 +++++++++++++++++++++++----------
>>  2 files changed, 46 insertions(+), 21 deletions(-)
>>
>> --
>> 2.28.0.rc0.105.gf9edc3c819-goog
>>
>>

--000000000000928fc605af7d4a25
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ping.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Wed, Aug 5, 2020 at 4:23 PM Shu-Chun Weng &lt;<a h=
ref=3D"mailto:scw@google.com">scw@google.com</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Ping:=C2=A0<a =
href=3D"https://patchew.org/QEMU/cover.1595463707.git.scw@google.com/" targ=
et=3D"_blank">https://patchew.org/QEMU/cover.1595463707.git.scw@google.com/=
</a></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Wed, Jul 22, 2020 at 5:27 PM Shu-Chun Weng &lt;<a href=3D"mailto:scw=
@google.com" target=3D"_blank">scw@google.com</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">Currently when configuring QEM=
U with clang, AVX2, AVX512F, ATOMIC64, and<br>
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
</blockquote></div>

--000000000000928fc605af7d4a25--

--00000000000098e77005af7d4ac2
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPkgYJKoZIhvcNAQcCoIIPgzCCD38CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggzsMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
--00000000000098e77005af7d4ac2--

