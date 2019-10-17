Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D405AECE58D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 21:30:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A51EA21A49
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 21:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51EA21A49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLDM8-0000PO-Qh
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 17:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iLDL9-0007io-07
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 17:29:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iLDL7-0001oQ-Ve
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 17:29:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41410)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>)
 id 1iLDL4-0001n1-B7; Thu, 17 Oct 2019 17:29:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DED233082A6C;
 Thu, 17 Oct 2019 21:29:40 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C3E505DC18;
 Thu, 17 Oct 2019 21:29:29 +0000 (UTC)
Date: Thu, 17 Oct 2019 18:29:27 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 00/10] image-fuzzer: Port to Python 3
Message-ID: <20191017212927.GI4084@habkost.net>
References: <20191016192430.25098-1-ehabkost@redhat.com>
 <318ecbf2-b077-1a5d-b7d5-a2fc1c9c1c96@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <318ecbf2-b077-1a5d-b7d5-a2fc1c9c1c96@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 17 Oct 2019 21:29:41 +0000 (UTC)
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 17, 2019 at 05:11:29PM -0400, John Snow wrote:
> 
> 
> On 10/16/19 3:24 PM, Eduardo Habkost wrote:
> > This series ports image-fuzzer to Python 3.
> > 
> > Eduardo Habkost (10):
> >   image-fuzzer: Open image files in binary mode
> >   image-fuzzer: Write bytes instead of string to image file
> >   image-fuzzer: Explicitly use integer division operator
> >   image-fuzzer: Use io.StringIO
> >   image-fuzzer: Use %r for all fiels at Field.__repr__()
> >   image-fuzzer: Return bytes objects on string fuzzing functions
> >   image-fuzzer: Use bytes constant for field values
> >   image-fuzzer: Encode file name and file format to bytes
> >   image-fuzzer: Run using python3
> >   image-fuzzer: Use errors parameter of subprocess.Popen()
> > 
> >  tests/image-fuzzer/qcow2/__init__.py |  1 -
> >  tests/image-fuzzer/qcow2/fuzz.py     | 54 +++++++++++++-------------
> >  tests/image-fuzzer/qcow2/layout.py   | 57 ++++++++++++++--------------
> >  tests/image-fuzzer/runner.py         | 12 +++---
> >  4 files changed, 61 insertions(+), 63 deletions(-)
> > 
> 
> When I gave my try at converting this to python3 I noticed that the
> "except OSError as e" segments used e[1] in a way that was not seemingly
> supported.
> 
> Did you fix that in this series or did I miss it?

Good catch, I hadn't noticed that.  I didn't fix it.

-- 
Eduardo

