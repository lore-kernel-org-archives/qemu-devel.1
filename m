Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35FAC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 06:39:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F55F22211
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 06:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gWQx6srO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F55F22211
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGGF5-0006eo-BM
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 02:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kGGEX-0006C2-Ig
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 02:39:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54621
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kGGEW-0007L6-09
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 02:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599719939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dYJYn4ZAsa1PkqNfb3ooiN3cbtmoG7pPD18yS1NIJaw=;
 b=gWQx6srOa12KsQDYr/6HmpaBkIosHAqwbmJHATFwcj+wBYbbUybbDDmSc5dbnpwmZ6OEag
 XwmF4ubIDI21f82M5oBCmkl3NNnAWc4gjn1hAsplRoHmgNywGzDnG4U7aO0vgobda9qMmg
 Y32vIfwb8u5hr/hMRNFb35TXRwhXMdk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-Mfxahlb7MXSeAc_35Yr2ug-1; Thu, 10 Sep 2020 02:38:55 -0400
X-MC-Unique: Mfxahlb7MXSeAc_35Yr2ug-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E25C21DE0A;
 Thu, 10 Sep 2020 06:38:53 +0000 (UTC)
Received: from gondolin (ovpn-112-225.ams2.redhat.com [10.36.112.225])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A7B935D9E8;
 Thu, 10 Sep 2020 06:38:44 +0000 (UTC)
Date: Thu, 10 Sep 2020 08:38:42 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Collin Walling <walling@linux.ibm.com>
Subject: Re: [PATCH v4 0/8] s390: Extended-Length SCCB & DIAGNOSE 0x318
Message-ID: <20200910083842.4eed4821.cohuck@redhat.com>
In-Reply-To: <22005476-9a22-f3b1-4c92-fff9fbb2e11d@linux.ibm.com>
References: <20200624202312.28349-1-walling@linux.ibm.com>
 <b1d68acf-881f-be0f-c1ac-d32b8bfc859d@linux.ibm.com>
 <20200715180409.451d217e.cohuck@redhat.com>
 <d59bd0a5-0660-0c22-09dd-018be6dfe74f@linux.ibm.com>
 <20200716140214.3fdc7590.cohuck@redhat.com>
 <42dde86f-2f12-3b89-0c35-74d69fa3d449@de.ibm.com>
 <20200909104623.57664738.cohuck@redhat.com>
 <20200909114351.1f91f330.cohuck@redhat.com>
 <22005476-9a22-f3b1-4c92-fff9fbb2e11d@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 01:44:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: thuth@redhat.com, frankja@linux.ibm.com, david@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, pasic@linux.ibm.com,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 svens@linux.ibm.com, pbonzini@redhat.com, mihajlov@linux.ibm.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 9 Sep 2020 14:13:55 -0400
Collin Walling <walling@linux.ibm.com> wrote:

> Has this been merged yet? There is one patch that I neglected to include
> in this series (I didn't realize it until now) that properly sets the
> SCCB size in QEMU based on the length provided by the kernel (right now,
> these patches allocate a static 4K size for the SCCB struct, which
> causes a segfault).
> 
> I can post my set with the fix as v5, or I can wait and post the fix as
> a bandaid if the patches are already in.
> 

It's queued on s390-next right now, I can still update it.

Is that really an extra patch, or something that can be merged into the
series? If the latter, I'd prefer a v5, if the former, I'd just queue
that patch on top.


