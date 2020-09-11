Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43331C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 10:48:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91AB9221ED
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 10:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g8Md3AXH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91AB9221ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGgbj-0003io-Hk
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 06:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kGgbD-0003Hm-M1
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 06:48:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41722
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kGgbB-00038j-6h
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 06:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599821288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rUUozAIkJhpSeGhpSaJB2N5abyWeXj6mSrtB3JTAQjc=;
 b=g8Md3AXHZetgeecC40MYkZC8wZn0YtqcTpGMPvUrb2WyklBvuw7Z/u/tJ7VlzuN+ICmw5H
 knPo4tRojKgM3NYltUOBPKMhxqitJT7gTgd2iKH4HSMzwvuEbah921VYeURqc8mGad+XHY
 meglHOkmALN3dd3hFr048BwLIW82MJY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-8tgPid77Ma-biEuiDFMYGQ-1; Fri, 11 Sep 2020 06:48:07 -0400
X-MC-Unique: 8tgPid77Ma-biEuiDFMYGQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 384BF801AEA;
 Fri, 11 Sep 2020 10:48:05 +0000 (UTC)
Received: from gondolin (ovpn-112-170.ams2.redhat.com [10.36.112.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E91CA5D9F7;
 Fri, 11 Sep 2020 10:47:56 +0000 (UTC)
Date: Fri, 11 Sep 2020 12:47:54 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Collin Walling <walling@linux.ibm.com>
Subject: Re: [PATCH v5 6/8] s390/sclp: add extended-length sccb support for
 kvm guest
Message-ID: <20200911124754.1a6c6cba.cohuck@redhat.com>
In-Reply-To: <20200910093655.255774-7-walling@linux.ibm.com>
References: <20200910093655.255774-1-walling@linux.ibm.com>
 <20200910093655.255774-7-walling@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 03:28:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: thuth@redhat.com, frankja@linux.ibm.com, mst@redhat.com, david@redhat.com,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, pbonzini@redhat.com, sumanthk@linux.ibm.com,
 mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 10 Sep 2020 05:36:53 -0400
Collin Walling <walling@linux.ibm.com> wrote:

> As more features and facilities are added to the Read SCP Info (RSCPI)
> response, more space is required to store them. The space used to store
> these new features intrudes on the space originally used to store CPU
> entries. This means as more features and facilities are added to the
> RSCPI response, less space can be used to store CPU entries.
> 
> With the Extended-Length SCCB (ELS) facility, a KVM guest can execute
> the RSCPI command and determine if the SCCB is large enough to store a
> complete reponse. If it is not large enough, then the required length
> will be set in the SCCB header.
> 
> The caller of the SCLP command is responsible for creating a
> large-enough SCCB to store a complete response. Proper checking should
> be in place, and the caller should execute the command once-more with
> the large-enough SCCB.
> 
> This facility also enables an extended SCCB for the Read CPU Info
> (RCPUI) command.
> 
> When this facility is enabled, the boundary violation response cannot
> be a result from the RSCPI, RSCPI Forced, or RCPUI commands.
> 
> In order to tolerate kernels that do not yet have full support for this
> feature, a "fixed" offset to the start of the CPU Entries within the
> Read SCP Info struct is set to allow for the original 248 max entries
> when this feature is disabled.
> 
> Additionally, this is introduced as a CPU feature to protect the guest
> from migrating to a machine that does not support storing an extended
> SCCB. This could otherwise hinder the VM from being able to read all
> available CPU entries after migration (such as during re-ipl).
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>  hw/s390x/sclp.c                     | 43 +++++++++++++++++++++++++----
>  include/hw/s390x/sclp.h             |  1 +
>  target/s390x/cpu_features_def.h.inc |  1 +
>  target/s390x/gen-features.c         |  1 +
>  target/s390x/kvm.c                  |  8 ++++++
>  5 files changed, 48 insertions(+), 6 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>


