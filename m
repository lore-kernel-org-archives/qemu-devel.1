Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C52C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:38:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 459A02070A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="goc1g/tV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 459A02070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZeI8-0007UE-Gc
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 13:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jZeHO-0006g5-AU
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:37:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60656
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jZeHN-00032q-HQ
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589564268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qD7gbekDdtO+rodzhjO+LFEUcT+WVSH04hnXSW7Va+c=;
 b=goc1g/tVuXuYaDFynTR9u6iuCBZZ5PQGo/29nr7FXWw6cGpmECr5gqNeonc9Y0w3FufOTt
 x7vSla71wENcNljZUY69fA17z80/vXdhXHrk5WbO3hqhkBxFahL49ljTlluq/4yavFTVAf
 9YKPco1XrGqhY3Z9FN6hxmi8Seq8BxY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-us6fbw4HNXu7uvw5-tLJ1w-1; Fri, 15 May 2020 13:37:46 -0400
X-MC-Unique: us6fbw4HNXu7uvw5-tLJ1w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E20941005510;
 Fri, 15 May 2020 17:37:45 +0000 (UTC)
Received: from [10.3.114.84] (ovpn-114-84.phx2.redhat.com [10.3.114.84])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B0A539E;
 Fri, 15 May 2020 17:37:39 +0000 (UTC)
Subject: Re: [PATCH v4 3/3] qemu-options: updates for abstract unix sockets
To: xiaoqiang zhao <zxq_yx_007@163.com>, qemu-devel@nongnu.org
References: <20200515043235.32189-1-zxq_yx_007@163.com>
 <20200515043235.32189-4-zxq_yx_007@163.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <df4fe148-90af-771d-641e-0579e2049cc3@redhat.com>
Date: Fri, 15 May 2020 12:37:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515043235.32189-4-zxq_yx_007@163.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, berrange@redhat.com,
 armbru@redhat.com, kraxel@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/20 11:32 PM, xiaoqiang zhao wrote:
> add options documents changes for -chardev
> 
> Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   qemu-options.hx | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)

I'd suggest listing 'abstract' before 'tight', since 'tight' only 
matters for abstract.  I also have grammar suggestions:

> -    ``unix options: path=path``
> +    ``unix options: path=path[,tight=on|off][,abstract=on|off]``
>           ``path`` specifies the local path of the unix socket. ``path``
>           is required.
> +	``tight`` whether to set @addrlen to the minimal string length,
> +        or the maximum sun_path length. defaults to true. ``tight`` is
> +        optional.
> +	``abstract`` whether use abstract address. defaults to false.
> +	``abstract`` is optional.

``abstract`` specifies the use of the abstract socket namespace, rather 
than the filesystem.  Optional, defaults to false.
``tight`` sets the socket length of abstract sockets to their minimum, 
rather than the full sun_path length.  Optional, defaults to true.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


