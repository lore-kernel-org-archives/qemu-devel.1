Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F70C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 17:44:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A40B4206B6
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 17:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vkpqp4eb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40B4206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIbTf-0003q7-FA
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 13:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kIbRv-0002sL-B9
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 13:42:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27468)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kIbRs-0003Jb-VT
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 13:42:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600278148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=et7mBzS5c+KeV5o+4eI8rmKu+WGbYybSSw6RqBheUeA=;
 b=Vkpqp4ebaKgXcN6rz7NMueV6rHaKCcTiaPhnXR5hsr/Yi88LVwJzRxStWBYuDXUkZz9410
 q6hawly0CRTA8mRPQIiXOUNehFZ0b628g87ncJdPT+/DiTUd04jTj2Mzj2z4sg/fmV0+30
 tpFSyt6w7x0blX8302zLYiKiw0k651k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-c-3EarUpNo6jq9E5nERmZw-1; Wed, 16 Sep 2020 13:42:22 -0400
X-MC-Unique: c-3EarUpNo6jq9E5nERmZw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C23F1891E8D;
 Wed, 16 Sep 2020 17:42:21 +0000 (UTC)
Received: from [10.3.113.91] (ovpn-113-91.phx2.redhat.com [10.3.113.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CEE535DF58;
 Wed, 16 Sep 2020 17:42:12 +0000 (UTC)
Subject: Re: [PATCH] migration: Silence compiler warning in
 global_state_store_running()
To: Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
References: <20200916171913.148681-1-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <9235ac78-34eb-d3b2-3ae3-276e85509b5f@redhat.com>
Date: Wed, 16 Sep 2020 12:42:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200916171913.148681-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.062, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/20 12:19 PM, Thomas Huth wrote:
> GCC 9.3.0 on Ubuntu complains:
> 
> In file included from /usr/include/string.h:495,
>                   from /home/travis/build/huth/qemu/include/qemu/osdep.h:87,
>                   from ../migration/global_state.c:13:
> In function ‘strncpy’,
>      inlined from ‘global_state_store_running’ at ../migration/global_state.c:47:5:
> /usr/include/x86_64-linux-gnu/bits/string_fortified.h:106:10: error: ‘__builtin_strncpy’ specified bound 100 equals destination size [-Werror=stringop-truncation]
>    106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
>        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> ... but we apparently really want to do the strncpy here. Silence the
> warning with QEMU_NONSTRING.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   migration/global_state.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/global_state.c b/migration/global_state.c
> index 25311479a4..f1355d7d97 100644
> --- a/migration/global_state.c
> +++ b/migration/global_state.c
> @@ -43,9 +43,9 @@ int global_state_store(void)
>   void global_state_store_running(void)
>   {
>       const char *state = RunState_str(RUN_STATE_RUNNING);
> +    QEMU_NONSTRING char *dest = (char *)global_state.runstate;

Do we still need the cast to char*?

>       assert(strlen(state) < sizeof(global_state.runstate));
> -    strncpy((char *)global_state.runstate,
> -           state, sizeof(global_state.runstate));
> +    strncpy(dest, state, sizeof(global_state.runstate));
>   }
>   

Otherwise,
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


