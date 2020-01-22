Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8141DC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 23:01:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C1EA21835
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 23:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1EA21835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuOzz-0007IL-Ci
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 18:01:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iuOyj-0006l5-2D
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 18:00:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iuOyf-00089u-4v
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 18:00:04 -0500
Received: from 9.mo68.mail-out.ovh.net ([46.105.78.111]:41206)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iuOye-00088X-4E
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 18:00:00 -0500
Received: from player715.ha.ovh.net (unknown [10.108.1.170])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id ABF2F1575FA
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 23:59:57 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player715.ha.ovh.net (Postfix) with ESMTPSA id 1794AE58199C;
 Wed, 22 Jan 2020 22:59:56 +0000 (UTC)
Date: Wed, 22 Jan 2020 23:59:54 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v4 07/11] tests/virtio-9p: failing splitted readdir test
Message-ID: <20200122235954.1305faab@bahia.lan>
In-Reply-To: <4dc3706db1f033d922e54af8c74a81211de8b79f.1579567020.git.qemu_oss@crudebyte.com>
References: <cover.1579567019.git.qemu_oss@crudebyte.com>
 <4dc3706db1f033d922e54af8c74a81211de8b79f.1579567020.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 15270861915673893184
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrvddugddtudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejudehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.78.111
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

On Tue, 21 Jan 2020 01:17:35 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> This patch is not intended to be merged. It resembles
> an issue (with debug messages) where the splitted
> readdir test fails because server is interrupted with
> transport error "Failed to decode VirtFS request type 40",

Ok. When we send a new request, we call:

uint32_t qvirtqueue_add(QTestState *qts, QVirtQueue *vq, uint64_t data,
                        uint32_t len, bool write, bool next)
{
    uint16_t flags = 0;
    vq->num_free--;

[...]

    return vq->free_head++; /* Return and increase, in this order */
}

where vq->num_free is the number of available buffers (aka. requests) in
the vq and vq->free_head the index of the next available buffer. The size
of the vq of the virtio-9p device is MAX_REQ (128) buffers. The driver
is very simple and doesn't care to handle the scenario of a full vq,
ie, num_free == 0 and free_head is past the vq->desc[] array. It seems
that count=128 generates enough extra requests to reach the end of the
vq. Hence the "decode" error you get. Maybe an assert(vq->num_free) in
qvirtqueue_add() would make that more clear ?

Not sure it is worth to address this limitation though. Especially since
count=128 isn't really a recommended choice in the first place. It has
more chances to cause a disconnect if the server needs to return a longer
file name (which is expected since most fs have 255 character long file
names).

> which BTW fails both with the unoptimized and with the
> optimized 9p readdir code.
> 

Yes, this is the client's fault.

> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  tests/qtest/virtio-9p-test.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
> index 8b0d94546e..e47b286340 100644
> --- a/tests/qtest/virtio-9p-test.c
> +++ b/tests/qtest/virtio-9p-test.c
> @@ -647,13 +647,14 @@ static void fs_readdir_split(void *obj, void *data, QGuestAllocator *t_alloc)
>      int fid;
>      uint64_t offset;
>      /* the Treaddir 'count' parameter values to be tested */
> -    const uint32_t vcount[] = { 512, 256 };
> +    const uint32_t vcount[] = { 512, 256, 128 };
>      const int nvcount = sizeof(vcount) / sizeof(uint32_t);
>  
>      fs_attach(v9p, NULL, t_alloc);
>  
>      /* iterate over all 'count' parameter values to be tested with Treaddir */
>      for (subtest = 0; subtest < nvcount; ++subtest) {
> +        printf("\nsubtest[%d] with count=%d\n", subtest, vcount[subtest]);
>          fid = subtest + 1;
>          offset = 0;
>          entries = NULL;
> @@ -674,12 +675,16 @@ static void fs_readdir_split(void *obj, void *data, QGuestAllocator *t_alloc)
>           * entries
>           */
>          while (true) {
> +            printf("\toffset=%ld\n", offset);
>              npartialentries = 0;
>              partialentries = NULL;
>  
> +            printf("Treaddir fid=%d offset=%ld count=%d\n",
> +                   fid, offset, vcount[subtest]);
>              req = v9fs_treaddir(v9p, fid, offset, vcount[subtest], 0);
>              v9fs_req_wait_for_reply(req, NULL);
>              v9fs_rreaddir(req, &count, &npartialentries, &partialentries);
> +            printf("\t\tnpartial=%d nentries=%d\n", npartialentries, nentries);
>              if (npartialentries > 0 && partialentries) {
>                  if (!entries) {
>                      entries = partialentries;
> @@ -716,6 +721,8 @@ static void fs_readdir_split(void *obj, void *data, QGuestAllocator *t_alloc)
>          }
>  
>          v9fs_free_dirents(entries);
> +
> +        printf("PASSED subtest[%d]\n", subtest);
>      }
>  
>      g_free(wnames[0]);


