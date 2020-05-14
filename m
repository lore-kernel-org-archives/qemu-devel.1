Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61ABC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:48:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B3C720727
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ScCUI5ej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3C720727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZFA4-0001IT-PL
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jZErc-000267-RI
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:29:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21394
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jZErb-0007un-0u
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589466569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2NyK+Z72m2q/7wAX9l5WGmJQ+PygSdIQ/OQ+rmCLnb8=;
 b=ScCUI5ejLivHy41GoKO340ITy+EAyiS70uTMvvPnQdln/d9CFQIXbmm9fqRWQIBJiaPe+o
 0gN5buL4PEx4bGSW0WgzBz/25xuaYd6o1mjlx9UQJOBl3UoLilFHpwaxXw6okE/u1B+/Ad
 zPfWPozGi+KnMyMLygSnscuqUueVD+4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-LLdzFXCmMoCgIGvLJgWGZg-1; Thu, 14 May 2020 10:29:24 -0400
X-MC-Unique: LLdzFXCmMoCgIGvLJgWGZg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47779845EE9;
 Thu, 14 May 2020 14:29:23 +0000 (UTC)
Received: from [10.3.116.145] (ovpn-116-145.phx2.redhat.com [10.3.116.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 928E25C1D6;
 Thu, 14 May 2020 14:29:22 +0000 (UTC)
Subject: Re: [PATCH v2 0/1] qemu-nbd: Close inherited stderr
To: qemu-devel@nongnu.org, raphael.pour@hetzner.com
References: <158946069407.13639.5714365663552293557@45ef0f9c86ae>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ece77427-d918-d766-b2bc-08cf7d4660bc@redhat.com>
Date: Thu, 14 May 2020 09:29:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <158946069407.13639.5714365663552293557@45ef0f9c86ae>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
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
Cc: qemu-stable@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/20 7:51 AM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200514063112.1457125-1-raphael.pour@hetzner.com/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Message-id: 20200514063112.1457125-1-raphael.pour@hetzner.com
> Subject: [PATCH v2 0/1] qemu-nbd: Close inherited stderr
> Type: series
> 

> 
> === OUTPUT BEGIN ===
> WARNING: Block comments use a leading /* on a separate line
> #20: FILE: qemu-nbd.c:919:
> +            /* Remember parents stderr only if the fork option is set.
> 
> ERROR: suspect code indent for conditional statements (12, 14)
> #23: FILE: qemu-nbd.c:922:
> +            if (fork_process) {
> +              old_stderr = dup(STDERR_FILENO);
> 
> ERROR: Missing Signed-off-by: line(s)

Patchew is correct.  All three things should be fixed (the missing S-o-b 
is most important - I can't supply that; the missing spaces and comment 
formatting are something I could touch up).

The comment could use some grammar help (s/parents/parent's/), and in 
truth, I don't think it adds much beyond what the code itself is already 
doing, so rather than adding another line to silence patchew, you could 
instead just eliminate the comment and life would still be fine.  Or if 
you want a one-line comment, I might suggest:

/* Remember parent's stderr if we will restoring it. */

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


