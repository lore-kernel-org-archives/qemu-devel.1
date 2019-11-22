Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F0DC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 12:11:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EB3920679
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 12:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eBdQ4VWC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EB3920679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY7mz-0000tR-DC
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 07:11:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iY7lv-0000DF-MM
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:10:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iY7lu-0002SX-9i
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:10:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55539
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iY7lu-0002Qq-6J
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:10:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574424644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9F9dMAl1LeVGNmr5lhZEgKailWrZLeiLIyUmVmYvttM=;
 b=eBdQ4VWCjfZ1fPOJQIdBuAOu8VznYnU88p+LPX8VkSLlMJQFQgLT/2vXC+t5JSSR+hJNRw
 aQ37e+320vJdiXc9hVGa3DPhgQQVsQdGsdPjd5f8DL6YnEcAzYkZuEhpYNq3a0hV0F54Bk
 LtnOvR8D2jLr/NmHUfWE08oGiewxsNA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-lUeWA11NMMipcXbgRDkfRQ-1; Fri, 22 Nov 2019 07:10:43 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AAF810054E3;
 Fri, 22 Nov 2019 12:10:41 +0000 (UTC)
Received: from gondolin (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 01FD219C70;
 Fri, 22 Nov 2019 12:10:37 +0000 (UTC)
Date: Fri, 22 Nov 2019 13:10:35 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 4/4] s390x: Beautify machine reset
Message-ID: <20191122131035.4f334a99.cohuck@redhat.com>
In-Reply-To: <def970f9-6889-c8ed-0f6a-087e4cd3bd87@redhat.com>
References: <20191122075218.23935-1-frankja@linux.ibm.com>
 <20191122075218.23935-5-frankja@linux.ibm.com>
 <d026944f-1a0a-0dbe-6514-d8e4fd293e35@redhat.com>
 <c2459655-f205-3294-23ba-ba5d3280df41@linux.ibm.com>
 <def970f9-6889-c8ed-0f6a-087e4cd3bd87@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: lUeWA11NMMipcXbgRDkfRQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: thuth@redhat.com, Janosch Frank <frankja@linux.ibm.com>,
 pmorel@linux.ibm.com, qemu-devel@nongnu.org, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 22 Nov 2019 12:47:44 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 22.11.19 12:46, Janosch Frank wrote:
> > On 11/22/19 11:59 AM, David Hildenbrand wrote: =20
> >> On 22.11.19 08:52, Janosch Frank wrote: =20
> >>> * Add comments that tell you which diag308 subcode caused the reset
> >>> * Sort by diag308 reset subcode
> >>>
> >>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> >>> ---
> >>>    hw/s390x/s390-virtio-ccw.c | 20 ++++++++++----------
> >>>    1 file changed, 10 insertions(+), 10 deletions(-)
> >>>
> >>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> >>> index c1d1440272..88f7758721 100644
> >>> --- a/hw/s390x/s390-virtio-ccw.c
> >>> +++ b/hw/s390x/s390-virtio-ccw.c
> >>> @@ -330,15 +330,7 @@ static void s390_machine_reset(MachineState *mac=
hine)
> >>>        s390_cmma_reset();
> >>>   =20
> >>>        switch (reset_type) {
> >>> -    case S390_RESET_EXTERNAL:
> >>> -    case S390_RESET_REIPL:
> >>> -        qemu_devices_reset();
> >>> -        s390_crypto_reset();
> >>> -
> >>> -        /* configure and start the ipl CPU only */
> >>> -        run_on_cpu(cs, s390_do_cpu_ipl, RUN_ON_CPU_NULL);
> >>> -        break;
> >>> -    case S390_RESET_MODIFIED_CLEAR:
> >>> +    case S390_RESET_MODIFIED_CLEAR: /* Subcode 0 */ =20
> >>
> >> IMHO "Subcode X" isn't of much help here. We're out of diag handling.
> >>
> >> I'd suggest to just document the subcodes along with the definitions, =
if
> >> really needed, and drop this patch, at least I don't quite see the val=
ue
> >> of moving code around here... or is the code shuffling of any value on
> >> your prot virt patches?
> >> =20
> >=20
> > It keeps me from consulting the POP every time I need to change things
> > in the machine resets. This is basically a 1:1 mapping of diag 308
> > subcodes to machine resets, so why don't we want to make that obvious
> > and order them by the subcodes?
> >  =20
>=20
> Because it is not a 1:1 mapping: S390_RESET_EXTERNAL
>=20

Tack the explanation onto the definitions of S390_RESET_, then?
Probably still quicker than consulting the POP :)


