Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AA1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:17:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DF9E20718
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QdMIyAsc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF9E20718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iudIG-0007Aa-UC
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 09:17:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55281)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iubpW-00072D-Fu
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:43:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iubpV-0005zt-4K
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:43:26 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47726
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iubpV-0005zc-14
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:43:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579783404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1mvNlkdHMr6sL5nEhJl0+ns+8Pqn6o0rPsDf+cOjpAs=;
 b=QdMIyAsckHTrGZWsbfTUcJC49hFl0JaK7D4mP+/QN42Kl6an1AZtOzOUUOw7i09DaXI4u1
 32r0KbZQfG6MkoIN9zNXRVT0/YvzaTNvmjBeHOWBI04qZtrpweApVv9kSkGiYjs7DrnsHC
 bC81R/edQ0qP9eoTKsIk3RyjifCOMZ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-ZuMgadEBNoepwwChkED6Dg-1; Thu, 23 Jan 2020 07:43:20 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84D18800D48;
 Thu, 23 Jan 2020 12:43:19 +0000 (UTC)
Received: from [10.3.117.16] (ovpn-117-16.phx2.redhat.com [10.3.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AC7485C1BB;
 Thu, 23 Jan 2020 12:43:16 +0000 (UTC)
Subject: Re: [PATCH 1/3] qemu-nbd: Convert invocation documentation to rST
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200116141511.16849-1-peter.maydell@linaro.org>
 <20200116141511.16849-2-peter.maydell@linaro.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c14e6614-4411-e4d1-daab-626e575450fb@redhat.com>
Date: Thu, 23 Jan 2020 06:43:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200116141511.16849-2-peter.maydell@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: ZuMgadEBNoepwwChkED6Dg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/16/20 8:15 AM, Peter Maydell wrote:
> The qemu-nbd documentation is currently in qemu-nbd.texi in Texinfo
> format, which we present to the user as:
>   * a qemu-nbd manpage
>   * a section of the main qemu-doc HTML documentation
> 
> Convert the documentation to rST format, and present it to the user as:
>   * a qemu-nbd manpage
>   * part of the interop/ Sphinx manual
> 

As I have now posted a patch that conflicts with this 
(https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg05118.html), 
and it needs a v2, I'm happy to do my rebase on top of this series, and 
stage these patches through my NBD tree if they don't land on master 
sooner via another path.

> 
> v1->v2:
>   * avoided some long lines in the Makefile
> ---
>   Makefile                               |  16 +-
>   MAINTAINERS                            |   1 +
>   docs/interop/conf.py                   |   4 +-
>   docs/interop/index.rst                 |   1 +
>   docs/interop/qemu-nbd.rst              | 263 +++++++++++++++++++++++++
>   docs/interop/qemu-option-trace.rst.inc |  30 +++
>   qemu-doc.texi                          |   6 -
>   qemu-nbd.texi                          | 214 --------------------
>   qemu-option-trace.texi                 |   4 +
>   9 files changed, 313 insertions(+), 226 deletions(-)
>   create mode 100644 docs/interop/qemu-nbd.rst
>   create mode 100644 docs/interop/qemu-option-trace.rst.inc
>   delete mode 100644 qemu-nbd.texi
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


