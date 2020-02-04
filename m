Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DEEC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 12:03:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF90020730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 12:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUovUglI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF90020730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iywvt-00055y-Ur
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 07:03:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iywvF-0004dM-42
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 07:03:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iywvE-0008Mw-38
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 07:03:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48162
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iywvD-0008G9-U9
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 07:03:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580817795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XZFZ4fTQcFtvr7Bc+ZDGWaIEye6CdF4w7n/VTBv7CD8=;
 b=OUovUglIqx5LSqOOnpyYemlpmuXfqOYIOwkWT3vHa4bNkzArGlSE/WH+Lag70IdwB3uG0L
 yhtfZdxSyigMjzyK+9/CcQodmNpDFXLV3kZsHreVDeekFSdd/7hjtTol91Ew6ndRfaa9Xt
 pNVhmQsDKPA1ZZL5uOwReW2WGynIeN4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-jZSM-B5gNUq3hE26RQA7HQ-1; Tue, 04 Feb 2020 07:03:11 -0500
Received: by mail-wr1-f69.google.com with SMTP id u18so9995125wrn.11
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 04:03:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=N+dqB+qQcdniXz0131P1dsrqTKJgqWpA22fUA2UZvbI=;
 b=TvMpwQwZ7zazh2hOfrePsiBo2UJ5h4taZRBC08DrmGi98SDEmLsZ+2a8wotjXDSTrO
 YTsHB3TFpR0obawEp6uLwXcypJ+a2uoum5Gw+26Jmz7kKdUGJvPT1MUuvrh9gutsgeK9
 FZijnfGNlAu1OBc2k4lNCoG0Y/iiWd6xSyiblZ5UZfNBzZiE1CZI7T1zvjLajjCr727j
 X3JcVzLYkeXKH8sNChpCq5jmM4K1xdAfk4ZtbKLSqlNfM5t8UGU3Muq4qVAbBIwlqctp
 3SObvYthStz1MvnXzZ8yjDyXwRMunjAk2Ptmr+18HbsrH8qHUmPO84qtMMuCxPAxL1+0
 4YOQ==
X-Gm-Message-State: APjAAAXAJObclYQ/3uYveHDCkMMREvyALCjmSAFUZbwZnwWMQPjpBhTQ
 LFiUVM+tK6TriOtGLTGLH1syo/VKTAGRciHQz725nfPWjRDUANRm1E6lhXGDGsDmJes8oc4t5pT
 gM8KN6hMqIiNKCwM=
X-Received: by 2002:adf:f847:: with SMTP id d7mr21444204wrq.35.1580817790343; 
 Tue, 04 Feb 2020 04:03:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqyhaimvJc+aN07c2BOT2B6I8jO97dqPaZ+ZKaQEDljS/u4R6DtULrfJie/MKUNQID0iP6bqxA==
X-Received: by 2002:adf:f847:: with SMTP id d7mr21444194wrq.35.1580817790176; 
 Tue, 04 Feb 2020 04:03:10 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id f207sm3729719wme.9.2020.02.04.04.03.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2020 04:03:09 -0800 (PST)
Subject: Re: [PATCH 4/4] virtiofsd: do_read missing NULL check
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com
References: <20200204110501.10731-1-dgilbert@redhat.com>
 <20200204110501.10731-5-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a279d91d-a7c1-aa3a-b128-99ea7bf96ebe@redhat.com>
Date: Tue, 4 Feb 2020 13:03:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204110501.10731-5-dgilbert@redhat.com>
Content-Language: en-US
X-MC-Unique: jZSM-B5gNUq3hE26RQA7HQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 12:05 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Missing a NULL check if the argument fetch fails.

Surprisingly all other calls to fuse_mbuf_iter_advance() do the check.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
> Fixes: Coverity CID 1413119
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>   tools/virtiofsd/fuse_lowlevel.c | 4 ++++
>   1 file changed, 4 insertions(+)
>=20
> diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowle=
vel.c
> index 01c418aade..704c0369b2 100644
> --- a/tools/virtiofsd/fuse_lowlevel.c
> +++ b/tools/virtiofsd/fuse_lowlevel.c
> @@ -1116,6 +1116,10 @@ static void do_read(fuse_req_t req, fuse_ino_t nod=
eid,
>           struct fuse_file_info fi;
>  =20
>           arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
> +        if (!arg) {
> +            fuse_reply_err(req, EINVAL);
> +            return;
> +        }
>  =20
>           memset(&fi, 0, sizeof(fi));
>           fi.fh =3D arg->fh;
>=20


