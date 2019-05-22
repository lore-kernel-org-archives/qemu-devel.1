Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A33C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 12:57:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4C8520868
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 12:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C8520868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42856 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTQnm-00029y-4H
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 08:57:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hTQn0-0001YX-TR
	for qemu-devel@nongnu.org; Wed, 22 May 2019 08:56:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hTQmz-0005Ll-MT
	for qemu-devel@nongnu.org; Wed, 22 May 2019 08:56:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hTQmz-0005LP-HD
	for qemu-devel@nongnu.org; Wed, 22 May 2019 08:56:13 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9009B309264F
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 12:56:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C2A515C5C3;
	Wed, 22 May 2019 12:55:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 5234B1138648; Wed, 22 May 2019 14:55:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
References: <20190514180311.16028-1-armbru@redhat.com>
	<20190514180311.16028-3-armbru@redhat.com>
	<dfe0cd4d-406b-b389-4838-d6c8274119a2@redhat.com>
	<0e5cf8f4-c6e1-5ff4-e44a-b28581337b41@redhat.com>
Date: Wed, 22 May 2019 14:55:58 +0200
In-Reply-To: <0e5cf8f4-c6e1-5ff4-e44a-b28581337b41@redhat.com> (Thomas Huth's
	message of "Tue, 21 May 2019 09:52:57 +0200")
Message-ID: <87a7feodgh.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Wed, 22 May 2019 12:56:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/6] tests/vhost-user-bridge: Fix misuse
 of isdigit()
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
Cc: Victor Kaplansky <victork@redhat.com>, philmd@redhat.com,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thomas Huth <thuth@redhat.com> writes:

> On 14/05/2019 20.41, Thomas Huth wrote:
>> On 14/05/2019 20.03, Markus Armbruster wrote:
>>> vubr_set_host() passes char values to isdigit().  Undefined behavior
>>> when the value is negative.
>>>
>>> Fix by using qemu_isdigit() instead.
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>  tests/vhost-user-bridge.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
>>> index 0033b61f2e..d70b107ebc 100644
>>> --- a/tests/vhost-user-bridge.c
>>> +++ b/tests/vhost-user-bridge.c

Squashing in

    @@ -30,6 +30,7 @@
     #define _FILE_OFFSET_BITS 64

     #include "qemu/osdep.h"
    +#include "qemu-common.h"
     #include "qemu/atomic.h"
     #include "qemu/iov.h"
     #include "standard-headers/linux/virtio_net.h"

>>> @@ -645,7 +645,7 @@ vubr_host_notifier_setup(VubrDev *dev)
>>>  static void
>>>  vubr_set_host(struct sockaddr_in *saddr, const char *host)
>>>  {
>>> -    if (isdigit(host[0])) {
>>> +    if (qemu_isdigit(host[0])) {
>>>          if (!inet_aton(host, &saddr->sin_addr)) {
>>>              fprintf(stderr, "inet_aton() failed.\n");
>>>              exit(1);
>> 
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
> By the way, how do you compile / run this test? The original commit
> message say one should compile it with "make tests/vhost-user-bridge"
> but that does not work for me:
>
> $ make tests/vhost-user-bridge
> cc     tests/vhost-user-bridge.c   -o tests/vhost-user-bridge
> tests/vhost-user-bridge.c:32:24: fatal error: qemu/osdep.h: No such file
> or directory

With that fixup, it compiles for me.

Thanks for your question!  I blindly assumed "make check" actually
compiled this.

