Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953D6CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 17:08:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A4A0206A3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 17:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TbJmIQ9e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A4A0206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYYOd-0001hX-CW
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 13:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYYBP-0001qG-E9
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:55:07 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40831)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYYBN-0002Mb-7i
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:55:07 -0400
Received: by mail-wm1-x344.google.com with SMTP id u16so24246710wmc.5
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 09:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=UXmarglZojfO1A8BU3EtiwEdWFl5N2qsjwk/zZKHK3U=;
 b=TbJmIQ9eKX/0wyI8hZejozJkEERzQxSbSySNaj15+uvQnehWvt1w4emPnyjx72jxPt
 WXp7Wnk/LGRWcMUgshC/ZZqZ09K781PMoCDZSQis+OOqrBGogLJS+JlHpWT7tuZhQJ7P
 SyrSfB8JUrh+uzIW6js1tr8wLG1pCtRbDp+s731FBUDIS4krKNOgJ0uta3I59AVXX37V
 3KQYWzwW3/yM4S+7yb1nLjYn/HkmGuzZfBv7pGU7+A61qr5mLXfTJ8rJaegbIQb+6+Mi
 0jpQvenRoiZcnDKv5RX1VFE0dsPJxUSD289rxKbr6K4Jiv+hKZh11BzRC2frtqPJLFKa
 NtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=UXmarglZojfO1A8BU3EtiwEdWFl5N2qsjwk/zZKHK3U=;
 b=ZRr99mOAi5AFSV2V3sSTj88B+YI+TTTnnOfV5gM9DF50DtDsamnksjr4KGz37Liay+
 OjdR6VlHjJlh4shuUAG0VtGclSTb/8e+yPIk0gf+Bx5PP6mHG2KAHMn29OM1+L5NRRVI
 oPSETjAIAVv8WPcTBxLMjozPurHNJPsvUofm8tt1Vg9agjLzBknk65mj9xU9ZfSxBd2x
 r959CSkk14yOk1dMYkDQgX6nhwiUMXjj/6ujE8C03JajWfTB4uvCwBHFlsUhFLJYc+EA
 ltLwMJdNhro+lg8sXXep2FCdm+6rojwwKa/H7lwCaHRXK881TbnzKW9KHxTak07lOXa4
 DA7Q==
X-Gm-Message-State: AOAM532+DS1QuOZC+8JvJ43EmbQXlmQFyYDLRj08D5/QnaZT7x5Z7hY0
 kvvbKQN6DZFa7jS+9BhMDmKVHFb1Nxg=
X-Google-Smtp-Source: ABdhPJxcqqHdlFDWQ48S3PtXxHTVj96TGLLmOjkgoyCYwD3Un+m26yRYS677aMntss5DJuaobX0aZQ==
X-Received: by 2002:a7b:c201:: with SMTP id x1mr2872870wmi.14.1589302502110;
 Tue, 12 May 2020 09:55:02 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z11sm23164173wro.48.2020.05.12.09.55.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 09:55:00 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 339F01FF7E;
 Tue, 12 May 2020 17:55:00 +0100 (BST)
References: <20200512133849.10624-1-thuth@redhat.com>
User-agent: mu4e 1.4.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] travis.yml: Improve the --disable-tcg test on s390x
In-reply-to: <20200512133849.10624-1-thuth@redhat.com>
Date: Tue, 12 May 2020 17:55:00 +0100
Message-ID: <87d079f5zv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Philippe =?utf-8?Q?Mathi?= =?utf-8?Q?eu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> Since the s390x containers do not allow KVM, we only compile-test
> the --disable-tcg build on s390x and do not run the qtests. Thus,
> it does not make sense to install genisoimage here, and it also does
> not make sense to build the s390-ccw.img here again - it is simply
> not used without the qtests.
> On the other hand, if we do not build the s390-ccw.img anymore, we
> can also compile with Clang - so let's use that compiler here to
> get some additional test coverage.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Queued to testing/next, thanks.

> ---
>  .travis.yml | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index fe708792ca..1ec8a7b465 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -502,9 +502,10 @@ jobs:
>                $(exit $BUILD_RC);
>            fi
>=20=20
> -    - name: "[s390x] GCC check (KVM)"
> +    - name: "[s390x] Clang (disable-tcg)"
>        arch: s390x
>        dist: bionic
> +      compiler: clang
>        addons:
>          apt_packages:
>            - libaio-dev
> @@ -528,21 +529,10 @@ jobs:
>            - libusb-1.0-0-dev
>            - libvdeplug-dev
>            - libvte-2.91-dev
> -          # Tests dependencies
> -          - genisoimage
>        env:
>          - TEST_CMD=3D"make check-unit"
> -        - CONFIG=3D"--disable-containers --disable-tcg --enable-kvm --di=
sable-tools"
> -      script:
> -        - ( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )
> -        - BUILD_RC=3D0 && make -j${JOBS} || BUILD_RC=3D$?
> -        - |
> -          if [ "$BUILD_RC" -eq 0 ] ; then
> -              mv pc-bios/s390-ccw/*.img pc-bios/ ;
> -              ${TEST_CMD} ;
> -          else
> -              $(exit $BUILD_RC);
> -          fi
> +        - CONFIG=3D"--disable-containers --disable-tcg --enable-kvm
> +                  --disable-tools --host-cc=3Dclang --cxx=3Dclang++"
>=20=20
>      # Release builds
>      # The make-release script expect a QEMU version, so our tag must sta=
rt with a 'v'.


--=20
Alex Benn=C3=A9e

