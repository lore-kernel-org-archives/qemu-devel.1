Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2785EC28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 12:56:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2920208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 12:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2920208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53929 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVy8B-0008Fw-9k
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 08:56:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hVy79-0007hl-RI
	for qemu-devel@nongnu.org; Wed, 29 May 2019 08:55:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hVy77-0006Qm-RZ
	for qemu-devel@nongnu.org; Wed, 29 May 2019 08:55:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hVy77-0006PO-M4
	for qemu-devel@nongnu.org; Wed, 29 May 2019 08:55:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 97847EE566;
	Wed, 29 May 2019 12:55:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-250.ams2.redhat.com
	[10.36.117.250])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6354117AC2;
	Wed, 29 May 2019 12:55:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id E6B601138648; Wed, 29 May 2019 14:55:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Anthony PERARD <anthony.perard@citrix.com>
References: <87lfyqla7r.fsf@dusky.pond.sub.org>
	<20190529095823.GC2126@perard.uk.xensource.com>
Date: Wed, 29 May 2019 14:55:20 +0200
In-Reply-To: <20190529095823.GC2126@perard.uk.xensource.com> (Anthony PERARD's
	message of "Wed, 29 May 2019 10:58:23 +0100")
Message-ID: <87blzlfmiv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Wed, 29 May 2019 12:55:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Headers without multiple inclusion guards
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org,
	Paul Durrant <paul.durrant@citrix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Anthony PERARD <anthony.perard@citrix.com> writes:

> On Tue, May 28, 2019 at 08:12:24PM +0200, Markus Armbruster wrote:
>> Just in case: what's a multiple inclusion guard?  It's
>> 
>>     #ifndef UNIQUE_GUARD_SYMBOL_H
>>     #define UNIQUE_GUARD_SYMBOL_H
>>     ...
>>     #endif
>> 
>> with nothing but comments outside the conditional, so that the header
>> can safely be included more than once.
>
>
>> Guest CPU Cores (Xen):
>> ----------------------
>> 
>> X86
>> M: Stefano Stabellini <sstabellini@kernel.org>
>> M: Anthony Perard <anthony.perard@citrix.com>
>> M: Paul Durrant <paul.durrant@citrix.com>
>> include/hw/xen/io/ring.h
>
> That file does have a guard, it's __XEN_PUBLIC_IO_RING_H__
>
> Do you (or the checker) want it to be changed to XEN_PUBLIC_IO_RING_H ?

Yes.  I'll post a patch.

>> virtio-9p
>> M: Greg Kurz <groug@kaod.org>
>> hw/9pfs/xen-9pfs.h
>
> Stefano, is the missing inclusion guard was intentional? Otherwise, I
> can send a patch for it.

Sending a patch is okay, but telling me "unintential, please fix it
along with the other ones" is also okay :)

Thanks!

