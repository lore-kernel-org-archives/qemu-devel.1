Received: from eggs.gnu.org ([2001:4830:134:3::10]:33123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fPid9-0008Mn-B9
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 02:06:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fPid6-0002T8-6H
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 02:06:11 -0400
Received: from 7.mo173.mail-out.ovh.net ([46.105.44.159]:35493)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fPid5-0002RO-Us
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 02:06:08 -0400
Received: from player688.ha.ovh.net (unknown [10.109.120.86])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 823B5BEA76
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 08:05:59 +0200 (CEST)
References: <20180518164405.11804-1-clg@kaod.org>
	<20180518164405.11804-2-clg@kaod.org>
	<20180525160249.7cb0a5bc@bahia.lan>
	<82ee8b24-91d7-9396-82b7-be37200cfacd@redhat.com>
	<683ccfbd-ef6f-4ce1-b53a-8f01919ec5c5@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <25d33ca1-dc06-eb33-b65c-484da71c9ca7@kaod.org>
Date: Mon, 4 Jun 2018 08:05:50 +0200
MIME-Version: 1.0
In-Reply-To: <683ccfbd-ef6f-4ce1-b53a-8f01919ec5c5@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] spapr: remove irq_hint parameter from
 spapr_irq_alloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>

>> The property is a public interface. Just because it's not used by
>> libvirt does not mean that nobody is using it. So yes, please follow the
>> rules and mark it as deprecated first for two release, before you really
>> remove it.
> 
> I don't see a section for 'Deprecated' properties in the qemu-doc files. 

So I added a new one, which gives us :

  B.7 Device options
    B.7.1 Block device options
      B.7.1.1 "backing": "" (since 2.12.0)
    B.7.2 vio-spapr-device device options
      B.7.2.1 "irq": "" (since 2.13.0)


Cheers,

C. 
