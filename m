Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148DDC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 11:43:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E08A721848
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 11:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08A721848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKLEb-0003mp-Vx
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 07:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iKLAT-0007c0-US
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 07:39:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iKLAR-0002Mi-ED
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 07:39:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55920)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iKLAQ-0002M2-VD
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 07:39:07 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D6EBC11A24
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 11:39:05 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id r21so5385194wme.5
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 04:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mTqLaqeFEbjVVwQNNIvunKHQFI9h93v9WYr9xpp1+eA=;
 b=HjeiJ6rd91hWeemHsHn/422ut1fhVGq7/YN0SETN5epgmZJNKil+jnWCgCWD0wOhjw
 hS4GeTE822EKDBi9hijs9T7rKv1Sv50YJ88XJ9g3YLZC5mTc2l9y1CQONf9nfyv7XGkW
 /FvxGVGKjH8F/yEWYYm4hIOxHAdJ1BsHFMBu+bET9sVpbuPSkA61IhYreEWIWtfMz0dZ
 LiXHNhX6q6MOvW2gHOsJRS5rA3bH//J03s3pjdMfPa8ajdW+3T20MqUjgd3+NO4TmKeF
 CgzlOe7yn1Pj6WfZDBatHma0F6ZVy09qA2//SAZYiFN05GLknkXAFehqMb6vWpSyRoXs
 g/jg==
X-Gm-Message-State: APjAAAVTCId/jWLfYEwSbo5tfmrh1Q2O/4EL+rXFjMG/GrwDxj0SD/y0
 ywH4yZX65+4ydsgJL34DAWpzJpIk4SVRPHmBkhxllNgoO1TWXTeU19EZa6tYLaX+KK44cvytKNM
 V+rDo2og/OejtYWs=
X-Received: by 2002:a5d:4f8f:: with SMTP id d15mr15317153wru.126.1571139542799; 
 Tue, 15 Oct 2019 04:39:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzYWqmL0r6OgLYVsQso3F4IM09Z2UOX8JMojI1+URNvckK/7O3p0zyrsT1BeMMS44DEChBi+A==
X-Received: by 2002:a5d:4f8f:: with SMTP id d15mr15317138wru.126.1571139542611; 
 Tue, 15 Oct 2019 04:39:02 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id j26sm37556072wrd.2.2019.10.15.04.39.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Oct 2019 04:39:02 -0700 (PDT)
Subject: Re: [PATCH v9 15/15] MAINTAINERS: add microvm related files
To: Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
References: <20191015112346.45554-1-slp@redhat.com>
 <20191015112346.45554-16-slp@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <321db25a-24c7-54e2-7a90-c7c5ef3708d1@redhat.com>
Date: Tue, 15 Oct 2019 13:39:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191015112346.45554-16-slp@redhat.com>
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
Cc: ehabkost@redhat.com, mst@redhat.com, kraxel@redhat.com, pbonzini@redhat.com,
 imammedo@redhat.com, sgarzare@redhat.com, lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/15/19 1:23 PM, Sergio Lopez wrote:
> Add a new "Microvm" section under "X86 Machines" with the new files
> related to this machine type.
>=20
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   MAINTAINERS | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe4dc51b08..9744f07727 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1275,6 +1275,16 @@ F: include/hw/timer/hpet.h
>   F: include/hw/timer/i8254*
>   F: include/hw/timer/mc146818rtc*
>  =20
> +Microvm
> +M: Sergio Lopez <slp@redhat.com>
> +M: Paolo Bonzini <pbonzini@redhat.com>
> +S: Maintained
> +F: docs/microvm.rst
> +F: hw/i386/microvm.c
> +F: include/hw/i386/microvm.h
> +F: roms/qboot

This is a submodule, change there won't be committed within QEMU.

Without the 'F: roms/qboot' line:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +F: pc-bios/bios-microvm.bin
> +
>   Machine core
>   M: Eduardo Habkost <ehabkost@redhat.com>
>   M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>=20

