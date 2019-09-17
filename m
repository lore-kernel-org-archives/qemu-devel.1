Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38FAC4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 11:31:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8891721852
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 11:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8891721852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iABhj-0003zZ-Fe
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 07:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55788)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iABgQ-00039S-B0
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:30:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iABgP-000098-AT
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:30:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33394)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1iABgG-0008Rg-KQ; Tue, 17 Sep 2019 07:30:00 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8F219300CB6E;
 Tue, 17 Sep 2019 11:29:59 +0000 (UTC)
Received: from gondolin (dhcp-192-230.str.redhat.com [10.33.192.230])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 55D5C1001B01;
 Tue, 17 Sep 2019 11:29:38 +0000 (UTC)
Date: Tue, 17 Sep 2019 13:29:36 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190917132936.7a2b9c95.cohuck@redhat.com>
In-Reply-To: <156871573833.196432.7906362695920387537.stgit@bahia.lan>
References: <156871562997.196432.17776290406203122029.stgit@bahia.lan>
 <156871573833.196432.7906362695920387537.stgit@bahia.lan>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 17 Sep 2019 11:29:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 17/17] checkpatch: Warn when errp is passed
 to error_append_hint()
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Eric Farman <farman@linux.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Yuval Shaia <yuval.shaia@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Kevin Wolf <kwolf@redhat.com>, "Daniel P.
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, qemu-s390x@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Sep 2019 12:22:18 +0200
Greg Kurz <groug@kaod.org> wrote:

> Passing errp from the argument list to error_append_hint()
> isn't recommended because it may cause unwanted behaviours
> when errp is equal to &error_fatal or &error_abort.
> 
> First, error_append_hint() aborts QEMU when passed either of
> those.
> 
> Second, consider the following:
> 
>     void foo(Error **errp)
>     {
>          error_setg(errp, "foo");
>          error_append_hint(errp, "Try bar\n");
>     }
> 
> error_setg() causes QEMU to exit or abort, and hints aren't
> added.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  scripts/checkpatch.pl |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index aa9a354a0e7e..17ce026282a6 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2902,6 +2902,10 @@ sub process {
>  		}
>  	}
>  

Maybe add a comment here?

# using errp is common practice, so that check should hopefully be enough

> +		if ($line =~ /error_append_hint\(errp/) {
> +		    WARN("suspicious errp passed to error_append_hint()\n" .

Add "(use a local error object)"?

> +			 $herecurr);
> +		}
>  # check for non-portable libc calls that have portable alternatives in QEMU
>  		if ($line =~ /\bffs\(/) {
>  			ERROR("use ctz32() instead of ffs()\n" . $herecurr);
> 


