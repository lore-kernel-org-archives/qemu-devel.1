Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE60CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:47:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66ED820650
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:47:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66ED820650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNF6Y-000336-RS
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 07:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49870)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNEXH-00008f-7f
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:10:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNEXF-0005j3-3r
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:10:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53622)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNEXE-0005ij-Ue
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:10:37 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BE6B7C057F31
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 11:10:35 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id s17so5077943wrp.17
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 04:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VRFiJO6Qlu2vaCinOdmr2MBN1mbX17AzbJs78dTUux4=;
 b=U+aNsjE2nig6OnJVTcIIAa4nG5n4ocJHrq1jXrGqs7T7ZOqefZdXDXfuYEQ1xFvEUL
 uI8y4MRC97qwBkWUx5K7GA6vr6X/IoMOl1nAQcomgoHtVY1OkTZCJQM377O3RVjAA94k
 IRGENdDriL0lF8m+5K7MmJT5ZddyETI/4sn/EY6qGAqkVeLvIXobzJlCod3wfotUcRnt
 u7HzVtsf8tHAjSWZYnv0nk8OePlghVCUTPDp7ecbbappHOnQp6u9ZmiPuN/Ah13CpB3Z
 lgc5aTpTY/HC3/czXj4LDmVRpRCOyR10kyV2NTTVmTRKeTwEDz8UKqBe/IqIUdEQseji
 qINA==
X-Gm-Message-State: APjAAAUKpj7f1YxZ0RYGIMYT9OIkNJ8XXzes6IhsAXi+ZzFIB0cCzGgU
 TwO9AzKTOLLJjs+zS9XIZOP+NU/epu5EuRFLS82JaPH4tV5bOX3sylPfIEkKENodrCTlO149hg7
 ZblGybYrQLjzoJR8=
X-Received: by 2002:adf:dbd2:: with SMTP id e18mr7915412wrj.268.1571829034548; 
 Wed, 23 Oct 2019 04:10:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwz8T96XwdJfMaaoRIYeAkB00/JTFKTK6RwgASBuSQ/ONnqKz0nZID3fTJg7VhtmJ+/GfZDFw==
X-Received: by 2002:adf:dbd2:: with SMTP id e18mr7915404wrj.268.1571829034380; 
 Wed, 23 Oct 2019 04:10:34 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id p17sm18022566wrn.4.2019.10.23.04.10.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2019 04:10:33 -0700 (PDT)
Subject: Re: [PATCH] buildfix: update texinfo menu
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <20191023101956.19120-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d88a6ffb-9a58-51b7-c772-f3e646d3bb5f@redhat.com>
Date: Wed, 23 Oct 2019 13:10:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191023101956.19120-1-kraxel@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ed trivial@

On 10/23/19 12:19 PM, Gerd Hoffmann wrote:
> Build error message:
> qemu-doc.texi:34: node `Top' lacks menu item for `Recently removed feat=
ures' despite being its Up target
>=20
> Fixes: 3264ffced3d0 ("dirty-bitmaps: remove deprecated autoload paramet=
er")
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> ---
>   qemu-doc.texi | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 3c5022050f0f..3ddf5c0a6865 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -44,6 +44,7 @@
>   * Security::
>   * Implementation notes::
>   * Deprecated features::
> +* Recently removed features::
>   * Supported build platforms::
>   * License::
>   * Index::
>=20

