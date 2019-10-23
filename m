Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AA6CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 10:56:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89AA0214B2
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 10:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89AA0214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNEJa-0006tS-58
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 06:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNEFG-0003LC-Hn
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:52:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNEFE-0008EH-OT
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:52:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50266)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNEFE-0008Dj-Go
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:52:00 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 09D4F5AFDE
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 10:51:59 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id i10so2588425wrp.7
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 03:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WMc7qHfCxariqvJyjPA71V487velwX0/vWxbT+R95lA=;
 b=PkhfXVUO8FGNtQK/vaWSx+Q9Hg8NICstP50UI5AV+sf9JYoRKUz/RjXWfNdaZopmis
 ztZV3HmlI1Ah31rM1lEEC1CeS/nwCtFY0KVctRvEiTrl4dXlBGt1VW/Rq2/VXb6iGatD
 bbB1waNdJiZ4OcasBjj7Wqn0TCLuYehK5+1R7mDrYpGP6ZppWbBVUWKLPpbgcAExC+w8
 UfzEbwcCggGia6QC+aNJEDfu+eYysayYLsx7B86qThhk9o/uDecpQG/FlwqrRPVFj3bQ
 7woiVkUwXMajlAGiMmfmG0LqwUoSr3+dJB+ulXYV7msmJLRXYFojc+qOBpw9fM/aSNu8
 VObg==
X-Gm-Message-State: APjAAAWEC9Mg4CAnaQVNkuil0ZrFM6IFu+KLRrT0iTe4H0J8XcEa+bia
 VsNImbGSHRzTOY/+fBDIttgPDpHj4e0ZQZz/5tgrdI780BdXvqnwNAEdduXu+o4TOLFCSrvOPfu
 T7WV8bz2xRPAk3l4=
X-Received: by 2002:a1c:44b:: with SMTP id 72mr7002776wme.72.1571827917312;
 Wed, 23 Oct 2019 03:51:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzfd+HEGZ6gV4BA2yuY6kJFvPkl1mVg41nV/NVNVRijQ9dT7FkK9plnAUy5bmfgL1lqXU/mZw==
X-Received: by 2002:a1c:44b:: with SMTP id 72mr7002755wme.72.1571827917044;
 Wed, 23 Oct 2019 03:51:57 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id o4sm33462452wre.91.2019.10.23.03.51.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2019 03:51:56 -0700 (PDT)
Subject: Re: [PATCH] audio: fix missing break
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20191023082431.30780-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <540cedf0-a8ec-36ea-14cd-080125f63386@redhat.com>
Date: Wed, 23 Oct 2019 12:51:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191023082431.30780-1-pbonzini@redhat.com>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/19 10:24 AM, Paolo Bonzini wrote:
> Reported by Coverity (CID 1406449).

Gerd sent the same patch earlier:
https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg05923.html

But your description is better.
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   audio/paaudio.c | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/audio/paaudio.c b/audio/paaudio.c
> index df541a72d3..55a91f8980 100644
> --- a/audio/paaudio.c
> +++ b/audio/paaudio.c
> @@ -385,6 +385,7 @@ static pa_stream *qpa_simple_new (
>           map.map[5] =3D PA_CHANNEL_POSITION_REAR_RIGHT;
>           map.map[6] =3D PA_CHANNEL_POSITION_SIDE_LEFT;
>           map.map[7] =3D PA_CHANNEL_POSITION_SIDE_RIGHT;
> +        break;
>  =20
>       default:
>           dolog("Internal error: unsupported channel count %d\n", ss->c=
hannels);
>=20

