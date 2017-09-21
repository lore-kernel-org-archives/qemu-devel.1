Received: from eggs.gnu.org ([2001:4830:134:3::10]:56482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duvxG-0000w2-Ky
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 03:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duvxD-0007Ly-IN
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 03:31:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duvxD-0007L8-DZ
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 03:31:23 -0400
Date: Thu, 21 Sep 2017 09:31:18 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170921093118.677e0819.cohuck@redhat.com>
In-Reply-To: <20170921005036.GL11080@bjsdjshi@linux.vnet.ibm.com>
References: <20170919182745.90280-1-pasic@linux.vnet.ibm.com>
	<20170919182745.90280-6-pasic@linux.vnet.ibm.com>
	<20170920074238.GH11080@bjsdjshi@linux.vnet.ibm.com>
	<20170920103312.50b8b69b.cohuck@redhat.com>
	<009428a2-fb31-ecc9-d477-4cdea226f2d8@linux.vnet.ibm.com>
	<20170920131844.066e53d7.cohuck@redhat.com>
	<268904f1-0b31-3255-02da-c3248abef6a2@linux.vnet.ibm.com>
	<20170921005036.GL11080@bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/5] s390x/css: support ccw IDA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Thu, 21 Sep 2017 08:50:36 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Halil Pasic <pasic@linux.vnet.ibm.com> [2017-09-20 18:46:57 +0200]:

> > Thinking about this some more. Since in case of IDA we are guaranteed
> > to never cross a block boundary with a single IDAW we won't ever cross
> > block boundary. So we can do the check in ida_read_next_idaw by checking
> > bit 0x80000000 on the ccw->cda. So we could keep idaw_fmt2 and ccw_fmt1
> > local to ida_read_next_idaw and save one goto err. I think that would
> > look a bit nicer than what I have here in v3. Agree?  
> Agree. That would also do the check in the first place. Sounds better.

Can't argue with nicer code, either :) Looking forward to the next
version.
