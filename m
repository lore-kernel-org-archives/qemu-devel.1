Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7993CA9EC9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 21:56:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DA7621D7F
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 21:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA7621D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRkKP-0002Ev-OD
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 16:56:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iRkJM-0001YB-45
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 16:54:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iRkJJ-0007N7-VO
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 16:54:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49402)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iRkJJ-0007Kr-Mo
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 16:54:53 -0500
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A38123DD47
 for <qemu-devel@nongnu.org>; Mon,  4 Nov 2019 21:54:51 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id m17so10982206wrb.20
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 13:54:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BqaclnhIeRZoAy2jktmnNSt0bRyebT0TfIUREC2+X6A=;
 b=LV9QD2qkvJiU/vdREEBMDn+zkLhCMKTQ0ZTLRCyujvB+03217jcpS63cZAVHvLYbZ+
 KQvhScNWsGLA5EyDo9/XYx2IjT6CthfVQ+L854OQ5p0GVHD0HvvmRGWgBJs0jQC1dB89
 qN5PAwwDYcppg/N5Z/HF1IBnxxFasuP1pfHYWN3mJHTpvk/iaHWbUPsBy+Urdb8KTR1w
 yCNgTsMpCsqAzh3ShDx/9Xb4houJ97jNIyYDv3jUw+pJ3l6D727WMm1S5AMfnpiwxJAe
 KTQ4MRhK7xPNckpkybCgo+SnSuAvA6tu0qiWUHtq5OZjq8qn6ncOxXS7gsRiq2tfZANa
 1m/A==
X-Gm-Message-State: APjAAAUYLGQSiawru/eja2nnZGMB+NlGEKeIQuL6DbMOyZ0B558vxFn1
 qNwFsfXMbJpCdiGlGxIZwJdwPUex6+WhvmK46f0fAig+ZT14UhXqVu5n+G8XrjJCXOyFp9YRS/o
 xpCMnkP+aYyTRzhc=
X-Received: by 2002:a5d:4701:: with SMTP id y1mr26555476wrq.385.1572904490435; 
 Mon, 04 Nov 2019 13:54:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqx7f2zV4SdY2c+gEBBIJpCpf6DV8UgIFOhKqNLS7hdKEuSAg8vepnEeet1BiaUN2V+cG+9Paw==
X-Received: by 2002:a5d:4701:: with SMTP id y1mr26555460wrq.385.1572904490148; 
 Mon, 04 Nov 2019 13:54:50 -0800 (PST)
Received: from [192.168.1.24] (lfbn-1-7864-228.w92-167.abo.wanadoo.fr.
 [92.167.33.228])
 by smtp.gmail.com with ESMTPSA id l5sm16340582wmj.44.2019.11.04.13.54.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2019 13:54:49 -0800 (PST)
Subject: Re: [PATCH] global: Squash 'the the'
To: qemu-devel@nongnu.org, no-reply@patchew.org, dgilbert@redhat.com
References: <157290359988.27285.16497763825853147226@37313f22b938>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <86ede4a8-caf7-70b9-367b-9821373aa0f3@redhat.com>
Date: Mon, 4 Nov 2019 22:54:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157290359988.27285.16497763825853147226@37313f22b938>
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
Cc: peter.maydell@linaro.org, sstabellini@kernel.org, qemu-trivial@nongnu.org,
 mjt@tls.msk.ru, laurent@vivier.eu, marcandre.lureau@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/4/19 10:40 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20191104185202.102504-1-dgilbert@=
redhat.com/
>=20
> Hi,
>=20
> This series failed the docker-quick@centos7 build test. Please find the=
 testing commands and
> their output below. If you have Docker installed, you can probably repr=
oduce it
> locally.
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> make docker-image-centos7 V=3D1 NETWORK=3D1
> time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D14 NETWORK=3D1
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
>    TEST    iotest-qcow2: 009
>    TEST    iotest-qcow2: 010
> **
> ERROR:/tmp/qemu-test/src/tests/migration-test.c:903:wait_for_migration_=
fail: assertion failed: (!strcmp(status, "setup") || !strcmp(status, "fai=
led") || (allow_active && !strcmp(status, "active")))
> ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/migration-test.c:903:w=
ait_for_migration_fail: assertion failed: (!strcmp(status, "setup") || !s=
trcmp(status, "failed") || (allow_active && !strcmp(status, "active")))
> make: *** [check-qtest-aarch64] Error 1
> make: *** Waiting for unfinished jobs....

=3D)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

