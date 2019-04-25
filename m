Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9A9C43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 20:56:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07D83206BF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 20:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPYRt0Ac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D83206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35005 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJlPg-0004rU-TH
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 16:56:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1hJlOs-0004P5-Ja
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 16:55:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1hJlOq-0007RC-Mz
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 16:55:22 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:46083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1hJlOq-0007R4-Iw
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 16:55:20 -0400
Received: by mail-qt1-x844.google.com with SMTP id w26so1695836qto.13
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 13:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=5jX0IEkiDuYP+VmY/W4Auq7LDKH+gPC0Q3+vNCMaItA=;
	b=lPYRt0Ac1gSJ66I/YmMpqqve0VtkuG0wHBgS7M6UUao/lLIhw6GUKH03r6GiIYBUbm
	LckHy82H0dZgBvs7iNGTetQPl3njjOaKj67zJqCFcdV60xjxshqjnp9ek96c5m0yYWO5
	NB47HFpNl7DhJEndlrrM5yKl0n/AzFY4s8U5kTgScovVftltM+wxg3hN7gaPACq8ovwX
	cTJ6/jLX41VoKIoPzw2GhRafENfVqtvt1w7xCqasONcpvs6YEmuxbDEiLj2qOCdg0YG6
	vNRf5eKmZso3Buy5ySbobpeyzNVb6YuUyjpyLylXk6BDdbZoCyMKyqJQX4J8iDJ9ebge
	bHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=5jX0IEkiDuYP+VmY/W4Auq7LDKH+gPC0Q3+vNCMaItA=;
	b=B3npmsq7/UDctBTvOrmInyoYAIjzu+/++l959hV6w7k2yh0UhfTWvqasQUrvxc3lp5
	rUqmTNS8V22QiJ7kKWqH3qg+H3Hvdrz8brynZctPGgFRnRoXndhbj9rg8MOKUXiIvG8f
	EGFkhSOpgLNRSXC1NcgT64QgdqMh0AsROJv18yCfqNPoALwu02848Kn1hVZoFmiihbgm
	dagUadj3UiMqw6WihXZmAi1pGJL24NsaCKsjBcuDYryvACXdtKnkIP+1i5SnOV+Ur/fh
	c3CIFCdnlnxEdEO+AjzPIclgNG+FwFoi6ntd4EslgGMqNTVHcWsj9zzJx/6HNj35sVbf
	+ohA==
X-Gm-Message-State: APjAAAWu5EEvzO3S6rHyfOQg8GLy/K/sm49VICTzpEmmdyvBvf9jbhHK
	2vaGYnjQsQtZwcdoZoPuduU=
X-Google-Smtp-Source: APXvYqyQ8jPM/hKAH9Np93uY2NTTwQzbjfP/fVWHCuyCbJDcI19H1z7NUPI+tK+rAlmJJnK6tVb1EA==
X-Received: by 2002:a0c:d157:: with SMTP id c23mr19698270qvh.200.1556225719815;
	Thu, 25 Apr 2019 13:55:19 -0700 (PDT)
Received: from ?IPv6:2804:431:f700:e6ba:b454:b6bb:95ea:4a7d?
	([2804:431:f700:e6ba:b454:b6bb:95ea:4a7d])
	by smtp.gmail.com with ESMTPSA id
	b37sm18224207qtb.92.2019.04.25.13.55.16
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 13:55:18 -0700 (PDT)
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org
References: <20190424004700.12766-1-richardw.yang@linux.intel.com>
	<20190424004700.12766-3-richardw.yang@linux.intel.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <0eb5e5a5-593e-f4a2-7e2d-a9fed481ab6c@gmail.com>
Date: Thu, 25 Apr 2019 17:55:15 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424004700.12766-3-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::844
Subject: Re: [Qemu-devel] [PATCH 2/4] migration/savevm: use
 migration_is_blocked to validate
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
Message-ID: <20190425205515.-MMqkehjL2Y9kb92fK3gMSotgaVwWlIh2Cd55TQoEsk@z>



On 4/23/19 9:46 PM, Wei Yang wrote:
> migration_is_blocked() is used in migrate_prepare() and
> save_snapshot(), this is more proper to use this instead of
> qemu_savevm_state_blocked() in qemu_loadvm_state().


migration_is_blocked() does an additional verification:

"if (migration_blockers)"

comparing to what was previously done in qemu_loadvm_state.

I've checked what migration_blockers does and it is a GList used
for callers to block the migration process. This is used via
'migration_add_blocker', from migration.c.

'migration_add_blocker' is called all over the place, most notably
in  _realize() functions  and _open() functions from block.

Thus, I am not sure if this change will impact the use of
qemu_loadvm_state() from load_snapshot() (i.e. can load_snapshot
be called with migration_blockers?). It's better to someone
with a better understanding of this code to comment on that.


DHB



> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>   migration/savevm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 2eea604624..6c61056cde 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2406,7 +2406,7 @@ int qemu_loadvm_state(QEMUFile *f)
>       unsigned int v;
>       int ret;
>   
> -    if (qemu_savevm_state_blocked(&local_err)) {
> +    if (migration_is_blocked(&local_err)) {
>           error_report_err(local_err);
>           return -EINVAL;
>       }


