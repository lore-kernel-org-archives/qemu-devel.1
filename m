Received: from eggs.gnu.org ([2001:4830:134:3::10]:49089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dor5v-0004qJ-94
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 09:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dor4B-0003VZ-Tz
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 09:07:15 -0400
Date: Mon, 4 Sep 2017 15:05:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170904150524.7fdcc0a0@nial.brq.redhat.com>
In-Reply-To: <20170904111054.GB2735@umbus.fritz.box>
References: <1504099475-241036-9-git-send-email-imammedo@redhat.com>
	<1504103170-259479-1-git-send-email-imammedo@redhat.com>
	<20170904111054.GB2735@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 9/8] fixup! ppc: remove non implemented
 cpu models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>

On Mon, 4 Sep 2017 21:10:54 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Aug 30, 2017 at 04:26:10PM +0200, Igor Mammedov wrote:
> > only TODO escaped defines were meant to be removed,
> > but not TODO_USER_ONLY which are compiled in case of
> > *-user targets.
> > 
> > So retirn back "440" model removed by mistake
> > 
> > Spotted-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>  
> 
> I've applied patch 8 with this change folded in, so as not to break
> bisect.
Thanks!
