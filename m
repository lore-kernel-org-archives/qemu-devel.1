Received: from eggs.gnu.org ([209.51.188.92]:43286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gzHrv-0007rm-9Z
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 04:20:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gzHru-00082O-Jf
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 04:20:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gzHru-00081u-9a
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 04:20:42 -0500
References: <20190228043503.68494-1-aik@ozlabs.ru>
	<20190228050007.GF27799@umbus.fritz.box>
	<365a4f56-5f68-9f33-72c2-9d0dc2c7f3c6@redhat.com>
	<20190228071444.72ku2l7fspjik6do@sirius.home.kraxel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <77acaf36-f9ae-70a4-4ad9-2323bf2a09ce@redhat.com>
Date: Thu, 28 Feb 2019 10:20:02 +0100
MIME-Version: 1.0
In-Reply-To: <20190228071444.72ku2l7fspjik6do@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] configure: Enable werror for git
 worktrees
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, philmd@redhat.com

On 28/02/19 08:14, Gerd Hoffmann wrote:
> On Thu, Feb 28, 2019 at 08:01:53AM +0100, Thomas Huth wrote:
>> On 28/02/2019 06.00, David Gibson wrote:
>>> On Thu, Feb 28, 2019 at 03:35:03PM +1100, Alexey Kardashevskiy wrote:
>>>> The configure script checks multiple times whether it works in a git
>>>> repository and it does this by "test -e "${source_path}/.git" in 4 cases
>>>> but in one case where it tries to enable werror "-d" is used there which
>>>> fails on git worktrees as .git is a file then and not a directory.
>>
>> That confused me. What is a "git worktree" where .git is a file? So far
>> .git was always a directory here...?
> 
> git worktree --help
> 
> A worktree is basically a clone, but instead of copying over the git
> repo it is simply referenced.
> 
> That is not the only possible case where .git is a file not a directory.
> In newer versions "git submodule" stores the repo in
> .git/modules/$submodule and $submodule/.git is just a file with a
> reference:
> 
> kraxel@sirius ~/projects/qemu# cat roms/seabios/.git
> gitdir: ../../.git/modules/roms/seabios
> 
> So, yes, the patch makes sense.
> 
> cheers,
>   Gerd
> 

Queued, thanks.

Paolo
