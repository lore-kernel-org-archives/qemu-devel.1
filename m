Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C77C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 10:46:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88CA0206E2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 10:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="duQMVv00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88CA0206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTNka-0002x3-NE
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 06:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jTNh4-0007yY-0m
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 06:43:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jTNdd-0004Yw-1a
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 06:42:25 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49709
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jTNdc-0004Yi-KG
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 06:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588070331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/7NAWnNaoUlS7P4lX/0IlMVjObOSLq35HG7C8D10PDI=;
 b=duQMVv00Z2jACVbViMo0qXZwkunrEZZX31CZr0cFOmx1Qsj6mgvJa6UtfbPf4y3ShEFFTC
 0KrZIEq7OwL7CBQhb0SyCtyCxB0zAB0OkZuCqtH7qxZCvXW5yFNSxAGqBjSZG0kqWBDksG
 AmtsrPm/QilWoYz5CxLXJHcTgijk8+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-9jAzkI02P-WUWyIWSwXQLw-1; Tue, 28 Apr 2020 06:38:50 -0400
X-MC-Unique: 9jAzkI02P-WUWyIWSwXQLw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74A8280058A;
 Tue, 28 Apr 2020 10:38:48 +0000 (UTC)
Received: from gondolin (ovpn-112-178.ams2.redhat.com [10.36.112.178])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A982E600D2;
 Tue, 28 Apr 2020 10:38:43 +0000 (UTC)
Date: Tue, 28 Apr 2020 12:38:26 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 0/2] virt: Set tpm-tis-device ppi property to off by
 default
Message-ID: <20200428123826.1ec68e6c.cohuck@redhat.com>
In-Reply-To: <20200427143145.16251-1-eric.auger@redhat.com>
References: <20200427143145.16251-1-eric.auger@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:11:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, eric.auger.pro@gmail.com, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Apr 2020 16:31:43 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Instead of using a compat in the mach-virt machine to force
> PPI off for all virt machines (PPI not supported by the
> tpm-tis-device device), let's simply change the default value
> in the sysbus device.
> 
> Best Regards
> 
> Eric
> 
> Eric Auger (2):
>   tpm: tpm-tis-device: set PPI to false by default
>   hw/arm/virt: Remove the compat forcing tpm-tis-device PPI to off
> 
>  hw/arm/virt.c           | 5 -----
>  hw/tpm/tpm_tis_sysbus.c | 2 +-
>  2 files changed, 1 insertion(+), 6 deletions(-)
> 

I think we can apply the compat machines patch on top of these two
patches.

Q: Who will queue this and the machine types patch? It feels a bit
weird taking arm patches through the s390 tree :)


