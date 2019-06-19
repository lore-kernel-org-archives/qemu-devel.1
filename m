Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73ACC31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 10:49:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E7F12080C
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 10:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E7F12080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36790 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdY9g-0003pT-ER
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 06:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60565)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hdY8c-0003Bp-Hh
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 06:48:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hdY8b-0001sn-AD
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 06:48:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47310)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hdY8Y-0001nG-EB; Wed, 19 Jun 2019 06:48:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 81CF23087944;
 Wed, 19 Jun 2019 10:48:13 +0000 (UTC)
Received: from dhcp-4-67.tlv.redhat.com (dhcp-4-67.tlv.redhat.com [10.35.4.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B41260DDF;
 Wed, 19 Jun 2019 10:48:03 +0000 (UTC)
Message-ID: <37b2f424befe7b44a4c128b5dfae9af685abaf04.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 19 Jun 2019 13:48:02 +0300
In-Reply-To: <20190619102434.GC13569@stefanha-x1.localdomain>
References: <20190610134905.22294-1-mehta.aaru20@gmail.com>
 <20190610134905.22294-8-mehta.aaru20@gmail.com>
 <dc84836e922049a290ea900be3cb542b3cc1a1ab.camel@redhat.com>
 <20190619102434.GC13569@stefanha-x1.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Wed, 19 Jun 2019 10:48:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 07/12] blockdev: accept io_uring as
 option
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, saket.sinha89@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-06-19 at 11:24 +0100, Stefan Hajnoczi wrote:
> On Mon, Jun 17, 2019 at 04:01:45PM +0300, Maxim Levitsky wrote:
> > On Mon, 2019-06-10 at 19:19 +0530, Aarushi Mehta wrote:
> > > Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > >  blockdev.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/blockdev.c b/blockdev.c
> > > index 3f44b891eb..a2a5b32604 100644
> > > --- a/blockdev.c
> > > +++ b/blockdev.c
> > > @@ -386,6 +386,8 @@ static void extract_common_blockdev_options(QemuOpts *opts, int *bdrv_flags,
> > >          if ((aio = qemu_opt_get(opts, "aio")) != NULL) {
> > >              if (!strcmp(aio, "native")) {
> > >                  *bdrv_flags |= BDRV_O_NATIVE_AIO;
> > > +            } else if (!strcmp(aio, "io_uring")) {
> > > +                *bdrv_flags |= BDRV_O_IO_URING;
> > >              } else if (!strcmp(aio, "threads")) {
> > >                  /* this is the default */
> > >              } else {
> > > @@ -4579,7 +4581,7 @@ QemuOptsList qemu_common_drive_opts = {
> > >          },{
> > >              .name = "aio",
> > >              .type = QEMU_OPT_STRING,
> > > -            .help = "host AIO implementation (threads, native)",
> > > +            .help = "host AIO implementation (threads, native, io_uring)",
> > >          },{
> > >              .name = BDRV_OPT_CACHE_WB,
> > >              .type = QEMU_OPT_BOOL,
> > 
> > Nitpick: Maybe we should rename the native to libaio (accept both but give an deprication warning)?
> 
> "libaio" is a clearer name but I'm afraid changing it or introducing a
> new name is not worth it with so many users, command-lines, scripts, and
> management tools that know about "native".  Having two names that mean
> the same thing might cause confusion.
> 
> Let's leave it as is.
> 
I won't argue about this, also this can also be done later.

Best regards,
	Maxim Levitsky


