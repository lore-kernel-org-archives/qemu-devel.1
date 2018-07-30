Received: from eggs.gnu.org ([2001:4830:134:3::10]:53124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fkAKg-0003D2-IY
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:43:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fkAKf-0007rW-N8
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:43:38 -0400
References: <20180729212744.23709-1-lbloch@janustech.com>
	<20180729212744.23709-2-lbloch@janustech.com>
	<ceb7a6e9-1dc2-b5f5-c81e-ba08841c8ba9@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <16e29571-c7e6-35e6-6b1e-442668362913@redhat.com>
Date: Mon, 30 Jul 2018 10:43:30 -0500
MIME-Version: 1.0
In-Reply-To: <ceb7a6e9-1dc2-b5f5-c81e-ba08841c8ba9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/6 for-3.0] Update .gitignore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 07/30/2018 10:40 AM, Eric Blake wrote:
> On 07/29/2018 04:27 PM, Leonid Bloch wrote:
>> Adds /roms/vgabios to .gitignore - this directory appears after the
>> build, and was not ignored by Git so far.
>>
> 
> Actually, that's the directories for one of the submodules. It seems 
> fishy to have a directory listed in both .gitignore and .gitmodules at 
> the same time, so I'm inclined to NACK this patch, and instead figure 
> out what in the build is dirtying the directory when the submodule is 
> not checked out.

Or rather, it was a submodule until commit 91b8eba9. So maybe what's 
happening is that you previously had it checked out, and now that we no 
longer have the submodule, it shows up unless .gitconfig ignores it. For 
that, I'd recommend editing .git/info/exclude to ignore it locally (if 
you plan on frequently checking out points both before and after the 
deletion) rather than making it part of upstream (which tends to focus 
more on ignoring files built by the current contents of master, not 
files that are leftovers from earlier commits).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
