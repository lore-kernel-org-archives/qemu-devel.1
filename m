Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0B6C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 19:38:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE06520758
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 19:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RHEcxika"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE06520758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbUXb-0007TB-7U
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 15:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jbUX2-00072X-DG
 for qemu-devel@nongnu.org; Wed, 20 May 2020 15:37:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24557
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jbUX1-0002wR-Lt
 for qemu-devel@nongnu.org; Wed, 20 May 2020 15:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590003454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=nRD8InT/OcADvRVBkUQEgDwm1zAKDV6Djr9GL+Blw8s=;
 b=RHEcxikaCLfTI1VHE/bwFp4sa/YgfZ4ppRsoVPsGpyqymvdNTZ13gXQmxeGTSDalSbesyW
 tjmTL8lLsGMtlx78scaD0lsDmEw/UGbmHE+9tO3cQFlGt2nmIwuMKll8A3/NWCK8zJnJBG
 1vL0Nt64dpT9RdmH4vm07dx9tYJeIB0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-Om00G_SDOw2Ono4nKrAY4w-1; Wed, 20 May 2020 15:37:31 -0400
X-MC-Unique: Om00G_SDOw2Ono4nKrAY4w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26F0C1800D42;
 Wed, 20 May 2020 19:37:30 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-114.ams2.redhat.com [10.36.112.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 81E1810640F5;
 Wed, 20 May 2020 19:37:25 +0000 (UTC)
Subject: Re: [PATCH v2 1/9] pc-bios: s390x: cio.c cleanup and compile fix
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200514123729.156283-1-frankja@linux.ibm.com>
 <20200514123729.156283-2-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8e57d1b7-7408-c2e8-a202-d9e394cf9810@redhat.com>
Date: Wed, 20 May 2020 21:37:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200514123729.156283-2-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 22:48:02
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/05/2020 14.37, Janosch Frank wrote:
> Let's initialize the structs at the beginning to ease reading and also
> zeroing all other fields. This also makes the compiler stop
> compalining about sense_id_ccw.flags being ored into when it's not
> initialized.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/cio.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)

With the nits mentioned by David fixed:

Reviewed-by: Thomas Huth <thuth@redhat.com>


