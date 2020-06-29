Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50337C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:07:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1861B23884
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0VZkfFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1861B23884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpqhh-00062t-Bw
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 06:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jpqeO-0002Wh-Uq
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 06:04:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58278
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jpqeL-0004zh-Qn
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 06:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593425069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=77mumMWEClNJLgsvvTSg5hEWgscXx+ECnODYkbDJlRI=;
 b=L0VZkfFTESwl0dUXNpWmlg/oTZ+p6LX/cxjo8jBXavkMU5L9FDfNLkUQ8YICnCbrYD8s53
 SIQN31aHqzUrFo4a+35Lz3F52K1HPa6mialxM+UYgZcvT6qCcaiPsB7Ho6yBc5m+ofqUUd
 N+JfdzsJnA1iDIvXdJIVOKbtsY4WdVs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-Zs8j65HlNMqWEUHyAd6CFA-1; Mon, 29 Jun 2020 06:04:27 -0400
X-MC-Unique: Zs8j65HlNMqWEUHyAd6CFA-1
Received: by mail-wm1-f71.google.com with SMTP id g124so18253077wmg.6
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 03:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=77mumMWEClNJLgsvvTSg5hEWgscXx+ECnODYkbDJlRI=;
 b=uF4ZijuiJXROaYnTiG+nXFf6o4yyyaCYq7Gtq0jkMiCUie/jLhODF4YT2HWMaZsdl8
 OJf3vYpd0I2qIQxmJBPrzH2mXqFv0dsVIoBbpfeL3MfA0GzC9YU4oCZq08D5mguj3/HO
 x5rQxnNMy4yQwrXnV9D3Namm9y706OMg4ksxqyMbgW8jIzQ/tpXHdvnINDKWQKTGj0iC
 H1aWvuPplODU91GtzR2Z1q+Yo6FyC+QenHho7kCst88E9Qxd+Mhv8SkJoXqXylpv9z/A
 KR0agILsPEdnvKL9yae0fFfGv+/QoMHC7NoDoVemr69u/B+MVPB8jTKDnPzsb/zNmkKq
 sP6Q==
X-Gm-Message-State: AOAM530VEJUhdHcVEZeeitssRfsN8b0elY9SQcoF9CvBkASb80QcMtv8
 tJHBTLvb9AYsJQCer6+PzS38+rnlBYkf1RKXjX6caAlWz+Sa5hLeh1cGFwkNhZpJtAmo8IqW9iL
 dBPVpxxoCG+bK7wY=
X-Received: by 2002:a1c:6a01:: with SMTP id f1mr15527866wmc.52.1593425065973; 
 Mon, 29 Jun 2020 03:04:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAqfYU9HGYc5BujuC82oiZNpbLFXSaBolnAqB+iDHvgdJYWV4NWKBzxVbunQhX+dX/mCH9mA==
X-Received: by 2002:a1c:6a01:: with SMTP id f1mr15527844wmc.52.1593425065762; 
 Mon, 29 Jun 2020 03:04:25 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id l1sm50119605wrb.31.2020.06.29.03.04.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 03:04:25 -0700 (PDT)
Subject: Re: [PATCH v3 15/30] tests/docker: change tag naming scheme of our
 images
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200626181357.26211-1-alex.bennee@linaro.org>
 <20200626181357.26211-16-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <d24808f8-118e-0ffe-44ed-8a5a859e6a55@redhat.com>
Date: Mon, 29 Jun 2020 12:04:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200626181357.26211-16-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:10:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, cota@braap.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/26/20 8:13 PM, Alex Bennée wrote:
> We've been misusing the tag naming scheme for some time by overloading
> the post : section with the image type. Really it should be saved for
> the revision of that particular build. Move the details to the other
> side so we have:
> 
>   qemu/image-name
> 
> with the implied :latest version added by the tooling.
> 
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - fix RUN invocation as well
>   - don't include :latest tag for debian-arm64-cross (implied)
> ---
>  tests/docker/Makefile.include                           | 4 ++--
>  tests/docker/docker.py                                  | 2 +-
>  tests/docker/dockerfiles/debian-alpha-cross.docker      | 2 +-
>  tests/docker/dockerfiles/debian-amd64-cross.docker      | 2 +-
>  tests/docker/dockerfiles/debian-amd64.docker            | 2 +-
>  tests/docker/dockerfiles/debian-arm64-cross.docker      | 2 +-
>  tests/docker/dockerfiles/debian-arm64-test-cross.docker | 2 +-
>  tests/docker/dockerfiles/debian-armel-cross.docker      | 2 +-
>  tests/docker/dockerfiles/debian-armhf-cross.docker      | 2 +-
>  tests/docker/dockerfiles/debian-hppa-cross.docker       | 2 +-
>  tests/docker/dockerfiles/debian-m68k-cross.docker       | 2 +-
>  tests/docker/dockerfiles/debian-mips-cross.docker       | 2 +-
>  tests/docker/dockerfiles/debian-mips64-cross.docker     | 2 +-
>  tests/docker/dockerfiles/debian-mips64el-cross.docker   | 2 +-
>  tests/docker/dockerfiles/debian-mipsel-cross.docker     | 2 +-
>  tests/docker/dockerfiles/debian-powerpc-cross.docker    | 2 +-
>  tests/docker/dockerfiles/debian-ppc64-cross.docker      | 2 +-
>  tests/docker/dockerfiles/debian-ppc64el-cross.docker    | 2 +-
>  tests/docker/dockerfiles/debian-riscv64-cross.docker    | 2 +-
>  tests/docker/dockerfiles/debian-s390x-cross.docker      | 2 +-
>  tests/docker/dockerfiles/debian-sh4-cross.docker        | 2 +-
>  tests/docker/dockerfiles/debian-sparc64-cross.docker    | 2 +-
>  tests/docker/dockerfiles/debian-tricore-cross.docker    | 2 +-
>  tests/docker/dockerfiles/debian-win32-cross.docker      | 2 +-
>  tests/docker/dockerfiles/debian-win64-cross.docker      | 2 +-
>  tests/docker/dockerfiles/debian9-mxe.docker             | 2 +-
>  26 files changed, 27 insertions(+), 27 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


