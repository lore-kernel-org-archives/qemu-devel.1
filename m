Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19453C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:21:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D43BC2075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GbFllE/K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43BC2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb43K-0004Vw-0q
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 11:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jb3fb-0002dw-HE
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:56:39 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52220
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jb3fZ-0003cO-9E
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589900196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g7sznRWAeMw8hCddLs8RkqgjbvLii3Oxy6wCtC0neHk=;
 b=GbFllE/KC2Boo1ip1miUiwS0plzz1UUzM979vgHLrL17YzUfyvDm0OWzy8Zl+rHBewtB4V
 H9Ti93EeAxjno80b4rICJbakb/FihHacM38nnVYqnKeRUt/4AI46zIooa8F4OzsytdyACx
 uDSrb3lJsLNAws8GtbJ6qEfuWgBoI3w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-8WcL7Xx6MNqNgpFtgtn_Bg-1; Tue, 19 May 2020 10:56:34 -0400
X-MC-Unique: 8WcL7Xx6MNqNgpFtgtn_Bg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C599A1005510;
 Tue, 19 May 2020 14:56:33 +0000 (UTC)
Received: from gondolin (ovpn-112-229.ams2.redhat.com [10.36.112.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E41A360BEC;
 Tue, 19 May 2020 14:56:32 +0000 (UTC)
Date: Tue, 19 May 2020 16:56:30 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3] docs/s390x: document vfio-ccw
Message-ID: <20200519165630.4631bca0.cohuck@redhat.com>
In-Reply-To: <73ebd9a0-f173-efed-c9b1-1ec30ead90b3@redhat.com>
References: <20200518075522.97643-1-cohuck@redhat.com>
 <73ebd9a0-f173-efed-c9b1-1ec30ead90b3@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 00:34:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 19 May 2020 15:19:21 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 18/05/2020 09.55, Cornelia Huck wrote:
> > Add a basic example for passing a dasd via vfio-ccw.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> > 
> > v2->v3: moved uuid generation (Thomas)
> > 
> > ---
> >  docs/system/s390x/vfio-ccw.rst | 77 ++++++++++++++++++++++++++++++++++
> >  docs/system/target-s390x.rst   |  1 +
> >  2 files changed, 78 insertions(+)
> >  create mode 100644 docs/system/s390x/vfio-ccw.rst
> > 
> > diff --git a/docs/system/s390x/vfio-ccw.rst b/docs/system/s390x/vfio-ccw.rst
> > new file mode 100644
> > index 000000000000..fff23d9afff7
> > --- /dev/null
> > +++ b/docs/system/s390x/vfio-ccw.rst
> > @@ -0,0 +1,77 @@
> > +Subchannel passthrough via vfio-ccw
> > +===================================
> > +
> > +vfio-ccw (based upon the mediated vfio device infrastructure) allows to
> > +make certain I/O subchannels and their devices available to a guest. The
> > +host will not interact with those subchannels/devices any more.
> > +
> > +Note that while vfio-ccw should work with most non-QDIO devices, only ECKD
> > +DASDs have really been tested.
> > +
> > +Example configuration
> > +---------------------
> > +
> > +Step 1: configure the host device
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +As every mdev is identified by a uuid, the first step is to obtain one::
> > +
> > +  [root@host ~]# uuidgen
> > +  7e270a25-e163-4922-af60-757fc8ed48c6
> > +
> > +Note: it is recommended to use the ``mdevctl`` tool for actually configuring
> > +the host device.
> > +
> > +To define the same device as configured below to be started
> > +automatically, use
> > +
> > +::
> > +
> > +   [root@host ~]# driverctl -b css set-override 0.0.0313 vfio_ccw
> > +   [root@host ~]# mdevctl define -u 7e270a25-e163-4922-af60-757fc8ed48c6\  
> 
> Maybe add a space before the backslash?
> 
> > +                  -p 0.0.0313 -t vfio-ccw_io -a
> > +
> > +If using ``mdevctl``  is not possible or wanted, follow the manual procedure
> > +below.  
> 
> Nit: Doubled whitespaces after mdevctl. With that fixed:
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks!

Fixed the nits and queued to s390-next.


