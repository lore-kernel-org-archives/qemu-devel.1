Received: from eggs.gnu.org ([2001:4830:134:3::10]:56939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eK5Np-0007MY-79
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:38:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eK5Nl-0003WK-8a
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:38:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eK5Nl-0003VZ-2d
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:38:45 -0500
References: <20171128044656.10592-1-linzhecheng@huawei.com>
	<cd2bad80-1790-aa01-fde4-4979b4c53b97@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA4A9A07@DGGEMA505-MBS.china.huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2d6d0a12-9eb8-0948-4dc5-f84ad9070cc0@redhat.com>
Date: Wed, 29 Nov 2017 17:38:37 +0100
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA4A9A07@DGGEMA505-MBS.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] thread: move detach_thread from
 creating thread to created thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, Eric Blake <eblake@redhat.com>, linzhecheng <linzhecheng@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "famz@redhat.com" <famz@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>

On 29/11/2017 17:28, Gonglei (Arei) wrote:
>>> The root cause of this problem is a bug of glibc(version 2.17,the latest version
>> has the same bug),
>>> let's see what happened in glibc's code.
>> Have you reported this bug to the glibc folks, and if so, can we include
>> a URL to the glibc bugzilla?
>>
> No, we didn't do that yet. :(

It's here:

    https://sourceware.org/bugzilla/show_bug.cgi?id=19951.

I've added a note to the commit message.

Paolo
