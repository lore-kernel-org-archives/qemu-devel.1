Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC99DC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 10:41:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C29D206B5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 10:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xy9Q/cDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C29D206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA9uq-0003Ti-QW
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 06:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kA9u1-0002Dh-AW
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 06:40:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22749
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kA9tx-00038P-4t
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 06:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598265630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+A6evpVCSTHV2YZ0pMLFCQA13iVdE/2LLf4WyYOz8hs=;
 b=Xy9Q/cDqwiZZxfjbRxT62XZpba09Ah3wT4eJ+5gNxqRsi4E22vpsKbeUtCHJpDC2b+Pp3Q
 UoHmQD+192wXU/jAuLpznN23kIHWHP+hJS+DH4Kc+vSAZXZbdVaRQYego14UG1qnObp+WP
 PfX2LePOU1IxaiAJOxbv8KW/ek8Okyk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-UjK6q6imNueuhC6OobWDVg-1; Mon, 24 Aug 2020 06:40:29 -0400
X-MC-Unique: UjK6q6imNueuhC6OobWDVg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F42818A225D;
 Mon, 24 Aug 2020 10:40:26 +0000 (UTC)
Received: from gondolin (ovpn-113-235.ams2.redhat.com [10.36.113.235])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AEA437D87C;
 Mon, 24 Aug 2020 10:40:09 +0000 (UTC)
Date: Mon, 24 Aug 2020 12:40:06 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: Suspicious QOM types without instance/class size
Message-ID: <20200824124006.3cfbdddd.cohuck@redhat.com>
In-Reply-To: <20200821210149.GN642093@habkost.net>
References: <20200820215529.GH642093@habkost.net>
 <20200821114335.2b100333.cohuck@redhat.com>
 <20200821210149.GN642093@habkost.net>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 03:41:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Cameron Esfahani <dirty@apple.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 21 Aug 2020 17:01:49 -0400
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Fri, Aug 21, 2020 at 11:43:35AM +0200, Cornelia Huck wrote:
> > On Thu, 20 Aug 2020 17:55:29 -0400
> > Eduardo Habkost <ehabkost@redhat.com> wrote:
> >   
> > > While trying to convert TypeInfo declarations to the new
> > > OBJECT_DECLARE* macros, I've stumbled on a few suspicious cases
> > > where instance_size or class_size is not set, despite having type
> > > checker macros that use a specific type.
> > > 
> > > The ones with "WARNING" are abstract types (maybe not serious if
> > > subclasses set the appropriate sizes).  The ones with "ERROR"
> > > don't seem to be abstract types.
> > > 
> > > ERROR: hw/s390x/virtio-ccw.c:1237:1: class_size should be set to sizeof(VirtioCcwBusClass)?
> > > ERROR: hw/virtio/virtio-pci.c:2101:1: class_size should be set to sizeof(VirtioPCIBusClass)?  
> > 
> > VirtioCcwBusClass and VirtioPCIBusClass are both simple typedefs of
> > VirtioBusClass (it's likely that I copied the ccw definition from the
> > pci one). virtio-mmio instead uses VirtioBusClass directly in its
> > checker macros.
> > 
> > I don't see a real reason for the typedefs, maybe ccw and pci should
> > use the mmio approach as well?  
> 
> I think it's OK to keep the typedefs if the code is consistent
> (i.e. we set instance_size and class_size just in case the
> typedefs are replaced by a real struct one day).

AFAIU, VirtioBusClass is providing functionality needed for all virtio
buses, and they should not need to add anything on top. We can however
try to make it safe, as it is only a line of code for both pci and ccw.

> 
> I'm not sure about the TYPE_VIRTIO_MMIO_BUS approach.  If the
> code just needs VirtioBusState or VirtioBusClass pointers, it can
> already use the VIRTIO_BUS* macros.

We could go ahead and ditch the bus-specific macros if there's no real
need for it. At least, I don't see a real need for *Class. OTOH, having
types and macros defined everywhere makes it more symmetric.

> 
> The OBJECT_DECLARE_TYPE macro Daniel sent expects each QOM type
> to have a separate struct being defined, which isn't true in many
> cases.  I'm considering removing the "typedef struct Foo Foo"
> lines from OBJECT_DECLARE_TYPE(), to make initial conversion
> easier.

Would be interesting to figure out the individual reasons why there's
no separate struct, just to make sure we're not operating from wrong
assumptions.


