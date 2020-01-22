Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8B6C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 21:19:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66EF72465B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 21:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66EF72465B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuNPn-0004aH-J2
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 16:19:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60420)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iuNP6-0004Ad-Ie
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 16:19:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iuNP5-0001hz-2A
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 16:19:12 -0500
Received: from 2.mo173.mail-out.ovh.net ([178.33.251.49]:38959)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iuNP4-0001hG-S5
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 16:19:11 -0500
Received: from player798.ha.ovh.net (unknown [10.108.42.88])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 66BBB12D2AE
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 22:19:08 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player798.ha.ovh.net (Postfix) with ESMTPSA id ABB68EA2B88A;
 Wed, 22 Jan 2020 21:19:06 +0000 (UTC)
Date: Wed, 22 Jan 2020 22:19:05 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v4 06/11] tests/virtio-9p: added splitted readdir test
Message-ID: <20200122221905.055f9f93@bahia.lan>
In-Reply-To: <f6394833fa66bf6a73d204db34302732a5f6b98a.1579567020.git.qemu_oss@crudebyte.com>
References: <cover.1579567019.git.qemu_oss@crudebyte.com>
 <f6394833fa66bf6a73d204db34302732a5f6b98a.1579567020.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 13567938304788175168
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrvddtgddugedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeelkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.251.49
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

On Tue, 21 Jan 2020 01:16:21 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> The previous, already existing readdir test simply used a 'count'
> parameter big enough to retrieve all directory entries with a
> single Treaddir request.
> 
> In this new 'splitted' readdir test, directory entries are
> retrieved, splitted over several Treaddir requests by picking small
> 'count' parameters which force the server to truncate the response.
> So the test client sends as many Treaddir requests as necessary to
> get all directory entries. Currently this test covers actually two
> tests: a sequence of Treaddir requests with count=512 and then a
> subsequent test with a sequence of Treaddir requests with count=256.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

Not sure it is really needed to check with multiple values for 'count',
but it doesn't eat too many cycles so I guess it doesn't hurt.

Applied as well.

>  tests/qtest/virtio-9p-test.c | 91 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
> 
> diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
> index 2167322985..8b0d94546e 100644
> --- a/tests/qtest/virtio-9p-test.c
> +++ b/tests/qtest/virtio-9p-test.c
> @@ -578,6 +578,7 @@ static bool fs_dirents_contain_name(struct V9fsDirent *e, const char* name)
>      return false;
>  }
>  
> +/* basic readdir test where reply fits into a single response message */
>  static void fs_readdir(void *obj, void *data, QGuestAllocator *t_alloc)
>  {
>      QVirtio9P *v9p = obj;
> @@ -631,6 +632,95 @@ static void fs_readdir(void *obj, void *data, QGuestAllocator *t_alloc)
>      g_free(wnames[0]);
>  }
>  
> +/* readdir test where overall request is splitted over several messages */
> +static void fs_readdir_split(void *obj, void *data, QGuestAllocator *t_alloc)
> +{
> +    QVirtio9P *v9p = obj;
> +    alloc = t_alloc;
> +    char *const wnames[] = { g_strdup(QTEST_V9FS_SYNTH_READDIR_DIR) };
> +    uint16_t nqid;
> +    v9fs_qid qid;
> +    uint32_t count, nentries, npartialentries;
> +    struct V9fsDirent *entries, *tail, *partialentries;
> +    P9Req *req;
> +    int subtest;
> +    int fid;
> +    uint64_t offset;
> +    /* the Treaddir 'count' parameter values to be tested */
> +    const uint32_t vcount[] = { 512, 256 };
> +    const int nvcount = sizeof(vcount) / sizeof(uint32_t);
> +
> +    fs_attach(v9p, NULL, t_alloc);
> +
> +    /* iterate over all 'count' parameter values to be tested with Treaddir */
> +    for (subtest = 0; subtest < nvcount; ++subtest) {
> +        fid = subtest + 1;
> +        offset = 0;
> +        entries = NULL;
> +        nentries = 0;
> +        tail = NULL;
> +
> +        req = v9fs_twalk(v9p, 0, fid, 1, wnames, 0);
> +        v9fs_req_wait_for_reply(req, NULL);
> +        v9fs_rwalk(req, &nqid, NULL);
> +        g_assert_cmpint(nqid, ==, 1);
> +
> +        req = v9fs_tlopen(v9p, fid, O_DIRECTORY, 0);
> +        v9fs_req_wait_for_reply(req, NULL);
> +        v9fs_rlopen(req, &qid, NULL);
> +
> +        /*
> +         * send as many Treaddir requests as required to get all directory
> +         * entries
> +         */
> +        while (true) {
> +            npartialentries = 0;
> +            partialentries = NULL;
> +
> +            req = v9fs_treaddir(v9p, fid, offset, vcount[subtest], 0);
> +            v9fs_req_wait_for_reply(req, NULL);
> +            v9fs_rreaddir(req, &count, &npartialentries, &partialentries);
> +            if (npartialentries > 0 && partialentries) {
> +                if (!entries) {
> +                    entries = partialentries;
> +                    nentries = npartialentries;
> +                    tail = partialentries;
> +                } else {
> +                    tail->next = partialentries;
> +                    nentries += npartialentries;
> +                }
> +                while (tail->next) {
> +                    tail = tail->next;
> +                }
> +                offset = tail->offset;
> +            } else {
> +                break;
> +            }
> +        }
> +
> +        g_assert_cmpint(
> +            nentries, ==,
> +            QTEST_V9FS_SYNTH_READDIR_NFILES + 2 /* "." and ".." */
> +        );
> +
> +        /*
> +         * Check all file names exist in returned entries, ignore their order
> +         * though.
> +         */
> +        g_assert_cmpint(fs_dirents_contain_name(entries, "."), ==, true);
> +        g_assert_cmpint(fs_dirents_contain_name(entries, ".."), ==, true);
> +        for (int i = 0; i < QTEST_V9FS_SYNTH_READDIR_NFILES; ++i) {
> +            char *name = g_strdup_printf(QTEST_V9FS_SYNTH_READDIR_FILE, i);
> +            g_assert_cmpint(fs_dirents_contain_name(entries, name), ==, true);
> +            g_free(name);
> +        }
> +
> +        v9fs_free_dirents(entries);
> +    }
> +
> +    g_free(wnames[0]);
> +}
> +
>  static void fs_walk_no_slash(void *obj, void *data, QGuestAllocator *t_alloc)
>  {
>      QVirtio9P *v9p = obj;
> @@ -810,6 +900,7 @@ static void register_virtio_9p_test(void)
>      qos_add_test("fs/flush/ignored", "virtio-9p", fs_flush_ignored,
>                   NULL);
>      qos_add_test("fs/readdir/basic", "virtio-9p", fs_readdir, NULL);
> +    qos_add_test("fs/readdir/split", "virtio-9p", fs_readdir_split, NULL);
>  }
>  
>  libqos_init(register_virtio_9p_test);


