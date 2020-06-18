Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC18C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 19:01:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BE10207DD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 19:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yn2++cOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE10207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlzn3-000199-JM
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 15:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jlzmL-0000Fg-V5
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 15:00:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35675
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jlzmJ-0006Ic-5s
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 15:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592506845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z9Up5KvxUZIXYZH5iKnQPZ9WUdFJDxaGOOrgo+PuAwo=;
 b=Yn2++cOG05uT2jBlCn+ltUQEaQ8XLF8OiX+CIkcFAqq4IzOCwiGIXD06hWysXOHaNLZ5Vn
 j/iQpbSIVjUaPwym7PgHR4774DJJxjCi8v8z4kT25DJMGmpiMqKfNaQOFRBzkHygdxOdkT
 8tK+qYGGnBl5n0XmcIBZJSS1XujAm94=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-YwNJNLf1NDKAyplnmjozsg-1; Thu, 18 Jun 2020 15:00:43 -0400
X-MC-Unique: YwNJNLf1NDKAyplnmjozsg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 379A81005512;
 Thu, 18 Jun 2020 19:00:42 +0000 (UTC)
Received: from work-vm (ovpn-114-205.ams2.redhat.com [10.36.114.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F13360BF4;
 Thu, 18 Jun 2020 19:00:35 +0000 (UTC)
Date: Thu, 18 Jun 2020 20:00:32 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH v25 QEMU 3/3] virtio-balloon: Replace
 free page hinting references to 'report' with 'hint'
Message-ID: <20200618190032.GH2769@work-vm>
References: <20200527041212.12700.60627.stgit@localhost.localdomain>
 <20200527041414.12700.50293.stgit@localhost.localdomain>
 <CAKgT0UdPC1s0c-wqsNc4x8DeZhtZQVMmLArWQ=Z345Mkof650Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKgT0UdPC1s0c-wqsNc4x8DeZhtZQVMmLArWQ=Z345Mkof650Q@mail.gmail.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:47:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Alexander Duyck (alexander.duyck@gmail.com) wrote:
> On Tue, May 26, 2020 at 9:14 PM Alexander Duyck
> <alexander.duyck@gmail.com> wrote:
> >
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > In an upcoming patch a feature named Free Page Reporting is about to be
> > added. In order to avoid any confusion we should drop the use of the word
> > 'report' when referring to Free Page Hinting. So what this patch does is go
> > through and replace all instances of 'report' with 'hint" when we are
> > referring to free page hinting.
> >
> > Acked-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > ---
> >  hw/virtio/virtio-balloon.c         |   78 ++++++++++++++++++------------------
> >  include/hw/virtio/virtio-balloon.h |   20 +++++----
> >  2 files changed, 49 insertions(+), 49 deletions(-)
> >
> > diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> > index 3e2ac1104b5f..dc15409b0bb6 100644
> > --- a/hw/virtio/virtio-balloon.c
> > +++ b/hw/virtio/virtio-balloon.c
> 
> ...
> 
> > @@ -817,14 +817,14 @@ static int virtio_balloon_post_load_device(void *opaque, int version_id)
> >      return 0;
> >  }
> >
> > -static const VMStateDescription vmstate_virtio_balloon_free_page_report = {
> > +static const VMStateDescription vmstate_virtio_balloon_free_page_hint = {
> >      .name = "virtio-balloon-device/free-page-report",
> >      .version_id = 1,
> >      .minimum_version_id = 1,
> >      .needed = virtio_balloon_free_page_support,
> >      .fields = (VMStateField[]) {
> > -        VMSTATE_UINT32(free_page_report_cmd_id, VirtIOBalloon),
> > -        VMSTATE_UINT32(free_page_report_status, VirtIOBalloon),
> > +        VMSTATE_UINT32(free_page_hint_cmd_id, VirtIOBalloon),
> > +        VMSTATE_UINT32(free_page_hint_status, VirtIOBalloon),
> >          VMSTATE_END_OF_LIST()
> >      }
> >  };
> 
> So I noticed this patch wasn't in the list of patches pulled, but that
> is probably for the best since I believe the change above might have
> broken migration as VMSTATE_UINT32 does a stringify on the first
> parameter.
> Any advice on how to address it, or should I just give up on renaming
> free_page_report_cmd_id and free_page_report_status?

The filed names never hit the wire; the migration format is trivial
binary, especially of things like integers - that lands as just 4 bytes
on the wire [ hopefully in the place where the destination expects to
receive them ].
You need to be careful of the names of top level vmstate devices, and
the names of subsections; I don't think any other naming is in the
stream.
(We've even done hacks in the past of converting a VMSTATE_UINT32 to a
pair of UINT16 )

Dave

> Looking at this I wonder why we even need to migrate these values? It
> seems like if we are completing a migration the cmd_id should always
> be "DONE" shouldn't it? It isn't as if we are going to migrate the
> hinting from one host to another. We will have to start over which is
> essentially the signal that the "DONE" value provides. Same thing for
> the status. We shouldn't be able to migrate unless both of these are
> already in the "DONE" state so if anything I wonder if we shouldn't
> have that as the initial state for the device and just drop the
> migration info.
> 
> Thanks.
> 
> - Alex
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


