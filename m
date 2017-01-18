Received: from eggs.gnu.org ([2001:4830:134:3::10]:48321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTpvD-0001PA-Kd
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:05:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTpv9-0000mr-JU
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:05:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cTpv9-0000mQ-Dy
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:04:59 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8501C3674A5
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 13:04:59 +0000 (UTC)
References: <20170117180051.11958-1-ehabkost@redhat.com>
	<50210df4-dcd8-8b2e-daab-d0c53449689a@redhat.com>
	<20170118125246.GT3491@thinpad.lan.raisama.net>
	<455f3089-c690-fb19-a861-aa18c07b6812@redhat.com>
	<20170118125820.GX3491@thinpad.lan.raisama.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a60dc21e-4576-db45-0e57-9f95f18acce3@redhat.com>
Date: Wed, 18 Jan 2017 14:04:57 +0100
MIME-Version: 1.0
In-Reply-To: <20170118125820.GX3491@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] arch_init: Remove unnecessary
 default_config_files table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>



On 18/01/2017 13:58, Eduardo Habkost wrote:
> On Wed, Jan 18, 2017 at 01:55:21PM +0100, Paolo Bonzini wrote:
>>
>>
>> On 18/01/2017 13:52, Eduardo Habkost wrote:
>>>>
>>>> Though maybe we should just remove .conf file support completely...
>>>> who's using it?!?
>>> You mean removing /etc/qemu.conf, or removing -readconfig
>>> completely?
>>>
>>> The former doesn't seem to be used often. The latter looks very
>>> useful for people trying to write scripts around QEMU and to
>>> avoid command-line length limits, so I will be surprised if
>>> nobody is using it.
>>
>> Of course /etc/qemu.conf only (so that -nodefconfig/-nouserconfig become
>> no-ops).
> 
> Agreed. Should we print a warning in 2.9 and remove it in 2.10?

I would just remove it, but that sounds like a plan too. :)

Paolo
