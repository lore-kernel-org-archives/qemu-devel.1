Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7378CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 19:57:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3705D21835
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 19:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3705D21835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuM84-00058K-CQ
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 14:57:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iuM7T-0004im-JI
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 14:56:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iuM7S-00025g-1F
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 14:56:55 -0500
Received: from 14.mo3.mail-out.ovh.net ([188.165.43.98]:59880)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iuM7R-00024G-Qa
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 14:56:53 -0500
Received: from player718.ha.ovh.net (unknown [10.109.146.137])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 4A91323EAB6
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 20:56:51 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player718.ha.ovh.net (Postfix) with ESMTPSA id A783EE6F02CF;
 Wed, 22 Jan 2020 19:56:49 +0000 (UTC)
Date: Wed, 22 Jan 2020 20:56:46 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v4 05/11] tests/virtio-9p: added readdir test
Message-ID: <20200122205646.66b19a39@bahia.lan>
In-Reply-To: <e0b4402722a877178f8fb6a8ad7b64bb20150613.1579567020.git.qemu_oss@crudebyte.com>
References: <cover.1579567019.git.qemu_oss@crudebyte.com>
 <e0b4402722a877178f8fb6a8ad7b64bb20150613.1579567020.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 12178296344191473984
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrvddtgdduvdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjedukedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.43.98
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

On Tue, 21 Jan 2020 01:12:00 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> The first readdir test simply checks the amount of directory
> entries returned by 9pfs server, according to the created amount
> of virtual files on 9pfs synth driver side. Then the subsequent
> readdir test also checks whether all directory entries have the
> expected file names (as created on 9pfs synth driver side),
> ignoring their precise order in result list though.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

LGTM

Reviewed-by: Greg Kurz <groug@kaod.org>

I've applied patches 4 and 5 as well.

>  tests/qtest/virtio-9p-test.c | 152 +++++++++++++++++++++++++++++++++++
>  1 file changed, 152 insertions(+)
> 
> diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
> index 06263edb53..2167322985 100644
> --- a/tests/qtest/virtio-9p-test.c
> +++ b/tests/qtest/virtio-9p-test.c
> @@ -68,6 +68,11 @@ static void v9fs_memread(P9Req *req, void *addr, size_t len)
>      req->r_off += len;
>  }
>  
> +static void v9fs_uint8_read(P9Req *req, uint8_t *val)
> +{
> +    v9fs_memread(req, val, 1);
> +}
> +
>  static void v9fs_uint16_write(P9Req *req, uint16_t val)
>  {
>      uint16_t le_val = cpu_to_le16(val);
> @@ -101,6 +106,12 @@ static void v9fs_uint32_read(P9Req *req, uint32_t *val)
>      le32_to_cpus(val);
>  }
>  
> +static void v9fs_uint64_read(P9Req *req, uint64_t *val)
> +{
> +    v9fs_memread(req, val, 8);
> +    le64_to_cpus(val);
> +}
> +
>  /* len[2] string[len] */
>  static uint16_t v9fs_string_size(const char *string)
>  {
> @@ -191,6 +202,7 @@ static const char *rmessage_name(uint8_t id)
>          id == P9_RLOPEN ? "RLOPEN" :
>          id == P9_RWRITE ? "RWRITE" :
>          id == P9_RFLUSH ? "RFLUSH" :
> +        id == P9_RREADDIR ? "READDIR" :
>          "<unknown>";
>  }
>  
> @@ -348,6 +360,82 @@ static void v9fs_rwalk(P9Req *req, uint16_t *nwqid, v9fs_qid **wqid)
>      v9fs_req_free(req);
>  }
>  
> +/* size[4] Treaddir tag[2] fid[4] offset[8] count[4] */
> +static P9Req *v9fs_treaddir(QVirtio9P *v9p, uint32_t fid, uint64_t offset,
> +                            uint32_t count, uint16_t tag)
> +{
> +    P9Req *req;
> +
> +    req = v9fs_req_init(v9p, 4 + 8 + 4, P9_TREADDIR, tag);
> +    v9fs_uint32_write(req, fid);
> +    v9fs_uint64_write(req, offset);
> +    v9fs_uint32_write(req, count);
> +    v9fs_req_send(req);
> +    return req;
> +}
> +
> +struct V9fsDirent {
> +    v9fs_qid qid;
> +    uint64_t offset;
> +    uint8_t type;
> +    char *name;
> +    struct V9fsDirent *next;
> +};
> +
> +/* size[4] Rreaddir tag[2] count[4] data[count] */
> +static void v9fs_rreaddir(P9Req *req, uint32_t *count, uint32_t *nentries,
> +                          struct V9fsDirent **entries)
> +{
> +    uint32_t local_count;
> +    struct V9fsDirent *e = NULL;
> +    uint16_t slen;
> +    uint32_t n = 0;
> +
> +    v9fs_req_recv(req, P9_RREADDIR);
> +    v9fs_uint32_read(req, &local_count);
> +
> +    if (count) {
> +        *count = local_count;
> +    }
> +
> +    for (int32_t togo = (int32_t)local_count;
> +         togo >= 13 + 8 + 1 + 2;
> +         togo -= 13 + 8 + 1 + 2 + slen, ++n)
> +    {
> +        if (!e) {
> +            e = g_malloc(sizeof(struct V9fsDirent));
> +            if (entries) {
> +                *entries = e;
> +            }
> +        } else {
> +            e = e->next = g_malloc(sizeof(struct V9fsDirent));
> +        }
> +        e->next = NULL;
> +        /* qid[13] offset[8] type[1] name[s] */
> +        v9fs_memread(req, &e->qid, 13);
> +        v9fs_uint64_read(req, &e->offset);
> +        v9fs_uint8_read(req, &e->type);
> +        v9fs_string_read(req, &slen, &e->name);
> +    }
> +
> +    if (nentries) {
> +        *nentries = n;
> +    }
> +
> +    v9fs_req_free(req);
> +}
> +
> +static void v9fs_free_dirents(struct V9fsDirent *e)
> +{
> +    struct V9fsDirent *next = NULL;
> +
> +    for (; e; e = next) {
> +        next = e->next;
> +        g_free(e->name);
> +        g_free(e);
> +    }
> +}
> +
>  /* size[4] Tlopen tag[2] fid[4] flags[4] */
>  static P9Req *v9fs_tlopen(QVirtio9P *v9p, uint32_t fid, uint32_t flags,
>                            uint16_t tag)
> @@ -480,6 +568,69 @@ static void fs_walk(void *obj, void *data, QGuestAllocator *t_alloc)
>      g_free(wqid);
>  }
>  
> +static bool fs_dirents_contain_name(struct V9fsDirent *e, const char* name)
> +{
> +    for (; e; e = e->next) {
> +        if (!strcmp(e->name, name)) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
> +static void fs_readdir(void *obj, void *data, QGuestAllocator *t_alloc)
> +{
> +    QVirtio9P *v9p = obj;
> +    alloc = t_alloc;
> +    char *const wnames[] = { g_strdup(QTEST_V9FS_SYNTH_READDIR_DIR) };
> +    uint16_t nqid;
> +    v9fs_qid qid;
> +    uint32_t count, nentries;
> +    struct V9fsDirent *entries = NULL;
> +    P9Req *req;
> +
> +    fs_attach(v9p, NULL, t_alloc);
> +    req = v9fs_twalk(v9p, 0, 1, 1, wnames, 0);
> +    v9fs_req_wait_for_reply(req, NULL);
> +    v9fs_rwalk(req, &nqid, NULL);
> +    g_assert_cmpint(nqid, ==, 1);
> +
> +    req = v9fs_tlopen(v9p, 1, O_DIRECTORY, 0);
> +    v9fs_req_wait_for_reply(req, NULL);
> +    v9fs_rlopen(req, &qid, NULL);
> +
> +    /*
> +     * submit count = msize - 11, because 11 is the header size of Rreaddir
> +     */
> +    req = v9fs_treaddir(v9p, 1, 0, P9_MAX_SIZE - 11, 0);
> +    v9fs_req_wait_for_reply(req, NULL);
> +    v9fs_rreaddir(req, &count, &nentries, &entries);
> +
> +    /*
> +     * Assuming msize (P9_MAX_SIZE) is large enough so we can retrieve all
> +     * dir entries with only one readdir request.
> +     */
> +    g_assert_cmpint(
> +        nentries, ==,
> +        QTEST_V9FS_SYNTH_READDIR_NFILES + 2 /* "." and ".." */
> +    );
> +
> +    /*
> +     * Check all file names exist in returned entries, ignore their order
> +     * though.
> +     */
> +    g_assert_cmpint(fs_dirents_contain_name(entries, "."), ==, true);
> +    g_assert_cmpint(fs_dirents_contain_name(entries, ".."), ==, true);
> +    for (int i = 0; i < QTEST_V9FS_SYNTH_READDIR_NFILES; ++i) {
> +        char *name = g_strdup_printf(QTEST_V9FS_SYNTH_READDIR_FILE, i);
> +        g_assert_cmpint(fs_dirents_contain_name(entries, name), ==, true);
> +        g_free(name);
> +    }
> +
> +    v9fs_free_dirents(entries);
> +    g_free(wnames[0]);
> +}
> +
>  static void fs_walk_no_slash(void *obj, void *data, QGuestAllocator *t_alloc)
>  {
>      QVirtio9P *v9p = obj;
> @@ -658,6 +809,7 @@ static void register_virtio_9p_test(void)
>                   NULL);
>      qos_add_test("fs/flush/ignored", "virtio-9p", fs_flush_ignored,
>                   NULL);
> +    qos_add_test("fs/readdir/basic", "virtio-9p", fs_readdir, NULL);
>  }
>  
>  libqos_init(register_virtio_9p_test);


