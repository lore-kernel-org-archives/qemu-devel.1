Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFCAC4727D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 06:41:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6291C2376F
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 06:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="StFRA6op"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6291C2376F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLKwl-0004iZ-CT
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 02:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kLKnt-000585-7E
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 02:32:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37871)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kLKnr-0002F1-AT
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 02:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600929146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1P+dtOg2XnFDEwzLxr1Z4bkSa2XUSWCRYOxeJYhs2As=;
 b=StFRA6opg/viwqbr4cDGPajHkI0AcdrVpG+2tD8lvemc67V2iBiENU3zSEvHxj7j0M4TQu
 6uRwrvnBSzapHe423/cJPNmsOqnSd/YVs2TZlzTKzPpFY0LOsqcnSCPbEUvob7Nn4empf9
 UA7+VxmDqo5MVPlTtdneDYZ/rMvWzSs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-hFEAGNOMM2aNhD1k0v-QrQ-1; Thu, 24 Sep 2020 02:32:22 -0400
X-MC-Unique: hFEAGNOMM2aNhD1k0v-QrQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B88B9805EE8;
 Thu, 24 Sep 2020 06:32:21 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6EFAD5D990;
 Thu, 24 Sep 2020 06:32:17 +0000 (UTC)
Date: Thu, 24 Sep 2020 08:32:15 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH v3] Add a comment in bios-tables-test.c to clarify the
 reason behind approach
Message-ID: <20200924083215.3ea5fd08@redhat.com>
In-Reply-To: <CAARzgwxKJHAQr3SgzN7UHVxPjzu+sh14P7B22wBniJ0qcpJ-vQ@mail.gmail.com>
References: <20200922100918.4200-1-ani@anisinha.ca>
 <20200922132744.2faf4eea@redhat.com>
 <CAARzgwxKJHAQr3SgzN7UHVxPjzu+sh14P7B22wBniJ0qcpJ-vQ@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 22 Sep 2020 17:06:42 +0530
Ani Sinha <ani@anisinha.ca> wrote:

> On Tue, Sep 22, 2020 at 4:57 PM Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > On Tue, 22 Sep 2020 15:39:18 +0530
> > Ani Sinha <ani@anisinha.ca> wrote:
> >  
> > > A comment blob is added in bios-tables-test.c that explains the reasoning
> > > behind the process of updating the ACPI table blobs when new tests are added
> > > or old tests are modified or code is committed that affect tests. The
> > > explanation would help future contributors follow the correct process when
> > > making code changes that affect ACPI tables.
> > >
> > > Signed-off-by: Ani Sinha <ani@anisinha.ca>  
> >
> > My English is not good enough for writing documentation.
> > Maybe Eric will have something to suggest.
> >  
> > > ---
> > >  tests/qtest/bios-tables-test.c | 13 ++++++++++++-
> > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > >
> > > Changelog:
> > > v2: cosmetic - commit log reworded.
> > > v3: review feedback incorporared and actual comment in the code reworded.
> > >
> > > diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> > > index b514b70b62..1e8838c8c6 100644
> > > --- a/tests/qtest/bios-tables-test.c
> > > +++ b/tests/qtest/bios-tables-test.c
> > > @@ -11,7 +11,7 @@
> > >   */
> > >
> > >  /*
> > > - * How to add or update the tests:
> > > + * How to add or update the tests or commit changes that affect ACPI tables:
> > >   * Contributor:
> > >   * 1. add empty files for new tables, if any, under tests/data/acpi
> > >   * 2. list any changed files in tests/qtest/bios-tables-test-allowed-diff.h
> > > @@ -38,6 +38,17 @@
> > >   *      $(SRC_PATH)/tests/data/acpi/rebuild-expected-aml.sh
> > >   * 6. Now commit any changes to the expected binary, include diff from step 4
> > >   *    in commit log.
> > > + *    The reason why we follow the above process is described below:
> > > + *    After every commit we make sure that the unit tests are not broken. To do
> > > + *    that, we could have committed the table updates along with the patches.  
> > I'd drop upto here, it's obvious that that no patch should break build intentionally.  
> 
> I prefer to make this explicit. Build breakage != unit test breakage
> all the time :-)
when it comes to merge, broken test == broken build,
in addition I don't like negative example.
what we are missing currently is answer to "why" #is there,
and that's is answered by below the rest is just distraction to me.


> > Writing docs is hard, try to minimize amount of not really needed
> > information.
> >  
> > > + *    However, expected binary updates needs to be a separate patch from the  
> > s/However,//
> >  
> > > + *    code that introduces changes to ACPI tables. It lets maintainer to drop
> > > + *    and regenerate binary updates in case of merge conflicts. Further, a code
> > > + *    change is easily reviewable but a binary blob is not (without doing a
> > > + *    diassemly).  
> >  
> > > + * Listing the modified table files additionally helps in

> > > + *    bisection in case things are broken.
> > > + *    Hence, we have a multi-step process and at each step unit tests continue
> > > + *    to pass.  
> > I'd drop this part as well  
> Why?

It doesn't belong to #6 and most of it is just one of the possible
justifications we can make up.
#1 is about turning hard error into warning to let test pass while
code being changed.
Try to concise and do not add extra sentences unless you have to.

> 
> >
> > with above corrections, I'm more or less fine with text so on that condition
> > Acked-by: Igor Mammedov <imammedo@redhat.com>
> > the rest is upto Michael.
> >  
> > >   * 7. Before sending patches to the list (Contributor)
> > >   *    or before doing a pull request (Maintainer), make sure
> > >   *    tests/qtest/bios-tables-test-allowed-diff.h is empty - this will ensure  
> >  
> 


