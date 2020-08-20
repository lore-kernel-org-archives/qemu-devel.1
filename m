Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E970DC433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 18:53:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3BA9207DE
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 18:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iT2YRLKy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3BA9207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8pgc-00009w-Oc
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 14:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k8pc9-0004DQ-FI
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 14:48:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36902
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k8pc6-0004IP-TM
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 14:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597949316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jl6sIq3+StgGZQf7SEIwnEcpvxLHoIaLxF5/ZqIIdY8=;
 b=iT2YRLKygR/3MATOaACC2zQmLp0PV2T77G5BB+y+zhCM5avNHO2CJX9VKXUrMbtgyGtL9Q
 pnUJUA3uXq/1jUn6Z1/d/4Hl6+EgVag+52gn1ie5jjGagnT5Ry+Rhb9r2kjRlPF6nbiwM9
 FRrHARFcWJLWDRK4yjBRcuDDfw2O8zA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-tI-JbluHNGuUFLR_B22wPg-1; Thu, 20 Aug 2020 14:48:32 -0400
X-MC-Unique: tI-JbluHNGuUFLR_B22wPg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0B6910060C3;
 Thu, 20 Aug 2020 18:48:31 +0000 (UTC)
Received: from localhost (ovpn-117-244.rdu2.redhat.com [10.10.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 54B5E100AE53;
 Thu, 20 Aug 2020 18:48:31 +0000 (UTC)
Date: Thu, 20 Aug 2020 14:48:30 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 44/58] qom: provide convenient macros for declaring
 and defining types
Message-ID: <20200820184830.GG642093@habkost.net>
References: <20200820001236.1284548-1-ehabkost@redhat.com>
 <20200820001236.1284548-45-ehabkost@redhat.com>
 <20200820174506.GE642093@habkost.net>
 <20200820175733.GC244434@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200820175733.GC244434@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 03:03:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 20, 2020 at 06:57:33PM +0100, Daniel P. Berrangé wrote:
> On Thu, Aug 20, 2020 at 01:45:06PM -0400, Eduardo Habkost wrote:
> > (CCing Eric Blake, who reviewed the original patch.  Sorry for
> > not CCing you previously, Eric)
> > 
> > On Wed, Aug 19, 2020 at 08:12:22PM -0400, Eduardo Habkost wrote:
> > [...]
> > > +/**
> > > + * OBJECT_DECLARE_TYPE:
> > > + * @ModuleObjName: the object name with initial capitalization
> > > + * @module_obj_name: the object name in lowercase with underscore separators
> > > + * @MODULE_OBJ_NAME: the object name in uppercase with underscore separators
> > 
> > We need to decide what to do with TYPE_SWIM:
> > 
> >   #define TYPE_SWIM "swim"
> >   typedef struct SWIM SWIM;
> >   #define SWIM(obj) OBJECT_CHECK(SWIM, (obj), TYPE_SWIM)
> > 
> > Both the typedef and type checking macros are called "SWIM".
> > This makes usage of OBJECT_DECLARE_TYPE impossible (because the
> > type checking function can't have the same as the typedef).  What
> > should be the recommended style here?  Rename the struct to
> > "Swim"?
> 
> This would be the gobject style approach to the problem - structs
> always have initial-caps-only even if they are abbreviations.
> 
> If that's unappealing we could add a suffix  "struct SWIMInst" 

I was considering "SWIMState", because "State" is a common
instance type suffix in QEMU device code.  But I will let the
maintainer (Laurent) decide.

> 
> > We have similar issues with RXCPU and ARMSSE, but these type
> > checking macros can be easily renamed to RX_CPU and ARM_SSE. so
> > they won't be an issue.
> 
> Or  RSCPUInst  and ARMSSEInst  ?

In these cases, renaming the type checking macro seems more
logical, because the type name constants are TYPE_RX_CPU and
TYPE_ARM_SSE.

-- 
Eduardo


