Received: from eggs.gnu.org ([2001:4830:134:3::10]:43439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1em5cL-0007Zl-O9
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 17:33:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1em5cH-0004g4-2U
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 17:33:33 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57990 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1em5cG-0004ew-Tm
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 17:33:28 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 785AE40201A0
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 22:33:28 +0000 (UTC)
References: <20180213142102.14450-1-stefanha@redhat.com>
	<20180213142102.14450-2-stefanha@redhat.com>
	<73eb771d-ddcd-42e6-5895-23e6024ccc80@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b6365ccd-75b2-a784-bd65-732fe3d5c1d2@redhat.com>
Date: Wed, 14 Feb 2018 16:33:23 -0600
MIME-Version: 1.0
In-Reply-To: <73eb771d-ddcd-42e6-5895-23e6024ccc80@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/4] block: extract AIO_WAIT_WHILE()
 from BlockDriverState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

On 02/13/2018 10:01 AM, Eric Blake wrote:
> On 02/13/2018 08:20 AM, Stefan Hajnoczi wrote:
>> BlockDriverState has the BDRV_POLL_WHILE() macro to wait on event loop
>> activity while a condition evaluates to true.=C2=A0 This is used to im=
plement
>> synchronous operations where it acts as a condvar between the IOThread
>> running the operation and the main loop waiting for the operation.=C2=A0=
 It
>> can also be called from the thread that owns the AioContext and in tha=
t
>> case it's just a nested event loop.
>>

>=20
> It may be that your patch is correct (as I'm not an expert on the rules=
=20
> in play here), but more comments may help.=C2=A0 Or you may have a NULL=
=20
> dereference bug lurking.=C2=A0 So at this point, I can't give R-b, even=
=20
> though the refactoring of the BDRV_POLL_WHILE() macro into a separate=20
> helper makes sense from the high level view.

Okay, based on your responses, I can now give

Reviewed-by: Eric Blake <eblake@redhat.com>

although it may still help to do followups with better documentation=20
and/or a rename of the confusing functions.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
