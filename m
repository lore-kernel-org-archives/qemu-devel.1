Received: from eggs.gnu.org ([2001:4830:134:3::10]:55690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gJuZh-0002gV-Cj
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 01:10:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gJuZc-0004dE-4E
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 01:10:53 -0500
Received: from mail.ispras.ru ([83.149.199.45]:39868)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gJuZb-0004TV-RY
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 01:10:48 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20181030093031.10131.17221.stgit@pasha-VirtualBox>
	<20181103132509.GF24365@umbus.hotspot.internet-for-guests.com>
In-Reply-To: <20181103132509.GF24365@umbus.hotspot.internet-for-guests.com>
Date: Tue, 6 Nov 2018 09:10:45 +0300
Message-ID: <003301d47597$749c0340$5dd409c0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH] target/ppc: fix mtmsr instruction for
 icount
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'David Gibson' <david@gibson.dropbear.id.au>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, maria.klimushenkova@ispras.ru, agraf@suse.de

> From: David Gibson [mailto:david@gibson.dropbear.id.au]
> On Tue, Oct 30, 2018 at 12:30:31PM +0300, Pavel Dovgalyuk wrote:
> > This patch fixes processing of mtmsr instructions in icount mode.
> > In this mode writing to interrupt/peripheral state is controlled
> > by can_do_io flag. This flag must be set explicitly before helper
> > function invocation.
> >
> > Signed-off-by: Maria Klimushenkova <maria.klimushenkova@ispras.ru>
> > Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> 
> Applied to ppc-for-3.1, thanks.

Thanks. What about this one
https://patchew.org/QEMU/20181030122134.11055.15711.stgit@pasha-VirtualBox/
There is a mess with the subject, but the code is ok :)


Pavel Dovgalyuk
