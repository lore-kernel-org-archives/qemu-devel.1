Received: from eggs.gnu.org ([2001:4830:134:3::10]:60870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezOpZ-0003iW-Ow
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezOpW-0000L6-K2
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:42:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43666 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ezOpW-0000Kw-FF
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:42:10 -0400
References: <20180323140821.28957-1-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <17b3708c-3787-c08d-e960-c6df21114689@redhat.com>
Date: Fri, 23 Mar 2018 10:42:00 -0500
MIME-Version: 1.0
In-Reply-To: <20180323140821.28957-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12 0/4] Turn OOB off for 2.12-rc1,
 revert OOB tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 03/23/2018 09:08 AM, Peter Xu wrote:
> Temporarily disable OOB for 2.12 since it break (a lot of) things.
> Luckily it's only a switch so not so hard. Meanwhile, revert all new
> tests that checks against it.
> 
> Tests done: all target builds and "make check" passed, but only on
> x86_64 host.  It can pass all "raw" iotests, but some "qcow2" iotests
> are still failing.  I can even reproduce many of the qcow2 fails even
> before the whole OOB series, so I suppose that's something already
> exists so I'll ignore.
> 
> More tests are really welcomed.  Thanks,
> 
> Peter

Acked-by: Eric Blake <eblake@redhat.com>

if Peter Maydell wants to pick this up directly on mainline (the smaller 
the window with broken tests, the easier it is to bisect other issues). 
Otherwise, I'll queue it in my QAPI pull request for Monday.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
