Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91720C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 09:58:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65B5126748
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 09:58:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B5126748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39392 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWeIV-0007M7-Gv
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 05:58:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hWeHj-00073M-Td
	for qemu-devel@nongnu.org; Fri, 31 May 2019 05:57:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hWeHi-0001WC-Uq
	for qemu-devel@nongnu.org; Fri, 31 May 2019 05:57:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hWeHi-0001SJ-P1
	for qemu-devel@nongnu.org; Fri, 31 May 2019 05:57:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8CE2AC130719;
	Fri, 31 May 2019 09:57:01 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8BB8B60C9F;
	Fri, 31 May 2019 09:56:59 +0000 (UTC)
Date: Fri, 31 May 2019 11:56:55 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Michael Rolnik <mrolnik@gmail.com>
Message-ID: <20190531115655.0c0c85ef@redhat.com>
In-Reply-To: <CAK4993h5ddy0jA6_Yp-vHgDpg8nwcoqg2W+uTn45mAcHEPXSqA@mail.gmail.com>
References: <20190530190738.22713-1-mrolnik@gmail.com>
	<20190530190738.22713-2-mrolnik@gmail.com>
	<20190531100237.138a9113@redhat.com>
	<CAK4993h5ddy0jA6_Yp-vHgDpg8nwcoqg2W+uTn45mAcHEPXSqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Fri, 31 May 2019 09:57:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH RFC v20 1/8] target/avr: Add outward facing
 interfaces and core CPU logic
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 31 May 2019 11:15:01 +0300
Michael Rolnik <mrolnik@gmail.com> wrote:

> Hi Igor.
> 
> Please explain what I should do.
Maybe look at inline comments which are somewhere in the body of reply.

> thank you,
> Michael
> 
> On Fri, May 31, 2019 at 11:02 AM Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Thu, 30 May 2019 22:07:31 +0300
> > Michael Rolnik <mrolnik@gmail.com> wrote:
[...]

> > > +static ObjectClass *avr_cpu_class_by_name(const char *cpu_model)
> > > +{
> > > +    ObjectClass *oc;
> > > +    char *name;
> > > +
> > > +    if (!cpu_model) {
> > > +        return NULL;
> > > +    }
> > > +
> > > +    oc = object_class_by_name(cpu_model);
> > > +    if (oc != NULL && object_class_dynamic_cast(oc, TYPE_AVR_CPU) !=  
> > NULL &&  
> > > +        !object_class_is_abstract(oc)) {
> > > +        return oc;
> > > +    }  
> >
> > In other targets QEMU has 1-2 or more naming variants but that were
> > influenced
> > by legacy code and we have to keep compatibility not to break existing
> > configurations.
> >
> > In case of new cpu, I'd keep only above hunk and drop the rest so that
> > only one naming scheme would be available, which is compatible with
> > '-device' naming and QMP/monitor interfaces that we support.
> >

I've suggested to leave only above hunk and drop following hunk.
this way only full cpu type name will be accepted by '-cpu'

> > > +    name = g_strdup_printf(AVR_CPU_TYPE_NAME("%s"), cpu_model);
> > > +    oc = object_class_by_name(name);
> > > +    g_free(name);
> > > +    if (oc != NULL && object_class_dynamic_cast(oc, TYPE_AVR_CPU) !=  
> > NULL &&  
> > > +        !object_class_is_abstract(oc)) {
> > > +        return oc;
> > > +    }

since suffix trick will be removed, you'll probably need to
amend/simplify avr_cpu_list_entry() as well.

> > > +    return NULL;
> > > +}
> > > +
[...]


