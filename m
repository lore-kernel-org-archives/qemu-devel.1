Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717C3C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 18:52:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E7982064A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 18:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7982064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50912 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZJyo-0005Ol-K1
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 14:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59369)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hZIZG-0000pz-G3
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 13:22:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hZIZB-0002Dy-Ia
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 13:22:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38378)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hZIZA-0002AU-6J
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 13:22:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E4AE9356E5;
 Fri,  7 Jun 2019 17:22:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8690760572;
 Fri,  7 Jun 2019 17:22:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1888411386A0; Fri,  7 Jun 2019 19:22:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20190606101533.20228-1-vsementsov@virtuozzo.com>
 <20190606111725.GH14300@redhat.com>
 <f42975be-51cf-c6b6-0148-514dfac7c2fa@virtuozzo.com>
Date: Fri, 07 Jun 2019 19:22:04 +0200
In-Reply-To: <f42975be-51cf-c6b6-0148-514dfac7c2fa@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Thu, 6 Jun 2019 11:33:03 +0000")
Message-ID: <87v9xh5n0j.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 07 Jun 2019 17:22:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] qapi: InitSocketAddress: add keepalive
 option
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Denis Lunev <den@virtuozzo.com>, "kraxel@redhat.com" <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 06.06.2019 14:17, Daniel P. Berrang=C3=A9 wrote:
>> On Thu, Jun 06, 2019 at 01:15:33PM +0300, Vladimir Sementsov-Ogievskiy w=
rote:
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>>
>>> Hi all!
>>>
>>> This is a continuation of "[PATCH v2 0/2] nbd: enable keepalive", but
>>> it's a try from another side, so almost nothing common with v2.

Please explain intended use of your new option in your commit message.

>>>   qapi/sockets.json   |  5 ++++-
>>>   util/qemu-sockets.c | 13 +++++++++++++
>>>   2 files changed, 17 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/qapi/sockets.json b/qapi/sockets.json
>>> index fc81d8d5e8..aefa024051 100644
>>> --- a/qapi/sockets.json
>>> +++ b/qapi/sockets.json
>>> @@ -53,6 +53,8 @@
>>>   #
>>>   # @ipv6: whether to accept IPv6 addresses, default try both IPv4 and =
IPv6
>>>   #
>>> +# @keepalive: enable keepalive when connecting to this socket (Since 4=
.1)
>>> +#
>>>   # Since: 1.3
>>>   ##
>>>   { 'struct': 'InetSocketAddress',
>>> @@ -61,7 +63,8 @@
>>>       '*numeric':  'bool',
>>>       '*to': 'uint16',
>>>       '*ipv4': 'bool',
>>> -    '*ipv6': 'bool' } }
>>> +    '*ipv6': 'bool',
>>> +    '*keepalive': 'bool' } }

I know the C identifier is SO_KEEPALIVE, but let's stick to proper
English words in QMP: keep-alive.

>>>=20=20=20
>>>   ##
>>>   # @UnixSocketAddress:
>>> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
>>> index 8850a280a8..d2cd2a9d4f 100644
>>> --- a/util/qemu-sockets.c
>>> +++ b/util/qemu-sockets.c
>>> @@ -457,6 +457,19 @@ int inet_connect_saddr(InetSocketAddress *saddr, E=
rror **errp)
>>>       }
>>>=20=20=20
>>>       freeaddrinfo(res);
>>> +
>>> +    if (saddr->keepalive) {
>>=20
>> IIUC, best practice is to use 'saddr->has_keepalive && saddr->keepalive'
>
> As I remember, now all optional fields are zeroed. But I'm not against st=
ricter condition.

As far as I'm concerned, relying on zero-initialization of optional
members is fine.

>
>>=20
>>> +        int val =3D 1;
>>> +        int ret =3D qemu_setsockopt(sock, SOL_SOCKET, SO_KEEPALIVE,
>>> +                                  &val, sizeof(val));
>>> +
>>> +        if (ret < 0) {
>>> +            error_setg_errno(errp, errno, "Unable to set KEEPALIVE");
>>> +            close(sock);
>>> +            return -1;
>>> +        }
>>> +    }
>>> +
>>>       return sock;
>>>   }

Possibly ignorant question: why obey the keep-alive option for active
connections (made with inet_connect_saddr()), but not passive ones (made
with inet_listen_saddr() + accept())?

Do you need to update inet_parse()?

