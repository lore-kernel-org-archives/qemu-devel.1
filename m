Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA927FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 09:57:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFC3121835
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 09:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC3121835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL2XI-0001M7-SY
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 05:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iL2Vu-00081T-3e
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 05:56:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iL2Vt-0008Lt-5P
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 05:56:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49378)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iL2Vs-0008L1-W4
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 05:56:09 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1EB6F10F09
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 09:56:08 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id g67so796108wmg.4
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 02:56:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yxs6sSSu8VQ8YzYH0Wt1/Gm2Fn9mHxn6/3jjKVtlMt8=;
 b=fEHWlEIwtHjp3mIs9FCNYqN908wzakZq+IloEH1xcoukZjwzRfYvvrKHpRzdw0iuIo
 EmnEWW/jRt2CS+f1d07nWvCWvIb7SoLWbwBf17BxLRjKljMMqEF5qGsvKNGvR5E+K5bm
 HlRFNVDgp7tfFtSEpUO6wiroX68kdeBxV/QtalfSY1QETqVEeKJYYC5HHGgarf60RZF5
 AA2pbyPeD/TnXEEyhewItfThMRJ329Tnns8TZaSIfNbhOsmK10+MWAK5H4ypd5Z3I8WV
 uHqVXpjRTIMf6uMGc0n/FNOYGDXA2fme02v9fap1i9M6QPkVOQGUacgpPiDnGR+liJrZ
 Px3A==
X-Gm-Message-State: APjAAAWVuFt0KkZThkzACXCT4s8oW+LEuWaRhH5ByM9pS29ryUseSyi3
 aqKTAp4fuytArr2a21OWV7gwRQN+pKNVQK4yaNzzU3Jy6rgYWsGEQm9mUX7eXqjlcUG7kyjtl6+
 7FrWEHtBaWPlDf58=
X-Received: by 2002:a5d:5408:: with SMTP id g8mr2158174wrv.202.1571306166560; 
 Thu, 17 Oct 2019 02:56:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwZaLHZnEvkVjo4PxZzMa3R8MtwgISSBnkBejfcjUCoedOJKc+xABhzxXXl2HRhzIVW3/4/Lw==
X-Received: by 2002:a5d:5408:: with SMTP id g8mr2158159wrv.202.1571306166397; 
 Thu, 17 Oct 2019 02:56:06 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id x5sm1640257wrg.69.2019.10.17.02.56.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2019 02:56:05 -0700 (PDT)
Subject: Re: [PATCH 02/10] image-fuzzer: Write bytes instead of string to
 image file
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20191016192430.25098-1-ehabkost@redhat.com>
 <20191016192430.25098-3-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9e9063e0-c8cd-5edd-1180-52fb53f07ee9@redhat.com>
Date: Thu, 17 Oct 2019 11:56:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191016192430.25098-3-ehabkost@redhat.com>
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
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/19 9:24 PM, Eduardo Habkost wrote:
> This is necessary for Python 3 compatibility.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>   tests/image-fuzzer/qcow2/layout.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/image-fuzzer/qcow2/layout.py b/tests/image-fuzzer/qc=
ow2/layout.py
> index c57418fa15..fe273d4143 100644
> --- a/tests/image-fuzzer/qcow2/layout.py
> +++ b/tests/image-fuzzer/qcow2/layout.py
> @@ -518,7 +518,7 @@ class Image(object):
>           rounded =3D (size + self.cluster_size - 1) & ~(self.cluster_s=
ize - 1)
>           if rounded > size:
>               image_file.seek(rounded - 1)
> -            image_file.write("\0")
> +            image_file.write(b'\x00')
>           image_file.close()
>  =20
>       @staticmethod
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

