Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6384EC4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:49:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDC952070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TOFl6HQl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC952070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUCNQ-0003nq-RQ
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jUCLQ-0001jo-SA
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:48:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jUCGz-0001ks-5W
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:47:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36778
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jUCGy-0001kY-LS
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:42:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588264971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R8pARsuQWI0hkAQIIMWALw3vCO1ynJO0lnPUoDsWy8A=;
 b=TOFl6HQlwJMT6JJkhBJLQqGyOH9cvejfz6nNInIERWqSgx7LxBC30ut7vFJmtafBme/bQ6
 xuAWgKkJy4aka0daKj+bdJOYWRL0cyS4+TQjFSu7ArCMOx7w2bab8hbU3irU3BSjPPbNQf
 WapAm6gvGcRmLnOLkfzmHxjTpx2abOY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-u4lfwVyANTOEpRqjR5Hm0g-1; Thu, 30 Apr 2020 12:42:49 -0400
X-MC-Unique: u4lfwVyANTOEpRqjR5Hm0g-1
Received: by mail-wr1-f70.google.com with SMTP id j16so4146816wrw.20
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 09:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R8pARsuQWI0hkAQIIMWALw3vCO1ynJO0lnPUoDsWy8A=;
 b=Hs0lAFLTP0gIvgq7OTitCJYUvVWXd0M9NpqwNj+fxbdxALjXp+/qYbO2gx9WyXYv+k
 dl4IJPGIU9VSiCl7QpQreEdD89x1ZsGRdI3DIPoMXAmDXEmAqG18Xw7S+ccSUEj+UP1o
 ThAIGSvrEOjntR36izi0zrwhyBADD7CzOvyth8L3+8xlBUG0rHT+TmIu0RFhqKs7nrqC
 r4IDFKizJMSVfh4mgk0HxK3QxEcUg62pBjDfrTpMCChua72QBwVTAdmtO3ALWwtnRGha
 IRGaxYVqE2w4QQqVz5BfGOoNoQJzvHLefNgzEVbGdAUDwSUL5BGHLdFJfPK0yF6ofeEo
 3DXQ==
X-Gm-Message-State: AGi0PuZbaOuyLjZlNYcc4iDxtjDfsSSWDqXmu46mROIwydbPYw667WvM
 w0SAio2pMT+IwDb6by6k+r77MH4JyhjS1sdU1Z+n/lf903DmzpdKmI4ahfjHDO1aYA0Utq6kRwO
 xOY3+03/rlwQdhdk=
X-Received: by 2002:a5d:4092:: with SMTP id o18mr4858814wrp.227.1588264968106; 
 Thu, 30 Apr 2020 09:42:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypKI8/RxFe2M+VcJOQQrJl6e1Q8qNm9Qf+C6aFDTRlJ0ePgWUgD3BgupX/8cUsKh23FOFfKBpA==
X-Received: by 2002:a5d:4092:: with SMTP id o18mr4858776wrp.227.1588264967742; 
 Thu, 30 Apr 2020 09:42:47 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id l4sm359838wrv.60.2020.04.30.09.42.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 09:42:47 -0700 (PDT)
Subject: Re: [PATCH] hostmem: don't use mbind() if host-nodes is epmty
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200430154606.6421-1-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <949872a1-1d5c-0e44-cab8-02d2e30202a7@redhat.com>
Date: Thu, 30 Apr 2020 18:42:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200430154606.6421-1-imammedo@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:04:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: pbonzini@redhat.com, mhohmann@physnet.uni-hamburg.de, berrange@redhat.com,
 ehabkost@redhat.com, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Typo "empty" in patch subject.

On 4/30/20 5:46 PM, Igor Mammedov wrote:
> Since 5.0 QEMU uses hostmem backend for allocating main guest RAM.
> The backend however calls mbind() which is typically NOP
> in case of default policy/absent host-nodes bitmap.
> However when runing in container with black-listed mbind()
> syscall, QEMU fails to start with error
>   "cannot bind memory to host NUMA nodes: Operation not permitted"
> even when user hasn't provided host-nodes to pin to explictly
> (which is the case with -m option)
> 
> To fix issue, call mbind() only in case when user has provided
> host-nodes explicitly (i.e. host_nodes bitmap is not empty).
> That should allow to run QEMU in containers with black-listed
> mbind() without memory pinning. If QEMU provided memory-pinning
> is required user still has to white-list mbind() in container
> configuration.
> 
> Reported-by: Manuel Hohmann <mhohmann@physnet.uni-hamburg.de>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: berrange@redhat.com
> CC: ehabkost@redhat.com
> CC: pbonzini@redhat.com
> CC: mhohmann@physnet.uni-hamburg.de
> CC: qemu-stable@nongnu.org
> ---
>   backends/hostmem.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/backends/hostmem.c b/backends/hostmem.c
> index 327f9eebc3..0efd7b7bd6 100644
> --- a/backends/hostmem.c
> +++ b/backends/hostmem.c
> @@ -383,8 +383,10 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
>           assert(sizeof(backend->host_nodes) >=
>                  BITS_TO_LONGS(MAX_NODES + 1) * sizeof(unsigned long));
>           assert(maxnode <= MAX_NODES);
> -        if (mbind(ptr, sz, backend->policy,
> -                  maxnode ? backend->host_nodes : NULL, maxnode + 1, flags)) {
> +
> +        if (maxnode &&
> +            mbind(ptr, sz, backend->policy, backend->host_nodes, maxnode + 1,
> +                  flags)) {
>               if (backend->policy != MPOL_DEFAULT || errno != ENOSYS) {
>                   error_setg_errno(errp, errno,
>                                    "cannot bind memory to host NUMA nodes");
> 


