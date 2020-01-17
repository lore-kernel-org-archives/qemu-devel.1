Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040B5C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 15:51:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC5F72064C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 15:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC5F72064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isTuP-0001Ht-Sh
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 10:51:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1isTtj-0000gN-SX
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 10:51:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1isTtf-0002CF-Qn
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 10:50:59 -0500
Received: from 20.mo6.mail-out.ovh.net ([178.32.124.17]:60026)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1isTtf-0002BL-Js
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 10:50:55 -0500
Received: from player692.ha.ovh.net (unknown [10.109.146.86])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 237981F9E2C
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 16:50:53 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player692.ha.ovh.net (Postfix) with ESMTPSA id 91A58E36BE6C;
 Fri, 17 Jan 2020 15:50:51 +0000 (UTC)
Date: Fri, 17 Jan 2020 16:50:50 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v3 03/11] 9pfs: validate count sent by client with
 T_readdir
Message-ID: <20200117165050.27604cf0@bahia.lan>
In-Reply-To: <5915926.WqdOhGH810@silver>
References: <cover.1578957500.git.qemu_oss@crudebyte.com>
 <0edf21d2cb2a6cf22ba1065bf451b44ad5962cbd.1578957500.git.qemu_oss@crudebyte.com>
 <20200116143342.4d518b30@bahia.lan> <5915926.WqdOhGH810@silver>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 15554307213065099584
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrtdejgdekudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieelvddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.32.124.17
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

On Thu, 16 Jan 2020 17:51:10 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Donnerstag, 16. Januar 2020 14:33:42 CET Greg Kurz wrote:
> > On Mon, 13 Jan 2020 23:22:08 +0100
> > 
> > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > > A good 9p client sends T_readdir with "count" parameter that's
> > > sufficiently smaller than client's initially negotiated msize
> > > (maximum message size). We perform a check for that though to
> > > avoid the server to be interrupted with a "Failed to encode
> > > VirtFS reply type 41" error message by bad clients.
> > > 
> > > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > > ---
> > > 
> > >  hw/9pfs/9p.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > > index a5fbe821d4..30da2fedf3 100644
> > > --- a/hw/9pfs/9p.c
> > > +++ b/hw/9pfs/9p.c
> > > @@ -2426,6 +2426,7 @@ static void coroutine_fn v9fs_readdir(void *opaque)
> > > 
> > >      int32_t count;
> > >      uint32_t max_count;
> > >      V9fsPDU *pdu = opaque;
> > > 
> > > +    V9fsState *s = pdu->s;
> > > 
> > >      retval = pdu_unmarshal(pdu, offset, "dqd", &fid,
> > >      
> > >                             &initial_offset, &max_count);
> > > 
> > > @@ -2434,6 +2435,13 @@ static void coroutine_fn v9fs_readdir(void *opaque)
> > > 
> > >      }
> > >      trace_v9fs_readdir(pdu->tag, pdu->id, fid, initial_offset,
> > >      max_count);
> > > 
> > > +    if (max_count > s->msize - P9_IOHDRSZ) {
> > 
> > P9_IOHDRSZ relates to Twrite. The Rreaddir message has a smaller header
> > of size 11:
> > 
> > size[4] Rreaddir tag[2] count[4]
> 
> Right, looks like I have falsely picked P9_IOHDRSZ after looking at:
> 
> static size_t v9fs_readdir_data_size(V9fsString *name)
> {
>     /*
>      * Size of each dirent on the wire: size of qid (13) + size of offset (8)
>      * size of type (1) + size of name.size (2) + strlen(name.data)
>      */
>     return 24 + v9fs_string_size(name);
> }
> 
> I'll have to correct that in the test cases as well. So no need to comment on 
> them for now.
> 
> But if you have an idea about the issue mentioned in cover letter (patch 7), 
> let me know. I have a feeling that there is some problem with the test 
> environment, because I also get strange error messages when I just add some 
> more e.g. noop 9pfs test cases (empty test cases doing nothing) or by copy 
> pasting existing tests and then running 
> 
> tests/qos-test -l
> 
> which obviously should just list the test cases, but not executing any of 
> them. I'd end up with "cannot push stack" error messages for some reason.
> 

No idea. I'll have to look more.

> > > +        max_count = s->msize - P9_IOHDRSZ;
> > > +        warn_report_once(
> > > +            "9p: bad client: T_readdir with count > msize - P9_IOHDRSZ"
> > > +        );
> > > +    }
> > > +
> > > 
> > >      fidp = get_fid(pdu, fid);
> > >      if (fidp == NULL) {
> > >      
> > >          retval = -EINVAL;
> 
> Best regards,
> Christian Schoenebeck
> 
> 


