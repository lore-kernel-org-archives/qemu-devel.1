Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC6AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 19:44:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33C062077D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 19:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z1RfEoLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C062077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhIGQ-0001Sm-ER
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 15:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jhIFo-0000yj-OK
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 15:43:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53624
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jhIFk-0007uY-Vo
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 15:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591386224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZYeo8ZchRQfqPNrQ6480n+t4pqsPE6EybcAaY1aHHC8=;
 b=Z1RfEoLzIJ5I6YMhR04xVLFXY7LvDXTkpe6Sao30k7oRzUusocnoG8+Ah1b0cxuArq8gjV
 /0MoxPeEHxhwWmbosELRC86zUqUhznABg/BnC7yKbocUrQpKgS5IYKMiMDrrjxl1QkVlin
 YhdizK7ZtlJSh7dxA9NeGCPV9HMkeZM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-LgPkJweGNeqTS-ev5QsfCw-1; Fri, 05 Jun 2020 15:43:40 -0400
X-MC-Unique: LgPkJweGNeqTS-ev5QsfCw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29EC51009619;
 Fri,  5 Jun 2020 19:43:39 +0000 (UTC)
Received: from [10.3.113.22] (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E6317CCF9;
 Fri,  5 Jun 2020 19:43:38 +0000 (UTC)
Subject: Re: [PATCH v4 01/12] qcow2.py: python style fixes
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200604174135.11042-1-vsementsov@virtuozzo.com>
 <20200604174135.11042-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <7b0ae96a-e52f-d75d-cd17-e681258874b7@redhat.com>
Date: Fri, 5 Jun 2020 14:43:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200604174135.11042-2-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:40:54
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
Cc: kwolf@redhat.com, den@openvz.org, andrey.shinkevich@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/4/20 12:41 PM, Vladimir Sementsov-Ogievskiy wrote:
> Fix flake8 complains. Leave the only chunk of lines over 79 characters:

complaints

> initialization of cmds variable. Leave it for another day, when it
> should be refactored to utilize argparse instead of hand-written
> parsing.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   tests/qemu-iotests/qcow2.py | 92 +++++++++++++++++++++----------------
>   1 file changed, 53 insertions(+), 39 deletions(-)
> 

>   cmds = [
> -    [ 'dump-header',          cmd_dump_header,          0, 'Dump image header and header extensions' ],
> -    [ 'dump-header-exts',     cmd_dump_header_exts,     0, 'Dump image header extensions' ],
> -    [ 'set-header',           cmd_set_header,           2, 'Set a field in the header'],
> -    [ 'add-header-ext',       cmd_add_header_ext,       2, 'Add a header extension' ],
> -    [ 'add-header-ext-stdio', cmd_add_header_ext_stdio, 1, 'Add a header extension, data from stdin' ],
> -    [ 'del-header-ext',       cmd_del_header_ext,       1, 'Delete a header extension' ],
> -    [ 'set-feature-bit',      cmd_set_feature_bit,      2, 'Set a feature bit'],
> +    ['dump-header',          cmd_dump_header,          0, 'Dump image header and header extensions'],

I know you mentioned argparse as a later refactoring, but is it worth 
reflowing the table in the meantime?

['dump-header', cmd_dump_header, 0,
  'Dump image header and header extensions'],
[...
  '...'],

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


