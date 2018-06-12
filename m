Received: from eggs.gnu.org ([2001:4830:134:3::10]:58474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fSkqD-0001rw-MG
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 11:04:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fSkqA-0002SI-K2
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 11:04:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38690 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fSkqA-0002Rp-FK
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 11:04:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 929E540201A3
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 15:04:09 +0000 (UTC)
References: <1525843212-31922-1-git-send-email-thuth@redhat.com>
	<87bmch48w6.fsf@dusky.pond.sub.org>
	<a16c729a-8856-1141-5a6f-e647624bab44@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dcd08712-9dbd-eeda-7040-40b1afb14429@redhat.com>
Date: Tue, 12 Jun 2018 17:04:07 +0200
MIME-Version: 1.0
In-Reply-To: <a16c729a-8856-1141-5a6f-e647624bab44@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add an entry for
 qemu-options* files in main directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

On 12/06/2018 12:46, Thomas Huth wrote:
>>
>> Your patch does what is possible with a monolithic interface definition:
>> it dumps it all on one maintainer: me.  I'm struggling to keep up with
>> the QAPI schema, I'm not sure I can take more.
>>
>> Note that "Command line option argument parsing" is phrased carefully:
>> it's not "CLI", not even "CLI parsing".  qemu-options* does not fit
>> there.  Two solutions: widen the section so it fits better, create a new
>> section.  The latter would be closer to how we do QMP.
>>
>> What do you think?
> Both ideas sound fine to me. What about adding a new section called
> "Generic command line options"? I hope that the word "generic" then
> makes it clear that this entry is primarily thought for generic options
> - subsystem specific options can and should still go through the
> subsystem trees instead.
> 
> Do you think you could still be available as (co-)maintainer of that new
> section? If not, who are going to be the maintainers of that new
> section? Paolo? Eric? Daniel? ...?

Well, currently it's going through me.  I'd add vl.c too, by the way.

Paolo
