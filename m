Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B905C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 17:40:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41A8820674
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 17:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dO2zyo66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A8820674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaNHE-0003vA-Ce
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 13:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jaNG9-0003Dh-RW
 for qemu-devel@nongnu.org; Sun, 17 May 2020 13:39:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48281
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jaNG7-0001Ya-K2
 for qemu-devel@nongnu.org; Sun, 17 May 2020 13:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589737170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=L0vaPXfwIPaWYhGguDsb/91JRz3mAe32enNIkBGt2+g=;
 b=dO2zyo66F2pZW4Ilqjow2v/3TOmW+HyY4YAWg1EXSm9ndj/Cc72eUOpdh8q3uuSdF8JSh8
 tEykGDVdXVFpPqrKrlvCTX8fUJiw1KiCpvKX9jfaQVSqJGyAPUXiwEayKSxM/s5U+obx+U
 47ZiR8Qqbd2Tt0aZjxo46lREg1GaDDU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-3rbBTuMMOxCZe51wwzEmUw-1; Sun, 17 May 2020 13:39:28 -0400
X-MC-Unique: 3rbBTuMMOxCZe51wwzEmUw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 415368014D7;
 Sun, 17 May 2020 17:39:27 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-98.ams2.redhat.com [10.36.112.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 90D175C1D6;
 Sun, 17 May 2020 17:39:26 +0000 (UTC)
Subject: Re: [PATCH v2 1/3] docs/s390x: document the virtual css
To: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org
References: <20200515151518.83950-1-cohuck@redhat.com>
 <20200515151518.83950-2-cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <df4ae06b-5401-c0f3-415e-89dc9cdefc67@redhat.com>
Date: Sun, 17 May 2020 19:39:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200515151518.83950-2-cohuck@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 13:23:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/05/2020 17.15, Cornelia Huck wrote:
> Add some hints about "devno" rules.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  docs/system/s390x/css.rst    | 86 ++++++++++++++++++++++++++++++++++++
>  docs/system/target-s390x.rst |  1 +
>  2 files changed, 87 insertions(+)
>  create mode 100644 docs/system/s390x/css.rst
[...]
> +if the guest OS does not enable MCSS-E (which is true of all
supported guest

Maybe s/true of/true for/ ? Not sure, your English is normally better
than mine ;-)

Anyway,
Reviewed-by: Thomas Huth <thuth@redhat.com>


