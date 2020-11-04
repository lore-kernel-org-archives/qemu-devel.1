Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1A8C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:05:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C11D20867
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LtsrhzHF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C11D20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaGbY-0008C2-EO
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 06:05:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kaGaS-0007Eb-PO
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:04:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25179)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kaGaP-0007B3-1n
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:04:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604487855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WG9PsnGpnehNox59JgdctBibcXIVMvC6bLZA6wC8yd8=;
 b=LtsrhzHFGEPd56qbjWVJdiJdP6zYLNrgpH3Llw0K2nOam/wQOq0zM4OmBNQSjhmLWY3yFm
 zPRuDaqx5ArG9rmZuzMaD89521k75GkY9JdThqdGC50wBo8mTSM6zjGrTggjsrIvDogusJ
 4QVLrRF2KCjHeQcd8x4u/UmrHI2h8Uw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-1WiEL9uCNXOtIRIHH2AWCg-1; Wed, 04 Nov 2020 06:04:08 -0500
X-MC-Unique: 1WiEL9uCNXOtIRIHH2AWCg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 611381016D09
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 11:04:07 +0000 (UTC)
Received: from localhost (unknown [10.40.208.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E681719646;
 Wed,  4 Nov 2020 11:04:05 +0000 (UTC)
Date: Wed, 4 Nov 2020 12:04:03 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH for-5.2 4/4] qemu-option: warn for short-form boolean
 options
Message-ID: <20201104120403.0685dd5f@redhat.com>
In-Reply-To: <5cf3ef53-0bd1-8226-caac-3f847645c692@redhat.com>
References: <20201103151452.416784-1-pbonzini@redhat.com>
 <20201103151452.416784-5-pbonzini@redhat.com>
 <20201103160843.GP205187@redhat.com>
 <20201103222239.5463be00@redhat.com>
 <5cf3ef53-0bd1-8226-caac-3f847645c692@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
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
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Nov 2020 22:41:40 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 03/11/20 22:22, Igor Mammedov wrote:
> > shall we also deprecate short forms for -cpu model,[feat|+feat|-feat]
> > and in the end allow only -device compatible form i.e. -cpu type,feat=[on|off]
> > 
> > that would let us drop custom
> >    x86_cpu_parse_featurestr,
> >    ppc_cpu_parse_featurestr,
> >    sparc_cpu_parse_features
> > 
> > and a bunch of cpu_class_by_name, where almost each target does its
> > magic conversion of cpu_model to the type (which ranges from various
> > prefix/suffix shuffling to completely ignoring cpu_model and returning
> > a fixed cpu type)  
> 
> Yes please. :)  But I would prefer someone else to do the work because I 
> have quite some KVM backlog...
> 

I'll look into it.

> Paolo
> 
> 


