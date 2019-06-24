Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759EDC4646B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:49:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4762220665
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4762220665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55228 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfXmV-0004SZ-94
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 18:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39154)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <wainersm@redhat.com>) id 1hfXl2-000392-Rp
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:48:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1hfXl1-0008O5-OX
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:48:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48266)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1hfXl1-0008Ln-Hi
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:48:15 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AB58530917AC
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 22:48:11 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-99.rdu2.redhat.com
 [10.10.123.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6DE6F100033E;
 Mon, 24 Jun 2019 22:48:07 +0000 (UTC)
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20190608233447.27970-1-ehabkost@redhat.com>
 <20190624180326.GJ1862@habkost.net>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <b55a1b4d-7aa4-ccb4-33f8-aae583776d3d@redhat.com>
Date: Mon, 24 Jun 2019 19:48:06 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190624180326.GJ1862@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Mon, 24 Jun 2019 22:48:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 0/1] Export machine type deprecation
 info through QMP
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
Cc: Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Michal Privoznik <mprivozn@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 06/24/2019 03:03 PM, Eduardo Habkost wrote:
> Any objections to this?  I'm planning to merge it this week.

IMHO, 1+. So I don't have objections.

- Wainer

>
> On Sat, Jun 08, 2019 at 08:34:46PM -0300, Eduardo Habkost wrote:
>> Changes v1 -> v2:
>> * I've decided to get rid of the status-message and
>>    suggested-alternative fields, to avoid more bikeshedding.
>>
>> This series adds machine type deprecation information to the
>> output of the `query-machines` QMP command.  With this, libvirt
>> and management software will be able to show this information to
>> users and/or suggest changes to VM configuration to avoid
>> deprecated machine types.
>>
>> Eduardo Habkost (1):
>>    qmp: Add deprecation information to query-machines
>>
>>   qapi/misc.json | 7 ++++++-
>>   vl.c           | 1 +
>>   2 files changed, 7 insertions(+), 1 deletion(-)
>>
>> -- 
>> 2.18.0.rc1.1.g3f1ff2140
>>


