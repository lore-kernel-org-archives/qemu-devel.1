Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70872C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 11:56:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97FA220709
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 11:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="P0lKd/4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FA220709
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTkpE-0002mw-KO
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 07:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kTkoQ-0002OB-QW
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 07:55:52 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:50787)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kTkoO-0006JQ-5k
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 07:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=afH06NDMUBW1rv91txIHyFgxlFgzdqOFMCFgFiSL5kI=; b=P0lKd/4elE21OdDpE8Gf1Yvlsu
 AqXVm22vKf1pg5CMCSLEveijoIG1qU08Wcrc5bKv5fPpExn7ntZIPII3xdAhd/wMP7OhVtbqpb/QZ
 /x2ZFgAwa9AuQ0QNqhrxdgHLReOyiYBpNYaTOHq0J8wfsDgqNbesJHFyhKzMiDLDXF5bhsSl5sjc8
 ETLlXIx+lOjyS9bXHAQSuzLbXSi2nlfaXedZ/7AQUmt8vK7KHsnSvmiV1KEy0Jq17yktQb46v9uG6
 qf6+xWgn9FSgrvQADv88CaO1u/OkE4P7Q56fnt/4Hb9zDqNrjzePIBRZnXHr9jTwsTUDtCvpqbT+k
 z6wpqZ5A==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>
Subject: Re: [PULL 0/5] 9p queue 2020-10-15
Date: Sat, 17 Oct 2020 13:55:42 +0200
Message-ID: <5809478.Xo1ZfStJPt@silver>
In-Reply-To: <CAFEAcA_ygiXU=Lh1iOPUDOsXu-cuVze-wDhc90wZ+r7C-BBesA@mail.gmail.com>
References: <cover.1602771296.git.qemu_oss@crudebyte.com>
 <CAFEAcA_ygiXU=Lh1iOPUDOsXu-cuVze-wDhc90wZ+r7C-BBesA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/17 07:55:44
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

On Samstag, 17. Oktober 2020 12:50:13 CEST Peter Maydell wrote:
> On Thu, 15 Oct 2020 at 22:04, Christian Schoenebeck
> 
> <qemu_oss@crudebyte.com> wrote:
> > The following changes since commit 
57c98ea9acdcef5021f5671efa6475a5794a51c4:
> >   Merge remote-tracking branch
> >   'remotes/kraxel/tags/ui-20201014-pull-request' into staging (2020-10-14
> >   13:56:06 +0100)> 
> > are available in the Git repository at:
> >   https://github.com/cschoenebeck/qemu.git tags/pull-9p-20201015
> > 
> > for you to fetch changes up to 97a64ec211d051439b654950ed3f7cffc47d489b:
> >   tests/9pfs: add local Tmkdir test (2020-10-15 16:11:17 +0200)
> > 
> > ----------------------------------------------------------------
> > 9pfs: add tests using local fs driver
> > 
> > The currently existing 9pfs test cases are all solely using the 9pfs
> > 'synth' fileystem driver, which is a very simple and purely simulated (in
> > RAM only) filesystem. There are issues though where the 'synth' fs driver
> > is not sufficient. For example the following two bugs need test cases
> > running the 9pfs 'local' fs driver:
> > 
> > https://bugs.launchpad.net/qemu/+bug/1336794
> > https://bugs.launchpad.net/qemu/+bug/1877384
> > 
> > This patch set for that reason introduces 9pfs test cases using the 9pfs
> > 'local' filesystem driver along to the already existing tests on 'synth'.
> 
> Build failure, OSX:
> 
> Compiling C object tests/qtest/libqos/libqos.fa.p/virtio-9p.c.o
> ../../tests/qtest/libqos/virtio-9p.c:37:17: error: implicit
> declaration of function 'get_current_dir_name' is invalid in C99
> [-Werror,-Wimplicit-function-declaration]
>     char *pwd = get_current_dir_name();
>                 ^
> ../../tests/qtest/libqos/virtio-9p.c:37:17: error: this function
> declaration is not a prototype [-Werror,-Wstrict-prototypes]
> ../../tests/qtest/libqos/virtio-9p.c:37:11: error: incompatible
> integer to pointer conversion initializing 'char *' with an expression
> of type 'int' [-Werror,-Wint-conversion]
>     char *pwd = get_current_dir_name();
> 
> 
> thanks
> -- PMM

Oops, get_current_dir_name() is a GNU extension. I just enabled Cirrus-CI to 
prevent this from happening again. Sorry Peter.

Am I supposed to rebase for v2 PRs?

Fix for this is currently test running:

> index 1524982634..d43647b3b7 100644
> --- a/tests/qtest/libqos/virtio-9p.c
> +++ b/tests/qtest/libqos/virtio-9p.c
> @@ -34,9 +34,9 @@ static char *concat_path(const char* a, const char* b)
> 
>  static void init_local_test_path(void)
>  {
> 
> -    char *pwd = get_current_dir_name();
> +    char *pwd = g_get_current_dir();
> 
>      local_test_path = concat_path(pwd, "qtest-9p-local");
> 
> -    free(pwd);
> +    g_free(pwd);
> 
>  }
>  
>  /* Creates the directory for the 9pfs 'local' filesystem driver to access.
>  */

Best regards,
Christian Schoenebeck



