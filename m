Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83055C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 18:19:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54E15206B2
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 18:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="A0FpDgDZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E15206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYCVw-0007s1-A3
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 14:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kYCTe-0006gX-Oi
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 14:16:48 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:41117)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kYCTc-0003N7-C1
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 14:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=Yj5WgYqYCP2DpZYYl8HK/yBYW5NnIAAEzB29evMB1aM=; b=A0FpDgDZ/t7MOsM9qF7wRZqnQs
 P4db3EOLJIKjgMQehprQew99+jLRs/8HVBvPCbRR9JUSkXI/fiRJg0YO531ipHuRthIjcQXoPxYVK
 i50VtZ0wrdbJuRyCpt7JikdzstFAnmQNTTpVnH8NVsPtTc7k9r/OFIHZUKYVKPZ0HLDzetbxYSk8b
 tLZ+1dPH8dBzpgliGugoLXfMhmg4enW2vESyysuIVsaDDFqrv9tV4hVgymb9eOTlagsRi2pQLxeHV
 G2BvbZWJPMCVf2B9znPiGYXDO7+cb2dmyB3W6Zk72xL31biB0WmdLGN+qWac3i5zYrgojs1CM8n/V
 3TXCuE5w==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL v3 3/6] tests/9pfs: introduce local tests
Date: Thu, 29 Oct 2020 19:16:40 +0100
Message-ID: <2639493.ej0QF1Rjni@silver>
In-Reply-To: <20201029190234.76bb51f4@bahia.lan>
References: <cover.1603111175.git.qemu_oss@crudebyte.com>
 <3a565c641a5c50bd6d0cb4df881b607a279505f6.1603111175.git.qemu_oss@crudebyte.com>
 <20201029190234.76bb51f4@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 13:27:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Donnerstag, 29. Oktober 2020 19:02:34 CET Greg Kurz wrote:
> On Thu, 8 Oct 2020 20:34:56 +0200
> 
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > This patch introduces 9pfs test cases using the 9pfs 'local'
> > filesystem driver which reads/writes/creates/deletes real files
> > and directories.
> > 
> > In this initial version, there is only one local test which actually
> > only checks if the 9pfs 'local' device was created successfully.
> > 
> > Before the 9pfs 'local' tests are run, a test directory 'qtest-9p-local'
> > is created (with world rwx permissions) under the current working
> > directory. At this point that test directory is not auto deleted yet.
> > 
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > Message-Id:
> > <81fc4b3b6b6c9bf7999e79f5e7cbc364a5f09ddb.1602182956.git.qemu_oss@crudeby
> > te.com> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> > 
> >  tests/qtest/libqos/virtio-9p.c | 81 ++++++++++++++++++++++++++++++++++
> >  tests/qtest/libqos/virtio-9p.h |  5 +++
> >  tests/qtest/virtio-9p-test.c   | 44 ++++++++++++------
> >  3 files changed, 116 insertions(+), 14 deletions(-)
> > 
> > diff --git a/tests/qtest/libqos/virtio-9p.c
> > b/tests/qtest/libqos/virtio-9p.c index 2e300063e3..ee331166de 100644
> > --- a/tests/qtest/libqos/virtio-9p.c
> > +++ b/tests/qtest/libqos/virtio-9p.c
> > @@ -24,6 +24,34 @@
> > 
> >  #include "qgraph.h"
> >  
> >  static QGuestAllocator *alloc;
> > 
> > +static char *local_test_path;
> > +
> > +/* Concatenates the passed 2 pathes. Returned result must be freed. */
> > +static char *concat_path(const char* a, const char* b)
> > +{
> > +    return g_build_filename(a, b, NULL);
> > +}
> > +
> > +static void init_local_test_path(void)
> > +{
> > +    char *pwd = g_get_current_dir();
> > +    local_test_path = concat_path(pwd, "qtest-9p-local");
> > +    g_free(pwd);
> > +}
> > +
> > +/* Creates the directory for the 9pfs 'local' filesystem driver to
> > access. */ +static void create_local_test_dir(void)
> > +{
> > +    struct stat st;
> > +
> > +    g_assert(local_test_path != NULL);
> > +    mkdir(local_test_path, 0777);
> > +
> 
> This makes coverity unhappy...
> 
> *** CID 1435963:  Error handling issues  (CHECKED_RETURN)
> /qemu/tests/qtest/libqos/virtio-9p.c: 48 in create_local_test_dir()
> 42     /* Creates the directory for the 9pfs 'local' filesystem driver to
> access. */ 43     static void create_local_test_dir(void)
> 44     {
> 45         struct stat st;
> 46
> 47         g_assert(local_test_path != NULL);
> 
> >>>     CID 1435963:  Error handling issues  (CHECKED_RETURN)
> >>>     Calling "mkdir(local_test_path, 511U)" without checking return
> >>>     value. This library function may fail and return an error code.
> 48         mkdir(local_test_path, 0777);
> 49
> 50         /* ensure test directory exists now ... */
> 51         g_assert(stat(local_test_path, &st) == 0);
> 52         /* ... and is actually a directory */
> 53         g_assert((st.st_mode & S_IFMT) == S_IFDIR);
> 
> > +    /* ensure test directory exists now ... */
> > +    g_assert(stat(local_test_path, &st) == 0);
> > +    /* ... and is actually a directory */
> > +    g_assert((st.st_mode & S_IFMT) == S_IFDIR);
> > +}
> > 

Ok, I'll fix that with tomorrow's patch(es) as well.

Best regards,
Christian Schoenebeck



