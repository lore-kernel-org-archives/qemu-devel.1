Received: from eggs.gnu.org ([2001:4830:134:3::10]:51904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drLTM-0002ki-Bi
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 05:57:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drLTH-0003BL-E6
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 05:57:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1drLTH-0003B0-80
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 05:57:39 -0400
References: <cover.1503077821.git.alistair.francis@xilinx.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <06b2af89-9871-f121-7641-b2b1a0d8a02c@redhat.com>
Date: Mon, 11 Sep 2017 11:57:34 +0200
MIME-Version: 1.0
In-Reply-To: <cover.1503077821.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/2] Remove libqemustub.a in order to
 improve error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, armbru@redhat.com
Cc: alistair23@gmail.com

On 18/08/2017 20:47, Alistair Francis wrote:
> As discussed with Paolo and Markus let's combine libqemustub.a into
> libqemuutil.a to avoid circular dependencies.
> 
> Alistair Francis (2):
>   Makefile: Remove libqemustub.a
>   Convert remaining single line fprintf() to warn_report()
> 
>  Makefile                    |  7 +++----
>  Makefile.target             |  2 +-
>  docs/devel/build-system.txt | 14 +++++---------
>  tests/Makefile.include      |  8 ++++----
>  util/cutils.c               |  3 ++-
>  5 files changed, 15 insertions(+), 19 deletions(-)
> 

Queued, thanks (with Philippe's adjustments to the comments).

Paolo
