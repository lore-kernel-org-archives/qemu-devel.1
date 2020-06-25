Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9DAC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:11:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06BEA20781
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IyCSrSid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06BEA20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joPnO-0007WB-A3
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 07:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1joPjN-0002ig-D5
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 07:07:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23690
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1joPjK-0005Kz-8A
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 07:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593083261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sUNR9iFSc/W7nU2FdMpN/+GfP+4pozTsDruUiRLnxCs=;
 b=IyCSrSid5Sg3nfB2TGs3SnsifodVdGeZsJ23MLCKCUlL4lRoTHLm8+HVI3WYVvohRdWSa9
 RLvoIt7msrH9URf11BbMZd9eTT5jwT5EchOfc7bvOZIfsoDSedbToUYIlEugYKE2RAGrCI
 T0USQpS7TVOxzjsYJl6Yqtka4Yz5pEM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-xuCgryIRMtmKLh0TzAlQCQ-1; Thu, 25 Jun 2020 07:07:30 -0400
X-MC-Unique: xuCgryIRMtmKLh0TzAlQCQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 161CE800C60;
 Thu, 25 Jun 2020 11:07:29 +0000 (UTC)
Received: from work-vm (ovpn-114-254.ams2.redhat.com [10.36.114.254])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D99CC612BA;
 Thu, 25 Jun 2020 11:07:18 +0000 (UTC)
Date: Thu, 25 Jun 2020 12:07:16 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [RFC 0/4] Enable virtio-fs on s390x
Message-ID: <20200625110716.GA2659@work-vm>
References: <20200625100430.22407-1-mhartmay@linux.ibm.com>
 <20200625101935.GF1009994@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200625101935.GF1009994@redhat.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel P. Berrangé (berrange@redhat.com) wrote:
> On Thu, Jun 25, 2020 at 12:04:26PM +0200, Marc Hartmayer wrote:
> > This RFC is about enabling virtio-fs on s390x. For that we need
> >  + some shim code (first patch), and we need
> >  + libvhost-user to deal with virtio endiannes as mandated by the spec.
> >  
> > The second part is trickier, because unlike QEMU we are not certain
> > about the guest's native endianness, which is needed to handle the
> > legacy-interface appropriately. In fact, this is the reason why just
> > RFC.
> > 
> > One of the open questions is whether to build separate versions, one
> > for guest little endian and one for guest big endian, or do we want
> > something like a command line option? (Digression on the libvirt
> > modeling)
> 
> When you talk about  big vs little endian, are you referring to TCG
> scenarios with mixed host/guest arch, or arches which can support
> either endianess, or both ? i guess it doesn't matter actually, as
> I think the latter forces a specific answer.
> 
> Considering that some architectures allow the guest OS to flip between
> big & little endian as they boot, libvirt cannot know what endianess
> the guest is using when it launches virtiofsd. It thus cannot pick
> between two different endianness builds of virtiofsd automatically.
> This would force the user to tell libvirt what arch the guest is using
> at the time they define the guest. This is an undesirable restriction
> for use cases where the admin of the guest OS has no direct control
> over the host config.
> 
> IOW, I think the only practical answer is to have a single binary that
> automagically does the right thing at runtime according to guest
> endianess that currently is in use.

Modifying the fuse code in virtiofsd to handle cross-endian would be a
big job;  IMHO unless you really have a cross-endian need I'd just make
sure it deals ok with big<->big and little<->little.

Dave

> Regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


