Return-Path: <SRS0=i/12=ZI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD593C432C3
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2019 02:03:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 971142073A
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2019 02:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dmbZyXZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 971142073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVnQa-0000AY-PV
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 21:03:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iVnP8-00084Z-Lq
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 21:01:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iVnP6-00088R-As
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 21:01:37 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30349)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iVnP4-00088B-Eh
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 21:01:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573869693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dsdpP3SpFoRXLgHaHJMwHaAVsKuDF8o5GNb5jTa0ta8=;
 b=dmbZyXZN4q/wHntzT8o/dUZy/8zApO+f8rAK+iD0nh9xigZWIVvimzIxlAaguwnnv/5lpV
 V7HeLHBwL1ZypeqDw0hfr1W5it/jJmknxNJ6MsJpi2yVYnDHd6KSgFWX3ncq/RDOgtsx+R
 YVYQ4Zw0baWuWusufvSds2Q5xz5Gxd8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-tfrX-YkiM8yT898qtbXVKg-1; Fri, 15 Nov 2019 21:01:30 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41272801FD2;
 Sat, 16 Nov 2019 02:01:29 +0000 (UTC)
Received: from [10.3.116.221] (ovpn-116-221.phx2.redhat.com [10.3.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B87E010027B1;
 Sat, 16 Nov 2019 02:01:28 +0000 (UTC)
Subject: Re: [PATCH] qemu-nbd: Document benefit of --pid-file
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20191007194840.29518-1-eblake@redhat.com>
 <20191008092448.GD1192@redhat.com>
 <04440b88-78f6-e177-924d-e16fc3c29b5c@virtuozzo.com>
 <d4b715de-6d5d-6f43-e845-86ddc01c3eac@redhat.com>
 <20191008133834.GG1192@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <a3cbc6e1-83f9-cd30-ae84-37c4fba20a27@redhat.com>
Date: Fri, 15 Nov 2019 20:01:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191008133834.GG1192@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: tfrX-YkiM8yT898qtbXVKg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/19 8:38 AM, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Oct 08, 2019 at 08:28:16AM -0500, Eric Blake wrote:
>> On 10/8/19 4:40 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> 08.10.2019 12:24, Daniel P. Berrang=C3=A9 wrote:
>>>> On Mon, Oct 07, 2019 at 02:48:40PM -0500, Eric Blake wrote:
>>>>> One benefit of --pid-file is that it is easier to probe the file
>>>>> system to see if a pid file has been created than it is to probe if a
>>>>> socket is available for connection. Document that this is an
>>>>> intentional feature.

Revisiting an older thread,


>>> I was just a bit confused, because pid file is something unrelated to
>>> socket, and why use one thing to check the existence of another, if we
>>> can directly try to connect.
>>
>> Consider the case of writing a testsuite that involves an nbd client, wh=
ere
>> you want to fire up qemu-nbd as the server.  Checking for a pid file in
>> shell is easy, and can be done prior to the point of spawning a client.
>> Checking for a successful connect is harder - the shell is not the point
>> that would actually connect, so checking if connect works involves the s=
hell
>> actually spawning off the child process that attempts the connect.  If t=
he
>> client itself has a retry builtin, then you don't need to do anything in
>> shell - just spawn the client with retry (at which point, the client
>> retrying on the connection is smarter than the client retrying on the pi=
d
>> file).  But pid files are immensely useful when you have a client that d=
oes
>> not have builtin retry, and when writing a testing framework where you u=
se
>> shell to learn whether it is safe to spawn the client: rather than havin=
g to
>> modify the client or write a shell loop that respawns child attempts, yo=
u
>> merely need a shell loop probing for the pid file to exist.
>=20
> We shouldn't need todo any of those tricks IIUC.  The --fork argument is
> supposed to only let the parent process exit once the server is running.
>=20
> IOW, if you run qemu-nbd --fork, in the foreground, then when execution
> continues the sockets should be present & accepting connections. No need
> to check for existance of any files or check connecting, etc.
>=20
>=20
> Except that AFAICT, --fork isn't actually implemented with this semantics
> in qemu-nbd. It looks like we only listen on the sockets after the parent
> has already exited :-( Can we fix that to synchronize wrt socket listener=
s ?

Actually, after re-reading the code, it IS implemented this way. The=20
parent process when --fork is used does not exit until after the child=20
process closes its temporary stderr pipe to the parent, which is after=20
the socket has been set up and only right before beginning the main=20
event loop.  So when --fork is in use, waiting for the process to exit=20
is sufficient.

But when --fork is not in use (because you want to keep the qemu-nbd=20
process in the foreground for whatever reason), then --pid-file can=20
indeed serve as a witness when the single process has progressed far=20
enough to have the socket open.

At any rate, I'm less certain if it is worth trying to revive this=20
patch.  A doc-only change is still okay for 4.2-rc2, except that we have=20
to agree on what such a doc change should be and if it adds anything=20
useful to the reader.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


