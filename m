Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCD9C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 15:26:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80655206E2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 15:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dAxLli23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80655206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeguI-00036Y-Mw
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 11:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jegtV-0002Hy-Eu
 for qemu-devel@nongnu.org; Fri, 29 May 2020 11:26:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28959
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jegtU-0006nd-NO
 for qemu-devel@nongnu.org; Fri, 29 May 2020 11:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590765959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hlg8d7yAh/DNOBmoemRHdqq9vVEqD0noE+Nhs983eAY=;
 b=dAxLli23e5d7JYcxWADkwZ/uByxfOxWvSfnUGXcUfvMPPG14jeXsMWtlECLKC/aRooZ8YF
 Y440l0FsCiS0Fe/zL1MavvFDtjVVo4kPj+VDlUK1RgtNRKa8qoIiwZMbLfF+gjWaCdRuhB
 Tw9ed+Xa5DrrHrO2+4mN7o28IrBq43Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-ws7xPuzsMjy43SW2XCOvQw-1; Fri, 29 May 2020 11:25:57 -0400
X-MC-Unique: ws7xPuzsMjy43SW2XCOvQw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7728B1054F8F;
 Fri, 29 May 2020 15:25:56 +0000 (UTC)
Received: from localhost (unknown [10.40.208.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A792A60BF1;
 Fri, 29 May 2020 15:25:54 +0000 (UTC)
Date: Fri, 29 May 2020 17:25:50 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>
Subject: Re: [PATCH 1/3] qapi: Make @associativity, @policy and @line of
 NumaHmatCacheOptions optional
Message-ID: <20200529172550.02282a62@redhat.com>
In-Reply-To: <196dfb8cf7e71ea13c70da12a7c2dfcd1672c958.1590753455.git.mprivozn@redhat.com>
References: <cover.1590753455.git.mprivozn@redhat.com>
 <196dfb8cf7e71ea13c70da12a7c2dfcd1672c958.1590753455.git.mprivozn@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 23:43:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: jingqi.liu@intel.com, tao3.xu@intel.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 29 May 2020 15:33:46 +0200
Michal Privoznik <mprivozn@redhat.com> wrote:

> The documentation to `-numa hmat-cache` says that @node-id, @size
> and @level are the only required attributes. The rest
> (@associativity, @policy and @line) is optional. Well, not quite
> - if I try to start QEMU with only the three required attributes
> defined the QAPI code is complaining about associativity missing.

indeed, they are marked as optional CLI arguments but we don't have
a code that would make them as optional. And I'd prefer docs fixed
instead of introducing default values handling here.


> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
>  qapi/machine.json | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/qapi/machine.json b/qapi/machine.json
> index ff7b5032e3..952784f8ba 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -723,9 +723,9 @@
>     'node-id': 'uint32',
>     'size': 'size',
>     'level': 'uint8',
> -   'associativity': 'HmatCacheAssociativity',
> -   'policy': 'HmatCacheWritePolicy',
> -   'line': 'uint16' }}
> +   '*associativity': 'HmatCacheAssociativity',
> +   '*policy': 'HmatCacheWritePolicy',
> +   '*line': 'uint16' }}
>  
>  ##
>  # @HostMemPolicy:


