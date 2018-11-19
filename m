Received: from eggs.gnu.org ([2001:4830:134:3::10]:36642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOsqS-0002T1-KL
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 18:20:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOsqN-0005fZ-VO
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 18:20:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gOsqN-0005eA-PP
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 18:20:39 -0500
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<20181114123643.24091-4-marcandre.lureau@redhat.com>
	<20181114142234.GJ19298@redhat.com>
	<20181119225950.43sytfmqg2ak2lho@function>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c065664f-ff6d-8781-a389-c3d64ce4fcf7@redhat.com>
Date: Mon, 19 Nov 2018 17:20:31 -0600
MIME-Version: 1.0
In-Reply-To: <20181119225950.43sytfmqg2ak2lho@function>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.2 03/41] slirp: simplify fork_exec()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, renzo@cs.unibo.it, qemu-devel@nongnu.org, stefanha@redhat.com, rjones@redhat.com

On 11/19/18 4:59 PM, Samuel Thibault wrote:
> Mmm, I don't think any portability issue remains. SO_OOBINLINE is used
> in other places, the rest is portable. There is the setsid() call which
> may just not make sense on Windows, but we could just disable it there.
> 
> I have pushed to
> 
> https://people.debian.org/~sthibault/qemu.git slirp-2-win
> 
> what it could look like. I don't have a windows box off hand, could
> somebody try it to confirm that it builds?

You could try 'make docker-test-mingw@fedora' to at least try building 
for a Windows environment (but that doesn't say much about testing the 
resulting binary).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
