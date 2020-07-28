Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E7AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 11:34:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA1E12065C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 11:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gUulohZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1E12065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0NsK-0003fH-Uy
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 07:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k0Nre-0002og-GV
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 07:33:46 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50636
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k0Nrb-0001zN-Qt
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 07:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595936022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TN6EVbDkjMwiXUpwGRGA+WTEiWtGwkWFTbVIE2ImSGs=;
 b=gUulohZ6UtmJU04zDNILnbk3YDFE9ElcysyGDH6sfmYvwDa5gIII63QNBjHmUrS21gRkKT
 Sel8NCi95/OkLQbJfAkDR6itDsjXmmvwdOVJ24COi2ufcRdDIWHHcAbYLPshluPSdwjOwB
 Hb2DPzD+sAn/hrcbBcF3BL8puLAdfvw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322--dtwJaInOzqTihHhTi8aFA-1; Tue, 28 Jul 2020 07:33:40 -0400
X-MC-Unique: -dtwJaInOzqTihHhTi8aFA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B71F80BCAC;
 Tue, 28 Jul 2020 11:33:39 +0000 (UTC)
Received: from gondolin (ovpn-113-21.ams2.redhat.com [10.36.113.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 65A2190E90;
 Tue, 28 Jul 2020 11:33:21 +0000 (UTC)
Date: Tue, 28 Jul 2020 13:33:18 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC v2 1/3] virtio: add vhost-user-fs-ccw device
Message-ID: <20200728133318.73dced6f.cohuck@redhat.com>
In-Reply-To: <20200728132557.3cbef52f.pasic@linux.ibm.com>
References: <20200717092929.19453-1-mhartmay@linux.ibm.com>
 <20200717092929.19453-2-mhartmay@linux.ibm.com>
 <20200728123151.468c252b.cohuck@redhat.com>
 <20200728132557.3cbef52f.pasic@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 06:02:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: "Daniel P. =?UTF-8?B?QmVycmFu?=
 =?UTF-8?B?Z8Op?=" <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jul 2020 13:25:57 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Tue, 28 Jul 2020 12:31:51 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Fri, 17 Jul 2020 11:29:27 +0200
> > Marc Hartmayer <mhartmay@linux.ibm.com> wrote:
> >   
> > > From: Halil Pasic <pasic@linux.ibm.com>
> > > 
> > > Wire up the CCW device for vhost-user-fs.
> > > 
> > > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > > ---
> > >  hw/s390x/Makefile.objs       |  1 +
> > >  hw/s390x/vhost-user-fs-ccw.c | 73 ++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 74 insertions(+)
> > >  create mode 100644 hw/s390x/vhost-user-fs-ccw.c

(...)

> > > +static void vhost_user_fs_ccw_instance_init(Object *obj)
> > > +{
> > > +    VHostUserFSCcw *dev = VHOST_USER_FS_CCW(obj);
> > > +  
> > 
> > This needs
> > 
> >     ccw_dev->force_revision_1 = true;
> >   
> 
> I'm OK with that as well. Just out of curiosity, why do we need it? Is
> there a virtio-ccw revision 1 feature this device inherently needs?

Yes, the VERSION_1 feature :)

(All newer virtio devices are virtio-1 only, and the code has recently
started enforcing this.)


