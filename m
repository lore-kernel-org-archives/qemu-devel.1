Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB8BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:40:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8225720773
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AHU94Y1S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8225720773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joPJQ-0004L0-DY
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 06:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1joPIF-00038e-Ri
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:39:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41058
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1joPIE-0003wQ-4g
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593081581;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NteMtL0MD3KIE074ggwyRQ3cXgmwcH4ws/J0fRIOSu8=;
 b=AHU94Y1SAeP24Hu9/Vm80KXfW/cR6ZZlSuZXfG7wVS4wLRjU9vg1pGcEf0NEELdLLDqa1/
 f+cjxbzZk0Ps5ciIbh4+5Ii6AsTtPLUl0KrpQv5LnlRwQQVWNtnXKUgJEnsPfhoMQ94dX/
 Drvk3Sh7cvxQFhjeWjATx5wzdFyca48=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-HetRBGTjOqy8h0Dvmh9ryA-1; Thu, 25 Jun 2020 06:39:39 -0400
X-MC-Unique: HetRBGTjOqy8h0Dvmh9ryA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FBF7107ACCA;
 Thu, 25 Jun 2020 10:39:38 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 138A11010428;
 Thu, 25 Jun 2020 10:39:27 +0000 (UTC)
Date: Thu, 25 Jun 2020 11:39:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC 0/4] Enable virtio-fs on s390x
Message-ID: <20200625103924.GH1009994@redhat.com>
References: <20200625100430.22407-1-mhartmay@linux.ibm.com>
 <20200625101935.GF1009994@redhat.com>
 <20200625123136.2c3c0ebe.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200625123136.2c3c0ebe.cohuck@redhat.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>, Marc Hartmayer <mhartmay@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 25, 2020 at 12:31:36PM +0200, Cornelia Huck wrote:
> On Thu, 25 Jun 2020 11:19:35 +0100
> Daniel P. Berrangé <berrange@redhat.com> wrote:
> 
> > On Thu, Jun 25, 2020 at 12:04:26PM +0200, Marc Hartmayer wrote:
> > > This RFC is about enabling virtio-fs on s390x. For that we need
> > >  + some shim code (first patch), and we need
> > >  + libvhost-user to deal with virtio endiannes as mandated by the spec.
> > >  
> > > The second part is trickier, because unlike QEMU we are not certain
> > > about the guest's native endianness, which is needed to handle the
> > > legacy-interface appropriately. In fact, this is the reason why just
> > > RFC.
> > > 
> > > One of the open questions is whether to build separate versions, one
> > > for guest little endian and one for guest big endian, or do we want
> > > something like a command line option? (Digression on the libvirt
> > > modeling)  
> > 
> > When you talk about  big vs little endian, are you referring to TCG
> > scenarios with mixed host/guest arch, or arches which can support
> > either endianess, or both ? i guess it doesn't matter actually, as
> > I think the latter forces a specific answer.
> > 
> > Considering that some architectures allow the guest OS to flip between
> > big & little endian as they boot, libvirt cannot know what endianess
> > the guest is using when it launches virtiofsd. It thus cannot pick
> > between two different endianness builds of virtiofsd automatically.
> > This would force the user to tell libvirt what arch the guest is using
> > at the time they define the guest. This is an undesirable restriction
> > for use cases where the admin of the guest OS has no direct control
> > over the host config.
> 
> Right, but that is in practice only a problem for legacy devices, isn't
> it? The standard says that non-legacy devices use little-endian
> everywhere; it's the legacy 'device endian' that is causing us
> headaches.
> 
> Which leads to the question: Do we really need to support legacy
> virtio-fs devices, or can we just force virtio-1, as many (most?) newer
> virtio devices do?

I'd hope virtio-fs is already forced to modern only, as there's no legacy
PCI ID assigned to it in the spec.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


