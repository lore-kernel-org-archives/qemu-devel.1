Received: from eggs.gnu.org ([2001:4830:134:3::10]:41843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eAMXc-0001mf-Ci
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 16:56:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eAMXb-0006Ni-D4
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 16:56:44 -0400
References: <1508784509-29377-1-git-send-email-thuth@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <2aa7bf9c-cceb-fdf7-4eac-5d318c854518@redhat.com>
Date: Thu, 2 Nov 2017 16:56:28 -0400
MIME-Version: 1.0
In-Reply-To: <1508784509-29377-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/ide/ahci: Move allwinner code into a
 separate file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-trivial@nongnu.org, qemu-arm@nongnu.org



On 10/23/2017 02:48 PM, Thomas Huth wrote:
> The allwinner code is only needed for the allwinner board (for which
> we also have a separate CONFIG_ALLWINNER_A10 config switch), so it
> does not make sense that we compile this for all the other boards
> that need AHCI, too. Let's move it to a separate file that is only
> compiled when CONFIG_ALLWINNER_A10 is set.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Belated, as it's already merged to master, but:

Thanks, applied to my IDE tree:

https://github.com/jnsnow/qemu/commits/ide
https://github.com/jnsnow/qemu.git

--js
