Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62035C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 17:51:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB00820706
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 17:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dhvvdA0T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB00820706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYYYN-0001h6-QJ
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 13:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kYYX3-0000cc-QA
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 13:49:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40245)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kYYX2-0002md-1N
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 13:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604080183;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=moup/79K6YhjMkvRsuQLKMr6psedbjifBJxbxKPt8oA=;
 b=dhvvdA0TYphv5u8GZCZbX0p2iiP1k4lgAyq6GmuCwjN1MzZ3g17viaERelcPhQVrzzJS+4
 ynuN3sTsBMEvMS+YxRnlYGWLO/wEO12kI+F5kjkUTxp7RvJ/ok5QC4Zm9SP3Wfbu1ba0Xd
 yIc24jFTl6Uhn82JC4KY5Oy/f9pbVWY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-f0us_g8KPq26lGGzD6Sd3A-1; Fri, 30 Oct 2020 13:49:39 -0400
X-MC-Unique: f0us_g8KPq26lGGzD6Sd3A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 384F39CDD9;
 Fri, 30 Oct 2020 17:49:38 +0000 (UTC)
Received: from redhat.com (ovpn-112-192.ams2.redhat.com [10.36.112.192])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D41D1109F197;
 Fri, 30 Oct 2020 17:49:36 +0000 (UTC)
Date: Fri, 30 Oct 2020 17:49:33 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/2] scripts/kerneldoc: For Sphinx 3 use c:macro for
 macros with arguments
Message-ID: <20201030174933.GH104289@redhat.com>
References: <20201030174700.7204-1-peter.maydell@linaro.org>
 <20201030174700.7204-2-peter.maydell@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20201030174700.7204-2-peter.maydell@linaro.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 30, 2020 at 05:46:59PM +0000, Peter Maydell wrote:
> The kerneldoc script currently emits Sphinx markup for a macro with
> arguments that uses the c:function directive. This is correct for
> Sphinx versions earlier than Sphinx 3, where c:macro doesn't allow
> documentation of macros with arguments and c:function is not picky
> about the syntax of what it is passed. However, in Sphinx 3 the
> c:macro directive was enhanced to support macros with arguments,
> and c:function was made more picky about what syntax it accepted.
> 
> When kerneldoc is told that it needs to produce output for Sphinx
> 3 or later, make it emit c:function only for functions and c:macro
> for macros with arguments. We assume that anything with a return
> type is a function and anything without is a macro.
> 
> This fixes the Sphinx error:
> 
> /home/petmay01/linaro/qemu-from-laptop/qemu/docs/../include/qom/object.h:155:Error in declarator
> If declarator-id with parameters (e.g., 'void f(int arg)'):
>   Invalid C declaration: Expected identifier in nested name. [error at 25]
>     DECLARE_INSTANCE_CHECKER ( InstanceType,  OBJ_NAME,  TYPENAME)
>     -------------------------^
> If parenthesis in noptr-declarator (e.g., 'void (*f(int arg))(double)'):
>   Error in declarator or parameters
>   Invalid C declaration: Expecting "(" in parameters. [error at 39]
>     DECLARE_INSTANCE_CHECKER ( InstanceType,  OBJ_NAME,  TYPENAME)
>     ---------------------------------------^
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  scripts/kernel-doc | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


