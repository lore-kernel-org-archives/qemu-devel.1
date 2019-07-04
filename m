Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E3AC0650E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 07:34:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87588218A3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 07:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87588218A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiwGf-0001sa-Vd
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 03:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47715)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hiwFM-00012O-DY
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 03:33:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hiwFL-0008KX-FC
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 03:33:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47206)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hiwFL-0008Jl-9R
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 03:33:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 10B10368A5
 for <qemu-devel@nongnu.org>; Thu,  4 Jul 2019 07:33:29 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 726C318360;
 Thu,  4 Jul 2019 07:33:27 +0000 (UTC)
Date: Thu, 4 Jul 2019 09:33:22 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190704093322.04d78d48@redhat.com>
In-Reply-To: <20190703193702.GA5198@habkost.net>
References: <20190702215726.23661-1-ehabkost@redhat.com>
 <20190703154723.7327-1-imammedo@redhat.com>
 <20190703193702.GA5198@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 04 Jul 2019 07:33:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] tests: numa-test: use -numa memdev
 option instead of legacy 'mem' option
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

On Wed, 3 Jul 2019 16:37:02 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Wed, Jul 03, 2019 at 11:47:23AM -0400, Igor Mammedov wrote:
> > it drops testing of deprecated 'mem' option and will test preferred memdev
> > option instead.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > v2:
> >   - make backend size depend on initial RAM size and a number of backends
> >     fixes test faulure with spapr machine (Eduardo Habkost <ehabkost@redhat.com>)
> > 
> >  tests/numa-test.c | 85 +++++++++++++++++++++++++++++------------------
> >  1 file changed, 52 insertions(+), 33 deletions(-)
> > 
> > diff --git a/tests/numa-test.c b/tests/numa-test.c
> > index 8de8581231..e102b3b70f 100644
> > --- a/tests/numa-test.c
> > +++ b/tests/numa-test.c
> > @@ -14,9 +14,28 @@
> >  #include "qapi/qmp/qdict.h"
> >  #include "qapi/qmp/qlist.h"
> >  
> > -static char *make_cli(const char *generic_cli, const char *test_cli)
> > +typedef struct {
> > +    const char *args;
> > +    int ram_size; /* size in MB */
> > +} TestData;
> > +
> > +static char *make_cli(const TestData *data, int memdev_count,
> > +                      const char *test_cli)
> >  {
> > -    return g_strdup_printf("%s %s", generic_cli ? generic_cli : "", test_cli);
> > +    int i;
> > +    char *tmp = NULL;
> > +    char *cli = g_strdup_printf("%s -m %d", data->args ? : "", data->ram_size);
> > +
> > +    for (i = 0; memdev_count && (i < memdev_count); i++) {
> > +        tmp = g_strdup_printf("%s -object memory-backend-ram,id=r%d,size=%dM",
> > +                              cli, i, data->ram_size / memdev_count);
> > +        g_free(cli);
> > +        cli = tmp;
> > +    }
> > +    tmp = g_strdup_printf("%s %s", cli, test_cli);
> > +    g_free(cli);
> > +    cli = tmp;
> > +    return cli;
> >  }  
> [...]
> > +    TestData data = { .ram_size = 128 };
> >  
> > -    if (strcmp(arch, "aarch64") == 0) {
> > -        args = "-machine virt";
> > +    if (!strcmp(arch, "aarch64")) {
> > +        data.args = "-machine virt";
> > +    } else if (!strcmp(arch, "ppc64")) {
> > +        data.ram_size = 512;  
> 
> Wouldn't it be simpler to always use "-m 512M" and the same node
> sizes?
it would, but it might make some CI instances start failing more
often where it used to work before. So I picked side of being
conservative and not to hog memory unless it's necessary.


