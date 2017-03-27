Received: from eggs.gnu.org ([2001:4830:134:3::10]:48192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1csQkI-0005A2-4M
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 05:15:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1csQkE-0004mc-2W
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 05:15:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:44454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jgross@suse.com>) id 1csQkD-0004jj-Ry
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 05:15:21 -0400
References: <20170327074245.3821-1-jgross@suse.com>
	<1330e0a0d9814073b39b52bd6e08a6a8@AMSPEX02CL03.citrite.net>
From: Juergen Gross <jgross@suse.com>
Message-ID: <552de1bb-46bf-1579-d8b2-763d4612eb44@suse.com>
Date: Mon, 27 Mar 2017 11:14:39 +0200
MIME-Version: 1.0
In-Reply-To: <1330e0a0d9814073b39b52bd6e08a6a8@AMSPEX02CL03.citrite.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] configure: use pkg-config for obtaining
 xen version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Cc: Anthony Perard <anthony.perard@citrix.com>, "kraxel@redhat.com" <kraxel@redhat.com>, "sstabellini@kernel.org" <sstabellini@kernel.org>

On 27/03/17 11:07, Paul Durrant wrote:
>> -----Original Message-----
>> From: Juergen Gross [mailto:jgross@suse.com]
>> Sent: 27 March 2017 08:43
>> To: qemu-devel@nongnu.org; xen-devel@lists.xenproject.org
>> Cc: Anthony Perard <anthony.perard@citrix.com>; kraxel@redhat.com;
>> sstabellini@kernel.org; Paul Durrant <Paul.Durrant@citrix.com>; Juergen
>> Gross <jgross@suse.com>
>> Subject: [PATCH v2] configure: use pkg-config for obtaining xen version
>>
>> Instead of trying to guess the Xen version to use by compiling various
>> test programs first just ask the system via pkg-config. Only if it
>> can't return the version fall back to the test program scheme.
>>
>> If configure is being called with dedicated flags for the Xen libraries
>> use those instead of the pkg-config output. This will avoid breaking
>> an in-tree Xen build of an old Xen version while a new Xen version is
>> installed on the build machine: pkg-config would pick up the installed
>> Xen config files as the Xen tree wouldn't contain any of them.
>>
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> ---
>> V2: - use pkg-config only if no Xen library paths have been specified via
>>       --extra-ldflags
>>     - keep test program for detecting Xen 4.9
> 
> This all looks plausible but it doesn't seem to be working for me when trying to build 4.8. I'm still getting a xen ctrl version of 40900... still trying to figure out why.

I suppose you reverted my previous patch?

Do you happen to have some stale 4.9 libraries in your Xen tree?

What happens without this patch?

> Also, the whitespace changes later on in the patch should probably be split out.

Hmm, those are just due to the nesting level of the if's changed.
I don't think they can easily be split out without having a
malformed indentation.


Juergen
