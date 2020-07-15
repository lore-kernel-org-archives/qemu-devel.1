Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA636C433EB
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 15:14:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A53F720658
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 15:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cbbcUNFf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53F720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvj72-0008Q9-W3
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 11:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jvj5x-0007iT-OI
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 11:13:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21437
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jvj5u-0008Gr-FN
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 11:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594825993;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N3yPsmRXB3YwgMsPX0IiwyZqGtLSV0qsjSriIm/JkR4=;
 b=cbbcUNFfHND5Zr6CTAV3jkmlXUU2cZ7qUZdKMZ1rcKtiB1rJAqAinv3ShHSKS0z/W2dahW
 SLQSSfiZYOtRxumQ3D0YBNrZJkZLzb+mvRft2LNNE8KDAaW89YKmGHo5y42oholSDKoRzJ
 FwNijWBhv9bVhusZHRMi79EtKGdy0wg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-s22FjWOgNQejGdaE7PxDiA-1; Wed, 15 Jul 2020 11:13:11 -0400
X-MC-Unique: s22FjWOgNQejGdaE7PxDiA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB6061030C20;
 Wed, 15 Jul 2020 15:13:09 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 591E5100164C;
 Wed, 15 Jul 2020 15:13:05 +0000 (UTC)
Date: Wed, 15 Jul 2020 16:13:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.1] net/colo: Remove unused trace event
Message-ID: <20200715151302.GE88416@redhat.com>
References: <20200715143130.11164-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200715143130.11164-1-philmd@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: zhangchen.fnst@cn.fujitsu.com, Li Zhijian <lizhijian@cn.fujitsu.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Zhang Chen <chen.zhang@intel.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 15, 2020 at 04:31:30PM +0200, Philippe Mathieu-Daudé wrote:
> Unused trace event cause build failure when using the dtrace backend:
> 
>   "probe colo_compare_miscompare doesn't exist"
> 
> Fixes: f4b618360e ("colo-compare: add TCP, UDP, ICMP packet comparison")
> Reported-by: Roman Bolshakov <r.bolshakov@yadro.com>

Note Roman indicated on IRC that this is seen with dtrace on macOS and
there were other problems too.

Unless someone knows that QEMU's dtrace support worked on macOS in the
past, I think we don't need  and simply consider dtrace unsupported on
macOS right now until someone can get it into more robust shape on
macOS.

> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> Cc: zhangchen.fnst@cn.fujitsu.com
> ---
>  net/trace-events | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/net/trace-events b/net/trace-events
> index fa49c71533..c3f623d40c 100644
> --- a/net/trace-events
> +++ b/net/trace-events
> @@ -17,7 +17,6 @@ colo_compare_udp_miscompare(const char *sta, int size) ": %s = %d"
>  colo_compare_icmp_miscompare(const char *sta, int size) ": %s = %d"
>  colo_compare_ip_info(int psize, const char *sta, const char *stb, int ssize, const char *stc, const char *std) "ppkt size = %d, ip_src = %s, ip_dst = %s, spkt size = %d, ip_src = %s, ip_dst = %s"
>  colo_old_packet_check_found(int64_t old_time) "%" PRId64
> -colo_compare_miscompare(void) ""
>  colo_compare_tcp_info(const char *pkt, uint32_t seq, uint32_t ack, int hdlen, int pdlen, int offset, int flags) "%s: seq/ack= %u/%u hdlen= %d pdlen= %d offset= %d flags=%d"
>  
>  # filter-rewriter.c
> -- 
> 2.21.3
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


