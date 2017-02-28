Received: from eggs.gnu.org ([2001:4830:134:3::10]:45142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cikLQ-0007FR-2F
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:09:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cikLO-00083Z-VR
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:09:44 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:35672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cikLO-00083U-OQ
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:09:42 -0500
Received: by mail-oi0-x242.google.com with SMTP id z13so1168945oig.2
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 08:09:42 -0800 (PST)
MIME-Version: 1.0
Sender: bobby.prani@gmail.com
In-Reply-To: <4e9eeab8-faca-b6ba-d53e-a8fbf5848c0f@msgid.tls.msk.ru>
References: <1488277840-18608-1-git-send-email-groug@kaod.org>
	<2a8da4e5-d66d-502c-322b-ec942f250f40@msgid.tls.msk.ru>
	<20170228152240.6efc1fbc@bahia.lan>
	<4e9eeab8-faca-b6ba-d53e-a8fbf5848c0f@msgid.tls.msk.ru>
From: Pranith Kumar <bobby.prani+qemu@gmail.com>
Date: Tue, 28 Feb 2017 11:09:11 -0500
Message-ID: <CAJhHMCAWFy4o4br265CXq65rUPafKgxqX_dX+mBTErvqfA0pNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/28] 9p CVE-2016-9602 fixes 2017-02-28 for
 2.9 soft freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel <qemu-devel@nongnu.org>

On Tue, Feb 28, 2017 at 9:55 AM, Michael Tokarev <mjt@tls.msk.ru> wrote:
>>
>> https://github.com/gkurz/qemu/commits/cve-2016-9602-for-upstream
>> https://github.com/gkurz/qemu/commit/c23d5f1d5bc0e23aeb845b1af8f996f16783ce98
>
> Interesting. Perhaps I've never worked with github before.
> It works when referring to particular commit like this.
> but the tag isn't visible in github UI, and neither the
> tag nor this commit ID is visible when cloning github
> repository locally. I wonder where's that.
>
> $ git remote -v | grep gkurz
> gkurz   git://github.com/gkurz/qemu.git (fetch)
> gkurz   git://github.com/gkurz/qemu.git (push)
> $ git remote update gkurz
> Fetching gkurz
> $ git show c23d5f1d5bc0e23aeb845b1af8f996f16783ce98
> fatal: bad object c23d5f1d5bc0e23aeb845b1af8f996f16783ce98
> $ git show cve-2016-9602-for-upstream --
> fatal: bad revision 'cve-2016-9602-for-upstream'
>
> that's now.  I'll dig into that later, there's apparently
> nothing wrong on your side, I'm sorry for the noise.
>

I think the answer is given here:
https://eddiemoya.com/2013/02/21/better-git-git-fetch-not-getting-tags/

You have to explicitly fetch the tags using 'git fetch -t gkurz' to
get the tags which are not direct references to a commit.

$ git remote update gkurz
Fetching gkurz
>From https://github.com/gkurz/qemu
 * [new branch]            9p-attr-fixes         -> gkurz/9p-attr-fixes
 * [new branch]            9p-cleanup            -> gkurz/9p-cleanup
 * [new branch]            9p-fix                -> gkurz/9p-fix
 * [new branch]            9p-next               -> gkurz/9p-next
 * [new branch]            9p-proxy              -> gkurz/9p-proxy
 * [new branch]            9p-security           -> gkurz/9p-security
 * [new branch]            9p-symlink            -> gkurz/9p-symlink
 * [new branch]            9p-tests              -> gkurz/9p-tests
 * [new branch]            ppc-vcpu-dt-id-rework -> gkurz/ppc-vcpu-dt-id-rework

$ git fetch -t gkurz
remote: Counting objects: 155, done.
remote: Compressing objects: 100% (145/145), done.
remote: Total 155 (delta 126), reused 8 (delta 8), pack-reused 2
Receiving objects: 100% (155/155), 41.89 KiB | 0 bytes/s, done.
Resolving deltas: 100% (126/126), completed with 6 local objects.
>From https://github.com/gkurz/qemu
 * [new tag]               cve-2016-9602-for-upstream ->
cve-2016-9602-for-upstream
 t [tag update]            for-upstream               -> for-upstream
 t [tag update]            for_anthony                -> for_anthony


Thanks,
--
Pranith
