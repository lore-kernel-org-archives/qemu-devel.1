Received: from eggs.gnu.org ([2001:4830:134:3::10]:58873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d3KYI-0002AW-Hh
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:52:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d3KYH-0008Tp-M2
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:52:06 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:38896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d3KYH-0008TW-FN
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:52:05 -0400
Received: by mail-wm0-x22a.google.com with SMTP id r190so46353wme.1
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 03:52:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1493161481-29595-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1493161481-29595-1-git-send-email-mdroth@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Apr 2017 11:51:43 +0100
Message-ID: <CAFEAcA95pEZhoqhBjh8_XuFs9-J2NPnHM06po9L+X=++2mJOeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/8] qemu-ga patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 26 April 2017 at 00:04, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> The following changes since commit fe491fa85c4634453b340b18046aae2eaf8147db:
>
>   Merge remote-tracking branch 'remotes/agraf/tags/signed-s390-for-upstream' into staging (2017-04-25 14:48:55 +0100)
>
> are available in the git repository at:
>
>   git://github.com/mdroth/qemu.git tags/qga-pull-2017-04-25-tag
>
> for you to fetch changes up to b3734da00e4285521f8eb2c958ab08b981f7a298:
>
>   qga: Add `guest-get-timezone` command (2017-04-25 15:49:24 -0500)
>
> ----------------------------------------------------------------
> qemu-ga patch queue
>
> * new commands: guest-get-timezone, guest-get-users, guest-get-host-name
> * fix hang on w32 when stopping qemu-ga service while fs frozen
> * fix missing setting of can-offline in guest-get-vcpus
> * make qemu-ga VSS w32 service on-demand rather than on-startup
> * fix unecessary errors to EventLog on w32
> * improvements to fsfreeze documentation
>

Hi. I'm afraid this doesn't build with clang:

In file included from
/Users/pm215/src/qemu-for-merges/qapi/qapi-dealloc-visitor.c:15:
In file included from /Users/pm215/src/qemu-for-merges/include/qemu/osdep.h:107:
/Users/pm215/src/qemu-for-merges/include/glib-compat.h:221:17: error:
unused function 'g_hash_table_contains' [-Werror,-Wunused-function]
static gboolean g_hash_table_contains(GHashTable *hash_table, gpointer key)
                ^
1 error generated.

Marking it "static inline" should fix this.

thanks
-- PMM
