Received: from eggs.gnu.org ([2001:4830:134:3::10]:54039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cTNRh-0003cA-NG
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 01:40:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cTNRd-0007Bb-Ou
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 01:40:41 -0500
Date: Tue, 17 Jan 2017 14:40:28 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170117064028.GC21563@lemon.Home>
References: <5878AF90.8020709@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5878AF90.8020709@kamp.de>
Subject: Re: [Qemu-devel] Data corruption in Qemu 2.7.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-stable@nongnu.org

On Fri, 01/13 11:44, Peter Lieven wrote:
> Hi,
> 
> i currently facing a problem in our testing environment where I see file
> system corruption with 2.7.1 on iSCSI and Local Storage (LVM).
> Trying to bisect, but has anyone observed this before?

The information here is too scarce to tell but a file corruption is more often a
result of two writers modifying the disk concurrently. Have you ruled that out?
Is the corruption reproducible?

Fam
