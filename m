Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F64CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 12:19:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBF772086D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 12:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBF772086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNFcA-0005aZ-Mg
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 08:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNFa5-0004GF-ME
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 08:17:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNFa4-0003u8-Ly
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 08:17:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39984)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNFa4-0003t5-EK
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 08:17:36 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8F4B885539
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 12:17:35 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id a6so8002374wru.1
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 05:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eNxJz2IYgT7TEJXv56X31ryvHb3/rMkvAMHOoTcdUSc=;
 b=cvkO7TzQS9qAHyLvksKzD1a6Iwaec3orf343a5SbT2lQ9a1hy4k3jRrd0YCq1dWHwt
 GoIOoyhcRiutW9cJBDqx3mVu7dT0o1dRmQxlk2G7H5oiEopZvbI2XO4EhbCRYElSKd75
 cDagwn5oAhxMMH3FTlGSUYReayc8SjfDSCoJd/m1exBd4dzd7SMFbGOlPq7O9Uc+2x+7
 XFiwrccPtU56mwasqzMD2QY50MhreaE6Wj+KZvwbq4a70e1YEl3SH27ZNxWlCcse1Gi4
 l05fyQhdoMCBakoVdTStN9uxK5GiSKvIRWT9Wn9pHCODB2lxreI86r1w0XhXNgSxOQsv
 5BIQ==
X-Gm-Message-State: APjAAAU6HqC90514xPCC3wI9qW2/mYX+melbOauGlOCTtt8DSv5lqBEP
 W+8eHvKLXIP/t3myO5oukzEbTorhj3+Vft4QhgGAiFsbKW6qf4Aj6h7rGP3B5S3Rc8Fr8TfxmHm
 iD1O/C3UjuaCL+k4=
X-Received: by 2002:a1c:9dd3:: with SMTP id g202mr7905828wme.43.1571833054133; 
 Wed, 23 Oct 2019 05:17:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw2MNDIC7gKMEOQ8rq62bKjYr5IWiMQFVUpBOKOfWk6UsritRqg2b7990QhhuG3wInAx6wSmQ==
X-Received: by 2002:a1c:9dd3:: with SMTP id g202mr7905813wme.43.1571833053941; 
 Wed, 23 Oct 2019 05:17:33 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id x8sm21222875wrr.43.2019.10.23.05.17.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2019 05:17:33 -0700 (PDT)
Subject: Re: [PATCH v1 16/19] iotests: Test 183 does not work on macOS and
 OpenBSD
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191022191704.6134-1-alex.bennee@linaro.org>
 <20191022191704.6134-17-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c7c85258-17b7-2fa8-779d-74f723af5cd1@redhat.com>
Date: Wed, 23 Oct 2019 14:17:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191022191704.6134-17-alex.bennee@linaro.org>
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
Cc: fam@euphon.net, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 stefanb@linux.vnet.ibm.com, richard.henderson@linaro.org, f4bug@amsat.org,
 Max Reitz <mreitz@redhat.com>, cota@braap.org, stefanha@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/22/19 9:17 PM, Alex Benn=C3=A9e wrote:
> From: Thomas Huth <thuth@redhat.com>
>=20
> In the long term, we might want to add test 183 to the "auto" group
> (but it still fails occasionally, so we cannot do that yet). However,
> when running 183 in Cirrus-CI on macOS, or with our vm-build-openbsd
> target, it currently always fails with an "Timeout waiting for return
> on handle 0" error.
>=20
> Let's mark it as supported only on systems where the test is working
> fine (i.e. Linux, FreeBSD and NetBSD).
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20191022072135.11188-4-thuth@redhat.com>
> ---
>   tests/qemu-iotests/183 | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/tests/qemu-iotests/183 b/tests/qemu-iotests/183
> index 04fb344d08e..ab5a7089549 100755
> --- a/tests/qemu-iotests/183
> +++ b/tests/qemu-iotests/183
> @@ -42,6 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>   . ./common.filter
>   . ./common.qemu
>  =20
> +_supported_os Linux FreeBSD NetBSD
>   _supported_fmt qcow2 raw qed quorum
>   _supported_proto file
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

