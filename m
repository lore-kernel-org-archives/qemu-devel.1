Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410B3C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 10:59:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ED40206DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 10:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED40206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46325 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEXQ4-0000Fc-Ei
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 06:59:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hEXOR-0007Xd-DP
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:57:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hEXOP-0006qz-GT
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:57:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hEXOJ-0004ws-Mk; Thu, 11 Apr 2019 06:57:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8418A3082E03;
	Thu, 11 Apr 2019 10:57:07 +0000 (UTC)
Received: from gondolin (ovpn-204-124.brq.redhat.com [10.40.204.124])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B36421062225;
	Thu, 11 Apr 2019 10:56:58 +0000 (UTC)
Date: Thu, 11 Apr 2019 12:56:55 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: <qemu-devel@nongnu.org>
Message-ID: <20190411125655.7feab799.cohuck@redhat.com>
In-Reply-To: <155497852263.12882.17138118894178379111@76452e4e88f2>
References: <20190411102025.22559-1-cohuck@redhat.com>
	<155497852263.12882.17138118894178379111@76452e4e88f2>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Thu, 11 Apr 2019 10:57:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.1] hw: add compat machines for 4.1
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, peter.maydell@linaro.org, ehabkost@redhat.com,
	mst@redhat.com, david@redhat.com, pasic@linux.ibm.com,
	borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
	qemu-arm@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com,
	david@gibson.dropbear.id.au, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411105655.1RGXn8tSnnfgbGrJTuDtS9S4fl0IQJsV1PC_W4S18pk@z>

On Thu, 11 Apr 2019 03:28:46 -0700 (PDT)
no-reply@patchew.org wrote:

> === OUTPUT BEGIN ===
> ERROR: spaces required around that '=' (ctx:WxV)
> #58: FILE: hw/i386/pc.c:118:
> +GlobalProperty pc_compat_4_0[] ={};
>                                 ^
> 
> total: 1 errors, 0 warnings, 160 lines checked

Yeah; trivial to fix by whoever applies this.

