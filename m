Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013A0C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 05:30:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA78F20717
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 05:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA78F20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54880 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYkzI-000680-5H
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 01:30:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hYkyZ-0005mc-UF
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 01:30:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hYkyZ-0006rN-0X
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 01:30:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41620)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hYkyY-0006pN-RF
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 01:30:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DBCB5C18B2CA;
	Thu,  6 Jun 2019 05:30:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A24B86606F;
	Thu,  6 Jun 2019 05:30:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 16F9F11386A0; Thu,  6 Jun 2019 07:30:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "H. Peter Anvin" <hpa@zytor.com>
References: <6364a057-23ab-db7f-cb2c-ccff70fb7aed@zytor.com>
	<aaf15ebe-7442-2e25-d533-c40c2e2df8cb@zytor.com>
Date: Thu, 06 Jun 2019 07:30:08 +0200
In-Reply-To: <aaf15ebe-7442-2e25-d533-c40c2e2df8cb@zytor.com> (H. Peter
	Anvin's message of "Wed, 5 Jun 2019 13:46:48 -0700")
Message-ID: <87ef47jn6n.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Thu, 06 Jun 2019 05:30:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Qemu baseline requirements/portability?
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"H. Peter Anvin" <hpa@zytor.com> writes:

> On 6/5/19 12:55 PM, H. Peter Anvin wrote:
>> Hi,
>> 
>> I am writing some code I'm hoping will be able to make it into Qemu, but I
>> can't seem to find what the baseline portability requirements are.  I'm
>> specifically wondering about newer POSIX features like openat(), which seems
>> to be used in the 9p filesystem and nowhere else, and what version of glib one
>> can rely on?
>> 
>
> Specifically, I'm trying to satisfy a 10-year-old request by me and others to
> support composite initrd during Linux boot.

Please peruse qemu-doc.texi @appendix Supported build platforms.  If it
doesn't fully answer your question, ask for clarification here.

