Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A716ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 09:56:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C7892089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 09:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7892089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL2WE-0008Fa-A1
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 05:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54803)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iL2VP-0007TR-SX
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 05:55:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iL2VO-0007v0-Qh
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 05:55:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49936)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iL2VO-0007uU-If
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 05:55:38 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A9CD2756
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 09:55:37 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id 7so676845wrl.2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 02:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wSIRuvATS3+aCyr3YSmfiWiqidT0J1AJGN/DJAOVIhk=;
 b=Qu7OVl7r0W9TV3wnGRQhRaB4RIXFbtpkNcF+cJddIp8OtPF0S6WAA3N7Yk8/QfQBHu
 1Flwupx3HrktnH150VNK4/maoUz0K7n9a4EGlAE8pVUW2uERBAsYGWRvLlH64wT77TID
 kC98IEb5PJ3xx0QCJnB0hMUQOsWsfnsuhiH90m4ydM0zyxP2Rq9UrAdJq2rLhSWuK8h7
 1gs15SpELk5FBnhJAnkAvF3tNfvo08ehx9TOHc37hhJu0tvvb33GAsz+FfxpN4amlrf6
 c2WL+/lTiYCvWH53X2Ajlo2+J8GFEXbmeXthZXMvcqS/mS/1/LEVo5tYgmbJ45GAwrRI
 ABog==
X-Gm-Message-State: APjAAAUwYwOq6UrbNwj/g+OA3zPLIpPcG/MMW2zpEE6LCvKTk1r9roTB
 OhfASAsXjecNxT4TFS2+LyKCc09d04fIt0uFqgVTA5Sqxsg8HwZOOTGyOWAJ+Yima2XyfNSLr9Q
 HmgNDr6nxEhQKEAc=
X-Received: by 2002:adf:f64f:: with SMTP id x15mr2177228wrp.381.1571306136480; 
 Thu, 17 Oct 2019 02:55:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyF0kDRJi89JCRLi/qeAWioKqClbW9yA1cfekoIIMQeT/kfGI08IOXmRHIIrNtVlqMJRMq9pg==
X-Received: by 2002:adf:f64f:: with SMTP id x15mr2177210wrp.381.1571306136270; 
 Thu, 17 Oct 2019 02:55:36 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id n7sm1546885wrt.59.2019.10.17.02.55.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2019 02:55:35 -0700 (PDT)
Subject: Re: [PATCH 07/10] image-fuzzer: Use bytes constant for field values
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20191016192430.25098-1-ehabkost@redhat.com>
 <20191016192430.25098-8-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <38ece349-c793-086c-2b14-239072056ea9@redhat.com>
Date: Thu, 17 Oct 2019 11:55:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191016192430.25098-8-ehabkost@redhat.com>
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
> Field values are supposed to be bytes objects, not unicode
> strings.  Change two constants that were declared as strings.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>   tests/image-fuzzer/qcow2/layout.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/image-fuzzer/qcow2/layout.py b/tests/image-fuzzer/qc=
ow2/layout.py
> index 0adcbd448d..a0fd53c7ad 100644
> --- a/tests/image-fuzzer/qcow2/layout.py
> +++ b/tests/image-fuzzer/qcow2/layout.py
> @@ -122,7 +122,7 @@ class Image(object):
>       def create_header(self, cluster_bits, backing_file_name=3DNone):
>           """Generate a random valid header."""
>           meta_header =3D [
> -            ['>4s', 0, "QFI\xfb", 'magic'],
> +            ['>4s', 0, b"QFI\xfb", 'magic'],
>               ['>I', 4, random.randint(2, 3), 'version'],
>               ['>Q', 8, 0, 'backing_file_offset'],
>               ['>I', 16, 0, 'backing_file_size'],
> @@ -231,7 +231,7 @@ class Image(object):
>               feature_tables =3D []
>               feature_ids =3D []
>               inner_offset =3D self.ext_offset + ext_header_len
> -            feat_name =3D 'some cool feature'
> +            feat_name =3D b'some cool feature'
>               while len(feature_tables) < num_fnt_entries * 3:
>                   feat_type, feat_bit =3D gen_feat_ids()
>                   # Remove duplicates
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

