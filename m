Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3D2C54FCE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:11:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A92320801
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aGRIM1x1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A92320801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7JsY-00025h-9q
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 09:11:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43545)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7Jrw-0001RZ-Vr
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:10:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7Jrv-00065Y-N2
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:10:28 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56517
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7Jrv-00065B-JT
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:10:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582812626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HUMBnaNE232sxsuM+1RQl1V3eZcvOv1P5kL2lDaaaFk=;
 b=aGRIM1x1jeJ6KzkWXgKt9nq1MJ/1Lt3Nz24pbf2uOgKYv2wdR1sWrzcE4aYOh2eVF3bInS
 iy2G1y8lUecCBD/5RsgfFPOxZVGdUfasbic+pBH/LySmR1n6+64YrWWyqNtsnkMYqpsCMX
 0UpSCF63prZpppdWKykzHv9AX3GJzbQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-TqtKwhsYOySwfdTvxRpAxQ-1; Thu, 27 Feb 2020 09:10:24 -0500
X-MC-Unique: TqtKwhsYOySwfdTvxRpAxQ-1
Received: by mail-wm1-f72.google.com with SMTP id f9so740820wmb.2
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 06:10:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=j/HrXiUtaWwbUUyf78KnlpOANbjR1CAHdCyjfLaoZ6E=;
 b=pRCiG+2oOlZM7tfvKOeKsPqzZVrHjjPT/zKkAX+AbiQ7L0V4itpUJPQXcBYtd/OvI3
 eNk7iKE2ZSdwgDlULZu8US+Ye9CKulpZ6a5dGvBXxIyMgaf01FVitsoFkymvAUjJtQ8J
 /bm9MylyrMv9ro/dipQ4e5IXOYCWHM/nj0mjHOwGZHVRee1DQN6ma3AZIqJQ7kbhGifk
 TKIPsQ/vtyikpnYph9kanA1sWgBZx6KDXJIcCpqPFyBch3H+STiFrFUADEFBoPrr8QDD
 /2zDdXl5YlhpOpPPnxGm4UutsAwNK03s8f3/hXeyui+Jxo1Rdm3JXRgdiRX/rCRm3cTj
 59cA==
X-Gm-Message-State: APjAAAWHiGYUMkSALvniDisU3y+maZDGqPDfCyRVvaFVUSJE8EdecqZC
 lEtRksWY+5hjsggnyyXRKhd5lJ9OPlK1yp1WQJgprv4bozWpR2tfN05f1Bd4/KqoivlWWoNPqTj
 Yn+M0bumeVIAK8j4=
X-Received: by 2002:adf:ee85:: with SMTP id b5mr5135185wro.34.1582812623317;
 Thu, 27 Feb 2020 06:10:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqygGuIUp53Af7SJjWlDU8DGE5md6VuvWlE00p7QuuQ8sZjIWm9Jbq+XK+jfjo2NnveDYZn2OQ==
X-Received: by 2002:adf:ee85:: with SMTP id b5mr5135158wro.34.1582812623030;
 Thu, 27 Feb 2020 06:10:23 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id t13sm7864029wrw.19.2020.02.27.06.10.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 06:10:22 -0800 (PST)
Subject: Re: [PATCH v6 4/9] iotest 258: use script_main
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200227000639.9644-1-jsnow@redhat.com>
 <20200227000639.9644-5-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <68c6b834-5326-6815-016b-3dd245e74e76@redhat.com>
Date: Thu, 27 Feb 2020 15:10:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200227000639.9644-5-jsnow@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/27/20 1:06 AM, John Snow wrote:
> Since this one is nicely factored to use a single entry point,
> use script_main to run the tests.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   tests/qemu-iotests/258 | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/258 b/tests/qemu-iotests/258
> index a65151dda6..e305a1502f 100755
> --- a/tests/qemu-iotests/258
> +++ b/tests/qemu-iotests/258
> @@ -23,12 +23,6 @@ import iotests
>   from iotests import log, qemu_img, qemu_io_silent, \
>           filter_qmp_testfiles, filter_qmp_imgfmt
>  =20
> -# Need backing file and change-backing-file support
> -iotests.script_initialize(
> -    supported_fmts=3D['qcow2', 'qed'],
> -    supported_platforms=3D['linux'],
> -)
> -
>   # Returns a node for blockdev-add
>   def node(node_name, path, backing=3DNone, fmt=3DNone, throttle=3DNone):
>       if fmt is None:
> @@ -161,4 +155,7 @@ def main():
>       test_concurrent_finish(False)
>  =20
>   if __name__ =3D=3D '__main__':
> -    main()
> +    # Need backing file and change-backing-file support
> +    iotests.script_main(main,
> +                        supported_fmts=3D['qcow2', 'qed'],
> +                        supported_platforms=3D['linux'])
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


