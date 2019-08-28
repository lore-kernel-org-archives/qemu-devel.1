Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEB0C3A5A4
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 09:36:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74B9C208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 09:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B9C208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2uNa-0002jl-CK
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 05:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1i2uLp-00015y-2L
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:34:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1i2uLn-0008Gr-6A
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:34:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48834)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1i2uLm-0008G7-Uh
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:34:47 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 14FF812A2
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 09:34:46 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id o5so1035916wrg.15
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 02:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=L4moDkRFOywyaKRwO3l2YdRrAg1YFjx3Zd0ETI+CxfU=;
 b=rAEnIHYBbWsNZI0mDRRXcY+M4ajD3lqH3ZztHDF0Zcai/nTRX4FUV1Aqmthc6SUqjI
 Q34qC5e+07UTQV4k4IkkGi/FH+0+EmZtcgQQgpLIwA9IXfWqGgtB7Qkv6ChQv8jYe8LU
 J+TBKhLTNH8Fns7r4JhxnSW6SZr6gXV+STBCEFsf2UG1klgQpecH900tXf57JbsBb5Os
 S9eGo2aDjq9IyXtoxddTTlNCvHVrnYHYdV4m9xOjdaHpygUMOFI53Pxj8NKjhDIipK9r
 sFScLGbVykRCVZKZJ7whaMLMv17rcC4LmKCu6pFFEB5ZHfwbK7BOhHOEzd+7pb7Rq9Gm
 3VUw==
X-Gm-Message-State: APjAAAUBDi2AFfqiW7k6xr5nC6weCxOpztTHHyjipfGBdej5nsN5SD3r
 PAlwHHv41T3wcmhqrt13wjPyx9JHfr6Bttg/FAEO3CnIewkBUBdGoX9s2rZpQyOtYqQKwfYvlta
 jokyi7G8E6Gz2ukI=
X-Received: by 2002:adf:f28d:: with SMTP id k13mr3213424wro.19.1566984884817; 
 Wed, 28 Aug 2019 02:34:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzmPRyadxGC0K3jfclN9X/K+3YPWhiJGj/20tQrma+fkudzahGTyVz5VBV4lzEBJd+YZb14wQ==
X-Received: by 2002:adf:f28d:: with SMTP id k13mr3213396wro.19.1566984884572; 
 Wed, 28 Aug 2019 02:34:44 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it.
 [79.13.201.122])
 by smtp.gmail.com with ESMTPSA id r4sm772229wrn.79.2019.08.28.02.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 02:34:44 -0700 (PDT)
Date: Wed, 28 Aug 2019 11:34:41 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190828093441.idt2vu7xz4zczi4j@steredhat>
References: <20190823130341.21550-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190823130341.21550-1-mreitz@redhat.com>
User-Agent: NeoMutt/20180716
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/2] block/file-posix: Reduce
 xfsctl() use
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
Cc: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 23, 2019 at 03:03:39PM +0200, Max Reitz wrote:
> Hi,
>=20
> As suggested by Paolo, this series drops xfsctl() calls where we have
> working fallocate() alternatives.  (And thus replaces =E2=80=9Cblock/fi=
le-posix:
> Fix xfs_write_zeroes()=E2=80=9D.)
>=20
> Unfortunately, we also use xfsctl() to inquire the request alignment fo=
r
> O_DIRECT, and this is the only way we currently have to obtain it
> without trying.  Therefore, I didn=E2=80=99t quite like removing that c=
all, too,
> so this series doesn=E2=80=99t get rid of xfsctl() completely.
>=20
> (If we did, we could delete 146 lines instead of these measly 76 here.)
>=20
>=20
> Anyway, dropping xfs_write_zeroes() will also fix the guest corruptions
> Luk=C3=A1=C5=A1 has reported (for qcow2, but I think it should be possi=
ble to see
> similar corruptions with raw, although I haven=E2=80=99t investigated t=
hat too
> far).
>=20
>=20
> Max Reitz (2):
>   block/file-posix: Reduce xfsctl() use
>   iotests: Test reverse sub-cluster qcow2 writes
>=20
>  block/file-posix.c         | 77 +-------------------------------------
>  tests/qemu-iotests/265     | 67 +++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/265.out |  6 +++
>  tests/qemu-iotests/group   |  1 +
>  4 files changed, 75 insertions(+), 76 deletions(-)
>  create mode 100755 tests/qemu-iotests/265
>  create mode 100644 tests/qemu-iotests/265.out

The patch and the test LGTM.

I tried to run the 265 test without the
"block/file-posix: Reduce xfsctl() use" patch and the failure rate is ~30=
% on
my system.

With the patch applied the failure rate is 0% :-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Tested-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

