Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51825C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:45:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A7B3206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CvlkQzG9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7B3206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZWuj-0001Mw-1O
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 05:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jZWu7-0000gJ-Ey
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:45:19 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43123
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jZWu6-0003FK-SJ
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589535917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IAOnmNbS2TDggtIU3jhjKnoR8UAw+nO/k2V4YA1yunY=;
 b=CvlkQzG9exYcfvjAauyD8NDhNAuhRZHhggUyVKU/ieu1FlmZlIP57A3BsOjAuAPg6ZtWHD
 V57Sahip+H0zTx2fZ6OduDSNf32wenHFpbGrlOY0F6nEcz5vea8k4G0slEUY80vy0d0lDh
 vBa6pIZm13FsMqNxWt49O1c6I5e+rz8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-XDpn_Y6bMu22MEuxHLjVRQ-1; Fri, 15 May 2020 05:45:15 -0400
X-MC-Unique: XDpn_Y6bMu22MEuxHLjVRQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C710A1005510;
 Fri, 15 May 2020 09:45:14 +0000 (UTC)
Received: from gondolin (ovpn-112-229.ams2.redhat.com [10.36.112.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E1EDF39E;
 Fri, 15 May 2020 09:45:13 +0000 (UTC)
Date: Fri, 15 May 2020 11:45:11 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 2/3] docs/s390x: document 3270
Message-ID: <20200515114511.2ac852f3.cohuck@redhat.com>
In-Reply-To: <b6acb966-16f2-605d-6d01-70f6085bfa79@redhat.com>
References: <20200505135025.14614-1-cohuck@redhat.com>
 <20200505135025.14614-3-cohuck@redhat.com>
 <4ea47ea1-04d5-3073-fef6-5af07f06a4d6@redhat.com>
 <20200515110007.1676b17d.cohuck@redhat.com>
 <b6acb966-16f2-605d-6d01-70f6085bfa79@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Fri, 15 May 2020 11:14:40 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 15/05/2020 11.00, Cornelia Huck wrote:
> > On Fri, 15 May 2020 09:29:42 +0200
> > Thomas Huth <thuth@redhat.com> wrote:
> >   
> >> On 05/05/2020 15.50, Cornelia Huck wrote:  
> >>> Add some basic info how to use 3270 devices.
> >>>
> >>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> >>> ---
> >>>  docs/system/s390x/3270.rst   | 32 ++++++++++++++++++++++++++++++++
> >>>  docs/system/target-s390x.rst |  1 +
> >>>  2 files changed, 33 insertions(+)
> >>>  create mode 100644 docs/system/s390x/3270.rst
> >>>
> >>> diff --git a/docs/system/s390x/3270.rst b/docs/system/s390x/3270.rst
> >>> new file mode 100644
> >>> index 000000000000..e367a457e001
> >>> --- /dev/null
> >>> +++ b/docs/system/s390x/3270.rst
> >>> @@ -0,0 +1,32 @@
> >>> +3270 devices
> >>> +============
> >>> +
> >>> +With the aid of the ``x3270`` emulator, QEMU provides limited support
> >>> +for making a single 3270 device available to a guest. Note that this
> >>> +supports basic features only.    
> >>
> >> The first sentence sounds somewhat confusing. Maybe rather something like:
> >>
> >> QEMU can emulate a 3270 device attached to a guest, which then can be
> >> used with a program like ``x3270`` to get a traditional 3270 terminal
> >> for your guest.  
> > 
> > But QEMU actually relies on x3270 (or a comparable program). It only
> > emulates the basic ccw plumbing; for the actual protocol (beyond
> > negotiating tn3270), it relies on the emulation done by x3270.  
> 
> Ok, makes sense now. Maybe something like:
> 
> QEMU provides the possibility to connect an external 3270 terminal
> emulator (like ``x3270``) to a guest?

Hm...

"QEMU supports connecting an external 3270 terminal emulator (such as
``x3270``) to make a single 3270 device available to a guest. Note that
this supports basic features only."

?


