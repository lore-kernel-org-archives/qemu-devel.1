Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77854C282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 09:30:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45AE320880
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 09:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45AE320880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50033 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDQc3-0005ap-IS
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 05:30:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hDQXu-0001o5-TO
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:26:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hDQKb-0007gs-F9
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:12:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hDQKb-0007gO-4O; Mon, 08 Apr 2019 05:12:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3EBAB2D804;
	Mon,  8 Apr 2019 09:04:53 +0000 (UTC)
Received: from gondolin (ovpn-117-86.ams2.redhat.com [10.36.117.86])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C13E95D9C9;
	Mon,  8 Apr 2019 09:04:51 +0000 (UTC)
Date: Mon, 8 Apr 2019 11:04:48 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190408110448.4ac62234.cohuck@redhat.com>
In-Reply-To: <9223e19f-878f-636e-2c48-6d9e47485a65@redhat.com>
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-10-armbru@redhat.com>
	<9223e19f-878f-636e-2c48-6d9e47485a65@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Mon, 08 Apr 2019 09:04:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 09/15] s390x/kvm: Report warnings with
 warn_report(), not error_printf()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408090448.VtX3FNzcZPYq_6LVacomy28lB87eo08zD49HpBKC4bg@z>

On Mon, 8 Apr 2019 10:39:40 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 08/04/2019 10.36, Markus Armbruster wrote:
> > kvm_s390_mem_op() can fail in two ways: when !cap_mem_op, it returns
> > -ENOSYS, and when kvm_vcpu_ioctl() fails, it returns -errno set by
> > ioctl().  Its caller s390_cpu_virt_mem_rw() recovers from both
> > failures.
> > 
> > kvm_s390_mem_op() prints "KVM_S390_MEM_OP failed" with error_printf()
> > in the latter failure mode.  Since this is obviously a warning, use
> > warn_report().
> > 
> > Perhaps the reporting should be left to the caller.  It could warn on
> > failure other than -ENOSYS.
> > 
> > Cc: Thomas Huth <thuth@redhat.com>
> > Cc: qemu-s390x@nongnu.org
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > ---
> >  target/s390x/kvm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> > index 19530fb94e..2c6e35b5aa 100644
> > --- a/target/s390x/kvm.c
> > +++ b/target/s390x/kvm.c
> > @@ -782,7 +782,7 @@ int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_t ar, void *hostbuf,
> >  
> >      ret = kvm_vcpu_ioctl(CPU(cpu), KVM_S390_MEM_OP, &mem_op);
> >      if (ret < 0) {
> > -        error_printf("KVM_S390_MEM_OP failed: %s\n", strerror(-ret));
> > +        warn_report("KVM_S390_MEM_OP failed: %s", strerror(-ret));
> >      }
> >      return ret;
> >  }
> >   
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

(Markus, I think you wanted to take this?)

