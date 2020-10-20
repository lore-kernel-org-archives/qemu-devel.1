Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381E2C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:43:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8044E22247
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8044E22247
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUtnV-0002t2-IY
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 11:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kUtlz-000172-7x
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:42:03 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:57095)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kUtlx-0001wr-5b
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:42:02 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.156.44])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id CE52D6DDA3E1;
 Tue, 20 Oct 2020 17:41:57 +0200 (CEST)
Received: from kaod.org (37.59.142.95) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Tue, 20 Oct
 2020 17:41:57 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G0011d4c026b-4f92-4dcf-b45a-e0cd5136e208,
 1DF5E91C91B319FFB92086F2F245FA8D0BCC998A) smtp.auth=groug@kaod.org
Date: Tue, 20 Oct 2020 17:41:56 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH 1/5] tests/9pfs: Factor out do_fs_version() helper
Message-ID: <20201020174156.229f8008@bahia.lan>
In-Reply-To: <3517148.drKrQmItIC@silver>
References: <160320655763.255209.3890094487013964615.stgit@bahia.lan>
 <160320666564.255209.11628044710614310582.stgit@bahia.lan>
 <3517148.drKrQmItIC@silver>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.95]
X-ClientProxiedBy: DAG8EX2.mxp5.local (172.16.2.72) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: ff9009a7-ff7c-43fb-a98f-fc662f12538b
X-Ovh-Tracer-Id: 379709747007101338
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrjeefgdeltdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefuddtieejjeevheekieeltefgleetkeetheettdeifeffvefhffelffdtfeeljeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 09:35:38
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 20 Oct 2020 17:34:05 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Dienstag, 20. Oktober 2020 17:11:05 CEST Greg Kurz wrote:
> > fs_version() is a top level test function. Factor out the sugar
> > to a separate helper instead of hijacking it in other tests.
> > 
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  tests/qtest/virtio-9p-test.c |   14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
> > index c15908f27b3d..63f91aaf77e6 100644
> > --- a/tests/qtest/virtio-9p-test.c
> > +++ b/tests/qtest/virtio-9p-test.c
> > @@ -567,10 +567,8 @@ static void v9fs_rflush(P9Req *req)
> >      v9fs_req_free(req);
> >  }
> > 
> > -static void fs_version(void *obj, void *data, QGuestAllocator *t_alloc)
> > +static void do_fs_version(QVirtio9P *v9p)
> >  {
> > -    QVirtio9P *v9p = obj;
> > -    alloc = t_alloc;
> >      const char *version = "9P2000.L";
> >      uint16_t server_len;
> >      char *server_version;
> > @@ -585,13 +583,19 @@ static void fs_version(void *obj, void *data,
> > QGuestAllocator *t_alloc) g_free(server_version);
> >  }
> 
> So the naming convention from now on shall be do_fs_*() for non-toplevel 
> functions there. Not that I care too much about the precise prefix, but how 
> about just do_*() for them instead?
> 

I've prepended "do_" to the existing names by pure laziness but I'm
fine with any prefix or naming convention actually.

So just tell me what you prefer and I'll send a v2.

> Except of that, your patches look fine to me.
> 
> Best regards,
> Christian Schoenebeck
> 
> 


