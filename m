Received: from eggs.gnu.org ([2001:4830:134:3::10]:54304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj7qa-0000CM-OD
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 14:52:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj7qZ-00063x-Pk
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 14:52:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44190 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fj7qZ-00063j-Jr
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 14:52:15 -0400
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-23-armbru@redhat.com>
	<007a70a2-4ee1-5d41-e53e-35d92f53f518@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9101ef49-d903-cbff-007a-edfd65a984b8@redhat.com>
Date: Fri, 27 Jul 2018 13:52:13 -0500
MIME-Version: 1.0
In-Reply-To: <007a70a2-4ee1-5d41-e53e-35d92f53f518@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 22/23] libqtest: Replace qtest_startf()
 by qtest_initf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: thuth@redhat.com, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: f4bug@amsat.org

On 07/27/2018 12:18 PM, Thomas Huth wrote:
> On 07/27/2018 05:13 PM, Markus Armbruster wrote:
>> qtest_init() creates a new QTestState, and leaves @global_qtest alone.
>> qtest_start() additionally assigns it to @global_qtest, but
>> qtest_startf() additionall sets assigns NULL to @global_qtest.  This
>> makes no sense.  Replace it by qtest_initf() that works like
>> qtest_init(), i.e. leaves @global_qtest alone.
> 
> FWIW, the original idea was to get rid of global_qtest, and then to
> remove qtest_init instead:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg02723.html
> 
> Not sure whether Eric is still working on these patches, though.

As pointed out in the cover letter, there are still some good things to 
salvage from my series, but at this point, it's been closer to a year 
since I last posted anything, so it is just as easy for me to 
rebase/rework from scratch for salvaging the good things, after this 
series lands.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
