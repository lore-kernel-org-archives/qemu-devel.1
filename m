Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49753C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 20:57:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1025A2063A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 20:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OvFNu/ZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1025A2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k88g4-0003E6-AJ
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 16:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k88fE-0001vW-8S
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 16:57:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50605
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k88f8-0007Et-Vf
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 16:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597784212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XQor21bUr1JHVRntoliX+4BkSfzqEPA/mEGB2ZEojxs=;
 b=OvFNu/ZVRiIQH6YHXj40oxOnTO4AuzuxBMudTKf8+p9mB7pz1Z7s2Jjw/pSb60knMWM3WU
 lJXTy33KzFbcraNmXJm5PZMzSsPTxhi5zwDJDFryRTK+2UX5PkcwIZHJ0zLGaUIiC7ctPx
 aDBxMYCX/FoVLKV0lVwrRvsCbhyztw4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-A4iq6mz7PDWmey9gs6nIfw-1; Tue, 18 Aug 2020 16:56:50 -0400
X-MC-Unique: A4iq6mz7PDWmey9gs6nIfw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB42018686C4
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 20:56:49 +0000 (UTC)
Received: from localhost (ovpn-117-244.rdu2.redhat.com [10.10.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 598971002391;
 Tue, 18 Aug 2020 20:56:49 +0000 (UTC)
Date: Tue, 18 Aug 2020 16:56:48 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 30/41] qom: Make type checker functions accept const
 pointers
Message-ID: <20200818205648.GA500103@habkost.net>
References: <20200813222625.243136-1-ehabkost@redhat.com>
 <20200813222625.243136-31-ehabkost@redhat.com>
 <20200817160841.GC4775@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200817160841.GC4775@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 16:56:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 17, 2020 at 05:08:41PM +0100, Daniel P. Berrangé wrote:
> On Thu, Aug 13, 2020 at 06:26:14PM -0400, Eduardo Habkost wrote:
> > The existing type check macros all unconditionally drop const
> > qualifiers from their arguments.  Keep this behavior in the
> > macros generated by DECLARE_*CHECKER* by now.
> > 
> > In the future, we might use _Generic to preserve const-ness of
> > the cast function arguments.
> 
> I'm not sure what you mean by "use _Generic" ?

I meant something like:

#define OBJECT_CHECK(Type, obj, ...) \
         _Generic((obj),
                  void *: (Type *)object_dynamic_cast_assert(obj, ...),
                  const void *: (const Type *)object_dynamic_cast_assert(obj, ...))

However, now we'll generate type checking functions instead of
type checking macros, so making (for example) DEVICE((Object*)x)
and DEVICE((const Object*)x) return a different type would be
impossible.

-- 
Eduardo


