Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13681C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 18:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E241A205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 18:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E241A205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3PFW-0001Jg-2k
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 14:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45136)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i3PAH-00066F-EG
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 14:28:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i3PAG-0007r8-DR
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 14:28:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35632)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i3PAG-0007qC-4a
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 14:28:56 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4506587638
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 18:28:55 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id x12so2547618wrw.0
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 11:28:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HZJseB1WYxY6ZRB8poIcT+wXeIDW1gEf0VCj+H6FZb8=;
 b=G8cfxQiTPhQmse+p7uIWFmLuBz3FeEMQoCDd/IAdBrV2ELfmcSzVELmgiPEqBCeKJ+
 iXZX0yxHQLQOCHEMcsaqhGHZG4J2Y5qGG2b8Awy2GBgHFXTsbIDymx9BEQzVlRH5d/fP
 ZUYgnUBneqWn68M6z1SpKVnatqW6uUgSpqLhyziS8PXtpkjmdxyQSArSgOEr3AaqEUox
 otzRm7PR7CfkvJ28mgVRR6krje9IZyAHkTrdtBrqdPC4lkEqO1oAV+NQkw8jDdOP6JRJ
 ta8ZoAiqI8ZGf8bCIjrdU6SMsHsBVdukpk6vXcgT3D4GwOIj/GiZ9k6QnuHSXzp2mwxK
 la3Q==
X-Gm-Message-State: APjAAAVHB2HSOHkkDFb5mkMSKl/GQCgphqTENqFOj2RLGMhf1hYtrM+6
 Nu7YVO1FeEkLyV14h05xBdLRFO7OTz3jEIS3lsOairH7qKFNbtRnjTWnOwB4TS5w6KcLyaGq2Ea
 ryjtnB/Qxo91GQBc=
X-Received: by 2002:a1c:a6ca:: with SMTP id p193mr541170wme.103.1567103333936; 
 Thu, 29 Aug 2019 11:28:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwPFI70jOffSFB0mQmgizRZrK+7ONSBDiU+lX3b9+s945UyS1IQKet3bRiEF2+II7NomCe99Q==
X-Received: by 2002:a1c:a6ca:: with SMTP id p193mr541147wme.103.1567103333711; 
 Thu, 29 Aug 2019 11:28:53 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id g65sm6035648wma.21.2019.08.29.11.28.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2019 11:28:52 -0700 (PDT)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190820235243.26092-1-jsnow@redhat.com>
 <20190820235243.26092-3-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <4427d4da-6ab3-5ee4-d7c0-40d5995e811f@redhat.com>
Date: Thu, 29 Aug 2019 20:28:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190820235243.26092-3-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 2/4] iotest 258: use script_main
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
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/21/19 1:52 AM, John Snow wrote:
> Since this one is nicely factored to use a single entry point,
> use script_main to run the tests.

With your Signed-off-by:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  tests/qemu-iotests/258 | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/258 b/tests/qemu-iotests/258
> index b84cf02254..1372522c7a 100755
> --- a/tests/qemu-iotests/258
> +++ b/tests/qemu-iotests/258
> @@ -23,11 +23,6 @@ import iotests
>  from iotests import log, qemu_img, qemu_io_silent, \
>          filter_qmp_testfiles, filter_qmp_imgfmt
> =20
> -# Need backing file and change-backing-file support
> -iotests.verify_image_format(supported_fmts=3D['qcow2', 'qed'])
> -iotests.verify_platform(['linux'])
> -
> -
>  # Returns a node for blockdev-add
>  def node(node_name, path, backing=3DNone, fmt=3DNone, throttle=3DNone)=
:
>      if fmt is None:
> @@ -160,4 +155,5 @@ def main():
>      test_concurrent_finish(False)
> =20
>  if __name__ =3D=3D '__main__':
> -    main()
> +    # Need backing file and change-backing-file support
> +    iotests.script_main(main, supported_fmts=3D['qcow2', 'qed'])
>=20

