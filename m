Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21233C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 13:02:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E81A220B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 13:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E81A220B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw4XJ-00040b-8Q
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 09:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54989)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hw4Wd-00036l-JJ
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 09:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hw4Wc-0001SN-Ik
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 09:01:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49210)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>)
 id 1hw4WY-0001OX-D0; Fri, 09 Aug 2019 09:01:38 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0D63730BEBEE;
 Fri,  9 Aug 2019 13:01:36 +0000 (UTC)
Received: from redhat.com (ovpn-116-49.ams2.redhat.com [10.36.116.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CDEC19C70;
 Fri,  9 Aug 2019 13:01:34 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
In-Reply-To: <CAFEAcA-YjLA25wPBgWOB_c2fV2o7C8n=1-uUVe6xgiP=j5+Fgw@mail.gmail.com>
 (Peter Maydell's message of "Fri, 9 Aug 2019 11:32:51 +0100")
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-8-damien.hedde@greensocs.com>
 <CAFEAcA-W0SaaGbUnGZ0b61ngxKY8R9xjwGXeN+=MaUi4bMDgNg@mail.gmail.com>
 <20190808154219.GK2852@work-vm>
 <CAFEAcA8L2YVMCu3Gb+eQTDfCpgVwA_WwVPrqPLV2iQ9rZ4HuTA@mail.gmail.com>
 <f400248f-7a3b-83e9-3355-77de359e3f43@greensocs.com>
 <CAFEAcA-YjLA25wPBgWOB_c2fV2o7C8n=1-uUVe6xgiP=j5+Fgw@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Fri, 09 Aug 2019 15:01:30 +0200
Message-ID: <87imr6332t.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 09 Aug 2019 13:01:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 07/33] automatically add vmstate for
 reset support in devices
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
Reply-To: quintela@redhat.com
Cc: Fam Zheng <fam@euphon.net>, Collin Walling <walling@linux.ibm.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>, Hannes Reinecke <hare@suse.com>,
 Qemu-block <qemu-block@nongnu.org>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Damien Hedde <damien.hedde@greensocs.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Mark Burton <mark.burton@greensocs.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> wrote:
> On Fri, 9 Aug 2019 at 11:29, Damien Hedde <damien.hedde@greensocs.com> wrote:
>>
>> One way to keep the feature without copy-pasting vmsd would be to add
>> a new vmstate_register with an additional argument to pass the base
>> class vmsd section and handle the whole thing there.
>
> If we have a vmstate section which contains no actual data,
> only subsections with 'needed' functions, is it migration
> compatible with previous versions in the same way that
> tacking a subsection onto an existing function is?

Not now, but we can make it happen.

Right now, we first send the VMSD "header", and then we sent whatever
data is in it.

We can it make work the way you want.  Not sure if that is the best way,
though.  Sections that can(or can't) be there make just reasoning about
the stream more difficult.

Later, Juan.

