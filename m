Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776B7C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 14:12:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46BD820850
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 14:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46BD820850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60473 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEDyC-0006wr-JA
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 10:12:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hEDxP-0006dA-0u
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:12:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hEDxN-0007mv-Sq
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:12:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hEDxN-0007lZ-Kk
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:12:05 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3C62F5F79B;
	Wed, 10 Apr 2019 14:12:03 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DE78461102;
	Wed, 10 Apr 2019 14:11:59 +0000 (UTC)
Date: Wed, 10 Apr 2019 16:11:58 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190410161158.7abaa745@redhat.com>
In-Reply-To: <20190410140153.GA2919@richard>
References: <1554822037-329838-1-git-send-email-imammedo@redhat.com>
	<20190410011231.GA29083@richard>
	<20190410110833.4db9721f@redhat.com>
	<20190410140153.GA2919@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Wed, 10 Apr 2019 14:12:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.1] q35: acpi: do not create dummy
 MCFG table
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410141158.hXCKgIVcR9AuzjXwxpJTpF1uI_wodPl_cEHkB6nDoQI@z>

On Wed, 10 Apr 2019 22:01:53 +0800
Wei Yang <richardw.yang@linux.intel.com> wrote:

> On Wed, Apr 10, 2019 at 11:08:33AM +0200, Igor Mammedov wrote:
> >On Wed, 10 Apr 2019 09:12:31 +0800
> >Wei Yang <richardw.yang@linux.intel.com> wrote:
> >  
> >> On Tue, Apr 09, 2019 at 05:00:37PM +0200, Igor Mammedov wrote:  
> >> >Dummy table (with signature "QEMU") creation came from original SeaBIOS
> >> >codebase. And QEMU would have to keep it around if there were Q35 machine
> >> >that depended on keeping ACPI tables blob constant size. Luckily there
> >> >were no versioned Q35 machine types before commit:
> >> >  (since 2.3) a1666142db acpi-build: make ROMs RAM blocks resizeable
> >> >which obsoleted need to keep ACPI tables blob the same size on source/destination.
> >> >    
> >> 
> >> I am not sure getting the "versioned Q35" correctly. Seems originally there is
> >> q35-1.4?
> >> 
> >> commit bf3caa3dc17552b323cec6831301a22cfc98ecd5
> >> Author: Paolo Bonzini <pbonzini@redhat.com>
> >> Date:   Fri Feb 8 14:06:15 2013 +0100
> >> 
> >>     pc: add compatibility machine types for 1.4
> >>     
> >>     Adds both pc-i440fx-1.4 and pc-q35-1.4.  
> >
> >current upstream has only pc-q35-2.4 as earliest versioned Q35
> >machine type (try to run: qemu-system-x86_64 -M help)  
> 
> Yes, I see those old type are removed. This means we don't want to support
> those old types, right? Because those old types can't be migrated to latest
> upstream qemu.

Exactly


