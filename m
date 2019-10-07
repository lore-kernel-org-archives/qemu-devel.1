Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9EBECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 20:05:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F93821A4A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 20:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F93821A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHZGD-00044n-OZ
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 16:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36047)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iHZF8-0003Nd-2o
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 16:04:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iHZF5-0002nm-KO
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 16:04:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44320)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iHZEk-00023E-DK; Mon, 07 Oct 2019 16:04:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8FBCD7F745;
 Mon,  7 Oct 2019 20:04:01 +0000 (UTC)
Received: from [10.3.116.162] (ovpn-116-162.phx2.redhat.com [10.3.116.162])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DFA05C219;
 Mon,  7 Oct 2019 20:03:58 +0000 (UTC)
Subject: Re: [PATCH v9 3/3] iotests: test nbd reconnect
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190917171322.4127-1-vsementsov@virtuozzo.com>
 <20190917171322.4127-4-vsementsov@virtuozzo.com>
 <7f0a7890-7b3d-9fd7-954d-389a8e28106f@redhat.com>
 <88a7e9c9-caf2-b114-93c4-7c99036c9b33@virtuozzo.com>
 <7854fa11-5c2d-4b88-16f8-2bbb2679efa2@redhat.com>
 <b8f833ed-5c0f-7cba-0cd4-acb96c1afbc9@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <0be52afc-ca1b-99bf-ca34-71f800d2ecba@redhat.com>
Date: Mon, 7 Oct 2019 15:03:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <b8f833ed-5c0f-7cba-0cd4-acb96c1afbc9@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Mon, 07 Oct 2019 20:04:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/19 5:48 AM, Vladimir Sementsov-Ogievskiy wrote:

>>> We want to wait until listening socket is prepared..
>>
>> In shell:
>>
>> qemu-nbd --pid-file=3D/path/to/file ...
>> while [ ! -e /path/to/file ]; do
>>   =C2=A0 sleep ... # fractional second, or exponential, or whatever...
>> done
>> # Now the listening socket is indeed prepared
>>
>> You'd have to translate that idiom to python.
>=20
> Don't see, how it is better than what I've done in 04.. But I can resen=
d with this.
> At least, the fact that socket is initialized before creating pid file =
is undocumented..

I just posted a patch to rectify that.

>=20
>>
>> Or:
>>
>> pre-open Unix socket at /path/to/socket
>> LISTEN_PID=3D... LISTEN_FDS=3D1 qemu-nbd ... 3<>/path/to/socket
>>
>> Now the socket is pre-created and passed into qemu-nbd via systemd soc=
ket activation, so you know the listening socket is ready without having =
to do any loop at all.=C2=A0 Here's a patch in libnbd where we just switc=
hed from waiting for the port to appear (because the test predated qemu-n=
bd pidfile support) to instead using socket activation, for reference:
>> https://github.com/libguestfs/libnbd/commit/352331d177
>>
>=20
> Hmm, I'm afraid I need more help in it, I don't know socket activation =
and googling for some time didn't help.
> How to pre-open the socket? How to set LISTEN_PID? Looking at the code =
I see that activation path failed if
> LISTEN_PID !=3D getpid().. So I need to know qemu-nbd pid before starti=
ng it? o_O
>=20

I'm not sure if a shell can open a Unix socket as a server.  The shell=20
_does_ have the 'exec' builtin, such that you can manipulate the=20
environment in shell and then use exec to guarantee the qemu-nbd process=20
has the same pid as the shell process that just manipulated the=20
environment; but it doesn't help unless you can also pass in the Unix=20
socket pre-bound, and I'm not aware of command line tools that make that=20
easy (maybe nc can do something like it, but then you have to wonder if=20
nc is adding yet another layer of bounce-buffering).  But in other=20
languages (C, Python, ...) you create a Unix socket, call bind() on it,=20
then call fork().  In the parent process, you then close the just-bound=20
fd, and call connect() on the socket - the connect will block until the=20
child process uses the socket, but you are guaranteed that it won't fail=20
because the server side is already bound.  In the child process, you use=20
dup2() to move the fd to 3 and clear O_CLOEXEC, manipulate the=20
environment to set LISTEN_PID to the current process id and LISTEN_FDS=20
to 1, then exec.  The child process then has the correct id to realize=20
that it has been handed a pre-bound socket, and skips any code that it=20
would normally do to create the socket and bind it.

Note that setting LISTEN_PID in the child process after a fork() from a=20
multi-threaded parent is _extremely_ difficult to do correctly (setenv()=20
is not async-signal-safe, and anything that is not async-signal-safe can=20
cause deadlock if invoked between fork() and exec() if the parent=20
process was multi-threaded) - so it may even be easier to do a=20
double-exec() - the first exec is to a shim to get rid of the=20
async-signal-safe restrictions, and can then set LISTEN_PID without=20
issues, and the second exec to the actual target.  But I don't know of=20
any such shim designed for common use.

That said, socket activation isn't a necessity to use, just a=20
convenience.  I don't care if the regression test uses socket=20
activation, as long as it works at testing nbd reconnect.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

