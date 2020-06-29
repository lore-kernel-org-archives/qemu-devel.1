Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76944C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 13:08:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4303923D37
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 13:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="efsrFER2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4303923D37
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jptWd-00015x-HF
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 09:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jptVh-0008AS-EM
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 09:07:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53804
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jptVf-0003Ya-5x
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 09:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593436062;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=fjrgu/rKPkSQGiIvKKstHvKk/4pGFkNTm0bfc+qOU1I=;
 b=efsrFER2zo6Et/F3xcyH6r5Zqs6yxP7RMOiRw788W1FJCmTPqsl2BOQkftNT7pyTv+qccM
 PnsZYNlacZtLOm/GogXbtStFm0Bu841HihkK6KAFxNpzrg5luUKeXWVb5wVmEkgYipWAjS
 J+hoomc22W3Ue880JOd5aUP3yZFCjQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-MTiy4FOtOmSEEQGFmPexGA-1; Mon, 29 Jun 2020 09:07:32 -0400
X-MC-Unique: MTiy4FOtOmSEEQGFmPexGA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A89B1800D42;
 Mon, 29 Jun 2020 13:07:31 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D98427168E;
 Mon, 29 Jun 2020 13:07:19 +0000 (UTC)
Date: Mon, 29 Jun 2020 14:07:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC 0/4] Enable virtio-fs on s390x
Message-ID: <20200629130716.GQ1298906@redhat.com>
References: <20200625100430.22407-1-mhartmay@linux.ibm.com>
 <20200629125305.GH31392@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200629125305.GH31392@stefanha-x1.localdomain>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:06:01
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 29, 2020 at 01:53:05PM +0100, Stefan Hajnoczi wrote:
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
> > 
> > A third option would be to refuse legacy altogether.
> 
> I suggest the following:
> 
> 1. Combinations that worked with libvhost-user in the past must not break.
> 
> 2. New combinations should only support VIRTIO 1.0 and later.
> 
> This means continue to allow Legacy mode devices where they already run
> today but don't add new code for the cases that didn't work.

What I'm missing here is what PCI product ID was being used when the
current impl is in legacy/transitional mode ?

Normally legacy and transitional mode devices need an explicit PCI ID
reserved, where as modern-only devices have a PCI ID derived from their
VirtIO ID + a fixed offset.

Was this mistakenly using a VirtIO ID + fixed offset for the legacy
mode too ?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


