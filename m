Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EF2C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 20:04:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F28207CB
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 20:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QTMjAjne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F28207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdfo7-0001a0-O7
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 16:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jdfnO-000187-8h
 for qemu-devel@nongnu.org; Tue, 26 May 2020 16:03:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33664
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jdfnM-0008M9-Dg
 for qemu-devel@nongnu.org; Tue, 26 May 2020 16:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590523406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KZIZkabUxZo0phpy3SdB8BTIFSEbG7bbiwsC/+BBEu4=;
 b=QTMjAjneUuswGxdwFrkp4TeHeVeSj4Pf6EbwfyOIceVCpAgbRPNYATg8tQiG4NiA5c5uBh
 0oTIJ3m8LdqVAf6jZMxW/urgf2aEeb0l6zfBpwoUo/V606gnBNV1+T+CewJcq00oB0O4K1
 HNfLHt4J7iElgITpzw4PO6AXBtWc46c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-rVVJ7OVkMfyIq_WkvsNdgw-1; Tue, 26 May 2020 16:03:21 -0400
X-MC-Unique: rVVJ7OVkMfyIq_WkvsNdgw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7528889ACF5;
 Tue, 26 May 2020 20:03:05 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BD0925D9E5;
 Tue, 26 May 2020 20:02:27 +0000 (UTC)
Subject: Re: [PATCH 1/2] qapi: Fix comment format for @CpuInstanceProperties
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
References: <cover.1590426097.git.mprivozn@redhat.com>
 <e7a678664d5f384f8d4cae72755c9a887643b0c0.1590426097.git.mprivozn@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <4acc2872-9d98-35e0-135a-963f32a8b18d@redhat.com>
Date: Tue, 26 May 2020 15:02:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <e7a678664d5f384f8d4cae72755c9a887643b0c0.1590426097.git.mprivozn@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:51:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: imammedo@redhat.com, ehabkost@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/25/20 12:03 PM, Michal Privoznik wrote:
> In 176d2cda0de, the @die-id attribute was introduced to
> CpuInstanceProperties type. However, it mangled the comment.
> 
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
>   qapi/machine.json | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/qapi/machine.json b/qapi/machine.json
> index ff7b5032e3..39caa1d914 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -824,7 +824,8 @@
>   # @node-id: NUMA node ID the CPU belongs to
>   # @socket-id: socket number within node/board the CPU belongs to
>   # @die-id: die number within node/board the CPU belongs to (Since 4.1)
> -# @core-id: core number within die the CPU belongs to# @thread-id: thread number within core the CPU belongs to
> +# @core-id: core number within die the CPU belongs to
> +# @thread-id: thread number within core the CPU belongs to
>   #
>   # Note: currently there are 5 properties that could be present
>   #       but management should be prepared to pass through other
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


