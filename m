Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9577C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:15:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B49BB2071A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1TXVEmt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B49BB2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlZn5-0007cu-SR
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 11:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1jlZbz-0005mJ-Is; Wed, 17 Jun 2020 11:04:23 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52981)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1jlZbx-0005GF-LS; Wed, 17 Jun 2020 11:04:23 -0400
Received: by mail-wm1-x344.google.com with SMTP id r9so2187853wmh.2;
 Wed, 17 Jun 2020 08:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dnXhK56wzWxR6LV/1smHXrH9BiqjRK+oVXW76SWNEU8=;
 b=Q1TXVEmtEQySJNsd56QQwC7ApqjjKOiD2zIHIKxE9VEtShp4GftaMwAtrwVTm8j2MV
 9++mAka7SG5C0+MnKiacmQNgVtuSzAml1yN0oSD+VF9vTjelPinhSw8J1A43IZPSv0rN
 ogCrDnDZ67ljh5DFLHPCRN2cGgUHY82z1GXvQkTNxE6S+/CbEC6nTNmb6NLNdraAYscg
 PuvgA9eEBGocJL5CpCC3NuOgbtz9iFLs74iumvGAP9+nOH9ScbTj3bjDwobr6YFudgyJ
 i7wA1E3ETDFbktAOEurxNaQ/Rro3lxHrP3WRU6po+xNkxwrdhzz8/C4/mQ27jHgUUEfo
 MwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dnXhK56wzWxR6LV/1smHXrH9BiqjRK+oVXW76SWNEU8=;
 b=YpxgseQvs2dSiyAXS9yrGsMQTRLJ00UcHeltFYT10Kr9kHQRTcXlt0k978EaEO8orQ
 q2VGUXaYDROmfrBIv25t2GeDb1z+6Rd55lLl3t97wxiFT4u5Cqrz3IOgQMTdIceDA2QQ
 1dhym74aSE214C1JSqj4+WdZn8CxhlX8GWkBl6/DGn66XqbD609YdYe+MN+P6GVxqZAU
 MTIk1VXlJLsjixuyRRM2LkBjvTONoFoJ9BRVhVraEwypFckipUsmx1vVMqqiAFrX1NaJ
 VLa5ISs2hlHAy7zkFbpAYdGA/aa/MMk9d1asWqgJCnXuSmxRayoeWPoP0JG6uA4SXbNa
 T1dw==
X-Gm-Message-State: AOAM531oPCbERZszxq4WdTZsKCDLFTlfq5YK6OIi6NBdcULyw1tRWrU9
 Rnwly14Axe5jx170fRWHp3E=
X-Google-Smtp-Source: ABdhPJyDwRu68E0wrJddqdrXroFxwqwbzXhh1tDoL0sGRbQTDrkyD7VMwjZSzuLKaKuMhR7Lc26FuA==
X-Received: by 2002:a1c:9ad8:: with SMTP id c207mr8494451wme.45.1592406258467; 
 Wed, 17 Jun 2020 08:04:18 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:48a4:82f8:2ffd:ec67?
 ([2001:b07:6468:f312:48a4:82f8:2ffd:ec67])
 by smtp.googlemail.com with ESMTPSA id s8sm33935027wrm.96.2020.06.17.08.04.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2020 08:04:17 -0700 (PDT)
Subject: Re: applying mailing list review tags (was: Re: [PATCH v3 00/16]
 python: add mypy support to python/qemu)
To: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200604202236.25039-1-jsnow@redhat.com>
 <20200605092630.GE5869@linux.fritz.box>
 <502e4f4d-6770-61a7-1496-9cb244f9ddd3@redhat.com>
 <20200608153327.GD6419@linux.fritz.box>
 <130e4383-8c33-c3f2-55b2-1ec45a5214cc@redhat.com>
 <87wo4gr4yb.fsf@dusky.pond.sub.org>
 <4ee8f32a-192d-b154-f3cc-c41e7ff56c58@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ce1b566c-dd78-194d-e287-2e7117aa7ad4@redhat.com>
Date: Wed, 17 Jun 2020 17:04:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <4ee8f32a-192d-b154-f3cc-c41e7ff56c58@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/06/20 19:58, John Snow wrote:
> 1. Correlating a mailing list patch from e.g. patchew to a commit in my
> history, even if it's changed a little bit?

Use "git am --message-id"?

> (git-backport-diff uses patch names, that might be sufficient... Could
> use that as a starting point, at least.)
> 
> 2. Obtaining the commit message of that patch?
> `git show -s --format=%B $SHA` ought to do it...
> 
> 3. Editing that commit message? This I'm not sure about. I'd need to
> understand the tags on the upstream and downstream versions, merge them,
> and then re-write the message. Some magic with `git rebase -i` ?

"patchew apply" actually uses "git filter-branch --msg-filter" to add the
tags  after a successful "git am", so you can do something similar yourself.
(Actually I have pending patches to patchew that switch it to server-side
application of tags using the "mbox" URL that Philippe mentioned earlier, but
they've been pending for quite some time now).

To get the upstream tags you can use the Patchew REST API:

   $ MSGID=20200521153616.307100-1-stefanha@redhat.com
   $ curl -L https://patchew.org/api/v1/projects/by-name/QEMU/messages/$MSGID/ | jq -r '.tags[]'
   Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
   Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

So you'd have to take a commit, look for a Message-Id header, fetch the
tags from above mentioned Patchew API URL and add the tags to the commit
message.

The commit message can be either emitted to stdout (and the script
used with "git filter-branch)" or, for the faint of heart, the script
could do a "git commit --amend" and you can use "git rebase -i --exec"
to execute the script on all commits in a range.

This script is for the latter option:

   #! /bin/bash
   BODY=$(git show -s --format=%B)
   MSGID=$(git interpret-trailers --parse <<< $BODY | sed -n 's/^Message-Id: <\(.*\)>/\1/ip')
   USER="$(git config user.name) <$(git config user.email)>"
   BODY=$(curl -L https://patchew.org/api/v1/projects/by-name/QEMU/messages/$MSGID/ | \
     jq -r '.tags[]' | ( \
       args=()
       while read x; do
         args+=(--trailer "$x")
       done
       git interpret-trailers \
         --if-exists doNothing "${args[@]}" \
         --if-exists replace --if-missing doNothing --trailer "Signed-off-by: $USER" <<< $BODY
   ))
   git commit --amend -m"$BODY"

The script will also move your Signed-off-by line at the end of the commit
message, this might be a problem if there is more than one such line and
you want to keep them all.

Paolo

