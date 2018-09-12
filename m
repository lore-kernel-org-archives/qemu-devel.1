Received: from eggs.gnu.org ([2001:4830:134:3::10]:38757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fzzoq-0008Lk-Qd
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 03:44:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fzzol-0006uk-2W
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 03:44:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34636 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fzzok-0006uN-T7
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 03:44:07 -0400
Date: Wed, 12 Sep 2018 15:44:02 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180912074402.GB11164@lemon.usersys.redhat.com>
References: <CAB3eZfvRJRR1k0X1MQivPMcLRNZR07yv1ZxBiDAkF3qOryK0UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB3eZfvRJRR1k0X1MQivPMcLRNZR07yv1ZxBiDAkF3qOryK0UQ@mail.gmail.com>
Subject: Re: [Qemu-devel] Can I convert backing file to internal snapshot?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lampahome <pahome.chen@mirlab.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Wed, 09/12 15:35, lampahome wrote:
> I have two qcow2 A & B, and A is backing file of B.
> 
> Can I convert both A&B to one image and containing data of both?
> 
> ex:
> one new image will contain data of A and B. When I check it by qemu-img
> info, I can see one snapshot in the new image.

I believe it's possible to create an internal snapshot in A and then qemu-img
commit B to A. From here, the active content is B, and the snapshot is A.

Fam
