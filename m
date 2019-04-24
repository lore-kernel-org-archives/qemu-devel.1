Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7831FC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 08:35:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B0602148D
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 08:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B0602148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37945 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJDNf-0001He-G8
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 04:35:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1hJDLq-0008Ch-1Q
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 04:33:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1hJDBh-0004Ev-Ls
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 04:23:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1hJDBW-00044C-1W
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 04:23:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C68A68E5A4;
	Wed, 24 Apr 2019 08:23:08 +0000 (UTC)
Received: from [10.43.2.30] (unknown [10.43.2.30])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AC1F5646CA;
	Wed, 24 Apr 2019 08:23:07 +0000 (UTC)
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20190423212246.3542-1-ehabkost@redhat.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <6d2f330c-dcff-52d5-52c8-92f152f97e2b@redhat.com>
Date: Wed, 24 Apr 2019 10:23:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423212246.3542-1-ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Wed, 24 Apr 2019 08:23:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/3] Export machine type deprecation info
 through QMP
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424082306.xoXvPHNgxh1A4TN5aFiJgZ7MGfLJqfDg1PX90lGihr8@z>

On 4/23/19 11:22 PM, Eduardo Habkost wrote:
> This series adds machine type deprecation information to the
> output of the `query-machines` QMP command.  With this, libvirt
> and management software will be able to show this information to
> users and/or suggest changes to VM configuration to avoid
> deprecated machine types.
> 
> Eduardo Habkost (3):
>    qapi: SupportStatusInfo struct
>    machine: Use SupportStatusInfo for deprecation info
>    qmp: Add deprecation information to query-machines
> 
>   qapi/common.json                   | 24 ++++++++++++++++++++++++
>   qapi/misc.json                     |  5 ++++-
>   include/hw/boards.h                |  7 ++++---
>   hw/i386/pc_piix.c                  |  4 +++-
>   hw/ppc/prep.c                      |  4 +++-
>   vl.c                               | 19 +++++++++++++++----
>   tests/acceptance/query_machines.py | 27 +++++++++++++++++++++++++++
>   7 files changed, 80 insertions(+), 10 deletions(-)
>   create mode 100644 tests/acceptance/query_machines.py
> 

ACK.

Now we need to think how to deal with this in libvirt. Whether it's 
sufficient to expose this in capabilities XML or libvirt needs to do 
something more.

Michal

