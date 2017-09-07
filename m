Received: from eggs.gnu.org ([2001:4830:134:3::10]:35648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpvrS-0001e7-MN
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 08:24:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpvrN-0006mo-Ox
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 08:24:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33311)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dpvrN-0006ld-J7
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 08:24:41 -0400
Date: Thu, 7 Sep 2017 14:24:35 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170907142435.6d0e54e6.cohuck@redhat.com>
In-Reply-To: <b0629ddd-ebea-b6b2-36b0-09715aae3aee@linux.vnet.ibm.com>
References: <20170905111645.18068-1-pasic@linux.vnet.ibm.com>
	<20170905111645.18068-6-pasic@linux.vnet.ibm.com>
	<20170906151821.1a77afe5.cohuck@redhat.com>
	<abc65014-f9fa-4cea-7f49-3e97e3845a3c@linux.vnet.ibm.com>
	<20170906172023.19a283a0.cohuck@redhat.com>
	<cafc4452-bdc5-546f-2ed0-4f1cb230f474@linux.vnet.ibm.com>
	<20170907100640.60de537a.cohuck@redhat.com>
	<b0629ddd-ebea-b6b2-36b0-09715aae3aee@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/5] s390x/ccs: add ccw-tester emulated
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Thu, 7 Sep 2017 11:10:17 +0200
Janosch Frank <frankja@linux.vnet.ibm.com> wrote:

> The thing is that I want to test the subchannel and not the device and
> therefore I really do not want to have to issue control commands to a
> device in order to get data. Having a device that reads and writes
> without a lot of overhead (like this) is therefore my main target.

Yes, a simple device backend for the channel subsystem is useful.

What could also be useful is a way to inject errors, e.g. randomly
failing things and then verifying that a sensible error reaches the
guest. These paths are part of the css and not the device, so it makes
sense to verify that these are working as expected. (Especially as they
aren't usually seen in the wild.)

But let's defer that one :)

> 
> Where this device lives doesn't concern me and as I'm new to this
> wonderful IO system take my statements with some salt. :)

You'll learn to love it 8)

> Yes it is and we certainly want to be integrated in as much external
> testing as possible. It seems like a few people began to run into the
> same direction but chose different approaches. My zonk test intentions
> are mainly to get a understanding how this all works without having to
> use the Linux devices but getting my hands dirty with the instructions
> and structures.

Something zonk-like would probably be a good thing for a test setup
that can be run via make check or something like that.

> 
> I see your arguments and we'll look into it and discuss consolidating
> our efforts.

Great, thanks for doing that!
