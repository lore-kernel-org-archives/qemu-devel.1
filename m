Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F30C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 14:56:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A035923110
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 14:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AehW8ba5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A035923110
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6xbd-00066N-SV
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 10:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1k6xaN-0004Wq-H6
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 10:55:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50994
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1k6xaK-0004KO-WA
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 10:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597503303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tu64X3IloGMdAybGlo5ze2f/3mRcuVk9MKIrHl5rBho=;
 b=AehW8ba5cOyUnpDFp9wOlT+rsvilW1i1NcX7XAPgCRveE305eWsYKHbGw6ssVD1Ops0sIG
 4i0/ht4b4qRzRJtgnEI9FYUhAzZgI/w6y647Rfp3UQvf1z35Ej9ysm4mitOxQ3tLdGkpGP
 C47iEe8GxXIJvr9Ce6YogjRjgpneHzo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-5r91fLDAPZOgoeOmmDFwQQ-1; Sat, 15 Aug 2020 02:52:00 -0400
X-MC-Unique: 5r91fLDAPZOgoeOmmDFwQQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45EAC1005530;
 Sat, 15 Aug 2020 06:51:59 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.23])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 69DC7747CE;
 Sat, 15 Aug 2020 06:51:52 +0000 (UTC)
Date: Sat, 15 Aug 2020 08:51:50 +0200
From: Andrew Jones <drjones@redhat.com>
To: Peng Liang <liangpeng10@huawei.com>
Subject: Re: [RFC 2/9] target/arm: parse cpu feature related options
Message-ID: <20200815065150.t54pb7jktueeft42@kamzik.brq.redhat.com>
References: <20200813102657.2588720-1-liangpeng10@huawei.com>
 <20200813102657.2588720-3-liangpeng10@huawei.com>
 <20200813122113.3esshhhnolqpe6ok@kamzik.brq.redhat.com>
 <047ab475-8735-c684-b0cb-4f44d93b4a0b@huawei.com>
MIME-Version: 1.0
In-Reply-To: <047ab475-8735-c684-b0cb-4f44d93b4a0b@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=drjones@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/15 02:52:02
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
Cc: peter.maydell@linaro.org, Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 mst@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 xiexiangyou 00584000 <xiexiangyou@huawei.com>, qemu-arm@nongnu.org,
 pbonzini@redhat.com, zhukeqian 00502301 <zhukeqian1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Aug 15, 2020 at 10:19:12AM +0800, Peng Liang wrote:
> On 8/13/2020 8:21 PM, Andrew Jones wrote:
> > On Thu, Aug 13, 2020 at 06:26:50PM +0800, Peng Liang wrote:
> >> The implementation of CPUClass::parse_features only supports CPU
> >> features in "feature=value" format.  However, libvirt maybe send us a
> >> CPU feature string in "+feature/-feature" format. 
> > 
> > Why would libvirt do that? If we have a boolean feature, then I'd think
> > libvirt should be capable of sending feature=on/off just as easily as a
> > +/-feature. Indeed libvirt seems to do the right thing with all the
> > CPU features we already have: pmu, sve*, ...
> > 
> > Thanks,
> > drew
> > 
> > .
> > 
> 
> Libvirt before d47db7b16dd5422c7e487c8c8ee5b181a2f9cd66 ("qemu: command:
> Support new cpu feature argument syntax") will send +/-feature.  Does QEMU
> need to support it?  If not, I'll remote it.

No, we don't need to support pre-2016 libvirt, at least not for ARM CPU
features, because libvirt didn't start querying QEMU for ARM CPU features
until just last year.

Thanks,
drew


