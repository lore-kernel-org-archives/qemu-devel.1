Received: from eggs.gnu.org ([209.51.188.92]:34920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hE9Dq-0003on-Ui
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 05:08:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hE9Do-0001Il-E1
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 05:08:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hE9Do-0001HH-4U
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 05:08:44 -0400
Date: Wed, 10 Apr 2019 11:08:33 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190410110833.4db9721f@redhat.com>
In-Reply-To: <20190410011231.GA29083@richard>
References: <1554822037-329838-1-git-send-email-imammedo@redhat.com>
	<20190410011231.GA29083@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.1] q35: acpi: do not create dummy
 MCFG table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, marcel.apfelbaum@gmail.com, ehabkost@redhat.com

On Wed, 10 Apr 2019 09:12:31 +0800
Wei Yang <richardw.yang@linux.intel.com> wrote:

> On Tue, Apr 09, 2019 at 05:00:37PM +0200, Igor Mammedov wrote:
> >Dummy table (with signature "QEMU") creation came from original SeaBIOS
> >codebase. And QEMU would have to keep it around if there were Q35 machine
> >that depended on keeping ACPI tables blob constant size. Luckily there
> >were no versioned Q35 machine types before commit:
> >  (since 2.3) a1666142db acpi-build: make ROMs RAM blocks resizeable
> >which obsoleted need to keep ACPI tables blob the same size on source/destination.
> >  
> 
> I am not sure getting the "versioned Q35" correctly. Seems originally there is
> q35-1.4?
> 
> commit bf3caa3dc17552b323cec6831301a22cfc98ecd5
> Author: Paolo Bonzini <pbonzini@redhat.com>
> Date:   Fri Feb 8 14:06:15 2013 +0100
> 
>     pc: add compatibility machine types for 1.4
>     
>     Adds both pc-i440fx-1.4 and pc-q35-1.4.

current upstream has only pc-q35-2.4 as earliest versioned Q35
machine type (try to run: qemu-system-x86_64 -M help)
