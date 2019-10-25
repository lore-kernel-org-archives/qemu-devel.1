Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D01CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:29:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BBDF21D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i4TEQpw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BBDF21D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNzeZ-0001Tx-NX
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 09:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33465)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iNzY4-0007U0-6y
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:22:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iNzY0-00059p-5H
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:22:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42185
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iNzXy-00058X-BW
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572009747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TXoeupEoqztpAAd5CgTj1cBSD9Wcv3BgFKcqST9xO2c=;
 b=i4TEQpw5C4+lbVzdAOUrkK4Tt3SZS0ceMMogQpK1mNpb6lgi8QEyyWt5kRp/2W5w5Kp+6w
 Wyn9J5f0S/ttsgRv3ohdN8KJAhfIYtsBXkL6SSstdRJ6KWIKWRyLTkmlF80Um678i7FuvV
 ZCLF9f35LklqQGBliVrR29Tq3i0665c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-GczJZsPlMUmnpCLSWxkQUA-1; Fri, 25 Oct 2019 09:22:24 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 567FD1800DCA;
 Fri, 25 Oct 2019 13:22:22 +0000 (UTC)
Received: from localhost (ovpn-116-62.gru2.redhat.com [10.97.116.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D053760BFB;
 Fri, 25 Oct 2019 13:22:16 +0000 (UTC)
Date: Fri, 25 Oct 2019 10:22:15 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, Jiri Denemark <jdenemar@redhat.com>
Subject: Re: [PATCH 7/7] cpu: Add `machine` parameter to query-cpu-definitions
Message-ID: <20191025132215.GC6744@habkost.net>
References: <20191025022553.25298-1-ehabkost@redhat.com>
 <20191025022553.25298-8-ehabkost@redhat.com>
 <8736fhmius.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <8736fhmius.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: GczJZsPlMUmnpCLSWxkQUA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>, libvir-list@redhat.com,
 David Hildenbrand <david@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CCing libvir-list.

On Fri, Oct 25, 2019 at 08:36:59AM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> > The new parameter can be used by management software to query for
> > CPU model alias information for multiple machines without
> > restarting QEMU.
[...]
> > @@ -317,9 +321,17 @@
>    ##
>    # @query-cpu-definitions:
> >  #
> >  # Return a list of supported virtual CPU definitions
> >  #
> > +# @machine: Name of machine type.  The command returns some data
> > +#           that machine-specific.  This overrides the machine type
>=20
> "that is machine-specific"
>=20
> > +#           used to look up that information.  This can be used,
> > +#           for example, to query machine-specific CPU model aliases
> > +#           without restarting QEMU (since 4.2)
> > +#
> >  # Returns: a list of CpuDefInfo
> >  #
> >  # Since: 1.2.0
> >  ##
> > -{ 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo']=
,
> > +{ 'command': 'query-cpu-definitions',
> > +  'data': { '*machine': 'str' },
> > +  'returns': ['CpuDefinitionInfo'],
> >    'if': 'defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_=
I386) || defined(TARGET_S390X) || defined(TARGET_MIPS)' }
>=20
> I'm afraid the doc comment is less than clear.  Before I can suggest
> improvements, I have questions.
>=20
> Looks like @alias-of is the only part of the return value that changes
> when I re-run query-cpu-definitions with another @machine argument.
> Correct?

Yes.

>=20
> How is this going to be used?  Will management software run
> query-cpu-definitions for each machine type returned by query-machines?
> Or just for a few of them?

I don't know.  I'll let Jiri and other libvirt developers answer
that.

--=20
Eduardo


