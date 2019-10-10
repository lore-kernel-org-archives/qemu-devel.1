Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237E2C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:28:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBEFF206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBEFF206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIWci-0000Lv-4r
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 07:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iIWbk-0007zr-Qc
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iIWbj-0003fS-Pa
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:27:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36868)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iIWbj-0003ex-KB
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:27:47 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B5F9BC054C58
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 11:27:46 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id n3so2490645wmf.3
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 04:27:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EVSp01GFizitQoFeA2vkC5QK0111TnbIGqgfspWggfo=;
 b=bivM2nDH0puLBgTm7MWdxz5loTUdi9f+aU6OxgB3OXX0+qErvtDREfNMPnnyuMPz/5
 cUZcu95LacXSXAupBe8XggLwpB/E80WAaf2yM/sDsq7IP/731HOkP1rdTTwOjThJ8Vqe
 BrYwUDx5nRLIhm4Zxm8z+hbrUFDnr9ZJrcoMQ+829bkn1JUO7NNyHOCfs+8428nv4i0M
 6J1f6xe340AuK8FS4LIz2cUTOCJv0oXBgvSWg8co0ikEXhVFiqBECEf6nZZvNiYvHPDC
 m8sYJJAFhkQFPnGMw3+AqhvfYXrYhT0VxZeC5zvEDRnwir3rXYLMAu1uMECsEk5LjBFf
 hd0A==
X-Gm-Message-State: APjAAAXJgfiXEUnICDrCjek7DFGAd2V9chTJ6zvD5mJ5+hrZufOCef5p
 qRT/79vbojXYm19xyaPxo1iaV7HdyxBnRgXXUb0j6zDE8GwfIVZzvByvL8fZxBfcUme5044RjUo
 TzXczYHxT8l61OWA=
X-Received: by 2002:adf:fe8d:: with SMTP id l13mr8200073wrr.365.1570706865487; 
 Thu, 10 Oct 2019 04:27:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyXSSlogHBllkS+Hbg2Lphoz3Ms22KjTAN3aH95rRegy01YkQHwl/4AXdBNBwah+764eK4hYg==
X-Received: by 2002:adf:fe8d:: with SMTP id l13mr8200047wrr.365.1570706865222; 
 Thu, 10 Oct 2019 04:27:45 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id 36sm8028973wrp.30.2019.10.10.04.27.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2019 04:27:44 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] qemu-iotests: 044: pass is actually a noop, so
 remove it
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20191009194740.8079-1-crosa@redhat.com>
 <20191009194740.8079-4-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d7a92123-569e-05be-c5d4-f24358e605eb@redhat.com>
Date: Thu, 10 Oct 2019 13:27:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191009194740.8079-4-crosa@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/19 9:47 PM, Cleber Rosa wrote:
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   tests/qemu-iotests/044 | 3 ---
>   1 file changed, 3 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/044 b/tests/qemu-iotests/044
> index 8b2afa2a11..aa2a00ceed 100755
> --- a/tests/qemu-iotests/044
> +++ b/tests/qemu-iotests/044
> @@ -102,17 +102,14 @@ class TestRefcountTableGrowth(iotests.QMPTestCase=
):
>       def setUp(self):
>           qemu_img('create', '-f', iotests.imgfmt, '-o', 'cluster_size=3D=
512', test_img, '16G')
>           self.preallocate(test_img)
> -        pass
>  =20
>  =20
>       def tearDown(self):
>           os.remove(test_img)
> -        pass
>  =20
>       def test_grow_refcount_table(self):
>           qemu_io('-c', 'write 3800M 1M', test_img)
>           qemu_img_verbose('check' , test_img)
> -        pass
>  =20
>   if __name__ =3D=3D '__main__':
>       iotests.main(supported_fmts=3D['qcow2'],
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

