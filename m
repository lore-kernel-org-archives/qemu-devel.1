Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B98C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 12:29:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A624722BED
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 12:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6TkPbtO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A624722BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2w4D-00063d-OM
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 08:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k2w3K-0005Xl-Sg
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 08:28:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52151
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k2w3I-0006bX-Ng
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 08:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596544099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sQ66LahJ77knGxx4GAUfWKyTqpSznjxAZBvtZHGZQGE=;
 b=b6TkPbtOg6OMupG+d42w0pv4HFa2gQu9OP6JcqACX3GNuo5eo/GZsJDliMzT2Dv9JP+P63
 1K6pj8vni2pv371f/VhjJBjNZwsbexJyHOH3ZJEIS+PKli3FptYhDd+X42lmzmxKd1ZzTY
 BRiwPmQM562fKx7sc4RhNrvh37y1AcQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-6kEXFYmoMb2S4osi_mL_8A-1; Tue, 04 Aug 2020 08:28:14 -0400
X-MC-Unique: 6kEXFYmoMb2S4osi_mL_8A-1
Received: by mail-qt1-f198.google.com with SMTP id k1so15285068qtp.20
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 05:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sQ66LahJ77knGxx4GAUfWKyTqpSznjxAZBvtZHGZQGE=;
 b=CV1TlqxK7ePG2WMesGsu2MntpWutLJgzp/GhKXFUfFwrSGrmKGNPoBJB/bnqE8GnyP
 d6+1jgtlIsvLrBS/L547oG52vBmnw3WqkWPNA1QA1KWdWxSd2waYOxtHbMniCTQX/nED
 qv3g10Z81pBB7Wx7IYK0FAl2MUwDUqqfJ0P9soovDSqWbwAeKXHWsGYNR/fUJRUoRtdG
 1aoPP1pUEU1yWBxuR3sk/W1N+/sM+jE/6A/cRVh+IX5tIlje8uXtC6qYp/0LZRrUC//x
 GQ6Rho1xIRKUeUxWH7IIay3RokPQcK8dMAs93kjrPb53aS64xLSX5ciluj3UzxnCMDLY
 62BA==
X-Gm-Message-State: AOAM5325eXY4HiG9rCeBwq1Ecgw2imvaA4pVj1ImzbJy7xRl5uujbR2f
 NI23TnjNGeL8+SVF1NbKNGakdeUBi2Ot3d3HojLH+dZLhrwoVBtmthhBBAa/6bZm4cvxkFZDUSm
 FS+hPK0uR5pUmZBI=
X-Received: by 2002:a37:a495:: with SMTP id
 n143mr21027911qke.330.1596544094021; 
 Tue, 04 Aug 2020 05:28:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqnU9kmXNA1/tRju27jPFLnNOxzDPg5SOtlz1Ydc5VzMWxUy2/pJ6h2dQIueuv2gfWWsredQ==
X-Received: by 2002:a37:a495:: with SMTP id
 n143mr21027891qke.330.1596544093797; 
 Tue, 04 Aug 2020 05:28:13 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id h81sm23603941qke.76.2020.08.04.05.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2020 05:28:13 -0700 (PDT)
Date: Tue, 4 Aug 2020 08:28:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 0/3] nvdimm: read-only file support
Message-ID: <20200804082756-mutt-send-email-mst@kernel.org>
References: <20200804101244.1283503-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200804101244.1283503-1-stefanha@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:23
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Julio Montes <julio.montes@intel.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 04, 2020 at 11:12:41AM +0100, Stefan Hajnoczi wrote:
> There is currently no way to back an NVDIMM with a read-only file so it can be
> safely shared between untrusted guests.
> 
> Introduce an -object memory-backend-file,readonly=on|off option.
> 
> Julio Montes sent an earlier patch here:
> https://patchew.org/QEMU/20190708211936.8037-1-julio.montes@intel.com/


makes sense:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Eric Ernst requested this feature again for Kata Containers so I gave it a try.
> 
> Stefan Hajnoczi (3):
>   memory: add readonly support to memory_region_init_ram_from_file()
>   hostmem-file: add readonly=on|off option
>   nvdimm: honor -object memory-backend-file,readonly=on option
> 
>  docs/nvdimm.txt           |  8 +++++++-
>  include/exec/memory.h     |  2 ++
>  include/exec/ram_addr.h   |  5 +++--
>  include/qemu/mmap-alloc.h |  2 ++
>  backends/hostmem-file.c   | 26 +++++++++++++++++++++++++-
>  exec.c                    | 18 +++++++++++-------
>  hw/mem/nvdimm.c           |  4 ++++
>  softmmu/memory.c          |  7 +++++--
>  util/mmap-alloc.c         | 10 ++++++----
>  util/oslib-posix.c        |  2 +-
>  qemu-options.hx           |  5 ++++-
>  11 files changed, 70 insertions(+), 19 deletions(-)
> 
> -- 
> 2.26.2
> 


