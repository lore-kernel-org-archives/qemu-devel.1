Received: from eggs.gnu.org ([209.51.188.92]:39468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hEDny-0003Io-Sa
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:02:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hEDnt-0008E5-CF
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:02:22 -0400
Received: from mga06.intel.com ([134.134.136.31]:10314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hEDns-0008BB-S7
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:02:17 -0400
Date: Wed, 10 Apr 2019 22:01:53 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190410140153.GA2919@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <1554822037-329838-1-git-send-email-imammedo@redhat.com>
	<20190410011231.GA29083@richard>
	<20190410110833.4db9721f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410110833.4db9721f@redhat.com>
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, mst@redhat.com, marcel.apfelbaum@gmail.com, ehabkost@redhat.com

On Wed, Apr 10, 2019 at 11:08:33AM +0200, Igor Mammedov wrote:
>On Wed, 10 Apr 2019 09:12:31 +0800
>Wei Yang <richardw.yang@linux.intel.com> wrote:
>
>> On Tue, Apr 09, 2019 at 05:00:37PM +0200, Igor Mammedov wrote:
>> >Dummy table (with signature "QEMU") creation came from original SeaBIOS
>> >codebase. And QEMU would have to keep it around if there were Q35 machine
>> >that depended on keeping ACPI tables blob constant size. Luckily there
>> >were no versioned Q35 machine types before commit:
>> >  (since 2.3) a1666142db acpi-build: make ROMs RAM blocks resizeable
>> >which obsoleted need to keep ACPI tables blob the same size on source/destination.
>> >  
>> 
>> I am not sure getting the "versioned Q35" correctly. Seems originally there is
>> q35-1.4?
>> 
>> commit bf3caa3dc17552b323cec6831301a22cfc98ecd5
>> Author: Paolo Bonzini <pbonzini@redhat.com>
>> Date:   Fri Feb 8 14:06:15 2013 +0100
>> 
>>     pc: add compatibility machine types for 1.4
>>     
>>     Adds both pc-i440fx-1.4 and pc-q35-1.4.
>
>current upstream has only pc-q35-2.4 as earliest versioned Q35
>machine type (try to run: qemu-system-x86_64 -M help)

Yes, I see those old type are removed. This means we don't want to support
those old types, right? Because those old types can't be migrated to latest
upstream qemu.

-- 
Wei Yang
Help you, Help me
