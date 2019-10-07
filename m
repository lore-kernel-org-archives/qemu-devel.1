Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B67DC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 06:47:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D575B20659
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 06:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D575B20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHMne-0003oQ-Vw
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 02:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1iHMmg-0003It-PT
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 02:46:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1iHMmf-0008Or-O1
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 02:46:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56998)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>)
 id 1iHMmc-0008LQ-NO; Mon, 07 Oct 2019 02:46:15 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 77539307D921;
 Mon,  7 Oct 2019 06:46:10 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.43.2.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DC4419C77;
 Mon,  7 Oct 2019 06:46:00 +0000 (UTC)
Date: Mon, 7 Oct 2019 08:45:58 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [libvirt] [PATCH 1/1] IDE: deprecate ide-drive
Message-ID: <20191007064558.GK6129@angien.pipo.sk>
References: <20191006203150.13054-1-jsnow@redhat.com>
 <20191006203150.13054-2-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191006203150.13054-2-jsnow@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Mon, 07 Oct 2019 06:46:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: libvir-list@redhat.com, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Oct 06, 2019 at 16:31:50 -0400, John Snow wrote:
> It's an old compatibility shim that just delegates to ide-cd or ide-hd.
> I'd like to refactor these some day, and getting rid of the super-object
> will make that easier.
> 
> Either way, we don't need this.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qemu-deprecated.texi          | 5 +++++
>  hw/ide/qdev.c                 | 3 +++
>  tests/qemu-iotests/051.pc.out | 6 ++++--
>  3 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 01245e0b1c4..f802d83983e 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -247,6 +247,11 @@ quite a bit. It will be removed without replacement unless some users speaks
>  up at the @email{qemu-devel@@nongnu.org} mailing list with information about
>  their usecases.
>  
> +@subsection ide-drive (since 4.2)
> +
> +The 'ide-drive' device is deprecated. Users should use 'ide-hd' or
> +'ide-cd' as appropriate to get an IDE hard disk or CDROM as needed.

In libvirt we don't use ide-drive any more for command line use since
libvirt-commit 'a4cda054e7' [0]

There is a capability named 'ide-drive.wwn', but this one is actually
probed from ide-hd along with other IDE-related capabilities since
libvirt-commit 'e67b6dcf361' [1].

There is also one test file that mentions ide-drive but that is actually
not referenced from any test code so I'll just delete it.

This means that libvirt is prepared for this deprecation so I guess you
can add a vanity-by:

Libvirt-checked-by: Peter Krempa <pkrempa@redhat.com>

[0] https://libvirt.org/git/?p=libvirt.git;a=commit;h=a4cda054e7
[1] https://libvirt.org/git/?p=libvirt.git;a=commit;h=e67b6dcf361


