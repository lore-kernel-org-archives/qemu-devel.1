Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A017FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 22:14:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E54E20707
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 22:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XCYDtHEh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E54E20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixI4d-0004LU-IZ
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 17:14:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42339)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixI3t-0003h4-6c
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:13:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixI3s-0003tK-3P
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:13:21 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38045
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixI3r-0003rq-Vq
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:13:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580422399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DcaZJHEd3aXhrFd57TJJReH5qPBZeOxfkUdR6IzTX2M=;
 b=XCYDtHEhoTNSWeseIIwmH4VNqNyWyDlReD9ubeKY81PmPRfhT+obOvF0+7UUxGdZqoL3mJ
 w6df1BEWj2kzlMbEVnc1HfRXXkK203gdaQ89t0gUix3prMufBv/gkMe3gQjT5Vu2Bsq6xS
 yq89ZbVw7EjY1cJjAvXVL1jKcEak4nQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-wIyF-_CKNR-Nla66nblubQ-1; Thu, 30 Jan 2020 17:13:16 -0500
Received: by mail-wm1-f69.google.com with SMTP id g26so1950265wmk.6
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 14:13:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DcaZJHEd3aXhrFd57TJJReH5qPBZeOxfkUdR6IzTX2M=;
 b=ckf2KMZj5hNMiJU2R15kRrImWiMMY+DDUz1Bhj3A6fYmEGD+IW3Xo7kUuRmbq/NyIQ
 BnvN/cgFTzadqf2Kc717OhAxfraQ2vZQ48jNmB6sRqTonGrvNTNIGJzs8M7xvCSwJTAJ
 UtI6nV5XvN+AIAUL9PExelslTQOG0ypQ+9UI18eYwij3ruol27xsWsvhy0B0zgA9CjFe
 suShD71EV99XsxhPBr8vQO3TyWz1vT7q54mirkFQz8fc0BbH6mpz1KeHf/aT7fT8abm+
 vAf0VbeNPntX+5r2zdqMeUwhrBZwQBQSrVEfzRXqCgOAp1naKVl9hZ8h8O/QFaKTqW66
 ZaWw==
X-Gm-Message-State: APjAAAUM6PJ1gEfUfgUo9MkSQyhX0hg7qiuVCF1N5yaYQBKulQOkLQnv
 nbVEereFHwbkcbj2kUUcLjQhbxgzQ7w8ZN6OwURLcgUBsYM6dPRG2w7tpE0PItBOnrl2v7bkvxp
 obaEtN1rZlEEtnTw=
X-Received: by 2002:a7b:c30b:: with SMTP id k11mr7565524wmj.36.1580422395854; 
 Thu, 30 Jan 2020 14:13:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqwA2/b9ANm6Z3A+GueeXaWq31x3H5ViWxPZLXbFrPhCPPYVoyR0N3sfPH7AeCjdxW6XVHcSJw==
X-Received: by 2002:a7b:c30b:: with SMTP id k11mr7565510wmj.36.1580422395562; 
 Thu, 30 Jan 2020 14:13:15 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id z6sm8348657wrw.36.2020.01.30.14.13.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 14:13:14 -0800 (PST)
Subject: Re: [PATCH] qemu-deprecated: Remove text about Python 2
To: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org
References: <20200109095116.18201-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a4875385-702d-4a8d-d208-0ee5f8782b90@redhat.com>
Date: Thu, 30 Jan 2020 23:13:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200109095116.18201-1-thuth@redhat.com>
Content-Language: en-US
X-MC-Unique: wIyF-_CKNR-Nla66nblubQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/9/20 10:51 AM, Thomas Huth wrote:
> Python 2 support has been removed, so we should now also remove
> the announcement text for the deprecation.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   qemu-deprecated.texi | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 7033e531de..8b23e98474 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -341,14 +341,6 @@ they have no effect when used with @option{-n} to skip image creation.
>   Silently ignored options can be confusing, so this combination of
>   options will be made an error in future versions.
>   
> -@section Build system
> -
> -@subsection Python 2 support (since 4.1.0)
> -
> -In the future, QEMU will require Python 3 to be available at
> -build time.  Support for Python 2 in scripts shipped with QEMU
> -is deprecated.
> -
>   @section Backwards compatibility
>   
>   @subsection Runnability guarantee of CPU models (since 4.1.0)
> 

Thanks, applied to my python-next tree:
https://gitlab.com/philmd/qemu/commits/python-next


