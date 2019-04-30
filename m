Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DA0C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 07:15:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF85A2075E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 07:15:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF85A2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40272 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLMyy-0005ZM-UA
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 03:15:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hLMxm-00057g-Ne
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 03:14:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hLMxl-0003qY-Py
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 03:14:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hLMxl-0003q6-JY; Tue, 30 Apr 2019 03:14:01 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D7D093086201;
	Tue, 30 Apr 2019 07:13:59 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7B2AA79BD;
	Tue, 30 Apr 2019 07:13:55 +0000 (UTC)
Date: Tue, 30 Apr 2019 09:13:54 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190430091354.23c9aca0.cohuck@redhat.com>
In-Reply-To: <6e6c4b4e-4d08-b4fa-1092-06567a6473da@redhat.com>
References: <20190429090250.7648-1-borntraeger@de.ibm.com>
	<20190429090250.7648-5-borntraeger@de.ibm.com>
	<0ad32bcf-0132-3905-3220-0f50e26937c3@redhat.com>
	<b0b0ec8f-d5ee-c08f-11dd-894d9433159f@de.ibm.com>
	<6e6c4b4e-4d08-b4fa-1092-06567a6473da@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Tue, 30 Apr 2019 07:13:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 4/9] s390x/cpumodel: msa9 facility
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
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>,
	Collin Walling <walling@linux.ibm.com>, qemu-devel <qemu-devel@nongnu.org>,
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430071354.l_Gzgx6i2XSiKmWLOaoV-iwX07wuT7xOBYAjhpupDss@z>

On Tue, 30 Apr 2019 09:00:56 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 30.04.19 07:41, Christian Borntraeger wrote:
> > 
> > 
> > On 29.04.19 21:24, David Hildenbrand wrote:  

> >> Just wondering, why keep the PCKMO ones separate, but not e.g. PCC ?  
> > 
> > Because those can be disabled at the HMC. It is painful to disable 5 elements
> > for LPARs that are configured that way. So I created a group for those. That
> > will allow to disable the full group.
> > (we have the same issue with the  exisiting AES and DEA pckmo functions).  
> 
> Rings a bell, maybe that information would be good to have in the cover
> letter. I guess Conny might want to change the description when picking up:
> 
> "Provide the MSA9 facility (stfle.155). This also contains pckmo
> subfunctions for key wrapping. Keep them in a separate group to disable
> those as a block if necessary. This is for example needed when disabling
> key wrapping via the HMC."

Sure, makes sense to fold that in.

