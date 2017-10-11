Received: from eggs.gnu.org ([2001:4830:134:3::10]:41982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lyan@suse.com>) id 1e2Nu3-0003ZF-BB
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 16:46:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lyan@suse.com>) id 1e2Nty-0004Kg-DL
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 16:46:55 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:36918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lyan@suse.com>) id 1e2Nty-0004Js-6f
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 16:46:50 -0400
References: <150729895903.22243.5921581973131047310.malonedeb@gac.canonical.com>
	<150730021408.8281.13104272267482208285.malone@wampee.canonical.com>
From: Liang Yan <lyan@suse.com>
Message-ID: <b10b109e-9a87-bf4e-bc72-eea4c0bcee70@suse.com>
Date: Wed, 11 Oct 2017 16:46:40 -0400
MIME-Version: 1.0
In-Reply-To: <150730021408.8281.13104272267482208285.malone@wampee.canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [Bug 1721788] Re: Failed to get shared "write"
 lock with 'qemu-img info'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1721788 <1721788@bugs.launchpad.net>, qemu-devel@nongnu.org

This does  not only affect qemu-img only, it could not make libvirt
"<shareable>" work either when two vms were running with share disk
image.  Is there a workaround for this situation?

Best,
Liang

On 10/6/17 10:30 AM, Daniel Berrange wrote:
> I've just noticed, however, that '--force-share' appears totally
> undocumented in both CLI help output and the man page. So that's
> certainly something that should be fixed
>
