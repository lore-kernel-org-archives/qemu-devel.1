Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD56C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 10:44:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF0E72173E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 10:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDBTGtsn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF0E72173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSeGx-0003CR-Sz
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 06:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1kSeG0-0002O1-Ji
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 06:43:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33873)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1kSeFx-0000Cg-5B
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 06:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602672217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8BFUp+8rG4oJNcEXzGmJ0fjScSf+wHJRO0PKNvnM4lI=;
 b=WDBTGtsnnKejQxVfCyIlUdpPDp+38dsNYvcUuwhSZu7YHFG4JL7CRbjhzj2/tijTt54EFx
 5qoSrBEzMJIr3kyR5/eBA6wkd0I1QBeQLGeiowQrDwgx5EJsV+uvDtbXkHvClTUOQl0THl
 V8kFm/WXrt7IAtoiDSAL8lF+38m7o9o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-lU9o7M-ANCO-1xmHljA9XQ-1; Wed, 14 Oct 2020 06:43:35 -0400
X-MC-Unique: lU9o7M-ANCO-1xmHljA9XQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F0B456B5B;
 Wed, 14 Oct 2020 10:43:34 +0000 (UTC)
Received: from [10.40.192.175] (unknown [10.40.192.175])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6CE2B7666D;
 Wed, 14 Oct 2020 10:43:33 +0000 (UTC)
Subject: Re: [PATCH 0/2] qemu-ga: add ssh-{add,remove}-authorized-keys
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20201013202502.335336-1-marcandre.lureau@redhat.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <5cb8c2c7-6237-4352-a2e9-4356094a9759@redhat.com>
Date: Wed, 14 Oct 2020 12:43:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201013202502.335336-1-marcandre.lureau@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mprivozn@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: berrange@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/20 10:25 PM, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Hi,
> 
> Add two new commands to help modify ~/.ssh/authorized_keys.

Apart from Philippe's comments, this path is configurable in 
sshd.config. But I doubt we should care as ssh-copy-id doesn't care.

> 
> Although it's possible already to modify the authorized_keys files via
> file-{read,write} or exec, the commands are often denied by default, and the
> logic is left to the client. Let's add specific commands for this job.
> 
> Fixes:
> https://bugzilla.redhat.com/show_bug.cgi?id=1885332
> 
> Marc-André Lureau (2):
>    glib-compat: add g_unix_get_passwd_entry_qemu()
>    qga: add ssh-{add,remove}-authorized-keys
> 
>   include/glib-compat.h    |  24 +++
>   qga/commands-posix-ssh.c | 394 +++++++++++++++++++++++++++++++++++++++
>   qga/commands-win32.c     |  10 +
>   qga/meson.build          |  17 +-
>   qga/qapi-schema.json     |  32 ++++
>   5 files changed, 476 insertions(+), 1 deletion(-)
>   create mode 100644 qga/commands-posix-ssh.c
> 

Reviewed-by: Michal Privoznik <mprivozn@redhat.com>

Michal


