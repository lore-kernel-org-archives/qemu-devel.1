Received: from eggs.gnu.org ([2001:4830:134:3::10]:58439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gIdQW-0003e6-KF
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:40:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gIdQS-0002BN-Vm
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:40:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gIdQS-0001uI-AS
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:40:04 -0400
References: <CAFjp5T7PXvmJAgYNY_T782vtdETy-3ks3rYtBpwXePGdEw-DJA@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <81efd239-cf58-9645-3425-c2ac16337e45@redhat.com>
Date: Fri, 2 Nov 2018 13:39:44 -0400
MIME-Version: 1.0
In-Reply-To: <CAFjp5T7PXvmJAgYNY_T782vtdETy-3ks3rYtBpwXePGdEw-DJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Regarding: Migration of VM created using qemu
 source code built
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: aditya bhardwaj <aditya.cse@nitttrchd.ac.in>, qemu-devel@nongnu.org



On 11/01/2018 03:14 AM, aditya bhardwaj wrote:
> Respected Sir,
> 
> I followed https://wiki.qemu.org/Hosts/Linux to build qemu from source
> code. Its installed successfully with Ubuntu 16.04 VM created using VNC
> server.
> 
> *Now, Could you please suggest me how to migrate VM from one host to
> another?.*
> 

Are you trying to migrate and running into problems, or you don't know
how to attempt it?

The simplest version is that you launch QEMU on the destination with the
same arguments, but you add the `-incoming` flag to tell it to listen
for incoming migration data.

Look at https://qemu.weilnetz.de/doc/qemu-doc.html and search for
"-incoming".

On the source, you use either the HMP or QMP protocol to tell QEMU to
migrate to a URI where the destination can pick it up (tcp, unix socket,
pipe, whatever.)

Take a look at http://www.linux-kvm.org/page/Migration for some basics.

If you can't access the hard drive images/devices from both the source
and dest machine, you'll want to do a block storage migration, too. At
this point you really want to be using libvirt to help you accomplish
that because it can get involved.

--js

> I goggled lot but not getting any solution.
> 
