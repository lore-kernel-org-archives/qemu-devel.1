Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FE1C10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 15:52:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A55DF2077C
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 15:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A55DF2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39180 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIbFL-00081E-G6
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 11:52:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jmoyer@redhat.com>) id 1hIbEW-0007i3-Rg
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 11:51:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jmoyer@redhat.com>) id 1hIbEV-0007Kq-Pl
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 11:51:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jmoyer@redhat.com>) id 1hIbEV-0007J7-IM
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 11:51:51 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A5B52C049E20;
	Mon, 22 Apr 2019 15:51:48 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com
	(segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 389081018A0D;
	Mon, 22 Apr 2019 15:51:36 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
References: <20190410040826.24371-1-pagupta@redhat.com>
	<20190410040826.24371-2-pagupta@redhat.com>
	<CAPcyv4i1FjBzfcWtzeCvj-giHa9xaX0dMQ==q4LZC_L8VEqkHg@mail.gmail.com>
	<20190412083230.GA29850@quack2.suse.cz>
	<x494l73z7th.fsf@segfault.boston.devel.redhat.com>
	<CAPcyv4jrNHqW3FuGkeo==ZoJr7LKahCv4_esnokfy7enek8=2Q@mail.gmail.com>
	<20190418161833.GA22970@infradead.org>
	<CAPcyv4jPOF_+R6U17J_+88+X8LC-LSPCugA6gbKxuphuuFB2gg@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Mon, 22 Apr 2019 11:51:35 -0400
In-Reply-To: <CAPcyv4jPOF_+R6U17J_+88+X8LC-LSPCugA6gbKxuphuuFB2gg@mail.gmail.com>
	(Dan Williams's message of "Thu, 18 Apr 2019 11:14:59 -0700")
Message-ID: <x497ebm82d4.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Mon, 22 Apr 2019 15:51:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 1/6] libnvdimm: nd_region flush callback
 support
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
Cc: Pankaj Gupta <pagupta@redhat.com>, cohuck@redhat.com,
	Jan Kara <jack@suse.cz>, KVM list <kvm@vger.kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, david <david@fromorbit.com>,
	Qemu Developers <qemu-devel@nongnu.org>,
	virtualization@lists.linux-foundation.org,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Ross Zwisler <zwisler@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>,
	linux-nvdimm <linux-nvdimm@lists.01.org>,
	Vishal L Verma <vishal.l.verma@intel.com>,
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	linux-ext4 <linux-ext4@vger.kernel.org>,
	Len Brown <lenb@kernel.org>, kilobyte@angband.pl,
	Rik van Riel <riel@surriel.com>, yuval shaia <yuval.shaia@oracle.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
	Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
	"Darrick J. Wong" <darrick.wong@oracle.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-xfs <linux-xfs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422155135.IzfDcQlzI1162gUDKWowYxM_WO4cYnN957expa5euT4@z>

Dan Williams <dan.j.williams@intel.com> writes:

> On Thu, Apr 18, 2019 at 9:18 AM Christoph Hellwig <hch@infradead.org> wrote:
>>
>> On Thu, Apr 18, 2019 at 09:05:05AM -0700, Dan Williams wrote:
>> > > > I'd either add a comment about avoiding retpoline overhead here or just
>> > > > make ->flush == NULL mean generic_nvdimm_flush(). Just so that people don't
>> > > > get confused by the code.
>> > >
>> > > Isn't this premature optimization?  I really don't like adding things
>> > > like this without some numbers to show it's worth it.
>> >
>> > I don't think it's premature given this optimization technique is
>> > already being deployed elsewhere, see:
>> >
>> > https://lwn.net/Articles/774347/
>>
>> For one this one was backed by numbers, and second after feedback
>> from Linux we switched to the NULL pointer check instead.
>
> Ok I should have noticed the switch to NULL pointer check. However,
> the question still stands do we want everyone to run numbers to
> justify this optimization, or make it a new common kernel coding
> practice to do:
>
>     if (!object->op)
>         generic_op(object);
>     else
>         object->op(object);
>
> ...in hot paths?

I don't think nvdimm_flush is a hot path.  Numbers of some
representative workload would prove one of us right.

-Jeff

