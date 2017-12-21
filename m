Received: from eggs.gnu.org ([2001:4830:134:3::10]:59687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eS7AL-0003s3-Sm
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 15:10:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eS7AI-0007ww-Ng
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 15:10:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eS7AI-0007wa-Gq
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 15:10:02 -0500
References: <0B44C3E6-545D-43B1-B124-97BB9D84BA0C@gmail.com>
	<8bf902fe-1ec9-4845-a072-af2e7da32ed2@redhat.com>
	<29E7CA81-A379-4B37-B174-20EACDEA5E79@gmail.com>
	<0e51a7c4-34b1-7b14-c2be-e21e81e6e7fc@redhat.com>
	<9F278FF6-8D20-45FC-88B9-64E6F47A2C98@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5ecea600-77b2-ecd7-faca-fc4c29994a83@redhat.com>
Date: Thu, 21 Dec 2017 14:09:59 -0600
MIME-Version: 1.0
In-Reply-To: <9F278FF6-8D20-45FC-88B9-64E6F47A2C98@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] About my strnlen patch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, QEMU Developers <qemu-devel@nongnu.org>

On 12/21/2017 01:07 PM, Programmingkid wrote:
> 
>> On Dec 21, 2017, at 1:40 PM, Eric Blake <eblake@redhat.com> wrote:
>>
>> On 12/21/2017 12:36 PM, Programmingkid wrote:
>>>> On Dec 21, 2017, at 1:30 PM, Eric Blake <eblake@redhat.com> wrote:
>>>>
>>>> On 12/21/2017 08:31 AM, Programmingkid wrote:
>>>>> Now would be a good time to push the strnlen patch.
>>>>
>>>> No links to the patch? Generally, when pinging a patch, it's best to reply to the existing thread, or at least provide a URL to the thread, where the patch was proposed.
>>>>
>>> Yes here is the patch: https://patchwork.kernel.org/patch/10027375/
>>
>> And that link says it was applied to libfdt on Oct 25.  What still needs to happen that caused you to send this ping?
> 
> It isn't available in QEMU yet. Without the patch building QEMU on Mac OS 10.6 fails.
> 
> The patch'ed code would be found here: <qemu folder>/dtc/libfdt/libfdt_env.h.
> 
> I can check on the patch's status by deleting the dtc folder and retrieve it again using this command:
> $ scripts/git-submodule.sh dtc

In other words, for qemu, you are proposing a patch to update the dtc 
submodule to a newer commit id.  Instead of describing that in words, 
it's better to post an actual patch, such as this, which updates to the 
latest dtc commit available as of my email:

diff --git i/dtc w/dtc
index 558cd81bdd..e671852042 160000
--- i/dtc
+++ w/dtc
@@ -1 +1 @@
-Subproject commit 558cd81bdd432769b59bff01240c44f82cfb1a9d
+Subproject commit e671852042a77b15ec72ca908291c7d647e4fb01

Create such a patch by: 'cd dtc; git pull; git merge origin; cd ..; git 
add dtc'.  However, pointing the dtc submodule to a commit in-between 
releases may not be desirable; your commit landed in dtc as commit 
c8f8194d, missing v1.4.5 (qemu.git is currently pointing to v1.4.4).  As 
I'm not the maintainer of the dtc submodule, I don't know the preferred 
submodule update procedure; it may mean that you have to wait for 
upstream dtc to release v1.4.6 before qemu.git can be updated to point 
to a dtc version that includes your commit.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
