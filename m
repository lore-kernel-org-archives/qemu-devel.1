Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E48C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:39:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEB7B2076E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JhOkiXbi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB7B2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRJLD-0007k4-0z
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 13:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRJJM-0005wC-AU
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:37:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRJJL-0005QW-JO
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:37:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29798
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRJJL-0005Pw-5e
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587577042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yXXmTtzCDugQju/4J89jwo1iTB0Wivr18bT89DE4EsU=;
 b=JhOkiXbi5xUSxMWGHvJxTGS9acUF8NOwI1Ns2PDZccOlzSBqABqYUhX+zJLqTwsxBVm5on
 JVEbt/n6/BDfUOBVfvZUrT2VrDE85bV3eDDEn1ckn7gyWwkzLJdaHdmbXNTxq/nc5Z8BBd
 +wReNjaaxkBd25pF3mJU8RE2M5OId6I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-TfG5eNE9PjuQVChELBI_1g-1; Wed, 22 Apr 2020 13:37:18 -0400
X-MC-Unique: TfG5eNE9PjuQVChELBI_1g-1
Received: by mail-wm1-f69.google.com with SMTP id n127so1156975wme.4
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 10:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oess+Iv6ercj0520dfm/8RkDVBBQ5tSian1yhjLFJxU=;
 b=aPLtxvp7Te+rfhHM5gij4qFK0J98zhLSn4ziv1G+iuRab5+QJoVrmSldusMDySh9gw
 2WniEOLVFJ3cfvtLdHin/rPXvBK7KEj1adU475fDjfcAjP5Cfe95RiQExWY/fWhjlxiz
 WAUKwypalisH2aL7O8ri4D2vEun1x0jwUJaV2zKlzqlqbo3esUwknKf2DLe69XXFbYvR
 KP2aQYG6ovt2J8Z0ztnJ5K/LF9IPswog2mWRECLUKkWuRiXRrAMc2xViQHZdfbf8xfWZ
 V0dd0IQUe4AxDtaNXXO9rpfZl53qNKZvntEVtBDa8DKk4muWXnJIDN3bbaUVpZr0fm3A
 CzGw==
X-Gm-Message-State: AGi0PuYZ9RNgr3pNcwXnq3uOONjWx/NGd1U1GgQnqafCnNrhaLw47FGV
 3CKmL3RMmCpyftOE9VckL/OH4Ls7XXh/qRlJqQqqMCwDl7wNhwi7TG7Xv0y+8ycIgZVVfdgPans
 jKg7hLz/y7qplVyg=
X-Received: by 2002:a1c:2002:: with SMTP id g2mr11277454wmg.109.1587577037617; 
 Wed, 22 Apr 2020 10:37:17 -0700 (PDT)
X-Google-Smtp-Source: APiQypIit2pm/pzrOwipf4oByF/Rl38JPb3/DSo6N11noJ2FpR92J4bEL/T6rt3nv5uhbKHQGIJ+MQ==
X-Received: by 2002:a1c:2002:: with SMTP id g2mr11277433wmg.109.1587577037383; 
 Wed, 22 Apr 2020 10:37:17 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id l19sm8840635wmj.14.2020.04.22.10.37.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2020 10:37:16 -0700 (PDT)
Subject: Re: [PATCH 2/8] docker.py/build: support binary files in --extra-files
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200422172351.26583-1-pbonzini@redhat.com>
 <20200422172351.26583-3-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1626c006-3f12-4309-9b02-e0929be7a9d7@redhat.com>
Date: Wed, 22 Apr 2020 19:37:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200422172351.26583-3-pbonzini@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 04:15:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/22/20 7:23 PM, Paolo Bonzini wrote:
> Read the --extra-files in binary mode to avoid encoding errors.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tests/docker/docker.py | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index ad61747bae..85e1dda10f 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -56,15 +56,19 @@ class EngineEnum(enum.IntEnum):
>  =20
>   USE_ENGINE =3D EngineEnum.AUTO
>  =20
> +def _bytes_checksum(bytes):
> +    """Calculate a digest string unique to the text content"""
> +    return hashlib.sha1(bytes).hexdigest()
> +
>   def _text_checksum(text):
>       """Calculate a digest string unique to the text content"""
> -    return hashlib.sha1(text.encode('utf-8')).hexdigest()
> +    return _bytes_checksum(text.encode('utf-8'))
>  =20
>   def _read_dockerfile(path):
>       return open(path, 'rt', encoding=3D'utf-8').read()
>  =20
>   def _file_checksum(filename):
> -    return _text_checksum(_read_dockerfile(filename))
> +    return _bytes_checksum(open(filename, 'rb').read())
>  =20
>  =20
>   def _guess_engine_command():
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


