Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED74C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 18:03:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4598207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 18:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4598207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYCGq-0007im-Dh
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 14:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kYCG2-0007J1-31
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 14:02:42 -0400
Received: from 8.mo52.mail-out.ovh.net ([46.105.37.156]:33134)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kYCFz-0001KP-Kw
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 14:02:41 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.194])
 by mo52.mail-out.ovh.net (Postfix) with ESMTPS id 0877D1FEDE9;
 Thu, 29 Oct 2020 19:02:35 +0100 (CET)
Received: from kaod.org (37.59.142.101) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 29 Oct
 2020 19:02:35 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G004f820b469-dae6-4570-855e-0c7bdc0ab75d,
 E5CD8EB7A660BD10DDB00AFD0F9198C3FA657B0B) smtp.auth=groug@kaod.org
Date: Thu, 29 Oct 2020 19:02:34 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PULL v3 3/6] tests/9pfs: introduce local tests
Message-ID: <20201029190234.76bb51f4@bahia.lan>
In-Reply-To: <3a565c641a5c50bd6d0cb4df881b607a279505f6.1603111175.git.qemu_oss@crudebyte.com>
References: <cover.1603111175.git.qemu_oss@crudebyte.com>
 <3a565c641a5c50bd6d0cb4df881b607a279505f6.1603111175.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG5EX1.mxp5.local (172.16.2.41) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: d0281c6a-aae2-4606-9f4a-2e0f8de1bdfe
X-Ovh-Tracer-Id: 268808606053734877
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrleefgddutdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefuddtieejjeevheekieeltefgleetkeetheettdeifeffvefhffelffdtfeeljeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepphgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhordhorhhg
Received-SPF: pass client-ip=46.105.37.156; envelope-from=groug@kaod.org;
 helo=8.mo52.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 14:02:37
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 8 Oct 2020 20:34:56 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> This patch introduces 9pfs test cases using the 9pfs 'local'
> filesystem driver which reads/writes/creates/deletes real files
> and directories.
> 
> In this initial version, there is only one local test which actually
> only checks if the 9pfs 'local' device was created successfully.
> 
> Before the 9pfs 'local' tests are run, a test directory 'qtest-9p-local'
> is created (with world rwx permissions) under the current working
> directory. At this point that test directory is not auto deleted yet.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> Message-Id: <81fc4b3b6b6c9bf7999e79f5e7cbc364a5f09ddb.1602182956.git.qemu_oss@crudebyte.com>
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  tests/qtest/libqos/virtio-9p.c | 81 ++++++++++++++++++++++++++++++++++
>  tests/qtest/libqos/virtio-9p.h |  5 +++
>  tests/qtest/virtio-9p-test.c   | 44 ++++++++++++------
>  3 files changed, 116 insertions(+), 14 deletions(-)
> 
> diff --git a/tests/qtest/libqos/virtio-9p.c b/tests/qtest/libqos/virtio-9p.c
> index 2e300063e3..ee331166de 100644
> --- a/tests/qtest/libqos/virtio-9p.c
> +++ b/tests/qtest/libqos/virtio-9p.c
> @@ -24,6 +24,34 @@
>  #include "qgraph.h"
>  
>  static QGuestAllocator *alloc;
> +static char *local_test_path;
> +
> +/* Concatenates the passed 2 pathes. Returned result must be freed. */
> +static char *concat_path(const char* a, const char* b)
> +{
> +    return g_build_filename(a, b, NULL);
> +}
> +
> +static void init_local_test_path(void)
> +{
> +    char *pwd = g_get_current_dir();
> +    local_test_path = concat_path(pwd, "qtest-9p-local");
> +    g_free(pwd);
> +}
> +
> +/* Creates the directory for the 9pfs 'local' filesystem driver to access. */
> +static void create_local_test_dir(void)
> +{
> +    struct stat st;
> +
> +    g_assert(local_test_path != NULL);
> +    mkdir(local_test_path, 0777);
> +

This makes coverity unhappy...

*** CID 1435963:  Error handling issues  (CHECKED_RETURN)
/qemu/tests/qtest/libqos/virtio-9p.c: 48 in create_local_test_dir()
42     /* Creates the directory for the 9pfs 'local' filesystem driver to access. */
43     static void create_local_test_dir(void)
44     {
45         struct stat st;
46     
47         g_assert(local_test_path != NULL);
>>>     CID 1435963:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "mkdir(local_test_path, 511U)" without checking return value. This library function may fail and return an error code.  
48         mkdir(local_test_path, 0777);
49     
50         /* ensure test directory exists now ... */
51         g_assert(stat(local_test_path, &st) == 0);
52         /* ... and is actually a directory */
53         g_assert((st.st_mode & S_IFMT) == S_IFDIR);

> +    /* ensure test directory exists now ... */
> +    g_assert(stat(local_test_path, &st) == 0);
> +    /* ... and is actually a directory */
> +    g_assert((st.st_mode & S_IFMT) == S_IFDIR);
> +}
>  
>  static void virtio_9p_cleanup(QVirtio9P *interface)
>  {
> @@ -146,11 +174,64 @@ static void *virtio_9p_pci_create(void *pci_bus, QGuestAllocator *t_alloc,
>      return obj;
>  }
>  
> +/**
> + * Performs regular expression based search and replace on @a haystack.
> + *
> + * @param haystack - input string to be parsed, result of replacement is
> + *                   stored back to @a haystack
> + * @param pattern - the regular expression pattern for scanning @a haystack
> + * @param replace_fmt - matches of supplied @a pattern are replaced by this,
> + *                      if necessary glib printf format can be used to add
> + *                      variable arguments of this function to this
> + *                      replacement string
> + */
> +static void regex_replace(GString *haystack, const char *pattern,
> +                          const char *replace_fmt, ...)
> +{
> +    GRegex *regex;
> +    char *replace, *s;
> +    va_list argp;
> +
> +    va_start(argp, replace_fmt);
> +    replace = g_strdup_vprintf(replace_fmt, argp);
> +    va_end(argp);
> +
> +    regex = g_regex_new(pattern, 0, 0, NULL);
> +    s = g_regex_replace(regex, haystack->str, -1, 0, replace, 0, NULL);
> +    g_string_assign(haystack, s);
> +    g_free(s);
> +    g_regex_unref(regex);
> +    g_free(replace);
> +}
> +
> +void virtio_9p_assign_local_driver(GString *cmd_line, const char *args)
> +{
> +    g_assert_nonnull(local_test_path);
> +
> +    /* replace 'synth' driver by 'local' driver */
> +    regex_replace(cmd_line, "-fsdev synth,", "-fsdev local,");
> +
> +    /* append 'path=...' to '-fsdev ...' group */
> +    regex_replace(cmd_line, "(-fsdev \\w[^ ]*)", "\\1,path='%s'",
> +                  local_test_path);
> +
> +    if (!args) {
> +        return;
> +    }
> +
> +    /* append passed args to '-fsdev ...' group */
> +    regex_replace(cmd_line, "(-fsdev \\w[^ ]*)", "\\1,%s", args);
> +}
> +
>  static void virtio_9p_register_nodes(void)
>  {
>      const char *str_simple = "fsdev=fsdev0,mount_tag=" MOUNT_TAG;
>      const char *str_addr = "fsdev=fsdev0,addr=04.0,mount_tag=" MOUNT_TAG;
>  
> +    /* make sure test dir for the 'local' tests exists and is clean */
> +    init_local_test_path();
> +    create_local_test_dir();
> +
>      QPCIAddress addr = {
>          .devfn = QPCI_DEVFN(4, 0),
>      };
> diff --git a/tests/qtest/libqos/virtio-9p.h b/tests/qtest/libqos/virtio-9p.h
> index b1e6badc4a..326a603f72 100644
> --- a/tests/qtest/libqos/virtio-9p.h
> +++ b/tests/qtest/libqos/virtio-9p.h
> @@ -44,4 +44,9 @@ struct QVirtio9PDevice {
>      QVirtio9P v9p;
>  };
>  
> +/**
> + * Prepares QEMU command line for 9pfs tests using the 'local' fs driver.
> + */
> +void virtio_9p_assign_local_driver(GString *cmd_line, const char *args);
> +
>  #endif
> diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
> index 3281153b9c..af7e169d3a 100644
> --- a/tests/qtest/virtio-9p-test.c
> +++ b/tests/qtest/virtio-9p-test.c
> @@ -895,29 +895,45 @@ static void fs_readdir_split_512(void *obj, void *data,
>      fs_readdir_split(obj, data, t_alloc, 512);
>  }
>  
> +static void *assign_9p_local_driver(GString *cmd_line, void *arg)
> +{
> +    virtio_9p_assign_local_driver(cmd_line, "security_model=mapped-xattr");
> +    return arg;
> +}
> +
>  static void register_virtio_9p_test(void)
>  {
> -    qos_add_test("synth/config", "virtio-9p", pci_config, NULL);
> -    qos_add_test("synth/version/basic", "virtio-9p", fs_version, NULL);
> -    qos_add_test("synth/attach/basic", "virtio-9p", fs_attach, NULL);
> -    qos_add_test("synth/walk/basic", "virtio-9p", fs_walk, NULL);
> +
> +    QOSGraphTestOptions opts = {
> +    };
> +
> +    /* 9pfs test cases using the 'synth' filesystem driver */
> +    qos_add_test("synth/config", "virtio-9p", pci_config, &opts);
> +    qos_add_test("synth/version/basic", "virtio-9p", fs_version,  &opts);
> +    qos_add_test("synth/attach/basic", "virtio-9p", fs_attach,  &opts);
> +    qos_add_test("synth/walk/basic", "virtio-9p", fs_walk,  &opts);
>      qos_add_test("synth/walk/no_slash", "virtio-9p", fs_walk_no_slash,
> -                 NULL);
> +                  &opts);
>      qos_add_test("synth/walk/dotdot_from_root", "virtio-9p",
> -                 fs_walk_dotdot, NULL);
> -    qos_add_test("synth/lopen/basic", "virtio-9p", fs_lopen, NULL);
> -    qos_add_test("synth/write/basic", "virtio-9p", fs_write, NULL);
> +                 fs_walk_dotdot,  &opts);
> +    qos_add_test("synth/lopen/basic", "virtio-9p", fs_lopen,  &opts);
> +    qos_add_test("synth/write/basic", "virtio-9p", fs_write,  &opts);
>      qos_add_test("synth/flush/success", "virtio-9p", fs_flush_success,
> -                 NULL);
> +                  &opts);
>      qos_add_test("synth/flush/ignored", "virtio-9p", fs_flush_ignored,
> -                 NULL);
> -    qos_add_test("synth/readdir/basic", "virtio-9p", fs_readdir, NULL);
> +                  &opts);
> +    qos_add_test("synth/readdir/basic", "virtio-9p", fs_readdir,  &opts);
>      qos_add_test("synth/readdir/split_512", "virtio-9p",
> -                 fs_readdir_split_512, NULL);
> +                 fs_readdir_split_512,  &opts);
>      qos_add_test("synth/readdir/split_256", "virtio-9p",
> -                 fs_readdir_split_256, NULL);
> +                 fs_readdir_split_256,  &opts);
>      qos_add_test("synth/readdir/split_128", "virtio-9p",
> -                 fs_readdir_split_128, NULL);
> +                 fs_readdir_split_128,  &opts);
> +
> +
> +    /* 9pfs test cases using the 'local' filesystem driver */
> +    opts.before = assign_9p_local_driver;
> +    qos_add_test("local/config", "virtio-9p", pci_config,  &opts);
>  }
>  
>  libqos_init(register_virtio_9p_test);


