Received: from eggs.gnu.org ([2001:4830:134:3::10]:52373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dGOqg-00024G-Dc
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:05:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dGOqc-0002Zf-JX
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:05:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:42151)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dGOqc-0002ZI-Aj
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:05:02 -0400
Date: Thu, 1 Jun 2017 20:04:54 +0800
From: Zhong Yang <yang.zhong@intel.com>
Message-ID: <20170601120454.GB18829@yangzhon-Virtual>
References: <1496212144-14947-1-git-send-email-yang.zhong@intel.com>
	<c5d963e7-ef71-0ed5-aaae-01d492e4fd8b@redhat.com>
	<20170601052736.GA17625@yangzhon-Virtual>
	<fc8f01b6-5b87-bd9e-0648-b489e00a6dfe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc8f01b6-5b87-bd9e-0648-b489e00a6dfe@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/6] tcg: move the tcg files into tcg/
 subdirectory.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Laurent Desnogues <laurent.desnogues@gmail.com>, anthony.xu@intel.com, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Thu, Jun 01, 2017 at 10:14:34AM +0200, Paolo Bonzini wrote:
> 
> 
> On 01/06/2017 07:27, Zhong Yang wrote:
> >   In the first phase, there are three patchsets to
> >   deal with split code and separate the files.
> >   1) split the tcg exec code.
> >      a)split the tcg accelerators from accel.c file and re-name
> >        tcg accelerator to tcg-all.c, like kvm-all.c did.
> >      b)create one accel directory, which will include kvm,
> >        tcg and general exec files.
> >      c)move tcg exec files into ./accel/tcg directory.
> >   2) move tcg related backend files into tcg/ directory
> >      those files include translate-all.(ch), translate-common.c,
> >      tci.c and tcg-runtime.c.
> >   3) move kvm exec and exec.c file.
> >      a)move kvm related exec files into ./accel/kvm directory.
> >      b)move exec.c in ./accel directory.
> > 
> >   after 1) and 3) done, the file tree like below:
> >   accel/
> >   ├── accel.c
> >   ├── exec.c
> >   ├── kvm
> >   │   ├── kvm-all.c
> >   │   ├── kvm-stub.c
> >   │   ├── Makefile.objs
> >   │   └── trace-events
> >   ├── Makefile.objs
> >   └── tcg
> >       ├── cpu-exec.c
> >       ├── cpu-exec-common.c
> >       ├── cputlb.c
> >       ├── Makefile.objs
> >       ├── tcg-all.c
> >       └── trace-events
> >   
> >   please help me check whether this kind of arrange is suitable? 
> 
> Oh, I see now.  I think translate-all.[ch] and translate-common.c belong
> in accel/tcg more than tcg/.

  okay, i will make those changes into one patchset and send v3 to all, thanks!

  Yang.
> 
> Thanks,
> 
> Paolo
