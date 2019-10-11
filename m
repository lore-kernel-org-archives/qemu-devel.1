Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F44ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 10:41:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35DC72084C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 10:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35DC72084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIsMD-00059i-4i
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 06:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iIsLL-0004Bh-N6
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 06:40:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iIsLK-00041y-JH
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 06:40:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39162)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>)
 id 1iIsLH-0003xD-Sc; Fri, 11 Oct 2019 06:40:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 03DC510DCCA7;
 Fri, 11 Oct 2019 10:40:15 +0000 (UTC)
Received: from redhat.com (ovpn-117-120.ams2.redhat.com [10.36.117.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 11A811019611;
 Fri, 11 Oct 2019 10:40:05 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PULL 5/5] multifd: Use number of channels as listen backlog
In-Reply-To: <20191011083745.GA17297@richard> (Wei Yang's message of "Fri, 11
 Oct 2019 16:37:46 +0800")
References: <20190904062915.6488-1-quintela@redhat.com>
 <20190904062915.6488-6-quintela@redhat.com>
 <20191011083745.GA17297@richard>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Fri, 11 Oct 2019 12:40:03 +0200
Message-ID: <87zhi7va4c.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Fri, 11 Oct 2019 10:40:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Wei Yang <richardw.yang@linux.intel.com> wrote:
> On Wed, Sep 04, 2019 at 08:29:15AM +0200, Juan Quintela wrote:
>>Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>Signed-off-by: Juan Quintela <quintela@redhat.com>
>>---
>> migration/socket.c | 7 ++++++-
>> 1 file changed, 6 insertions(+), 1 deletion(-)
>>
>>diff --git a/migration/socket.c b/migration/socket.c
>>index e63f5e1612..97c9efde59 100644
>>--- a/migration/socket.c
>>+++ b/migration/socket.c
>>@@ -178,10 +178,15 @@ static void socket_start_incoming_migration(SocketA=
ddress *saddr,
>> {
>>     QIONetListener *listener =3D qio_net_listener_new();
>>     size_t i;
>>+    int num =3D 1;
>>=20
>>     qio_net_listener_set_name(listener, "migration-socket-listener");
>>=20
>>-    if (qio_net_listener_open_sync(listener, saddr, 1, errp) < 0) {
>>+    if (migrate_use_multifd()) {
>>+        num =3D migrate_multifd_channels();
>>+    }
>>+
>>+    if (qio_net_listener_open_sync(listener, saddr, num, errp) < 0) {
>>         object_unref(OBJECT(listener));
>>         return;
>>     }
>
> My confusion is this function is called at the beginning of the program, =
which
> means we didn't set multifd on or change the multifd channel parameter.
>
> They are the default value at this point.
>
> Am I right?

Hi

good catch!

You are right.  The fix worked for me because I always use on the
command line:

--global migration.multifd-channels=3D10

or whatever number I want to avoid typing.  I can only see two
solutions:
- increase the number always
- require "defer" when using multifd to be able to setup parameters.

Any other good ideas?

Thanks, Juan.

PD.  I was having problem reproducing this issue because I use the
command line for the parameter.

