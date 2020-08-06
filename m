Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB52C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:13:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A75523123
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E0VQBqcL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A75523123
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3fiS-0003PS-HZ
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 09:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k3fgg-00021h-LC
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 09:12:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31319
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k3fge-0008DN-7q
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 09:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596719519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GIe8ZeBZuol9f2+gTg0lkmI56lDnCnmkTt0vxfbKCGE=;
 b=E0VQBqcLRjVjZfHeWNTEXU1plUWvuMeymXvygnMKOiTyMNXjKkzB/NUeHQdK/uLqrKQVMZ
 h3O6KIrd10o3ojayyeoOAPHhn2CNeFWKBoIWdBj5GhrPWgHC5pEWlpGJxF4IhPBBAkQpMd
 5eMaZj5sfpRmPhHTEZE8IGA/+rRDQnM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-YZryfA1CNLyi8CzYrluK2A-1; Thu, 06 Aug 2020 09:11:55 -0400
X-MC-Unique: YZryfA1CNLyi8CzYrluK2A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECE90800404;
 Thu,  6 Aug 2020 13:11:53 +0000 (UTC)
Received: from gondolin (ovpn-113-2.ams2.redhat.com [10.36.113.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 16FD687A4D;
 Thu,  6 Aug 2020 13:11:51 +0000 (UTC)
Date: Thu, 6 Aug 2020 15:11:49 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH for-5.2 v2 9/9] tests/qtest/cdrom: Add more
 s390x-related boot tests
Message-ID: <20200806151149.2b9833e2.cohuck@redhat.com>
In-Reply-To: <51c2b736-4b30-84d7-492d-a7963d79ec27@redhat.com>
References: <20200806105349.632-1-thuth@redhat.com>
 <20200806105349.632-10-thuth@redhat.com>
 <20200806132344.4a34178e.cohuck@redhat.com>
 <51c2b736-4b30-84d7-492d-a7963d79ec27@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:07:42
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
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>,
 Collin Walling <walling@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 6 Aug 2020 13:58:47 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 06/08/2020 13.23, Cornelia Huck wrote:
> > On Thu,  6 Aug 2020 12:53:49 +0200
> > Thomas Huth <thuth@redhat.com> wrote:
> >   
> >> Let's add two new tests:
> >>
> >> 1) Booting with "bootindex" is the architected default behavior on the
> >> s390x target, so we should have at least one test that is using the
> >> "bootindex" property.
> >>
> >> 2) The s390-ccw bios used to fail when other unbootable devices have
> >> been specified before the bootable device (without "bootindex"). Now
> >> that the s390-ccw bios is a little bit smarter here, we should test
> >> this scenario, too, to avoid regressions.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>  tests/qtest/cdrom-test.c | 12 ++++++++++++
> >>  1 file changed, 12 insertions(+)
> >>
> >> diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c
> >> index 833a0508a1..13e22f57c1 100644
> >> --- a/tests/qtest/cdrom-test.c
> >> +++ b/tests/qtest/cdrom-test.c
> >> @@ -163,6 +163,18 @@ static void add_s390x_tests(void)
> >>      qtest_add_data_func("cdrom/boot/virtio-scsi",
> >>                          "-device virtio-scsi -device scsi-cd,drive=cdr "
> >>                          "-blockdev file,node-name=cdr,filename=", test_cdboot);
> >> +    qtest_add_data_func("cdrom/boot/with-bootindex",
> >> +                        "-device virtio-serial -device virtio-scsi "
> >> +                        "-device virtio-blk,drive=d1 "
> >> +                        "-drive driver=null-co,read-zeroes=on,if=none,id=d1 "
> >> +                        "-device virtio-blk,drive=d2,bootindex=1 "
> >> +                        "-drive if=none,id=d2,media=cdrom,file=", test_cdboot);
> >> +    qtest_add_data_func("cdrom/boot/without-bootindex",
> >> +                        "-device virtio-scsi -device virtio-serial "
> >> +                        "-device x-terminal3270 -device virtio-blk,drive=d1 "  
> > 
> > Any special reason for that 3270 device here? Or just to add more
> > variety? :)  
> 
> Yes, there is a reason:
> 
>  https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg07231.html
> 
> ... so this is a check that this does not happen again.

Ah, thanks for reminding me. Adding 3270 is a good idea.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


