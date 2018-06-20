Received: from eggs.gnu.org ([2001:4830:134:3::10]:58817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fVi2C-0005qZ-24
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 14:40:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fVi27-0002xn-0L
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 14:40:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37488 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fVi26-0002xf-Q0
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 14:40:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5969A4022414
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 18:40:42 +0000 (UTC)
References: <1528688464-17289-1-git-send-email-thuth@redhat.com>
	<20180611221859.GE7451@localhost.localdomain>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5231573e-f53d-dba2-e39c-5f3755505cca@redhat.com>
Date: Wed, 20 Jun 2018 20:40:38 +0200
MIME-Version: 1.0
In-Reply-To: <20180611221859.GE7451@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/i386: Deprecate the machine types
 pc-0.10 and pc-0.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 12.06.2018 00:18, Eduardo Habkost wrote:
> On Mon, Jun 11, 2018 at 05:41:04AM +0200, Thomas Huth wrote:
>> The oldest machine type which is still used in a maintained distribution
>> is a pc-0.12 based machine type in RHEL6, so everything that is older
>> than pc-0.12 should not be used anymore. Thus let's deprecate pc-0.10
>> and pc-0.11 so that we can finally remove them in a future release.
[...]
>> @@ -3952,6 +3953,10 @@ int main(int argc, char **argv, char **envp)
>>      }
>>  
>>      machine_class = select_machine();
>> +    if (machine_class->deprecation_msg) {
>> +        error_report("Machine type '%s' is deprecated: %s",
>> +                     machine_class->name, machine_class->deprecation_msg);
>> +    }
> 
> Do you plan to add this info to 'query-machines' QMP command?

No, I'm not planning to add this. We'd need a request from upper layers
(i.e. libvirt) for this first, otherwise it's just a dead interface that
nobody is using.

 Thomas
