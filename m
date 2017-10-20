Received: from eggs.gnu.org ([2001:4830:134:3::10]:58579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e5RR3-000563-BN
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 03:09:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e5RR0-0000ap-5Z
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 03:09:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1e5RQz-0000aH-Uw
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 03:09:34 -0400
Date: Fri, 20 Oct 2017 15:09:27 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171020070927.GF29815@lemon>
References: <20171016131644.9565-1-kraxel@redhat.com>
	<20171016131644.9565-8-kraxel@redhat.com>
	<e41b2fbc-98ed-cabb-4236-2126b887626c@redhat.com>
	<58a70aa2-c318-b9de-de07-540b7c19d423@redhat.com>
	<c10f4e46-1e65-496d-4450-a5462973cc23@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c10f4e46-1e65-496d-4450-a5462973cc23@redhat.com>
Subject: Re: [Qemu-devel] [PULL 07/11] tools: add qemu-keymap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Fri, 10/20 08:52, Thomas Huth wrote:
> On 20.10.2017 00:12, Eric Blake wrote:
> > On 10/19/2017 05:09 PM, Eric Blake wrote:
> >> On 10/16/2017 08:16 AM, Gerd Hoffmann wrote:
> >>> qemu-keymap generates qemu reverse keymaps from xkb keymaps,
> >>> which can be used with the qemu "-k" command line switch.
> >>>
> >>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> >>> Message-id: 20171005153330.19210-2-kraxel@redhat.com
> >>> ---
> >>>  configure     |  23 ++++++
> >>>  Makefile      |   5 ++
> >>>  qemu-keymap.c | 258 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>>  3 files changed, 286 insertions(+)
> >>>  create mode 100644 qemu-keymap.c
> >>
> >> For in-tree builds, this forgot to update .gitignore so that
> >> 'qemu-keymap' isn't accidentally checked in via 'git add -a'.
> > 
> > And on a related note, commit 2e1d70b pollutes the tree with a new
> > ui/shader/texture-blit-flip-vert.h, that should also be mentioned in
> > .gitignore.
> 
> Since this seems to happen regularly: I wonder whether we could add a
> check to patchew that tests whether the output of "git status" is clean
> at the end of an in-tree compilation process?

Sounds good, I'll try to write a $QEMU_SRC/tests/docker/test-cleanness patch
first.

Fam
