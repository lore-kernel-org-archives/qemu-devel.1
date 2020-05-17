Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1B0C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 18:51:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55515207D3
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 18:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pn2DXNbE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55515207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaONI-0006cE-G6
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 14:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jaOMc-0005zX-7N
 for qemu-devel@nongnu.org; Sun, 17 May 2020 14:50:18 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34012
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jaOMa-0001eu-PG
 for qemu-devel@nongnu.org; Sun, 17 May 2020 14:50:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589741415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CbDgoBkdGDfsnyKvk8EL6IaKk+4za97Tfr02QsQig2A=;
 b=Pn2DXNbEEmkMY2jvQDsEK/26vqw00o4MPrP5P9Dw0zy1p51aGGBdbMOJFrVhh2nAF/V1Ae
 U6z6okl3sU1FAglq8A4e+QA/HLfJiE5LRVkOO6YdJxS4wYF5AmPlWMBc7+DIdzoyDnnXc4
 jGg1D37AFilBItYyFL1GpKS2SjXqzlY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-NvA9ONF6OLCCmkiRISVNRA-1; Sun, 17 May 2020 14:50:13 -0400
X-MC-Unique: NvA9ONF6OLCCmkiRISVNRA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D95E800D24;
 Sun, 17 May 2020 18:50:12 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 608511FBCD;
 Sun, 17 May 2020 18:50:10 +0000 (UTC)
Message-ID: <1fbd26d24c59a0189fb44d21639707fa7a6aa3c7.camel@redhat.com>
Subject: Re: [PATCH v6 09/14] iotests: filter few more luks specific create
 options
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Sun, 17 May 2020 21:50:09 +0300
In-Reply-To: <9916f5ef-3373-8999-1c1b-bcc97e1ce7cd@redhat.com>
References: <20200510134037.18487-1-mlevitsk@redhat.com>
 <20200510134037.18487-10-mlevitsk@redhat.com>
 <9916f5ef-3373-8999-1c1b-bcc97e1ce7cd@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 13:47:52
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2020-05-14 at 16:49 +0200, Max Reitz wrote:
> On 10.05.20 15:40, Maxim Levitsky wrote:
> > This allows more tests to be able to have same output on both qcow2 luks encrypted images
> > and raw luks images
> > 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  tests/qemu-iotests/087.out       |  6 ++---
> >  tests/qemu-iotests/134.out       |  2 +-
> >  tests/qemu-iotests/158.out       |  4 +--
> >  tests/qemu-iotests/188.out       |  2 +-
> >  tests/qemu-iotests/189.out       |  4 +--
> >  tests/qemu-iotests/198.out       |  4 +--
> >  tests/qemu-iotests/263.out       |  4 +--
> >  tests/qemu-iotests/274.out       | 46 ++++++++++++++++----------------
> >  tests/qemu-iotests/284.out       |  6 ++---
> >  tests/qemu-iotests/common.filter |  6 +++--
> >  10 files changed, 43 insertions(+), 41 deletions(-)
> 
> [...]
> 
> > diff --git a/tests/qemu-iotests/274.out b/tests/qemu-iotests/274.out
> > index 9d6fdeb1f7..59de176b99 100644
> > --- a/tests/qemu-iotests/274.out
> > +++ b/tests/qemu-iotests/274.out
> > @@ -1,9 +1,9 @@
> >  == Commit tests ==
> > -Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=2097152 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> > +Formatting 'TEST_DIR/PID-base', fmt=qcow2 cluster_size=65536 size=2097152 lazy_refcounts=off refcount_bits=16
> >  
> > -Formatting 'TEST_DIR/PID-mid', fmt=qcow2 size=1048576 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16
> > +Formatting 'TEST_DIR/PID-mid', fmt=qcow2 cluster_size=65536 size=1048576 backing_file=TEST_DIR/PID-base lazy_refcounts=off refcount_bits=16
> >  
> > -Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=2097152 backing_file=TEST_DIR/PID-mid cluster_size=65536 lazy_refcounts=off refcount_bits=16
> > +Formatting 'TEST_DIR/PID-top', fmt=qcow2 cluster_size=65536 size=2097152 backing_file=TEST_DIR/PID-mid lazy_refcounts=off refcount_bits=16
> 
> @size and @cluster_size swapping positions doesn’t look right for this
> patch.  I think all hunks for 274.out should be in patch 5.
Fixed

> 
> Max
> 

Best regards,
	Maxim Levitsky



