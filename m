Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C756CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 13:57:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95D4823D51
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 13:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uf1jPL3+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D4823D51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpuHn-0006mL-TA
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 09:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1jpuH3-0005lb-25
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 09:56:41 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53338)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1jpuH1-0002Re-Gm
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 09:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593438997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JXYETXDuT/akQOdjn+sOlbrmTeC9Zqh4GIjA38Xx1hs=;
 b=Uf1jPL3+AesrKjjY0J+a8dHW4yJ5AopqJ9qtAC92Ua9W154A5akN9KXZpdIpse03zSs/Bi
 7z78UWo0aWijY0nnYTbdJScowFXGGBqVQIvcQbf41gF9zhWzL15A+dVHEFXCT1ypYSk5S6
 htZXwApvv5e6Hf/STD0gp5AWw4icETU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-KNKafLfAOmKBHduXcHhrjw-1; Mon, 29 Jun 2020 09:56:36 -0400
X-MC-Unique: KNKafLfAOmKBHduXcHhrjw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D7C319067E1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 13:56:35 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-176.rdu2.redhat.com [10.10.115.176])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B26A25C290;
 Mon, 29 Jun 2020 13:56:29 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 189B8220C58; Mon, 29 Jun 2020 09:56:29 -0400 (EDT)
Date: Mon, 29 Jun 2020 09:56:29 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 0/3] virtiofsd capability changes and addition
Message-ID: <20200629135629.GA269627@redhat.com>
References: <20200629115420.98443-1-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200629115420.98443-1-dgilbert@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vgoyal@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:06:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 29, 2020 at 12:54:17PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Hi,
>   This is a set of changes relating to the capability restirctions
> introduced in virtiofsd back in a59feb483b8.
>  
> The first one is a potentially important fix; the missing terminator
> could mean extra capabilities are added based on junk on the stack;
> although that's not been seen in practice.
>  
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Mounting overlayfs on top of virtiofs now works for me once I
gave CAP_SYS_ADMIN to daemon.

Thanks
Vivek

> v2
>   Pass a copy of the parameter list into setup_capabilities
> 
> Dr. David Alan Gilbert (3):
>   virtiofsd: Terminate capability list
>   virtiofsd: Check capability calls
>   virtiofsd: Allow addition or removal of capabilities
> 
>  docs/tools/virtiofsd.rst         |  5 +++
>  tools/virtiofsd/helper.c         |  2 +
>  tools/virtiofsd/passthrough_ll.c | 71 +++++++++++++++++++++++++++++---
>  3 files changed, 73 insertions(+), 5 deletions(-)
> 
> -- 
> 2.26.2
> 


