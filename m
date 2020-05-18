Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677C8C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 21:23:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A1D12075F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 21:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2ur7v9t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A1D12075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1janEC-0001EQ-9n
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 17:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1janDI-0000n8-Rr
 for qemu-devel@nongnu.org; Mon, 18 May 2020 17:22:22 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36120)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1janDI-0005UJ-5C
 for qemu-devel@nongnu.org; Mon, 18 May 2020 17:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589836939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IkK71Gq+Bu7lhGENbaurdAcE8yt6gEPQ8HiSG1ntfhI=;
 b=H2ur7v9tf9WYdGrYLDt+zpchFnyxJYrXXv1tqyn8DKOZBMDORR36WGN6RLlaPtUbNTD6sO
 IaPRoBT2q3zcu9bvK0pDRDb9mZ6VGH09vqpG3qsgHk0EmQxln9PUWxJ+MZ1C0OMLTx/LyK
 SVNJxp/NONe+KKsm6LRglN1QpUP4I4Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-hNbEy4_IMFG-jVZ5rUEsYg-1; Mon, 18 May 2020 17:22:15 -0400
X-MC-Unique: hNbEy4_IMFG-jVZ5rUEsYg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A2CA80B71E;
 Mon, 18 May 2020 21:22:14 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B50EB79583;
 Mon, 18 May 2020 21:22:10 +0000 (UTC)
Subject: Re: [PATCH RFC v2 5/5] iotests: add 287 for
 block-dirty-bitmap-populate
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200514034922.24834-1-jsnow@redhat.com>
 <20200514034922.24834-6-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ed800a34-ccfc-e4af-7565-36eeefb44868@redhat.com>
Date: Mon, 18 May 2020 16:22:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200514034922.24834-6-jsnow@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 16:37:19
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
Cc: Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 vsementsov@virtuozzo.com, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/13/20 10:49 PM, John Snow wrote:
> Give block-dirty-bitmap-populate a workout.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   tests/qemu-iotests/287     |  242 ++
>   tests/qemu-iotests/287.out | 4544 ++++++++++++++++++++++++++++++++++++

Sheesh, that output file is a workout indeed.

>   tests/qemu-iotests/group   |    1 +
>   3 files changed, 4787 insertions(+)
>   create mode 100755 tests/qemu-iotests/287
>   create mode 100644 tests/qemu-iotests/287.out

287 has been created in the meantime (commit dd488fc1c00); we'll have to 
rebase.  (Vladimir's series to rename iotests to something sensible 
instead of three digits may help...)

> +
> +class Drive:
> +    def __init__(self, path, vm):
> +        self.path = path
> +        self.vm = vm
> +        self.fmt = None
> +        self.size = None
> +        self.node = None
> +
> +    def img_create(self, fmt, size):
> +        self.fmt = fmt
> +        self.size = size
> +        iotests.qemu_img_create('-f', self.fmt, self.path, str(self.size))

Are we creating images with backing files anywhere in this test?  Should 
we be?  (The question of what is allocated in the top layer is more 
interesting to answer when there is a backing layer)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


