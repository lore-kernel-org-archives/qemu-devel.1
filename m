Received: from eggs.gnu.org ([209.51.188.92]:38757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJiPq-00044u-2E
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:44:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJiPl-0001gH-MN
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:44:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hJiPc-0001aS-TY
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:43:59 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6772320261
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 17:43:54 +0000 (UTC)
Date: Thu, 25 Apr 2019 14:43:50 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190425174350.GP18406@habkost.net>
References: <20190423212246.3542-1-ehabkost@redhat.com>
	<20190423212246.3542-4-ehabkost@redhat.com>
	<a1529434-54e0-0d2e-4275-1c6080c1cffe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1529434-54e0-0d2e-4275-1c6080c1cffe@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] qmp: Add deprecation information to
 query-machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Cc: qemu-devel@nongnu.org, mprivozn@redhat.com, Markus Armbruster <armbru@redhat.com>

On Thu, Apr 25, 2019 at 11:54:34AM -0300, Wainer dos Santos Moschetta wrote:
> Hi Eduardo,
> 
> On 04/23/2019 06:22 PM, Eduardo Habkost wrote:
[...]
> > +class QueryMachines(Test):
> > +    def test(self):
> 
> I suggest to use a meaning test case name as it will be displayed with
> Avocado output. Something like 'test_status_information'.

This is a generic test case for query-machines, and I don't
expect it to be specific for validating support-status.

> 
> > +        self.vm.launch()
> > +        machines = self.vm.command('query-machines')
> 
> Also I suggest to assert you got at least on machine, so ensure
> 'query-machines' returning nothing doesn't pass unnoticed.

Good idea.  I will send this in v2 or as a follow up patch.
Thanks!

-- 
Eduardo
