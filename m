Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA43BC43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 18:53:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6645922207
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 18:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bNm9L59D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6645922207
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGoAn-0008WB-GL
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 14:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGoAH-00085b-BH
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 14:52:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40239)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGoAF-0003sI-If
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 14:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599850370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mbQNH7E+3G4irDN7c6PM1Zu/4d2U/VSTA2Lhw/d4Sw8=;
 b=bNm9L59D6dwTVOp8XJbj7uNT5pYMoS5XGHqf26okQQ5LGeXrer8APpqo0/NaIGZFwmVw3t
 vpH9Vzb/tL4WAVqhJhZhliwTa+zO9Hob8UUimaB0NYl+qv84irFuijSoiR8f7R4TGkBrBr
 r2d6YfRZ6eNniYqKKgkgLxs0wSYW9ZE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-yg-fxiPbP3iPVs6v7hwJ2g-1; Fri, 11 Sep 2020 14:52:48 -0400
X-MC-Unique: yg-fxiPbP3iPVs6v7hwJ2g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A1118015A4;
 Fri, 11 Sep 2020 18:52:47 +0000 (UTC)
Received: from work-vm (ovpn-113-52.ams2.redhat.com [10.36.113.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FAFB75121;
 Fri, 11 Sep 2020 18:52:33 +0000 (UTC)
Date: Fri, 11 Sep 2020 19:52:30 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V1 16/32] oslib: add qemu_clr_cloexec
Message-ID: <20200911185230.GV3310@work-vm>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-17-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1596122076-341293-17-git-send-email-steven.sistare@oracle.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 23:26:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Steve Sistare (steven.sistare@oracle.com) wrote:
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Seems same as set, so:

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  include/qemu/osdep.h | 1 +
>  util/oslib-posix.c   | 9 +++++++++
>  util/oslib-win32.c   | 4 ++++
>  3 files changed, 14 insertions(+)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 45c217a..bb28df1 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -551,6 +551,7 @@ static inline void qemu_timersub(const struct timeval *val1,
>  #endif
>  
>  void qemu_set_cloexec(int fd);
> +void qemu_clr_cloexec(int fd);
>  
>  /* Starting on QEMU 2.5, qemu_hw_version() returns "2.5+" by default
>   * instead of QEMU_VERSION, so setting hw_version on MachineClass
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index d923674..28fee45 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -314,6 +314,15 @@ void qemu_set_cloexec(int fd)
>      assert(f != -1);
>  }
>  
> +void qemu_clr_cloexec(int fd)
> +{
> +    int f;
> +    f = fcntl(fd, F_GETFD);
> +    assert(f != -1);
> +    f = fcntl(fd, F_SETFD, f & ~FD_CLOEXEC);
> +    assert(f != -1);
> +}
> +
>  /*
>   * Creates a pipe with FD_CLOEXEC set on both file descriptors
>   */
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index 7eedbe5..e5d0c7c 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -254,6 +254,10 @@ void qemu_set_cloexec(int fd)
>  {
>  }
>  
> +void qemu_clr_cloexec(int fd)
> +{
> +}
> +
>  /* Offset between 1/1/1601 and 1/1/1970 in 100 nanosec units */
>  #define _W32_FT_OFFSET (116444736000000000ULL)
>  
> -- 
> 1.8.3.1
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


