Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A796C3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 14:00:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47FEC20848
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 14:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RT/wV2W7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47FEC20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j986F-0000KW-Ew
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 09:00:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59149)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j985Q-0008He-Gi
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 08:59:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j985P-0005pu-1j
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 08:59:52 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43376)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j985O-0005pm-QN
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 08:59:50 -0500
Received: by mail-wr1-x443.google.com with SMTP id h9so3502569wrr.10
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 05:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=G0HZvp1eXD2cp0YekPoUge6e6IUce1YPUQJwHIZW358=;
 b=RT/wV2W7yk4pCp03FgS9ysACPFUR4oluD3RGiW9yGBrjQRsffmUDNMkO4o/3E+XsN0
 E2H0Ujser6CoZk2yfYixWq6T5ZQ1K3pCFSRWmoAfoOS6bhFJlR3iLdPZhtlUWqCcsA9g
 M7nnma8wbsPQTkuSAFmLxda6fpzytWJPcA0DsA6nocMZ6Ci5xsRnotX+KhBAlL+b2Kpx
 80629PJdMUrVoYX3UF6GJCCjCFk32aIFV5bV3/fx7aU6ivdqyduZ1GUHNO2J+EdaoyJB
 t2QPM1BRdaBcsXkZdXVNRv8jov39BsPVROwIKQIFQhNMxEQc/7Resl6FLfC+LjZSIfVn
 zmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=G0HZvp1eXD2cp0YekPoUge6e6IUce1YPUQJwHIZW358=;
 b=czx6bsW7Wj0W1ccL/v71ocNMB8ipVx2bS0foLUgzfbSasBP+e9y6p7gQVrcUmBp1Ja
 U7UkCjBpMcDLEm7PoyeOBl4/M0KUQC2loRP1aTs3j9ocOIf9fGUn3S5aHwdPBHjMMFBX
 d3Qo02Y56eT3dnsB3LKYC05bzJ+eyV9L9+NQDyK4w9o8xXPAfXdKRYCEExMOv6qIEoLt
 CBWEEopQjO+zZjvxD/NjyCzMp1Xgv2vr6WDBUoWx1WtIWOjKqLQ3Vp6DrfYoo//Iv1JF
 X0Lyqqlfx6i+3aow2+fLBW8HEIfkbD6nzW6wzFILgAk21os0wVkyD4ZCqty9dpG2dmIM
 hrng==
X-Gm-Message-State: ANhLgQ3WLgAwYlZwmLmexNuQ6vkubTDxzRU6WRk6AtAxJV1L5+cXeFLw
 h+p/3nbKz6RKDejy9qoKCs2fFQ==
X-Google-Smtp-Source: ADFU+vu+BSAXSXEBEuwqFoQgg8W4vNFfu0SrUC1pv7BkSU4gkite7SlJOLaMCYK4n0nQBR4CD4FvDg==
X-Received: by 2002:a5d:658c:: with SMTP id q12mr5964451wru.57.1583243989370; 
 Tue, 03 Mar 2020 05:59:49 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q3sm32469277wrs.1.2020.03.03.05.59.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2020 05:59:48 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 882821FF87;
 Tue,  3 Mar 2020 13:59:47 +0000 (GMT)
References: <20200302180937.24148-1-alex.bennee@linaro.org>
 <c6f8e8b0-e391-67a7-4fcb-b88464285f65@redhat.com>
 <810018352.9991598.1583243092838.JavaMail.zimbra@redhat.com>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH] tests/acceptance: move @skipUnless decoration to test
 itself
In-reply-to: <810018352.9991598.1583243092838.JavaMail.zimbra@redhat.com>
Date: Tue, 03 Mar 2020 13:59:47 +0000
Message-ID: <877e017d4c.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Cleber Rosa <crosa@redhat.com> writes:

> ----- Original Message -----
>> From: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
>> To: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>, qemu-devel@nongnu.org
>> Cc: "Aurelien Jarno" <aurelien@aurel32.net>, f4bug@amsat.org, "Aleksanda=
r Markovic" <amarkovic@wavecomp.com>
>> Sent: Monday, March 2, 2020 1:14:31 PM
>> Subject: Re: [PATCH] tests/acceptance: move @skipUnless decoration to te=
st itself
>>=20
>> On 3/2/20 7:09 PM, Alex Benn=C3=A9e wrote:
>> > It appears ignore the decoration if just applied to the class.
>>=20
>> Odd I remember testing this, this might be a feature supported by a
>> newer Avocado version than the one available on Travis-CI.
>>=20
>> >=20
>> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> > ---
>> >   tests/acceptance/machine_mips_malta.py | 4 ++--
>> >   1 file changed, 2 insertions(+), 2 deletions(-)
>> >=20
>> > diff --git a/tests/acceptance/machine_mips_malta.py
>> > b/tests/acceptance/machine_mips_malta.py
>> > index 92b4f28a112..b8fac2a44d5 100644
>> > --- a/tests/acceptance/machine_mips_malta.py
>> > +++ b/tests/acceptance/machine_mips_malta.py
>> > @@ -30,14 +30,14 @@ except ImportError:
>> >       CV2_AVAILABLE =3D False
>> >=20=20=20
>> >=20=20=20
>> > -@skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
>> > -@skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
>> >   class MaltaMachineFramebuffer(Test):
>> >=20=20=20
>> >       timeout =3D 30
>> >=20=20=20
>> >       KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
>> >=20=20=20
>> > +    @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
>> > +    @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
>> >       def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
>> >           """
>> >           Boot Linux kernel and check Tux logo is displayed on the
>> >           framebuffer.
>> >=20
>>=20
>> Unfortunately you have to also add it to the 7/8cores tests.
>>=20
>>=20
>>=20
>
> This is true of Avocado < 76.0, but on 76.0 you can decorate the
> class too:
>
> https://avocado-framework.readthedocs.io/en/76.0/releases/76_0.html#users=
-test-writers
>
> Maybe replace this patch and bump Avocado's version?

Where is this defined in the source?

>
> - Cleber.


--=20
Alex Benn=C3=A9e

