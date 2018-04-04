Received: from eggs.gnu.org ([2001:4830:134:3::10]:47942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f3m8Y-0002nW-Bv
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 13:23:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f3m8U-0002sH-Dj
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 13:23:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51610 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f3m8U-0002s2-7g
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 13:23:50 -0400
References: <mailman.35816.1522678020.27992.qemu-devel@nongnu.org>
	<B4011235-0338-474D-90E4-ABDF3DC8CCB7@gmail.com>
	<eeb9a3c8-e7ee-742b-fd6a-41c364d971c4@redhat.com>
	<57D8CDA1-C9D1-4CD7-99A1-203B570BF4D3@gmail.com>
	<20180404143859.GI3186@redhat.com>
	<e283ef1f-a1cd-c21a-9058-c68c76182486@redhat.com>
	<20180404145803.GJ3186@redhat.com>
	<b5f3cb9f-d40a-439a-34a4-58bba9ec0387@weilnetz.de>
	<6C36CDC6-851D-41A3-BDA8-1D2712437117@gmail.com>
	<395f732f-dca2-a2e8-7c4c-0cbe79f3e8c5@redhat.com>
	<0B844F19-6C50-475D-B33D-3A66620A2595@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5f03cc19-de3a-b599-dfc1-405f6fef4f9c@redhat.com>
Date: Wed, 4 Apr 2018 19:23:47 +0200
MIME-Version: 1.0
In-Reply-To: <0B844F19-6C50-475D-B33D-3A66620A2595@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-web PATCH] download: Add instructions for
 MacPorts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: Stefan Weil <sw@weilnetz.de>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Rainer M?ller <raimue@macports.org>, QEMU Developers <qemu-devel@nongnu.org>

On 04/04/2018 18:19, Programmingkid wrote:
>>> I guess there is just too much distrust to provide a QEMU binary for download.
>> It's not distrust, it's responsibility.
>>
>> Paolo
> So from what I learned, in order to provide a binary of QEMU, these things must be done:
> - Some kind of checksum be provided for the binary (md5, SHA512, ...)
> - A zip file that has the exact code used to build the binary be provided
> - The complete environment use to build the binary be documented
> -- Operating system name and version
> -- name and version of various tools used to build the binary (GCC, make, ...)
> -- name and version of libraries that are linked to QEMU (libc, pixman, ...)
> - The exact command-line options used to build the binary be provided
> - The email address and identity of the person who made the binary be provided
> 
> If anything is missing please feel free to share. 

In practice a GPG signature, with a signature well-connected to other
people in the QEMU community, would already be a very good start.  If
the exact code is not a release tarball, that would also be required.

The command line options used for the build can be documented in the wiki.

Paolo
