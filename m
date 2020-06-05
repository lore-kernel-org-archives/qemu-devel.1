Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CB3C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:57:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 555E1206DC
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="if3DQ27Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 555E1206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhEj2-0000sh-IF
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 11:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jhEgI-0003wJ-UY
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:54:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53293
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jhEgH-0004zQ-Go
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591372492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VNA5BbRTwuJTsiVfhGA1Txb8W4yr50sFIpeSyUwMq6Y=;
 b=if3DQ27YgxZqXqw6RKIcbhQ8YXDDKd5UWLQn5VfYn6SAKWaLX4joUuXGpt0/IL0VgWAEu3
 7AukHMnvLoPbjOS6TclPPaNrzMGqHKhonimX+356pQJVIUk4JYbCwDL7Vh0/a78hxbT/0D
 OhxXAd3JBTMdaG/5lqZ2VD/Ob5u8npU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-xr5F5JkFNdmb7YkCSJQ1yg-1; Fri, 05 Jun 2020 11:54:46 -0400
X-MC-Unique: xr5F5JkFNdmb7YkCSJQ1yg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F79B107ACCA;
 Fri,  5 Jun 2020 15:54:45 +0000 (UTC)
Received: from [10.3.113.22] (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0969460BE2;
 Fri,  5 Jun 2020 15:54:44 +0000 (UTC)
Subject: Re: [PATCH v1 00/14] various fixes for next PR (testing, vhost,
 guest_base fixes)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200605154929.26910-1-alex.bennee@linaro.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <80fa6131-51c1-eed5-f2a6-54ae60e71539@redhat.com>
Date: Fri, 5 Jun 2020 10:54:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200605154929.26910-1-alex.bennee@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:27:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/5/20 10:49 AM, Alex Bennée wrote:
> Hi,
> 
> These are all the patches I've currently got which are ready for a
> pull request next week. I've included some patches which are destined
> to go in via other trees so I can keep the testing green on the CI.
> 
> In summary:
> 
>   Some simple plugin cleanups (the reset remain in plugins/next)
>   Reliability fixes for travis/shippable
>   iotest 194 fix (going in via block tree?)

I've got that one queued for a PR Monday with some typo fixes included.

>   docker updates (ubuntu and tricore fix)
>   vhost-user and TCG fix
>   more linux-user guest_base fixes
> 
> I'll certainly include the testing stuff in my PR but if others are
> happy for me to include bits touching their areas then shout and I'll
> include them in the PR.
> 
> The following need review:
> 
>   - linux-user: detect overflow of MAP_FIXED mmap
>   - linux-user: deal with address wrap for ARM_COMMPAGE on 32 bit
>   - linux-user: provide fallback pgd_find_hole for bare chroots
>   - tests/docker: fix pre-requisite for debian-tricore-cross
>   - hw/virtio/vhost: re-factor vhost-section and allow DIRTY_MEMORY_CODE
>   - .shippable: temporaily disable some cross builds
>   - exec: flush the whole TLB if a watchpoint crosses a page boundary
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


