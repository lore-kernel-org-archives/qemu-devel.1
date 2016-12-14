Received: from eggs.gnu.org ([2001:4830:134:3::10]:43495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cH3vR-00036o-67
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 02:24:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cH3vN-0001DV-VC
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 02:24:29 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:35919)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cH3vN-0001DI-Ov
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 02:24:25 -0500
Received: by mail-io0-f196.google.com with SMTP id b194so3112004ioa.3
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 23:24:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAAo6VWMJAYeLdtEmyQ43vYeYjvNzCP80Wufe4=eNRUZum0rYdQ@mail.gmail.com>
References: <CAAo6VWMJAYeLdtEmyQ43vYeYjvNzCP80Wufe4=eNRUZum0rYdQ@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 14 Dec 2016 07:23:24 +0000
Message-ID: <CAJSP0QV7QCLwih+F30hcohmwYQ1Ci+6bMPuCj_Kk9hwbmgWzUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v7 RFC] block/vxhs: Initial commit to add
 Veritas HyperScale VxHS block device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ashish mittal <ashmit602@gmail.com>
Cc: Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <Ashish.Mittal@veritas.com>, Abhijit Dey <Abhijit.Dey@veritas.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Gaurav Bhandarkar <Gaurav.Bhandarkar@veritas.com>, Abhishek Kane <Abhishek.Kane@veritas.com>, Ketan Mahajan <Ketan.Mahajan@veritas.com>, Niranjan Pendharkar <Niranjan.Pendharkar@veritas.com>, Nirendra Awasthi <Nirendra.Awasthi@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>

On Wed, Dec 14, 2016 at 12:06 AM, ashish mittal <ashmit602@gmail.com> wrote:
> I am requesting feedback on the following design proposal for libqnio.
>
> This adds an access control mechanism between libqnio client and
> server. It is not a full client-server authentication model, and it is
> not intended to substitute an authentication mechanism.
>
> We wanted to check if the following would be acceptable for the first
> version of VxHS patch while we design/implement a proper
> authentication mechanism (possibly on a libqnio side branch)?
>
> 1.       Client passes VM ID and vdisk ID to the server when it wants
> to open a vdisk.
> 2.       Server verifies whether the client/VM has access to open the
> disk and passes/fails the open request.

Are the VM ID and vdisk ID secrets?

If yes, then this is an authentication scheme.

If no, then this is not secure and probably not worth doing.

Stefan
