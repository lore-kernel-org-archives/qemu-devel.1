Received: from eggs.gnu.org ([2001:4830:134:3::10]:52202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fleh7-00055f-0e
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 14:20:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fleh3-0005ah-RZ
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 14:20:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46046 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fleh3-0005aR-MD
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 14:20:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 35CDC401DE61
	for <qemu-devel@nongnu.org>; Fri,  3 Aug 2018 18:20:53 +0000 (UTC)
References: <20180803173614.12358-1-marcandre.lureau@redhat.com>
	<20180803173614.12358-8-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c8490d50-216b-3c50-7e39-b87a218c48db@redhat.com>
Date: Fri, 3 Aug 2018 13:20:51 -0500
MIME-Version: 1.0
In-Reply-To: <20180803173614.12358-8-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/10] char: move SpiceChardev and
 open_spice_port() to spice.h header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 08/03/2018 12:36 PM, Marc-Andr=C3=A9 Lureau wrote:
> This will allow to subclass SpiceChardev easily.

Grammar - 'allow to ${verb}' is not idiomatic; better is 'allow=20
${verb}ing' or 'allow ${subject} to ${verb}'. Here, I'd write:

This will allow easier subclassing of SpiceChardev.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
