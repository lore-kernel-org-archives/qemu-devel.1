Received: from eggs.gnu.org ([2001:4830:134:3::10]:54992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVJXP-0003JQ-8H
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 12:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVJXK-00016P-Jr
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 12:31:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47426 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fVJXK-00015v-ER
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 12:31:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D42748790F
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 16:31:17 +0000 (UTC)
References: <20180619151719.17002-1-berrange@redhat.com>
	<20180619154504.GI2368@work-vm> <20180619155859.GE26829@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <85ae384d-9684-261f-9224-5343d670d69c@redhat.com>
Date: Tue, 19 Jun 2018 11:31:17 -0500
MIME-Version: 1.0
In-Reply-To: <20180619155859.GE26829@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration: fix crash in when incoming
 client channel setup fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

On 06/19/2018 10:58 AM, Daniel P. Berrang=C3=A9 wrote:

>> So, what happens with this fix, does the destination exit cleanly, or
>> stay to accept another connection or what?
>=20
> It stays around and can accept another connection, which is actually
> quite desirable, as it limits impact of a malicious client from DOS'ing
> the genuine client by racing to connect first.

Compare to NBD which had a CVE created for the DOS aspect of a malicious=20
client connecting first; see commit 0c9390d9, CVE-2017-9524.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
