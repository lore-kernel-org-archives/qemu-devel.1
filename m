Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4E8C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 11:06:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16A3020830
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 11:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A3020830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8jOy-00088P-9M
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 07:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i8jOI-0007iX-Jr
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 07:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i8jOH-0007sE-8V
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 07:05:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47154)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i8jOH-0007ri-3S
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 07:05:25 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 03AB4356F9
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 11:05:24 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id v18so280324wro.16
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 04:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pTJupkw/xHBw7sJqgCBqgHMXtALvOeZ3ZLZ968/cVRw=;
 b=i1fzByEk/iM6bIuPxMBwncaKQb+UDggrR7kwXVqL7f9AdiZ7cqm51vVK4ZNpUqM9F+
 7uzYwLoRXa1mI3WEmZMq4Y8Sj4Ygj72/wy9uQGkzEs8vMPuy8tlDbkUZCHcK5MXnM4AF
 GcKouuxuqYVHnyxrw6UBWf2IjAEmFC85jkJOvP9h7b9rbWEqR7/egCNweksAZmNxF7AP
 nEmwbRj6CyG4kE/ofY5H8iAh+4zeYUV09VDvGA8BZo222BmD2f4Y//bTd3xd3w4GWV2o
 sJg/rwRUJL/DaxnGL3gHs32vRXL1u2001y0iqWSs+bbelJUphtiRAegePy5qXPNx4L+S
 2gTw==
X-Gm-Message-State: APjAAAWbHR6Hq3Re97YXAqOf2o0NdbaNoQlajflSGLaGutdL0mLwbhmr
 xdZPOg/MUpvMU0g+fzldLEzLdAW3mD4egEY1hxQ+ckUOZN5wAPozwSkBatclm0aifMYYnlgelLf
 WMFfJ4Xsbn0qqtt4=
X-Received: by 2002:a05:600c:224d:: with SMTP id
 a13mr2875339wmm.45.1568372722827; 
 Fri, 13 Sep 2019 04:05:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxPqnOWy8rCTyyl1RtpoEdNUReeHD76Odh5PjinfYY2BB6juwtxv2ekhwf3JTX6ItcBggYGJA==
X-Received: by 2002:a05:600c:224d:: with SMTP id
 a13mr2875320wmm.45.1568372722661; 
 Fri, 13 Sep 2019 04:05:22 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id v64sm2406488wmf.12.2019.09.13.04.05.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Sep 2019 04:05:22 -0700 (PDT)
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20190912184607.3507-1-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <3669d4b7-a0af-60a4-e519-e4bcfb033460@redhat.com>
Date: Fri, 13 Sep 2019 13:05:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190912184607.3507-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] build: Don't ignore qapi-visit-core.c
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
Cc: Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/12/19 8:46 PM, Eric Blake wrote:
> This file is version-controlled, and not generated from a .json file.
>=20
> Fixes: bf582c3461b
> Reported-by: Thomas Huth <thuth@redhat.com>

Good catch!

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/.gitignore b/.gitignore
> index e9bbc006d39e..7de868d1eab4 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -41,6 +41,7 @@
>  /qapi/qapi-types-*.[ch]
>  /qapi/qapi-types.[ch]
>  /qapi/qapi-visit-*.[ch]
> +!/qapi/qapi-visit-core.c
>  /qapi/qapi-visit.[ch]
>  /qapi/qapi-doc.texi
>  /qemu-doc.html
>=20

