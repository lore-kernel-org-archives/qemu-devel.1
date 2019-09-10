Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC6DC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:54:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31542206CD
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31542206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7cr7-0006pt-EI
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i7cqP-0006Ly-SZ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i7cqO-0001Hd-O2
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:53:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52794)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i7cqO-0001H2-Ip
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:53:52 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0B9E710E7A36;
 Tue, 10 Sep 2019 09:53:51 +0000 (UTC)
Received: from redhat.com (ovpn-112-58.ams2.redhat.com [10.36.112.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3AE29100194E;
 Tue, 10 Sep 2019 09:53:49 +0000 (UTC)
Date: Tue, 10 Sep 2019 10:53:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Message-ID: <20190910095346.GD8583@redhat.com>
References: <20190910090821.28327-1-sgarzare@redhat.com>
 <87mufc1nvd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87mufc1nvd.fsf@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Tue, 10 Sep 2019 09:53:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] elf-ops.h: fix int overflow in load_elf()
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 10, 2019 at 10:50:30AM +0100, Alex Benn=C3=A9e wrote:
>=20
> Stefano Garzarella <sgarzare@redhat.com> writes:
>=20
> > This patch fixes a possible integer overflow when we calculate
> > the total size of ELF segments loaded.
> >
> > Reported-by: Coverity (CID 1405299)
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> > Now we are limited to INT_MAX, should load_elf() returns ssize_t
> > to support bigger ELFs?
> > ---
> >  include/hw/elf_ops.h | 6 ++++++
> >  hw/core/loader.c     | 1 +
> >  2 files changed, 7 insertions(+)
> >
> > diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
> > index 1496d7e753..46dd3bf413 100644
> > --- a/include/hw/elf_ops.h
> > +++ b/include/hw/elf_ops.h
> > @@ -485,6 +485,12 @@ static int glue(load_elf, SZ)(const char *name, =
int fd,
> >                  }
> >              }
> >
> > +            if (mem_size > INT_MAX - total_size) {
> > +                error_report("ELF total segments size is too big to =
load "
> > +                             "max is %d)", INT_MAX);
> > +                goto fail;
> > +            }
> > +
>=20
> Seem sensible enough (although gah, I hate these glue bits). Would the
> large amount of goto fail logic be something that could be cleaned up
> with the automatic cleanup functions we recently mentioned in
> CODING_STYLE.rst?

The target has this:

 fail:
    g_mapped_file_unref(mapped_file);
    g_free(phdr);
    return ret;



GMappedFIle supports the  g_autoptr cleanup, and g_free is trivially
done with g_autofree.

So yes, you can entirely kill the goto's in this function using
auto cleanup

>=20
> Anyway:
>=20
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

