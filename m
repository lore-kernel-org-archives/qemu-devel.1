Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175BDCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:42:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4F9920B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P0jibDZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F9920B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMrcG-00029k-3K
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 06:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iMrbc-0001kb-Kd
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:41:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iMrbb-0001NQ-D5
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:41:36 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39194)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iMrbb-0001N7-5a
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:41:35 -0400
Received: by mail-wr1-x443.google.com with SMTP id a11so1390456wra.6
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 03:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=JHRxvgL9FDQka6jd9HMMnEgyR0vmSHI4ys57q/6/LmY=;
 b=P0jibDZVKr3FoLVflKAvcMnGOSqVDYmDtjr0m6F+W5Q3P30cGKagjp9GVrI6lK8RoU
 V3Vlh4Q3stdu1QRodLOQ9qLsHHnh+Mq8J7uuXHhKjGfFNa6M4AeXdniRDWwX9Sw6UxFr
 XQpWwQ5a55ZXhKEgH5acPSdrsXPjU9FMQedbiXjsasjAm/RO5mB6bbx8sokArgavrJF+
 nrCmG+e9NAo90nX9YGXcueymoCRNpCgs7OsvW9RePXl3OP+p9EmCWdzl39AqopLsuDQ3
 g54z10hCqKFqpe4ezz8S8KLWqhkD7NRkfUhPKo5puNdOl2Yc32tssL8dar6FsBT8p0oK
 EPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=JHRxvgL9FDQka6jd9HMMnEgyR0vmSHI4ys57q/6/LmY=;
 b=NWw2Ecv4GOtIR7JJs0/cyyNoVfHJE3ZCqLcb4HYflguMp0P8MdSMzQu0tPRdRlCXwM
 BfBltqfoEoIqofjExwaY5GSfLVzQcZ05Q/M7hea8lwU3lLSRbSwQQvnmKiWEvy4tl1S6
 +zna1/c+HBjhdSJRx3gNI6Nmyu31CJynZ1Ype1yPpYHYg3NfAUN27K2Sr+JrVUGaFVn5
 CWUS/IgS0dgNigGRswnC5p1OEF4StbDWraik5rDmOIkiFxonPr/bpIHJgQC3LfsU8rqp
 n5JKPwBG/5CILaA/WEu+UdcpqkRfnpngfyj84/di6UG3PgF1Tw8YLuKm0SYRXTNQeLFV
 1ZOg==
X-Gm-Message-State: APjAAAXMY/cMvtAePFJB975hNLLg1VqQXecph8vv35EpQ7U7nivlCJ1G
 az3w1goHas4lT0DLzL7YaxtcPg==
X-Google-Smtp-Source: APXvYqyYkilgByeqxpjybtQLK1fEegCQ7w3wwUg1OL6J2M+qR1vFGRutR7HUjagM1hUXUnSK87AGFQ==
X-Received: by 2002:a5d:46ca:: with SMTP id g10mr2934333wrs.193.1571740893398; 
 Tue, 22 Oct 2019 03:41:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o15sm372131wrv.76.2019.10.22.03.41.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 03:41:32 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 091321FF87;
 Tue, 22 Oct 2019 11:41:32 +0100 (BST)
References: <20191009170701.14756-1-thuth@redhat.com>
 <20191009170701.14756-6-thuth@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 5/5] travis.yml: Compile on arm64, too
In-reply-to: <20191009170701.14756-6-thuth@redhat.com>
Date: Tue, 22 Oct 2019 11:41:31 +0100
Message-ID: <87lftdvz8k.fsf@linaro.org>
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> Travis now features an arm64 build host, so let's check compilation
> there, too.
>
> Unfortunately, there are some quirks:
> - block/ssh.c does not compile properly in this environment, so we have
>   to use --disable-libssh until that problem is fixed.
> - test-util-filemonitor fails, so we can not run the unit tests there
> - The file system size seems to be very limited, so the iotest tests
>   can't be used and the hd-geo-test fails (thus we can't compile
>   x86_64-softmmu here and run "check-qtest" afterwards)
> - Compiling seems to be quite a bit slower than on the x86 builders,
>   so we better limit the target list to some few architectures.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .travis.yml | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/.travis.yml b/.travis.yml
> index 0c88e8757b..357ca02890 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -342,3 +342,9 @@ matrix:
>          - CONFIG=3D"--target-list=3Dxtensa-softmmu,arm-softmmu,aarch64-s=
oftmmu,alpha-softmmu"
>          - TEST_CMD=3D"make -j3 check-tcg V=3D1"
>          - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
> +
> +    # Non-x86 builds:
> +    - env:
> +        - CONFIG=3D"--disable-libssh --target-list=3Daarch64-softmmu,ppc=
64-softmmu,s390x-softmmu,x86_64-linux-user"
> +        - TEST_CMD=3D"make check-qtest check-softfloat -j3 V=3D1"
> +      arch: arm64


Hmm this keeps fail for me now but it looks like missing deps:

Reading state information...

E: Unable to locate package libspice-server-dev
apt-get.diagnostics

apt-get install failed

The command "sudo -E apt-get -yq --no-install-suggests --no-install-recomme=
nds $(travis_apt_get_options) install libaio-dev libattr1-dev libbrlapi-dev=
 libcap-dev libcap-ng-dev libgcc-4.8-dev libgnutls28-dev libgtk-3-dev libis=
csi-dev liblttng-ust-dev libncurses5-dev libnfs-dev libnss3-dev libpixman-1=
-dev libpng-dev librados-dev libsdl2-dev libsdl2-image-dev libseccomp-dev l=
ibspice-protocol-dev libspice-server-dev libssh-dev liburcu-dev libusb-1.0-=
0-dev libvdeplug-dev libvte-2.91-dev sparse uuid-dev gcovr" failed and exit=
ed with 100 during .

--
Alex Benn=C3=A9e

