Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47CBC43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 19:28:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0086020685
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 19:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfP2LNwj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0086020685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34136 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJk2v-00066p-9C
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 15:28:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1hJk1s-0005YY-IN
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 15:27:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1hJjvh-0001jD-24
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 15:21:11 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:44096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1hJjvf-0001K7-2Q
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 15:21:07 -0400
Received: by mail-qk1-x743.google.com with SMTP id y5so432262qkc.11
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 12:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=trdNWblg77J5PrVc9fHnmhA1Nmi2cR9fU07cp/3jEW4=;
	b=bfP2LNwjflVwTy1tSSqTG7c3o6bmu/iOESE1Ej78TZtPRqkZYzo1wHPLiRu47j0k0i
	+ZOIm6SiTLd2eUQ/uiyXgYx/4YGUezbzYb1ZsCuzUEImrbGjL+umH7wmeEHKO77BEQjR
	62j3u4sdJwNBUcVJVng7HZ0K6+1MnBRncp/yFADLqg3a3/oK2yR8RMdnPsFhYtqpTNEd
	kiKydd5z3HIONmCP7cIjJFQjP5FrFGCuVaSCVjLSSPZGsRyHPSxeXbpOBfi0VcK8JU33
	pR9GGX/2c6SojYZQDZFBP2Y4DrmcK9ndXAGfsEbkmOp4PPivUD+3u7vHwt6pNtxx9M1J
	OV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=trdNWblg77J5PrVc9fHnmhA1Nmi2cR9fU07cp/3jEW4=;
	b=C7yVXdXj8m9dG++krT3ibj4bEY031/WWrWYGuGXWY/zlL94yn4bD2JY+RYzjcv9Bw2
	fQsIPE3G+1mTnWbJJ+ivjV4oTc0udUuwGFrrFneJI5613PW7lzGwtiWCcrDXzeHcV2zg
	8aDCtFGfjsFSVZ7+BTJAjTACUP9Kyq0wAIil3wdKgxfknDhzoeQP0QzW9HZ7Q/1VDz2Q
	OLiduCZO61mVJNUyA5OiSGF0RErQIyVS/koF7eqWg4q1QOgQO3Z+GC4BYhwYYv7o0wR/
	Ed5SHdpY78/EQ0A+9x5n6H39f4nj08curcSwQoWglK7vs3bVHEXTLOu63BCrGK+AsjOk
	s5lQ==
X-Gm-Message-State: APjAAAWoeFnNLZD2JnV35F6kArte+WIU1rutmsamRl/ijhSL1CNe9Mkg
	VKFyGKqzGZAqhF72NwJr6qo=
X-Google-Smtp-Source: APXvYqwNIUwnfUr85DXLLXqWWlojx2m7uBoU1RzCPGdV0KgTKnuBf6Ia2yG3K+A1lyjokc9kdXXymw==
X-Received: by 2002:a05:620a:124e:: with SMTP id
	a14mr2577114qkl.43.1556220063333; 
	Thu, 25 Apr 2019 12:21:03 -0700 (PDT)
Received: from ?IPv6:2804:18:6a:bad:164e:37be:136d:b67b?
	([2804:18:6a:bad:164e:37be:136d:b67b])
	by smtp.gmail.com with ESMTPSA id
	13sm10683828qtm.52.2019.04.25.12.21.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 12:21:02 -0700 (PDT)
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org
References: <20190424004700.12766-1-richardw.yang@linux.intel.com>
	<20190424004700.12766-2-richardw.yang@linux.intel.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <e9cd3438-345f-2a68-daec-1ce4cba37ef1@gmail.com>
Date: Thu, 25 Apr 2019 16:20:57 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424004700.12766-2-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::743
Subject: Re: [Qemu-devel] [PATCH 1/4] migration/savevm: remove duplicate
 check of migration_is_blocked
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
Cc: dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425192057.wrAcFVHJkmdWwLfqR5Vp-gXZkA-OvVhwq_QIsl2aUqI@z>



On 4/23/19 9:46 PM, Wei Yang wrote:
> Current call flow of save_snapshot is:
>
>    save_snapshot
>      migration_is_blocked
>        qemu_savevm_state
>          migration_is_blocked
>
> Since qemu_savevm_state is only called in save_snapshot, this means
> migration_is_blocked has been already checked.

I think it would be a nice touch to add a comment in qemu_savevm_state,
saying that the function must be called with migration_is_blocked()
context. Just in case someone else in the future ends up re-using the
function.


Other than that, +1 for less code duplication.


Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>




>
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>   migration/savevm.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 92af2471cd..2eea604624 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1412,10 +1412,6 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
>           return -EINVAL;
>       }
>   
> -    if (migration_is_blocked(errp)) {
> -        return -EINVAL;
> -    }
> -
>       if (migrate_use_block()) {
>           error_setg(errp, "Block migration and snapshots are incompatible");
>           return -EINVAL;


