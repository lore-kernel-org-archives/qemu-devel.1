Received: from eggs.gnu.org ([2001:4830:134:3::10]:33603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d47sE-0001Oo-AO
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:31:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d47sB-0008Sc-6D
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:31:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d47sA-0008SK-VX
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:31:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E1192C057FA4
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 15:31:53 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170428121553.22408-1-berrange@redhat.com>
	<6f1ae51f-5336-7789-66b0-c4f984b5c0cc@redhat.com>
	<20170428145921.GG11415@redhat.com>
Date: Fri, 28 Apr 2017 17:31:42 +0200
In-Reply-To: <20170428145921.GG11415@redhat.com> (Daniel P. Berrange's message
	of "Fri, 28 Apr 2017 15:59:21 +0100")
Message-ID: <87r30c7dlt.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] sockets: ensure we can bind to both ipv4 &
 ipv6 separately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

"Daniel P. Berrange" <berrange@redhat.com> writes:

> On Fri, Apr 28, 2017 at 09:57:24AM -0500, Eric Blake wrote:
>> On 04/28/2017 07:15 AM, Daniel P. Berrange wrote:
>> > When binding to an IPv6 socket we currently force the
>> > IPV6_V6ONLY flag to off. This means that the IPv6 socket
>> > will accept both IPv4 & IPv6 sockets when QEMU is launched
>> > with something like
>> > 
>> >   -vnc :::1
>> 
>> At first glance, I thought that was too many :.  But I guess it is
>> parsed as host:screen, with host of '::', and port offset of '1'...
>
> Yeah, I was amazed when it actually worked in fact :-) I thought
> I was going to have to use {::}:1, but it seems we reverse search
> for the last ':'.

I would've expected we need ":[::1]".  Too many ad hoc parsers...

[...]
