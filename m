Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE9EC4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:05:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8818823741
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQ/51f3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8818823741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLNBY-00069X-NC
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 05:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLN9y-0004nT-5b
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:03:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35700)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLN9v-0003ER-5n
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600938202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e+55kK8neczSRBpB8gZp8Jwk57omXrDXz8rrmA5b2pw=;
 b=DQ/51f3ZBClLCqfxDJpwgeqfmQtBV4CMeU7BEo+TijOM4qxR43BN0N5N5OcTH9Y8BtsauD
 h7jPM9k6wzmc4VL90u9AdjYcm4N1MTshlzLaMf9wemwCyKuNHXh/OtMI3a73nlmVOByjOz
 /DqDAcT+p75sj4/ttdtVR47yInPSCGE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-t0lw9BhdOLCeA756Oyc0Bw-1; Thu, 24 Sep 2020 05:03:17 -0400
X-MC-Unique: t0lw9BhdOLCeA756Oyc0Bw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 543FB81F007;
 Thu, 24 Sep 2020 09:03:16 +0000 (UTC)
Received: from work-vm (ovpn-114-250.ams2.redhat.com [10.36.114.250])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 30E799CBA;
 Thu, 24 Sep 2020 09:03:14 +0000 (UTC)
Date: Thu, 24 Sep 2020 10:03:11 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Chuan Zheng <zhengchuan@huawei.com>
Subject: Re: [PATCH v4 0/6] *** Add Multifd support for TLS migration ***
Message-ID: <20200924090311.GA4980@work-vm>
References: <1600139042-104593-1-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1600139042-104593-1-git-send-email-zhengchuan@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: berrange@redhat.com, zhang.zhanghailiang@huawei.com, quintela@redhat.com,
 yuxiating@huawei.com, qemu-devel@nongnu.org, xiexiangyou@huawei.com,
 alex.chen@huawei.com, jinyan12@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Chuan Zheng (zhengchuan@huawei.com) wrote:
> v3 -> v4:
>     still use MigrationState field and save hostname in migration_tls_channel_connect
>     remove MigrationState from MultiFDSendParams
>  
> v2 -> v3:
>     rebase patches on master
> 
> v1 -> v2:
>     fix memoryleak of MigrationState hostname
>     add tls_hostname into MultiFDSendParams for handshake use
>     fix function alignment
>     squash Patch005 and Patch006
>     add ioc into trace-events
> 
> TLS migration could easily reach bottleneck of cpu because of encryption
> and decryption in migration thread.
> In our test, the tls migration could only reach 300MB/s under bandwidth
> of 500MB/s.
> 
> Inspired by multifd, we add multifd support for tls migration to make fully
> use of given net bandwidth at the cost of multi-cpus and could reduce
> at most of 100% migration time with 4U16G test vm.
> 
> Evaluate migration time of migration vm.
> The VM specifications for migration are as follows:
> - VM use 4-K page;
> - the number of VCPU is 4;
> - the total memory is 16Gigabit;
> - use 'mempress' tool to pressurize VM(mempress 4096 100);
> - migration flag is 73755 (8219 + 65536 (TLS)) vs 204827 (8219 + 65536 (TLS) + 131072(Multifd))
> 
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> |                      |         TLS           |      MultiFD + TLS (2 channel)    |
> --------------------------------------------------------t---------------------------
> | mempress 1024 120    |       25.035s         |           15.067s                 |
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> | mempress 1024 200    |       48.798s         |           25.334s                 |
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Queued.

> Chuan Zheng (6):
>   migration/tls: save hostname into MigrationState
>   migration/tls: extract migration_tls_client_create for common-use
>   migration/tls: add tls_hostname into MultiFDSendParams
>   migration/tls: extract cleanup function for common-use
>   migration/tls: add support for multifd tls-handshake
>   migration/tls: add trace points for multifd-tls
> 
>  migration/channel.c    |   1 +
>  migration/migration.c  |   1 +
>  migration/migration.h  |   5 ++
>  migration/multifd.c    | 124 +++++++++++++++++++++++++++++++++++++++++++------
>  migration/multifd.h    |   2 +
>  migration/tls.c        |  28 +++++++----
>  migration/tls.h        |   6 +++
>  migration/trace-events |   4 ++
>  8 files changed, 149 insertions(+), 22 deletions(-)
> 
> -- 
> 1.8.3.1
> 
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


