Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F4BC352A3
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 22:41:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2515214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 22:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XU2qod5W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2515214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izppW-0006Ve-V7
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 17:41:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58435)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izpot-0005rz-Di
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 17:40:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izpos-00009n-Br
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 17:40:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25130
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izpos-000065-7a
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 17:40:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581028821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=llC4Z7L0d5vKteDS59rDFJf4KQQwJZ1+ZPlk+Izxy5w=;
 b=XU2qod5WKaCgkjKiTQx3lfZshIZZwCFGkZ7iB3su3mssqwQHYUPo/iLieozIX51x5pY6RY
 ZolEvHRhMpExkYA0XvAGhIq6oEyFnt084nAyIGTclTzURBrc4LPrJ0+DVHaM7IUPYmKAR+
 bufSX7/Xl4s/gy1AY90xItikU9fS0qk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-7oWiQStHOmOu9PmQVIsM1A-1; Thu, 06 Feb 2020 17:40:17 -0500
Received: by mail-wm1-f71.google.com with SMTP id p2so39711wma.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 14:40:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Rr09J1D+eELMG+Cfk3EzW9zHjxrFfN+tiVGsyhPCzFs=;
 b=BR4X3+UK4olvuSWQ2yOJDCj/G6RAVnOjdCv/sx/0v+GUMqKdndBhgxF04b6VQmTnmp
 XWyDYvZEMFlC/9Tp0yCekMSYcQvnSOlqIwQ6gwEklrO2jAnghM5nE/MjetUIsAYcCAGd
 X72H8dgRdoaVi3DjkeGXfv11/BvrFIHgs19aM6hHVgnocxRYe8IyPmQ2HHCmlb557Dvr
 uK0wqytUkvdKODOXutrq2eoZ5UQOkXUmS8KDs+V0qnfOY8OzR52LMf4iGcBmDiU7Smqa
 jxvt4t5wXjmNM1uPl8WMewqeyoY/BQgA1LqycQCysMHP0Sxix8kjxSzvrV1WXG0U9B9G
 l4dw==
X-Gm-Message-State: APjAAAV/HuXPvj79F9AQ6LUlUcSuNOp44kHNxdtAZN1/URzu4prtAjTP
 s9DYownSPx3NgtnW8y3IJM8w3fC8R+xXMl5EBebbmhGckfG/pCcwVDtf9wPaAemWpiF+yUI/c0e
 rn5VLlsp7h7euMjY=
X-Received: by 2002:a5d:6886:: with SMTP id h6mr259833wru.154.1581028816403;
 Thu, 06 Feb 2020 14:40:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqzoA4Q3lIcgYKxUWJFjcU1dqT0yZ5iW1XrI3md/7vWPHP6/iMj3R9QmexyljoKn/cWiBwwVVQ==
X-Received: by 2002:a5d:6886:: with SMTP id h6mr259818wru.154.1581028816228;
 Thu, 06 Feb 2020 14:40:16 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id n3sm1046337wmc.27.2020.02.06.14.40.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 14:40:15 -0800 (PST)
Subject: Re: [PATCH] travis.yml: Test the s390-ccw build, too
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>
References: <20200206202543.7085-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <48598d71-efe0-3cf4-ce42-13e7c415ebb9@redhat.com>
Date: Thu, 6 Feb 2020 23:40:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206202543.7085-1-thuth@redhat.com>
Content-Language: en-US
X-MC-Unique: 7oWiQStHOmOu9PmQVIsM1A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/6/20 9:25 PM, Thomas Huth wrote:
> Since we can now use a s390x host on Travis, we can also build and
> test the s390-ccw bios images there. For this we have to make sure
> that roms/SLOF is checked out, too, and then move the generated *.img
> files to the right location before running the tests.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   .travis.yml | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index 6c0ec6cf69..c0eeff9caa 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -508,6 +508,16 @@ matrix:
>         env:
>           - TEST_CMD=3D"make check check-tcg V=3D1"
>           - CONFIG=3D"--disable-containers --target-list=3D${MAIN_SOFTMMU=
_TARGETS},s390x-linux-user"
> +      script:
> +        - ( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )
> +        - BUILD_RC=3D0 && make -j${JOBS} || BUILD_RC=3D$?
> +        - |
> +          if [ "$BUILD_RC" -eq 0 ] ; then
> +              mv pc-bios/s390-ccw/*.img pc-bios/ ;
> +              ${TEST_CMD} ;
> +          else
> +              $(exit $BUILD_RC);
> +          fi
>  =20
>       # Release builds
>       # The make-release script expect a QEMU version, so our tag must st=
art with a 'v'.
>=20

Maybe remove the trailing ", too" in subject...

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
https://travis-ci.org/philmd/qemu/jobs/647085877#L3190


