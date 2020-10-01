Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC50C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:10:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F412B20897
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YqNq1+UM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F412B20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO25l-0003Y2-1s
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kO22T-0008WM-0m
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:06:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26279)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kO22R-0001Sh-7z
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601571998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iEAgsg/yS6Py9FdSD/kZSiwdkf2ooJzT8eWaRGGQdkY=;
 b=YqNq1+UMBoe59Fm6OXuJmUgJ/dWr4QoOzXOX3HiTQy3UZniZHJtS3+OjGy5hrC/TptCp7J
 2CvMtB17US4pWkoHgycDcykBrqSQu0VnLwRQjYtrR4QDPQxojNid2NdAZNyThYlhLj95b0
 TyLqSF7+P5dXXzBMr+s0ZxZDbxsHg6U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-ewaFcgcwPp-cg8JoaymS2w-1; Thu, 01 Oct 2020 13:06:36 -0400
X-MC-Unique: ewaFcgcwPp-cg8JoaymS2w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8473E807330;
 Thu,  1 Oct 2020 17:06:35 +0000 (UTC)
Received: from gondolin (ovpn-112-102.ams2.redhat.com [10.36.112.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F5722C31E;
 Thu,  1 Oct 2020 17:06:30 +0000 (UTC)
Date: Thu, 1 Oct 2020 19:06:28 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 0/9] s390x/tcg: Implement some z14 facilities
Message-ID: <20201001190628.7f02aa45.cohuck@redhat.com>
In-Reply-To: <34320742-1859-ba79-9396-e3783f785fae@redhat.com>
References: <20200928122717.30586-1-david@redhat.com>
 <20201001190214.210cbcee.cohuck@redhat.com>
 <34320742-1859-ba79-9396-e3783f785fae@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 1 Oct 2020 19:03:39 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 01.10.20 19:02, Cornelia Huck wrote:
> > On Mon, 28 Sep 2020 14:27:08 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> With this patchset, I can boot a kernel compiled for z14 (requiring
> >> Miscellaneous-Instruction-Extensions Facility 2) (using -cpu max).
> >>
> >> I am currently working on "vector-enhancements facility 1", I have most
> >> stuff in place except:
> >> - VECTOR FP (MAXIMUM|MINIMUM): needs some manual work to cover all types of
> >>                                comparisons.
> >>
> >> Once we have that in place, we can convert the QEMU machine to a
> >> stripped-down z14.
> >>
> >> v1 -> v2:
> >> - "s390x/cpu_model: S390_FEAT_MISC_INSTRUCTION_EXT ->
> >>    S390_FEAT_MISC_INSTRUCTION_EXT2"
> >> -- Added
> >> - "s390x/tcg: Implement BRANCH INDIRECT ON CONDITION (BIC)"
> >> -- Use new helper instead
> >> - "s390x/tcg: Implement MULTIPLY SINGLE (MSC, MSGC, MSGRKC, MSRKC)"
> >> -- Tune comparisons in CC computation
> >>
> >> David Hildenbrand (9):
> >>   s390x/cpu_model: S390_FEAT_MISC_INSTRUCTION_EXT ->
> >>     S390_FEAT_MISC_INSTRUCTION_EXT2
> >>   s390x/tcg: Implement ADD HALFWORD (AGH)
> >>   s390x/tcg: Implement SUBTRACT HALFWORD (SGH)
> >>   s390x/tcg: Implement MULTIPLY (MG, MGRK)
> >>   s390x/tcg: Implement MULTIPLY HALFWORD (MGH)
> >>   s390x/tcg: Implement BRANCH INDIRECT ON CONDITION (BIC)
> >>   s390x/tcg: Implement MULTIPLY SINGLE (MSC, MSGC, MSGRKC, MSRKC)
> >>   s390x/tcg: We support Miscellaneous-Instruction-Extensions Facility 2
> >>   s390x/tcg: Implement CIPHER MESSAGE WITH AUTHENTICATION (KMA)
> >>
> >>  target/s390x/cc_helper.c            | 32 +++++++++++++++++++
> >>  target/s390x/cpu_features_def.h.inc |  2 +-
> >>  target/s390x/gen-features.c         |  4 ++-
> >>  target/s390x/helper.c               |  2 ++
> >>  target/s390x/insn-data.def          | 12 ++++++++
> >>  target/s390x/internal.h             |  2 ++
> >>  target/s390x/translate.c            | 48 +++++++++++++++++++++++++++++
> >>  7 files changed, 100 insertions(+), 2 deletions(-)
> >>  
> > 
> > Thanks, applied.
> >   
> 
> Can you rename in patch #1 subject "s390x/cpu_model" ->
> "s390x/cpumodel"? Thanks!

As you wish :) Pushed out.


