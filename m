Received: from eggs.gnu.org ([2001:4830:134:3::10]:37073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elliott@hpe.com>) id 1fOcLf-000450-Ex
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 01:11:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elliott@hpe.com>) id 1fOcLc-00085D-90
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 01:11:35 -0400
Received: from g2t2354.austin.hpe.com ([15.233.44.27]:32910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elliott@hpe.com>) id 1fOcLc-0007ty-1p
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 01:11:32 -0400
From: "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
Date: Fri, 1 Jun 2018 05:11:28 +0000
Message-ID: <AT5PR8401MB1169ACFF025365F3EDFE11BDAB620@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <20180521163203.26590-1-ross.zwisler@linux.intel.com>
	<20180529195433.GA16151@linux.intel.com>
In-Reply-To: <20180529195433.GA16151@linux.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [qemu PATCH v4 0/4] support NFIT platform
 capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Igor Mammedov <imammedo@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Haozhong Zhang <haozhong.zhang@intel.com>, "Michael
	S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>

> Ping on this series.  Rob, I think I've addressed all your feedback.
> Can you please verify?

I haven't tested it, but it reads OK.  I'm OK with just extending
the valid count for bits set to one for now; we can add a new
argument later if a need arises for extending it to express new bits
set to zero.
