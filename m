Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BB9C742D6
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:00:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA11B20651
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA11B20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlyuS-0006rB-Cj
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 13:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57809)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hlyuF-0006Ma-H0
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:00:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hlyuE-0007TF-HQ
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:00:23 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50228)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hlyuE-0007SJ-CC
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:00:22 -0400
Received: by mail-wm1-f66.google.com with SMTP id v15so9578974wml.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 10:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MUBsIKX1x/E5OBfsa3QHVjy4My2fSIWjSQcItrVCVs8=;
 b=jxgUykrxMVC+WaQ5BiHXKucjMvDYg4fu7OzPxmSt4vSFNuXgPK+PKMofCB4oYCOFnj
 QparhI7dnWQs5v1tTmQPnke68sKOgrta7H1rhh9WyEvUIuCaZrJuNLCUtRhYFmhbWOMy
 4/Vn5cwO2Lk17wkeMFP0bRjz0lLSi3qbH9xNYPRy9b8iKy2W+v6q9jbRxek3468ryYlU
 mRcbuekq3ov1DODkGWYqa2L59lgtmtSSqMwPl6ld2supksLtcfRbkajjjg0ZLqA9XJ3d
 V7lTTuSyMJ+FG8TKw1z1UTKvulPhsRKV2hkIXWTXznDsMLrx8fSqRsRwiBuPpeHswmeh
 B2dQ==
X-Gm-Message-State: APjAAAWIrv+90GVLC8LsyUzg0NZLvx1fT8UUD8C9V2qzSVamnUHd6RxM
 rt3kEEe289vuqp2hvD+qD7UudA==
X-Google-Smtp-Source: APXvYqwqr2RY4ZxW6ns4W4KPel6al8YxZGI9kOkv4jDCFpdWjctC9yiL5qTE9pkz24sz3yu1pDqfDw==
X-Received: by 2002:a1c:ca06:: with SMTP id a6mr10621651wmg.48.1562950820989; 
 Fri, 12 Jul 2019 10:00:20 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id t140sm9907753wmt.0.2019.07.12.10.00.20
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Jul 2019 10:00:20 -0700 (PDT)
To: Michal Privoznik <mprivozn@redhat.com>, qemu-trivial@nongnu.org
References: <db150a03315a89a849ab9968e4a5a26110d41424.1562942402.git.mprivozn@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <65135f2f-8e84-321f-14d5-3ae8af753e2d@redhat.com>
Date: Fri, 12 Jul 2019 19:00:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <db150a03315a89a849ab9968e4a5a26110d41424.1562942402.git.mprivozn@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH] .gitignore: ignore some vhost-user*
 related files
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
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/12/19 4:41 PM, Michal Privoznik wrote:
> Commit d52c454aadc creates
> '/contrib/vhost-user-gpu/50-qemu-gpu.json' and '/vhost-user-gpu'
> and commit 06914c97d3a creates '/vhost-user-input' neither of
> which is ignored by git.
> 
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
>  .gitignore | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/.gitignore b/.gitignore
> index fd6e6c38c7..e9bbc006d3 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -65,6 +65,8 @@
>  /scsi/qemu-pr-helper
>  /vhost-user-scsi
>  /vhost-user-blk
> +/vhost-user-gpu
> +/vhost-user-input
>  /fsdev/virtfs-proxy-helper
>  *.tmp
>  *.[1-9]
> @@ -131,6 +133,7 @@
>  /docs/interop/qemu-qmp-ref.info*
>  /docs/interop/qemu-qmp-ref.txt
>  /docs/version.texi
> +/contrib/vhost-user-gpu/50-qemu-gpu.json
>  *.tps
>  .stgit-*
>  .git-submodule-status
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

