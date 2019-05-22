Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C94C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 15:19:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A9E120879
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 15:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A9E120879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45905 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTT1t-0001RE-6a
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 11:19:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTT07-0000e4-Jb
	for qemu-devel@nongnu.org; Wed, 22 May 2019 11:17:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTT05-000110-KJ
	for qemu-devel@nongnu.org; Wed, 22 May 2019 11:17:55 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:47747)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hTT01-0000kG-Ug; Wed, 22 May 2019 11:17:51 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1MA7Om-1hNOAo1ayQ-00BeNA; Wed, 22 May 2019 17:17:16 +0200
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
References: <155800428514.543845.17558475870097990036.stgit@bahia.lan>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <c3cb3044-00e4-4ea5-2610-a397765a26d0@vivier.eu>
Date: Wed, 22 May 2019 17:17:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <155800428514.543845.17558475870097990036.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Qbo+YixGX8ZCYpVKSZiGn7RJH0T1wgyt4S36b/ZQ3MqwKNkHfY+
	A7KHleb2ou+8Lcy3fHhd34uTVOkH2dEtGO/1337g/uChZ3pX0Nk8YfEkyXbpuIpKiK4YC3I
	8yQ8ghWy5KK+0MjYm1W0hvoAW3+wVXgU9KTMm/+9ae3q4qPDyOYs7qCrBYXegPxH/Quzb3g
	j5JHbZp0+hNZJiW4VY5WQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YOwH4LeHdlg=:ZenqAPVI2TGTPCAsieeeQg
	7ZeZHbsfr8M5NztKmfV8GlYjVLftpqBFlbu3Yn59+omxTImd7NwrDMacYhFBStQMgxS4Mw4ZX
	WsI4IKLDug5hbgSx1gV3jveuvVmZEyDnK0Xs/uhENWH4tBS2yaR9DbEhR7tcYEmDi+TAdCeNJ
	qWc5cZ8wD4LhXMlEsYrrE7F8ET963RGCRcnEyyRYU6AZQfbHL/qFp/JUSUB4cy8X76n2eanNl
	93jvR8q8uhxWHXq5kl9FvaX01ybd1uP8mKaLTean4tI/tsTlnVn//0e1o7TM4KGLycSt5KNgx
	EKvmVXFYsZw/YN+TqJZ+BYIyKSsmGWTgdw9JqkhDymNAPpZmjnJzSzQAJAop+j4VGMqvD5dQs
	CUHvSZt/yb80mY7RKDC3eqY3aePjb/31QZBGpd4GkqDffnC3f7LgwphxwHC0W23MWhqm8Qxhd
	DnVBmfwQaymhXGGJnONAIVHKUtmyDTadMwufBkD/3DNOL7X89YhmKQbT53X8R1pskJnVbc2uJ
	LvaFOi15fHcJH+oFmCTVHecqJXkCU1SBfCT8nmsgXMtXB0wVjEthpMH7eLzXg2eu7WOf44NHR
	3hUkKNUqBdo8RGaaCzKe3/weu1NC3sb4LkYX8m+jVwnJHGzWfJECLiJsX1AXjyLEMhcYfUMmt
	leZspiZjZzK6KQRc++jobwOY+hsdHyj2cQMWZ/u9IjJiPCsU/RMBnSs4xf3BeWCFBKtaI7egT
	2NDlMuCDljI2eXHiOSi8dudHpdxayiqxYuve1okw9+Jk6T8pWwiSOVHkhhs=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] migration: Fix typo in
 migrate_add_blocker() error message
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/05/2019 12:58, Greg Kurz wrote:
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   migration/migration.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 609e0df5d0c0..c15e75e0eebe 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1714,7 +1714,7 @@ int migrate_add_blocker(Error *reason, Error **errp)
>       if (only_migratable) {
>           error_propagate_prepend(errp, error_copy(reason),
>                                   "disallowing migration blocker "
> -                                "(--only_migratable) for: ");
> +                                "(--only-migratable) for: ");
>           return -EACCES;
>       }
>   
> 
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

