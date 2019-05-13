Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93731C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 15:07:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5259B20879
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 15:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5259B20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58867 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQCXb-00066r-AH
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 11:06:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hQCWA-0005It-CV
	for qemu-devel@nongnu.org; Mon, 13 May 2019 11:05:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hQCW5-0001k4-Hj
	for qemu-devel@nongnu.org; Mon, 13 May 2019 11:05:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hQCW2-0001ZB-Uw; Mon, 13 May 2019 11:05:25 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2A032309B14E;
	Mon, 13 May 2019 15:05:14 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1432E19C6A;
	Mon, 13 May 2019 15:05:12 +0000 (UTC)
Date: Mon, 13 May 2019 17:05:10 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190513170510.51499cf6.cohuck@redhat.com>
In-Reply-To: <20190508094857.21145-1-thuth@redhat.com>
References: <20190508094857.21145-1-thuth@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Mon, 13 May 2019 15:05:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL SUBSYSTEM s390x 0/3] s390-ccw-bios: Skip
 bootmap signature entries
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
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
	qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed,  8 May 2019 11:48:54 +0200
Thomas Huth <thuth@redhat.com> wrote:

> This pull request is not for master.
> 
> 
>  Hi Cornelia,
> 
> the following changes since commit a6f6d24757a73f7176989134b97284a1a7df11e5:
> 
>   Merge remote-tracking branch 'remotes/kraxel/tags/vga-20190507-pull-request' into staging (2019-05-07 21:39:28 +0100)
> 
> are available in the Git repository at:
> 
>   https://gitlab.com/huth/qemu.git tags/s390-ccw-bios-2019-05-08
> 
> for you to fetch changes up to f7a339a5ba48a8a5c5bf4f1fdb1463bf8ac5f5bb:
> 
>   pc-bios/s390: Update firmware image with "Skip bootmap signature entries" fix (2019-05-08 11:26:01 +0200)
> 
> ----------------------------------------------------------------
> Skip unsupported bootmap signature entries instead of aborting the boot process
> ----------------------------------------------------------------
> 
> Jason J. Herne (1):
>       s390-bios: Skip bootmap signature entries
> 
> Markus Armbruster (1):
>       pc-bios/s390-ccw: Clean up harmless misuse of isdigit()
> 
> Thomas Huth (1):
>       pc-bios/s390: Update firmware image with "Skip bootmap signature entries" fix
> 
>  pc-bios/s390-ccw.img       | Bin 42608 -> 42608 bytes
>  pc-bios/s390-ccw/bootmap.c |  19 +++++++++++++++++--
>  pc-bios/s390-ccw/bootmap.h |  10 ++++++----
>  pc-bios/s390-ccw/libc.c    |   2 +-
>  pc-bios/s390-ccw/menu.c    |   2 +-
>  5 files changed, 25 insertions(+), 8 deletions(-)

Thanks, pulled.

