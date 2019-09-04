Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B96C41514
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:40:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FE6122CF7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:40:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FE6122CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5VWm-0006py-Lz
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 09:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1i5VC8-0001iJ-5r
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 09:19:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1i5VC6-0004cs-U3
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 09:19:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60222)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>)
 id 1i5VC3-0004Zh-QZ; Wed, 04 Sep 2019 09:19:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0F1C418C8929;
 Wed,  4 Sep 2019 13:19:27 +0000 (UTC)
Received: from redhat.com (ovpn-117-170.ams2.redhat.com [10.36.117.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 811096060D;
 Wed,  4 Sep 2019 13:19:23 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Eric Blake <eblake@redhat.com>
In-Reply-To: <22efeb99-70d7-13dc-407e-b6fcbce31797@redhat.com> (Eric Blake's
 message of "Wed, 4 Sep 2019 07:39:01 -0500")
References: <20190820104836.3093-1-quintela@redhat.com>
 <20190820104836.3093-5-quintela@redhat.com>
 <22efeb99-70d7-13dc-407e-b6fcbce31797@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Wed, 04 Sep 2019 15:19:21 +0200
Message-ID: <87blw0kxly.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Wed, 04 Sep 2019 13:19:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 4/5] socket: Add num connections to
 qio_net_listener_open_sync()
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> wrote:
> On 8/20/19 5:48 AM, Juan Quintela wrote:
>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  blockdev-nbd.c            | 2 +-
>>  chardev/char-socket.c     | 2 +-
>>  include/io/net-listener.h | 2 ++
>>  io/net-listener.c         | 3 ++-
>>  migration/socket.c        | 2 +-
>>  qemu-nbd.c                | 2 +-
>>  ui/vnc.c                  | 4 ++--
>>  7 files changed, 10 insertions(+), 7 deletions(-)
>
> Just now noticing this one, even though the pull request is already sent.=
..
>
>>=20
>> diff --git a/blockdev-nbd.c b/blockdev-nbd.c
>> index 7a71da447f..c621686131 100644
>> --- a/blockdev-nbd.c
>> +++ b/blockdev-nbd.c
>> @@ -101,7 +101,7 @@ void nbd_server_start(SocketAddress *addr, const cha=
r *tls_creds,
>>      qio_net_listener_set_name(nbd_server->listener,
>>                                "nbd-listener");
>>=20=20
>> -    if (qio_net_listener_open_sync(nbd_server->listener, addr, errp) < =
0) {
>> +    if (qio_net_listener_open_sync(nbd_server->listener, addr, 1, errp)=
 < 0) {
>>          goto error;
>>      }
>
> Does this interfere with the ability to have more than one client
> connect to an NBD server during pull-mode incremental backup?  Or can
> you still have multiple simultaneous clients, provided that the server
> has finished accepting the connection from the first before the second
> one starts?

It is exactly the same than the old code.  Old code always use one.  We
need to have more than one for multifd.

Once told that, if the connections don't start "very" simultaneosly
(i..e. With multifd we start <num channels> connections in paraller),
you will never notice that the backlog is one (sie of queue of pending
connections nowadays).


>
>> +++ b/qemu-nbd.c
>> @@ -1054,7 +1054,7 @@ int main(int argc, char **argv)
>>      server =3D qio_net_listener_new();
>>      if (socket_activation =3D=3D 0) {
>>          saddr =3D nbd_build_socket_address(sockpath, bindto, port);
>> -        if (qio_net_listener_open_sync(server, saddr, &local_err) < 0) {
>> +        if (qio_net_listener_open_sync(server, saddr, 1, &local_err) < =
0) {
>
> Here, 'qemu-nbd -e $n' allows up to $n simultaneous clients.  Should we
> be feeding in that number, instead of a hard-coded 1, to make it easier
> for those clients to connect simultaneously?
>
> We can make such changes as a followup patch.

From the man page:

       The backlog argument defines the maximum length to which the  queue =
 of
       pending  connections  for  sockfd  may  grow.

So, except if you plan to start multiples connections at the same time,
you don't care.  And if the old code worked, this one makes no
difference.

To explain multifd problem, I was creating 10 threads, and each launched
a connect.  On the receiving side, I only got 8 connections, 2 of them
were missing.

Later, Juan.

