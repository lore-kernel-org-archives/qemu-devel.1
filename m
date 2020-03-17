Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B9FC1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:41:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 241EB20753
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QGgQcDc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 241EB20753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEJ1t-0002EB-9e
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 16:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jEJ0g-0000n4-QE
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:40:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jEJ0f-0001Bu-Q2
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:40:22 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:22340)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jEJ0f-00014q-Ka
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584477621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bf8EUSMGbw2fgGJoRk5IIkecalhp4fzyHX1C//n4U5s=;
 b=QGgQcDc+ny2M3hJHyTHg/CHLS2xsgvfo9b6xonL7eo2AmNEkRk4grMKtaYIO2/aoDnKa9U
 bWvbaIDcmGSkhtUzoqT82ppVi5vW+60D4VtEf2H/Siwkf1fXnGsJXzWG0B4ZWCHSuqkOEO
 Pvh24l6CfJvYiqH0k6GZInM1tBW2W3U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-7VrbclJuMjWb68tt7X76lA-1; Tue, 17 Mar 2020 16:40:16 -0400
X-MC-Unique: 7VrbclJuMjWb68tt7X76lA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEF6013FA;
 Tue, 17 Mar 2020 20:40:15 +0000 (UTC)
Received: from [10.3.112.193] (ovpn-112-193.phx2.redhat.com [10.3.112.193])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B35360BEE;
 Tue, 17 Mar 2020 20:40:15 +0000 (UTC)
Subject: Re: [PATCH v4 26/34] qapi: Mark deprecated QMP parts with feature
 'deprecated'
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200317115459.31821-1-armbru@redhat.com>
 <20200317115459.31821-27-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <7903672f-2acf-bf9f-cadf-f5e0dc1abc43@redhat.com>
Date: Tue, 17 Mar 2020 15:40:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317115459.31821-27-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: marcandre.lureau@gmail.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/17/20 6:54 AM, Markus Armbruster wrote:
> Add feature 'deprecated' to the deprecated QMP commands, so their
> deprecation becomes visible in output of query-qmp-schema.  Looks like
> this:
> 
>      {"name": "query-cpus",
>       "ret-type": "[164]",
>       "meta-type": "command",
>       "arg-type": "0",
> ---> "features": ["deprecated"]}
> 
> Management applications could conceivably use this for static
> checking.
> 
> The deprecated commands are change, cpu-add, migrate-set-cache-size,
> migrate_set_downtime, migrate_set_speed, query-cpus, query-events,
> query-migrate-cache-size.
> 
> The deprecated command arguments are block-commit arguments @base and
> @top, and block_set_io_throttle, blockdev-change-medium,
> blockdev-close-tray, blockdev-open-tray, eject argument @device.
> 
> The deprecated command results are query-cpus-fast result @arch,
> query-block result @dirty-bitmaps, query-named-block-nodes result
> @encryption_key_missing and result @dirty-bitmaps's member @status.
> Same for query-block result @inserted, which mirrors
> query-named-block-nodes.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


