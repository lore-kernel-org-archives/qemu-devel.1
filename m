Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF24C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:34:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9717C2065C
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ikySVX+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9717C2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjOHx-0000Tv-Pw
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 10:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jjOGp-000827-Fp
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 10:33:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42026
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jjOGo-0001CY-Ag
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 10:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591886008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GP5JW9xWQvedUO1sV4sAoR5F6LadVMmEcrROE0T7AXU=;
 b=ikySVX+kzBPk78nXKj00A33GZmyjHINFzmHcUi7OFTOgyJRu7A9v6ABpMfda0/WSMihVug
 Ulg9IrsknRbpZIpkq2PV4LX2vM14CPFtN63SeDAAtH3nWN6ycYMKntEqTdSA+yZgmBJyxd
 yfJ/RMCF8ANh+uKwr72mrNn+VnWP46Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-V8sOaaJHPS-33sexL5RJMw-1; Thu, 11 Jun 2020 10:33:26 -0400
X-MC-Unique: V8sOaaJHPS-33sexL5RJMw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 566A0805DEE
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 14:31:51 +0000 (UTC)
Received: from [10.3.113.22] (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D88FC619C8;
 Thu, 11 Jun 2020 14:31:50 +0000 (UTC)
Subject: Re: [PATCH 0/2] monitor openfd commands
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, armbru@redhat.com, thuth@redhat.com,
 quintela@redhat.com
References: <20200611111703.159590-1-dgilbert@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <cec98884-f2cd-02f3-1806-a6579ce68961@redhat.com>
Date: Thu, 11 Jun 2020 09:31:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611111703.159590-1-dgilbert@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On 6/11/20 6:17 AM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> The monitors currently have a 'getfd' command that lets you pass an fd
> via the monitor socket.  'openfd' is a new command that opens a file
> and puts the fd in the same fd pool.  The file is opened RW and created
> if it doesn't exist.
> It makes it easy to test migration to and from a file.

We have two fd-passing mechanisms: getfd and add-fd.  add-fd is newer, 
and allows things like /dev/fdset/NNN to work anywhere a filename works. 
  I'm guessing that the issue here is that migration hasn't been tweaked 
to work nicely with the newer add-fd, but instead insists on the older 
getfd interface (where you have to use getfd to associate an fd with a 
name, then tell migration to use that special name, but the special name 
is via a different parameter than the normal filename parameter).  At 
which point openfd looks like it is just sugar to make getfd easier to use.

Would it instead be worth modifying migration to work with add-fd?  Or 
does add-fd need the same sort of sugar?

> 
> Dr. David Alan Gilbert (2):
>    qmp: Add 'openfd' command
>    hmp: Add 'openfd' command
> 
>   hmp-commands.hx        | 16 +++++++++++++-
>   include/monitor/hmp.h  |  1 +
>   monitor/hmp-cmds.c     | 10 +++++++++
>   monitor/misc.c         | 48 +++++++++++++++++++++++++++++++++---------
>   qapi/misc.json         | 23 +++++++++++++++++++-
>   tests/qtest/test-hmp.c |  2 ++
>   6 files changed, 88 insertions(+), 12 deletions(-)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


