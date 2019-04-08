Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5250C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 12:34:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8972921473
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 12:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8972921473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52409 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDTTq-0001TI-Ny
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 08:34:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDTSK-0000Yq-Vk
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 08:32:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDTSJ-0003ES-R6
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 08:32:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hDTSJ-0003E5-ES; Mon, 08 Apr 2019 08:32:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9DA3559468;
	Mon,  8 Apr 2019 12:32:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6AC871001DE3;
	Mon,  8 Apr 2019 12:32:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 33BBF1138648; Mon,  8 Apr 2019 14:32:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-10-armbru@redhat.com>
	<9223e19f-878f-636e-2c48-6d9e47485a65@redhat.com>
	<20190408110448.4ac62234.cohuck@redhat.com>
Date: Mon, 08 Apr 2019 14:32:53 +0200
In-Reply-To: <20190408110448.4ac62234.cohuck@redhat.com> (Cornelia Huck's
	message of "Mon, 8 Apr 2019 11:04:48 +0200")
Message-ID: <877ec4r822.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Mon, 08 Apr 2019 12:32:54 +0000 (UTC)
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
Message-ID: <20190408123253.YZkrclkE8r9z1T2R1MODZN8hQyyEidRcr9jSxjh53AU@z>

Cornelia Huck <cohuck@redhat.com> writes:

> On Mon, 8 Apr 2019 10:39:40 +0200
> Thomas Huth <thuth@redhat.com> wrote:
>
>> On 08/04/2019 10.36, Markus Armbruster wrote:
>> > kvm_s390_mem_op() can fail in two ways: when !cap_mem_op, it returns
>> > -ENOSYS, and when kvm_vcpu_ioctl() fails, it returns -errno set by
>> > ioctl().  Its caller s390_cpu_virt_mem_rw() recovers from both
>> > failures.
>> > 
>> > kvm_s390_mem_op() prints "KVM_S390_MEM_OP failed" with error_printf()
>> > in the latter failure mode.  Since this is obviously a warning, use
>> > warn_report().
>> > 
>> > Perhaps the reporting should be left to the caller.  It could warn on
>> > failure other than -ENOSYS.
>> > 
>> > Cc: Thomas Huth <thuth@redhat.com>
>> > Cc: qemu-s390x@nongnu.org
>> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> > ---
>> >  target/s390x/kvm.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > 
>> > diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> > index 19530fb94e..2c6e35b5aa 100644
>> > --- a/target/s390x/kvm.c
>> > +++ b/target/s390x/kvm.c
>> > @@ -782,7 +782,7 @@ int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_t ar, void *hostbuf,
>> >  
>> >      ret = kvm_vcpu_ioctl(CPU(cpu), KVM_S390_MEM_OP, &mem_op);
>> >      if (ret < 0) {
>> > -        error_printf("KVM_S390_MEM_OP failed: %s\n", strerror(-ret));
>> > +        warn_report("KVM_S390_MEM_OP failed: %s", strerror(-ret));
>> >      }
>> >      return ret;
>> >  }
>> >   
>> 
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>
> (Markus, I think you wanted to take this?)

I intend to take the complete series through my tree if nobody objects.

Thanks!

