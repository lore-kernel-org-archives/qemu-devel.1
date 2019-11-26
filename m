Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E400BC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 15:54:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2BB22071E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 15:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="go9QTbyB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2BB22071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZdAA-00006q-RS
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 10:54:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60562)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iZd84-00064I-1K
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 10:51:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iZd81-0004lb-TK
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 10:51:51 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22868
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iZd81-0004in-P9
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 10:51:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574783509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KBfF2ATm99DvzhP9dNoWrfKtmFwV62atbvixQ3+ncTw=;
 b=go9QTbyBW0f60IUPh+fjUZz1WzLfc/pm0OBMTxJ7eLCCp4SsudmLJlOspg17vVzJGNptOr
 THMhsLrYCfpVrQzerJ+WmB/lphCNw2iCHZt979KsThDZjNJFnmo+XVsrCFHnTrsEKwIj4Y
 FTrk0KhagxjBIEK+feIJNhgeWErxflU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-wG_y4COLO7SVC4PvrzoiSw-1; Tue, 26 Nov 2019 10:51:44 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C89B2EDD;
 Tue, 26 Nov 2019 15:51:41 +0000 (UTC)
Received: from [10.3.116.163] (ovpn-116-163.phx2.redhat.com [10.3.116.163])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D438760C80;
 Tue, 26 Nov 2019 15:51:39 +0000 (UTC)
Subject: Re: [PATCH v9 1/3] block: introduce compress filter driver
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <1574779398-88772-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1574779398-88772-2-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <81e8a576-8611-749a-9aa5-e35025de6cd6@redhat.com>
Date: Tue, 26 Nov 2019 09:51:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1574779398-88772-2-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: wG_y4COLO7SVC4PvrzoiSw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 armbru@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/26/19 8:43 AM, Andrey Shinkevich wrote:
> Allow writing all the data compressed through the filter driver.
> The written data will be aligned by the cluster size.
> Based on the QEMU current implementation, that data can be written to
> unallocated clusters only. May be used for a backup job.
> 
> Suggested-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---

> +++ b/qapi/block-core.json
> @@ -2884,15 +2884,16 @@
>   # @copy-on-read: Since 3.0
>   # @blklogwrites: Since 3.0
>   # @blkreplay: Since 4.2
> +# @compress: Since 5.0
>   #
>   # Since: 2.9
>   ##
>   { 'enum': 'BlockdevDriver',
>     'data': [ 'blkdebug', 'blklogwrites', 'blkreplay', 'blkverify', 'bochs',
> -            'cloop', 'copy-on-read', 'dmg', 'file', 'ftp', 'ftps', 'gluster',
> -            'host_cdrom', 'host_device', 'http', 'https', 'iscsi', 'luks',
> -            'nbd', 'nfs', 'null-aio', 'null-co', 'nvme', 'parallels', 'qcow',
> -            'qcow2', 'qed', 'quorum', 'raw', 'rbd',
> +            'cloop', 'copy-on-read', 'compress', 'dmg', 'file', 'ftp', 'ftps',

Nit: Preserving alphabetical ordering means 'compress' comes before 
'copy-on-read'.

> +            'gluster', 'host_cdrom', 'host_device', 'http', 'https', 'iscsi',
> +            'luks', 'nbd', 'nfs', 'null-aio', 'null-co', 'nvme', 'parallels',
> +            'qcow', 'qcow2', 'qed', 'quorum', 'raw', 'rbd',
>               { 'name': 'replication', 'if': 'defined(CONFIG_REPLICATION)' },
>               'sheepdog',
>               'ssh', 'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs' ] }
> @@ -4045,6 +4046,7 @@
>         'bochs':      'BlockdevOptionsGenericFormat',
>         'cloop':      'BlockdevOptionsGenericFormat',
>         'copy-on-read':'BlockdevOptionsGenericFormat',
> +      'compress':   'BlockdevOptionsGenericFormat',

and again

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


