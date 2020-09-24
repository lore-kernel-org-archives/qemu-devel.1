Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1D0C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:14:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A292C21D91
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SPJaIN3G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A292C21D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLWhf-00081A-Jn
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kLWUF-00074b-LT
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:01:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60033)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kLWU9-0003LW-7B
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600974050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b8lRyGSd4ce+BgLHcxK9M6WJAysgoZskzX+NwKtSREA=;
 b=SPJaIN3GC0pwrZMXHjAYZZOEY+1k67ezn4DUg4TgdfBBxpRTsoRlPng+uNvM3Duoz6KhWk
 HZObQlEbeI3KKMu+ACZpwckRGyrjbCKXm03Vpqt9TSEDr/snebRxZS2vKCikAxymNoTvpL
 lzo1YMk68WlZ/e8rZ/ZKaqBDh4LukYM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-dIUeZkXFNOSmsdD4bttH0g-1; Thu, 24 Sep 2020 15:00:39 -0400
X-MC-Unique: dIUeZkXFNOSmsdD4bttH0g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A389E1084D76;
 Thu, 24 Sep 2020 19:00:38 +0000 (UTC)
Received: from [10.3.114.148] (ovpn-114-148.phx2.redhat.com [10.3.114.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B3E6A60C15;
 Thu, 24 Sep 2020 19:00:34 +0000 (UTC)
Subject: Re: [PATCH v9 0/7] coroutines: generate wrapper code
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200924185414.28642-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <450e10eb-e7b0-2640-4855-c0cdb21d97a4@redhat.com>
Date: Thu, 24 Sep 2020 14:00:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200924185414.28642-1-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: fam@euphon.net, kwolf@redhat.com, ehabkost@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/20 1:54 PM, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> The aim of the series is to reduce code-duplication and writing
> parameters structure-packing by hand around coroutine function wrappers.
> 
> Benefits:
>   - no code duplication
>   - less indirection
> 
> v9: Thanks to Eric, I used commit message tweaks and rebase-conflict solving from his git.
> 01: add Philippe's, Stefan's r-bs
> 02: - add Philippe's, Stefan's r-bs
>      - commit message tweaks stolen from Eric's git :)

LOL: "stolen" makes it sound like a crime was committed ;)  I find it to 
be one of the joys of open source when my ideas show up in someone 
else's work when properly attributed, as you did here.  [Maybe the 
recent push towards a conscious language initiative has let me hone in 
on something that turned out humorous to me, but might not be as obvious 
to someone less fluent in English idioms]

At any rate, I'm glad my rebase efforts helped.

> 03: add Philippe's, Stefan's r-bs
> 04: - wording/grammar by Eric (partly, stolen from repo)
>      - ref new file in docs/devel/index.rst
>      - use 644 rights and recommended header for python script
>      - call gen_header() once
>      - rename gen_wrappers_file to gen_wrappers
> 05: add Stefan's r-b
> 06: add Philippe's, Stefan's r-bs
> 07: Stefan's r-b
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


