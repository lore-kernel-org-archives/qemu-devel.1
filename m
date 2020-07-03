Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C79C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 12:07:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5116920772
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 12:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xcw3yubj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5116920772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrKTH-0003mG-KG
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 08:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jrKSe-00033c-HN
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 08:06:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28244
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jrKSd-0007v9-2L
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 08:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593777989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HiXF8QA5XRmllngQa8EDckihXyF+/8O5bgiNUux545g=;
 b=Xcw3yubjdkPibBensmcMF2afi2nRMIViBvTJPeI28IhPU3kgPllW4+YfqpQGt7GboTZUrm
 3JTXos6PXKZtNGHTSwt7KblYePzaO33T2wKGBkfZ/aJDLkesDTprB2CY0xiwcyOctpxX9w
 7BjJtzLKEFUakt20P7nbm6dqBCBPL/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-LOWHW9vdNI-9YuB5Ij6ofw-1; Fri, 03 Jul 2020 08:06:28 -0400
X-MC-Unique: LOWHW9vdNI-9YuB5Ij6ofw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B76EEC1A0
 for <qemu-devel@nongnu.org>; Fri,  3 Jul 2020 12:06:27 +0000 (UTC)
Received: from work-vm (ovpn-114-207.ams2.redhat.com [10.36.114.207])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D9B139CFC7;
 Fri,  3 Jul 2020 12:06:20 +0000 (UTC)
Date: Fri, 3 Jul 2020 13:06:18 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, virtio-fs@redhat.com, stefanha@redhat.com,
 vgoyal@redhat.com
Subject: Re: [PATCH v2 0/3] virtiofsd capability changes and addition
Message-ID: <20200703120618.GA36813@work-vm>
References: <20200629115420.98443-1-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200629115420.98443-1-dgilbert@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:17:33
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Dr. David Alan Gilbert (git) (dgilbert@redhat.com) wrote:
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

Queued

> 
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
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


