Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDA4C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 18:27:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A37122075E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 18:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A37122075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45691 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMcuX-0008AH-UC
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 14:27:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMcsi-0006yx-G9
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMcsh-0006Cn-MZ
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:26:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hMcsh-0006Al-HZ
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:25:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 674D864458;
	Fri,  3 May 2019 18:25:58 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A56F350F4D;
	Fri,  3 May 2019 18:25:51 +0000 (UTC)
Date: Fri, 3 May 2019 15:25:49 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Janakarajan Natarajan <jnataraj@amd.com>
Message-ID: <20190503182549.GS28722@habkost.net>
References: <20190425225610.28350-1-Janakarajan.Natarajan@amd.com>
	<20190425225610.28350-2-Janakarajan.Natarajan@amd.com>
	<20190426142908.5d63d530@Igors-MacBook-Pro.local>
	<3d272b2b-67ba-de54-9683-d3361ecbe276@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <3d272b2b-67ba-de54-9683-d3361ecbe276@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Fri, 03 May 2019 18:25:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/3] ram-encrypted-notifier: Introduce a
 RAM block encrypted notifier
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
Cc: Fam Zheng <fam@euphon.net>, "Singh, Brijesh" <brijesh.singh@amd.com>,
	"Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503182549.waM3wTEkgUMeVeuA_Nwjh1ovc3u-VuZgNaANk7EcWjk@z>

On Fri, Apr 26, 2019 at 02:32:51PM +0000, Janakarajan Natarajan wrote:
> On 4/26/19 7:29 AM, Igor Mammedov wrote:
[...]
> >> diff --git a/numa.c b/numa.c
> >> index 3875e1efda..08601366c5 100644
> >> --- a/numa.c
> >> +++ b/numa.c
> > looks like wrong file to put RAMBlock code in. I though that we should put it in exec.c
> 
> 
> I placed the RAMBlockEncrypted Notifier code along with the RAMBlock 
> Notifier code.

Paolo, Fam, do you remember why was the ram block notifier code
added to numa.c instead of memory.c or exec.c?

-- 
Eduardo

