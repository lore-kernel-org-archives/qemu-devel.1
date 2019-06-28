Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77E9C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 12:56:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 716682133F
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 12:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="Fa4hfPPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716682133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgqQq-00071r-9w
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 08:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37400)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <qemu_oss@crudebyte.com>) id 1hgq7V-000638-Hx
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:36:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1hgq7T-0005Rm-6h
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:36:49 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:50737)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1hgq7S-0005Pi-Om
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=j9Bgeh5ORcS3zh5M01sP+j2waz3x7lPAVubYd65cf0o=; b=Fa4hfPPRjlpLF2iWGeIVVpydga
 rvKsKcQnMsCnJyWqOyphsaSDLfrq0UlDUUqdg6SwKn1OuBwVs5w9jHym0ToAtXScUo8csV3tndExI
 gPPtBOJC40qxFQm/G6oHdq32vojpcYRZuwScML4AMPoXJ5ujxQAS9QdHeKNii43cWLJ97Kico2mrx
 e3OuZ7uAhWlRBO+jOOwZ3E/j9kmkq6F3cu3X+OhxYkXjuaECsZ8irZvgZDXsPY5LaEK8oKNX1IJxL
 YdQQw54ttLzFxM/Il5i3Y2ImAkZ4pAxI/guK9c3mmjdXKGDBwE6gOjhVqzaFNy2nZsvbASI6v68oz
 Z7H6wKNfUordYdN4MYyHTBmsgWnB741R7h95B5hVEOe6X/ZJjdA2z5lnahJ2Bj2wz5Z4QYBfkV/mI
 lMolP5bURnufqR7aaWOe9/yUlJqqsZZMz9XDSU8v0nOkmq/1xF4ZkJzKCWfLMP/4+AukHsfG7AxMU
 25BUiBoejEugv14o6rzVvOKmSd8+P0cz3jvgjEJvWebGrMdj1PUxG3VlK17WV1yKFiJfQQxmR5cAb
 T4lKlCCHrTEjf8Hhlz2hplgwwOlm/qK2C8nFXYKw+gyhKYUgnICPWZSZltYgIxpGkY7ngBJnC21ay
 LnqZJOFFG6GL1B2z2+mu0YjVmx7ROTsW3ibEzbD3c=;
To: qemu-devel@nongnu.org
Date: Fri, 28 Jun 2019 14:36:41 +0200
Message-ID: <11832960.ASyAv1XfID@silver>
In-Reply-To: <20190627192622.6f49dc0a@bahia.lan>
References: <cover.1561575449.git.qemu_oss@crudebyte.com>
 <26b626706b5fa0c492413a3279512c17952be5de.1561575449.git.qemu_oss@crudebyte.com>
 <20190627192622.6f49dc0a@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.189.157.229
Subject: Re: [Qemu-devel] [PATCH v4 2/5] 9p: Treat multiple devices on one
 export as an error
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
From: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Greg Kurz <groug@kaod.org>, Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Donnerstag, 27. Juni 2019 19:26:22 CEST Greg Kurz wrote:
> On Wed, 26 Jun 2019 20:30:41 +0200
> 
> Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org> wrote:
> > The QID path should uniquely identify a file. However, the
> > inode of a file is currently used as the QID path, which
> > on its own only uniquely identifies wiles within a device.
> 
> s/wile/files

Ah right. :)

> > Here we track the device hosting the 9pfs share, in order
> > to prevent security issues with QID path collisions from
> > other devices.
> > 
> > Signed-off-by: Antonios Motakis <antonios.motakis@huawei.com>
> 
> You should mention here the changes you made to the original patch.

Got it. Will do for the other cases as well of course.

> > -static void stat_to_qid(const struct stat *stbuf, V9fsQID *qidp)
> > +static int stat_to_qid(V9fsPDU *pdu, const struct stat *stbuf, V9fsQID
> > *qidp)> 
> >  {
> >  
> >      size_t size;
> > 
> > +    if (pdu->s->dev_id == 0) {
> > +        pdu->s->dev_id = stbuf->st_dev;
> 
> st_dev should be captured in v9fs_device_realize_common() since we
> lstat() the root there, instead of every request doing the check.

Ok.

> > +    } else if (pdu->s->dev_id != stbuf->st_dev) {
> > +        error_report_once(
> > +            "9p: Multiple devices detected in same VirtFS export. "
> > +            "You must use a separate export for each device."
> > +        );
> > +        return -ENOSYS;
> 
> This error is likely to end up as the return value of a
> syscall in the guest and -ENOSYS usually means the syscall
> isn't implemented, which is obviously not the case. Maybe
> return -EPERM instead ?

I would rather suggest -ENODEV. The entire device of the requested file/dir is 
not available on guest.

-EPERM IMO rather motivates users looking for file system permission settings 
on individual files intead, and probably not checking the host's logs for the 
detailled error message.

> > @@ -3633,6 +3674,8 @@ int v9fs_device_realize_common(V9fsState *s, const
> > V9fsTransport *t,> 
> >          goto out;
> >      
> >      }
> > 
> > +    s->dev_id = 0;
> > +
> 
> Set it to stat->st_dev after lstat() was called later in this function.

I guesst you mean "earlier" not "later". The lstat() call is just before that 
dev_id initalization line. But in general your suggestion makes sense of 
course.

Best regards,
Christian Schoenebeck

